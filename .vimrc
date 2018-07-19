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

"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-latex/vim-latex'

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

set encoding=utf-8

set smartcase

" Enable powerline by default
set laststatus=2
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" Use the solarized dark theme
set background=dark
colorscheme solarized

" Spelling correction enabled. Use spellang= to change dictionary language.
set spell

autocmd BufNewFile,BufRead *.py
   \ set textwidth=79 |
    \ set autoindent

autocmd BufNewFile,BufRead *.cc,*.h
    \ set softtabstop=2 |
    \ set shiftwidth=2

let python_highlight_all=1

syntax on

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Let jdt.ls handle java
let g:syntastic_java_checkers = []

" Make CtrlP search inside directories which have a .root file
" I keep an empty .root file in ~/git inside which all my repos live
" This enables CtrlP to search all my repos
" https://vi.stackexchange.com/questions/2724/how-to-add-multiple-git-projects-to-ctrl-p-search-path
let g:ctrlp_root_markers=['.root']

" Start CtrlP in mixed mode (MRU + Buffers + Files)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
" Makes these visible to vim in general and CtrlP in particular
set wildignore-=.vimrc,.tmux.conf,.zshrc,.emacs

" Paste unmodified from the system clipboard (no more annoying wrong indents
" while pasting)
" Please note that expandtab is disabled when vim is in paste mode
set pastetoggle=<F2>

" Easy shortcut to toggle the NERDTree buffer
map <C-N> :NERDTreeToggle<CR>
" Quit if NERDtree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Map leader to spacebar
let mapleader = "\<Space>"

" Toggle folding with leader spacebar
nnoremap <leader><space> za

" Make the single quote work like a backtick.  Puts the cursor on the column of
" a mark, instead of going to the first non-blank character in the line.
" Thank you, tips.txt!
map ' `

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

" In insert mode, update (i.e. save only if buffer has unsaved changes)
" using <C-S> and get out of insert mode
inoremap <silent> <C-S> <Esc>:update<CR>
" Realised that I might need to update a file in normal mode too!
" (e.g. insert mode -> do some edits -> leave insert mode -> browse the file
" -> realise you need to save your changes)
nnoremap <silent> <C-S> <Esc>:update<CR>

" Easy quitting a buffer. If there are unsaved changes, get a confirmation
" prompt.
noremap <silent> <C-Q> :confirm :quit<Esc>

" Easy reload .vimrc. Immensely useful since I keep tinkering around.
map <silent> <leader>sv :source $MYVIMRC<CR>

" MAKE SURE that the highlight group definition is placed AFTER any
" colo/colorscheme commands, otherwise this setting will be overridden
" Matches trailing whitespaces at the end of a line when not typing at the end
" and ALL tabs (anywhere in the file)
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Had to change the first autocmd from BufWinEnter to FileType as I observed
" that &filetype is not set when we do the check on BufWinEnter
autocmd FileType * call MatchBadWhiteSpace()
autocmd InsertEnter * call MatchBadWhiteSpaceInsertEnter()
autocmd InsertLeave * call MatchBadWhiteSpace()
autocmd BufWinLeave * call clearmatches()

function! MatchBadWhiteSpace()
    " Since vim help files are indented with tabs, highlighting them
    " gives a visually annoying result.  We only apply the highlight
    " to non-help files.
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

" ======================= EXPERIMENTAL SECTION =======================

" Easy quit the insert mode
lmap <M-.> <Esc>
lmap <M-l> <Esc>
imap <M-.> <Esc>
imap <M-l> <Esc>
vmap <M-.> <Esc>
vmap <M-l> <Esc>
cmap <M-.> <Esc>
cmap <M-l> <Esc>

" http://howivim.com/2016/damian-conway/
" <UP> and <DOWN> to step through the file list
nmap <silent> <UP>            :prev<CR>
nmap <silent> <DOWN>          :next<CR>
" <LEFT> and <RIGHT> to step through the quickfix list
nmap <silent> <LEFT>          :cprev<CR>
nmap <silent> <RIGHT>         :cnext<CR>
" double <LEFT> and <RIGHT> to jump through the quickfix file list
nmap <silent> <LEFT><LEFT>    :cpfile<CR><C-G>
nmap <silent> <RIGHT><RIGHT>  :cnfile<CR><C-G>

" Simple (s)
vnoremap <silent> <leader>ss :call SearchAndReplaceFromAB()<CR>
" Specify registers (r)
vnoremap <silent> <leader>sr :call SearchAndReplaceFromRegisters()<CR>

" Convenience function written to perform global search and replace
" within VISUAL selection. Please see the wrappers SearchAndReplaceFromAB and
" SearchAndReplaceFromRegisters which supply the required arguments.
function! SearchAndReplaceCore(search_pattern, replace_pattern)
    execute 'normal! :''<,''>s/' . a:search_pattern
                \. '/' . a:replace_pattern . '/g\<CR>\<Esc>'
endfunction

" Just use the keymapping to trigger this command and the search pattern will
" be taken from register a, the replacement pattern will be taken from
" register b
function! SearchAndReplaceFromAB()
    let search_pattern = getreg('a')
    let replace_pattern = getreg('b')

    call SearchAndReplaceCore(search_pattern, replace_pattern)
endfunction

" After the keymapping, user has to make two keystrokes corresponding to
" two register names:
"    first should contain the search pattern
"    second should contain the replacement pattern
function! SearchAndReplaceFromRegisters()
    let ra = nr2char(getchar())
    let rb = nr2char(getchar())

    let search_pattern = getreg(ra)
    let replace_pattern = getreg(rb)

    call SearchAndReplaceCore(search_pattern, replace_pattern)
endfunction

nnoremap <silent> <leader>a; :call AppendSemicolonToLine()<CR>
function! AppendSemicolonToLine()
    let orig_cursor_pos = getpos('.')
    execute ':normal! A;'
    call setpos('.', orig_cursor_pos)
endfunction

" ======================= Section for commands with historical importance =======================
" Interface with system clipboard by default (such a life saver, man!)
"set clipboard=unnamed

" In vimdiff, highlight changed portion of lines without syntax colouring
" https://vi.stackexchange.com/questions/625/how-do-i-use-vim-as-a-diff-tool
"if &diff
    "highlight! link DiffText MatchParen
"endif
