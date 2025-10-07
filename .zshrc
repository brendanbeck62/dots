#fastfetch
# speed up oh-my-zsh
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Append directories to path
#TODO

path+=('/Users/brendan/src/scripts')
path+=('/Users/brendan/.git')
path+=('/Library/TeX/texbin')
export PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="false"
EDITOR="vim"

plugins=(
  git
  aws
  terraform
  zsh-autosuggestions
  docker docker-compose
  kubectl
)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# only compute the cache once a day, rather than every new shell
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

source <(limactl completion zsh)
source <(colima completion zsh)
source <(kind completion zsh)

# User configuration
alias ls='eza --icons --group-directories-first --ignore-glob=".DS_Store"'
alias ll='eza -la --icons --group-directories-first --ignore-glob=".DS_Store"'
# Override the coloring for Dockerfiles to include anything containing Dockerfile
export EXA_COLORS="*Dockerfile*=1;4;33:*Jenkinsfile*=1;4;33:*jenkinsfile*=1;4;33"

function cdroot() {
  if $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
    cd $(git rev-parse --show-toplevel)
  else
    return 1
  fi
}
function catall() {
    dir=${1:-./}
    find $dir -type f | xargs tail -n +1
}


#########################
# Aliases
#########################
alias dkclean='docker rm $(docker ps --filter status=exited -q) && docker rmi -f $(docker images -f "dangling=true" -q)'
alias gs='git status'
alias gcm='git commit -m'
alias cat='bat $@'
alias tfs='terraform show'
alias rg='rg --ignore-case'

alias lsjdk='/usr/libexec/java_home -V'
function setjdk() {
  export JAVA_HOME=`/usr/libexec/java_home -v $1`
}

# separate historys in each tab of iterm
unsetopt inc_append_history
unsetopt share_history

# remove duplicates from history
setopt HIST_FIND_NO_DUPS

# jira-cli
export JIRA_AUTH_TYPE=bearer

# fzf
source <(fzf --zsh)
# --strip-cwd-prefix
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'


# for ghostty .config/ghostty/config
export XDG_CONFIG_HOME="$HOME/.config"

#python virtualenvwrapper setup
# if upgrading python version and get "(ModuleNotFoundError: No module named 'virtualenvwrapper')"
# run `pip3 install virtualenvwrapper --break-system-packages`
# python is installed from python.org, not using brew
export WORKON_HOME=~/.py-envs
export VIRTUALENVWRAPPER_PYTHON=`which python3`
export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
source ~/.py-envs/default_env/bin/virtualenvwrapper.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
