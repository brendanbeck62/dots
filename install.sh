
DOTS=~/dots

ln -sf $DOTS/.bashrc ~/.bashrc
ln -sf $DOTS/.vimrc ~/.vimrc
mkdir -p ~/.vim/colors
ln -sf $DOTS/.vim/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim
ln -sf $DOTS/.tmux.conf ~/.tmux.conf

bash $DOTS/gitconfigure.sh
