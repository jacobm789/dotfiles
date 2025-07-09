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
                source "$DOTFILES/debian/.bashrc"
                CONFIG_LOADED=1
                ;;
            arch)
                source "$DOTFILES/arch/.bashrc"
                CONFIG_LOADED=1
                ;;
        esac
        ;;
    Darwin)
        source "$DOTFILES/mac/.bashrc"
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
alias ll='ls -lA'
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
alias tma='tmux a || tmux new -s main'
alias tmm='tmux a -t main || tmux new -s main'

#Spoof git diff for any 2 files
gitlikediff() {
  local file1 file2
  local extra_args=()
  local found_marker=0

  for arg in "$@"; do
    if [[ $found_marker -eq 0 ]]; then
      if [[ $arg == "--" ]]; then
        found_marker=1
      else
        extra_args+=("$arg")
      fi
    else
      # After "--", collect diff flags
      extra_args+=("$arg")
    fi
  done

  # The first two in extra_args are files, the rest are diff flags
  file1="${extra_args[0]}"
  file2="${extra_args[1]}"
  unset extra_args[0] extra_args[1]

  diff -u --color=always "$file1" "$file2" "${extra_args[@]}" | less -FRX
}

_gitlikediff_complete() {
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # Find position of "--"
  local marker_idx=-1
  for i in "${!COMP_WORDS[@]}"; do
    if [[ "${COMP_WORDS[$i]}" == "--" ]]; then
      marker_idx=$i
      break
    fi
  done

  if (( marker_idx != -1 && COMP_CWORD > marker_idx )); then
    # After "--", complete diff flags
    local diff_flags
    diff_flags=$(diff --help | grep -oE -- '--[a-zA-Z0-9-]+' | tr '\n' ' ')
    COMPREPLY=( $(compgen -W "$diff_flags" -- "$cur") )
  else
    # Before "--", complete files/dirs
    compopt -o default
    return 1
  fi
}

complete -F _gitlikediff_complete gitlikediff

# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'

# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous off"

export PATH="$HOME/scripts:$PATH"

if ! tmux ls 2>/dev/null | grep -q "(attached)"; then
    tmux a -t main || tmux new -s main
fi
