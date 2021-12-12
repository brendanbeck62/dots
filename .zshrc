# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/${USER}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="false"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
plugins=(
  git
  aws
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# For a full list of active aliases, run `alias`.

alias ls='exa --icons --group-directories-first'
alias ll='exa -la --icons --group-directories-first'

function cdl() {
  cd $1 && ll
}

alias find='find . -iname'

alias gs='git status'
alias gcm='git commit -m'
alias cat='bat'

# separate historys in each tab of iterm
unsetopt inc_append_history
unsetopt share_history

# remove duplicates from history
setopt HIST_FIND_NO_DUPS

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
