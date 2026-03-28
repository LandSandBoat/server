# Bastok Missions Rank 1-3

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Bastok_Missions
- Codebase: `scripts/missions/bastok/1_1_The_Zeruhn_Report.lua` through `3_3_Jeuno.lua`
- Battlefields: `scripts/battlefields/Horlais_Peak/rank_2_mission.lua`, `scripts/battlefields/Balgas_Dais/rank_2_mission.lua`

## Summary
All 9 Bastok Rank 1-3 missions have full script implementations with proper NPC interactions, key item handling, cutscenes, rewards, and rank-ups. The Emissary (2-3) is the most complex with 5 sub-scripts covering both the San d'Oria and Windurst paths, including two battlefield fights. No stubs or auto-completes found.

## Checklist

### Rank 1

| Item | Status | Notes |
|------|--------|-------|
| **1-1 The Zeruhn Report** | WORKS | Accept from any gate guard, get Zeruhn Report KI from Makarim in Zeruhn Mines, deliver to Naji in Metalworks. All NPCs scripted. |
| - Gate Guards (4 locations) | WORKS | Cleades, Rashid, Malduc, Argus all have accept handlers |
| - Makarim (Zeruhn Mines) | WORKS | Gives KI on trigger, has dialog for already having KI |
| - Naji (Metalworks) | WORKS | Checks for KI, completes mission, deletes KI |
| **1-2 A Geological Survey** | WORKS | Get Blue Acidity Tester from Cid, take to Dangruf Wadi geyser to turn Red, return to Cid. All steps scripted. |
| - Cid (Metalworks) | WORKS | 3 states: gives tester, waiting, accepts red tester. Proper KI exchange. |
| - Dangruf Wadi geysers | WORKS | Events 10/11/12 all handle Blue->Red KI swap |
| - Reward: rank points | WORKS | Mission complete with KI cleanup |
| **1-3 Fetichism** | WORKS | Trade 4 Quadav Fetich pieces (head/torso/arms/legs) to any gate guard. Handles first-time and repeat completions differently. |
| - Fetich item trade | WORKS | `npcUtil.tradeHasExactly` checks all 4 pieces, `confirmTrade` on completion |
| - Reward: 1000 gil, Rank 2 | WORKS | `mission.reward` sets gil=1000, rank=2, rankPoints=200 |

### Rank 2

| Item | Status | Notes |
|------|--------|-------|
| **2-1 The Crystal Line** | WORKS | Get random crystal from Cid, trade Faded Crystal back, get C.L. Report KI, deliver to Ayame. |
| - Cid (Metalworks) | WORKS | Gives random crystal, accepts Faded Crystal trade, gives C.L. Report KI |
| - Ayame (Metalworks) | WORKS | Accepts C.L. Report, completes mission |
| - Naji (Metalworks) | WORKS | Has dialog when player holds C.L. Report |
| - Reward: rank points | WORKS | rankPoints=200 |
| **2-2 Wading Beasts** | WORKS | Trade Lizard Egg to Alois in Metalworks. Simple fetch mission. |
| - Alois (Metalworks) | WORKS | Accepts Lizard Egg trade, handles first-time vs repeat |
| - Reward: rank points | WORKS | rankPoints=250 |
| **2-3 The Emissary** | WORKS | Complex multi-path mission visiting San d'Oria and Windurst consulates. 5 sub-scripts handle all paths. Awards Rank 3. |
| - Naji (start) | WORKS | Gives Letter to the Consuls KI, tracks first-time-23 flag for Lion dialog variation |
| - San d'Oria path (first) | WORKS | `2_3_1_The_Emissary_Sandoria.lua` - Helaku/Baraka in N. San d'Oria, Halver in Chateau, kill Warchief Vatgit in Ghelsba |
| - Windurst path (first) | WORKS | `2_3_2_The_Emissary_Windurst.lua` - Melek in Port Windurst, Kupipi in Heaven's Tower (zone-in CS), Gold Skull for Dull Sword, Uu Zhoumo in Giddeus for Aspir Knife trade |
| - San d'Oria path (second) | WORKS | `2_3_3_The_Emissary_Sandoria2.lua` - Halver CS + Halver Trust cipher, battlefield at Horlais Peak (Dread Dragon + Spotter), return for Kindred Report KI |
| - Windurst path (second) | WORKS | `2_3_4_The_Emissary_Windurst2.lua` - Kupipi for Dark Key, battlefield at Balga's Dais (Black Dragon + Searcher), return for Kindred Report KI |
| - Battlefield: Horlais Peak | WORKS | `rank_2_mission.lua` - 6 players, lv25 cap, 30 min, trusts allowed. Entry checks mission status. |
| - Battlefield: Balga's Dais | WORKS | `rank_2_mission.lua` - 6 players, lv25 cap, 30 min, trusts allowed. Requires Dark Key KI. |
| - Halver Trust cipher | WORKS | Awarded during San d'Oria path if ENABLE_TRUST_QUESTS=1 |
| - Semih Lafihna Trust cipher | WORKS | Awarded during Windurst path if ENABLE_TRUST_QUESTS=1 |
| - Reward: 3000 gil, Rank 3 | WORKS | Also awards Adventurer's Certificate KI and Certified Adventurer title |

### Rank 3

| Item | Status | Notes |
|------|--------|-------|
| **3-1 The Four Musketeers** | WORKS | Talk to Iron Eater, go to Beadeaux, kill 20 Copper Quadavs, zone to Pashhow for CS. |
| - Iron Eater (Metalworks) | WORKS | Gives instructions, sets status=1 |
| - Beadeaux zone-in CS | WORKS | Triggers at status=1, sets status=2, positions player |
| - Copper Quadav kill tracking | WORKS | onMobDeath increments status from 2 to 22 (20 kills). Mob script exists in Beadeaux. |
| - Pashhow exit CS | WORKS | Two events: status<22 = failure/retry (repositions), status=22 = success + complete |
| - Ayame/Naji dialog | WORKS | Both have dialog at status>0 |
| - Reward: rank points | WORKS | rankPoints=350 |
| **3-2 To the Forsaken Mines** | WORKS | Optional. Trade Hare Meat to QM in Gusgen Mines to spawn Blind Moby, get Glocolite, trade to gate guard. |
| - Davyad (Bastok Mines) | WORKS | Provides mission info dialog |
| - Gusgen Mines QM spawn | WORKS | Trades Hare Meat, spawns Blind Moby via `npcUtil.popFromQM` with 3-min respawn timer |
| - Blind Moby (NM) | WORKS | Mob exists in mob_pools.sql and mob_spawn_points.sql |
| - Glocolite trade to guard | WORKS | All 4 gate guards accept trade, handles first-time vs repeat |
| - Reward: rank points | WORKS | rankPoints=400 |
| **3-3 Jeuno** | WORKS | Talk to Lucius for Letter to the Ambassador KI, go to Ru'Lude Gardens, talk to Goggehn, get Delkfutt Key, open door in Lower Delkfutt's Tower, return to Ru'Lude. Awards Rank 4. |
| - Lucius (Metalworks) | WORKS | Gives Letter to the Ambassador KI, sets status=1 |
| - Goggehn (Ru'Lude Gardens) | WORKS | Accepts letter (status 1->2), has dialog at status 2-3 |
| - Lower Delkfutt's Tower door | WORKS | Accepts Delkfutt Key trade OR KI. Converts inventory key to KI on trade. Sets status=3. |
| - Ru'Lude Gardens completion | WORKS | Door `_6r2` triggers final CS at status=3 |
| - Reward: 5000 gil, Rank 4 | WORKS | gil=5000, rank=4 |

## Blockers
- None identified. All missions appear fully functional.

## Fix Difficulty
- N/A -- no fixes needed.

## Notes
- The Emissary is a shared mission concept across all 3 nations. The Bastok version has the most thorough implementation with 5 separate script files covering every path combination.
- Both battlefields (Horlais Peak and Balga's Dais) allow trusts, making them soloable at the lv25 cap.
- The Four Musketeers kill counter (20 Copper Quadavs) uses mission status incrementing from 2 to 22, which is a clean implementation.
- All missions properly handle repeat completions where applicable (Fetichism, Wading Beasts, To the Forsaken Mines).
