# macOS dotfiles

Plain dotfiles + a Brewfile. No nix.

- **`Brewfile`** — every package this machine needs, as leaves. Single flat list.
- **`home/`** — one stow package; the tree inside mirrors `$HOME`.

```
home/.zshrc                              ->  ~/.zshrc
home/.config/ghostty/config              ->  ~/.config/ghostty/config
home/.config/starship/starship.toml      ->  ~/.config/starship/starship.toml
home/.claude/statusline-command.sh       ->  ~/.claude/statusline-command.sh
```

## Fresh machine

Install Homebrew first, then:

```bash
make install
```

That trusts non-Apple taps, installs missing packages, symlinks dotfiles, and
enables TouchID for sudo. Re-run it any time — every step is idempotent.

## Day to day

```bash
make brew           # install missing packages only — never upgrades or reinstalls
make brew-upgrade   # ...and upgrade outdated ones
make dotfiles       # re-symlink after adding a file to home/
```

`make help` lists the rest.

### Adding a package

Add a line to `Brewfile`, run `make brew`.

### Adding a dotfile

Drop it in `home/` at the path it should have under `$HOME` (e.g.
`home/.config/foo/bar` → `~/.config/foo/bar`), then `make dotfiles`.

### Removing a package

Delete its line from `Brewfile`. `make brew` will not uninstall it — run
`make brew-prune` for that. Prune uses `--zap`, which also deletes application
data and preferences, so it lists its plan and waits for an explicit `yes`.

## Notes

`make dotfiles` uses `stow --no-folding`, which symlinks individual files rather
than whole directories. That matters for `~/.config/ghostty` and `~/.claude`,
which hold unmanaged entries (`ghostty/themes`, `settings.json`) that would be
hidden if stow replaced the directory with a symlink.

Symlinks are relative — stow has no option for absolute ones — so moving this
repo breaks them. Re-run `make dotfiles` afterwards.

TouchID for sudo lives in `/etc/pam.d/sudo_local`. macOS ships only a
`.template` there, and wipes edits to `/etc/pam.d/sudo` on major updates;
`sudo_local` is the sanctioned override and survives.
