{ pkgs }:

{
  systemPackages = with pkgs;
  [
    bat
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
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "awscli"
      "coreutils"
      "go"
      "mas"
      "node"
      "ollama"
      "php"
      "python"
      "stow"
      "tmux"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "1password-cli"
      "docker"
      "font-fira-code-nerd-font"
      "ghostty"
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
