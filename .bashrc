#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# setup
shopt -s autocd

# exports
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth
export EDITOR="nvim"
export VISUAL="nvim"

# fish
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
then
	neofetch
	exec fish
fi

