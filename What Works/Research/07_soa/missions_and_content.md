# Seekers of Adoulin -- Missions and Content Systems

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Seekers_of_Adoulin_Missions
- Codebase:
  - `scripts/missions/soa/` -- 106 files (105 mission scripts + helpers.lua)
  - `scripts/globals/colonization_reives.lua` -- reive system logic
  - `scripts/globals/colonization_reive_data.lua` -- reive zone data (14 zones)
  - `scripts/globals/waypoint.lua` -- Adoulin waypoint teleport system (355 lines)
  - `scripts/zones/Western_Adoulin/npcs/` -- 46 NPC scripts
  - `scripts/zones/Eastern_Adoulin/npcs/` -- 13 NPC scripts
  - `scripts/quests/adoulin/` -- 14 quest scripts
  - `scripts/missions/soa/helpers.lua` -- imprimatur gate helper + minigame logic
  - `sql/zone_settings.sql` -- zones 256-282 (Adoulin/Ulbuka)
  - `sql/char_points.sql` -- bayld column exists
  - `src/map/packets/s2c/0x118_currencies_2.cpp` -- bayld packet support
  - `settings/default/main.lua` -- ENABLE_SOA = 1, BAYLD_RATE = 1.0

## Summary
SoA missions have extensive script coverage (105 scripts for ~110 retail missions). Adoulin zones are accessible from Jeuno via waypoint. Colonization reives are the most complete SoA system with full spawn/despawn logic across 14 zones. Coalitions, skirmish, and delve are NOT implemented. Bayld currency is earned from quests and reives but spending options are minimal.

## Checklist

### 1. SoA Missions
| Item | Status | Notes |
|------|--------|-------|
| Mission scripts exist | WORKS | 105 scripts covering all 5 chapters + epilogue |
| Chapter 1 (8 missions) | WORKS | All 8 scripted: Rumors from the West through Arciela Appears Again |
| Chapter 2 (19 missions) | WORKS | All 19 scripted: Budding Prospects through Yggdrasil |
| Chapter 3 (24 missions) | WORKS | All 24 scripted: Return of the Exorcist through Glimmer of Portent |
| Chapter 4 (39 missions) | WORKS | All 39 scripted: Into the Fire through Royal Blessings |
| Chapter 5 (15 missions) | WORKS | All 15 scripted: Arboreal Rumors through The Light Within |
| Auto-complete/skip flags | PARTIAL | Only 2 files reference skip/auto_complete (1_1 and 1_2). Most missions appear to be properly scripted with cutscene events and progression checks |
| Smallest scripts (~37-39 lines) | PARTIAL | Some missions are quite small (e.g., Blood_for_Blood at 37 lines) which may indicate simplified implementations vs. retail, but they still contain proper mission framework code |
| Helpers/minigame (3-4, 3-5) | WORKS | helpers.lua has shot history minigame logic for mission 3-4/3-5 |

### 2. Adoulin Zone Access
| Item | Status | Notes |
|------|--------|-------|
| Western Adoulin (256) | WORKS | Zone in DB, 46 NPC scripts, home points, waypoints, AH |
| Eastern Adoulin (257) | WORKS | Zone in DB, 13 NPC scripts, home points, survival guide, waypoints |
| Path from Jeuno | WORKS | Mission 1-1 starts at Darcia in Lower Jeuno. Mission 1-3 (Onward to Adoulin) uses waypoint in Lower Jeuno to transport to Ceizak Battlegrounds. Waypoint system (355 lines) handles Adoulin transport |
| RUN/GEO unlock access | WORKS | Players can reach Adoulin via mission 1-3 waypoint. RUN/GEO unlock quests in Western Adoulin should be accessible once player arrives |
| Rala Waterways (258) | WORKS | Zone in DB, used in several missions |

### 3. Ulbuka Wilderness Zones
| Item | Status | Notes |
|------|--------|-------|
| Ceizak Battlegrounds (261) | PARTIAL | Zone exists, 230 mob spawn points in DB, 4 mob scripts (Knotted_Root, Transcendent_Scorpion, Mastop, Unfettered_Twitherym). Most mobs use pooled AI, only special mobs need scripts |
| Yahse Hunting Grounds (260) | PARTIAL | Zone exists, only 1 mob script (Knotted_Root = reive obstacle) |
| Foret de Hennetiel (262) | PARTIAL | Zone exists, 1 mob script (Broadleaf_Palm = reive obstacle) |
| Yorcia Weald (263) | PARTIAL | Zone exists, 1 mob script (Gnarled_Rampart = reive obstacle) |
| Morimar Basalt Fields (265) | PARTIAL | Zone exists, 1 mob script (Bedrock_Crag = reive obstacle) |
| Marjami Ravine (266) | PARTIAL | Zone exists, 1 mob script (Monolithic_Boulder = reive obstacle) |
| Kamihr Drifts (267) | PARTIAL | Zone exists, 2 mob scripts (Icy_Palisade = reive, Slobbering_Ruszor = NM) |
| Gate zones (Sih/Moh/Dho/Woh) | PARTIAL | All exist in zone_settings. Each has Knotted_Root reive mob script |
| Outer Ra'Kaznar (274) | PARTIAL | Zone exists, 1 mob script (Amaranth_Barrier = reive) |
| Ra'Kaznar Inner Court | PARTIAL | Zone exists, 1 mob script (Heliotrope_Barrier = reive) |
| Mob spawn points total | PARTIAL | ~1,803 spawn points across 7 main wilderness zones (261+260+262+263+265+266+267). Mobs spawn but most only have DB-defined behavior (no special scripts for regular mobs) |

### 4. Colonization/Reives
| Item | Status | Notes |
|------|--------|-------|
| Reive system framework | WORKS | Full implementation in `colonization_reives.lua` (200+ lines). Handles spawn/despawn, obstacle tracking, enable/disable per zone |
| Reive data (14 zones) | WORKS | `colonization_reive_data.lua` covers all Ulbuka zones: Ceizak, Yahse, Foret, Yorcia, Morimar, Marjami, Kamihr, Sih/Moh/Dho/Woh Gates, Outer Ra'Kaznar, Ra'Kaznar Inner Court, Cirdas Caverns |
| Reive obstacle mobs | WORKS | Each zone has scripted obstacles (Knotted_Root, Bedrock_Crag, etc.) using `xi.reives.onMobSpawn`/`onMobDeath` |
| Reive respawn timer | WORKS | 60-minute objective respawn, 5-minute mob respawn |
| Reive mark effect | WORKS | `scripts/effects/reive_mark.lua` exists |
| SOA gate check | WORKS | Reives only spawn if `ENABLE_SOA == 1` |
| Bayld rewards from reives | MISSING | No bayld reward logic found in reive scripts. Reives complete but may not grant bayld |

### 5. Coalitions
| Item | Status | Notes |
|------|--------|-------|
| Coalition system | STUB | `Iyvah_Halohm.lua` has TODO comments: all 6 coalition ranks hardcoded to 0 (Pioneers, Peacekeepers, Couriers, Scouts, Inventors, Mummers) |
| Imprimatur system | STUB | `helpers.lua` has `imprimaturGate()` but it is TODO -- imprimatursSpent hardcoded to 0, no DB pull |
| Coalition assignments | MISSING | No assignment quest scripts found. No coalition task/work order system |
| Coalition NPCs | PARTIAL | Some NPCs exist (Chanteillie gives Inventor's Pickaxe KI) but no functional assignment system |

### 6. Skirmish
| Item | Status | Notes |
|------|--------|-------|
| Skirmish content | MISSING | No skirmish implementation found. Only match was "Vanguard_Skirmisher" (Dynamis mob) and a Voidwatch quest name. No Skirmish instances, NPC triggers, or Alluvion Skirmish zones |

### 7. Delve
| Item | Status | Notes |
|------|--------|-------|
| Delve content | MISSING | No delve implementation. Only matches were "Delver" mob in Spire of Mea (CoP promyvion mob) and "Kuftal_Delver" (unrelated). No delve instances, plasm currency, or Naakual boss scripts |

### 8. Mog Garden
| Item | Status | Notes |
|------|--------|-------|
| Mog Garden | STUB | Previously documented in `00_core/mog_house.md`. Zone loads, Green Thumb Moogle opens mog menu + seed shop, Mog Dinghy transport works. No gathering NPCs, no tutorial quests, no monster rearing, no flotsam. Massive effort to implement |

### 9. Bayld Currency
| Item | Status | Notes |
|------|--------|-------|
| Bayld DB storage | WORKS | `char_points.sql` has `bayld` column |
| Bayld packet display | WORKS | `0x118_currencies_2.cpp` reads/sends bayld to client |
| Bayld earning (quests) | WORKS | `npc_util.lua` has bayld reward support with BAYLD_RATE multiplier. Multiple Adoulin quest NPCs grant bayld (Pagnelle 1000, Clautaire 500, Jorin 300, Westerly_Breeze 1000) |
| Bayld earning (reives) | MISSING | Reive scripts do not grant bayld on completion |
| Bayld earning (sparks exchange) | WORKS | Sparkshop has bayld exchange option (1000 bayld per exchange) |
| Bayld spending (gear) | PARTIAL | Sifa_Alani and Ujlei_Zelekko NPCs use `delCurrency('bayld')` -- at least 2 NPCs allow bayld purchases |
| BAYLD_RATE setting | WORKS | Default 1.0 multiplier in `settings/default/main.lua` |

## Blockers
- **Coalitions not implemented** -- All 6 coalition ranks are hardcoded to 0. No assignment/work order system exists. This blocks coalition-gated content and imprimatur accumulation.
- **Skirmish completely missing** -- No instances, no NPC triggers, no Alluvion Skirmish. Blocks Skirmish gear upgrades.
- **Delve completely missing** -- No delve instances, no plasm system, no Naakual bosses. Blocks Delve gear.
- **Reives do not grant bayld** -- Players must rely on quests or sparks exchange for bayld income, which is far more limited than retail.
- **Mog Garden is a stub** -- See `00_core/mog_house.md` for full details.

## Fix Difficulty
- SoA Missions: N/A (already substantially complete)
- Adoulin Zone Access: N/A (works)
- Colonization Reives: **Easy** to add bayld rewards to reive completion
- Coalitions: **Massive** -- needs full assignment system, rank tracking, imprimatur earning/spending, work order content for all 6 coalitions
- Skirmish: **Massive** -- needs instance system, entry NPCs, mob scripting, loot tables, Alluvion variant
- Delve: **Massive** -- needs instance system, plasm currency, Naakual boss AI, loot tables
- Mog Garden: **Massive** -- see mog_house.md
- Bayld spending: **Medium** -- more vendor NPCs need scripting for gear/item purchases
