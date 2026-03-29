# Commented-Out Gameplay Code Sweep
**Date:** 2026-03-29
**Branch:** develop
**Scope:** ALL zone scripts (IDs.lua, npcs/, mobs/, Zone.lua), global scripts

---

## EXECUTIVE SUMMARY

Comprehensive sweep of the codebase for commented-out gameplay code, empty handlers, and TODO markers indicating incomplete logic. Findings sorted by severity.

**Totals:** 4 CRITICAL, 8 MODERATE, 12 LOW

---

## CRITICAL FINDINGS (Blocks Gameplay)

### C1. Apollyon Zone.lua -- ALL Floor Teleporters Commented Out
- **File:** `scripts/zones/Apollyon/Zone.lua` (lines 57-159)
- **Issue:** The entire `onTriggerAreaEnter` handler is commented out. This means:
  - SE/NE/SW/NW Apollyon floor teleporters do NOT work
  - Players cannot progress between Limbus floors
  - Trigger areas are registered (lines 17-36) but never acted upon
- **Root Cause:** Commit `5420aae4ed` intentionally disabled Limbus. The IDs.lua has 203/245 lines commented out (83%).
- **Impact:** Limbus (Apollyon + Temenos) is completely non-functional
- **Note:** This was an intentional disable, not a regression. Re-enabling requires uncommenting IDs and Zone.lua handler, plus verifying NPC IDs are correct for current client version.

### C2. Temenos IDs.lua -- Entire Limbus Data Tables Commented Out
- **File:** `scripts/zones/Temenos/IDs.lua` (171/206 lines commented = 83%)
- **Issue:** LINKED_CRATES, RECOVER_CRATES, TIME_CRATES, TEMENOS_WESTERN_TOWER mob/npc data all commented
- **Cross-reference:** `scripts/zones/Temenos/npcs/Scanning_Device.lua` references `[TEMENOS_WESTERN_TOWER]Time` server variable but the mob/NPC IDs for actual Temenos content are disabled
- **Impact:** All Temenos floors non-functional (blocks Homam/Nashira gear, upgrade path to Abjuration armor)

### C3. QuBia Arena Burning Circle -- ACP Mission BCNM Disabled
- **File:** `scripts/zones/QuBia_Arena/npcs/Burning_Circle.lua` (lines 10-12)
- **Code:** `onTrigger` has the ACP mission check + `startEvent(5)` commented out with note "Temp disabled pending fixes for the BCNM mobs"
- **Impact:** ACP mission "Those Who Lurk in Shadows II" cannot be entered or completed. Blocks all subsequent ACP progression.

### C4. Qufim Island qm3 -- ACP Seed Mandragora Battle Stub
- **File:** `scripts/zones/Qufim_Island/npcs/qm3.lua` (lines 43-65)
- **Issue:** `GATHERER_OF_LIGHT_II` handler prints "Confrontation Battles are not working yet" instead of spawning mobs. The repeat Amber Key logic (lines 56-65) is entirely commented out.
- **Impact:** ACP mission "Gatherer of Light II" uses a hacky workaround (sets/clears a var without actual combat). Amber Key repeats are broken. ACP story technically progresses but without actual gameplay.

---

## MODERATE FINDINGS (Reduces Functionality)

### M1. Ambuscade -- Heavily Incomplete
- **File:** `scripts/globals/ambuscade.lua`
- **Issues:**
  - `onTradeGorpaMasorpa` (line 28-30): TODO with no implementation for seal trades
  - `onEventUpdateTome` (line 134): TODO with no implementation for difficulty selection
  - `onEventFinishTome` (line 142): TODO for regular ambuscade entry
  - `onInstanceComplete` (line 152): Difficulty hardcoded to 1, version selection commented out
  - Abdhaljs Seal removal commented out (line 177)
- **Impact:** Ambuscade entry partially works but difficulty selection, regular mode, and seal mechanics are non-functional

### M2. Apollyon IDs.lua -- SE/NE/SW/NW Apollyon Data Commented
- **File:** `scripts/zones/Apollyon/IDs.lua` (203 commented lines)
- **Detail:** SE_APOLLYON, NE_APOLLYON, SW_APOLLYON, NW_APOLLYON, CENTRAL_APOLLYON portal/crate/mob data all commented
- **Impact:** Part of the Limbus disable (see C1/C2). Listed separately as the IDs would need to be re-verified against current client before uncommenting.

### M3. Southern San d'Oria Diary -- Page 5 Commented Out
- **File:** `scripts/zones/Southern_San_dOria/npcs/Diary.lua` (lines 40-41, 57-58)
- **Issue:** `diaryPage >= 4` branch with `startEvent(723)` is commented, and the corresponding `setCharVar('DiaryPage', 5)` in onEventFinish
- **Impact:** "Over The Hills And Far Away" quest chain may be incomplete -- players cannot read the final diary page. Quest itself completes via other NPCs, so this is a missing flavor element.

### M4. Chocobo Breeding (Finbarr) -- Mostly Non-Functional
- **File:** `scripts/zones/Upper_Jeuno/npcs/Finbarr.lua`
- **Issue:** `onTrade` handler is commented out (line 21). `onTrigger` always fires event 10103 (intro dialog) -- no breeding menu, no date selection, no egg hatching. All alternative events are commented out.
- **Impact:** Chocobo breeding system is a stub. Only the purchase menu (10108) in onEventFinish is implemented, but it's unreachable since onTrigger never starts event 10108.

### M5. Chocobo Registration (Mapitoto) -- TODO
- **File:** `scripts/zones/Upper_Jeuno/npcs/Mapitoto.lua` (line 79)
- **Issue:** `TODO: player:registerChocobo(info)` -- chocobo companion registration not implemented
- **Impact:** Players completing "Full Speed Ahead" quest cannot register their chocobo companion

### M6. Besieged -- Astral Candescence Hardcoded
- **File:** `scripts/globals/besieged.lua` (line 96-98)
- **Issue:** `getAstralCandescence()` returns hardcoded 1. TODO note says "Implement Astral Candescence"
- **Impact:** Besieged outcome mechanics are simplified/static

### M7. Ixaern DRK -- Add Despawn on Death Commented
- **File:** `scripts/zones/The_Garden_of_RuHmet/mobs/Ixaern_DRK.lua` (lines 78-79)
- **Issue:** `DespawnMob(QnAernA)` and `DespawnMob(QnAernB)` are commented out in the death handler
- **Impact:** Qn'Aern adds may persist after Ix'Aern DRK is killed. Minor gameplay issue but could confuse players.

### M8. Bhaflau Remnants Troll Engraver -- Pet Spawn Commented
- **File:** `scripts/zones/Bhaflau_Remnants/mobs/Troll_Engraver.lua` (line 13)
- **Issue:** `mob:setPet(GetMobByID(mob:getID() + 1, instance))` is commented out
- **Impact:** Salvage Troll Engravers don't have their pet mobs, making encounters easier than intended

---

## LOW FINDINGS (Cosmetic/Minor)

### L1. Past Event Watcher NPCs -- Missing CSIDs for Some Replays
- **Files:**
  - `scripts/zones/Bastok_Markets/npcs/Lamepaue.lua` -- "The First Meeting", "All by Myself", "Dancer Attire", "Records of Eminence", "Trust (Mumor)", "Unity Concord", "Rumors from the West" all commented with `*Need the correct csid` or `*not yet defined`
  - `scripts/zones/Northern_San_dOria/npcs/Durogg.lua` -- "Hasten! In a Jam in Jeuno?", "Rumors from the West" commented
  - `scripts/zones/Port_Bastok/npcs/Dalba.lua` -- "Trial by Earth", "Out of the Depths pt.2", "Chasing Dreams", "Monstrosity", "Hasten! In a Jam in Jeuno?" commented
- **Impact:** These NPCs replay past cutscenes. Missing entries mean some completed quests/missions can't be re-watched. Does not block gameplay.

### L2. Deraquien (S. San d'Oria) -- Quest CS References at Bottom
- **File:** `scripts/zones/Southern_San_dOria/npcs/Deraquien.lua` (lines 29-39)
- **Issue:** 10 startEvent calls commented at bottom of file, referencing quest "Thief of Royal Sceptre" chain
- **Impact:** These are documentation/reference comments outside any handler. NPC currently only handles Lure of the Wildcat. The referenced quests are likely handled in quest scripts. LOW.

### L3. Windurst Walls NPCs -- Quest Event Reference Comments
- **Files:** Kalupa-Tawalupa.lua, Raamimi.lua, Rutango-Botango.lua, Zayhi-Bauhi.lua
- **Issue:** Commented startEvent calls documenting "Too Bee or Not Too Bee" quest CS flow
- **Impact:** Documentation only. The actual quest logic is in the quest script. NO gameplay impact.

### L4. Jarafah (Aht Urhgan Whitegate) -- Item Depository Not Implemented
- **File:** `scripts/zones/Aht_Urhgan_Whitegate/npcs/Jarafah.lua`
- **Issue:** NPC triggers intro event but onEventFinish has TODO for actual item depository logic
- **Impact:** Race-change item swap system unavailable. Extremely niche feature.

### L5. Rala Waterways Antiquated Sluice Gate -- Debug Prints
- **File:** `scripts/zones/Rala_Waterways/npcs/Antiquated_Sluice_Gate.lua`
- **Issue:** Contains `print(1)` and `print(2)` debug statements, plus a commented TODO about instance failure
- **Impact:** Debug output in server logs. Gate functionality appears to work via xi.instance system.

### L6. Aht Urhgan Whitegate Shops -- Stock TODO
- **Files:** Hagakoff.lua, Kulh_Amariyo.lua, Mulnith.lua, Rubahah.lua, Saluhwa.lua (all in Aht_Urhgan_Whitegate/npcs/)
- **Issue:** TODO comments about stock modification based on nation control/besieged status
- **Impact:** Shops always have full stock regardless of besieged state. Player-favorable.

### L7. Garlaige Citadel Zone.lua -- Lever Deactivation TODO
- **File:** `scripts/zones/Garlaige_Citadel/Zone.lua` (line 91-93)
- **Issue:** TODO about lever deactivation timing when related door is open
- **Impact:** Banishing gate levers may not perfectly match retail behavior in edge cases.

### L8. Al Zahbi Gajaad -- Besieged Trade Check TODO
- **File:** `scripts/zones/Al_Zahbi/npcs/Gajaad.lua` (line 43)
- **Issue:** TODO about besieged result affecting NPC trade acceptance
- **Impact:** NPC always accepts trades regardless of besieged outcome.

### L9. Caskets -- Evolith System Not Implemented
- **File:** `scripts/globals/caskets.lua` (line 84, 627)
- **Issue:** EVOLITH reward type marked "not implemented", augment flag for evoliths commented
- **Impact:** Evoliths don't drop from caskets. Minor augment system gap.

### L10. Shami (Port Jeuno) -- First-Time Dialog TODO
- **File:** `scripts/zones/Port_Jeuno/npcs/Shami.lua` (line 101)
- **Issue:** TODO for first-time-with-seal dialog variant. Current code skips to standard menu.
- **Impact:** Cosmetic -- misses one dialog variant on first visit.

### L11. Assault Armband Deletion Commented
- **Files:** Meyaada.lua (Arrapago_Reef), Daswil.lua (Bhaflau_Thickets), Nahshib.lua, Nareema.lua (Caedarva_Mire)
- **Issue:** `player:delKeyItem(xi.ki.ASSAULT_ARMBAND)` commented out in assault entry NPCs
- **Impact:** Assault Armbands may not be consumed on entry. Player-favorable bug.

### L12. Sorrowful Sage -- Assault Point Check Commented
- **File:** `scripts/zones/Aht_Urhgan_Whitegate/npcs/Sorrowful_Sage.lua` (line 13)
- **Issue:** Token count from `getAssaultPoint()` commented, hardcoded to 3
- **Impact:** May affect assault point exchange logic.

---

## VERIFICATION METHODOLOGY

1. **IDs.lua sweep:** `grep -rn '^\s*--\s*\[' scripts/zones/*/IDs.lua` -- Found Apollyon (203 commented lines) and Temenos (171 commented lines) as major hits. Inner Horutoto Ruins hit was a harmless block comment documenting mob offsets.

2. **NPC startEvent sweep:** `grep -rn '^\s*--.*startEvent\|^\s*--.*player:' scripts/zones/*/npcs/*.lua` -- 80+ hits across 40+ files. Filtered by checking if entire handlers were disabled vs. documentation/alternative event references.

3. **Mob death/spawn sweep:** `grep -rn '^\s*--.*onMobDeath\|^\s*--.*SetServerVariable\|^\s*--.*SpawnMob' scripts/zones/*/mobs/*.lua` -- Only 1 meaningful hit (Ixaern DRK despawn). Absolute Virtue hit was a dev `!exec` comment.

4. **Empty handler sweep:** Checked all onTrigger handlers for immediate `end` on next line. Found 3 files; verified 2 were intentional (quest logic in separate files), 1 was a stub (Phomiuna Aqueducts door).

5. **TODO/FIXME sweep:** `grep -rn 'TODO\|FIXME'` across all zone and global scripts. 100+ hits total. Filtered for those inside active handler code paths that indicate incomplete logic.

6. **Cross-reference with upstream:** Verified Apollyon/Temenos commented code matches an intentional disable commit (`5420aae4ed`). Upstream diff shows only a text ID shift, confirming commented data is upstream-inherited.

---

## PRIORITY RECOMMENDATIONS

| Priority | Finding | Action |
|----------|---------|--------|
| 1 | C1+C2+M2: Limbus disabled | Decide if Limbus is desired content. If yes, verify IDs against current client, uncomment data tables and Zone.lua handler. |
| 2 | C3+C4: ACP missions broken | Fix Burning Circle BCNM entry and Seed Mandragora confrontation battle |
| 3 | M1: Ambuscade incomplete | Major modern endgame content with multiple TODOs. Needs dedicated implementation effort. |
| 4 | M4+M5: Chocobo systems | Breeding is a stub, registration not implemented. Low priority for 4-player server. |
| 5 | M7+M8: Mob behavior | Uncomment despawn/pet calls for accurate encounters |
