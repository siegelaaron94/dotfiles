"Basic Setup {{{
set shell=bash
set hidden
set nobackup
set nowritebackup
set noswapfile

set mouse+=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set nowrap
set clipboard=unnamedplus
set colorcolumn=80
let &colorcolumn=join(range(81,999),",")

set hlsearch
set incsearch
set ignorecase
set smartcase

set diffopt=filler,vertical
set updatetime=250


"Auto reload .vimrc
" autocmd bufwritepost .vimrc source %
" }}}

" Install Plugins {{{
" Vundle Setup {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" }}}

" UI Plugins {{{
Plugin 'endel/vim-github-colorscheme'
Plugin 'siegelaaron94/vim-one'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
" Plugin 'vim-scripts/TagHighlight'
" Plugin 'ryanoasis/vim-devicons'
" Plugin 'thaerkh/vim-indentguides'
Plugin 'wincent/terminus'
" }}}

" Basic Plugins {{{
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-sensible'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
" Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
" Plugin 'terryma/vim-multiple-cursors'
" }}}

" Navigation Plugins {{{
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'matze/vim-move'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
" }}}

" Project Plugins {{{
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'
" }}}

" HTML5 Plugins {{{
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'
" }}}

" Python Plugins {{{
Plugin 'tell-k/vim-autopep8'
Plugin 'tmhedberg/SimpylFold'
" }}}

" C/C++ Plugins {{{
Plugin 'derekwyatt/vim-fswitch'
Plugin 'rhysd/vim-clang-format'
" "Plugin 'Chiel92/vim-autoformat'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'alepez/vim-gtest'
" }}}

" GLSL Plugins {{{
Plugin 'tikhomirov/vim-glsl'
" }}}

" SML {{{
" Plugin 'jez/vim-better-sml'
" }}}

" Jinja2 {{{
Plugin 'Glench/Vim-Jinja2-Syntax'
" }}}

" Antlr {{{
" Plugin 'dylon/vim-antlr'
" }}}

" Vundle Cleanup {{{
call vundle#end()
filetype plugin indent on
" }}}
" }}}

" Theme Setup {{{
set termguicolors
colorscheme one
set background=dark
let g:airline_theme='one'
let g:airline_powerline_fonts = 1
" }}}

" Plugin Setup {{{
" Git Gutter setup {{{
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
" }}}

" CtrlP setup {{{
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


let g:local_vimrc = ['.config', '_vimrc_local.vim', '.vimrc_local.vim']
" }}}

" NERDTree setup {{{
" " Open NERDTree when vim is started with no files
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" " Open NERDTree when vim is started with a directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close NERDTree when last buffer is closed.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd VimEnter * NERDTreeClose
" }}}

" Clang format setup {{{
autocmd FileType c,cpp,objc,javascript,java,proto,glsl ClangFormatAutoEnable
let g:clang_format#command="/home/aaron/.atom/packages/clang-format/node_modules/clang-format/bin/linux_x64/clang-format"
let g:clang_format#code_style="Webkit"
let g:clang_format#style_options = { "ColumnLimit": 0, "Standard":"C++11" }
" }}}

" Google Test setup {{{
" let g:gtest#highlight_failing_tests = 1
" }}} 

" YouCompleteMe setup {{{
let g:ycm_server_log_level = 'debug'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_use_vim_stdout = 0
let g:ycm_global_ycm_extra_conf ="~/.ycm_extra_conf.py"
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
" }}}

" GLSL setup {{{
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.geom,*.frag,*.comp,*.glsl set filetype=glsl
" }}}

" Antlr setup {{{
" au BufRead,BufNewFile *.g set filetype=antlr3
" au BufRead,BufNewFile *.g4 set filetype=antlr4
" }}}

" Python Setup {{{
function! Autopep8Save()
    let b:PlugView=winsaveview()
    call Autopep8()
    call winrestview(b:PlugView)
endfunction
au BufWritePre *.py :call Autopep8Save()
let g:autopep8_disable_show_diff=1
" }}}
" }}}

" Util Functions {{{
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc
" }}}

" Code Folding {{{
" Enable default vim folding {{{
autocmd FileType c,cpp,glsl,vim,perl,java,javascript,python setlocal foldmethod=syntax
autocmd FileType c,cpp,glsl,vim,perl,java,javascript,python set foldlevelstart=99
autocmd FileType c,cpp,glsl,vim,perl,java,javascript,python set foldlevel=99
autocmd FileType vim setlocal foldmethod=marker
" }}}

" Don't Open Folds While Typeing {{{
" https://github.com/othree/html5.vim/issues/56 (zanona )
function! s:OnInsertModeEnter()
  if !exists('w:last_fdm')
    let w:last_fdm = &foldmethod
    setlocal foldmethod=manual
  endif
endfunction

function! s:OnInsertModeLeave()
  if exists('w:last_fdm')
    let &l:foldmethod = w:last_fdm
    unlet w:last_fdm
  endif
endfunction

autocmd InsertEnter             *        call <SID>OnInsertModeEnter()
autocmd InsertLeave,WinLeave    *        call <SID>OnInsertModeLeave()
" }}}

" Better HTML Folding {{{
" https://github.com/othree/html5.vim/issues/56 (nhooyr)
let s:html_exclude_tags_list = [
            \ '\/',
            \ '!',
            \ 'area',
            \ 'base',
            \ 'br',
            \ 'col',
            \ 'embed',
            \ 'hr',
            \ 'img',
            \ 'input',
            \ 'keygen',
            \ 'link',
            \ 'menuitem',
            \ 'meta',
            \ 'param',
            \ 'source',
            \ 'track',
            \ 'wbr',
            \ ]
let s:html_exclude_tags = join(s:html_exclude_tags_list, '\|')

function! HTMLFolds()
    let line = getline(v:lnum)
    
    " Ignore tags that open and close in the same line
    if line =~# '<\(\w\+\).*<\/\1>'
        return '='
    endif

    if line =~# '<\%(' . s:html_exclude_tags . '\)\@!'
        return 'a1'
    endif
    
    if line =~# '<\/\%(' . s:html_exclude_tags . '\)\@!'
        return 's1'
    endif
    
    return '='
endfunction

autocmd FileType html,htmldjango setlocal foldmethod=expr
autocmd FileType html,htmldjango setlocal foldexpr=HTMLFolds()
" }}}

au BufNewFile,BufRead python
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
" }}}

" Shortcuts {{{
" Basic Shortcuts {{{

let mapleader ="\<Space>"

" Use shift to move text selection down/up
" with j/k
let g:move_key_modifier = 'S'


" Keep block selected when indenting
vnoremap < <gv
vnoremap > >gv

nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>
nnoremap <F5> :Make <CR>
noremap <S-n> :NERDTreeToggle<CR>
" noremap <F12> :TagbarToggle <CR>

" Switch between last two buffers
" nnoremap <leader><leader> <C-^>

nnoremap <F8> :call <SID>SynStack()<CR>
" }}}

" C/C++ Shortcuots {{{
autocmd FileType c,cpp nnoremap <buffer> <F4> :FSHere<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sl :FSSplitRight<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sh :FSSplitLeft<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sk :FSSplitAbove<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sj :FSSplitBelow<CR>
autocmd FileType c,cpp nnoremap <buffer> <F2> :YcmCompleter GoTo<CR>
" }}}
" }}}

" C/C++ Highlighting {{{
let cOperatorList  = '[-&|+<>=*/!~]' " A list of symbols that we don't want to immediately precede the operator
let cOperatorList .= '\@<!'          " Negative look-behind (check that the preceding symbols aren't there)
let cOperatorList .= '\%('           " Beginning of a list of possible operators
let cOperatorList .=     '\('        " First option, the following symbols...
let cOperatorList .=        '[-&|+<>=]'
let cOperatorList .=     '\)'
let cOperatorList .=     '\1\?'      " Followed by (optionally) the exact same symbol, so -, --, =, ==, &, && etc
let cOperatorList .= '\|'            " Next option:
let cOperatorList .=     '->'        " Pointer dereference operator
let cOperatorList .= '\|'            " Next option:
let cOperatorList .=     '[-+*/%&^|!]=' " One of the listed symbols followed by an =, e.g. +=, -=, &= etc
let cOperatorList .= '\|'            " Next option:
let cOperatorList .=     '[*?,!~%]'  " Some simple single character operators
let cOperatorList .= '\|'            " Next option:
let cOperatorList .=     '\('        " One of the shift characters:
let cOperatorList .=         '[<>]'
let cOperatorList .=     '\)'
let cOperatorList .=     '\2'        " Followed by another identical character, so << or >>...
let cOperatorList .=     '='         " Followed by =, so <<= or >>=.
let cOperatorList .= '\)'            " End of the long list of options
let cOperatorList .= '[-&|+<>=*/!~]' " The list of symbols that we don't want to follow
let cOperatorList .= '\@!'           " Negative look-ahead (this and the \@<! prevent === etc from matching)

au FileType c,cpp exe"syn match cOperator display '" . cOperatorList ."'"
au FileType c,cpp syn match cOperator display ';'
au FileType c,cpp hi link CTagsClass Structure
au FileType c,cpp hi link CTagsStructure Structure
au FileType c,cpp hi link CTagsNamespace Structure
au FileType c,cpp hi link CTagsType Structure
" }}}
