export DOTFILES=~/dotfiles

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

CONFIG_LOADED=0

case "$(uname -s)" in
    Linux)
        DISTRO=$(detect_distro)
        case "$DISTRO" in
            debian)
                source "$DOTFILES/.bashrc.debian"
                CONFIG_LOADED=1
                ;;
            arch)
                source "$DOTFILES/.bashrc.arch"
                CONFIG_LOADED=1
                ;;
        esac
        ;;
    Darwin)
        source "$DOTFILES/.bashrc.mac"
        CONFIG_LOADED=1
        ;;
esac

if [ "$CONFIG_LOADED" -eq 0 ] && [ -f ~/.bashrc.bak ]; then
    echo "[.bashrc] No matching config found. Falling back to ~/.bashrc.bak"
    source ~/.bashrc.bak
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# ignore case in bash completion, not as good as adding to /etc/inputrc
bind 'set completion-ignore-case on'

alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

if command -v nvim >/dev/null 2>&1; then
    export MANPAGER='nvim +Man!'
    export VISUAL=nvim
    export EDITOR=nvim
fi

export MANWIDTH=160

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# exclude these commands from history
export HISTIGNORE="pwd:exit:clear:htop:btop:ranger:neofetch:fastfetch"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias venv='source venv/bin/activate'

#Spoof git diff for any 2 files
gitlikediff() {
    diff -u --color=always "$1" "$2" | less -FRX
}

# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'

# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"

export PATH="$HOME/scripts:$PATH"
