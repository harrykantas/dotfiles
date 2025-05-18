nix-rebuild:
	cd nix && sudo darwin-rebuild switch --flake .#"$$(scutil --get LocalHostName)" && cd ..

nix-install:
	sh <(curl -L https://nixos.org/nix/install)

nix-setup:
	cd nix && sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#"$$(scutil --get LocalHostName)" && cd ..
