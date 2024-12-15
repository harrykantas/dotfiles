# Nix Package Management on MacOS

## Fresh install
### Copy dotfiles
```bash
mkdir -p ~/dev && cd "$_"
git clone https://github.com/harrykantas/dotfiles
cd dotfiles
make
```

### Install nix and nix-darwin
```bash
sh <(curl -L https://nixos.org/nix/install)
cd ~/.config/nix
nix run nix-darwin -- switch --flake .#<hostname>
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
