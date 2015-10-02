" vimrc file with:
"    2 space tabs
"    real tab chars are flagged with annoying ticks
"    trailing whitespace flagged with annoying carots
"    new windows stacked vertically
"    ctrl-J/K/L/H to navigate the window stack
"    <F4> shells out to a find script called 'fs'
"    <ctrl-n> removes the last highlighted search
"    <ctrl-s> show highlight class

" Adopted from:
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2002 May 28
"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

""""""""""""""""""
" TABS vs SPACES
set et
set shiftwidth=2
set softtabstop=2
set tw=78
set list
set autoindent                " always set autoindenting on
set listchars=tab:'`,trail:^  " adds annoying characters to tabs and trailers
map <C-^> :set nolist<CR>     " hides annoying chars
set backspace=indent,eol,start " backspace over everything


""""""""""""""""""
" F4 = SEARCH FILES 
"
" search current word using 'fs' in path (as below)
"
" #!/bin/bash
" if [ -z "$1" ]; then
"     echo usage: $0 [egrep options: -i -C n] string
" exit
" fi
" find -L /dev/null > /dev/null
" if [ "$?" -eq 0 ] ; then
"     l="-L"
" fi
" if [ "$2" !=  "" ]; then
" echo "searching for $2 ... (grep $1)";
" find $l . -name "*.[c|h|l|y|i|py|js]*" -exec egrep $1 -n -H "$2" {} \; 2>/dev/null
" else
" echo "searching for $1 ...";
" find $l . -name "*.[c|h|l|y|i|py|js]*" -exec egrep -n -H "$1" {} \; 2>/dev/null
" fi
map <F4> :!fs <cword><CR>

" gd is quick way to search globally for current word
map gd gD

" CTRL-n gets rid of annoying highlighting after a search
nmap <silent> <C-N> :silent noh<CR>

"set incsearch          " NO incremental searching

"""""""""""""""""""
" WINDOW NAVIGATION 
set wmh=0
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_
nmap <C-L> <C-W>l<C-W><bar>
nmap <C-H> <C-W>h<C-W><bar>
imap <C-w> <C-o><C-w>
set winheight=9999

"""""""""""""""""""
" BACKUP
set backup           " keep a backup file
set backupdir=/vimbup



set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

"""""""""""""""
" HIGHLIGHTING 
"
" CTRL-s to [s]how the highlight class so easy to tweak
map <C-s> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if &t_Co > 2 || has("gui_running")
  syntax on
hi VertSplit ctermfg=7,ctermbg=1
hi StatusLine ctermfg=4,ctermbg=1
hi StatusLineNC ctermfg=3,ctermbg=1
hi Visual ctermfg=4 ctermbg=2
hi Search cterm=bold ctermfg=3 ctermbg=4
hi Comment ctermfg=cyan ctermbg=none cterm=bold
hi link htmlLink Comment
set bg=dark
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")
