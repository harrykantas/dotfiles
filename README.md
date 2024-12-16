# MacOS dotfiles

## Fresh install
### Copy dotfiles
```bash
brew install stow
git clone -C ~/dev https://github.com/harrykantas/dotfiles
cd ~/dev/dotfiles
make
```

## Nix Package Management
### Install nix and nix-darwin
```bash
sh <(curl -L https://nixos.org/nix/install)
cd ~/.config/nix
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#<hostname>
```

## Update flake lock file
```bash
cd ~/.config/nix
nix flake update
```

## Apply changes
```bash
cd ~/.config/nix
darwin-rebuild switch --flake .#<hostname>
```
