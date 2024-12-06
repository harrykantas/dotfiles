{ pkgs }:

{
  systemPackages = with pkgs;
  [
    alacritty
    bottom
    eza
    fastfetch
    hugo
    hwatch
    mkalias
    neovim
    ollama
    starship
    tmux
    yt-dlp
    zoxide
  ];

  homebrew = {
    brews = [
      "mas"
      "podman"
      "podman-compose"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "font-fira-code-nerd-font"
      "fractal-bot"
      "godot"
      "ledger-live"
      "nordvpn"
      "raycast"
      "signal"
      "tailscale"
      "vlc"
      "zed"
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
