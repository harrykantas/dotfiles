#!/usr/bin/env bash
# Trust casks from non-Apple taps.
#
# Apple's Homebrew fork runs with HOMEBREW_REQUIRE_TAP_TRUST, which refuses to
# load formulae/casks from non-Apple taps until they are trusted. `brew trust`
# writes the entries itself in a canonical form we can't reproduce by hand.
set -euo pipefail

BREW=${BREW:-/opt/homebrew/bin/brew}

CASKS=(
    "msitarzewski/brew-browser/brew-browser"
)

[[ -x $BREW ]] || { echo "error: $BREW not found" >&2; exit 1; }

for cask in "${CASKS[@]}"; do
  if "$BREW" trust --cask "$cask" >/dev/null 2>&1; then
    echo "  trusted  $cask"
  else
    echo "  WARN: could not trust $cask" >&2
  fi
done
