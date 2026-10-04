#!/usr/bin/env bash
# Uninstall anything not listed in the Brewfile.
#
# --zap removes app data and preferences too, so a stale Brewfile entry can
# destroy config that is not recoverable by reinstalling. Always shows the plan
# and waits for an explicit "yes".
set -euo pipefail

BREW=${BREW:-/opt/homebrew/bin/brew}
FILE=${FILE:-Brewfile}

# The dry run loads every cask, so non-Apple taps must be trusted first.
FILE="$FILE" "$(dirname "$0")/brew-trust.sh" >/dev/null

echo "==> Packages not in $FILE (candidates for removal):"
plan=$("$BREW" bundle cleanup --file="$FILE" 2>&1) || true
echo "$plan"

if ! grep -qE 'Would (uninstall|untap|zap)' <<<"$plan"; then
  echo "==> Nothing to prune."
  exit 0
fi

echo
echo "!!! --zap also deletes application data and preferences. This is not reversible."
read -r -p "Type 'yes' to proceed: " reply
[[ $reply == yes ]] || { echo "Aborted."; exit 1; }

"$BREW" bundle cleanup --force --zap --file="$FILE"
