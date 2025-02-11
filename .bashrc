#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias neofetch='fastfetch'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

alias venv='source venv/bin/activate'

export MANPAGER='nvim +Man!'
export MANWIDTH=999

# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'

# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"

# [ -f ~/.ssh/agent_utils.sh ] && source ~/.ssh/agent_utils.sh
