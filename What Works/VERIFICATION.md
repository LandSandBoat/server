# Research File Verification Status

The AF audit revealed that agents were checking `scripts/quests/` files only, missing quests implemented in zone NPC scripts. This file tracks which research files are RELIABLE vs need re-verification.

## Methodology Risk Categories

**LOW RISK** — findings based on checking actual code logic, SQL data, C++ systems, or zone scripts. Not affected by the quest-counting error.

**HIGH RISK** — findings based on counting files in `scripts/quests/` or similar directory scans. Quest counts are likely UNDERCOUNTED.

**VERIFIED** — re-checked with corrected methodology.

---

## File Status

### Phase 1 — Core Systems (LOW RISK — checked systems, not quest files)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| 00_core/combat.md | LOW | RELIABLE | Checked C++ systems + script counts |
| 00_core/transport.md | LOW | RELIABLE | Checked zone scripts + SQL |
| 00_core/trusts.md | LOW | RELIABLE | Counted trust spell scripts directly |
| 00_core/mog_house.md | LOW | RELIABLE | Checked NPC scripts + systems |
| 00_core/jobs/base_jobs.md | LOW | RELIABLE | Checked abilities/traits/SP |
| 00_core/jobs/advanced_jobs.md | LOW | RELIABLE | Checked unlock scripts directly |
| 00_core/jobs/expansion_jobs.md | LOW | RELIABLE | Checked unlock scripts directly |

### Phase 1 — Mission Audits (LOW RISK — checked mission scripts directly)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| 01_base_game/*/missions_rank*.md (6 files) | LOW | RELIABLE | Checked scripts/missions/ directly |
| 02_zilart/missions_zm*.md (2 files) | LOW | RELIABLE | Checked scripts/missions/rotz/ |
| 03_cop/missions_ch*.md (2 files) | LOW | RELIABLE | Checked scripts/missions/cop/ |
| 04_toau/missions_and_content.md | LOW | RELIABLE | Mission count reliable, content systems checked |
| 05_wotg/missions_and_content.md | LOW | RELIABLE | Mission scripts checked, campaign status reliable |
| 06_abyssea/access_and_content.md | LOW | RELIABLE | NM counts from mob data, not quest files |
| 07_soa/missions_and_content.md | LOW | RELIABLE | Mission scripts checked, imprimaturGate found |
| 08_rov/missions_all.md | LOW | RELIABLE | Every mission script read |
| 09_endgame/all_systems.md | LOW | RELIABLE | Checked systems/zones, not quest files |

### Phase 2 — Progression (LOW RISK — traced specific quest chains)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| progression/new_player_lv1-10.md | LOW | RELIABLE | Traced specific NPCs/systems |
| progression/leveling_10-30.md | LOW | RELIABLE | Traced specific quests step-by-step |
| progression/leveling_30-50.md | LOW | RELIABLE | Traced LB1, AF for WAR/WHM, job unlocks |
| progression/leveling_50-75.md | LOW | RELIABLE | Traced LB2-5 step-by-step |
| progression/leveling_75-99.md | LOW | RELIABLE | Traced LB6-10 step-by-step |
| progression/leveling_99-119.md | LOW | RELIABLE | Checked upgrade NPCs directly |

### Phase 2 — Quest Counts (HIGH RISK — used file counting)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| quests/sandoria_quests.md | HIGH | CORRECTED | 77/82 (93.9%), bugs re-verified |
| quests/bastok_quests.md | HIGH | CORRECTED | 80/93 (86.0%), Eco-Warrior recovered, Too Many Chefs bug found |
| quests/windurst_quests.md | HIGH | CORRECTED | 84/90 (93.3%), Nothing Matters NOT a blocker |
| quests/jeuno_quests.md | HIGH | CORRECTED | 115/145 (79.3%), 14 NPC quests recovered |
| quests/other_areas_quests.md | HIGH | CORRECTED | 52/67 (77.6%) |
| quests/expansion_quests.md | HIGH | CORRECTED | All 7 areas corrected with quests.lua counts |
| quests/af_armor_all_jobs.md | HIGH | CORRECTED | 18/22 complete (was 8/22) |
| quests/all_job_quest_chains.md | HIGH | CORRECTED | Updated with verified AF data |
| quests/af_partial_jobs_detailed.md | HIGH | CORRECTED | Only SCH + PUP have real gaps |

### Phase 2 — Deep Quest Logic (MIXED — checked logic but may have missed NPC-based quests)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| quests/sandoria_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only (56), missed NPC-based |
| quests/bastok_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only (78), missed NPC-based |
| quests/windurst_jeuno_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only, missed NPC-based |
| quests/toau_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only |
| quests/other_areas_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only |
| quests/outlands_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only |
| quests/crystal_war_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only |
| quests/adoulin_quests_deep.md | MEDIUM | CHECK | Verified converted scripts only |
| quests/abyssea_quests_deep.md | LOW | RELIABLE | Checked actual systems not quest files |
| quests/quest_flag_dependencies.md | LOW | RELIABLE | Traced actual code paths |
| quests/seasonal_events.md | LOW | RELIABLE | Checked event framework directly |

### Phase 2 — Zones, NMs, Gear, Crafting (LOW RISK — SQL/code based)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| zones/zone_accessibility.md | LOW | RELIABLE | Checked zonelines.sql |
| zones/zone_paths_detailed.md | LOW | RELIABLE | Checked NPC scripts directly |
| zones/expansion_zone_paths.md | LOW | RELIABLE | Traced access paths |
| zones/battlefield_access.md | LOW | RELIABLE | Found Limbus broken (real finding) |
| nms/nm_systems.md | LOW | RELIABLE | SQL-based checks |
| nms/nm_droplists_deep.md | LOW | RELIABLE | Checked actual droplists |
| nms/mob_spawns_key_zones.md | LOW | RELIABLE | Counted spawn points |
| nms/dynamis_content.md | LOW | RELIABLE | Checked zone scripts |
| nms/abyssea_nms_deep.md | LOW | RELIABLE | Checked NM scripts + pop system |
| nms/treasure_chests.md | LOW | RELIABLE | Checked framework code |
| nms/wrong_drops_audit.md | LOW | RELIABLE | SQL cross-reference |
| nms/drop_consistency_audit.md | LOW | RELIABLE | SQL cross-reference |
| gear/upgrade_paths.md | LOW | RELIABLE | Checked NPC scripts directly |
| gear/quest_reward_items.md | LOW | RELIABLE | Checked item_mods.sql directly |
| gear/common_gear_stats.md | LOW | RELIABLE | Checked item_mods.sql directly |
| gear/expansion_mission_rewards.md | LOW | RELIABLE | Checked item_mods.sql directly |
| gear/zero_mod_equipment.md | LOW | RELIABLE | SQL diff |
| crafting/crafting_system.md | LOW | RELIABLE | Checked guild scripts + DB |
| crafting/recipes_deep.md | LOW | RELIABLE | Checked synth_recipes.sql |
| npcs/vendors_and_currency.md | LOW | RELIABLE | Checked NPC scripts directly |
| npcs/misc_systems.md | LOW | RELIABLE | Checked system scripts |

### Phase 2 — Mission Step-by-Step (LOW RISK — read actual scripts)
| File | Risk | Status | Notes |
|------|------|--------|-------|
| zilart/missions_detailed.md | LOW | RELIABLE | Read every mission script |
| cop/missions_detailed.md | LOW | RELIABLE | Read every mission script |
| toau/missions_detailed.md | LOW | RELIABLE | Read every mission script |
| wotg/missions_detailed.md | LOW | RELIABLE | Read every mission script |
| soa/missions_detailed.md | LOW | RELIABLE | Read every mission script |
| rov/missions_detailed.md | LOW | RELIABLE | Read every mission script |
| toau/assault_detailed.md | LOW | RELIABLE | Checked battlefield scripts |

---

## Corrected Quest Counts (VERIFIED from quests.lua markers + agent re-verification)

| Area | Total | Implemented | Rate | Previous (wrong) |
|------|-------|-------------|------|-----------------|
| San d'Oria | 82 | 77 | 93.9% | 93.9% (same) |
| Bastok | 93 | 80 | 86.0% | 83.0% |
| Windurst | 90 | 84 | 93.3% | 92.4% |
| Jeuno | 145 | 115 | 79.3% | 71.4% |
| Other Areas | 67 | 52 | 77.6% | 42.3% |
| Outlands | 56 | 45 | 80.4% | 51.1% |
| Aht Urhgan | 72 | 50 | 69.4% | 61.3% |
| Crystal War | 95 | 37 | 38.9% | 30.6% |
| Abyssea | 192 | 49 | 25.5% | 31.6% |
| Adoulin | 97 | 18 | 18.6% | 14.6% |
| Coalition | 95 | 0 | 0.0% | 0.0% |
| **TOTAL** | **1,084** | **607** | **56.0%** | was 54.1% |

Note: Base game nations + Outlands are much healthier than originally reported (77-94%).
The gaps are in Abyssea (25.5%), Adoulin (18.6%), and Coalition (0%).

## Corrected AF Status

| Job | AF Status | Notes |
|-----|-----------|-------|
| WAR, MNK, WHM, THF, DRK, SAM, BLU, DNC | 5/5 or 3/3 | Complete |
| PLD, BLM, DRG, RNG, NIN, SMN, BRD, RDM, BST, COR | 5/5 or 3/3 | Complete (many via NPC scripts) |
| SCH | 2/3 | Missing Seeing Blood Red (head) |
| PUP | 2/3 | Missing Puppetmaster Blues (AF3) |
| GEO | 0/5 | Adoulin content not implemented |
| RUN | 0/5 | Adoulin content not implemented |
