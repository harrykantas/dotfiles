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
    ollama
    starship
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "mas"
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
      "zoom"
    ];

    masApps = {
      "Steam Link" = 1246969117;
    };

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
