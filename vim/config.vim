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

set visualbell

set hlsearch
set incsearch
set smartcase

" Code Folding {{{
autocmd FileType * setlocal foldmethod=syntax
autocmd FileType * set foldlevelstart=99
autocmd FileType * set foldlevel=99
autocmd FileType vim setlocal foldmethod=marker
" Don't Open Folds While Typeing https://github.com/othree/html5.vim/issues/56 (zanona )
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

autocmd InsertEnter * call <SID>OnInsertModeEnter()
autocmd InsertLeave, WinLeave * call <SID>OnInsertModeLeave()

" HTML {{{
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

" }}}

" UI {{{
set diffopt=filler,vertical
set termguicolors
set noshowmode
set updatetime=250
set colorcolumn=80
let &colorcolumn=join(range(81,999),",")


" set fillchars=
" set fillchars=vert:│,fold:─
set fillchars=vert:│
autocmd Colorscheme * highlight FoldColumn guifg=bg guibg=bg

let g:airline_theme='one'
let g:airline_powerline_fonts = 1
let g:onedark_terminal_italics = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_max_signs=9999

syntax on
set background=light
colorscheme one

" Start NERDTree closed.
autocmd VimEnter * NERDTreeClose
" Close NERDTree when last buffer is closed.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" CtrlP {{{
let g:ctrlp_extensions = ['cmdpalette', 'tag']
let g:ctrlp_cmdpalette_execute = 1
if executable('ag')
    let g:ctrlp_user_command = ['.git', 'ag %s -l --nocolor -g ""']
    " let g:ctrlp_use_caching = 1
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endif
" }}}

" Grep {{{
" https://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

command -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!
" }}}

" Autoformat {{{
let g:formatters_python = ['yapf']
let g:formatters_javascript_jsx = [
            \ 'eslint_local',
            \ 'jsbeautify_javascript',
            \ 'jscs',
            \ 'standard_javascript',
            \ 'xo_javascript'
            \ ]
let g:formatters_jsx = [
            \ 'eslint_local',
            \ 'jsbeautify_javascript',
            \ 'jscs',
            \ 'standard_javascript',
            \ 'xo_javascript'
            \ ]
augroup AutoformatGroup
    autocmd FileType c,cpp,python,java,javascript,javascript.jsx,html,css
        \ autocmd! AutoformatGroup BufWritePre <buffer> :Autoformat
augroup END
" }}}

" Language Server Protocal {{{
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_signs_enabled = 1
let g:lsp_auto_enable = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_async_completion = 1
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_auto_popup = 0

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'requirements.txt'))},
        \ 'whitelist': ['python'],
        \ })
endif


let s:lsp_cquery_command = expand('~/projects/language-servers/cquery/build/release/bin/cquery')
if executable(s:lsp_cquery_command)
    au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, s:lsp_cquery_command . ' --language-server']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '.vscode/cquery_cached_index' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
endif


" let s:lsp_glslls_command = expand('~/projects/language-servers/glsl-language-server/build/glslls')
" if executable(s:lsp_glslls_command)
"     au User lsp_setup call lsp#register_server({
"       \ 'name': 'glslls',
"       \ 'cmd': {server_info->[&shell, &shellcmdflag, s:lsp_glslls_command . ' --stdin']},
"       \ 'whitelist': ['glsl'],
"       \ })
" endif

if executable('javascript-typescript-stdio')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript-typescript-stdio',
        \ 'cmd': {server_info->['javascript-typescript-stdio']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
        \ 'whitelist': ['javascript', 'javascript.jsx', 'typescript'],
        \ })
endif
" }}}

" Gutentags {{{
let g:gutentags_ctags_exclude = ['node_modules', 'thirdparty', '.vscode', 'build']
" }}}

" Javascript {{{
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0
" }}}

" C/C++ Highlighting {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

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
