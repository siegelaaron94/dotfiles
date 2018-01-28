if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

packadd termdebug

call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'haya14busa/is.vim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'

Plug 'rakr/vim-one'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/terminus'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-scripts/TagHighlight'
Plug 'ludovicchabant/vim-gutentags'

Plug 'Chiel92/vim-autoformat'
Plug 'derekwyatt/vim-fswitch'
Plug 'sheerun/vim-polyglot'
Plug 'siegelaaron94/vim-lsp', {'branch': 'support-document-changes'}
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'

call plug#end()
