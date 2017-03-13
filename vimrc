set shell=bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'matze/vim-move'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'siegelaaron94/vim-one'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'

Plugin 'derekwyatt/vim-fswitch'
Plugin 'rhysd/vim-clang-format'
Plugin 'Valloric/YouCompleteMe'

Plugin 'tikhomirov/vim-glsl'

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


autocmd FileType c,cpp,objc ClangFormatAutoEnable
let g:clang_format#code_style="Webkit"
let g:clang_format#style_options = {
            \ "ColumnLimit": 0,
            \ "Standard" : "C++11"}            



let mapleader = "\<Space>"


let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


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


map <F9> :w <CR> :!clear && gcc % <CR> 
map <C-F9> :w <CR> :!clear && gcc % -o %< && ./%< <CR>
