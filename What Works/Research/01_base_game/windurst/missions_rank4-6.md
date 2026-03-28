# Windurst Missions Rank 4-6

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Windurst_Missions
- Codebase:
  - `scripts/missions/windurst/4_1_Magicite.lua`
  - `scripts/missions/windurst/5_1_The_Final_Seal.lua`
  - `scripts/missions/windurst/5_2_The_Shadow_Awaits.lua`
  - `scripts/missions/windurst/6_1_Full_Moon_Fountain.lua`
  - `scripts/missions/windurst/6_2_Saintly_Invitation.lua`
  - `scripts/battlefields/QuBia_Arena/rank_5_mission.lua`
  - `scripts/battlefields/Throne_Room/shadow_lord_battle.lua`
  - `scripts/battlefields/Balgas_Dais/saintly_invitation.lua`

## Summary
All five Windurst Rank 4-6 missions have full implementations with proper NPC interactions, cutscenes, battlefield scripts, and mob spawns. No stubs or auto-completes found. These should be completable end-to-end without GM intervention.

## Checklist

### 4-1: Magicite (Rank 4 -> 5)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `4_1_Magicite.lua` - 383 lines, fully implemented |
| NPC: Pakh Jatalfih (Ru'Lude Gardens) | WORKS | In npc_list.sql (ID 17772549), handles mission start and turn-in |
| NPC: Aldo (Lower Jeuno) | WORKS | Gives Silver Bell key item, advances mission status |
| NPC: Paya-Sabya (Upper Jeuno) | WORKS | Yagudo Torch cutscene path |
| NPC: Muckvix (Lower Jeuno) | WORKS | Gives Yagudo Torch key item |
| Embassy door (_6r8) | WORKS | Gives Archducal Audience Permit |
| Audience Chamber (_6r9) | WORKS | Letter to Aldo CS, magicite turn-in CS |
| Magicite (Altar Room / Orastone) | WORKS | Mob spawn point zone 152, gives ki.MAGICITE_ORASTONE |
| Magicite (Monastic Cavern / Optistone) | WORKS | Mob spawn point zone 150, gives ki.MAGICITE_OPTISTONE |
| Magicite (Qu'lun Dome / Aurastone) | WORKS | Mob spawn point zone 148, gives ki.MAGICITE_AURASTONE |
| Reward: Rank 5, 10000 gil, Airship Pass | WORKS | Airship Pass or 20000 gil if already owned |
| Multi-nation support | WORKS | Handles shared Magicite quest across nations properly |

### 5-1: The Final Seal (Rank 5, rank points mission)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `5_1_The_Final_Seal.lua` - 171 lines, fully implemented |
| NPC: Heaven's Tower Vestal Chamber (_6q2) | WORKS | Mission accept and turn-in |
| NPC: Gate guards (Mokyokyo, Janshura-Rashura, Rakoh Buuma, Zokima-Rokima) | WORKS | All 4 guards offer initial trigger events |
| Zone-in CS: Fei'Yin | WORKS | Cutscene on entering Fei'Yin at status 10 |
| Battlefield: Qu'Bia Arena (Rank 5 Mission) | WORKS | `rank_5_mission.lua` - battlefield ID 512, level cap 50, 30 min, 6 players, trusts allowed |
| Mob: Archlich Taber'quoan + adds | WORKS | In mob_pools.sql (ID 223), mob_spawn_points confirmed (3 arenas of 7 mobs each) |
| Key items: New Fei'Yin Seal -> Burnt Seal | WORKS | Seal given on accept, Burnt Seal on win, deleted on completion |
| Reward: 600 rank points | WORKS | Defined in mission.reward |

### 5-2: The Shadow Awaits (Rank 5 -> 6)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `5_2_The_Shadow_Awaits.lua` - 175 lines, fully implemented |
| NPC: Gate guards (4 Windurst zones) | WORKS | All handle mission accept via onEventFinish |
| NPC: Heaven's Tower Vestal Chamber (_6q2) | WORKS | Cutscene with Star Crested Summons, grants Star Ordained Warrior title |
| NPC: Zubaba (Heaven's Tower) | WORKS | In npc_list.sql (ID 17768486), dialogue for summons and shadow fragment |
| Battlefield: Throne Room (Shadow Lord Battle) | WORKS | `shadow_lord_battle.lua` - battlefield ID 160, level cap 75, 30 min, trusts allowed |
| Mob: Shadow Lord (Phase 1 + Phase 2) | WORKS | 6 spawn points per arena (3 arenas), two-phase fight with Implode mechanic |
| Zilart Mission unlock | WORKS | Adds ZM "The New Frontier" on completion if not already started/completed |
| Zone: Castle Zvahl Baileys CS | WORKS | Shadow Fragment given via afterZoneIn when status == 4 |
| Key items: Star Crested Summons 1, Shadow Fragment | WORKS | Proper grant/delete flow |
| Reward: Rank 6, 20000 gil | WORKS | Defined in mission.reward |

### 6-1: Full Moon Fountain (Rank 6, rank points mission)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `6_1_Full_Moon_Fountain.lua` - 204 lines, fully implemented |
| NPC: Gate guards (4 Windurst zones) | WORKS | All handle mission accept |
| NPC: Hakkuru-Rinkuru (Port Windurst) | WORKS | In npc_list.sql (ID 17760273), gives Southwestern Star Charm |
| Gate: Magical Gizmo (_5eb, Outer Horutoto Ruins) | WORKS | Spawns Jack mobs or plays CS depending on status |
| Mob: Jack of Cups | WORKS | mob_spawn_points ID 17572197, pool 2120, level 62 |
| Mob: Jack of Batons | WORKS | mob_spawn_points ID 17572198, level 62 |
| Mob: Jack of Swords | WORKS | mob_spawn_points ID 17572199, level 62 |
| Mob: Jack of Coins | WORKS | mob_spawn_points ID 17572200, level 62 |
| Zone: Full Moon Fountain | WORKS | In zone_settings.sql (zone 170), cutscene event 50 on zone-in completes mission |
| Key items: Southwestern Star Charm | WORKS | Given by Hakkuru-Rinkuru, deleted after defeating Jacks |
| Reward: 650 rank points | WORKS | Defined in mission.reward |
| NM fight is open-world (not BCNM) | WORKS | Spawned via SpawnMob in Outer Horutoto Ruins, not a battlefield instance |

### 6-2: Saintly Invitation (Rank 6 -> 7)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `6_2_Saintly_Invitation.lua` - 148 lines, fully implemented |
| NPC: Gate guards (4 Windurst zones) | WORKS | All handle mission accept |
| NPC: Heaven's Tower Vestal Chamber (_6q2) | WORKS | Gives Holy One's Invitation, completes mission on return |
| Battlefield: Balga's Dais (Saintly Invitation) | WORKS | `saintly_invitation.lua` - battlefield ID 99, level cap 75, 30 min, trusts allowed |
| Mob: Buu Xolo the Bloodfaced + 3 Yagudo | WORKS | In mob_pools (ID 588), mob_spawn_points confirmed, 4 mobs + 2 adds per arena |
| NPC: Kaa Toru the Just (Castle Oztroja) | WORKS | In npc_list.sql (ID 17396214), gives Ashura Necklace and Holy One's Oath |
| Key items: Holy One's Invitation, Balga Champion Certificate, Holy One's Oath | WORKS | Proper grant/delete flow through all stages |
| Reward: Rank 7, 40000 gil, Ashura Necklace | WORKS | Gil/rank in mission.reward, necklace from Kaa Toru |
| Title: Hero on Behalf of Windurst, Victor of the Balga Contest | WORKS | Both titles granted at appropriate stages |

## Blockers
- None identified. All missions appear fully functional.

## Fix Difficulty
- N/A - No fixes needed.
