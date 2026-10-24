#!/bin/sh
# Claude Code status line. Input schema: https://code.claude.com/docs/en/statusline

# Parse all fields with a single jq call; @sh quotes each value safely for eval.
eval "$(jq -r '
  @sh "cwd=\(.workspace.current_dir // .cwd // "")",
  @sh "model=\(.model.display_name // "")",
  @sh "effort=\(.effort.level // "")",
  @sh "used=\(.context_window.used_percentage // "")",
  @sh "ctx_tok=\(.context_window.total_input_tokens // "")",
  @sh "cost=\(.cost.total_cost_usd // "")",
  @sh "rl5h=\(.rate_limits.five_hour.used_percentage // "")",
  @sh "rl5h_at=\(.rate_limits.five_hour.resets_at // "")",
  @sh "rl7d=\(.rate_limits.seven_day.used_percentage // "")",
  @sh "rl7d_at=\(.rate_limits.seven_day.resets_at // "")"
')"

RST='\033[0m'

# Green / yellow / red by percentage threshold.
pct_color() {
  if [ "$1" -ge 80 ]; then printf '\033[31m'
  elif [ "$1" -ge 50 ]; then printf '\033[33m'
  else printf '\033[32m'
  fi
}

# Compact time until a Unix epoch timestamp (resets_at is epoch seconds per docs).
fmt_until() {
  case "$1" in ''|*[!0-9]*) return ;; esac
  diff=$(($1 - $(date +%s)))
  [ "$diff" -le 0 ] && { printf '0m'; return; }
  d=$((diff / 86400)); h=$(((diff % 86400) / 3600)); m=$(((diff % 3600) / 60))
  if [ "$d" -gt 0 ]; then printf '%dd%dh' "$d" "$h"
  elif [ "$h" -gt 0 ]; then printf '%dh%dm' "$h" "$m"
  else printf '%dm' "$m"
  fi
}

# Compact token count: 1234 -> 1.2k, 1234567 -> 1.2M.
fmt_tok() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) printf "%.1fM", n/1000000
    else if (n >= 1000) printf "%.1fk", n/1000
    else printf "%d", n
  }'
}

# Rate-limit segment: label, percentage, resets_at.
rl_segment() {
  [ -n "$2" ] || return
  pct=$(printf '%.0f' "$2")
  until=$(fmt_until "$3")
  printf ' %b%s:%s%%%s%b' "$(pct_color "$pct")" "$1" "$pct" "${until:+ ($until)}" "$RST"
}

# Shorten home directory to ~ (exact match or path prefix only).
case "$cwd" in
  "$HOME") short_cwd='~' ;;
  "$HOME"/*) short_cwd="~${cwd#"$HOME"}" ;;
  *) short_cwd=$cwd ;;
esac

# Git branch, or short SHA when detached. No optional locks, no fsmonitor.
branch=""
if [ -n "$cwd" ]; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" -c core.fsmonitor=false symbolic-ref --short -q HEAD 2>/dev/null) ||
    branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

out=""
[ -n "$short_cwd" ] && out=$(printf '\033[34m%s%b' "$short_cwd" "$RST")
[ -n "$branch" ] && out=$(printf '%s \033[32m(%s)%b' "$out" "$branch" "$RST")
[ -n "$model" ] && out=$(printf '%s \033[90m%s%b' "$out" "$model" "$RST")
[ -n "$effort" ] && out=$(printf '%s \033[90m[%s]%b' "$out" "$effort" "$RST")

# Context usage: percentage plus tokens currently in the context window.
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  tok=""
  [ -n "$ctx_tok" ] && [ "$ctx_tok" != 0 ] && tok=" ($(fmt_tok "$ctx_tok"))"
  out=$(printf '%s %bctx:%s%%%s%b' "$out" "$(pct_color "$used_int")" "$used_int" "$tok" "$RST")
fi

[ -n "$cost" ] && out=$(printf '%s \033[36m$%.2f%b' "$out" "$cost" "$RST")

out="$out$(rl_segment 5h "$rl5h" "$rl5h_at")$(rl_segment 7d "$rl7d" "$rl7d_at")"

printf '%s' "$out"
