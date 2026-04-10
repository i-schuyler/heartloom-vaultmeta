# HL-2026-04-09 — VaultMeta alpha readiness review (Slice 9)

## Supersession note (post-review)

- This document remains a historical Slice 9 review snapshot.
- Its `attachments`-defect references (`Known limitations not acceptable for alpha` and related recommendation bullets) were accurate at review time and are now superseded by later merged fixes.
- Keep the body below intact for historical traceability.
- The `termux_packages.md` disclosure/redaction caution remains relevant and current.

## Purpose / review scope

This review checks current `heartloom-vaultmeta` repo reality against the locked paid-alpha gate and records a repo-local recommendation for whether sponsor-gated paid alpha should begin now.

Locked gate used in this review:

- free core = visibility + reporting
- broken-link scan/report required before sponsor-gated paid alpha
- orphan-notes reporting is flexible (not required pre-alpha)

Slice constraints followed:

- docs-only review
- exactly one new investigation file
- no code, release, or CI/workflow changes

## Evidence block (exact `file:line`)

- **Current command surface:** `README.md:31`, `README.md:35`, `README.md:40`, `bin/vaultmeta:1037`, `bin/vaultmeta:1043`, `bin/vaultmeta:1077`
- **Current reports surface:** `README.md:12`, `README.md:20`, `README.md:23`, `docs/REPORTS.md:42`, `docs/REPORTS.md:59`, `docs/REPORTS.md:81`
- **Free-core boundary lock:** `README.md:79`, `README.md:81`, `README.md:82`, `README.md:83`, `docs/README.md:21`, `docs/README.md:26`, `docs/README.md:27`
- **Broken-link implementation/docs:** `docs/REPORTS.md:59`, `docs/REPORTS.md:63`, `docs/REPORTS.md:67`, `docs/REPORTS.md:73`, `docs/REPORTS.md:79`, `bin/vaultmeta:612`, `bin/vaultmeta:616`, `bin/vaultmeta:666`, `bin/vaultmeta:671`, `bin/vaultmeta:773`, `bin/vaultmeta:803`, `bin/vaultmeta:1062`
- **Versioning posture:** `docs/VERSIONING.md:3`, `docs/VERSIONING.md:7`, `docs/VERSIONING.md:13`, `docs/VERSIONING.md:19`
- **Privacy/redaction posture:** `docs/REPORTS.md:101`, `docs/REPORTS.md:103`, `docs/REPORTS.md:104`, `docs/REPORTS.md:105`
- **Install/docs/readme coherence anchors:** `docs/INSTALL.md:7`, `docs/INSTALL.md:39`, `docs/INSTALL.md:43`, `README.md:40`, `docs/REPORTS.md:79`

## Current command/report surface

Current surface is a single `vaultmeta` entrypoint with subcommands including `broken-links` and default run-all support.

- Usage and dispatcher include `broken-links`: `bin/vaultmeta:1043`, `bin/vaultmeta:1077`
- Run-all includes broken-links report generation: `bin/vaultmeta:1062`
- README command surface matches this: `README.md:35`, `README.md:40`

Current report set includes:

- visibility/reporting baseline reports plus broken-links and termux packages: `README.md:20`, `README.md:23`, `README.md:25`
- reports contract includes Broken Links first-pass scope/exclusions/output structure: `docs/REPORTS.md:59` through `docs/REPORTS.md:79`

## Free-core gate checklist

- **Free core anchored to visibility + reporting:** pass (`README.md:81`, `docs/README.md:23`)
- **Broken-link scan/report required pre-alpha:** pass as policy (`README.md:82`, `docs/README.md:26`)
- **Broken-link scan/report implemented and on command surface:** pass (`bin/vaultmeta:612`, `bin/vaultmeta:1043`, `bin/vaultmeta:1062`, `docs/REPORTS.md:79`)
- **Orphan-notes remains flexible / not gate-blocking:** pass (`README.md:83`, `docs/README.md:27`)

## What is now ready

- The locked alpha gate is satisfied at repo-doc + command/report contract level.
- Broken-links exists as both documented contract and implemented command path.
- README / INSTALL / REPORTS command references for `broken-links` are coherent.
- Versioning posture is explicitly documented, including dev-vs-stable distinctions.

## Known limitations still acceptable for alpha

- Orphan-notes reporting remains intentionally out of pre-alpha gate scope (`README.md:83`, `docs/README.md:27`).
- Redaction controls are guidance-level (documented operational posture) rather than automated enforcement; for alpha this is acceptable if disclosure guidance is followed (`docs/REPORTS.md:103` through `docs/REPORTS.md:105`).

## Known limitations not acceptable for alpha (if any)

- `docs/README.md` still records a confirmed `attachments` defect as current known gap (`docs/README.md:40` through `docs/README.md:43`).
- This does not break the explicit broken-links alpha gate, but it is a trust-sensitive reporting limitation and should be explicitly disclosed in alpha onboarding.

## Privacy/disclosure posture review

- Current posture is explicit for `termux_packages.md`: treat as local diagnostic artifact and redact sensitive identifiers before sharing (`docs/REPORTS.md:101` through `docs/REPORTS.md:105`).
- For paid alpha, this is workable, but requires an admin/process step so sponsors consistently receive redacted artifacts only.

## Install/docs/readme coherence review

- Command lists are aligned across docs and CLI for `broken-links` (`docs/INSTALL.md:7`, `README.md:40`, `bin/vaultmeta:1043`).
- Report naming is aligned across docs (`README.md:23`, `docs/INSTALL.md:43`, `docs/REPORTS.md:59`).
- Free-core/gate language is aligned in README + docs index (`README.md:81` through `README.md:83`, `docs/README.md:23` through `docs/README.md:27`).

## Recommendation

**Proceed after minor docs/admin step.**

VaultMeta appears alpha-ready against the locked gate, but should complete one lightweight operational step before sponsor-gated paid alpha begins:

1. Publish a short alpha onboarding note that:
   - calls out the known `attachments` defect currently documented in `docs/README.md:40`
   - requires redaction of `termux_packages.md` details before external sharing (`docs/REPORTS.md:104`)

This is an admin/disclosure action, not a code blocker, and keeps alpha entry aligned with the repo’s trust posture.

## Recommended immediate next steps

1. Open the sponsor-facing alpha onboarding/disclosure note (single short doc or PR template section).
2. Include two mandatory disclosures in that onboarding note:
   - known `attachments` gap status
   - `termux_packages.md` redaction requirement
3. Start sponsor-gated paid alpha once that disclosure step is live.
