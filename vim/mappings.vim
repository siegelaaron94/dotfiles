let mapleader ="\<Space>"

" Save with CTRL+S
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>

" Keep block selected when indenting
vnoremap < <gv
vnoremap > >gv

noremap <S-n> :NERDTreeToggle<CR>

autocmd FileType c,cpp nnoremap <buffer> <F4> :FSHere<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sl :FSSplitRight<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sh :FSSplitLeft<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sk :FSSplitAbove<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>sj :FSSplitBelow<CR>
autocmd FileType c,cpp nnoremap <buffer> <F2> :YcmCompleter GoTo<CR>

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc

nnoremap <F8> :call <SID>SynStack()<CR>
