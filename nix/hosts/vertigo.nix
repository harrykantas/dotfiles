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
      "aws-sam-cli"
      "coreutils"
      "go"
      "mas"
      "node"
      "ollama"
      "php"
      "pipx"
      "python"
      "python-argcomplete"
      "zellij"
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
