#!/bin/bash

# install patched font
  # change font in iterm2 settings

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# pull down powerlevel
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# update theme in zshrc to "powerlevel10/powerlevel10"

# configure powerlevel
# y y y, rainbow, unicode, 1(no), 1(angled), 1(sharp), 1(flat), 1 (oneline), 1(compact), 2(many icons), 1(consise), y(transient prompt), 1(verbose), y(update vimrc)

# install zsh syntax highlighting
brew install zsh-syntax-highlighting

# install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install bat
brew install bat

# edit bat theme in lighten the gutter color

# install exa
brew install exa

# clone my dots
git clone https://github.com/brendanbeck62/dots.git

# copy vimrc
cp ~/dots/iTerm2/.vimrc ~/.vimrc

# copy zshrc
cp ~/dots/iTerm2/.zshrc ~/.zshrc

# source zshrc
source ~/.zshrc