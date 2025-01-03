"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Maintainer:
"       Brendan Beck - @brendanbeck62
"
" Sections:
"    -> General
"    -> Hotkeys
"    -> Colors and Fonts
"    -> Configurations
"    -> Statusline
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
scriptencoding utf-8
set encoding=utf-8

let mapleader = " " " set the leader to <space>
set autoread        " reload files that have not been modified
set history=500     " command history
set hidden          " Allow buffers to be backgrounded without being saved
set number          " use line numbers
set rnu             " relative line numbers
set ruler           " show the line number and column in status bar
set mouse=a         " mouse scrolling
set scrolloff=15    " how many lines to keep on screen when scrolling up
set list            " show hidden characters
set listchars=tab:▸\ ,trail:·
set showmatch       " Show matching brackets when text indicator is over them
set splitright      " splits go to the right by default
set splitbelow      " splits go below by default
set noshowmode      " Don't show '-- INSERT --' in command line

" No annoying sound on errors
set noerrorbells
set novisualbell
set belloff=all

" backup settings
set undofile
set undodir=~/.vim/undodir

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" tabs
set expandtab           " expand tabs to what we want
set tabstop=4           " tab width
set shiftwidth=4        " amount of spaces when shifting
set softtabstop=4       " soft tab width in spaces
set noshiftround        " round indent to multiple of 'shiftwidth'
set autoindent

" Tab completion settings
set wildmenu                    " enables <leader><Tab> to change buffers
set wildcharm=<Tab>             " enables <Tab> to be used in remap cmds
set wildmode=longest:full,full  " Wildcard matches show a list, matching the longest first
set wildignore+=.git,.hg,.svn   " Ignore version control repos
set wildignore+=*.6             " Ignore Go compiled files
set wildignore+=*.pyc           " Ignore Python compiled files
set wildignore+=*.rbc           " Ignore Rubinius compiled files
set wildignore+=*.swp           " Ignore vim backups

" Change directory to the current buffer when opening files.
set autochdir

" makes FZF work idk
set rtp+=/opt/homebrew/opt/fzf

if &diff
    set noreadonly
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkeys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick open
noremap <silent> <C-P> :FZF <CR>

" Move to beginning/end of line without taking my fingers off of home row:
nnoremap H ^
nnoremap L $

" stop searching
nnoremap <C-n> :nohlsearch<cr>
vnoremap <C-n> :nohlsearch<cr>

" move up/down visual lines instead of logical lines
nnoremap j gj
nnoremap k gk

" Insert line above cursor and move cursor to that line at correct indent while staying in insert mode
inoremap <silent><c-o> <esc>O

" Buffer management
nnoremap <Leader><Tab> :buffer <Tab>    " wildmenu for buffer selection
nnoremap <left> :bp<cr>                 " buffer previous
nnoremap <right> :bn<cr>                " buffer next
nnoremap <leader>d :bd<cr>              " buffer delete
nnoremap <leader><leader> <c-^>         " toggle between last 2 buffers

" no arrow keys for you! use left and right for buffer next/prev
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" open splits and focus it
nnoremap <leader>v <C-w>v
nnoremap <leader>h <C-w>s

" source vimrc
nnoremap <Leader>r :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Reselects the selection after indent or dedent
vnoremap < <gv
vnoremap > >gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on syntax highlighting
syntax on

" fixes colors in tmux
set background=dark

" ~/.vim/colors/gruvbox.vim (https://github.com/morhetz/gruvbox)
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Highlight searches in light grey
hi Search ctermbg=LightGrey

" Vim diff colors
highlight DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
highlight DiffChange term=reverse cterm=bold ctermbg=darkcyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=white
highlight DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black


" Syntax highlight file associations
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead *.erb set filetype=eruby
au BufNewFile,BufRead *.pp set filetype=puppet " syntax file located in ~/.vim/syntax/puppet.vim
au BufNewFile,BufRead Jenkinsfile* set filetype=groovy
au BufNewFile,BufRead *.tf,*.hcl,*.tfvars set filetype=hcl | set syntax=hcl
au BufNewFile,BufRead *.tfstate set filetype=json

" Fixes a problem with groovy syntax highlighting?
set re=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to toggle line numbers for copying text
function CopyToggle()
  set rnu!
  set number!
endfunction
command Copy call CopyToggle()

" Function to remove trailing whitespace
function Trimws()
  %s/\s\+$//e
endfunction
command Trim call Trimws()
" trim on file write
au BufWrite * :Trim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Explorer
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_winsize = 25 " percentage of screen

" FZF
let g:fzf_layout = { 'down':'~20%' }


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
hi NormalColor guifg=Black guibg=White ctermbg=White ctermfg=Black
hi InsertColor guifg=Black guibg=Cyan ctermbg=Cyan ctermfg=Black
hi ReplaceColor guifg=Black guibg=Magenta ctermbg=Magenta ctermfg=Black
hi VisualColor guifg=Black guibg=Orange ctermbg=Yellow ctermfg=Black

" Always show the status line
" https://stackoverflow.com/a/5380230
set laststatus=2

" %1* at the beginning sets the color
" %* at the end resets the color
" %= splits the line between left and right
set statusline =%1*            " start custom color
set statusline +=\ %<%F         "full path
set statusline +=%m             "modified flag
set statusline +=\ \            " 2 spaces for padding between mod flag and Ln
set statusline +=%=Ln           " Right half + 'Ln'
set statusline +=\ %l           " 2 adds a space, current line
set statusline +=/%L            "total lines
set statusline +=\ Col          " Col
set statusline +=\ %v\          "virtual column number
set statusline +=%*             " end color
set statusline+=%#NormalColor#%{(mode()=='n')?'\ NORMAL\ ':''}
set statusline+=%#InsertColor#%{(mode()=='i')?'\ INSERT\ ':''}
set statusline+=%#ReplaceColor#%{(mode()=='R')?'\ RPLACE\ ':''}
set statusline+=%#VisualColor#%{(mode()=='v')?'\ VISUAL\ ':''}
" TODO: can't figure out what to match for visual block mode
