# home.nix
# home-manager switch 

{ config, pkgs, ... }:

{
  home.username = "harry";
  home.homeDirectory = "/Users/harry";
  home.stateVersion = "24.11"; 

  home.packages = [
  ];

  home.file = {
    ".config/starship/starship.toml".source = ~/dev/dotfiles/starship/starship.toml;
    ".config/nix/flake.nix".source = ~/dev/dotfiles/nix/flake.nix;
    ".config/nix/home.nix".source = ~/dev/dotfiles/nix/home.nix;
    ".config/nix/hosts".source = ~/dev/dotfiles/nix/hosts;
    ".config/ghostty/config".source = ~/dev/dotfiles/ghostty/config;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # sourcing
      eval "$(starship init zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      source <(fzf --zsh)
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

      # exports
      export EDITOR="nvim"
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH

      # aliases
      alias ls="eza --icons=always"
      alias vim="nvim"
      alias nix-rebuild="cd ~/dev/dotfiles/nix/.config/nix && darwin-rebuild switch --flake .#$(scutil --get LocalHostName); cd -"
    '';
  };
}
