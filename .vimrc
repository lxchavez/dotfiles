set nocompatible              " required
filetype off                  " required

" UTF-8 Support
set encoding=utf-8

" Enable code folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" More natural split opening
set splitbelow
set splitright

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Web Development indentation
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Flag unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Line numbering
set nu

" Syntax highlighting
syntax on

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Python necessities
Plugin 'klen/python-mode'
" Auto Complete
let g:pymode_rope_complete_on_dot = 1 

" File Browsing
Plugin 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd vimenter * NERDTree

" Super Searching
Plugin 'ctrlpvim/ctrlp.vim'

" Git Integration
Plugin 'tpope/vim-fugitive'

" Powerline - cool status bar
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Color Schemes
Plugin 'liuchengxu/space-vim-dark'
colorscheme space-vim-dark

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

