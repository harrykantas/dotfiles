all:
	cd nix && \
        darwin-rebuild switch --flake .#$(scutil --get LocalHostName) && \
        cd ..

install-nix:
        sh <(curl -L https://nixos.org/nix/install)

init:
        nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#$(scutil --get LocalHostName)