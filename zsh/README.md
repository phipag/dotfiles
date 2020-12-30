# Installation
Follow the [Getting Started](https://github.com/phipag/dotfiles/blob/main/README.md) guide first. Specifically, make sure that all Git submodules are correctly loaded.

Symlink `.zshrc`, `.p10k.zsh` and `.oh-my-zsh` to your home directory.
```sh
ln -s ~/.dotfiles/zsh/.zshrc ~
ln -s ~/.dotfiles/zsh/.p10k.zsh ~
ln -s ~/.dotfiles/zsh/.oh-my-zsh ~
```

Copy the `custom` folder to your `~/.oh-my-zsh` folder.
```sh
cp -r ~/.dotfiles/zsh/custom ~/.oh-my-zsh
```

Optional: Add your own `*.zsh` files or plugins to `~/.oh-my-zsh/custom`. It is fully compatible with the [Oh My ZSH](https://github.com/ohmyzsh/ohmyzsh) framework.
