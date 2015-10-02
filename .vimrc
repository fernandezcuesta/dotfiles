" ============== Vundle =============
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'VundleVim/Vundle.vim'
"--- tab completion
Bundle 'ervandew/supertab'
"---
Bundle 'scrooloose/nerdtree'
"--- git plugin for vim
Bundle 'tpope/vim-fugitive'
"--- Finder for Vim
Bundle 'kien/ctrlp.vim'
"--- quoting/parenthesis made easy
Bundle 'tpope/vim-surround'
"--- colourful, dark scheme
Plugin 'evgenyzinoviev/vim-vendetta'
"--- status and tabline
Bundle 'bling/vim-airline'
"--- code completion
Bundle 'Valloric/YouCompleteMe'
"--- python integration
Bundle 'klen/python-mode'

call vundle#end()

filetype plugin indent on
set shell=/bin/bash

" ============ General Options ==============

syntax enable          " Enable syntax highlighting
set mouse=a            " Enable mouse
set mousem=popup_setpos         " 2nd button behaviour:
                                " popup in clicked position
set backspace=indent,eol,start  " more powerful backspacing
set paste              " vim knows about pasting (i.e. from mouse click)
set history=50         " keep 50 lines of command line history
set wrap               " wrap long lines only when surrounded
set whichwrap=b,s,<,>,[,]
set tabstop=4
set number             " Show line numbers.
set showmatch          " When a bracket is inserted, briefly jump to the matching
                       " one. The jump is only done if the match can be seen on the
                       " screen. The time to show the match can be set with
                       " 'matchtime'.
 
set hlsearch           " When there is a previous search pattern, highlight all
                       " its matches.
 
set incsearch          " While typing a search command, show immediately where the
                       " so far typed pattern matches.
 
set scrolloff=5        " minimum scroll of 5 lines (Ctrl-D/Ctrl-U)
set ignorecase         " Ignore case in search patterns.
 
set smartcase          " Override the 'ignorecase' option if the search pattern
                       " contains upper case characters.

" Enable undo file creation (filename.un~) under ~/.vim/undodir
if version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif
set undolevels=1000    "maximum number of changes that can be undone


" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

set wildignore+=*.pyc,*.o,*.class,*.lo,.git
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Insert 4 spaces instead of TAB
set expandtab     " insert spaces when hitting TAB
set softtabstop=4
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " hard tab
set shiftround    " round indent to multiple of 'shiftwidth'
set bs=2          " make backspace behave like normal

" Disable vim modelines
set modelines=0

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nowritebackup
set noswapfile
set nobackup



" ============= INTERFACE =============

" Following line only needed for tmux; skipping while on gvim
if !has("gui_running")
   set term=screen-256color
endif

set ruler              " Show the line and column number of the cursor position,
                       " separated by a comma.
set cursorline         " Highlight cursor's line

set background=dark    " When set to "dark", Vim will try to use colors that look
                       " good on a dark background. When set to "light", Vim will
                       " try to use colors that look good on a light background.
                       " Any other value is illegal.

set t_Co=256           " Enable 256-color mode
colorscheme vendetta   " Obtained with vundle

set colorcolumn=79     " Draw a vertical line on column 79


" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Autoremove trailing spaces when saving the buffer
autocmd FileType c,cpp,eruby,html,java,javascript,php,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%80v.*/
highlight LineLengthError ctermbg=DarkBlue guibg=DarkBlue ctermfg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=blue guibg=blue


" Status
set laststatus=2
set statusline=
set statusline+=%<\ " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\ " buffer number, and flags
set statusline+=%-40f\ " relative path
set statusline+=%= " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\ " file type
set statusline+=%10(L(%l/%L)%)\ " line
set statusline+=%2(C(%v/80)%)\ " column
set statusline+=%P " percentage of file


" ============= KEY BINDINGS =============

" Split view keyboard shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let mapleader=","           " Rebind leader key to comma
imap jj <ESC>               " Quick ESC
command -nargs=0 Quit :qa!  " Quit with :Q


" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" format the entire file
nmap <leader>fef ggVG=

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>
 

" ============= Taken from Arch wiki =============
" (https://wiki.archlinux.org/index.php/Vim/.vimrc)

set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
set commentstring=#%s

" ============= MISC =============

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set encoding=utf-8

" ============= ADDITIONAL OPTIONS =============
set wildmenu        " Show a menu for autocomplete (i.e. :e <TAB>)

" Powerline support
set rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim

" vim-airline options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" CtrlP
nnoremap <silent> t :CtrlP<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 5
let g:ctrlp_max_height = 30
