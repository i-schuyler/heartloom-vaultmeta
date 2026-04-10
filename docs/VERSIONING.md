# VERSIONING

VaultMeta uses a simple semver-like posture for release signaling.

## Core rules

- Versions must be explicit and immutable.
- Each version must map to one unique repository state.
- Consumers should treat versions as pinned snapshots, not floating references.

## Scheme

- Use a semver-like scheme for stable release versions (for example `0.2.0`, `1.0.0`).
- Distinguish stable releases from unreleased development head clearly.
- Development-head identifiers (for example `-dev`) are not stable release versions.

## Sync requirement

- Release tags and in-repo version strings must stay in sync.
- For CLI releases, the `VERSION` string in `bin/vaultmeta` and the Git tag should refer to the same release state.

## Practical consumption

- Pin to explicit tags/versions for automation, docs, and downstream packaging.
- Avoid relying on moving branch heads for release-critical behavior.
