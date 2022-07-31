"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Brendan Beck - @brendanbeck62
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> Difftool
"    -> Misc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

" Highlight search results
set hlsearch

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set belloff=all
set t_vb=
set tm=500

" Show line numbers
set relativenumber
set number
set rnu

" Function to toggle line numbers for copying text
function CopyToggle()
  set rnu!
  set number!
endfunction
command Copy call CopyToggle()

" Mouse scrolling
set mouse=a
set scrolloff=8
set sidescrolloff=8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting
syntax on

" Highlight searches in light grey
hi Search ctermbg=LightGrey

" Vim diff colors
highlight DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
highlight DiffChange term=reverse cterm=bold ctermbg=darkcyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=white
highlight DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black

" Encoding
set encoding=utf-8

" Syntax highlight file associations
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead *.erb set filetype=eruby
au BufNewFile,BufRead *.pp set filetype=puppet " syntax file located in ~/.vim/syntax/puppet.vim
au BufNewFile,BufRead Jenkinsfile* set filetype=groovy
au BufNewFile,BufRead *.tf,*.hcl,*.tfvars set filetype=hcl
au BufNewFile,BufRead *.tfstate set filetype=json

" Fixes a problem with groovy syntax highlighting?
set re=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 2 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noshiftround " round indent to multiple of 'shiftwidth'

# Terraform tabs are 2 spaces
autocmd Filetype hcl setlocal tabstop=2 shiftwidth=2 softtabstop=2


set autoindent

" Wrap lines
set wrap
" set textwidth=79

" Highlight trailing whitespace
set listchars=tab:▸\ ,trail:·
set list

" Function to remove trailing whitespace
function Trimws()
  %s/\s\+$//e
endfunction
command Trim call Trimws()
command Trimw call Trimws() | w

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Reselects the selection after indent or dedent
:vnoremap < <gv
:vnoremap > >gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

" Always show the status line
" set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move to beginning/end of line without taking my fingers off of home row:
nnoremap H ^
nnoremap L $

" Insert line above cursor and move cursor to that line at correct indent while staying in insert mode (Control + O in insert mode)
inoremap <silent><c-o> <esc>O

" Ctrl + i insert a single character from regular mode, staying in regular mode.
" similar to rX, which replaces the current char with X
nnoremap <C-i> i_<Esc>r
" Similar to above, ctrl+a appends 1 char and remains in regular mode
nnoremap <C-a> a_<Esc>r

" hitting escape clears search highlighting
" nnoremap <silent> <esc> :noh<cr><esc>

" vp highlights last pasted block
nnoremap vp `[v`]

" auto close chars (ctrl+v in insert mode before char to not run this)
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Difftool
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &diff
    set noreadonly
endif
