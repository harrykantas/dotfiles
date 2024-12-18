{ pkgs }:

{
  systemPackages = with pkgs;
  [
    awscli
    alacritty
    bottom
    coreutils
    eza
    fastfetch
    fzf
    go
    hwatch
    mkalias
    neovim
    nodejs_23
    onefetch
    php
    python313
    starship
    shellcheck
    tmux
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "mas"
      "ollama"
      "stow"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "1password-cli"
      "docker"
      "font-fira-code-nerd-font"
      "git-credential-manager"
      "google-chrome"
      "raycast"
      "slack"
      "visual-studio-code"
      "vlc"
      "zoom"
    ];

    masApps = {
    };

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
