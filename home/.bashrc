#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If thefuck is installed set it up
if hash thefuck 2>/dev/null; then
	eval $(thefuck --alias)
fi

export PATH="$HOME/.bin/:$PATH"

IFS=':' read -a GEM_PATHS <<< "$(gem environment gempath)"

for gem_path_part in "${GEM_PATHS[@]}"; do
	export PATH="${gem_path_part}/bin/:$PATH"
done

export PYTHONPATH="./.pip:$PYTHONPATH"

# export TERM=xterm-256color
# export TERM=linux

alias ls='ls --color=auto'
alias composer='PHP_INI_SCAN_DIR=/dev/null php -c '$HOME'/.composer/php.ini '`which composer`''

source "$HOME/.bash_theme"

[ "$(ls -A $HOME/.bash_completion.d/ | grep '\.bash$')" ] && source $HOME/.bash_completion.d/*.bash

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

homeshick --quiet refresh
