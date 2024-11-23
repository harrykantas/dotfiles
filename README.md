# Nix Package Management on MacOS

## Fresh install
```bash
mkdir -p ~/Dev && cd "$_"
git clone https://github.com/harrykantas/dotfiles
cd dotfiles
rsync -av --exclude {'README.md','.git'} . ~/
```

## Update pkg repos
```bash
cd ~/.config/nix
nix flake update
```

## Apply changes
```bash
darwin-rebuild switch --flake .
```
