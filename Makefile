all:
	cd nix && \
        darwin-rebuild switch --flake .#$(scutil --get LocalHostName) && \
        cd ..
