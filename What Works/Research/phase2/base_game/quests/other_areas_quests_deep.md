# Other Areas Quests - Deep Audit

Audited: `scripts/quests/otherAreas/` (41 quest scripts + 1 helpers file)
Date: 2026-03-28

## Summary

- **41 quest scripts** audited across Selbina, Mhaura, Tavnazia, Oldton Movalpolos, and other zones
- **1 code bug found** (The_Call_of_the_Sea orphaned table)
- **2 TODO-heavy quests** (Uninvited_Guests, Tango_with_a_Tracker)
- **All equipment rewards verified** in item_mods.sql
- **Key quests NOT in otherAreas folder** -- sub-job unlock (Elder Memories), SAM/NIN/DNC/SCH unlocks, avatar prime fights, and Magian Trials are in other quest folders (outlands, jeuno, bastok, crystalWar)
- **1 missing prerequisite quest script** (Behind_the_Smile, ID 77)

## Detailed Audit Table

| # | Script | Quest ID | Location | Accept | Completion | Rewards | Equipment Mods | Status | Issues |
|---|--------|----------|----------|--------|------------|---------|----------------|--------|--------|
| 1 | A_Bitter_Past | 66 | Tavnazia/Lufaise | Talk Frescheque (event 151) | Trade KI to Frescheque (event 154) | Yinyang Lorgnette | VERIFIED in item_mods.sql | OK | Dual NM kill check (both must be dead) is correct |
| 2 | A_Hard_Days_Knight | 64 | Tavnazia/Lufaise | Talk Quelveuiat, option==3 (event 119) | Kill NM + talk Quelveuiat (event 121) | 2100 gil, Tavnazian Squire title | N/A (gil) | OK-TODOs | 2 TODOs: single-trade event verification (line 104), forced zoning events (line 137) |
| 3 | An_Explorers_Footsteps | 19 | Selbina + 17 zones | Talk Abelard (events 40/42) | Trade all 17 tablets (event 47) | Gil (varies), Map of Crawlers' Nest | N/A (KI) | OK | Complex multi-zone monument system; well-implemented bitmask tracking |
| 4 | Better_The_Demon_You_Know | 105 | Oldton Movalpolos/Zvahl | Prereq: For_The_Birds completed; talk Koblakiq (event 20) | Kill Marquis + get KI + return (event 26) | Goblin Grenade | N/A (consumable) | OK | 5-mob spawn at QM; localVar NMKilled resets on zone (intentional) |
| 5 | Bombs_Away | 96 | Uleguerand Range | Talk Buffalostalker, option==1 (event 6) | Trade 2x Cluster Core (event 8) | Chunk of Shumeyo Salt | N/A (consumable) | MINOR | Second section uses `status ~= QUEST_AVAILABLE` which also matches QUEST_COMPLETED -- allows repeated trades after completion (may be intentional for repeatable quest) |
| 6 | Confessions_of_a_Bellmaker | 79 | Riverne A01/Bastok/San d'Oria | Touch Stone Monument (event 101) | Kill Arcane Phantasm + touch monument again (event 103) | Minstrel's Dagger | VERIFIED in item_mods.sql | OK-TODO | TODO at line 57: "Determine if message is displayed on NM pop"; uses xi.keyItem (valid alias for xi.ki) |
| 7 | Elderly_Pursuits | 75 | Tavnazia/S.Sandy/Carpenters | Prereq: Secrets_of_Ovens_Lost; talk Despachiaire (event 517) | Kill Para NM + get KI + return to Despachiaire (event 518) | Elegant Ribbon | VERIFIED in item_mods.sql | OK | Zone-out resets Prog from 2 to 1 (must check QM before zoning) |
| 8 | For_The_Birds | 104 | Movalpolos/Oztroja/Beadeaux | Prereq: Missionary_Moblin; talk Koblakiq (event 14) | Kill 4 Quadav NMs + return (event 18) | Jaguar Mantle | VERIFIED in item_mods.sql | OK | Complex multi-zone NM fight; onZoneOut resets kill count; must-zone flag set on complete |
| 9 | Give_a_Moogle_a_Break | 100 | Mog House (home nation) | Talk Moogle (event 30005), fame >= 3 | Trade Power Bow + Beetle Ring, wait 60s (event 30008) | Mog Safe +10 slots x2, Mog's Kind Master title | N/A (storage) | OK | Bed placement time check; 60s real-time wait |
| 10 | Go_Go_Gobmuffin | 69 | Tavnazia/Riverne B01 | Prereq: CoP Sheltering Doubt; talk Epinolle (event 232) | Kill 3 Goblin NMs + return (event 234) | 2000 exp, 2000 gil, Map of Cape Riverne | N/A (KI) | OK | Bitmask tracking for 3 NMs; localVar resets on zone |
| 11 | In_Search_of_the_Truth | 80 | Tavnazian Safehold | Prereq: CoP > Darkness Named; talk Tressia (event 544) | Follow water trail (5 QMs in order) + CS chain | Gramary Cape | VERIFIED in item_mods.sql | MINOR | Line 261: uses `player:completeQuest()` directly instead of `quest:complete()` -- bypasses framework reward system. Reward is given in post-completion section via event 559 instead |
| 12 | Inside_the_Belly | 26 | Selbina | Prereq: The_Real_Gift + fishing >= 30; talk Zaldon (event 161) | Trade qualifying fish to Zaldon | Gil + random item per fish | N/A (varies) | OK | Massive fish reward table with percentage-based drops; many "guessing X%" comments indicate unverified rates; confirmTrade happens before CS to prevent cheese |
| 13 | Its_Raining_Mannequins | 29 | Mhaura/Selbina/N.Sandy | Talk Fyi_Chalmwoh (event 305) | Trade 5 mannequin parts + wait 60s | Race-matched Mannequin | N/A (furniture) | OK | Race-based reward selection; 60s wait timer; checks free inventory |
| 14 | Knocking_on_Forbidden_Doors | 78 | Tavnazia/Phomiuna/Misareaux/Mhaura | Prereq: Behind_the_Smile; talk Enaremand (event 535) | Kill Alsha NM + get KI + talk Fyi_Chalmwoh | Better Humes and Mannequins KI (mannequin system unlock) | N/A (KI) | WARN | **Prereq quest Behind_the_Smile (ID 77) has NO script file** -- quest cannot be completed to unlock this one unless manually flagged |
| 15 | Missionary_Moblin | 103 | Oldton Movalpolos | Talk Koblakiq, option==1 (event 7) | Trade Soiled Letter (event 9) | 4000 gil | N/A (gil) | OK | Simple fetch quest; must-zone flag for post-complete dialog |
| 16 | Monstrosity | 34 | Pashhow/Cities/Feretory | Setting ENABLE_MONSTROSITY==1; talk Suspicious_Hume (event 40) | Trade species item + enter Feretory | Ring of Supernal Disjunction KI | N/A (KI) | OK-TODOs | TODO line 176: character appearance encoding for CS; TODO line 214: event 886 may be once-per-zone; Suspicious NPC post-complete items need additional work (line 191-193) |
| 17 | Moogles_in_the_Wild | 102 | Mog House (home nation) | Prereq: The_Moogle_Picnic, fame >= 7; talk Moogle (event 30013) | Trade Raptor Mantle + Wool Hat, wait 60s | Mog Safe +10 x2, Mog's Loving Master title | N/A (storage) | OK | Same pattern as other Moogle quests |
| 18 | Paradise_Salvation_and_Maps | 68 | Tavnazia/Sacrarium | Prereq: CoP The Savage; talk Nivorajean (event 223) | Get floorplans from chest + coordinate puzzle | 2000 exp, 2000 gil, Map of Sacrarium | N/A (KI) | OK | Coordinate selection puzzle; VanadielUniqueDay wait; uses xi.keyItem (valid) |
| 19 | Petals_for_Parelbriaux | 74 | Tavnazia/Lufaise | Prereq: CoP Darkness Named; talk Chemioue->Parelbriaux->Ondieulix | Kill Baumesel (fog weather spawn) + get KI + return | Powerful Rope, title | VERIFIED in item_mods.sql | OK | Weather-gated NM spawn (FOG required); localVar NMKilled |
| 20 | RQ1_Rycharde_the_Chef | 0 | Mhaura | Talk Numi Adaligo (default event 50, option 2) -> Take -> Rycharde | Trade 2x Dhalmel Meat to Rycharde (event 74) | 1500 gil, fame, Purveyor in Training title | N/A (gil) | OK | Default event interception pattern; sets DayCompleted for next quest chain |
| 21 | RQ2_Way_of_the_Cook | 1 | Mhaura | Prereq: RQ1 + fame 3 + 8 Vanadiel days wait; talk Rycharde (event 76) | Trade Dhalmel Meat + Beehive Chip within time limit | 1500 gil (in time) or 1000 gil (late), fame, title | N/A (gil) | OK | Timed quest (3 Vana days); separate rewards for on-time/late completion |
| 22 | RQ3_Unending_Chase | 2 | Mhaura | Prereq: RQ2 + fame 3 + 7 Vana days wait; talk Rycharde (event 82) | Trade Puffball to Rycharde (event 83) | 2100 gil, fame, Two Star Purveyor title | N/A (gil) | OK | Simple fetch quest in chain |
| 23 | RQ4_His_Name_is_Valgeir | 3 | Mhaura/Selbina | Prereq: RQ3 + fame 3 + 2 Vana days wait; talk Rycharde (event 86) | Deliver Aragoneu Pizza to Valgeir -> return to Rycharde (event 88) | 2000 exp, 2000 gil, fame, Map of Toraimarai Canal | N/A (KI) | OK | Delivery quest; optional free ferry ride; exp given via addExp() not in reward table |
| 24 | RQ5_Expertise | 4 | Mhaura/Selbina | Prereq: RQ4 + fame 3 + 8 Vana days wait; talk Take (event 61) | Trade ingredients to Valgeir -> wait 24 Vana hours -> get KI -> return to Take | Tableware Set, Three Star Purveyor title | N/A (furnishing) | OK | Real-time wait (24 * 144 = 3456 seconds); KI-based progression |
| 25 | RQ6_The_Clue | 5 | Mhaura | Prereq: RQ5 + fame 5 + 7 Vana days wait; talk Rycharde (event 90) | Trade 4x Crawler Eggs to Rycharde (event 92) | 3000 gil, fame, Four Star Purveyor title | N/A (gil) | OK | Checks partial trade (< 4 eggs) and gives feedback |
| 26 | RQ7_The_Basics | 6 | Mhaura/Selbina | Prereq: RQ6 + fame 5 + 7 Vana days wait; talk Rycharde (event 94) | Deliver Mhauran Couscous to Valgeir -> get Baked Popoto -> trade to Rycharde | Tea Set, 2000 exp, fame, Five Star Purveyor title | N/A (furnishing) | OK-TODO | TODO line 80: Ferry free ride details unknown; post-quest commentary dialog system |
| 27 | Recycling_Rods | 30 | Mhaura | Talk Keshab-Menjab, option==1 (event 313) | Trade Clean Snap Rod (event 317) | 1500 gil | N/A (gil) | OK | Simple trade quest |
| 28 | Secrets_of_Ovens_Lost | 73 | Tavnazia/Sacrarium/Phomiuna | Prereq: Spice Gals (Sandoria quest); talk Despachiaire -> Jonette | Get Tavnazian Cookbook from QM -> return to Jonette | Miratete's Memoirs | N/A (scroll) | OK | Repeatable after conquest tally; cookbook obtainable from 2 zones; comment says "Spice Gals" but code file header also says this |
| 29 | Tango_with_a_Tracker | 82 | Tavnazia/Boneyard Gully | Prereq: CoP A Fate Decided; talk Despachiaire (event 576) | Win battlefield (Tango with a Tracker) | 10000 gil, Sin Hunter Hunter title | N/A (gil) | OK-TODOs | TODO lines 6-8: exact quest start unknown, quest log timing unclear; conquest tally reset for repeat attempts |
| 30 | Test_My_Mettle | 25 | Selbina/Davoi | Lv10+, Rank 2+, fame 2+; talk Devean (event 120) | Find Jar in Davoi -> trade Power Sandals back | Gil (bet * multiplier), fame | N/A (gil) | OK-TODO | TODO line 156: Find Jar's default action; gambling quest with time-based multiplier; jar moves randomly in Davoi |
| 31 | The_Call_of_the_Sea | 67 | Tavnazia/Misareaux | Talk Equette (event 170) -> Anteurephiaux (event 172) | Kill Bloody Coffin NM + get KI + return | Memento Muffler | VERIFIED in item_mods.sql | BUG | **Line 38-46: Orphaned anonymous table after `['Equette'] = quest:progressEvent(170),`** -- the `{onTrigger = ...}` block checking Prog==0 is disconnected and never executes. Event 170 fires unconditionally for Equette during QUEST_AVAILABLE, bypassing the Prog check. Functionally quest still works since Prog==0 is the initial state, but the dead code indicates intended gating logic was lost. |
| 32 | The_Gift | 21 | Selbina | Prereq: Under_the_Sea + The_Sand_Charm accepted + fishing enabled; talk Oswald (event 70) | Trade Danceshroom (event 72) | Sleep Dagger, Savior of Love title | VERIFIED in item_mods.sql | OK | Part of Selbina fishing quest chain |
| 33 | The_Real_Gift | 22 | Selbina | Prereq: Under_the_Sea + The_Sand_Charm completed + fishing enabled; talk Oswald (event 73) | Trade Shall Shell (event 75) | Glass Fiber Fishing Rod, The Love Doctor title | N/A (fishing rod) | OK | Final quest in Oswald chain |
| 34 | The_Rescue | 23 | Selbina/Beadeaux | Fame >= 1; talk Thunder Hawk (event 80) | Trade Quadav Charm to jail door -> get Traders Sack -> return | 2000 exp, 5000 gil, Map of Ranguemont Pass, title | N/A (KI) | OK-TODO | TODO line 27: Fame requirement needs verification |
| 35 | The_Sand_Charm | 8 | Mhaura | Fame >= 2 + fishing enabled; talk Blandine -> Zexu -> Celestina | Trade Sand Charm to Celestina (event 127) | 2000 exp, 2000 gil, Map of Bostaunieux Oubliette | N/A (KI) | OK | Position check for Blandine (not on dock); multi-NPC dialog chain |
| 36 | The_Moogles_Picnic | 101 | Mog House (home nation) | Prereq: Give_a_Moogle_a_Break, fame >= 5; talk Moogle (event 30009) | Trade Shrimp Lure + Selbina Butter, wait 60s | Mog Safe +10 x2, title | N/A (storage) | OK | Same pattern as other Moogle expansion quests |
| 37 | Under_the_Sea | 17 | Selbina | Fame >= 2 + fishing enabled; talk Yaya (event 31) | Multi-step: Oswald -> Jimaida -> Zaldon -> trade Fat Greedie (20% chance) -> return ring | Amber Earring, Lil' Cupid title | N/A (accessory) | OK-TODO | TODO line 10: Quest log timing unclear; 20% success rate on fish trade is RNG-gated |
| 38 | Unforgiven | 72 | Tavnazian Safehold | Prereq: CoP >= An Invitation West; talk Elysia (event 200) | Find Alabaster Hairpin -> Elysia -> Pradiulot | 2000 exp, Map of Tavnazia | N/A (KI) | OK | Post-quest cleanup with 2-step dialog chain |
| 39 | Uninvited_Guests | 81 | Tavnazia/Monarch Linn | Prereq: CoP The Savage; talk Justinius (event 570) | Win Monarch Linn battlefield -> return | Miratete's Memoirs (random), Monarch Linn Patrol Guard title | N/A (scroll) | OK-TODOs | TODO lines 9-10: "Implement full rewards" and "Add ROE rewards"; reward pool only has 1 item (Miratete's Memoirs at 100%) -- likely incomplete |
| 40 | Waking_the_Beast | 32 | La Theine/6 Cloisters/Full Moon Fountain | Must have all 6 avatar spells; touch QM (event 207) | Win all 6 cloister fights + Full Moon Fountain | Carbuncle's Pole | VERIFIED in item_mods.sql | OK | Repeatable weekly (conquest tally reset); complex multi-battlefield progression; 2 title variants based on CS option |
| 41 | X_Marks_The_Spot | 65 | Tavnazia/Phomiuna | Prereq: CoP >= Ancient Vows; talk Despachiaire (event 144) | Multi-step: Parelbriaux -> Odeya -> trade Tavnazian Liver -> Phomiuna door -> return | 4000 gil | N/A (gil) | OK | Post-quest cleanup with zone-out handler |

## Critical Issues

### BUG: The_Call_of_the_Sea - Orphaned Code Block (Line 38-46)
```lua
['Equette'] = quest:progressEvent(170),
{   -- THIS TABLE IS ORPHANED - never referenced
    onTrigger = function(player, npc)
        if quest:getVar(player, 'Prog') == 0 then
            return quest:progressEvent(170)
        end
    end,
},
```
The anonymous table after the comma is a separate array element in the section table, not part of the `['Equette']` entry. The intended Prog==0 gating never executes. Event 170 fires unconditionally. **Impact: Low** -- quest still works because Prog is 0 initially, but the dead code should be cleaned up.

### WARN: Knocking_on_Forbidden_Doors - Missing Prerequisite Script
Quest requires `player:hasCompletedQuest(BEHIND_THE_SMILE)` but **Behind_the_Smile (ID 77) has no script file**. This quest is defined in quests.lua but without a "Converted" marker. Players cannot complete this prerequisite through normal gameplay, making Knocking_on_Forbidden_Doors inaccessible without GM intervention.

### WARN: Uninvited_Guests - Incomplete Reward Table
Two TODOs explicitly state rewards are not fully implemented. The reward table only contains Miratete's Memoirs at 100% weight. The original quest should have variable rewards including gil.

## Minor Issues

| Script | Issue |
|--------|-------|
| In_Search_of_the_Truth | Uses `player:completeQuest()` directly (line 261) instead of `quest:complete()` -- bypasses framework reward handling; reward given separately in post-completion section |
| Bombs_Away | Second section check `status ~= QUEST_AVAILABLE` matches COMPLETED status too -- allows trade after completion (may be intentional for repeatable design) |
| Inside_the_Belly | Many fish reward percentages marked as "guessing X%" -- unverified drop rates from wiki |
| A_Hard_Days_Knight | Post-completion Temple Knight Key trade logic has TODO about retail accuracy |
| RQ4_His_Name_is_Valgeir | Exp reward (2000) given via `player:addExp()` in onEventFinish rather than through quest.reward table |

## TODOs in Code

| Script | Line(s) | TODO Description |
|--------|---------|------------------|
| A_Hard_Days_Knight | 104, 137 | Single-trade event verification; forced zoning events need capture check |
| Confessions_of_a_Bellmaker | 57 | Determine if message displays on NM pop |
| Monstrosity | 176 | Character appearance encoding for CS |
| Monstrosity | 214 | Event 886 may be once-per-zone |
| Monstrosity | 191-193 | Post-complete Suspicious NPC items need work |
| RQ7_The_Basics | 80 | Ferry free ride details unknown |
| Tango_with_a_Tracker | 6-8 | Exact quest start unknown; quest log timing |
| Test_My_Mettle | 156 | Jar's default action unknown |
| The_Rescue | 27 | Fame requirement needs verification |
| Under_the_Sea | 10 | Quest log timing unclear |
| Uninvited_Guests | 9-10 | Full rewards and ROE rewards not implemented |

## Key Quests NOT in otherAreas

The following quests referenced in the audit request are located in other quest folders:

| Quest | Folder | File |
|-------|--------|------|
| Elder Memories (sub-job) | otherAreas (ID 24) | **NOT CONVERTED** -- no script file, uses legacy system |
| The Sacred Katana (SAM unlock) | outlands | SAM_AF1_The_Sacred_Katana.lua |
| Ayame and Kaede (NIN unlock) | bastok | Ayame_and_Kaede.lua |
| Lakeside Minuet (DNC unlock) | jeuno | Lakeside_Minuet.lua |
| A Little Knowledge (SCH unlock) | crystalWar | A_Little_Knowledge.lua |
| Avatar prime fights | outlands/jeuno | Individual trial quest scripts |
| Magian Trial starter | N/A | No quest script found in any folder |

## Equipment Reward Mod Verification

All equipment item rewards were checked against `sql/item_mods.sql`:

| Item | Quest | Mods Present |
|------|-------|-------------|
| Yinyang Lorgnette | A_Bitter_Past | YES |
| Minstrel's Dagger | Confessions_of_a_Bellmaker | YES |
| Jaguar Mantle | For_The_Birds | YES |
| Elegant Ribbon | Elderly_Pursuits | YES |
| Gramary Cape | In_Search_of_the_Truth | YES |
| Memento Muffler | The_Call_of_the_Sea | YES |
| Powerful Rope | Petals_for_Parelbriaux | YES |
| Sleep Dagger | The_Gift | YES |
| Carbuncle's Pole | Waking_the_Beast | YES |

## Rycharde Quest Chain Integrity

The 7-quest Rycharde cooking chain (RQ1-RQ7) is fully implemented with proper:
- Sequential prerequisite checks
- Vanadiel day wait timers between quests
- Fame requirements escalating from none to level 5
- DayCompleted variable cleanup between chain links
- Time-limit mechanics (RQ2)
