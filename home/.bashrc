#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

OPERATING_SYSTEM="$(uname -s | tr '[:upper:]' '[:lower:]')"

if [[ -f "${HOME}/.bashrc.${OPERATING_SYSTEM}" ]]; then
	source "${HOME}/.bashrc.${OPERATING_SYSTEM}"
fi

if [[ -f "${HOME}/.bashrc.${HOSTNAME}" ]]; then
	source "${HOME}/.bashrc.${HOSTNAME}"
fi

# If thefuck is installed set it up
if hash thefuck 2>/dev/null; then
	eval $(thefuck --alias)
fi

if hash rbenv 2>/dev/null; then
	eval "$(rbenv init -)"
fi

if hash pyenv 2>/dev/null; then
	eval "$(pyenv init -)"

	if [[ -z "$VIRTUAL_ENV" ]]; then
		eval "$(pyenv virtualenv-init -)"
	fi
fi

export PATH="$HOME/.bin/:/usr/local/bin:$PATH"

if hash gem 2>/dev/null; then
	IFS=':' read -a GEM_PATHS <<< "$(gem environment gempath)"

	for gem_path_part in "${GEM_PATHS[@]}"; do
		export PATH="${gem_path_part}/bin/:$PATH"
	done
fi

# export TERM=xterm-256color
# export TERM=linux

alias composer='php -c '$HOME'/.composer/php.ini '`which composer`''

files=$(shopt -s nullglob dotglob; echo $HOME/.bash_completion.d/*.bash)
[ ${#files[@]} -gt 0 ] && source $HOME/.bash_completion.d/*.bash

if [[ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]]; then
	export HOMESHICK_DIR="$HOME/.homesick/repos/homeshick"
elif [[ -f "/usr/local/opt/homeshick/homeshick.sh" ]]; then
	export HOMESHICK_DIR="/usr/local/opt/homeshick"
fi

source "$HOMESHICK_DIR/homeshick.sh"

homeshick --quiet refresh

source "$HOME/.bash_theme"
