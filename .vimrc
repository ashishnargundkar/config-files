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
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Syntax checking
Plugin 'scrooloose/syntastic'

" PEP8 checking
Plugin 'nvie/vim-flake8'

Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'Valloric/YouCompleteMe'
Plugin 'christoomey/vim-tmux-navigator'

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

" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

" Start NERDtree with vim
"autocmd vimenter * NERDTree
" Easy shortcut to toggle
map <C-n> :NERDTreeToggle<CR>
" Quit if NERDtree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
syntax on

" Enable powerline by default
set laststatus=2

" Interface with system clipboard by default (such a life saver, man!)
set clipboard=unnamed

" Paste unmodified from the system clipboard (no more annoying wrong indents
" while pasting)
set paste

" Map leader to spacebar
let mapleader = "\<Space>"

" Use the solarized dark theme
colo solarized

"=====[ Highlight matches when jumping to next ]=============
" More Instantly Better Vim - https://www.youtube.com/watch?v=aHm36-na4-4
nnoremap <silent> n n:call HLNext(0.05)<cr>
nnoremap <silent> N N:call HLNext(0.05)<cr>
nnoremap <silent> * *:call HLNext(0.05)<cr>
nnoremap <silent> # #:call HLNext(0.05)<cr>

highlight RedOnBlack ctermbg=black ctermfg=red
"=====[ Highlight the match in red ]=============
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let blinks = 5
    for n in range(1, blinks)
        let red = matchadd('RedOnBlack', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
        call matchdelete(red)
        redraw
        exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
    endfor
endfunction

" Nicer, more compact controls for navigating splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#easier-split-navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Splits open to the right and below (more intuitive)
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#easier-split-navigations
set splitbelow
set splitright

" In vimdiff, highlight changed portion of lines without syntax colouring
" https://vi.stackexchange.com/questions/625/how-do-i-use-vim-as-a-diff-tool
if &diff
    highlight! link DiffText MatchParen
endif
