{ pkgs }:

{
  systemPackages = with pkgs;
  [
    alacritty
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
    tmux
    yt-dlp
    zoxide
  ];

  homebrew = {
    enable = true;

    brews = [
      "mas"
      "podman"
      "podman-compose"
      "stow"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "font-fira-code-nerd-font"
      "fractal-bot"
      "git-credential-manager"
      "godot"
      "ledger-live"
      "nordvpn"
      "podman-desktop"
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
