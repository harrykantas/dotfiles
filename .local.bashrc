# setup
shopt -s autocd

# source
[[ -f /usr/share/bash-complete-alias/complete_alias ]] && source /usr/share/bash-complete-alias/complete_alias

# exports
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth
export EDITOR="vim"
export VISUAL="vim"

# aliases
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias pacupd="yay --editmenu -Syyu"
alias login_gdm="sudo machinectl shell gdm@ /bin/bash"

# functions
function home_vpn() {
  case "$1" in
    up) nmcli connection up wg0 | awk -F\( '{print $1}';;
    down) nmcli connection down wg0 | awk -F\( '{print $1}';;
    *) echo "Usage: home_vpn up|down" ;;
  esac
}

# auto completes
complete -F _complete_alias dotfiles

# main
neofetch
