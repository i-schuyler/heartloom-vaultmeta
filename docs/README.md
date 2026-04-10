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

- Free core remains complete for its stated purpose: **visibility + reporting**.
- Paid scope adds comfort, automation, polish, and scale.
- Paid scope does not remove basic trust/visibility capabilities from free core.
- **Required before sponsor-gated paid alpha:** broken-link scan exists inside free core (tracked as a readiness gate, not claimed as shipped here).
- **Flexible before sponsor-gated paid alpha:** orphan-notes reporting may land later without breaking the free-core boundary.

## Alpha-readiness posture (docs anchor)

- **Must be true before sponsor-gated paid alpha starts:**
  - free core stays anchored to visibility + reporting
  - broken-link scan is present as a free-core trust feature
  - paid alpha positioning remains additive (comfort/automation/polish/scale)
- **May still be incomplete when paid alpha starts:**
  - orphan-notes reporting
  - other non-trust polish items that do not remove free-core visibility/reporting value

## Current known gap

- The `attachments` command has a confirmed bug in current reality and should be treated as a tracked defect, not intended behavior.
- See investigation notes under `_investigation/` for concrete evidence snapshots when present.
