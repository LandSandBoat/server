# Server Implementation Audit — Executive Summary

Phase 1 completed 2026-03-27 (22 files). Phase 2 completed 2026-03-28 (25 files). Total: 47 research files.

## Overall Status

| Content Area | Status | Details |
|-------------|--------|---------|
| **Core Combat** | WORKS | All 15 subsystems, 208 WS, 342 abilities, 588 effects |
| **Core Transport** | WORKS | All 16 methods functional |
| **Core Jobs (22)** | WORKS/PARTIAL | All unlock quests work. PLD SP2 missing, GEO missing 4 abilities |
| **Trusts** | PARTIAL | 120 scripts, only 49 have AI. No iLvl scaling |
| **Mog House** | PARTIAL | Mog Garden STUB, Mog Sack 0 slots |
| **San d'Oria Missions** | WORKS | All ranks 1-10, all BCNMs |
| **Bastok Missions** | WORKS | All ranks 1-10 (9-2 trusts fixed) |
| **Windurst Missions** | WORKS | All ranks 1-10 |
| **Zilart Missions** | WORKS | All 17 missions, Ark Angels, Divine Might, Celestial Nexus |
| **COP Missions** | WORKS | All 31 missions, 9 battlefields, Sea zones |
| **ToAU Missions** | WORKS | All 48 missions including Alexander |
| **ToAU Content** | PARTIAL | Nyzul/Einherjar WORKS. Assault 9/50. Besieged MISSING |
| **WotG Missions** | PARTIAL | 54 scripts, ~8 battlefields incomplete |
| **WotG Content** | MISSING | Campaign battles AND ops not implemented |
| **Abyssea** | PARTIAL | 172 NMs (28 w/AI), 69/149 atma empty, Fabricant stub |
| **SoA Missions** | WORKS | 105 scripts across all chapters |
| **SoA Content** | MISSING | Coalitions stub, Skirmish/Delve missing |
| **ROV Missions** | PARTIAL | 93 scripts, 5 boss battles stubbed |
| **Endgame (Classic)** | WORKS | Dynamis, Limbus, Job Points |
| **Endgame (Modern)** | MISSING | Odyssey, Omen, Domain Invasion, Geas Fete, Master Levels |

---

## What Works Great (no action needed)

- All nation missions rank 1-10 (27 missions x 3 nations)
- Zilart missions 1-17 with full boss fights
- COP missions 1-8 with all battlefields and Sea access
- ToAU missions 1-48
- All transport systems
- Core combat (melee, magic, skillchains, pets, enmity)
- All 22 job unlocks accessible
- Nyzul Isle Investigation
- Einherjar
- Dynamis (original 10 zones)
- Limbus
- Job Points system
- Rhapsody KI bonuses
- Home points, survival guides, unity warps, waypoints

## What Partially Works (usable but gaps)

- **Trusts** — 49/120 have AI, rest auto-attack only
- **Abyssea** — NMs spawn but most lack custom AI, many atma give no stats
- **ROV** — completable but 5 boss fights auto-complete
- **WotG missions** — ~8 need battlefield wiring
- **Assault** — only 9 of 50 scenarios
- **SoA zones** — mobs exist via DB but minimal Lua scripts
- **Ambuscade** — framework exists, no monthly rotation
- **Unity** — warps/shops work, no Wanted NMs

## What's Missing (major gaps)

| System | Effort | Impact |
|--------|--------|--------|
| Campaign Battles | Massive | WotG main content loop, no Allied Notes earning |
| Campaign Ops | Large | 100+ ops, nation-specific |
| Besieged | Massive | ToAU city defense system |
| Coalitions (SoA) | Large | All 6 stuck at rank 0 |
| Skirmish | Large | SoA endgame content |
| Delve | Large | SoA endgame content |
| Odyssey/Sheol | Massive | Modern endgame, no code exists |
| Omen | Large | Modern endgame, empty zone |
| Domain Invasion | Medium | Daily Escha content |
| Geas Fete | Large | Escha NM system, SQL data exists but no pop system |
| Master Levels | Large | Post-99 progression |
| Voidwatch | Large | In progress (see VOIDWATCH_TODO.md) |
| Mog Garden | Massive | Tutorial/gathering/rearing all missing |
| Dynamis Divergence | Large | Empty zone shells only |
| Vagary | Medium | No code exists |

## Quick Wins (easy fixes found during audit)

| Fix | File | Status |
|-----|------|--------|
| Bastok 9-2 allow trusts | `battlefields/Throne_Room/where_two_paths_converge.lua` | FIXED |
| Phomiuna gate silent fail | `zones/Phomiuna_Aqueducts/npcs/_ir9.lua` | FIXED |
| Mog Sack 0 slots | `sql/char_storage.sql` or GM command | TODO |
| Acuex mob family for Sylvie ROE | `scripts/globals/roe_records.lua` record 3690 | FIXED |
| ROV ROE records 1417-1425 | `scripts/globals/roe_records.lua` | ADDED |
| Vanadversary ROE (27 records) | `scripts/globals/roe_records.lua` | ADDED |
| 4 new ROE trigger types | `src/map/roe.h` + Lua + C++ hook points | ADDED |
| SoA imprimaturGate | `scripts/missions/soa/helpers.lua` | FIXED |
| Scintillating Rhapsody KI | `scripts/missions/rov/3_34_The_Orbs_Radiance.lua` | FIXED |
| RUN AF armor 78 mods | `sql/item_mods.sql` (Futhark set) | FIXED |
| Einherjar enabled | `settings/default/main.lua` | FIXED |
| toau pre-RMT drops | `modules/init.txt` | FIXED |
| Salvage Remnants Permit | `zones/Aht_Urhgan_Whitegate/npcs/Zasshal.lua` | FIXED |

## Phase 2 Findings (Step-by-Step Verification)

### Player Progression (verified lv1-119)
- Lv1-99: All limit breaks, FoV/GoV, sub-job, AF quests verified
- Lv99-119: **ALL iLvl 119 gear paths broken** (Monisette/Oboro/Ambuscade/Unity/Escha)

### Quest Coverage
| Area | Scripts | Total | Rate |
|------|---------|-------|------|
| San d'Oria | 77 | 82 | 93.9% |
| Bastok | 78 | 94 | 83.0% |
| Windurst | 85 | 92 | 92.4% |
| Jeuno | 100 | 140 | 71.4% |
| Aht Urhgan | 46 | 75 | 61.3% |
| Crystal War | 30 | 98 | 30.6% |
| Adoulin | 14 | 96 | 14.6% |
| Other Areas | 204 | 482 | 42.3% |

### AF Armor by Job
- 11 jobs fully complete (WAR/MNK/WHM/RDM/THF/DRK/BST/SAM/NIN/BLU/DNC)
- 8 jobs partial (BLM/PLD/RNG/DRG/BRD/SMN/COR/SCH — missing 1-2 quests)
- 3 jobs completely missing (PUP/RUN/GEO)

### Zone Accessibility
- All base game zones reachable without GM commands
- All expansion zones reachable except Reisenjima (needs !pos)
- Garlaige banishing gates modified for solo play

### Gear/Upgrade Pipeline
- Sagheera, Switchstix, Magian Trials: WORKS
- Monisette (iLvl 109/119 armor): MISSING — **#1 priority fix**
- Oboro (REMA weapons to 119): MISSING
- 71 AF/Relic/Empyrean +3 pieces have zero mods
- 1,105 iLvl 119 items missing mods (upstream gap)

### Key Broken Systems (Phase 1 corrections)
- Limbus: BROKEN (Swirling Vortex entry commented out) — Phase 1 said WORKS, was wrong

## Recommendations for a 4-Player Server

1. **#1 Priority**: Implement Monisette — unlocks iLvl 109/119 armor for all 22 jobs
2. **#2 Priority**: Implement Oboro — unlocks REMA weapon upgrades to 119
3. **High value**: Fill 69 empty atma mods, add AI to key trusts, wire up WotG battlefields
4. **Medium value**: Fix Limbus entry, add RUN/GEO/PUP AF quests, fix 71 +3 armor mods
5. **Continue**: Voidwatch (in progress), ROV boss battles
6. **Don't worry about**: Campaign, Besieged, Odyssey, Master Levels — designed for large populations
7. **Consider**: `UNLOCK_OUTPOST_WARPS=1`, increase Mog Sack slots, seed AH with common items
