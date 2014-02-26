" vimrc file with:
"    4 space tabs
"    real tab chars are flagged with annoying ticks
"    trailing whitespace flagged with annoying carots
"    new windows stacked vertically
"    ctrl-J/K/L/H to navigate the window stack
"    <F4> shells out to a find script called 'fs'
"    <C-n> removes the last highlighted search

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

" CUSTOMIZATIONS
set shiftwidth=4
set softtabstop=4
set tw=78
map <F4> :!fs <cword><CR>
set list
set listchars=tab:'`,trail:^
map <C-^> :set nolist<CR>

map gl ]I
map gd gD
nmap <silent> <C-N> :silent noh<CR>

" WINDOW NAVIGATION
set wmh=0
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_
nmap <C-L> <C-W>l<C-W><bar>
nmap <C-H> <C-W>h<C-W><bar>
imap <C-w> <C-o><C-w>
set winheight=9999

" BACUP
set backup           " keep a backup file
set backupdir=~/vimbup


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent          " always set autoindenting on

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
"set incsearch          " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"  set hlsearch
hi VertSplit ctermfg=7,ctermbg=1
hi StatusLine ctermfg=7,ctermbg=1
hi StatusLineNC ctermfg=7,ctermbg=1
hi Visual ctermfg=4 ctermbg=2
hi Search cterm=bold ctermfg=3 ctermbg=4
hi Comment ctermfg=cyan ctermbg=none cterm=bold
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
