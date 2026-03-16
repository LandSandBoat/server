# Repo Map

Status: starter note
Last updated: 2026-03-15
Domains: documentation, server-core, lua-gameplay, sql-data, module-customization, build-tooling

## Purpose

Track the high-level repository layout and the best first-stop directories for common LandSandBoat tasks.

## Inspected

- `grounding.md`
- repo root directory layout
- `src/`
- `scripts/`
- `modules/`
- `tools/`
- `documentation/`

## Confirmed

- `src/common/` exists for shared infrastructure.
- `src/login/`, `src/map/`, `src/search/`, and `src/world/` exist as distinct runtime areas.
- `src/map/` contains `ai`, `entities`, `items`, `lua`, `packets`, `utils`, and LOS helpers, making it a primary gameplay-debugging surface.
- `scripts/` contains gameplay content for actions, battlefields, commands, effects, items, missions, quests, tests, mixins, and zones.
- `modules/` exists and includes `custom`, `example`, expansion-focused folders, and C++ or Lua or SQL customization surfaces.
- `tools/` contains database, migration, CI, formatting, and headless-client utilities.
- `documentation/` already exists and should be treated as supplementary repo-local context.

## Inferred

- Most gameplay customization can likely be isolated to Lua or SQL modules before core C++ edits are necessary.
- `documentation/` appears to contain topic-specific notes rather than a complete architecture guide.

## Unknown

- Precise startup flow and IPC boundaries between login, map, search, and world processes.
- Which local modules are actively enabled for this private-server deployment.
- Whether any client or DAT customization lives outside this repo.

## Risk

- This is only a starter map; relying on it without confirming the relevant source files would be too coarse for code changes.

## Next Verification Step

- Trace one end-to-end gameplay change from packet or command entry point through map-server C++ into Lua and SQL content.
