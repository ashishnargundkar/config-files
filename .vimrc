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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-rhubarb'
Plugin 'prendradjaja/vim-vertigo'
Plugin 'jreybert/vimagit'
Plugin 'rust-lang/rust.vim'

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

let g:SimpylFold_docstring_preview=1

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set fileformat=unix
set backspace=indent,eol,start

" Splits open to the right and below (more intuitive)
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#easier-split-navigations
set splitbelow
set splitright

autocmd BufNewFile,BufRead *.py
   \ set textwidth=79 |
    \ set autoindent

set encoding=utf-8

" Easy shortcut to toggle the NERDTree buffer
map <C-N> :NERDTreeToggle<CR>
" Quit if NERDtree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
syntax on
let g:syntastic_always_populate_loc_list = 1

" Let jdt.ls handle java
let g:syntastic_java_checkers = []

" Enable powerline by default
set laststatus=2

" Paste unmodified from the system clipboard (no more annoying wrong indents
" while pasting)
" Please note that expandtab is disabled when vim is in paste mode
set pastetoggle=<F2>

" Map leader to spacebar
let mapleader = "\<Space>"

" Use the solarized dark theme
set background=dark
colorscheme solarized

" Spelling correction enabled. Use spellang= to change dictionary language.
set spell

" Toggle folding with leader spacebar
nnoremap <leader><space> za

"=====[ Highlight matches when jumping to next ]=============
" More Instantly Better Vim - https://www.youtube.com/watch?v=aHm36-na4-4
nnoremap <silent> n n:call HLNext(0.05)<cr>
nnoremap <silent> N N:call HLNext(0.05)<cr>
nnoremap <silent> * *:call HLNext(0.05)<cr>
nnoremap <silent> # #:call HLNext(0.05)<cr>

" Make sure that the highlight group definition is placed AFTER any
" colo/colorscheme commands, otherwise this setting will be overridden
highlight BlueOnWhite ctermbg=white ctermfg=33
"=====[ Highlight the current match ]=============
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    "let target_pat = '\c\%#\%('.@/.'\)'
    let target_pat = '\c\%#'.@/
    let blinks = 5
    let red = matchadd('BlueOnWhite', target_pat, 101)
endfunction
"=====[ Blink the current match using a highlight ]=============
function! HLNextBlinker (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let blinks = 5
    for n in range(1, blinks)
        let red = matchadd('BlueOnWhite', target_pat, 101)
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

" Move through lines using relative numbering without leaving the
" keyboard home row!
" See: https://github.com/prendradjaja/vim-vertigo#vimrc-mappings
nnoremap <silent> <leader>j :<C-U>VertigoDown n<CR>
vnoremap <silent> <leader>j :<C-U>VertigoDown v<CR>
onoremap <silent> <leader>j :<C-U>VertigoDown o<CR>
nnoremap <silent> <leader>k :<C-U>VertigoUp n<CR>
vnoremap <silent> <leader>k :<C-U>VertigoUp v<CR>
onoremap <silent> <leader>k :<C-U>VertigoUp o<CR>

" In insert mode, save using <C-S> and get out of insert mode
inoremap <C-S> <Esc>:w<CR>
" Realised that I might need to save a file in normal mode too!
" (e.g. insert mode -> do some edits -> leave insert mode -> browse the file
" -> realise you need to save your changes)
nnoremap <C-S> <Esc>:w<CR>

noremap <C-Q> :q<Esc>

map <silent> <leader>sv :source $MYVIMRC<CR>

" ======================= EXPERIMENTAL SECTION =======================

" Make sure that the highlight group definition is placed AFTER any
" colo/colorscheme commands, otherwise this setting will be overridden
" Matches trailing whitespaces at the end of a line when not typing at the end
" and ALL tabs (anywhere in the file)
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
autocmd FileType * call MatchBadWhiteSpace()
autocmd InsertEnter * call MatchBadWhiteSpaceInsertEnter()
autocmd InsertLeave * call MatchBadWhiteSpace()
autocmd BufWinLeave * call clearmatches()

function! MatchBadWhiteSpace()
    if &filetype !=# 'help'
        highlight BadWhitespace ctermbg=white
        match BadWhitespace /\s\+$\|\t/
    endif
endfunction

function! MatchBadWhiteSpaceInsertEnter()
    if &filetype !=# 'help'
        highlight BadWhitespace ctermbg=white
        match BadWhitespace /\s\+\%#\@<!$\|\t/
    endif
endfunction

autocmd VimEnter * echo '>^.^<   greetings, human!'

map <silent> <leader>sv :source $MYVIMRC<CR>

" ======================= Section for commands with historical importance =======================
" Interface with system clipboard by default (such a life saver, man!)
"set clipboard=unnamed

" In vimdiff, highlight changed portion of lines without syntax colouring
" https://vi.stackexchange.com/questions/625/how-do-i-use-vim-as-a-diff-tool
"if &diff
    "highlight! link DiffText MatchParen
"endif
