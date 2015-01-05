#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.bin/:$PATH"

export PATH="$(gem environment gempath):$PATH"

# export TERM=xterm-256color
# export TERM=linux

alias ls='ls --color=auto'

source .bash_theme

[ "$(ls -A $HOME/.bash_completion.d/ | grep '\.bash$')" ] && source $HOME/.bash_completion.d/*.bash

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

homeshick --quiet refresh
