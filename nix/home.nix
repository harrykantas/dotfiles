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
    ".config/ghostty".source = ../ghostty;
    ".config/starship".source = ../starship;
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
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      cat = "bat --paging=never";
      ls = "eza --icons=always";
      vim = "nvim";
    };
    initExtra = ''
      # sourcing
      eval "$(starship init zsh)"
      eval "$(zoxide init --cmd cd zsh)"
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
      export HOMEBREW_NO_ANALYTICS="1"
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH

      # host specific config
      [[ -f "$HOME/.zshrc.local" ]] && source $HOME/.zshrc.local
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
