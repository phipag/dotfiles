# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"
# Set language to english
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Init Homebrew
# Intel based Macs will have brew installed at /usr/local/bin
# ARM (Apple Silicon) based Macs will have brew installed at /opt/homebrew/bin/brew
if [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
else 
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User local bins
export PATH="$PATH:$HOME/.local/bin"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
