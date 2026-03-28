# Windurst Missions Rank 1-3

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Windurst_Missions
- Codebase: `scripts/missions/windurst/1_1_*.lua` through `3_3_*.lua`
- Battlefields: `scripts/battlefields/Horlais_Peak/rank_2_mission.lua`, `scripts/battlefields/Waughroon_Shrine/rank_2_mission.lua`

## Summary
All nine Windurst Rank 1-3 missions have full script implementations with detailed step-by-step progression, NPC dialogue, key item handling, and post-mission dialogue. The Two BCNM fights in the rank-up (2-3) path are also implemented. No stubs or auto-completes found. This is a mature, well-implemented mission line.

## Checklist

### Rank 1

| Item | Status | Notes |
|------|--------|-------|
| **1-1: The Horutoto Ruins Experiment** | WORKS | Full implementation. Accept from gate guards (4 zones), talk Hakkuru-Rinkuru in Orastery, examine Gate: Magical Gizmo in Inner Horutoto Ruins, find random broken gizmo (1 of 6), return Cracked Mana Orb. Reward: 250 rank points. All NPC dialogue including post-mission implemented. |
| 1-1: Gate guard NPCs | WORKS | Rakoh Buuma, Mokyokyo, Janshura-Rashura, Zokima-Rokima all scripted with accept/in-progress/post-mission dialogue |
| 1-1: Hakkuru-Rinkuru (Orastery) | WORKS | NPC script exists at `scripts/zones/Port_Windurst/npcs/Hakkuru-Rinkuru.lua` |
| 1-1: Inner Horutoto Ruins gizmos | WORKS | 6 gizmos (`_5cp` through `_5cu`) with random correct one, success/fail events, KI grant |
| **1-2: The Heart of the Matter** | WORKS | Full implementation. Talk Apururu, get 6 Dark Mana Orbs, visit Pore-Ohre for SE Star Charm, place orbs in Outer Horutoto Ruins gizmos, examine gate, collect 6 Glowing Mana Orbs, return to Apururu. Includes cardian ambush CS when zoning to E. Sarutabaruta. Reward: 250 rank points. |
| 1-2: Apururu (Manustery) | WORKS | NPC script exists at `scripts/zones/Windurst_Woods/npcs/Apururu.lua` |
| 1-2: Outer Horutoto Ruins gizmos | WORKS | 6 gizmos (`_5ee` through `_5ej`) for placing and collecting orbs |
| 1-2: Cardian ambush on zone | WORKS | E. Sarutabaruta onZoneIn CS (event 48) strips orbs, branches to alternate ending |
| **1-3: The Price of Peace** | WORKS | Full implementation. Talk Leepe-Hoppe at Rhinostery, get Food/Drink Offerings, deliver to Yagudo NPCs (Laa Mozi, Ghoo Pakya) in Giddeus, return for CS, report to gate guard. Reward: Rank 2, 1000 gil. |
| 1-3: Leepe-Hoppe (Rhinostery) | WORKS | Gives KIs, mid-mission dialogue, post-mission dialogue |
| 1-3: Giddeus Yagudo NPCs | WORKS | Laa Mozi and Ghoo Pakya accept offerings, track turn-in count |

### Rank 2

| Item | Status | Notes |
|------|--------|-------|
| **2-1: Lost for Words** | WORKS | Full implementation. Talk Tosuka-Porika at Optistery, talk Nanaa Mihgo for Lapis Monocle, find correct Fossil Rock (random 1 of 6) in Maze of Shakhrami for Lapis Coral, return to Nanaa Mihgo for Hideout Key, examine Mahogany Door in Inner Horutoto Ruins, visit House of the Hero in Windurst Walls, return to Tosuka-Porika. Reward: 300 rank points. |
| 2-1: Tosuka-Porika (Optistery) | WORKS | NPC script exists at `scripts/zones/Windurst_Waters/npcs/Tosuka-Porika.lua` |
| 2-1: Nanaa Mihgo | WORKS | NPC script exists at `scripts/zones/Windurst_Woods/npcs/Nanaa_Mihgo.lua` |
| 2-1: Fossil Rocks (Maze of Shakhrami) | WORKS | Handled via mission interaction system; FOSSIL_ROCK_OFFSET used to identify correct rock |
| 2-1: House of the Hero (`_6n2`) | WORKS | Cutscene event 337 in Windurst Walls |
| **2-2: A Testing Time** | WORKS | Full implementation. Talk Moreno-Toeno at Aurastery, get Creature Counter Magic Doll, kill mobs in Tahrongi Canyon within Vana'diel day, return for assessment. Kill-count tiers (19/30/35) determine pass/fail. Repeatable with Buburimu Peninsula mobs and 2-day timer. Reward: 300 rank points. |
| 2-2: Moreno-Toeno (Aurastery) | WORKS | NPC script exists at `scripts/zones/Windurst_Waters/npcs/Moreno-Toeno.lua` |
| 2-2: Kill counter system | WORKS | Tracks kills across all Tahrongi Canyon mobs (29 mob types listed), time-based assessment |
| 2-2: Repeat path (Buburimu) | WORKS | Separate mob list for repeat runs with longer timer |
| **2-3: The Three Kingdoms** | WORKS | Complex multi-part mission with 5 sub-scripts. Accept from gate guard, visit Kupipi in Heaven's Tower for Letter to Consuls, travel to San d'Oria (Heruze-Moruze/Kasaroro) and Bastok (Patt-Pott/Grohm/Pius). Two paths (San d'Oria and Bastok) each have Part 1 and Part 2. Part 2 culminates in a BCNM fight. Reward: Rank 3, 3000 gil, Adventurer's Certificate, Certified Adventurer title. |
| 2-3: Main script (2_3_0) | WORKS | Handles accept, Kupipi/Heaven's Tower, branching to San d'Oria or Bastok paths, and final completion |
| 2-3: San d'Oria path Part 1 (2_3_1) | WORKS | Talk Halver in Chateau d'Oraguille, kill Warchief Vatgit in Ghelsba Outpost, report to Kasaroro |
| 2-3: San d'Oria path Part 2 (2_3_3) | WORKS | Talk Halver, BCNM at Horlais Peak (Rank 2 Mission 1, lv25 cap, 30min, trusts allowed), report to Kasaroro for Kindred Report |
| 2-3: Bastok path Part 1 (2_3_2) | WORKS | Talk Pius, talk Grohm for pickaxes, mine Mythril Sand, trade to Patt-Pott |
| 2-3: Bastok path Part 2 (2_3_4) | WORKS | Talk Pius, talk Grohm, BCNM at Waughroon Shrine (Rank 2 Mission 2, lv25 cap, 30min, trusts allowed), report to Patt-Pott for Kindred Report |
| 2-3: BCNM - Horlais Peak | WORKS | `scripts/battlefields/Horlais_Peak/rank_2_mission.lua` - full battlefield config |
| 2-3: BCNM - Waughroon Shrine | WORKS | `scripts/battlefields/Waughroon_Shrine/rank_2_mission.lua` - full battlefield config |
| 2-3: Semih Lafihna trust cipher | WORKS | Granted from Kupipi if ENABLE_TRUST_QUESTS == 1 |
| 2-3: Halver trust cipher | WORKS | Granted during San d'Oria path if ENABLE_TRUST_QUESTS == 1 |
| 2-3: Warchief Vatgit mob | WORKS | Mob script at `scripts/zones/Ghelsba_Outpost/mobs/Warchief_Vatgit.lua` |

### Rank 3

| Item | Status | Notes |
|------|--------|-------|
| **3-1: To Each His Own Right** | WORKS | Full implementation. Accept from gate guard, talk Kupipi in Heaven's Tower for Starway Stairway Bauble, talk Rhy Epocan, talk Hakkuru-Rinkuru at Orastery, go to Castle Oztroja trap door (event 43 from `_47b`/`_47c` NPCs), return to Rhy Epocan. Reward: 450 rank points. |
| 3-1: Kupipi (Heaven's Tower) | WORKS | NPC script exists, handles KI grant and mission progression |
| 3-1: Rhy Epocan (Heaven's Tower) | WORKS | Handled via mission interaction system; 3 mission status checks |
| 3-1: Castle Oztroja trap door | WORKS | `_47b` NPC script exists at `scripts/zones/Castle_Oztroja/npcs/_47b.lua` |
| **3-2: Written in the Stars** | WORKS | Full implementation. Two paths: first-time (talk Zubaba, get Charm of Light, use Gate of Light `_5ci` in Inner Horutoto Ruins, return to Zubaba) and repeat (talk Zubaba, trade 3x Rusty Dagger). Reward: 400-500 rank points. |
| 3-2: Zubaba (Heaven's Tower) | WORKS | NPC script exists at `scripts/zones/Heavens_Tower/npcs/Zubaba.lua` |
| 3-2: Gate of Light (Inner Horutoto) | WORKS | `_5ci` NPC interaction, Charm of Light KI consumed |
| 3-2: Repeat path (Rusty Daggers) | WORKS | Trade 3x Rusty Dagger to Zubaba, separate check/event flow |
| **3-3: A New Journey** | WORKS | Full implementation. Accept from gate guard (get Star Crested Summons 1), enter Vestal Chambers in Heaven's Tower for Letter to Ambassador, talk Pakh Jatalfih in Ru'Lude Gardens, open Cermet Door in Lower Delkfutt's Tower with Delkfutt Key (trade or KI), return to Pakh Jatalfih, examine Embassy Door. Reward: Rank 4, 5000 gil. |
| 3-3: Heaven's Tower Vestal Chambers | WORKS | `_6q2` NPC interaction, KI swap (Star Crested Summons -> Letter to Ambassador) |
| 3-3: Pakh Jatalfih (Ru'Lude Gardens) | WORKS | NPC script exists, handles 3 mission status checks |
| 3-3: Lower Delkfutt's Tower door | WORKS | `_540` NPC handles both KI check and item trade for Delkfutt Key |
| 3-3: Embassy Door (Ru'Lude Gardens) | WORKS | `_6r8` NPC, triggers final completion event |

## Blockers
- None identified. All missions appear fully functional.

## Fix Difficulty
- N/A -- no fixes needed.

## Notes
- All missions use the LandSandBoat interaction framework (Mission:new, progressEvent, etc.) which is the modern pattern.
- Post-mission NPC dialogue is implemented for most missions, showing attention to retail accuracy.
- The Three Kingdoms (2-3) is particularly well done with 5 sub-scripts covering all branching paths.
- BCNMs allow trusts, which is helpful for a small private server.
- Mission 2-2 (A Testing Time) has a working time-based kill-count assessment with proper fail/pass tiers.
- ROV integration present in Three Kingdoms (checks for The Path Untraveled mission).
