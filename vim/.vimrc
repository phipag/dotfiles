"Reference: https://danielmiessler.com/study/vim/

"Remove <ESC> key for leaving insert mode
inoremap jk <ESC>

"Leader key <Space>
let mapleader = " "

"Further optimizations
filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus
set backspace=indent,eol,start
