# INSTALL

This doc covers installing VaultMeta on **Termux (Android)** and **desktop shells**.

VaultMeta installs a single command:

- `vaultmeta` (subcommands: `tree`, `dirs`, `changes`, `largest`, `attachments`, `termux-packages`, `status`, `help`)

It generates **stable, overwrite-on-run** Markdown reports inside your vault.

---

## Paths used by this project

### Installed command
- `~/.local/bin/vaultmeta`

### Config (XDG)
VaultMeta reads config from:

- `${XDG_CONFIG_HOME:-$HOME/.config}/vaultmeta/vaultmeta.conf`

Override the config location per-run with:

```sh
VAULTMETA_CONFIG=/path/to/vaultmeta.conf vaultmeta status
```

### Termux:Widget shortcut (optional)
- `~/.shortcuts/run-vaultmeta`

### Default reports written (stable notes)
Reports are written to `OUTPUT_DIR` from the config. If `OUTPUT_DIR` is blank, VaultMeta will offer a default:

- `$VAULT_ROOT/30_REFERENCE/vaultmeta/`

Reports (overwritten each run):

- `VaultMeta - File Tree.md`
- `VaultMeta - Directory Blocks.md`
- `VaultMeta - Recent Changes.md`
- `VaultMeta - Largest Files.md`
- `VaultMeta - Attachment Audit.md`
- `termux_packages.md` (written to `TERMUX_OUTPUT_DIR`)

---

## Requirements

- `bash`
- core utilities: `find`, `sed`, `awk`, `sort`
- `git` (for cloning/pulling)
- Optional: Termux:Widget (only if you want a home-screen button)

---

## Install

From the repo root:

```sh
chmod +x install.sh bin/vaultmeta
./install.sh install
hash -r
```

What install does:

- Creates config (if missing):  
  `${XDG_CONFIG_HOME:-$HOME/.config}/vaultmeta/vaultmeta.conf`  
  (copied from `config/vaultmeta.conf.example`)
- Installs the command to: `~/.local/bin/vaultmeta`
- Optionally creates a Termux:Widget shortcut: `~/.shortcuts/run-vaultmeta`

---

## Ensure `~/.local/bin` is on PATH

Check:

```sh
echo "$PATH" | tr ':' '\n' | grep -x "$HOME/.local/bin" || echo "NOT ON PATH"
```

If needed (bash):

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
hash -r
```

---

## Termux:Widget shortcut behavior (integrity-safe)

During install you’ll be asked whether to create a shortcut named `run-vaultmeta`.

Detection rules:

- Termux is detected via `$PREFIX` containing `com.termux`, or `termux-info` being available.
- If you opt in but the shortcuts directory is missing (or you’re not in Termux), install will skip with:

> “Skipping shortcut creation because Termux shortcut directory does not exist.”

If you want the shortcut, ensure:

```sh
mkdir -p ~/.shortcuts
```

---

## Test

Verify install:

```sh
command -v vaultmeta
vaultmeta status
```

Run full report set (Phase 0 + Phase 1):

```sh
vaultmeta
```

Run individually:

```sh
vaultmeta tree
vaultmeta dirs
vaultmeta changes
vaultmeta largest
vaultmeta attachments
vaultmeta termux-packages
```

You should see “Wrote:” lines pointing at `OUTPUT_DIR` (VaultMeta reports) and `TERMUX_OUTPUT_DIR` (Termux packages report).

---

## Edit config

```sh
./install.sh edit-config
```

This opens:

- `${XDG_CONFIG_HOME:-$HOME/.config}/vaultmeta/vaultmeta.conf`

If `$EDITOR` is set, it’s used. Otherwise `nano`, then `vi`, then an inline prompt.

---

## Uninstall (safe)

```sh
./install.sh uninstall
```

Uninstall:

- removes `~/.local/bin/vaultmeta` (if present)
- removes `~/.shortcuts/run-vaultmeta` (if present)
- asks before removing your config file

Uninstall **never deletes your vault**.

---

## Troubleshooting

### `Permission denied` running `./install.sh`
```sh
chmod +x install.sh
```

### `vaultmeta: not found` after install
```sh
hash -r
command -v vaultmeta
```

### `ERROR: Config not found`
Create config via:

```sh
./install.sh install
```

Or run with an explicit override:

```sh
VAULTMETA_CONFIG=/path/to/vaultmeta.conf vaultmeta status
```
