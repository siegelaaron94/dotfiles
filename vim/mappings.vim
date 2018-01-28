let mapleader ="\<Space>"

" Save with CTRL+S
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>

" Keep block selected when indenting
vnoremap < <gv
vnoremap > >gv

" Make tab cycle through completion options
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

nnoremap <S-n> :NERDTreeToggle<CR>
nnoremap <S-m> :TagbarToggle<CR>
nnoremap <silent> K :LspHover<CR>

" \ will start project search
nnoremap \ :Grep<SPACE>

autocmd FileType c,cpp nnoremap <buffer> <F4> :FSHere<CR>
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
