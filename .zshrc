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
path+=('/Users/brendan/dots/scripts')
path+=('/Library/TeX/texbin')
export PATH

export EDITOR="vim"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="false"

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

if command -v limactl >/dev/null 2>&1; then
    source <(limactl completion zsh)
fi
if command -v colima >/dev/null 2>&1; then
    source <(colima completion zsh)
fi
if command -v kind >/dev/null 2>&1; then
    source <(kind completion zsh)
fi

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

# jump to the top of the output. requires my patched mdless
mdless() {
    command mdless "$@"
    if [[ -n "$TMUX" ]]; then
        tmux copy-mode
        tmux send-keys -X previous-prompt -o
    fi
}


# zsh doesnt come with watch installed. Don't pipe, just run
    # watch kubectl exec ...
watch () {
    IN=2
    case $1 in
        -n)
            IN=$2
            shift 2
            ;;
    esac
    printf '\033c' # clear
    CM="$*"
    LEFT="$(printf 'Every %.1f: %s' $IN $CM)"
    ((PAD = COLUMNS - ${#LEFT}))
    while :
    do
        DT=$(date)
        printf "$LEFT%${PAD}s\n" "$HOST $(date)"
        eval "$CM"
        sleep $IN
        printf '\033c'
    done
}

#########################
# Aliases
#########################
alias dkclean='docker rm $(docker ps --filter status=exited -q) && docker rmi -f $(docker images -f "dangling=true" -q)'
alias gs='git status'
alias gcm='git commit -m'
alias tfs='terraform show'
alias rg='rg --ignore-case'

# Always print to the terminal (not a pager) and disable mdless's TTY::Spinner so
# its clear-line escape doesn't wipe Ghostty's OSC 133;C marker on the
# output-start line. Then, inside tmux, jump to the first line of the output.
mdless() {
    command mdless "$@"
    if [[ -n "$TMUX" ]]; then
        tmux copy-mode
        tmux send-keys -X previous-prompt -o
    fi
}

cat() {
  for arg in "$@"; do
    case "$arg" in
      *.md|*.MD|*.markdown)
        mdless "$@"
        ;;
      *)
        command bat -p --theme=gruvbox-dark "$arg"
        ;;
    esac
  done
}


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

# manage python on macos with pyenv (`pyenv install 3.13 && pyenv global 3.13`)
    # lazy loaded
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PATH:$PYENV_ROOT/bin"
# Lazy-load pyenv - only initializes when first used
_init_pyenv() {
  unfunction _init_pyenv pyenv python python3 pip pip3 gimme-aws-creds 2>/dev/null
  eval "$(command pyenv init --path)"
  eval "$(command pyenv init - zsh)"
}
pyenv() { _init_pyenv; command pyenv "$@" }
python() { _init_pyenv; command python "$@" }
python3() { _init_pyenv; command python3 "$@" }
pip() { _init_pyenv; command pip "$@" }
pip3() { _init_pyenv; command pip3 "$@" }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# From ghostty shell integration:
#    This is an autoloadable function. It's invoked automatically in shells directly spawned by Ghostty but not in any other
#    shells. For example, running exec zsh, sudo -E zsh, tmux, or plain zsh will create a shell where ghostty-integration
#    won't automatically run. Zsh users who want integration with Ghostty in all shells should add the following lines to
#    their .zshrc
#
# Basically, tmux is no longer ghostty, because $TERM = tmux-256color. so load it as if it was ghostty
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

