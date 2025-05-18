{ pkgs }:

{
  systemPackages = with pkgs;
  [
    bat
    bottom
    eza
    fastfetch
    fzf
    hugo
    hwatch
    mkalias
    neovim
    starship
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "mas"
      "ollama"
      "zellij"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "docker"
      "font-fira-code-nerd-font"
      "fractal-bot"
      "ghostty"
      "git-credential-manager"
      "ledger-live"
      "signal"
      "tailscale"
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
