# MacOS dotfiles

## Fresh install
### Install nix, home-manager and nix-darwin
```bash
sh <(curl -L https://nixos.org/nix/install)
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#<hostname>
```

## Apply new config, updates
```bash
make
```
or
```bash
darwin-rebuild switch --flake .#<hostname>
```
