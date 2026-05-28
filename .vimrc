"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Maintainer:
"       Brendan Beck - @brendanbeck62
"
" Sections:
"    -> General
"    -> Hotkeys
"    -> Colors and Fonts
"    -> Functions
"    -> Configuration
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
set updatetime=1000
set history=10000   " command history
set hidden          " Allow buffers to be backgrounded without being saved
set number          " use line numbers
set rnu             " relative line numbers
set ruler           " show the line number and column in status bar
set mouse=a         " mouse scrolling
set ttymouse=sgr    " removes the legacy 223 character buffer limit
set scrolloff=8     " how many lines to keep on screen when scrolling up
set list            " show hidden characters
set listchars=tab:▸\ ,trail:·
set nowrap          " don't wrap newlines
set showmatch       " Show matching brackets when text indicator is over them
set splitright      " splits go to the right by default
set splitbelow      " splits go below by default
set noshowmode      " Don't show '-- INSERT --' in command line
set timeoutlen=1000 " time in ms to wait to see what next char is (mappings)
set ttimeoutlen=50  " (keycodes)

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
"set autochdir

" add vim to the RunTimePath - guard for non-Apple-Silicon systems
if isdirectory('/opt/homebrew/opt/fzf')
    set rtp+=/opt/homebrew/opt/fzf
elseif isdirectory('/usr/local/opt/fzf')
    set rtp+=/usr/local/opt/fzf
endif

if &diff
    set noreadonly
endif

" Force bracketed paste — Vim doesn't auto-enable it for tmux-256color
if !has('gui_running')
    " sent on Vim startup to tell the terminal please wrap pastes in markers.
    let &t_BE = "\<Esc>[?2004h"

    " sent on Vim exit to turn it off (so your shell goes back to normal behavior).
    let &t_BD = "\<Esc>[?2004l"

    " the start/end markers Vim watches for in incoming input.
    " When it sees t_PS, it knows the next bytes until t_PE are a paste - don't run mappings/indent on them.
    exec "set t_PS=\<Esc>[200~"
    exec "set t_PE=\<Esc>[201~"
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkeys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unmap F1 for help
nnoremap <F1> <Nop>
inoremap <F1> <Nop>
vnoremap <F1> <Nop>

" quick open (current dir)
" if you want to open in another directory, run `:cd <dir>` before <C-P>
noremap <silent> <C-P> :FZF --border --preview cat\ {} <CR>

" Move to beginning/end of line without taking my fingers off of home row:
nnoremap H ^
nnoremap L $

" stop searching
nnoremap <leader>n :nohlsearch<cr>
vnoremap <leader>n :nohlsearch<cr>

" move up/down visual lines instead of logical lines
" use <expr> so counts (e.g. 5j) still jump logical lines - important with rnu
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Insert line above cursor and move cursor to that line at correct indent while staying in insert mode
inoremap <silent><c-o> <esc>O

" Buffer management
" NOTE: inline `" comments` after :map RHS get mapped as keystrokes, so keep comments above
nnoremap <Leader><Tab> :buffer<space><Tab>
" buffer previous
nnoremap <left> :bp<cr>
" buffer next
nnoremap <right> :bn<cr>
" buffer delete
nnoremap <leader>d :bd!<cr>
" toggle between last 2 buffers
nnoremap <leader><leader> <c-^>

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

" leader + </> move the vsp between quarters. Ctrl+w </> still moves one unit at a time
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 3/4)<CR>

" source vimrc
nnoremap <Leader>r :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Reselects the selection after indent or dedent
vnoremap < <gv
vnoremap > >gv

" Command to write as root if we dont' have permission (thanks mitchellh)
" cnoremap (not cmap) so it isn't recursively remapped; correct RHS uses `w !sudo ...`
cnoremap w!! w !sudo tee > /dev/null %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on syntax highlighting
syntax on

" fixes colors in tmux
set background=dark

" make sure we are using cterm not gui
set notermguicolors

" ~/.vim/colors/gruvbox.vim (https://github.com/morhetz/gruvbox)
" expand is requred if using '~'
if filereadable(expand("~/.vim/colors/gruvbox.vim"))
    " set let s:gb.dark0_hard  = ['#111111', 234] to 233 for darker background in ~/.vim/colors/gruvbox.vim
    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox
endif

" Vim diff colors
"highlight DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
"highlight DiffChange term=reverse cterm=bold ctermbg=darkcyan ctermfg=black
"highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=white
"highlight DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black


" Syntax highlight file associations + groovy regex-engine fix (scoped, not global re=0)
augroup vimrc_filetypes
    autocmd!
    autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
    autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
    autocmd BufNewFile,BufRead *.erb set filetype=eruby
    autocmd BufNewFile,BufRead *.pp set filetype=puppet " syntax file located in ~/.vim/syntax/puppet.vim
    autocmd BufNewFile,BufRead Jenkinsfile* set filetype=groovy
    autocmd BufNewFile,BufRead *.tf,*.hcl,*.tfvars set filetype=hcl | set syntax=hcl
    autocmd BufNewFile,BufRead *.tfstate set filetype=json
    " Fixes a problem with groovy syntax highlighting (was global `set re=0`)
    autocmd FileType groovy setlocal regexpengine=0
    autocmd FileType markdown setlocal foldlevel=99
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to remove trailing whitespace (preserves cursor position)
function! Trimws()
  let l:pos = getpos('.')
  keeppatterns %s/\s\+$//e
  call setpos('.', l:pos)
endfunction
command! Trim call Trimws()

" convert jenkins object to pretty print
function! PrettyPrintConfig()
  silent! %s/\s\+/ /g
  silent! %s/\(\w\)\s*:\s*/\1: /g

  silent! %s/,\s*/,\r  /g
  silent! %s/\[\s*/[\r  /g
  silent! %s/\s*\]/\r]/g

  normal! gg=G

  silent! %g/^\s*\w\+:/s/^\(\s*\)\(\w\+\):\s*/\1\2: /g
endfunction
command! PrettyConfig call PrettyPrintConfig()

" Remove every other line when newlines are created when pasting into vim
command! CleanNewlines %s/\n\n\([^\n]\)/\r\1/g

" use jq to format json files
" autocmd FileType json :silent %!jq --indent 4 .
" command Jq :silent %!jq .
function! FormatJsonWithConfirm()
  if confirm('Format this JSON file?', "&Yes\n&No") == 1
    silent %!jq --indent 4 .
  endif
endfunction
command! Jq call FormatJsonWithConfirm()

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

" remove statusline when fzf window is active
augroup vimrc_fzf
    autocmd!
    autocmd FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 ruler
augroup END

" turn off paste when leaving insert mode after pasteing
"autocmd InsertLeave * if &paste | set nopaste | echo "Paste mode disabled" | endif

" General autocmds - grouped so re-sourcing ~/.vimrc doesn't stack duplicates
augroup vimrc_general
    autocmd!
    " use CursorHold too so updatetime actually matters for autoread
    autocmd FocusGained,CursorHold,CursorHoldI * silent! checktime
    " trim trailing whitespace on file write (skip filetypes where trailing ws is meaningful)
    autocmd BufWritePre * if index(['markdown','diff','patch','mail'], &filetype) < 0 | call Trimws() | endif
    " for not in tmux - window title
    autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
augroup END

" set tmux tab + terminal tab to 'vim {full path}' - only when inside tmux
if !empty($TMUX)
    augroup vimrc_tmux
        autocmd!
        autocmd BufEnter * call system("tmux rename-window " . shellescape(expand("%:t")))
        autocmd VimLeave * call system("tmux rename-window zsh")
    augroup END
endif

set title

" Prompt to format JSON on initial read only (not every BufEnter into help/preview)
augroup vimrc_json
    autocmd!
    autocmd BufReadPost *.json if &modifiable && !&readonly | call FormatJsonWithConfirm() | endif
augroup END

" folds
" Markdown heading folding - $VIMRUNTIME/ftplugin/markdown.vim
filetype plugin indent on
let g:markdown_folding = 1


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
hi NormalColor guifg=Black guibg=White ctermbg=White ctermfg=Black
hi InsertColor guifg=Black guibg=Green ctermbg=Green ctermfg=Black
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
set statusline+=%#NormalColor#%{(mode()==#'n')?'\ NORMAL\ ':''}
set statusline+=%#InsertColor#%{(mode()==#'i')?'\ INSERT\ ':''}
set statusline+=%#ReplaceColor#%{(mode()==#'R')?'\ RPLACE\ ':''}
" mode() returns 'v','V', or <C-V> (\x16) for visual variants - matches all three
set statusline+=%#VisualColor#%{(mode()=~#'\v^[vV\x16]$')?'\ VISUAL\ ':''}
