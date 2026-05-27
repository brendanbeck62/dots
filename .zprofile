eval "$(/opt/homebrew/bin/brew shellenv)"

# Avoid duplicate paths
append_to_path() {
    local dir
    for dir in "$@"; do
        if [[ ":$PATH:" != *":${dir}:"* ]]; then
            PATH="$PATH:${dir}"
        fi
    done
}

append_to_path \
    "$HOME/dots/scripts" \
    "/Library/Tex/textbin"
export PATH

export EDITOR="vim"
