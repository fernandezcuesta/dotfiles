" Load Pathogen first, so any plugin depending on it can be invoked here
execute pathogen#infect()

" ============ General Options ==============
set nocompatible       " Use Vim defaults instead of 100% vi compatibility
                       " Required by vundle
syntax enable          " Enable syntax highlighting
set mouse=a            " Enable mouse
set mousem=popup_setpos         " 2nd button behaviour:
                                " popup in clicked position
set backspace=indent,eol,start  " more powerful backspacing
set paste              " vim knows about pasting (i.e. from mouse click)
set history=50         " keep 50 lines of command line history
set wrap               " wrap long lines
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
set ruler              " Show the line and column number of the cursor position,
                       " separated by a comma.
set cursorline         " Highlight cursor's line

set background=dark    " When set to "dark", Vim will try to use colors that look
                       " good on a dark background. When set to "light", Vim will
                       " try to use colors that look good on a light background.
                       " Any other value is illegal.

" Following line only needed for tmux; skipping while on gvim
if !has("gui_running")
   set term=screen-256color
endif

set t_Co=256           " Enable 256-color mode
let g:solarized_termcolors=256
colorscheme solarized  " Set default theme

filetype off           " Required by vundle

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


" Vundle specific
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

call vundle#end()            " required by vundle
filetype plugin indent on    " required by vundle


" Split view keyboard shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Insert 4 spaces instead of TAB
set expandtab     " insert spaces when hitting TAB
set softtabstop=4
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " hard tab
set shiftround    "round indent to multiple of 'shiftwidth'

" bring vim-ipython the ability to use Ctrl-S (which is used for flow control)
let g:ipy_perform_mappings=0



" Taken from Arch wiki (https://wiki.archlinux.org/index.php/Vim/.vimrc)
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

set wildmenu        " Show a menu for autocomplete (i.e. :e <TAB>)


" Change cursor color with xfce4-terminal (http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes)
" Update: full path required by vim while invoked from virsh (i.e. `edit vm`)

if !has("gui_running") && has("autocmd")
  au InsertEnter * silent execute "!sed -i.bak -re 's/(ColorCursor=).*$/\\1\\#dc0000/' /home/fernandezjm/.config/xfce4/terminal/terminalrc"
  au InsertLeave * silent execute "!sed -i.bak -re 's/(ColorCursor=).*$/\\1\\#0000dc/' /home/fernandezjm/.config/xfce4/terminal/terminalrc"
  au VimLeave * silent execute "!sed -i.bak -re 's/(ColorCursor=).*$/\\1\\#0000dc/' /home/fernandezjm/.config/xfce4/terminal/terminalrc"
endif
