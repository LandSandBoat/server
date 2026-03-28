# Bastok Missions Rank 7-10

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Bastok_Missions
- Codebase: `scripts/missions/bastok/7_1_The_Final_Image.lua` through `9_2_Where_Two_Paths_Converge.lua`
- Battlefields: `scripts/battlefields/Waughroon_Shrine/on_my_way.lua`, `scripts/battlefields/Throne_Room/where_two_paths_converge.lua`

## Summary
All six Rank 7-10 missions have full implementations with proper mission flow, NPC interactions, cutscenes, NM spawns, battlefield scripts, and rewards. The 9-2 battlefield is missing `allowTrusts = true`, which means players cannot summon Trust NPCs in that fight -- this is a notable difficulty spike for a small server. Otherwise these missions appear complete and functional.

## Checklist

### Rank 7

| Item | Status | Notes |
|------|--------|-------|
| 7-1: The Final Image | WORKS | Accept from gate guard, talk to Cid (Metalworks event 763), travel to Ro'Maeve, find roaming ???(qm2), fight 2x Mokkurkalfi (NMs in mob_spawn_points, mob_pools, IDs.lua all present), obtain Reinforced Cermet KI, return to Cid (event 764). Reward: 700 rank points. Additional NPC flavor text from Cleades, Rashid, Malduc, Argus. |
| 7-1: Mokkurkalfi NMs | WORKS | Mob pool 2717, family Golem-Mokkurkalfi (500), spawn point in Ro'Maeve at ~(104,-4,-115). Mob script exists at `scripts/zones/RoMaeve/mobs/Mokkurkalfi.lua`. Two spawned via `npcUtil.popFromQM`. |
| 7-2: On My Way | WORKS | Accept from gate guard, briefing from Karst (Metalworks event 765), talk to Hilda (Port Bastok event 255), BCNM at Waughroon Shrine vs 4 Quadav NMs, win grants Letter from Werei KI, return to Karst (event 766). Reward: Rank 8 + 60,000 gil. Post-mission Gumbah letter delivery and optional Cornelia CS handled. |
| 7-2: BCNM (On My Way) | WORKS | Battlefield script fully implemented. 6 players max, level 75 cap, 30 min, Trusts allowed. 4 Quadav mobs per instance (Ku'Jhu Graniteskin + 3 others), 3 battlefield areas. Mob spawn points confirmed in SQL. `allDeath` triggers win. |

### Rank 8

| Item | Status | Notes |
|------|--------|-------|
| 8-1: The Chains That Bind Us | WORKS | Accept from gate guard, briefing from Iron Eater (Metalworks event 767). Travel to Quicksand Caves Map 7, interact with qm6 to spawn 3 Antica NMs (Centurio IV-VII WAR, Triarius IV-XIV BLM, Princeps IV-XLV PLD). All 3 mobs in mob_pools and spawn_points at level 70. Defeat all 3, check qm6 for Zeid cutscene (event 11), navigate to Map 5 qm4 for second Zeid cutscene (event 10). Return to Iron Eater (event 768). Reward: 1133 rank points. |
| 8-1: Antica NMs | WORKS | All 3 NMs defined in mob_pools (IDs 672, 3999, 3193), mob_groups, and mob_spawn_points in zone 208 (Quicksand Caves). Level 70, manageable with Trusts at 99+. |
| 8-2: Enter the Talekeeper | WORKS | Accept from gate guard, briefing from Drake Fang in Zeruhn Mines (event 202). Travel to Kuftal Tunnel, check qm5 (event 12) to begin, check qm6 to spawn 3 Ghost NMs (Gordov's, Dervo's, Gizerl's Ghost). All at level 68 with spawn points confirmed. Kill all 3, check qm6 for cutscene (event 13) and Old Piece of Wood KI. Return to Drake Fang (event 204), auto-teleport to Bastok Mines (event 176) for completion. Reward: Rank 9 + 80,000 gil. Post-mission optional cutscenes from Detzo, Gumbah, Pavvke, Iron Eater. |
| 8-2: Ghost NMs | WORKS | Gordov's Ghost (pool 1763), Dervo's Ghost (pool 1003), Gizerl's Ghost (pool 1609). All level 68. Spawn points in Kuftal Tunnel zone 174. Referenced via `TALEKEEPER_OFFSET` in IDs.lua. |

### Rank 9

| Item | Status | Notes |
|------|--------|-------|
| 9-1: The Salt of the Earth | WORKS | Accept from gate guard, briefing from Alois (Metalworks event 773), travel to Rabao and speak to Dancing Wolf (events 102-105). Go to Gustav Tunnel qm2 to spawn Gigaplasm. Division mechanic fully implemented: Gigaplasm splits into 2 Macroplasm, each splits into 2 Microplasm, each splits into 2 Nanoplasm (15 total mobs confirmed in mob_spawn_points). Kill all Nanoplasm, get Miraclesalt KI from qm2, return to Dancing Wolf, then Alois (event 776). Reward: 1500 rank points. Post-mission optional Franziska/Cornelia cutscenes (events 777, 779). |
| 9-1: Gigaplasm + splits | WORKS | Gigaplasm (pool 1550) at level 70, plus 2 Macroplasm, 4 Microplasm, 8 Nanoplasm = 15 total mobs in spawn_points. Split scripts in `mobs/Macroplasm.lua` and `mobs/Microplasm.lua`. `isPlasmsAlive()` checks all 15 mob IDs. |
| 9-2: Where Two Paths Converge | PARTIAL | Accept from gate guard, briefing from Iron Eater (Metalworks event 780). Travel to Throne Room for BCNM. Two-phase Zeid fight: Phase 1 Zeid is unkillable, at <70% HP triggers phase transition (event 32004). Phase 2 spawns Zeid_2 with preserved HP%, Volker ally joins, 2x Shadow of Rage spawned. Shadow of Rage immune to sleep, respawns after 60s. Volker death = battlefield loss. Killing Zeid_2 = win. Return to Iron Eater (event 782). Reward: Rank 10 + 100,000 gil + Hero Among Heroes title + Bastokan Flag item. Flag delivery fallback if inventory full. |
| 9-2: BCNM mechanics | PARTIAL | Battlefield script is sophisticated with phase transition, Volker helper NPC (uses helper_npc mixin), Shadow of Rage TP chain mechanic. All mob spawn points confirmed (Zeid, Zeid_2, Shadow_of_Rage in 3 areas). **However: `allowTrusts` is NOT set (defaults to false).** Level 75 cap, 6 players max. On a 4-player server without Trusts this fight will be significantly harder than intended for modern play. |

## Key Items Verified
| Key Item | Enum Value | Used In |
|----------|------------|---------|
| REINFORCED_CERMET | 289 | 7-1 |
| LETTER_FROM_WEREI | 290 | 7-2 |
| OLD_PIECE_OF_WOOD | 293 | 8-2 |
| MIRACLESALT | 477 | 9-1 |
| BASTOKAN_FLAG (item) | 182 | 9-2 reward |

## Blockers
- **9-2 Missing Trust Support**: The `where_two_paths_converge.lua` battlefield does NOT have `allowTrusts = true`. The 7-2 battlefield (On My Way) does allow Trusts. For a small private server (max 4 players), the 9-2 fight with level 75 cap, two-phase Zeid, Volker keep-alive mechanic, and sleep-immune Shadow of Rage adds could be very challenging without Trusts. This may need to be added.

## Fix Difficulty
- Easy -- Adding `allowTrusts = true` to the 9-2 battlefield definition is a one-line change in `scripts/battlefields/Throne_Room/where_two_paths_converge.lua`.
