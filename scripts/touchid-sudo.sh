#!/usr/bin/env bash
# Enable TouchID for sudo.
#
# macOS ships /etc/pam.d/sudo_local.template but no active sudo_local, and
# wipes edits to /etc/pam.d/sudo on major updates. sudo_local is the sanctioned
# override path and survives updates.
set -euo pipefail

TARGET=/etc/pam.d/sudo_local
LINE='auth       sufficient     pam_tid.so'

if [[ -L $TARGET ]]; then
  echo "  replacing symlinked $TARGET ($(readlink "$TARGET"))"
  sudo rm -f "$TARGET"
elif [[ -f $TARGET ]] && grep -q '^[^#]*pam_tid\.so' "$TARGET"; then
  echo "  TouchID for sudo already enabled"
  exit 0
fi

printf '%s\n' "$LINE" | sudo tee "$TARGET" >/dev/null
sudo chmod 444 "$TARGET"
sudo chown root:wheel "$TARGET"
echo "  wrote $TARGET"
