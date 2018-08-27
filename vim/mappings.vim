let mapleader ="\<Space>"

set tm=500
" Save with CTRL+S
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>

" Keep block selected when indenting
vnoremap < <gv
vnoremap > >gv

" Make tab cycle through completion options
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <S-n> :NERDTreeToggle<CR>
nnoremap <leader>o :TagbarToggle<CR>
" nnoremap <silent>K :LspHover<CR>
" nnoremap <silent><F2> :LspDefinition<CR>

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


" \ will start project search
nnoremap \ :Grep<SPACE>

function! SwitchHeaderSource()
    execute 'edit' system('switch-header '. expand("%"))
endfunc

autocmd FileType c,cpp nnoremap <buffer> <C-k><C-o> :call SwitchHeaderSource()<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sl :FSSplitRight<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sh :FSSplitLeft<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sk :FSSplitAbove<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sj :FSSplitBelow<CR>

tnoremap <C-j> <C-W><C-J>
tnoremap <C-k> <C-W><C-k>
tnoremap <C-h> <C-W><C-h>
tnoremap <C-l> <C-W><C-l>

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc

nnoremap <F8> :call <SID>SynStack()<CR>
