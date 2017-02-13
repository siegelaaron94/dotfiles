set shell=bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'matze/vim-move'
Plugin 'tikhomirov/vim-glsl'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'Valloric/YouCompleteMe'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'siegelaaron94/vim-one'

call vundle#end()
filetype plugin indent on

set clipboard=unnamedplus

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

let g:move_key_modifier = 'C'

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
nmap <C-S-L> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
