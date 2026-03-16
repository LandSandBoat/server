# Reference Index

Read this file first when the skill triggers. Use it to pick the smallest repo surface that can answer the current task.

## Grounding and project posture

- `grounding.md`: canonical repo grounding currently on disk; contains domain separation, module-first strategy, and durable-memory rules.
- `README.md`: repo entry point and setup context.
- `docs/knowledge/*.md`: durable project notes; confirm any stale notes against source before relying on them.

## Architecture

- `src/common/`: shared infrastructure.
- `src/login/`: login and connection server.
- `src/map/`: gameplay runtime, entities, packets, Lua bindings, AI, and item logic.
- `src/search/`: search and auction-related runtime.
- `src/world/`: world-level systems.

## Modules and customization

- `modules/README.md`: module posture and expansion-era placement guidance.
- `modules/init.txt`: module loading entry point.
- `modules/custom/`: project-specific customizations.
- `modules/example/`: minimal module patterns worth copying before editing core files.

## Lua gameplay behavior

- `scripts/globals/`: shared Lua utilities, job helpers, interaction helpers, spell helpers, and reusable globals.
- `scripts/mixins/`: reusable mob and NPC behavior.
- `src/map/lua/`: C++ to Lua bindings and lookup functions.
- `scripts/tests/` and `scripts/specs/`: gameplay and packet test surfaces.

## Quests, missions, interactions, and battlefields

- `scripts/quests/`
- `scripts/missions/`
- `scripts/globals/interaction/`
- `scripts/battlefields/`

## Mobs, zones, and entity lookup patterns

- `scripts/zones/<Zone>/`: zone-local NPCs, mobs, text, and `IDs.lua`.
- `scripts/actions/mobskills/`: mob skill behavior.
- `src/map/lua/luautils.cpp`: `GetFirstID`, `GetNPCByID`, and `GetMobByID`.
- Example lookup and helper usage:
  - `modules/custom/lua/custom_HNM_system.lua`
  - `scripts/missions/**` files using `npcUtil`
  - `scripts/mixins/**` for reusable mob behavior

## SQL and content data

- `sql/`: database content and backups.
- `modules/*/sql/`: module-scoped data changes.
- `tools/migrations/`: schema and character-data migration history.

## Build and tooling

- `CMakeLists.txt`: build entry point.
- `tools/README.md`: dbtool, migrations, formatting, and operational scripts.
- `tools/dbtool.py`: database backup, update, and migration path.
- `tools/ci/`: sanity checks and CI helpers.
- `tools/headlessxi/`: packet and client tooling for deeper investigations.

## Client vs server boundary

- `grounding.md`: standing DAT boundary rules.
- `docs/knowledge/client-dat-boundary.md`: project-specific notes on what is server-enforced vs client-side.
- If a DAT or UI problem cannot be traced to repo code, document it as a client-side track rather than forcing a server explanation.

## Content completeness and status

- `docs/knowledge/content-status.md`: project summary and unknowns.
- `documentation/`: project-specific notes already present in repo.
- `modules/abyssea`, `modules/cop`, `modules/rov`, `modules/soa`, `modules/toau`, `modules/wotg`: expansion-specific customizations that may affect content completeness.
