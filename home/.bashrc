#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If thefuck is installed set it up
if hash thefuck 2>/dev/null; then
	eval $(thefuck --alias)
fi

eval "$(rbenv init -)"

export JAVA_HOME=/usr/lib/jvm/default-runtime

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONIFG_DIRS="/etc/xdg"

export PATH="$HOME/.bin/:$PATH"

IFS=':' read -a GEM_PATHS <<< "$(gem environment gempath)"

for gem_path_part in "${GEM_PATHS[@]}"; do
	export PATH="${gem_path_part}/bin/:$PATH"
done

export PYTHONPATH="./.pip:$PYTHONPATH"

# export TERM=xterm-256color
# export TERM=linux

alias ls='ls --color=auto'
alias composer='php -c '$HOME'/.composer/php.ini '`which composer`''

source "$HOME/.bash_theme"

[ "$(ls -A $HOME/.bash_completion.d/ | grep '\.bash$')" ] && source $HOME/.bash_completion.d/*.bash

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

homeshick --quiet refresh

export PATH="/home/james/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/james/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/james/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/james/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/james/perl5"
