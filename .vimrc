" Enable mouse support
set mouse=a

" More natural split opening
set splitbelow
set splitright

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Syntax highlighting
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" A Sensible Vim Configuration
Plugin 'tpope/vim-sensible'

" Python necessities
Plugin 'klen/python-mode'

" File Browsing
Plugin 'scrooloose/nerdtree'

" Git status flags for nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Super Searching
Plugin 'ctrlpvim/ctrlp.vim'

" Git Integration
Plugin 'tpope/vim-fugitive'

" Git gutter
Plugin 'airblade/vim-gitgutter'

" Surround brackets
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree

" python-mode settings
let g:pymode_rope = 1
let g:pymode_indent = 1
let g:pymode_virtualenv = 1
let g:pymode_lint = 1
let g:pymode_lint_on_fly = 0
