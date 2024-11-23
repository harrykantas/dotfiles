# Nix Package Management on MacOS

## Update pkg repos
```bash
cd ~/.config/nix
nix flake update
```

## Apply changes
```bash
darwin-rebuild switch --flake .
```
