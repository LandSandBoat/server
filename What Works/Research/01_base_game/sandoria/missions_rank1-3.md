# San d'Oria Missions Rank 1-3

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:San_d%27Oria_Missions
- Codebase: `scripts/missions/sandoria/1_1_Smash_the_Orcish_Scouts.lua` through `3_3_Appointment_to_Jeuno.lua`
- Mission IDs: `scripts/globals/missions.lua` (lines 75-87)
- Battlefield: `scripts/battlefields/Ghelsba_Outpost/save_the_children.lua`
- BCNM (Journey Abroad): `scripts/battlefields/Balgas_Dais/rank_2_mission.lua`, `scripts/battlefields/Waughroon_Shrine/rank_2_mission.lua`
- Tests: `scripts/tests/missions/sandoria.lua`

## Summary
All nine Rank 1-3 San d'Oria mission scripts exist and appear fully implemented with proper NPC interactions, cutscene events, item trades, battlefield encounters, and reward logic. The codebase also includes automated test coverage. No stubs or auto-completion detected.

## Checklist

### Rank 1

| Item | Status | Notes |
|------|--------|-------|
| 1-1 Smash the Orcish Scouts | WORKS | Script complete. Accept from gate guards (Ambrotien, Endracion, Grilau). Trade Orcish Axe to complete. First-time and repeat paths both handled. Reward: rank points. |
| 1-2 Bat Hunt | WORKS | Script complete. Visit Tombstone_Upper in King Ranperre's Tomb (NPC confirmed in npc_list.sql ID 17555989). Trade Orcish Mail Scales (first) or Bat Fang (repeat) to gate guard. Reward: rank points. |
| 1-3 Save the Children | WORKS | Script complete. Talk to Arnau in N. Sandy, then BCNM at Ghelsba Outpost Hut Door. Battlefield script exists with 3 mobs: Fodderchief Vokdek + 2 adds (Strongarm Zodvad, Sureshot Snatgat). Mob scripts exist. Allows trusts, 6 players, 10 min time limit, no level cap (99). Win gives Orcish Hut Key, check Hut Door, return to gate guard. Reward: Rank 2 + 1000 gil. Repeat gives rank points. |

### Rank 2

| Item | Status | Notes |
|------|--------|-------|
| 2-1 The Rescue Drill | WORKS | Script complete. Complex multi-step mission across La Theine Plateau and Ordelle's Caves. 8 NPCs in La Theine (Galaihaurat, Equesobillot, Deaufrain, Vicorpasse, Laurisse, Narvecaint, Augevinne, Yaucevouchat) plus Ruillont in Ordelle's Caves. All NPC interactions scripted through 11 status stages. Trade Bronze Sword to Ruillont, get Rescue Training Certificate, return to gate guard. Reward: rank points. |
| 2-2 The Davoi Report | WORKS | Script complete. Travel to Davoi, talk to Zantaviat, find Lost Document (from '!' NPC at specific coords), return to Zantaviat for Temple Knights' Davoi Report key item. Optional Papal Chambers cutscene in N. Sandy ('_6fc' door). Return report to gate guard. Reward: rank points. |
| 2-3 Journey Abroad | WORKS | Complex multi-part mission split across 5 script files (2_3_0 through 2_3_4). Starts at Chateau d'Oraguille with Halver (gives Halver trust cipher if enabled). Player visits both Bastok and Windurst consuls. Bastok path: talk to Pius/Grohm in Metalworks, mine Mythril Sand, trade to Savae E Paleade. Windurst path: Heaven's Tower/Kupipi (gives Semih Lafihna trust cipher), get Shield Offering, deliver to Giddeus Uu Zhoumo, trade 2 Parana Shields to Mourices. Both paths include a BCNM: Balga's Dais (rank_2_mission) or Waughroon Shrine (rank_2_mission). Battlefield scripts exist for both. Returns Kindred Report to Halver. Reward: Rank 3 + 3000 gil + Adventurer's Certificate. |

### Rank 3

| Item | Status | Notes |
|------|--------|-------|
| 3-1 Infiltrate Davoi | WORKS | Script complete with separate first-time and repeat paths. First time: Chateau d'Oraguille Prince's door ('_6h0') cutscene, zone into Davoi for CS, talk to Quemaricond for Royal Knights' Davoi Report, return to Chateau. Repeat: talk to Zantaviat, collect 3 block codes from '!' NPCs (East/South/North at specific coordinates), return codes to Zantaviat, then report to gate guard. Reward: rank points (400 first, 300 repeat). |
| 3-2 The Crystal Spring | WORKS | Script complete. Trade Crystal Bass to gate guard, enter Chateau d'Oraguille for cutscene (event 555 on zone-in), talk to Chalvatot to complete. First-time and repeat paths both handled. Crystal Bass obtainable via fishing or AH. Reward: rank points. |
| 3-3 Appointment to Jeuno | WORKS | Script complete. No battlefield. Talk to Halver in Chateau d'Oraguille, audience with King (Great Hall '_6h4' door), receive Letter to the Ambassador key item. Travel to Ru'Lude Gardens, deliver to Nelcabrit. Then go to Lower Delkfutt's Tower, open Cermet Door ('_541') with Delkfutt Key (trade item or use key item version). Return to Nelcabrit/Ru'Lude Gardens door ('_6r5') to complete. Reward: Rank 4 + 5000 gil. |

### Cross-cutting Checks

| Item | Status | Notes |
|------|--------|-------|
| Mission ID definitions | WORKS | All 9 missions defined in `scripts/globals/missions.lua` (IDs 0-12). |
| Gate guard framework | WORKS | Events 1009/2009 for mission selection, consistent across all missions. |
| NPC scripts exist | WORKS | Key NPCs verified: Tombstone_Upper (npc_list.sql), Fodderchief_Vokdek (mob script + IDs.lua), Arnau, Halver, Chalvatot, Zantaviat, Quemaricond, Ruillont, Mourices, Savae_E_Paleade, Kupipi, Nelcabrit. |
| Battlefield scripts | WORKS | Save the Children BCNM at Ghelsba Outpost, Rank 2 BCNMs at Balga's Dais and Waughroon Shrine all have dedicated battlefield scripts. |
| Automated tests | WORKS | `scripts/tests/missions/sandoria.lua` includes test cases for these missions. |
| Trust ciphers (Journey Abroad) | WORKS | Halver cipher given during Chateau CS, Semih Lafihna cipher during Heaven's Tower CS, both gated behind `ENABLE_TRUST_QUESTS` setting. |

## Blockers
- None identified. All Rank 1-3 missions appear fully implemented.

## Fix Difficulty
- N/A -- no fixes needed.
