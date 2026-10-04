#!/usr/bin/env bash
# Trust every Brewfile entry marked `trusted: true`.
#
# Apple's Homebrew fork runs with HOMEBREW_REQUIRE_TAP_TRUST, which refuses to
# load formulae/casks from non-Apple taps until they are trusted. `brew trust`
# writes the entries itself in a canonical form we can't reproduce by hand.
set -euo pipefail

BREW=${BREW:-/opt/homebrew/bin/brew}
FILE=${FILE:-Brewfile}

[[ -x $BREW ]] || { echo "error: $BREW not found" >&2; exit 1; }

while read -r type name; do
  case $type in
    tap)  flag=--tap ;;
    brew) flag=--formula ;;
    cask) flag=--cask ;;
  esac
  if "$BREW" trust "$flag" "$name" >/dev/null 2>&1; then
    echo "  trusted  $name"
  else
    echo "  WARN: could not trust $name" >&2
  fi
done < <(sed -nE 's/^(tap|brew|cask) "([^"]+)".*trusted: *true.*/\1 \2/p' "$FILE")
