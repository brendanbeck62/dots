
" have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" H and L start and end of lines
nmap H ^
nmap L $


" Emulate Tab Switching https://vimhelp.org/tabpage.txt.html#gt
" have to delete default obsidian hot keys
exmap tabnext obcommand workspace:next-tab
nmap gt :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap gT :tabprev<CR>

