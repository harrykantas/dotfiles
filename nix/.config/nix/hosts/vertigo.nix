{ pkgs }:

{
  systemPackages = with pkgs;
  [
    alacritty
    bottom
    eza
    fastfetch
    hwatch
    mkalias
    neovim
    starship
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
      "font-fira-code-nerd-font"
      "vlc"
    ];

    masApps = {
    };

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
