if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sensible'
" Plug 'LucHermitte/lh-vim-lib'
" Plug 'LucHermitte/local_vimrc'
" Plug 'jiangmiao/auto-pairs'
" Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'
" Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'wincent/terminus'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
" Plug 'vim-scripts/TagHighlight'

Plug 'Chiel92/vim-autoformat'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
" Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'chr4/nginx.vim'
" Plug 'dylon/vim-antlr'
" Plug 'jez/vim-better-sml'
" Plug 'othree/html5.vim'
Plug 'tikhomirov/vim-glsl'

Plug 'derekwyatt/vim-fswitch'
" Plug 'mattn/emmet-vim'
"
call plug#end()
