# Kubernetes Deployment

Status: starter note
Last updated: 2026-03-15
Domains: build-tooling, server-core, documentation

## Purpose

Capture the current Kubernetes deployment strategy for this private-server project and keep the network and sharding assumptions explicit.

## Inspected

- `settings/default/network.lua`
- `src/login/data_session.cpp`
- `src/map/map_application.cpp`
- `src/map/map_networking.cpp`
- `src/map/map_socket.cpp`
- `src/map/utils/zoneutils.cpp`
- `src/map/utils/instanceutils.cpp`
- `src/world/zone_settings.h`
- `sql/zone_settings.sql`
- `docker/alpine.Dockerfile`
- `docker/README.md`
- local homelab cluster repo patterns

## Confirmed

- Login is TCP on `54001`, `54230`, and `54231`.
- Search is TCP on `54002`.
- World exposes ZMQ on `54003` for internal server-to-server communication.
- Map traffic is UDP, and each `xi_map` process can advertise a distinct `IP:port` pair through `--ip` and `--port`.
- `xi_map --ip` controls the process identity used against `zone_settings`; the UDP socket itself binds `0.0.0.0:<port>`.
- Client map routing is driven by `zone_settings.zoneip` and `zone_settings.zoneport`.
- Multi-process map sharding is therefore DB-driven, not Kubernetes-replica-driven.
- Map session creation keys off the client source IP stored in `accounts_sessions.client_addr`, so deployment networking must preserve client source IP end to end.
- The upstream repo already includes an Alpine service image build path in `docker/alpine.Dockerfile`.

## Inferred

- The simplest first sharding model is a small number of stable map shards, not one pod per zone.
- With one public home IP, external access should use a single advertised IP plus different UDP ports per map shard.

## Current First-Pass Design

- One `connect` deployment for login TCP listeners.
- One `search` deployment for search TCP listener.
- One `world` deployment for ZMQ coordination.
- Four map shards:
  - `town` hub shard:
    - all `zonetype = 1` zones
    - plus hub and public-travel zone IDs `1`, `3`, `46`, `47`, `53`, `58`, `59`, `220`, `221`, `223`, `224`, `225`, `226`, `227`, `228`
    - active zone count: `57`
  - `field`: `zonetype = 2` excluding the hub exceptions above
    - active zone count: `77`
  - `dungeon`: `zonetype = 4`
    - active zone count: `78`
  - `instance`: `zonetype IN (0, 128, 256)` with `zoneport <> 0`, excluding `220` and `221`
    - active zone count: `87`
- Suggested public UDP ports:
  - town: `54230`
  - field: `54240`
  - dungeon: `54250`
  - instance: `54260`
- Kubernetes exposure strategy:
  - Cilium `LoadBalancer` Services with `externalTrafficPolicy: Local`
  - one TCP LB for `connect`
  - one TCP LB for `search`
  - one UDP LB per map shard
  - one `ClusterIP` Service for `world`
- Pod rollout strategy:
  - single replica per workload
  - `Recreate` strategy for `connect`, `search`, `world`, `bootstrap`, and each map shard to avoid overlapping shard owners

## UniFi Port Forward Plan

- TCP `54001` on the WAN IP -> `10.50.100.30:54001` for `connect`
- TCP `54230` on the WAN IP -> `10.50.100.30:54230` for `connect`
- TCP `54231` on the WAN IP -> `10.50.100.30:54231` for `connect`
- TCP `54002` on the WAN IP -> `10.50.100.31:54002` for `search`
- UDP `54230` on the WAN IP -> `10.50.100.40:54230` for the hub shard
- UDP `54240` on the WAN IP -> `10.50.100.41:54240` for the field shard
- UDP `54250` on the WAN IP -> `10.50.100.42:54250` for the dungeon shard
- UDP `54260` on the WAN IP -> `10.50.100.43:54260` for the instance shard

Notes:
- TCP and UDP can both use external port `54230` because the protocol differs.
- The client-facing `zoneip` should remain the WAN IP for public internet play.
- The internal `10.50.100.x` addresses are only the UniFi NAT targets.

## Rollout Order

1. Publish the Alpine Linux image tag that the homelab app will deploy.
2. Create the `calamityxi-game-server` 1Password item containing `DOCKER_CONFIG_JSON`.
3. Replace the placeholder `CALAMITYXI_PUBLIC_IP` in the homelab `ks.yaml` with the real WAN IP.
4. Commit and push the homelab manifests.
5. Wait for Flux to reconcile and verify the Services receive the expected LB IPs.
6. Add the UniFi TCP and UDP port-forward rules to those LB IPs.
7. Confirm the bootstrap Deployment rewrote `zone_settings` to the expected hub, field, dungeon, and instance ports.
8. Confirm `connect`, `search`, `world`, and all four map Deployments are ready.
9. Validate login plus zoning across hub, field, dungeon, and instance content.

Useful checks:
- `kubectl get svc -n calamityxi`
- `kubectl get deploy -n calamityxi`
- `kubectl logs -n calamityxi deploy/calamityxi-early-access-bootstrap`
- `kubectl exec -n calamityxi deploy/calamityxi-early-access-bootstrap -- mariadb --host=calamityxi-mariadb-early-access --port=3306 --user=calamityxi-early-access --database=calamityxi-early-access -e "SELECT zoneid, zoneip, zoneport FROM zone_settings WHERE zoneid IN (243,100,9,188,53,220,223) ORDER BY zoneid;"`

## Replica Guidance

- `connect`: keep at `1` replica.
  - Login session state is stored in-process in `authenticatedSessions_`.
  - The login ZMQ dealer routing ID explicitly assumes a single login server.
- `world`: keep at `1` replica.
  - It is the single ZMQ router for map and login IPC.
  - It also runs global world systems and timers such as conquest, campaign, besieged, colonization, and the time server.
- `search`: safest at `1` replica for now.
  - Request handling is closer to stateless than `connect` or `world`, but it still has in-process IP session counting and periodic AH expiration work.
  - Replicas are only worth revisiting if cleanup is split out and the changed connection-limit semantics are acceptable.

## Self-Hosted CI

- The homelab repo now has a separate ARC runner scale set intended for `https://github.com/CalamityFFXI/game-server`, distinct from the existing `carldanley/homelab` runner set.
- The initial runner target is operationally conservative:
  - `minRunners: 0`
  - `maxRunners: 2`
- The runner scale set name is explicitly `calamityxi-game-server-runners`, and ARC runner scale sets use that single name as the `runs-on` target for workflows.
- The runner auth material should come from a dedicated 1Password item named `calamityxi-game-server-runners`, not from the `homelab` runner secret, because the GitHub App installation ID must match the `CalamityFFXI/game-server` installation scope.
- This runner set only prepares cluster-side capacity. GitHub workflow files still need explicit `cxi_` self-hosted workflows before PR checks or builds will use it.

## Risks

- Sharding by mostly-zonetype buckets with hand-tuned hub exceptions is a safe first pass, but not necessarily the final optimum for player load or event locality.
- Any bootstrap that rewrites `zone_settings` must preserve disabled zones where `zoneport = 0`.
- The advertised `zoneip` must be reachable by clients; for public internet access this is the WAN IP, not a cluster-only IP.
- If source IP is not preserved by the TCP and UDP edge path, login and map handoff will fail because the map server will not match client packets to the login-created session row.

## Next Verification Step

- Validate the first deployment by logging in, zoning between a hub city and field content, then to a dungeon, then to instance content, and confirming each handoff reaches the expected UDP port.
