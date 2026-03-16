# Self-Hosted CI Runners

Date: 2026-03-16
Status: implemented in homelab manifests
Domains: build-tooling, documentation

## Request

Add a self-hosted Actions Runner Controller configuration in the homelab repo for `CalamityFFXI/game-server`.

## Relevant Files

- `grounding.md`
- `docs/decision-records/2026-03-16-ci-workflow-fork-separation.md`
- `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system/actions-runner-controller/ks.yaml`
- `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system/actions-runner-controller/runners/kustomization.yaml`
- `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system/actions-runner-controller/runners/homelab/externalsecret.yaml`
- `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system/actions-runner-controller/runners/homelab/helmrelease.yaml`

## Current Understanding

### Confirmed

- The homelab repo already had ARC installed and a runner scale set for `https://github.com/carldanley/homelab`.
- No runner scale set existed yet for `https://github.com/CalamityFFXI/game-server`.
- The existing runner pattern uses a GitHub App secret from 1Password, `gha-runner-scale-set`, and Flux-managed `HelmRelease` resources.

### Inferred

- The `game-server` repo should use a separate secret target and separate runner set so auth and lifecycle stay isolated from the `homelab` runners.
- Reusing the `homelab` GitHub App installation ID would be unsafe unless that installation scope also covers `CalamityFFXI/game-server`.
- Starting with `minRunners: 0` and `maxRunners: 2` is a reasonable low-cost default for Linux-only CI in this project.

### Unknown

- Whether the existing GitHub App is already installed on the `CalamityFFXI` owner or whether a new installation is still needed.
- Which exact `runs-on` labels the final `cxi_` workflows should target once self-hosted PR workflows are added.

## Planned Change

Add a second ARC runner scale set in the homelab repo for `CalamityFFXI/game-server`, with its own `ExternalSecret`, `HelmRelease`, `ServiceAccount`, and `ClusterRoleBinding`.

## Validation

- Rendered `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system/actions-runner-controller/runners` with `kubectl kustomize`.
- Rendered `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system` with `kubectl kustomize`.
- Confirmed the new runner set is included in the runners kustomization and Flux health checks.
- Bound `.github/workflows/cxi_minimal_alpine_image.yml` to the explicit ARC scale-set label `calamityxi-game-server-runners`.

## Risks

- The new runner set will not register successfully until the GitHub App is installed for `CalamityFFXI/game-server` and the matching credentials exist in 1Password.
- ARC runner permissions are currently broad because the repo mirrors the existing cluster-admin runner pattern; this is functional but not least-privilege.
- Workflows still need explicit self-hosted `cxi_` entrypoints before this runner set is actually used.

## Rollback Notes

- Remove `/home/carldanley/Code/personal/homelab-codex/kubernetes/apps/actions-runner-system/actions-runner-controller/runners/calamityxi-game-server/`.
- Remove the `./calamityxi-game-server` entry from the runners `kustomization.yaml`.
- Remove the `calamityxi-game-server-runners` health check from the parent `ks.yaml`.

## Next Steps

- Create the 1Password item `calamityxi-game-server-runners` with `app-id`, `app-installation-id`, and `app-private-key`.
- Ensure the GitHub App is installed for `CalamityFFXI/game-server`.
- Validate `.github/workflows/cxi_minimal_alpine_image.yml` on the new self-hosted runner set.
- Add additional Linux-only `cxi_` workflows in the game-server repo that target the new self-hosted runner set.
