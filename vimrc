set shell=bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'siegelaaron94/vim-one'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'derekwyatt/vim-fswitch'

call vundle#end()
filetype plugin indent on

set laststatus=2
let g:airline_powerline_fonts = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

syntax enable
set tabstop=4
set number

set termguicolors
set background=dark
colorscheme one
let g:airline_theme='one'

let mapleader = "\<Space>"

" Save with Ctrl+s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

" Copy with Ctrl+c
vnoremap <C-c> "+y

" Switch Header/Source with <F4>
map <F4> :FSHere<CR>
map <leader>r :FSSplitRight<CR>
map <leader>l :FSSplitLeft<CR>
map <leader>t :FSSplitAbove<CR>
map <leader>b :FSSplitRelow<CR>

set mouse+=a

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

