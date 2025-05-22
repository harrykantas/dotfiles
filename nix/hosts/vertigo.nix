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
    wget
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "awscli"
      "aws-sam-cli"
      "coreutils"
      "go"
      "lazydocker"
      "mas"
      "mise"
      "mysql-client"
      "node"
      "ollama"
      "pgcli"
      "php"
      "pipx"
      "pyenv"
      "python"
      "python-argcomplete"
      "qemu"
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
      "github"
      "google-chrome"
      "maccy"
      "obsidian"
      "slack"
      "session-manager-plugin"
      "tailscale"
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
