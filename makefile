all:
	stow --verbose --target=$$HOME --restow --ignore=flake.lock */

delete:
	stow --verbose --target=$$HOME --delete */
