" Turn on syntax highlighting
syntax on

" TODO: Pick a leader key
" let mapleader = ","

" Security
set modelines=0

" Show line numbers
set relativenumber
set rnu

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Mouse scrolling
set mouse=a

" Supress Sounds
set belloff=all

"iTerm colors
set termguicolors


" Key mappings:
" Move to beginning/end of line without taking my fingers off of home row:

nnoremap H ^
nnoremap L $

" Insert line above cursor and move cursor to that line at correct indent while staying in insert mode

inoremap <silent><c-o> <esc>O
