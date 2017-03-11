set shell=bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'matze/vim-move'
Plugin 'tikhomirov/vim-glsl'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'Valloric/YouCompleteMe'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'siegelaaron94/vim-one'
Plugin 'scrooloose/nerdtree'
Plugin 'benmills/vimux'
Plugin 'sigidagi/vim-cmake-project'
Plugin 'airblade/vim-gitgutter'
Plugin 'rhysd/vim-clang-format'

call vundle#end()
filetype plugin indent on

set clipboard=unnamedplus


set tabstop=4
set shiftwidth=4 
set softtabstop=4 
set expandtab
set number
set nowrap


syntax enable
set termguicolors
set background=dark
set laststatus=2
colorscheme one
let g:airline_theme='one'
let g:airline_powerline_fonts = 1


set updatetime=250
set diffopt=filler,vertical
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1


let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


autocmd FileType c,cpp,objc ClangFormatAutoEnable
let g:clang_format#code_style="Webkit"
let g:clang_format#style_options = {
            \ "ColumnLimit": 0,
            \ "Standard" : "C++11"}            


" Match <> in cpp.
autocmd FileType cpp set mps+=<:>


let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1


let mapleader = "\<Space>"

" Use control to move text selection down/up
" with j/k
let g:move_key_modifier = 'C'


let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

map <C-n> :NERDTreeToggle<CR>

" Save with Ctrl+s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

" Copy with Ctrl+c
vnoremap <C-c> "+y


map <F2> :YcmCompleter GoTo<CR>

" Switch Header/Source with <F4>
map <F4> :FSHere<CR>
map <leader>r :FSSplitRight<CR>
map <leader>l :FSSplitLeft<CR>
map <leader>t :FSSplitAbove<CR>
map <leader>b :FSSplitRelow<CR>

set mouse+=a

" Show syntax highlighting groups for word under cursor
" nmap <C-S-L> :call <SID>SynStack()<CR>
" function! <SID>SynStack()
" 	if !exists("*synstack")
" 		return
" 	endif
" 	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

map <Leader>g <Plug>CMakeBuild
map <Leader>b <Plug>CMakeCompile
map <Leader>cc <Plug>CMakeClean
map <Leader>o <Plug>CMakeOutput
