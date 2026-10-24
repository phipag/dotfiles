# Claude Code

Custom [status line](https://code.claude.com/docs/en/statusline) for Claude Code. Requires `jq`.

## Installation

Symlink the script to `~/.claude`.

```sh
ln -sf ~/.dotfiles/claude/statusline-command.sh ~/.claude/statusline-command.sh
```

Then add this to `~/.claude/settings.json`:

```json
"statusLine": {
  "type": "command",
  "command": "sh ~/.claude/statusline-command.sh"
}
```
