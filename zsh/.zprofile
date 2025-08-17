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

# Init pyenv
eval  "$(pyenv init --path)"

# User local bins
export PATH="$PATH:$HOME/.local/bin"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set up mise for runtime management
eval "$(mise activate zsh)"

# SDKMan! for Java version management
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

