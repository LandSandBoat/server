# Endgame Systems Audit

## Source
- Codebase: scripts/globals/, scripts/zones/, src/map/, sql/zone_settings.sql

## Summary
Most modern retail endgame systems (Odyssey, Dynamis Divergence, Omen, Domain Invasion, Geas Fete, Master Levels, Vagary) are either missing or empty stubs. Ambuscade has a partial framework. Original Dynamis and Limbus are the most complete endgame content. Unity and Job Points have working infrastructure.

## Checklist

| System | EXISTS | Status | Notes |
|--------|--------|--------|-------|
| Ambuscade | Yes | PARTIAL | `scripts/globals/ambuscade.lua` has NPC menus (Gorpa-Masorpa, Ambuscade Tome), hallmark/gallantry currency tracking, instance creation via `scripts/zones/Maquette_Abdhaljs-Legion_B/instances/ambuscade.lua`. Instance spawns mobs and awards currency on completion. However: reward shop menus stub out (updateEvent all zeros), difficulty selection is TODO, no monthly rotation system, only one hardcoded fight (Intense VE only). Regular Ambuscade hidden. |
| Odyssey/Sheol | No | MISSING | No zone directories for Sheol A/B/C. No entries in zone_settings.sql. Only one stray reference to "odyssey" in `scripts/globals/quests.lua` (quest name string). No Odyssey system code exists. |
| Dynamis Divergence | Partial | STUB | Four [D] zone directories exist: `Dynamis-Bastok_[D]`, `Dynamis-Jeuno_[D]`, `Dynamis-San_dOria_[D]`, `Dynamis-Windurst_[D]`. Each has only Zone.lua and IDs.lua -- no mob scripts, no NPC scripts, no instance logic. Zone.lua handles entry/exit positioning only. Completely non-functional as content. |
| Omen | No | MISSING | `Reisenjima_Henge` zone exists (zone 292) with a bare Zone.lua (all handlers empty, spawn position commented out). No Omen system code, no NPC scripts, no mob scripts, no instance logic. The only "omen" hit in scripts is the unrelated BCNM "Omens" in Navukgo Execution Chamber. |
| Unity System | Yes | PARTIAL | `scripts/globals/unity.lua` implements: leader selection, accolade currency, unity warps (56 destinations), item shop (13 items). Working: join/change unity, accolade spending, warps. Missing: Unity Wanted battles (no "wanted" references), Unity NM system, ranking-based rewards, monthly ranking competition. Warp access was previously fixed to force rank=1 in packet 0x061. |
| Domain Invasion | No | MISSING | No "domain_invasion" references anywhere in scripts/ or src/. Only an autotranslate string entry. No system implementation at all. |
| Geas Fete | No | MISSING | No "geas_fete" or "geas fete" references in scripts. Escha zones exist (Escha-Zi'Tah zone 288, Escha-Ru'Aun zone 289) with portals and basic zone scripts, but only 2 mob scripts in Escha-Ru'Aun (Eschan_Gargouille, Eschan_Ilaern) and zero in Escha-Zi'Tah. No Geas Fete NM pop system, no tribulens currency, no NM fights. |
| Master Levels | No | MISSING | Only autotranslate string references and TODO comments in packets (0x0c9, 0x119). No master level system, no ML exp gain, no ML cap raise mechanics. Completely unimplemented. |
| Job Points | Yes | WORKS | Full C++ implementation: `src/map/job_points.cpp`, `src/map/job_points.h` with all 22 job categories defined. Packet handlers for spending (0x0bf) and display (0x08d, 0x063). Modifier integration in battleutils, charutils, petutils, blueutils, trait system. Appears to be a working system for spending capacity points on job-specific bonuses. |
| Dynamis (Original) | Yes | WORKS | `scripts/globals/dynamis.lua` fully implements entry system for all 10 zones: San d'Oria, Bastok, Windurst, Jeuno, Beaucedine, Xarcabard, Valkurm, Buburimu, Qufim, Tavnazia. Each zone directory has extensive mob scripts (dozens of named NMs, Vanguard mobs, Hydra mobs), NPC scripts (Somnial Threshold, QMs), and zone scripts. Entry requirements, win tracking, key items all implemented. Most complete endgame system. |
| Limbus | Yes | WORKS | Both Temenos and Apollyon zone directories have extensive content: ~80+ mob scripts in Temenos (Proto-Ultima, elementals, beastmen), ~30+ in Apollyon (Proto-Omega, beastmen, NMs). Battlefield framework in `scripts/globals/battlefield.lua` has dedicated Limbus battlefield functions. Entry NPCs, scanning devices, sentinel columns present. |
| Vagary | No | MISSING | Only one "vagary" reference in `scripts/globals/dealer_moogle.lua` (likely a reward item reference). No Vagary system, no zone, no battlefield implementation. |

## Blockers
- Ambuscade: No monthly rotation, reward shops non-functional, only one difficulty works
- Odyssey: Entire system missing; would be a massive implementation effort
- Dynamis Divergence: Zone shells exist but zero content inside them
- Omen: Zone exists but completely empty
- Domain Invasion: No implementation at all
- Geas Fete: Escha zones exist but NM pop system is missing
- Master Levels: Would require significant C++ work for exp system changes

## Fix Difficulty
| System | Difficulty | Notes |
|--------|-----------|-------|
| Ambuscade | Medium | Framework exists, needs fight content and shop logic |
| Odyssey/Sheol | Massive | Nothing exists, complex instanced content |
| Dynamis Divergence | Massive | Zone shells only, needs full mob/NM/wave system |
| Omen | Massive | Empty zone, complex boss/card system |
| Unity Wanted | Medium | Unity base works, need to add NM spawns |
| Domain Invasion | Hard | No framework, needs scheduling + NM waves |
| Geas Fete | Hard | Zones exist, needs NM pop/tribulens system |
| Master Levels | Hard | Core C++ changes to exp system |
| Job Points | N/A | Already working |
| Dynamis (Original) | N/A | Already working |
| Limbus | N/A | Already working |
| Vagary | Massive | Nothing exists |
