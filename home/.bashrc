#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.bin/:$PATH"

IFS=':' read -a GEM_PATHS <<< "$(gem environment gempath)"

for gem_path_part in "${GEM_PATHS[@]}"; do
	export PATH="${gem_path_part}/bin/:$PATH"
done

# export TERM=xterm-256color
# export TERM=linux

alias ls='ls --color=auto'

source "$HOME/.bash_theme"

[ "$(ls -A $HOME/.bash_completion.d/ | grep '\.bash$')" ] && source $HOME/.bash_completion.d/*.bash

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

homeshick --quiet refresh
