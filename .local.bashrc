# setup
shopt -s autocd

# exports
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth
export EDITOR="vim"
export VISUAL="vim"

# fish
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
then
	exec fish
fi

