# init starship
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# key bindings
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# source zsh utils
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# exports
export EDITOR="nvim"
export VISUAL="zed"
export DOCKER_HOST='unix:///var/folders/yq/yv8n0krx62scrm9srp7f2k2h0000gn/T/podman/podman-machine-default-api.sock'

# aliases
alias ls="eza --icons=always"
alias vim="nvim"
