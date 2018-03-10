set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set list listchars=tab:»·,trail:·
set ruler
set incsearch
set hlsearch
set number relativenumber

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
" nnoremap <space> za

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set fileformat=unix
set backspace=indent,eol,start

au BufNewFile,BufRead *.py
   \ set textwidth=79 |
    \ set autoindent

Plugin 'vim-scripts/indentpython.vim'

" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Syntax checking
Plugin 'scrooloose/syntastic'

" PEP8 checking
Plugin 'nvie/vim-flake8'

let python_highlight_all=1
syntax on

Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Enable powerline by default
set laststatus=2

" Interface with system clipboard by default (such a life saver, man!)
set clipboard=unnamed
