nix-rebuild:
	cd nix && darwin-rebuild switch --flake .#"$$(scutil --get LocalHostName)" && cd ..

nix-install:
	sh <(curl -L https://nixos.org/nix/install)

nix-setup:
	nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#"$$(scutil --get LocalHostName)"
