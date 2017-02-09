set shell=bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rakr/vim-one'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

set laststatus=2
let g:airline_powerline_fonts=1


syntax enable
set tabstop=4
set number

set termguicolors
set background=dark
colorscheme one
let g:airline_theme='one'

" Set ctrl+s as save
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

vnoremap <C-c> "+y

set mouse+=a




