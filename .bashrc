#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

OPERATING_SYSTEM="$(uname -s | tr '[:upper:]' '[:lower:]')"

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config 

export GOPATH="$XDG_DATA_HOME"/go

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle 

export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc 
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc 

export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose 

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


export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
if hash rbenv 2>/dev/null; then
	eval "$(rbenv init -)"
fi

export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
if hash pyenv 2>/dev/null; then
	eval "$(pyenv init --path)"
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

for f in ${HOME}/.bash_completion.d/*.bash; do source $f; done

source "$HOME/.bash_theme"
