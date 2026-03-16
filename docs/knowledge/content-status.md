# Content Status

Status: starter note
Last updated: 2026-03-15
Domains: documentation, lua-gameplay, sql-data, module-customization

## Purpose

Track known content coverage, project customizations, and unverified content areas over time.

## Inspected

- top-level content directories under `scripts/`
- `modules/`
- `documentation/`

## Confirmed

- `scripts/` includes broad content surfaces for actions, battlefields, commands, effects, items, missions, quests, tests, and zones.
- Expansion-oriented module folders exist for `cop`, `toau`, `wotg`, `abyssea`, `soa`, and `rov`.
- `modules/custom/` contains project-specific Lua, C++, and SQL overrides.
- `documentation/` contains at least some system-specific project notes, including Limbus-related documentation.

## Inferred

- This repo likely combines upstream LandSandBoat content with local era or customization modules rather than keeping all private-server behavior in core files.

## Unknown

- Actual completeness or correctness of any specific quest line, mission line, battlefield, job, or zone.
- Which modules are enabled in production and which are optional experiments.
- What content has been intentionally custom-balanced versus kept upstream-accurate.

## Risk

- Directory presence does not prove retail-accurate behavior or project readiness.

## Next Verification Step

- Build a per-system status sheet as tasks touch jobs, combat, items, quests, battlefields, zones, and packets.
