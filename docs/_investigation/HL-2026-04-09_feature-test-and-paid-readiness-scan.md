# HL-2026-04-09 — VaultMeta feature test and paid-readiness scan (Slice 1)

## Purpose / slice scope

This investigation captures the real current feature surface of `heartloom-vaultmeta`, smoke-tests the current command set against a synthetic vault, and records confirmed drift and paid-readiness implications.

Slice constraints followed:

- No code changes in `bin/` or `install.sh`
- No bug fixes
- No release/tag/version changes
- One new investigation doc only

Preflight outcome:

- Open PR check: no open PRs found (`gh pr list --state open ...` returned `[]`)
- Git preflight before edits: clean tree, no divergence (`0 0`), started on `main`, then switched to `docs/vaultmeta-feature-test-and-paid-readiness-scan`

## Repo reality summary

Observed feature reality is a Phase 0 + Phase 1 report generator with a single entrypoint and explicit subcommands.

Required evidence collected (exact `file:line`):

- Command surface in README: `README.md:27`, `README.md:31`, `README.md:32`, `README.md:33`, `README.md:34`, `README.md:35`, `README.md:36`, `README.md:37`, `README.md:38`, `README.md:39`
- Command surface in install docs: `docs/INSTALL.md:7`, `docs/INSTALL.md:128`, `docs/INSTALL.md:129`, `docs/INSTALL.md:130`, `docs/INSTALL.md:131`, `docs/INSTALL.md:132`, `docs/INSTALL.md:133`
- Actual command surface in script usage + dispatcher: `bin/vaultmeta:713`, `bin/vaultmeta:718`, `bin/vaultmeta:719`, `bin/vaultmeta:720`, `bin/vaultmeta:721`, `bin/vaultmeta:722`, `bin/vaultmeta:723`, `bin/vaultmeta:724`, `bin/vaultmeta:725`, `bin/vaultmeta:726`, `bin/vaultmeta:749`, `bin/vaultmeta:750`, `bin/vaultmeta:751`, `bin/vaultmeta:752`, `bin/vaultmeta:753`, `bin/vaultmeta:754`, `bin/vaultmeta:755`, `bin/vaultmeta:756`, `bin/vaultmeta:757`, `bin/vaultmeta:758`
- Current report contract: `docs/REPORTS.md:3`, `docs/REPORTS.md:9`, `docs/REPORTS.md:19`, `docs/REPORTS.md:42`, `docs/REPORTS.md:44`, `docs/REPORTS.md:51`, `docs/REPORTS.md:54`, `docs/REPORTS.md:59`, `docs/REPORTS.md:71`, `docs/REPORTS.md:79`
- Downstream boundary and inheritance posture: `AGENTS.md:11`, `AGENTS.md:12`, `AGENTS.md:13`, `AGENTS.md:52`, `AGENTS.md:55`, `docs/IDENTITY_INHERITANCE.md:13`, `docs/IDENTITY_INHERITANCE.md:24`, `docs/IDENTITY_INHERITANCE.md:36`, `docs/IDENTITY_INHERITANCE.md:109`, `docs/IDENTITY_INHERITANCE.md:110`, `docs/IDENTITY_INHERITANCE.md:111`
- Current script version: `bin/vaultmeta:6`

Boundary alignment note:

- This slice stays repo-local and does not redefine authority owned by [`heartloom-source`](https://github.com/i-schuyler/heartloom-source) or governance posture owned by [`heartloom-identity`](https://github.com/i-schuyler/heartloom-identity), consistent with `docs/IDENTITY_INHERITANCE.md`.

## Exact command surface

Confirmed from `bin/vaultmeta` usage + `case` dispatcher:

- `vaultmeta` (no subcommand) runs all reports (`bin/vaultmeta:718`, `bin/vaultmeta:750`)
- `vaultmeta tree` (`bin/vaultmeta:719`, `bin/vaultmeta:751`)
- `vaultmeta dirs` (`bin/vaultmeta:720`, `bin/vaultmeta:752`)
- `vaultmeta changes` (`bin/vaultmeta:721`, `bin/vaultmeta:753`)
- `vaultmeta largest` (`bin/vaultmeta:722`, `bin/vaultmeta:754`)
- `vaultmeta attachments` (`bin/vaultmeta:723`, `bin/vaultmeta:755`)
- `vaultmeta termux-packages` (`bin/vaultmeta:724`, `bin/vaultmeta:756`)
- `vaultmeta status` (`bin/vaultmeta:725`, `bin/vaultmeta:757`)
- `vaultmeta help` / `-h` / `--help` (`bin/vaultmeta:726`, `bin/vaultmeta:758`)

## Smoke test setup

Verification steps executed:

1. Syntax checks
   - `bash -n bin/vaultmeta` (pass)
   - `bash -n install.sh` (pass)

2. Synthetic vault root (non-`/tmp`)
   - `${TMPDIR:-$HOME/.cache}/vaultmeta-smoke/`
   - Resolved in this session to: `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/`

3. Synthetic vault contents included:
   - Markdown notes
   - Non-markdown attachments (`.jpg`, `.png`, `.pdf`, `.mp3`, `.zip`)
   - Filename with spaces (`Plan with spaces.md`, `photo one.jpg`, `Specification Draft.pdf`)
   - Hidden directory (`.obsidian/plugins/plugins.json`)
   - Nested folders (`Projects/Project Alpha/Nested`, `Daily/2026/04`, etc.)
   - Varied sizes and mtimes to exercise `changes`, `largest`, and `attachments`

4. Temp config used
   - `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/vaultmeta-smoke.conf`
   - Set `VAULT_ROOT`, `OUTPUT_DIR`, `TERMUX_OUTPUT_DIR`, and Phase 1 parameters

## Per-command smoke test results

All commands were run as `VAULTMETA_CONFIG=<temp-config> bin/vaultmeta <subcommand>`.

- `status` — **PASS**
  - Exit: `0`
  - Output files: none expected
  - Structure check: N/A (prints resolved config and settings)
  - Notes: reports version `0.1.0-phase1-dev`

- `tree` — **PASS (with suspicious output)**
  - Exit: `0`
  - Output file: `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/out/vaultmeta/VaultMeta - File Tree.md`
  - Structure check: frontmatter + settings summary present
  - Suspicious output: indented absolute-root artifact line (`- synthetic-vault`) appears in tree body

- `dirs` — **PASS (with suspicious grouping behavior)**
  - Exit: `0`
  - Output file: `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/out/vaultmeta/VaultMeta - Directory Blocks.md`
  - Structure check: frontmatter + settings summary present
  - Suspicious output: repeated `## (root)` heading segments between top-level groups

- `changes` — **PASS**
  - Exit: `0`
  - Output file: `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/out/vaultmeta/VaultMeta - Recent Changes.md`
  - Structure check: frontmatter + settings summary + both time windows present

- `largest` — **PASS**
  - Exit: `0`
  - Output file: `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/out/vaultmeta/VaultMeta - Largest Files.md`
  - Structure check: frontmatter + settings summary + size/path table present

- `attachments` — **FAIL**
  - Exit: `1`
  - Output file path (partially written): `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/out/vaultmeta/VaultMeta - Attachment Audit.md`
  - Structure check: frontmatter + settings summary present, body incomplete after table header
  - Exact stderr:
    - `bin/vaultmeta: line 438: .md: command not found`
    - `awk: cmd. line:13:             printf "%s\t%d\t%d`
    - `awk: cmd. line:13:                    ^ unterminated string`
  - Confirmed code evidence for this failure site: `bin/vaultmeta:438`, `bin/vaultmeta:470`, `bin/vaultmeta:471`

- `termux-packages` — **PASS**
  - Exit: `0`
  - Output file: `/data/data/com.termux/files/usr/tmp/vaultmeta-smoke/out/termux-outputs/termux_packages.md`
  - Structure check: frontmatter present, report sections populated
  - Notes: writes substantial host/environment/package detail

## Confirmed doc drift

1. `docs/INSTALL.md` top command summary is stale vs real surface.

- Doc claims subcommands are only `tree`, `dirs`, `status` (`docs/INSTALL.md:7`)
- Actual script includes `changes`, `largest`, `attachments`, `termux-packages`, and `help` (`bin/vaultmeta:721` through `bin/vaultmeta:726`, dispatcher at `bin/vaultmeta:753` through `bin/vaultmeta:758`)

2. Internal install doc inconsistency.

- Top section lists only 3 subcommands (`docs/INSTALL.md:7`)
- Later “Run individually” block includes the broader set (`docs/INSTALL.md:128` through `docs/INSTALL.md:133`)

3. Roadmap Phase 1 wording mismatch against current repo reality (prompt-provided roadmap excerpt for this slice).

- Prompt excerpt Phase 1 includes: recent-change digest, largest files, attachment audit, broken link scan, orphan notes
- Current repo docs/code confirm: recent changes, largest, attachment audit, termux packages (`README.md:18` through `README.md:21`, `docs/REPORTS.md:44`, `docs/REPORTS.md:51`, `docs/REPORTS.md:54`, `docs/REPORTS.md:59`)
- No confirmed command/report for broken-link scan or orphan-notes scan in current command dispatcher (`bin/vaultmeta:749` through `bin/vaultmeta:760`)

## Confirmed release/version drift

- Script version is explicitly dev-labeled: `VERSION="0.1.0-phase1-dev"` (`bin/vaultmeta:6`)
- User-facing docs are phase-oriented but do not clearly define release channel/stability expectations for paid packaging handoff:
  - README positions “Phase 0 + Phase 1” (`README.md:9`)
  - REPORTS references potential later phases (`docs/REPORTS.md:83`)
- Net effect: release signaling is understandable for contributors but weak for paid-readiness user expectations (no explicit release-state contract in install/report docs).

## Privacy/safety review notes

`termux_packages.md` currently includes potentially sensitive environment identifiers and configuration details:

- Full `uname -a` host/kernel/device string (`bin/vaultmeta:526`)
- Raw `termux-info` output block when available (`bin/vaultmeta:527` through `bin/vaultmeta:533`)
- Global Git identity if set (`git user.name`, `git user.email`) (`bin/vaultmeta:583` through `bin/vaultmeta:587`)
- Presence of key dotfile directories (`bin/vaultmeta:594` through `bin/vaultmeta:597`)
- APT source definitions and held-package details (`bin/vaultmeta:600` through `bin/vaultmeta:647`)
- Optional language ecosystem package inventories (`bin/vaultmeta:657` through `bin/vaultmeta:699`)

Paid packaging implication:

- Report should be treated as a high-disclosure diagnostic artifact. Before paid packaging, either document this disclosure explicitly or add redaction/profile controls in a future slice.

## Paid-readiness assessment

Using prompt-authoritative boundary (“free remains complete for visibility/reporting; paid adds comfort/automation/polish/scale”):

- Free-core alignment: mostly aligned on visibility/report generation surface (tree/dirs/changes/largest/attachments/status)
- Critical blocker: `attachments` command currently fails in smoke-test conditions and produces incomplete output
- Roadmap alignment gap: broken-link and orphan-note features (prompt Phase 1 excerpt) are not present in current command surface
- Paid-feature readiness (prompt Phase 2 excerpt: setup wizard, scheduler bundle, diff mode, multi-vault profiles, formatting themes): not present yet; this is expected but should be framed as future work, not implied current capability
- Release communication gap: `phase1-dev` script version and doc framing may under-communicate readiness expectations for paid-facing users

## Unknowns / unresolved questions

- Is `attachments` failure already known/accepted as pre-release debt, or should it gate any paid-readiness milestone?
- Should broken-link and orphan-note scans be explicitly moved to later roadmap wording if not in current Phase 1 implementation?
- Should `termux_packages.md` become opt-in for paid distributions due to disclosure breadth?
- Should release-state language (dev/beta/stable) be standardized across README/install/report docs before paid-facing communication?

## Recommended next slices

1. **Bug-fix slice (code):** fix `attachments` command runtime errors (`bin/vaultmeta:438`, `bin/vaultmeta:470`, `bin/vaultmeta:471`) and re-run smoke tests.
2. **Docs alignment slice:** reconcile `docs/INSTALL.md` command summary with real surface and remove internal inconsistency.
3. **Roadmap clarity slice:** align repo-facing roadmap wording with implemented features (or clearly mark pending items).
4. **Privacy controls slice:** define/document disclosure profile for `termux_packages.md` (default redactions or explicit warning language).
5. **Release signaling slice:** add explicit release-state language and paid-readiness criteria in docs.
