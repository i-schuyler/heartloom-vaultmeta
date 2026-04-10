# Docs Index (Canonical)

This file is the canonical docs index for `heartloom-vaultmeta`.

## Start here

- Project overview: `../README.md`
- Install / uninstall: `INSTALL.md`
- Config contract: `CONFIG.md`
- Reports contract: `REPORTS.md`
- Versioning / release posture: `VERSIONING.md`
- Inheritance boundary: `IDENTITY_INHERITANCE.md`
- Investigations and audits: `_investigation/` (when present)

## Canon vs generated outputs

- Repo canon lives in committed docs in this repository.
- Generated vault reports are runtime outputs in user vaults (for example `VaultMeta - File Tree.md` and `termux_packages.md`).
- Generated outputs are useful artifacts but are not committed repo canon.

## Free vs paid scope anchor

- Free scope remains complete for its stated purpose: vault visibility + reporting.
- Paid scope should add comfort, automation, polish, and scale.
- Paid scope should not remove basic trust/visibility capabilities from free scope.

## Current known gap

- The `attachments` command has a confirmed bug in current reality and should be treated as a tracked defect, not intended behavior.
- See investigation notes under `_investigation/` for concrete evidence snapshots when present.
