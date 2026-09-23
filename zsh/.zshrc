# zsh config
autoload -U compinit && compinit
autoload -Uz edit-command-line
zle -N edit-command-line
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# homebrew
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath+=(/opt/homebrew/share/zsh/site-functions)
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# config
source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export EDITOR="vim"

# aliases
alias cat="bat --paging=never"
alias cd="z"
alias gitc-no-op='git commit --allow-empty -m "[no-op]"'
alias ls="eza --icons=always"

