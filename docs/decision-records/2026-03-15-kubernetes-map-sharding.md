# Kubernetes Map Sharding

Date: 2026-03-15
Status: accepted

## Context

The project is being deployed to a home Kubernetes cluster with one public internet IP and Cilium-backed internal load balancer IPs. LandSandBoat clients connect directly to map endpoints that are advertised from `zone_settings`, so Kubernetes replica semantics do not solve map routing on their own.

## Confirmed Facts

- The login server sends `zone_settings.zoneip` and `zone_settings.zoneport` to the client for the initial map connection.
- Later zone changes resolve the destination endpoint through `zone_settings` as well.
- `xi_map` supports explicit `--ip` and `--port`.
- Map sockets are UDP.
- Zone ownership on a map process is determined by matching the process endpoint to `zone_settings`.

## Decision

Adopt a first-pass four-shard map layout for Kubernetes:

- `town` shard for all `zonetype = 1` zones plus explicit hub and public-travel exceptions:
  - `1`, `3`, `46`, `47`, `53`, `58`, `59`, `220`, `221`, `223`, `224`, `225`, `226`, `227`, `228`
- `field` shard for `zonetype = 2` excluding the hub exceptions above
- `dungeon` shard for `zonetype = 4`
- `instance` shard for `zonetype IN (0, 128, 256)` while preserving rows that are disabled with `zoneport = 0`, excluding `220` and `221`

Use one advertised client IP and distinct UDP ports for each shard, rather than assigning one public endpoint per zone.

Use `Recreate` rollout semantics for every single-owner server workload so two pods never claim the same shard simultaneously.

Use Cilium `LoadBalancer` Services with `externalTrafficPolicy: Local` for every public-facing TCP/UDP service so the game stack continues to see the real client source IP.

Approximate active zone counts after the hand-tuned split:

- `town` hub shard: `57`
- `field` shard: `77`
- `dungeon` shard: `78`
- `instance` shard: `87`

## Alternatives Considered

- Single monolithic map process:
  - simplest operationally, but does not exercise the multi-map deployment path the project wants to support.
- One map pod per zone:
  - technically closer to the DB model, but operationally too expensive and fragile behind a single home WAN IP.
- Manually curated zone-by-zone sharding:
  - possible later, but too high-effort for the initial deployment and harder to keep aligned with upstream content updates.
- Three-shard zonetype split:
  - simpler, but left the `zonetype IN (0, 4, 128, 256)` shard too broad for a cluster that has ample CPU and memory headroom.
- Pure four-shard zonetype split:
  - workable, but left Nashmau and the public travel surface on non-hub shards even though they behave operationally more like city and transit content than overworld combat zones.

## Mergeability Risk

- None to server gameplay logic if the deployment logic stays in deployment manifests and documentation.

## Validation Impact

- Validation must include login plus zone changes across all four shards, especially hub-to-airship or ferry transitions and hub-to-field transitions, not just process startup.

## Rollback Or Reversal Path

- Reassign all active zones back to a single advertised UDP port in `zone_settings`.
- Scale non-primary map shards to zero.
