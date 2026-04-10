# heartloom-vaultmeta

VaultMeta is a small, public-friendly toolkit that makes an Obsidian vault **legible to itself** by generating **stable, overwrite-on-run** Markdown “vault visibility” notes.

`heartloom-vaultmeta` is a focused downstream Heartloom toolkit: it follows [`heartloom-identity`](https://github.com/i-schuyler/heartloom-identity) for governance/inheritance posture and points to [`heartloom-source`](https://github.com/i-schuyler/heartloom-source) for upstream meaning, law, identity, and deeper architecture. See `docs/IDENTITY_INHERITANCE.md`.

**About:** Stable and visible Markdown reports that make your Obsidian vault legible. (HeartloomOS toolkit).

Docs index (canonical):
- `docs/README.md`

## What it does (Phase 0 + Phase 1)

Generates stable notes (overwritten each run):

**Phase 0**
- `VaultMeta - File Tree.md`
- `VaultMeta - Directory Blocks.md`

**Phase 1**
- `VaultMeta - Recent Changes.md`
- `VaultMeta - Largest Files.md`
- `VaultMeta - Attachment Audit.md`
- Termux report: `termux_packages.md` (written to your vault’s termux outputs directory)

Default VaultMeta output directory (if `OUTPUT_DIR` is blank):

- `$VAULT_ROOT/30_REFERENCE/vaultmeta/`

## Command surface

Single entrypoint with subcommands:

- `vaultmeta` → runs all Phase 0 + Phase 1 reports
- `vaultmeta tree` → file tree report
- `vaultmeta dirs` → directory blocks report (grouped with headings)
- `vaultmeta changes` → recent-change digest report
- `vaultmeta largest` → largest files report
- `vaultmeta attachments` → attachment audit report
- `vaultmeta termux-packages` → termux packages report (writes into vault termux-outputs)
- `vaultmeta status` → prints resolved config and effective settings (no file writes)
- `vaultmeta help` → usage

## Config

Config location (XDG):

- `${XDG_CONFIG_HOME:-$HOME/.config}/vaultmeta/vaultmeta.conf`

Docs:
- `docs/CONFIG.md`

## Install / Uninstall

```sh
chmod +x install.sh bin/vaultmeta
./install.sh install
hash -r
vaultmeta status
vaultmeta
```

Docs:
- `docs/INSTALL.md`

## Reports

Docs:
- `docs/REPORTS.md`

## Versioning + scope posture

Docs:
- `docs/VERSIONING.md`
- `docs/README.md`

## Free-core boundary for paid alpha

- Free core remains **visibility + reporting**.
- Broken-link scan is a required free-core readiness gate before sponsor-gated paid alpha (not declared shipped in this README).
- Orphan-notes reporting remains flexible and may land after paid alpha starts.
- Paid alpha is additive: comfort, automation, polish, and scale, without taking away free-core trust features.

## Safety + integrity rules

- Stable notes overwrite on each run (no accumulating files).
- Path resilience: if expected paths are missing, you will be prompted for updated paths and the tool will continue.
- Uninstall never deletes your vault content.
