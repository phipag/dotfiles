# Setup
## Prerequisites
Follow the [Getting Started](https://github.com/phipag/dotfiles/blob/main/README.md) guide first. Specifically, make sure that all Git submodules are correctly loaded.

This setup uses the following tools.
* [Homebrew](https://github.com/Homebrew/brew): MacOS package manager
* [pyenv](https://github.com/pyenv/pyenv): Python version manager
* [jenv](https://github.com/jenv/jenv): Java version manager

If you do not want to use them remove the corresponding initialization methods in `.zprofile` and `custom/custom.zsh`.

The following tools will be installed automatically:
* [nvm](https://github.com/nvm-sh/nvm): Node version manager (installed automatically by the [zsh-nvm](https://github.com/lukechilds/zsh-nvm/tree/23067bd9bb6eb6f4737a3ea90cb0cb5e85f61ba2) plugin)

## Installation
Symlink `.zshrc`, `.p10k.zsh` and `.oh-my-zsh` to your home directory.
```sh
ln -s ~/.dotfiles/zsh/.zshrc ~
ln -s ~/.dotfiles/zsh/.zprofile ~
ln -s ~/.dotfiles/zsh/.p10k.zsh ~
ln -s ~/.dotfiles/zsh/.oh-my-zsh ~
```

Copy the `custom` folder to your `~/.oh-my-zsh` folder.
```sh
cp -r ~/.dotfiles/zsh/custom ~/.oh-my-zsh
```

Configure the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme.
```sh
p10k configure
```
If you want to use my existing powerlevel10k config just exit the `p10k configure` command after installing the Meslo Nerd font. If you want to configure your own follow the instructions.

Optional: Add your own `*.zsh` files, plugins or themes to `~/.oh-my-zsh/custom`. It is fully compatible with the [Oh My ZSH](https://github.com/ohmyzsh/ohmyzsh) framework.

# Development
Updating all plugins is equal to pulling all git submodules from remote.
```sh
git submodule update --remote --recursive
```
