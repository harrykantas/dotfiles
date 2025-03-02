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
    nodejs_23
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
      "godot"
      "ledger-live"
      "nordvpn"
      "raycast"
      "signal"
      "tailscale"
      "visual-studio-code"
      "vlc"
    ];

    masApps = {
      "Steam Link" = 1246969117;
    };

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
