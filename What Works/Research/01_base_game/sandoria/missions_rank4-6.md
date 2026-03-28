# San d'Oria Missions Rank 4-6

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:San_d%27Oria_Missions
- Codebase:
  - `scripts/missions/sandoria/4_1_Magicite.lua`
  - `scripts/missions/sandoria/5_1_The_Ruins_of_FeiYin.lua`
  - `scripts/missions/sandoria/5_2_The_Shadow_Lord.lua`
  - `scripts/missions/sandoria/6_1_Leautes_Last_Wishes.lua`
  - `scripts/missions/sandoria/6_2_Ranperres_Final_Rest.lua`
  - `scripts/battlefields/QuBia_Arena/rank_5_mission.lua`
  - `scripts/battlefields/Throne_Room/shadow_lord_battle.lua`

## Summary
All five missions (4-1 through 6-2) have full, non-stub implementations with proper NPC interactions, cutscenes, battlefield scripts, mob spawns, and key item handling. No auto-completes or stubs detected. Two minor TODOs exist but neither blocks gameplay.

## Checklist

### Mission 4-1: Magicite (Rank 4 -> 5)
| Item | Status | Notes |
|------|--------|-------|
| Accept from Nelcabrit (Ru'Lude Gardens) | WORKS | Rank point check included; event 45/49 |
| Embassy door (_6r5) cutscene | WORKS | Grants Archducal Audience Permit KI |
| Audience Chamber (_6r9) cutscene | WORKS | Grants Letter to Aldo KI |
| Aldo (Lower Jeuno) interaction | WORKS | Grants Silver Bell KI |
| Paya-Sabya / Muckvix torch quest | WORKS | Yagudo Torch KI chain fully scripted |
| Magicite: Orastone (Altar Room, zone 152) | WORKS | NPC exists in npc_list (id 17399840), CS with Lion on last magicite |
| Magicite: Optistone (Monastic Cavern, zone 150) | WORKS | NPC exists in npc_list (id 17391831), CS with Lion on last magicite |
| Magicite: Aurastone (Qu'lun Dome, zone 148) | WORKS | NPC exists in npc_list (id 17383459), CS with Lion on last magicite |
| Turn-in to Audience Chamber | WORKS | Grants Airship Pass (or 20k gil if already owned), title |
| Complete at Nelcabrit | WORKS | Rank 5 + 10,000 gil reward |

### Mission 5-1: The Ruins of Fei'Yin (Rank 5)
| Item | Status | Notes |
|------|--------|-------|
| Chateau d'Oraguille entry CS (509) | WORKS | Triggers on zone-in from N. San d'Oria |
| Accept from gate guards (event 1009/2009) | WORKS | Option 14 to accept |
| Halver gives New Fei'Yin Seal KI | WORKS | Event 533, status -> 10 |
| Fei'Yin zone-in cutscene | WORKS | Event 1 on entry, status -> 11 |
| Qu'Bia Arena BCNM (Rank 5 Mission) | WORKS | Battlefield script exists; Archlich Taber'quoan + adds (3 arena variants); mob spawn data confirmed; trusts allowed; level cap 50; 30 min |
| Burnt Seal KI on win | WORKS | Granted on battlefieldWin event 32001 |
| Turn in Burnt Seal to Halver | WORKS | Event 534 completes mission; 400 rank points |
| Optional post-completion dialogue | WORKS | Curilla, Rahal, door events in Chateau |

### Mission 5-2: The Shadow Lord (Rank 5 -> 6)
| Item | Status | Notes |
|------|--------|-------|
| Accept from gate guards | WORKS | Option 15 to accept |
| Halver cutscene (546) | WORKS | Status -> 1 |
| Prince Royal's door (_6h0) CS (547) | WORKS | Status -> 2 |
| Throne Room entry CS (event 6) | WORKS | Status -> 3 via _4l1 NPC |
| Shadow Lord BCNM (Throne Room) | WORKS | Two-phase fight; Phase 1 (Shadow_Lord_Phase_1) and Phase 2 (Shadow_Lord_Phase_2) mob spawn data confirmed in mob_spawn_points.sql; trusts allowed; level cap 75; 30 min |
| Zilart Mission unlock on win | WORKS | Adds ZM "The New Frontier" if not already started/completed |
| Shadow Fragment KI + teleport | WORKS | Event 7 grants KI, warps to zone 161 |
| Turn in to Halver (548) | WORKS | Rank 6 + 20,000 gil |
| Optional Great Hall event | WORKS | hallEvent var triggers Arsha/Chupaile/door scenes |
| Minor TODO in code | WORKS | "TODO: This is most likely a pos change and onZoneIn" -- cosmetic note, event 7 already works with startEvent + setPos |

### Mission 6-1: Leaute's Last Wishes (Rank 6)
| Item | Status | Notes |
|------|--------|-------|
| Accept from gate guards | WORKS | Option 16 to accept |
| Halver CS chain (events 25, 23, 24, 22) | WORKS | Multi-step status progression 0->1->2->3->4 |
| Great Hall door (_6h4) event 87 | WORKS | Status 1 -> 2 |
| Dreamrose NPC (Western Altepa Desert) | WORKS | NPC exists in npc_list (id 17289759) at correct pos |
| Sabotender Enamorado spawn + fight | WORKS | Mob exists in mob_spawn_points (id 17289653); spawns on Dreamrose trigger; onMobDeath sets progress var |
| Dreamrose KI pickup after kill | WORKS | Second trigger of Dreamrose NPC after kill grants KI |
| Turn in at Chateau (trigger area 2) | WORKS | Event 111 completes mission; 600 rank points + Piece of Paper KI |

### Mission 6-2: Ranperre's Final Rest (Rank 6 -> 7)
| Item | Status | Notes |
|------|--------|-------|
| Accept from gate guards | WORKS | Option 17 to accept |
| Prince Royal's door CS (event 81) | WORKS | Status -> 1 |
| King Ranperre's Tomb: Heavy Stone Door (_5a0) | WORKS | Spawns 3 corrupted knights from QM |
| Corrupted Yorgos/Soffeil/Ulbrig fight | WORKS | All 3 mobs exist in mob_spawn_points (ids 17555770-72); onMobDeath checks all 3 dead to advance |
| Stone door CS after kills (events 6, 7) | WORKS | Position-dependent triggers for status progression |
| Tombstone_Lower interaction | WORKS | NPC exists (id 17555991); grants Ancient San d'Orian Book KI |
| Return book to S. San d'Oria NPCs | WORKS | Ambrotien/Endracion events handle book turn-in and status updates |
| Perfaumand + Prince Royal's door finish | WORKS | Multiple completion paths through Chateau NPCs |
| Final turn-in at gate guards | WORKS | Events 1033/1034 complete mission; Rank 7 + 40,000 gil |

## Blockers
- None identified. All missions appear fully functional.

## Notes
- Two minor TODO comments exist in codebase:
  - 4-1 Magicite line 63: "TODO: Verify that the mission is displayed in the logs here" -- cosmetic only, mission begin() is called
  - 5-2 Shadow Lord line 139: "TODO: This is most likely a pos change and onZoneIn" -- already functional via startEvent + setPos
- All battlefields allow trusts, which is helpful for a small-population server
- Magicite mission is shared across all three nations; the San d'Oria path through it is fully implemented
- Shadow Lord battle unlocks Zilart Missions and Dynamis access

## Fix Difficulty
- N/A -- No fixes needed
