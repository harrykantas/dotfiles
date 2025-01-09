all:
	darwin-rebuild switch --flake .#$(scutil --get LocalHostName)

