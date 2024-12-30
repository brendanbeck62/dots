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
" makesure ~/.vim/undodir exists
set undofile
set undodir=~/.vim/undodir


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
set scrolloff=15
set sidescrolloff=8

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

" Encoding
set encoding=utf-8

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

" Terraform tabs are 2 spaces
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

set splitright
set splitbelow

" Explorer
let g:netrw_liststyle = 3
let g:netrw_banner = 0
" 1:open files in new horizontal split
" 2:open files in new vertical split
" 3:open files in new tab
" 4:open in previous window
let g:netrw_browse_split = 3
let g:netrw_winsize = 25 " percentage of screen

" Toggle Vexplore with Ctrl-E
"function! ToggleVExplorer()
"  if exists("t:expl_buf_num")
"      let expl_win_num = bufwinnr(t:expl_buf_num)
"      if expl_win_num != -1
"          let cur_win_id = win_getid()
"          exec expl_win_num . 'windo close'
"          let prev_win_num = win_id2win(cur_win_id)
"          if prev_win_num != 0
"              exec prev_win_num . 'wincmd w'
"          endif
"      endif
"      unlet t:expl_buf_num
"  else
"      exec '1wincmd w'
"      Vexplore
"      let t:expl_buf_num = bufnr("%")
"  endif
"endfunction
"map <silent> <C-E> :call ToggleVExplorer() <CR>
map <silent> <C-E> :Vex <CR>

" Change directory to the current buffer when opening files.
set autochdir


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

hi NormalColor guifg=Black guibg=Green ctermbg=White ctermfg=Black
hi InsertColor guifg=Black guibg=Cyan ctermbg=Cyan ctermfg=Black
hi ReplaceColor guifg=Black guibg=maroon1 ctermbg=Magenta ctermfg=Black
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

" Don't show '-- INSERT --' in command line
:set noshowmode


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
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

" move selected text line up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Difftool
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &diff
    set noreadonly
endif

" for fzf
set rtp+=/opt/homebrew/opt/fzf

