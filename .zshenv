export PATH="$PATH:/Users/yoriy/.config/nvim/plugged/vim-terraform-completion/bin"

export TFENV_ROOT="$HOME/.tfenv"
export PATH="$TFENV_ROOT/bin:$PATH"

export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

alias vim=nvim
export EDITOR=vim

function nvm_prompt_info() {
    echo "$(nvm current)"
}

function rbenv_prompt_info_works() {
    echo "$(rbenv version-name)"
}

function tfenv_prompt_info() {
    echo "$(cat $TFENV_ROOT/version)"
}

function hstn_prompt_info() {
    if [[ -z HOUSTON_DEFAULT_PROFILE ]]; then
        echo "$HOUSTON_DEFAULT_PROFILE"
    else
        echo "$(houston current -q)"
    fi
}

# Use fd with fzf to change directory
function fdc() {
    local dir
    dir="$(fd -t d | fzf)" && cd "$dir"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
function fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Setting fd as the default source for fzf, revealing hidden files and following symlinks
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
