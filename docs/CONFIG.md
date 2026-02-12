# CONFIG

VaultMeta uses a simple `.conf` file (shell-style `KEY=value`) to control report behavior.

---

## Config file location (XDG)

VaultMeta reads config from:

- `${XDG_CONFIG_HOME:-$HOME/.config}/vaultmeta/vaultmeta.conf`

Create it via:

```sh
./install.sh install
```

Edit it via:

```sh
./install.sh edit-config
```

Override per-run:

```sh
VAULTMETA_CONFIG=/path/to/vaultmeta.conf vaultmeta status
```

---

## Keys

### Required

- `VAULT_ROOT=...`  
  Path to the root of your Obsidian vault.  
  If missing or not found, VaultMeta will prompt you.

### Optional (safe defaults / prompting)

- `OUTPUT_DIR=...`  
  Where VaultMeta report notes are written.  
  If blank, VaultMeta will offer: `$VAULT_ROOT/30_REFERENCE/vaultmeta/`

- `INCLUDE_HIDDEN=0|1`  
  Include dot-directories like `.obsidian/`.

- `EXCLUDE_DIRS=dirA,dirB,...`  
  Comma-separated directory names to prune (examples: `.git,node_modules`).

- `EXCLUDE_GLOBS=globA,globB,...`  
  Comma-separated filename globs to ignore (examples: `*.log,*.tmp`).

- `TREE_MAX_DEPTH=N`  
  Max traversal depth for the **File Tree** report.

- `FOLLOW_SYMLINKS=0|1`  
  Follow symlinks (uses `find -L`). Keep `0` unless you know you want this.

- `INCLUDE_FILES=0|1`  
  Include files in the File Tree report.  
  If `0`, the tree report will list directories only.

---

## Phase 1 report settings

- `CHANGES_HOURS=N`  
  Recent Changes “window A” (default `24`).

- `CHANGES_DAYS=N`  
  Recent Changes “window B” (default `7`).

- `LARGEST_TOP_N=N`  
  Top N for Largest Files (default `50`).

- `ATTACHMENT_TOP_N=N`  
  Top N for Attachment Audit (default `50`).

---

## Termux report output location

- `TERMUX_OUTPUT_DIR=...`  
  Output directory inside your vault for `termux_packages.md`.  
  Default:
  `/storage/emulated/0/Documents/HeartloomVault/30_REFERENCE/termux-outputs/`

Path resilience applies here too: if the directory is missing, VaultMeta will echo what’s missing, prompt for a new path, and continue.

---

## Path resilience (non-negotiable)

If expected paths can’t be found, VaultMeta will:

1) print what’s missing  
2) prompt you for the updated path  
3) continue using your answer

This prevents silent breakage when your vault evolves.

---

## Example config

See:

- `config/vaultmeta.conf.example`
