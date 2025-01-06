{ pkgs }:

{
  systemPackages = with pkgs;
  [
    alacritty
    bottom
    eza
    fastfetch
    fzf
    hwatch
    mkalias
    neovim
    onefetch
    ripgrep
    starship
    shellcheck
    tmux
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "awscli"
      "coreutils"
      "ghostty"
      "go"
      "mas"
      "node"
      "ollama"
      "php"
      "python"
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
