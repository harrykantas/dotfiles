# Nix Package Management on MacOS

## Fresh install
### Copy dotfiles
```bash
mkdir -p ~/Dev && cd "$_"
git clone https://github.com/harrykantas/dotfiles
cd dotfiles
rsync -av --exclude {'README.md','.git'} . ../
```

### Install nix and nix-darwin
```bash
sh <(curl -L https://nixos.org/nix/install)
cd ~/.config/nix
nix run nix-darwin -- switch --flake .
```

## Update flake lock file
```bash
cd ~/.config/nix
nix flake update
```

## Apply changes
```bash
cd ~/.config/nix
darwin-rebuild switch --flake .
```
