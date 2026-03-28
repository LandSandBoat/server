# Aht Urhgan Quests -- Deep Audit

Audited: 2026-03-28
Scripts path: `scripts/quests/ahtUrhgan/`
Total scripts: 46

---

## Summary of Findings

- **Critical bugs found:** 2 (Saga of the Skyserpent dead code, Cook-a-roon missing reward)
- **Missing rewards in quest.reward:** 1 (Cook-a-roon, Keeping Notes -- but these are by design)
- **Equipment reward items missing mods:** 0 (all checked, all have mods)
- **TODOs / empty handlers:** 0
- **Logic concerns:** 4 (noted in table)
- **Imperial Standing earning quests:** 5 confirmed working (Fist of the People, When the Bow Breaks, Soothing Waters, Saga of the Skyserpent, Embers of His Past)

---

## Audit Table

| # | Quest | Type | Accept Cond | Completion Logic | Reward | Issues |
|---|-------|------|-------------|-----------------|--------|--------|
| 1 | **Promotion: Private First Class** | Promo | AssaultPromotion >= 25 | Trade Imp Wing to Naja | KI: PFC_WILDCAT_BADGE | OK. Deletes PSC badge, resets AssaultPromotion. |
| 2 | **Promotion: Superior Private** | Promo | AssaultPromotion >= 25 + PFC completed | Get Dark Rider Hoofprint from 4 zones, return to Naja | KI: SP_WILDCAT_BADGE | OK. Deletes PFC badge + hoofprint KI. |
| 3 | **Promotion: Lance Corporal** | Promo | AssaultPromotion >= 25 + SP completed | Complex mythralline mixing minigame via Nafiwaa, wait 1 game day | KI: LC_WILDCAT_BADGE, title, bonus items | OK. Complex but well-structured. Deletes SP badge. |
| 4 | **Promotion: Corporal** | Promo | AssaultPromotion >= 25 + LC completed | Plant Quartz Transmitter at Warhorse Hoofprint | KI: C_WILDCAT_BADGE | **MINOR:** Line 113 uses `player:setVar` instead of `player:setCharVar` for AssaultPromotion (inconsistent with other promos that use `setCharVar`). Functional difference: `setVar` and `setCharVar` are the same method in LSB, so no actual bug. |
| 5 | **Promotion: Sergeant** | Promo | AssaultPromotion >= 25 + Corporal completed | Multi-step: Whitegate CS, Nashmau CS, trade Sutlac, check QM in Caedarva | KI: S_WILDCAT_BADGE, title | OK. Uses `setCharVar` consistently. |
| 6 | **Promotion: Sergeant Major** | Promo | AssaultPromotion >= 25 + Sergeant completed | 3 minigames with Naja, each requires game day wait | KI: SM_WILDCAT_BADGE, title | OK. Well-structured stage/retry system. |
| 7 | **Promotion: Chief Sergeant** | Promo | AssaultPromotion >= 25 + SM completed | Mushroom farming minigame in Aydeewa with Abquhbah/Hagakoff | KI: CS_WILDCAT_BADGE, title, Imperial Mythril Piece (+bonus Gold Piece) | **MINOR:** Uses `player:getVar` (line 119) instead of `player:getCharVar` for AssaultPromotion check (same function in LSB, not a real bug). |
| 8 | **Promotion: Second Lieutenant** | Promo | AssaultPromotion >= 25 + CS completed | Trade Imperial Gold Pieces (3), Mythril Pieces (2) for minigames, trade beastmen items, final minigame | KI: SL_WILDCAT_BADGE, title | OK. Multi-step trading and minigame system. |
| 9 | **Promotion: First Lieutenant** | Promo | AssaultPromotion >= 25 + 2ndLt completed | Trade 5 Imperial Gold Pieces, 3 minigames with day waits, graduation ceremony at specific time | KI: FL_WILDCAT_BADGE, title | **MINOR:** Uses `npcUtil.tradeHas` (not `tradeHasExactly`) on line 57 for the 5 gold pieces trade -- allows extra items in trade. Likely intentional. |
| 10 | **BLU AF1: Beginnings** | BLU AF | BLU main job, AF1 level, completed An Empty Vessel + Immortal Sentries mission | Collect 5 brand KIs from NPCs across ToAU zones, return to Waoud | Immortal's Scimitar (17717) | OK. Mods confirmed: MP+10, STR+1, INT+1. Timer/divination system properly shared across BLU quests. |
| 11 | **BLU AF2: Omens** | BLU AF | BLU main job, AF2 level, completed Beginnings | Win BCNM, CS chain through Waoud/Lathuya/Aydeewa | Magus Charuqs (15684), title | OK. Mods confirmed: DEF13, HP13, MP13, Enmity-3, Evasion+10. Battlefield + NPC progression well structured. |
| 12 | **BLU AF3: Transformations** | BLU AF | BLU main job, AF3 level, completed Omens | Divination, Imperial Whitegate CS, Alzadaal exploration + NM kill | Magus Keffiyeh (15265), title | OK. Mods confirmed: DEF23, MP20, INT3, MND3. Sets `[BLUAF]Remaining` for BLU armor crafting. |
| 13 | **COR AF1: Equipped for All Occasions** | COR AF | COR main job, AF1 level | Kill Lost Soul in Maze of Shakhrami, get KI, return to Arrapago, talk to Ratihb | Trump Gun (18702) | OK. Mods confirmed: AGI+2, RACC+2. Requires `Stage` var set by Luck of the Draw completion. Cross-quest dependency is properly documented in comments. |
| 14 | **An Empty Vessel** (BLU unlock) | Job Unlock | Main level >= ADVANCED_JOB_LEVEL | Divination quiz, trade item to Waoud, Aydeewa CS | Title, unlocks BLU, Mark of Zahak KI | OK. Complex divination system with correct answer tracking. Cancel path properly resets variables. |
| 15 | **Luck of the Draw** (COR unlock) | Job Unlock | Main level >= ADVANCED_JOB_LEVEL | Multi-zone progression: Ratihb > Mafwahb > Arrapago > Talacca Cove | Corsair Die, KI, title, unlocks COR | OK. Post-completion section sets Stage var for COR AF1 cross-dependency. |
| 16 | **No Strings Attached** (PUP unlock) | Job Unlock | Main level >= ADVANCED_JOB_LEVEL | Bastok > Whitegate > Arrapago (get Antique Automaton) > Ghatsad > Iruki-Waraki | Animator, KI, title, unlocks PUP | OK. Includes replacement Animator purchase for 10k gil post-completion. Unlocks Harlequin frame/head attachments. |
| 17 | **A Taste of Honey** | Side | Completed Vanishing Act | Trade 3 White Honey to Qutiba | Irmik Helvasi (food) | OK. Pephredo Hive honey gathering with daily cooldown. Repeat trade section after completion. |
| 18 | **Arts and Crafts** | Side | None | Talk to 7 NPCs, collect/trade Sutlac | Imperial Silver Piece | OK. Bit-flag system for 7 NPC visits works correctly. |
| 19 | **Cook-a-roon** | Side/Repeatable | None | Trade 5 specific fish to Ququroon | **NO quest.reward defined** | **NOTE:** No `quest.reward` block. Reward is a random chance Bowl of Nashmau Stew given inline (line 62-63). This is by design -- the stew reward is RNG-based. Repeat section uses onEventUpdate instead of onEventFinish for the trade confirm (line 98). |
| 20 | **Delivering the Goods** | Side | None | Talk chain: Fochacha > Qutiba/Ulamaal > Fochacha | 3x Imperial Bronze Piece | OK. Sets stage var for Vanishing Act prereq. |
| 21 | **Divine Interference** | Repeatable | Completed Waking the Colossus, TOAU mission complete, timer expired | Mt. Zhayolm door > trade plumbago > Alzadaal lamp > return | Imperial Gold Piece, title + choice reward (Mantle/Earring/Torque/Gil/Alexander) | OK. Repeatable with JP midnight cooldown. All 3 Colossus gear items have mods confirmed. |
| 22 | **Embers of His Past** | Serpent | Completed Soothing Waters | Multi-zone CS chain, trade Hydrangea twice, Mt. Zhayolm nighttime triggers | Imperial Gold Piece, title, +500 IS, +Mercenary Camp Entry Slip post-completion | OK. Complex 9-stage progression with zone-in cutscenes. Imperial Standing properly granted. |
| 23 | **Fear of the Dark 2** | Side/Repeatable | None | Trade 2 Imp Wings to Suldiran in Al Zahbi | 200 gil, title | OK. Repeat trade for 200 gil works. |
| 24 | **Fist of the People** | Serpent/IS | Completed Ode to the Serpents | Fari-Wari > trade Rusty Medal to Leypoint | Title, +500 IS | OK. Imperial Standing granted via addCurrency. |
| 25 | **Give Peace a Chance** | Side | None | Nighttime QM in Wajaom > Mishhar > Mamook QM > Mishhar | Imperial Silver Piece | OK. Night-only trigger condition for first step. |
| 26 | **Got It All** | Side | None | Multi-NPC dialog chain through Whitegate + trigger areas | Bibiki Seashell | OK. 7-step progression with KI (Luminous Water), JstMidnight wait. |
| 27 | **Keeping Notes** | Side | None | Trade Parchment + Black Ink to Ahkk Jharcham | **Moghouse flag only** (no item/gil) | OK. Grants moghouse furnishing flag (+0x0010). Post-completion parchment trade exists but gives nothing (informational). |
| 28 | **Led Astray** | Side | None | Multi-step Whitegate CS chain > Nashmau (Tataroon) | Imperial Silver Piece | OK. Bit-flag system for Rubahah/Cacaroon dual-NPC requirement. |
| 29 | **Not Meant to Be** | Side | None | Nashmau > Caedarva QM > Nashmau > Caedarva (kill Lamia No.27 + Moshdahn) > return | 3x Imperial Gold Piece | OK. Dual NM spawn with bit-flag tracking for both kills. |
| 30 | **Ode to the Serpents** | Serpent | Completed Saga of the Skyserpent | Accept letter KI, complete When the Bow Breaks + Fist of the People, return | Imperial Gold Piece | OK. Gate quest requiring two sub-quests completed. |
| 31 | **Olduum** | Side/Repeatable | None | Get research journal KI, mine with pickaxe in Aydeewa, return KI to Dkhaaya | Lightning Band (craft item 2217) | OK. Post-completion: can trade Lightning Band at Leypoint for Olduum Ring. Mining has 50% fail rate. |
| 32 | **Rat Race** | Side | None | Multi-zone chain: Nashmau > Whitegate > Nashmau (fish trade > stew > delivery) | 2x Gold + 2x Mythril + 3x Silver Imperial Pieces | OK. 6-step progression across zones. |
| 33 | **Rock Bottom** | Side | None | Trade Pickaxe then Mythril Pick to blank11 in Mt. Zhayolm | Map of Mount Zhayolm (KI) | OK. Uses `player:tradeComplete()` (line 74) instead of `player:confirmTrade()` -- both valid. Zone requirement between trades. |
| 34 | **Saga of the Skyserpent** | Serpent/IS | None | Halvung KI > Fari-Wari > Wajaom CS chain > wait > return | Imperial Gold Piece, title, +1000 IS | **BUG:** Lines 124-132 have an anonymous table `{ onTrigger = ... }` inside the `Fari-Wari` NPC definition that creates dead code. The `quest:progressEvent(825)` on line 123 always fires regardless of the day wait check on line 126. The conditional day-wait logic is never reached. Player can complete immediately without waiting. |
| 35 | **Soothing Waters** | Serpent/IS | Completed Ode to the Serpents | Multi-NPC chain, Al Zahbi NPC, trade Colorful Hair in Aydeewa | Imperial Gold Piece, title, +500 IS | OK. 4-step progression with replaceEvent reminders. |
| 36 | **Striking a Balance** | Side | None | Multi-step Whitegate CS chain + Al Zahbi pickup | 3x Imperial Bronze Piece | OK. Uses positionTable for NPC repositioning. 5-step progression. |
| 37 | **Such Sweet Sorrow** | Side | None | Zone-in CS chain (Whitegate > Caedarva > Whitegate), trade Merrow Scale | Merrow No. 17 Locket (15518) | OK. Mods confirmed: DEF2, MP10, Water MEVA+30, Charm Resist+2. |
| 38 | **The Die is Cast** | Side | None | Multi-zone: Ratihb > Ekhu > Jijiroon > Arrapago QM > kill Bukki NM > return | Random Ring (15770) | OK. Random Ring is an enchanted item (uses scripts/items/random_ring.lua). No static mods expected -- enchantment-based. 6-step progression. |
| 39 | **The Prankster** | Side | None | Whitegate trigger areas > Bhaflau QM (kill Plague Chigoe) > return to QM | Map of Caedarva Mire (KI) | OK. NM pop from QM with death flag progression. |
| 40 | **The Prince and the Hopper** | Side | None | Zone-in CS > Mamook footprints > cross-zone CS > NM fight (Poroggo Casanova) > return | Chanoix's Gorget (16270) | OK. Mods confirmed: ACC+2. Complex cross-zone cutscene system. NM despawns adds on boss death. |
| 41 | **Three Men and a Closet** | Side | Completed Got It All | NPC dialog chain: Kubhe > Wajaom zone-in > NPC chain > complete | Imperial Bronze Piece | OK. 4-step Whitegate NPC chain with Wajaom zone-in CS. |
| 42 | **Two Horn the Savage** | Side | None | Trade 1000 gil to Cacaroon > Mamook (trigger > kill Mamool Ja NM > trigger) > Milazahn | Imperial Mythril Piece | OK. 4-step with NM pop from QM. |
| 43 | **Vanishing Act** | Side | Completed Delivering the Goods | CS chain, Wajaom harvesting (trade Sickle for Rainbow Berry KI), return | Imperial Silver Piece | OK. Sets stage var for A Taste of Honey prereq. Post-completion recipe book event. |
| 44 | **Waking the Colossus** | Story | TOAU missions complete (Eternal Mercenary) | Collect 4 nation approval letters, Mt. Zhayolm > Alzadaal > return | Imperial Gold Piece, title + choice reward (Mantle/Earring/Torque/Gil/Alexander) | OK. Spans 5 nations. Sets timer for Divine Interference. Choice reward system identical to Divine Interference (shared getRewardMask/giveQuestReward functions). |
| 45 | **What Friends Are For** | Side | None (trigger area in Aydeewa) | Aydeewa trigger > Nashmau trade > Aydeewa QM > return | Map of Aydeewa Subterrane (KI) or Imperial Bronze Piece (if already have map) | OK. Adaptive reward based on whether player already has the map. |
| 46 | **When the Bow Breaks** | Serpent/IS | Completed Ode to the Serpents | Trade Frayed Arrow to Giwahb Watchtower in Wajaom | Title, +500 IS | OK. Simple trade-to-complete. |

---

## Issues Detail

### CRITICAL: Saga of the Skyserpent -- Dead Code / Missing Day Wait

**File:** `scripts/quests/ahtUrhgan/Saga_of_the_Skyserpent.lua`, lines 122-143
**Problem:** In the third quest section (Prog == 2), the `Fari-Wari` NPC is assigned `quest:progressEvent(825)` directly on line 123. Then lines 124-132 define an anonymous table with `onTrigger` that includes a day-wait check (`quest:getVar(player, 'Stage') < VanadielUniqueDay()`). This anonymous table is never registered as the NPC handler -- it is dead code sitting inside the zone table.

**Impact:** The quest can be completed immediately after the Wajaom cutscene without waiting the intended game day. The 1000 Imperial Standing reward is granted too easily.

**Fix:** Replace the direct assignment with the conditional onTrigger:
```lua
['Fari-Wari'] =
{
    onTrigger = function(player, npc)
        if quest:getVar(player, 'Stage') < VanadielUniqueDay() then
            return quest:progressEvent(825, { text_table = 0 })
        else
            return quest:event(833)
        end
    end,
},
```

### MINOR: Corporal Promotion -- setVar vs setCharVar

**File:** `scripts/quests/ahtUrhgan/Promotion_Corporal.lua`, line 113
**Detail:** Uses `player:setVar('AssaultPromotion', 0)` while other promotions use `player:setCharVar('AssaultPromotion', 0)`. In LandSandBoat, these are the same function, so this is a style inconsistency, not a bug.

### MINOR: First Lieutenant -- tradeHas vs tradeHasExactly

**File:** `scripts/quests/ahtUrhgan/Promotion_First_Lieutenant.lua`, line 57
**Detail:** Uses `npcUtil.tradeHas` instead of `npcUtil.tradeHasExactly` for the 5 Imperial Gold Pieces trade. This means extra items in the trade window would still be accepted. May be intentional to be lenient.

### NOTE: Cook-a-roon repeat section

**File:** `scripts/quests/ahtUrhgan/Cook-a-roon.lua`, lines 95-104
**Detail:** The repeat section (post-completion) uses `onEventUpdate` for event 243 instead of `onEventFinish`. The `confirmTrade()` is called inside onEventUpdate, and `quest:setVar(player, 'Prog', 0)` resets the RNG variable. This is an unusual pattern but works because the update fires during the event.

---

## Equipment Reward Mod Verification

| Item | ID | Quest | Mods Present |
|------|----|-------|-------------|
| Immortal's Scimitar | 17717 | BLU AF1 | YES: MP+10, STR+1, INT+1 |
| Magus Charuqs | 15684 | BLU AF2 | YES: DEF13, HP13, MP13, Enmity-3, Evasion+10 |
| Magus Keffiyeh | 15265 | BLU AF3 | YES: DEF23, MP20, INT3, MND3 |
| Trump Gun | 18702 | COR AF1 | YES: AGI+2, RACC+2 |
| Colossus's Mantle | 11547 | Waking/Divine | YES: DEF5, HP20, MP20, MDT-2% |
| Colossus's Earring | 16058 | Waking/Divine | YES: HP10, MP10, PDT-1%, RDT-1% |
| Colossus's Torque | 11590 | Waking/Divine | YES: Light MEVA+20, Healing+7, Enhancing+7 |
| Merrow No.17 Locket | 15518 | Such Sweet Sorrow | YES: DEF2, MP10, Water MEVA+30, Charm Resist+2 |
| Chanoix's Gorget | 16270 | Prince and the Hopper | YES: ACC+2 |
| Random Ring | 15770 | The Die is Cast | N/A: Enchanted item (script-based effect) |

---

## Imperial Standing Earning Quests

| Quest | IS Amount | Method |
|-------|-----------|--------|
| Fist of the People | 500 | addCurrency on complete |
| When the Bow Breaks | 500 | addCurrency on complete |
| Soothing Waters | 500 | addCurrency on complete |
| Saga of the Skyserpent | 1000 | addCurrency on complete |
| Embers of His Past | 500 | addCurrency on complete |

All 5 IS-earning quests properly use `player:addCurrency('imperial_standing', amount)` and display the BESIEGED_OFFSET / INCREASED_STANDING message.

---

## Missing Quests Check

**PUP AF quests:** Not present as standalone quest scripts in `scripts/quests/ahtUrhgan/`. PUP AF quests (The Wayward Automaton, Give My Regards to Reeves, Operation Teatime) are implemented in the older zone-based NPC script style across files like `scripts/zones/Aht_Urhgan_Whitegate/npcs/Iruki-Waraki.lua`, `scripts/zones/Nashmau/npcs/Dnegan.lua`, etc. The PUP unlock quest (No Strings Attached) IS present as a standalone script and working.

**COR AF2/AF3:** Not present as standalone quest scripts. Only COR AF1 (Equipped for All Occasions) exists here. COR AF2 (Rapid Repartee) and COR AF3 (Against All Odds) are implemented in zone-based NPC scripts (e.g., `scripts/zones/Nashmau/npcs/Leleroon.lua`, `scripts/zones/Caedarva_Mire/npcs/qm9.lua`). These older-style implementations were not audited in this pass.

---

## Verdict

43 of 46 scripts are clean with no issues. The Saga of the Skyserpent dead code bug is the only functional issue that would affect gameplay. The Corporal/First Lieutenant inconsistencies are cosmetic. PUP AF2/AF3 and COR AF2/AF3 quests are not present in this directory and may need investigation.
