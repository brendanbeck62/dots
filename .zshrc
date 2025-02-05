fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Append directories to path
path+=('/Users/brendan/src/scripts')
path+=('/Users/brendan/.git')
export PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/brendan/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="false"

plugins=(
  git
  aws
  vagrant
  zsh-autosuggestions
  terraform
)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration
alias ls='exa --icons --group-directories-first'
alias ll='exa -la --icons --group-directories-first'
alias lt='exa -la --icons --group-directories-first --tree --level=2 --ignore-glob=".git"'

# cd to the root of a git project
function cdroot() {
  if $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
    cd $(git rev-parse --show-toplevel)
  else
    return 1
  fi
}


#########################
# Aliases
#########################
alias dkclean='docker rm $(docker ps --filter status=exited -q) && docker rmi -f $(docker images -f "dangling=true" -q)'
alias gs='git status'
alias gcm='git commit -m'
alias lsjdk='/usr/libexec/java_home -V'
function setjdk() {
  export JAVA_HOME=`/usr/libexec/java_home -v $1`
}
alias tfs='terraform show'

# separate historys in each tab of iterm
unsetopt inc_append_history
unsetopt share_history

# remove duplicates from history
setopt HIST_FIND_NO_DUPS

# python virtualenvwrapper setup
export WORKON_HOME=~/.py-envs
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/Current/bin/python3
source /Library/Frameworks/Python.framework/Versions/3.12/bin/virtualenvwrapper.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

