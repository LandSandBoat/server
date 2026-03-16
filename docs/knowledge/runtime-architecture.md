# Runtime Architecture

Status: starter note
Last updated: 2026-03-15
Domains: documentation, server-core

## Purpose

Capture process responsibilities and interaction points between the major LandSandBoat server runtimes.

## Inspected

- `grounding.md`
- `src/common/`
- `src/login/`
- `src/map/`
- `src/search/`
- `src/world/`

## Confirmed

- `src/common/` exists for shared infrastructure used across server processes.
- `src/login/` exists and is described in `grounding.md` as the connect and login server surface.
- `src/map/` exists and is described in `grounding.md` as the main gameplay runtime.
- `src/search/` exists and is described in `grounding.md` as the search and auction-related runtime.
- `src/world/` exists and is described in `grounding.md` as the world-level systems surface.
- `src/map/` contains `entities`, `lua`, `packets`, `ai`, and `items`, making it the highest-value entry point for gameplay debugging.
- Login uses TCP listeners on `network.LOGIN_VIEW_PORT`, `network.LOGIN_DATA_PORT`, and `network.LOGIN_AUTH_PORT`.
- Search listens on `network.SEARCH_PORT` over TCP.
- Map traffic uses a UDP socket and binds either `network.MAP_PORT` or the explicit `--port` passed to `xi_map`.
- `xi_map` accepts `--ip` and `--port`, and zone ownership is resolved from `zone_settings.zoneip` plus `zone_settings.zoneport`.
- Login hands the client a `zoneip` and `zoneport` from `zone_settings` for the first map connection, and zone changes later resolve destination endpoints through `zone_settings` as well.
- World loads `zone_settings` and tracks map endpoints by unique IP plus port pairs, not by process names or Kubernetes identities.

## Inferred

- Cross-process communication likely depends on shared code in `src/common/`, but the exact contracts still need code tracing.
- Multi-process map sharding is DB-driven and should be treated as endpoint assignment, not as generic stateless horizontal scaling.

## Unknown

- Startup order, IPC message boundaries, zone-to-process mapping, and where search or world responsibilities begin and end in practice.
- Whether any gameplay subsystems have hidden expectations that certain zone families remain on the same map endpoint beyond the explicit instance-loading filters already identified.

## Risk

- Process-boundary mistakes can lead to fixes being implemented in the wrong server surface.
- Treating map pods like fungible replicas would break client routing because the client is sent explicit map endpoints.

## Next Verification Step

- Trace server startup and one login-to-map handoff through the relevant entry points and IPC code.
- For Kubernetes deployment work, map candidate shard groupings to `zone_settings` rows and validate instance and battlefield locality before changing assignments.
