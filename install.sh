
DOTS=~/dots

ln -sf $DOTS/.bashrc ~/.bashrc
ln -sf $DOTS/.vimrc ~/.vimrc
ln -sf $DOTS/.tmux.conf ~/.tmux.conf

bash $DOTS/gitconfigure.sh
