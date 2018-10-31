" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Sensible vim settings
Plug 'tpope/vim-sensible'

" Nice file and directory browsing
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Git Integration
Plug 'tpope/vim-fugitive'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Surround brackets
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()

" Enable mouse support
set mouse=a

" Line numbering
set nu

" Tab settings
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" vim-gitgutter config
set updatetime=100

" NERDtree config
" Map NERDtree to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
