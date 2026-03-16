# Kubernetes Deployment Networking

Date: 2026-03-15
Status: implemented in homelab manifests
Domains: server-core, build-tooling, documentation, client-dat

## Request

Evaluate how to deploy this LandSandBoat-based server to the existing Kubernetes homelab, with special attention to multi-map-server networking, one-public-IP constraints, and low-cost image build strategy.

## Relevant Files

- `grounding.md`
- `.github/workflows/publish_meshes.yml`
- `settings/default/network.lua`
- `src/login/data_session.cpp`
- `src/login/connect_engine.cpp`
- `src/map/map_application.cpp`
- `src/map/map_networking.cpp`
- `src/map/map_socket.cpp`
- `src/map/ipc_client.cpp`
- `src/map/utils/zoneutils.cpp`
- `src/map/utils/instanceutils.cpp`
- `src/world/zone_settings.h`
- `sql/zone_settings.sql`
- `docker/alpine.Dockerfile`
- `docker/README.md`

## Current Understanding

### Confirmed

- The client is explicitly told which map endpoint to use from `zone_settings.zoneip` and `zone_settings.zoneport`.
- Zone changes also resolve destination IP plus port pairs through `zone_settings`, so the system already supports endpoint fan-out across map processes.
- `xi_map` supports explicit `--ip` and `--port`, and the map server binds a UDP socket on that port.
- Zone ownership for a map process is selected by matching the process IP plus port to rows in `zone_settings`.
- Login and search are TCP services; map is UDP.
- The default port `54230` is reused as TCP login-data and UDP map traffic.
- The homelab repo already provides Flux, Cilium LoadBalancer IPAM with BGP to UniFi, Multus, a `calamityxi` app namespace, and self-hosted GitHub runners.
- The upstream repo already has an Alpine multi-stage Dockerfile that produces one image containing all four binaries and runtime assets.
- The homelab deployment uses the upstream `ghcr.io/landsandboat/ximeshes:latest` image, so this fork does not need automatic mesh-image publishing on push.

### Inferred

- A single public IP with different UDP ports per map shard should work because the client is routed by explicit IP plus port values rather than by a fixed map port.
- Deploying one pod per zone would be operationally expensive because each unique shard needs a stable externally reachable endpoint and matching `zone_settings` rows.
- A single reusable Alpine image with separate Kubernetes workloads is likely the cheapest starting point.
- Moving Nashmau plus the public ferry and airship routes onto the hub shard should reduce unnecessary cross-shard travel churn for common player paths.

### Unknown

- The best first shard boundaries for this project's actual zone mix and player load.
- Whether any user-specific client or NAT behavior makes port fan-out harder in practice than the server code suggests.
- Whether this deployment is intended for LAN/VPN-only access or public internet access.

## Planned Change

Create an initial Flux app in the homelab repo for `connect`, `search`, `world`, and fixed map shards with DB bootstrap and explicit public TCP/UDP edges.

## Validation

- Confirmed login endpoint handoff in `src/login/data_session.cpp`.
- Confirmed map UDP bind and explicit `--ip` and `--port` support in `src/map/map_application.cpp`, `src/map/map_networking.cpp`, and `src/map/map_socket.cpp`.
- Confirmed zone-to-map assignment via `zone_settings` in `src/map/utils/zoneutils.cpp`, `src/world/zone_settings.h`, and `sql/zone_settings.sql`.
- Confirmed instance loading is filtered by the current map endpoint in `src/map/utils/instanceutils.cpp`.
- Confirmed `--ip` is process identity only; `MapSocket` binds `0.0.0.0:<port>`, which fits Kubernetes Service routing.
- Confirmed map session lookup is keyed by client source IP in `src/map/map_session_container.cpp`, so source-IP preservation is mandatory for login/map handoff.
- Confirmed search IP comes from the client-reported login destination in `src/login/data_session.cpp`, so the client can keep using the public WAN IP while Kubernetes uses internal LB IPs behind NAT.
- Confirmed homelab networking capabilities by inspecting the referenced homelab repository clone.
- Confirmed a refined hand-tuned hub shard can be expressed entirely as SQL updates in the bootstrap process.
- Evaluated workflow-cost reductions, but reverted direct edits to upstream workflow files in favor of an additive fork-specific workflow policy.
- The current fork-specific CI path is the separate `.github/workflows/cxi_minimal_alpine_image.yml` workflow; upstream workflows remain upstream-shaped unless there is a documented reason to patch them.
- Validated new homelab YAML with `yaml.safe_load_all`.
- Validated the homelab app kustomization with `kubectl kustomize`.

## Risks

- Splitting zones too aggressively could create hard-to-debug locality issues around instances, battlefields, or module overrides.
- Treating map workloads as interchangeable replicas would conflict with the DB-driven endpoint model.
- Public exposure through one IP requires deliberate TCP/UDP port planning and corresponding UniFi forwarding rules.
- Rolling updates that briefly overlap two pods for the same shard would create ambiguous shard ownership and unpredictable packet handling.

## Rollback Notes

- Reassign all active zones back to one advertised UDP port in `zone_settings`.
- Scale non-primary map shards to zero.
- Remove the homelab Flux app from `kubernetes/apps/calamityxi/early-access/game-server/`.

## Next Steps

- Set the real `CALAMITYXI_PUBLIC_IP` in the homelab `ks.yaml`.
- Create the `calamityxi-game-server` 1Password item with `DOCKER_CONFIG_JSON` for GHCR pulls.
- Add UniFi port forwards:
  - TCP `54001`, `54230`, `54231` -> `10.50.100.30`
  - TCP `54002` -> `10.50.100.31`
  - UDP `54230` -> `10.50.100.40`
  - UDP `54240` -> `10.50.100.41`
  - UDP `54250` -> `10.50.100.42`
  - UDP `54260` -> `10.50.100.43`
- Smoke test login, character select, and zone changes across hub, field, dungeon, and instance content.
