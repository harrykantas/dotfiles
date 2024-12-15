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
      "stow"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "1password-cli"
      "font-fira-code-nerd-font"
      "git-credential-manager"
      "raycast"
      "visual-studio-code"
      "vlc"
    ];

    masApps = {
    };

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
