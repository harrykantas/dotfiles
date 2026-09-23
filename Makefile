SHELL := /bin/bash
BREW  := /opt/homebrew/bin/brew

# One stow package per directory; layout inside mirrors $HOME.
PKGS := zsh starship ghostty claude

export BREW
export HOMEBREW_NO_AUTO_UPDATE := 1
export HOMEBREW_NO_ANALYTICS   := 1
export HOMEBREW_NO_ENV_HINTS   := 1

.DEFAULT_GOAL := help
.PHONY: help install brew brew-upgrade brew-prune brew-trust brew-dump \
        dotfiles dotfiles-dry unstow touchid doctor

help:
	@echo "Setup"
	@echo "  make install        brew-trust + brew + dotfiles + touchid"
	@echo
	@echo "Packages"
	@echo "  make brew           install missing packages only (no upgrades, no reinstalls)"
	@echo "  make brew-upgrade   install missing + upgrade outdated"
	@echo "  make brew-prune     uninstall anything not in the Brewfile (asks first)"
	@echo "  make brew-trust     trust casks from non-Apple taps"
	@echo "  make brew-dump      regenerate Brewfile from what is installed now"
	@echo
	@echo "Dotfiles"
	@echo "  make dotfiles       symlink $(PKGS) into ~"
	@echo "  make dotfiles-dry   show what dotfiles would do"
	@echo "  make unstow         remove the symlinks"

install: brew-trust brew dotfiles touchid
	@echo "==> Done."

# --- packages ---------------------------------------------------------------

# --no-upgrade: leave already-installed packages exactly as they are.
brew:
	@echo "==> Installing missing packages"
	@$(BREW) bundle install --no-upgrade --file=Brewfile

brew-upgrade:
	@echo "==> Installing missing packages and upgrading outdated"
	@$(BREW) bundle install --upgrade --file=Brewfile

brew-prune:
	@./scripts/brew-prune.sh

brew-trust:
	@echo "==> Trusting non-Apple taps"
	@./scripts/brew-trust.sh

brew-dump:
	@$(BREW) bundle dump --force --describe --file=Brewfile.dump
	@echo "==> Wrote Brewfile.dump — diff it against Brewfile before replacing."

# --- dotfiles ---------------------------------------------------------------

# --no-folding symlinks leaf files instead of whole directories, so ~/.config
# and ~/.claude keep their unmanaged contents (e.g. ghostty/themes).
dotfiles:
	@command -v stow >/dev/null || { echo "error: stow missing — run 'make brew' first" >&2; exit 1; }
	@echo "==> Stowing $(PKGS) into $$HOME"
	@stow --no-folding --target="$$HOME" --restow $(PKGS) --adopt

dotfiles-dry:
	@command -v stow >/dev/null || { echo "error: stow missing — run 'make brew' first" >&2; exit 1; }
	@stow --no-folding --target="$$HOME" --restow --simulate --verbose=2 $(PKGS) --adopt

unstow:
	@stow --no-folding --target="$$HOME" --delete $(PKGS)

# --- system -----------------------------------------------------------------

touchid:
	@echo "==> TouchID for sudo"
	@./scripts/touchid-sudo.sh

# --- checks -----------------------------------------------------------------

doctor:
	@./scripts/doctor.sh
