# CI Workflow Fork Separation

Date: 2026-03-16
Status: accepted
Domains: build-tooling, documentation

## Context

This fork needs custom GitHub Actions behavior for CalamityXI without increasing merge friction against upstream `LandSandBoat/server`.

GitHub Actions workflow discovery is fixed to `.github/workflows/`, so this repository cannot point GitHub at a separate workflow directory for event-triggered workflows.

## Decision

- Keep upstream workflow files in `.github/workflows/` as close to upstream as practical.
- Put CalamityXI-specific workflows in the same folder, but prefix them with `cxi_`.
- Prefer disabling unwanted upstream workflows in GitHub repository settings or with `gh workflow disable ...` instead of patching upstream workflow YAML in git.
- Keep branch protection and required checks focused on `cxi_` workflows when fork-specific policy differs from upstream.

## Consequences

- Upstream workflow merges should stay cleaner because fork policy is mostly additive.
- New upstream workflows may still arrive enabled by default and need a one-time disable in GitHub if the fork does not want them to run.
- CalamityXI workflow ownership becomes obvious from the filename prefix alone.

## Initial Fork-Specific Workflow

- `.github/workflows/cxi_minimal_alpine_image.yml`

## Revisit If

- GitHub adds support for configurable workflow directories.
- The fork moves most CI logic into a dedicated reusable-workflows repository and only keeps thin entrypoints here.
