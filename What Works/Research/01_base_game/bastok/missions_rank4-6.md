# Bastok Missions Rank 4-6

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Bastok_Missions
- Codebase:
  - `scripts/missions/bastok/4_1_Magicite.lua`
  - `scripts/missions/bastok/5_1_Darkness_Rising.lua`
  - `scripts/missions/bastok/5_2_Xarcabard_Land_of_Truths.lua`
  - `scripts/missions/bastok/6_1_Return_of_the_Talekeeper.lua`
  - `scripts/missions/bastok/6_2_The_Pirates_Cove.lua`
  - `scripts/battlefields/QuBia_Arena/rank_5_mission.lua`
  - `scripts/battlefields/Throne_Room/shadow_lord_battle.lua`

## Summary
All five Bastok Rank 4-6 missions have full, non-stub implementations with proper NPC interactions, cutscenes, battlefield scripts, key item handling, and mission progression logic. All referenced NPCs exist in npc_list.sql and all mobs exist in mob_spawn_points.sql. Both battlefields (Rank 5 BCNM and Shadow Lord) are fully scripted with mob groups and win conditions.

## Checklist

### Mission 4-1: Magicite
| Item | Status | Notes |
|------|--------|-------|
| Start (Ru'Lude Gardens Embassy _6r2) | WORKS | NPC exists (17772683), event 129 begins mission, grants Archducal Audience Permit |
| Goggehn dialogue | WORKS | NPC exists (17772547), rank point check implemented |
| Audience Chamber (_6r9) cutscene | WORKS | NPC exists (17772690), event 128 gives Letter to Aldo |
| Aldo in Lower Jeuno | WORKS | NPC exists (17293777), event 152 gives Silver Bell |
| Paya-Sabya in Upper Jeuno | WORKS | NPC exists (17776672), Yagudo Torch hint CS |
| Muckvix in Lower Jeuno | WORKS | NPC exists (17780761), gives Yagudo Torch KI |
| Magicite (Orastone) in Altar Room | WORKS | NPC exists, event 44 grants KI, Lion CS for last magicite |
| Magicite (Optistone) in Monastic Cavern | WORKS | NPC exists, event 0 grants KI |
| Magicite (Aurastone) in Qu'lun Dome | WORKS | NPC exists, event 0 grants KI |
| Turn-in at Ru'Lude Gardens | WORKS | Event 60 removes all 3 magicites, grants Airship Pass (or 20k gil if already owned) |
| Completion via Goggehn | WORKS | Event 35 completes mission, awards Rank 5 + 10,000 gil |

### Mission 5-1: Darkness Rising
| Item | Status | Notes |
|------|--------|-------|
| Mission offer (Naji in Metalworks) | WORKS | NPC exists (17379796), event 720 starts mission, gives New Fei'Yin Seal |
| Accept from gate guards (Cleades/Rashid/Malduc/Argus) | WORKS | All NPCs exist, event 1001 handler for deferred accept |
| Fei'Yin zone-in cutscene | WORKS | Event 1 on zone-in when status == 10 |
| Qu'Bia Arena battlefield (Rank 5 Mission) | WORKS | Battlefield ID 512, level cap 50, 30 min, 6 players, trusts allowed |
| Archlich Taber'quoan + adds | WORKS | Mobs exist (17620993+), 3 arena copies with sorcerer/warrior adds |
| Burnt Seal KI after win | WORKS | Event 32001 checks battlefieldWin, grants Burnt Seal, removes New Fei'Yin Seal |
| Turn-in to Naji | WORKS | Event 722 completes mission, awards 600 rank points |

### Mission 5-2: Xarcabard, Land of Truths
| Item | Status | Notes |
|------|--------|-------|
| Accept from gate guards | WORKS | Event 1001 handler in all 4 Bastok zones |
| Karst in Metalworks | WORKS | NPC exists (17748010), event 602 advances to status 2 |
| Throne Room entry (_4l1) | WORKS | NPC exists (17453301), event 6 advances to status 3 |
| Shadow Lord battlefield | WORKS | Battlefield scripted with 2 phases (Phase 1 + Phase 2 Shadow Lord), 6 mobs total, level cap 75, trusts allowed |
| Shadow Lord mobs | WORKS | Phase 1 (17453057-59) and Phase 2 (17453060-62) exist in mob_spawn_points |
| Post-battle cutscene (event 7) | WORKS | Grants Shadow Fragment KI, teleports to zone 161, sets status 4 |
| Zilart mission unlock | WORKS | Adds ZM "The New Frontier" if not already started/completed |
| Turn-in at Metalworks (_6ld) | WORKS | NPC exists (17748054), event 603 completes mission, removes Shadow Fragment |
| Reward | WORKS | Rank 6 + 20,000 gil |
| Pavvke post-completion CS | WORKS | One-time important event in Bastok Mines after 5-2 completion (before 6-1) |

### Mission 6-1: Return of the Talekeeper
| Item | Status | Notes |
|------|--------|-------|
| Accept from gate guards | WORKS | Event 1001 handler in all 4 Bastok zones |
| Medicine Eagle in Bastok Mines | WORKS | NPC exists (17735695), event 180 starts the investigation |
| Drake Fang in Zeruhn Mines | WORKS | NPC exists (17481823), event 200 advances to status 2 |
| Western Altepa Desert qm2 trigger | WORKS | Spawns Eastern Sphinx + Western Sphinx NMs |
| Eastern Sphinx mob | WORKS | Exists (17289654), onMobDeath tracks kill |
| Western Sphinx mob | WORKS | Exists (17289655), onMobDeath tracks kill |
| Altepa Moonpebble KI | WORKS | Granted after both sphinxes defeated via qm2 re-trigger |
| Tall Mountain turn-in | WORKS | NPC exists (17735721), event 182 completes mission, removes Moonpebble |
| Reward | WORKS | 650 rank points |

### Mission 6-2: The Pirate's Cove
| Item | Status | Notes |
|------|--------|-------|
| Accept from gate guards | WORKS | Event 1001 handler in all 4 Bastok zones |
| Naji in Metalworks (start) | WORKS | Event 761 advances to status 1 |
| Gilgamesh in Norg (first visit) | WORKS | NPC exists (17809411), event 98 advances to status 2 |
| Ifrit's Cauldron qm4 NM spawn | WORKS | Trades Chunk of Adaman Ore, spawns Salamander (17616897) + Magma (17616898) |
| Frag Rock drop | WORKS | Item defined (ID 1160), dropped by Pirate's Cove NMs |
| Gilgamesh trade (Frag Rock) | WORKS | Event 99 consumes Frag Rock, advances to status 3 |
| Naji turn-in (completion) | WORKS | Event 762 completes mission |
| Reward | WORKS | Rank 7 + 40,000 gil |

## Blockers
- None identified. All missions appear fully implemented.

## Fix Difficulty
- N/A (no fixes needed)
