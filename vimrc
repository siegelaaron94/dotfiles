set shell=bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'matze/vim-move'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'

Plugin 'tomtom/tcomment_vim'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'siegelaaron94/vim-one'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'

Plugin 'derekwyatt/vim-fswitch'
Plugin 'rhysd/vim-clang-format'
Plugin 'Valloric/YouCompleteMe'
Plugin 'alepez/vim-gtest'
Plugin 'jeaye/color_coded'

Plugin 'tikhomirov/vim-glsl'


Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'


call vundle#end()
filetype plugin indent on


set clipboard=unnamedplus


set tabstop=4
set shiftwidth=4 
set softtabstop=4 
set expandtab
set number
set nowrap

set hlsearch
set termguicolors
set background=dark
colorscheme one
let g:airline_theme='one'
let g:airline_powerline_fonts = 1


set updatetime=250
set diffopt=filler,vertical
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1


let g:NERDDefaultAlign="start"
 

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


let g:nerdtree_tabs_open_on_console_startup = 2

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let g:local_vimrc = ['.config', '_vimrc_local.vim', '.vimrc_local.vim']

 
autocmd FileType c,cpp,objc,python ClangFormatAutoEnable
let g:clang_format#command="/home/aaron/.atom/packages/clang-format/node_modules/clang-format/bin/linux_x64/clang-format"
let g:clang_format#code_style="Webkit"
let g:clang_format#style_options = {
            \ "ColumnLimit": 0,
            \ "Standard" : "C++11"}            
let g:gtest#highlight_failing_tests = 1
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"

let mapleader = "\<Space>"


" Use control to move text selection down/up
" with j/k
let g:move_key_modifier = 'S'


noremap <C-n> :NERDTreeToggle<CR>

" Save with Ctrl+s
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>

"C/C++ Switch Header/Source
autocmd FileType c,cpp nnoremap <buffer> <F4> :FSHere<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sl :FSSplitRight<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sh :FSSplitLeft<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sk :FSSplitAbove<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sj :FSSplitBelow<CR>

" C/C++ goto defintion
autocmd FileType c,cpp nnoremap <buffer> <F2> :YcmCompleter GoTo<CR>


set mouse+=a

" " Show syntax highlighting groups for word under cursor
" " nmap <C-S-L> :call <SID>SynStack()<CR>
" " function! <SID>SynStack()
" " 	if !exists("*synstack")
" " 		return
" " 	endif
" " 	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" " endfunc

" let g:xml_syntax_folding=1
" au FileType xml setlocal foldmethod=syntax
 

nnoremap <leader>b :Make <CR> 


autocmd FileType c,cpp nnoremap <buffer> <F9> :w <CR> :!clear && gcc % <CR> 
autocmd FileType c,cpp nnoremap <buffer> <C-F9> :w <CR> :!clear && gcc % -o %< && ./%< <CR>
