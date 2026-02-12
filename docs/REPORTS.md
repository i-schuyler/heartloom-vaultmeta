# REPORTS

VaultMeta generates **stable notes** (overwritten each run). Phase 0 + Phase 1 are filesystem-first reports meant to be reliable on a phone.

---

## Output locations

### VaultMeta reports (Phase 0 + Phase 1)

Written to:

- `OUTPUT_DIR` from config

If `OUTPUT_DIR` is blank, VaultMeta offers:

- `$VAULT_ROOT/30_REFERENCE/vaultmeta/`

### Termux report (Phase 1)

Written to a separate (vault) directory:

- `TERMUX_OUTPUT_DIR` from config, or default:
  `/storage/emulated/0/Documents/HeartloomVault/30_REFERENCE/termux-outputs/`

File (overwritten each run):

- `termux_packages.md`

---

## Reports (Phase 0)

### 1) VaultMeta - File Tree.md
A readable bullet-tree of your vault (depth-limited), optionally including files.

### 2) VaultMeta - Directory Blocks.md
A directory list as fenced blocks, now grouped with **top-level headings** (e.g. `## 40_STAGING`) so Obsidian’s outline/TOC can jump between major areas.

---

## Reports (Phase 1)

### 3) VaultMeta - Recent Changes.md
Shows files modified in two windows:
- last `CHANGES_HOURS` hours
- last `CHANGES_DAYS` days

Grouped by top-level directory with timestamps.

### 4) VaultMeta - Largest Files.md
Top `LARGEST_TOP_N` largest files in the vault, with size + relative path.

### 5) VaultMeta - Attachment Audit.md
Audits non-`.md` files:
- totals by extension (count + total size)
- top `ATTACHMENT_TOP_N` largest attachments

### 6) termux_packages.md (Termux packages report)
Writes to `TERMUX_OUTPUT_DIR` inside your vault.

Includes:
- device basics (`uname`, optional `termux-info`, storage sanity)
- package table from `dpkg-query`
- secondary view from `pkg list-installed` (if available)
- repo/config anchors, apt sources, held packages
- optional language ecosystem snapshots (Python/Node/Go/Rust if installed)

---

## Report headers

Each report includes:
- frontmatter properties (`type`, `title`, `generated`, `version`, plus vault/output where relevant)
- a “Settings Summary” section (for VaultMeta reports) showing effective config values

---

## Stability contract

- Notes are **always overwritten** on each run.
- VaultMeta does not create “daily” files or accumulate history in Phase 0/1.
- Later phases may add optional diff/history features, but stable notes remain the core contract.
