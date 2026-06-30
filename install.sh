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
        ln -sf $DOTS/.p10k.zsh ~/.p10k.zsh
        ln -sf $DOTS/.zprofile ~/.zprofile
        touch ~/.hushlogin
    fi
elif [[ "$CONTEXT" == "work" ]]; then
    # bash/zsh
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ln -sf $DOTS/.bashrc ~/.bashrc
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        ln -sf $DOTS/.zshrc ~/.zshrc
        ln -sf $DOTS/.p10k.zsh ~/.p10k.zsh
        ln -sf $DOTS/.zprofile ~/.zprofile
    fi
fi
#########
# VIM
#########
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/syntax
# for persistant editing history
mkdir -p ~/.vim/undodir
ln -sf $DOTS/.vim/colors ~/.vim/colors
ln -sf $DOTS/.vim/syntax ~/.vim/syntax
ln -sf $DOTS/.vimrc ~/.vimrc

#########
# TMUX
#########
ln -sf $DOTS/.tmux.conf ~/.tmux.conf
mkdir -p $HOME/.tmux/plugins
if [ ! -d "$HOME/.tmux/plugins/tmux-kube-context/.git" ]; then
    git clone git@github.com:brendanbeck62/tmux-kube-context.git ~/.tmux/plugins/tmux-kube-context
else
    git -C ~/.tmux/plugins/tmux-kube-context pull -q
fi

#########
# GHOSTTY
#########
mkdir -p ~/.config/ghostty
ln -sf $DOTS/.config/ghostty/config ~/.config/ghostty/
if [ -d "$HOME/src/obsidian-brain" ]; then
    ln -sf $DOTS/.obsidian.vimrc ~/src/obsidian-brain/.obsidian.vimrc
fi

#########
# GIT
#########
ln -sf $DOTS/.config/gh ~/.config/gh

if command -v git >/dev/null 2>&1
then
    git config --global user.email "brendan.beck62@gmail.com"
    git config --global user.name "Brendan Beck"
    git config --global pager.branch false
    git config --global branch.sort -committerdate
    git config --global column.ui auto
    git config --global column.status never
    git config --global diff.tool vimdiff
fi
