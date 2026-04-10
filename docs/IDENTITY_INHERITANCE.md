# VaultMeta Identity Inheritance

## Purpose

`heartloom-vaultmeta` is a focused downstream Heartloom tool repo.

Its job is not to redefine Heartloom meaning, law, identity, or deeper architecture. Its job is to provide practical vault-visibility tooling that stays coherent within the wider Heartloom ecosystem.

This note keeps VaultMeta’s inheritance posture explicit so the repo can stay clear, useful, and lightweight as it grows.

## Authority Boundaries

### Upstream: `heartloom-source`

Use `heartloom-source` as authority for:

- Heartloom meaning
- Heartloom law
- Heartloom identity
- deeper architectural source texts

If a proposed VaultMeta change appears to redefine those areas rather than implement local tooling, stop and route upstream.

### Identity layer: `heartloom-identity`

Use `heartloom-identity` as authority for:

- downstream governance posture
- translation and inheritance guidance
- anti-drift review
- ecosystem maps and pack/export context
- cross-repo coherence questions

VaultMeta inherits its downstream posture from `heartloom-identity` by adopting these distinctions, not by importing a heavy governance framework.

### Local repo: `heartloom-vaultmeta`

Use this repo as authority for:

- VaultMeta tool behavior
- install and uninstall behavior
- config handling
- report generation details
- local file and output contracts
- repo-local implementation and roadmap decisions

## What VaultMeta Inherits

VaultMeta should explicitly inherit these identity-layer distinctions:

1. **Source vs identity vs downstream**
   - source owns meaning
   - identity owns translation, governance, and inheritance posture
   - VaultMeta remains a downstream tool repo

2. **Translation vs redefinition**
   - VaultMeta can translate ecosystem distinctions into repo behavior
   - VaultMeta should not silently redefine source meaning

3. **Generated local artifact vs committed source doc**
   - generated notes inside a user vault are runtime outputs
   - committed repository docs define the contract for those outputs
   - generated notes are useful and stable, but not repo canon

4. **Anti-drift review**
   Before expanding scope, ask:
   - Is this aligned with source?
   - Is this translation or redefinition?
   - Does this belong upstream, in identity, or here?
   - Does this change local tooling only, or ecosystem posture too?

## Local Application in VaultMeta

These distinctions matter because VaultMeta already sits at a real boundary:

- it generates stable, overwrite-on-run notes in a local vault
- it maintains committed docs that define tool behavior
- it needs path resilience and stable output expectations
- it should remain a practical toolkit, not a second governance repo

So the local rule is simple:

- keep repo docs focused on the tool
- keep ecosystem governance lightweight and referential
- point upward when a question belongs to identity or source
- keep generated outputs clearly separate from committed repo canon

## Thin Inheritance Model

VaultMeta keeps inheritance deliberately thin:

- one repo-local inheritance/boundary note
- one lightweight README pointer
- explicit upward references when scope crosses local boundaries
- local decisions kept local unless they affect ecosystem inheritance posture

## Generated Outputs vs Repo Canon

VaultMeta generates stable, overwrite-on-run Markdown notes inside a user vault.

Those notes are useful, shareable, linkable, and part of a working vault substrate.

But they are still generated local artifacts, not committed source docs.

Repo canon lives in committed repository docs. Generated notes live in the user environment.

## Change Routing Rule

- Changes to Heartloom meaning, law, identity, or deeper architecture → route to `heartloom-source`.
- Changes to downstream governance or cross-repo inheritance posture → route to `heartloom-identity`.
- Changes to VaultMeta tool behavior, install/config/output contracts, or repo-local docs → handle in `heartloom-vaultmeta`.

## Practical Posture

VaultMeta should gain coherence through inheritance, not through heavy governance.

Aim for clearer boundaries, less drift, and better newcomer understanding while keeping this repo a practical toolkit.
