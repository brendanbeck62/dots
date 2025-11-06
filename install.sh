
DOTS=$(pwd)
read -p "Where are the dots located? [$DOTS]: " INDOTS
DOTS=${INDOTS:-$DOTS}

read -p "Which context are you running this in [home/work]: " CONTEXT
if [[ $CONTEXT != "home" && $CONTEXT != "work" ]]; then
    echo "ERROR: context must be one of [home/work]"
    exit 1
fi

if [[ "$CONTEXT" == "home" ]]; then
    # bash/zsh
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ln -sf $DOTS/.bashrc ~/.bashrc
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        ln -sf $DOTS/.zshrc ~/.zshrc
        ln -sf $DOTS/.zprofile ~/.zprofile
        touch ~/.hushlogin
    fi

elif [[ "$CONTEXT" == "work" ]]; then
    # bash/zsh
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ln -sf $DOTS/.bashrc ~/.bashrc
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        ln -sf $DOTS/.zshrc ~/.zshrc
        ln -sf $DOTS/.zprofile ~/.zprofile
    fi

fi


mkdir -p ~/.vim/colors
# for persistant editing history
mkdir -p ~/.vim/undodir
ln -sf $DOTS/.vim/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim
ln -sf $DOTS/.vimrc ~/.vimrc

ln -sf $DOTS/.tmux.conf ~/.tmux.conf

mkdir -p ~/.config/ghostty
ln -sf $DOTS/.config/ghostty/config ~/.config/ghostty/

# configure git
if command -v git >/dev/null 2>&1
then
    git config --global pager.branch false
    git config --global branch.sort -committerdate
    git config --global column.ui auto
    git config --global column.status never
    git config --global diff.tool vimdiff
fi

