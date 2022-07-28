"Reference: https://danielmiessler.com/study/vim/

"Enable line numbers by default
set number

"Enable jk shortcut for leaving insert mode 
inoremap jk <ESC>

"Leader key <Space>
let mapleader = " "

"Further optimizations
filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus
set backspace=indent,eol,start

"Force me to not use the arrow keys for navigation
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"Force me to also use the hjkl keys in insert mode with Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

