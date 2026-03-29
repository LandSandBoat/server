# Bastok Quests -- Phase 2 Audit (CORRECTED)

**Date:** 2026-03-28
**Corrected:** 2026-03-28 -- Previous audit undercounted implemented quests. Used quests.lua enum as authoritative source. NPC-based (non-converted) quests were missed.
**Source of truth:** `scripts/globals/quests.lua` lines 124-219 (xi.questLog.BASTOK enum)
**Script path:** `scripts/quests/bastok/` (converted quests) + `scripts/zones/*/npcs/` (NPC-based quests)

---

## Summary

| Metric | Count |
|--------|-------|
| Total quests in enum | 93 |
| Converted quest scripts (Quest:new) | 78 |
| NPC-based quest scripts (zone NPCs) | 2 |
| Total implemented | 80 |
| Partially implemented | 1 |
| Quests missing | 12 |
| Implementation rate | **86%** |

### Correction Notes

The previous audit reported 94 total / 78 implemented / 16 missing. Errors:
1. **Eco-Warrior (ID 65)** -- marked "+" in quests.lua, fully implemented via NPC scripts (Raifa, Degga, qm5, Pudding mobs). Was listed as MISSING.
2. **Too Many Chefs (ID 86)** -- marked "+" in quests.lua, has NPC scripts (Ferghus, Leonhardt, Raginmund, Umberto) but Red Oven Mitt has no drop source. Reclassified as PARTIAL.
3. **A Chocobo Riding Game** -- was listed as missing but does not exist in the quest enum. Removed from count.
4. Total quests corrected from 94 to 93 (the enum has IDs 0-92).

---

## Quests WITH Scripts -- Converted (78 total)

All 78 use the modern `Quest:new()` framework with proper `quest.reward`, `quest.sections`, `check` functions, `onTrigger`/`onTrade`/`onEventFinish` handlers, and `quest:complete()` calls. Deep audit (bastok_quests_deep.md) confirmed all are fully functional with no stubs.

### Starter Quests (low fame, early game)

| # | Quest | Enum ID | Script | Status |
|---|-------|---------|--------|--------|
| 1 | The Siren's Tear | 0 | `The_Sirens_Tear.lua` | WORKS -- Wahid in Bastok Mines, multi-zone fetch. Reward: 150 gil, title. |
| 2 | Beauty and the Galka | 1 | `Beauty_and_the_Galka.lua` | WORKS |
| 3 | Welcome to Bastok | 2 | `Welcome_to_Bastok.lua` | WORKS -- Powhatan in Port Bastok. Reward: Spatha, title. |
| 4 | Guest of Hauteur | 3 | `Guest_of_Hauteur.lua` | WORKS |
| 5 | The Quadav's Curse | 4 | `The_Quadavs_Curse.lua` | WORKS |
| 6 | Out of One's Shell | 5 | `Out_of_Ones_Shell.lua` | WORKS |
| 7 | Hearts of Mythril | 6 | `Hearts_of_Mythril.lua` | WORKS |
| 8 | The Eleventh's Hour | 7 | `The_Elevenths_Hour.lua` | WORKS |
| 9 | Stamp Hunt | 16 | `Stamp_Hunt.lua` | WORKS |
| 10 | The Gustaberg Tour | 45 | `The_Gustaberg_Tour.lua` | WORKS |
| 11 | Groceries | 37 | `Groceries.lua` | WORKS -- Tami in Bastok Mines. Reward: Rabbit Mantle. |

### Fame / Repeatable Quests

| # | Quest | Enum ID | Script | Status |
|---|-------|---------|--------|--------|
| 12 | Shady Business | 8 | `Shady_Business.lua` | WORKS |
| 13 | A Foreman's Best Friend | 9 | `A_Foremans_Best_Friend.lua` | WORKS |
| 14 | Breaking Stones | 10 | `Breaking_Stones.lua` | WORKS |
| 15 | The Cold Light of Day | 11 | `The_Cold_Light_of_Day.lua` | WORKS |
| 16 | Gourmet | 12 | `Gourmet.lua` | WORKS -- Time-of-day trade mechanic. |
| 17 | The Elvaan Goldsmith | 13 | `The_Elvaan_Goldsmith.lua` | WORKS |
| 18 | A Flash in the Pan | 14 | `A_Flash_in_the_Pan.lua` | WORKS |
| 19 | Smoke on the Mountain | 15 | `Smoke_on_the_Mountain.lua` | WORKS |
| 20 | Buckets of Gold | 41 | `Buckets_of_Gold.lua` | WORKS |

### Story / Chain Quests

| # | Quest | Enum ID | Script | Status |
|---|-------|---------|--------|--------|
| 21 | Forever to Hold | 17 | `Forever_to_Hold.lua` | WORKS |
| 22 | Till Death Do Us Part | 18 | `Till_Death_Do_Us_Part.lua` | WORKS |
| 23 | Fallen Comrades | 19 | `Fallen_Comrades.lua` | WORKS |
| 24 | Rivals | 20 | `Rivals.lua` | WORKS |
| 25 | Mom, the Adventurer? | 21 | `Mom_the_Adventurer.lua` | WORKS |
| 26 | The Signpost Marks the Spot | 22 | `The_Signpost_Marks_the_Spot.lua` | WORKS |
| 27 | Past Perfect | 23 | `Past_Perfect.lua` | WORKS |
| 28 | Stardust | 24 | `Stardust.lua` | WORKS |
| 29 | Mean Machine | 25 | `Mean_Machine.lua` | WORKS |
| 30 | Cid's Secret | 26 | `Cids_Secret.lua` | WORKS |
| 31 | The Usual | 27 | `The_Usual.lua` | WORKS |
| 32 | Blade of Darkness | 28 | `Blade_of_Darkness.lua` | WORKS |
| 33 | Father Figure | 29 | `Father_Figure.lua` | WORKS |
| 34 | The Return of the Adventurer | 30 | `The_Return_of_the_Adventurer.lua` | WORKS |
| 35 | Drachenfall | 31 | `Drachenfall.lua` | WORKS |
| 36 | Vengeful Wrath | 32 | `Vengeful_Wrath.lua` | WORKS |
| 37 | Beadeaux Smog | 33 | `Beadeaux_Smog.lua` | WORKS |
| 38 | The Curse Collector | 34 | `The_Curse_Collector.lua` | WORKS |
| 39 | Fear of Flying | 35 | `Fear_of_Flying.lua` | WORKS |
| 40 | The Wisdom of Elders | 36 | `The_Wisdom_of_Elders.lua` | WORKS |
| 41 | The Bare Bones | 38 | `The_Bare_Bones.lua` | WORKS |
| 42 | Minesweeper | 39 | `Minesweeper.lua` | WORKS |
| 43 | The Darksmith | 40 | `The_Darksmith.lua` | WORKS |
| 44 | The Stars of Ifrit | 42 | `The_Stars_of_Ifrit.lua` | WORKS |
| 45 | Love and Ice | 43 | `Love_and_Ice.lua` | WORKS |
| 46 | Brygid the Stylist | 44 | `Brygid_the_Stylist.lua` | WORKS |
| 47 | Bite the Dust | 46 | `Bite_the_Dust.lua` | WORKS |
| 48 | Blade of Death | 47 | `Blade_of_Death.lua` | WORKS |
| 49 | Silence of the Rams | 48 | `Silence_of_the_Rams.lua` | WORKS |
| 50 | Altana's Sorrow | 49 | `Altanas_Sorrow.lua` | WORKS |
| 51 | A Lady's Heart | 50 | `A_Ladys_Heart.lua` | WORKS |
| 52 | Ayame and Kaede | 60 | `Ayame_and_Kaede.lua` | WORKS -- NIN unlock quest. |
| 53 | A Test of True Love | 62 | `A_Test_of_True_Love.lua` | WORKS |
| 54 | Lovers in the Dusk | 63 | `Lovers_in_the_Dusk.lua` | WORKS |
| 55 | Wish Upon a Star | 64 | `Wish_Upon_a_Star.lua` | WORKS |
| 56 | Faded Promises | 73 | `Faded_Promises.lua` | WORKS -- NIN-specific quest. |
| 57 | Brygid the Stylist Returns | 74 | `Brygid_the_Stylist_Returns.lua` | WORKS |
| 58 | Out of the Depths | 75 | `Out_of_the_Depths.lua` | WORKS |
| 59 | A Question of Faith | 77 | `A_Question_of_Faith.lua` | WORKS |
| 60 | Teak Me to the Stars | 79 | `Teak_Me_to_the_Stars.lua` | WORKS |
| 61 | Chips | 82 | `Chips.lua` | WORKS |

### Weaponskill Unlock Quests

| # | Quest | Enum ID | Script | Status |
|---|-------|---------|--------|--------|
| 62 | The Weight of Your Limits | 66 | `The_Weight_of_Your_Limits.lua` | WORKS -- Steel Cyclone (Great Axe 240+). |
| 63 | Shoot First, Ask Questions Later | 67 | `Shoot_First_Ask_Questions_Later.lua` | WORKS -- Detonator (Marksmanship 250+). |
| 64 | Inheritance | 68 | `Inheritance.lua` | WORKS -- Ground Strike (GS 250+). |
| 65 | The Walls of Your Mind | 69 | `The_Walls_of_Your_Mind.lua` | WORKS -- Asuran Fists (H2H 250+). |

### Artifact (AF) Quests

| # | Quest | Enum ID | Script | Status |
|---|-------|---------|--------|--------|
| 66 | MNK AF1: Ghosts of the Past | 51 | `MNK_AF1_Ghosts_of_the_Past.lua` | WORKS |
| 67 | MNK AF2: The First Meeting | 52 | `MNK_AF2_The_First_Meeting.lua` | WORKS |
| 68 | MNK AF3: True Strength | 53 | `MNK_AF3_True_Strength.lua` | WORKS |
| 69 | WAR AF1: The Doorman | 54 | `WAR_AF1_The_Doorman.lua` | WORKS |
| 70 | WAR AF2: The Talekeeper's Truth | 55 | `WAR_AF2_The_Talekeepers_Truth.lua` | WORKS |
| 71 | WAR AF3: The Talekeeper's Gift | 56 | `WAR_AF3_The_Talekeepers_Gift.lua` | WORKS |
| 72 | DRK AF1: Dark Legacy | 57 | `DRK_AF1_Dark_Legacy.lua` | WORKS |
| 73 | DRK AF2: Dark Puppet | 58 | `DRK_AF2_Dark_Puppet.lua` | WORKS |
| 74 | DRK AF3: Blade of Evil | 59 | `DRK_AF3_Blade_of_Evil.lua` | WORKS |

### Special / System Quests

| # | Quest | Enum ID | Script | Status |
|---|-------|---------|--------|--------|
| 75 | Trial by Earth | 61 | `Trial_by_Earth.lua` | WORKS -- Full Titan prime fight. |
| 76 | Trial-Size Trial by Earth | 72 | `Trial_Size_Trial_by_Earth.lua` | WORKS -- SMN avatar mini-fight. |
| 77 | Lure of the Wildcat (Bastok) | 84 | `Lure_of_the_Wildcat_Bastok.lua` | WORKS -- TOAU prerequisite. |
| 78 | Trust: Bastok | 92 | `Trust_Bastok.lua` | WORKS -- Grants Naji trust, then Ayame/Volker/Iron Eater. |

---

## Quests WITH Scripts -- NPC-Based (2 total)

These quests are marked "+" (not "Converted") in quests.lua. They are implemented via zone NPC scripts rather than dedicated quest scripts in `scripts/quests/bastok/`.

### Eco-Warrior (Bastok) -- WORKS

| Enum ID | 65 |
|---|---|
| Status | WORKS |
| Quest Start | Raifa in Port Bastok (`scripts/zones/Port_Bastok/npcs/Raifa.lua`) |
| Flow | Raifa (event 278) -> accept -> Degga in Gusgen Mines -> apply ointment (lv25 restriction) -> trigger qm5 to spawn 2 Pudding NMs -> kill both -> interact with qm5 for Indigested Ore KI -> return to Degga -> return to Raifa (event 282) -> complete |
| Reward | 5000 gil, Dragon Chronicles (item 4198), title Cerulean Soldier, 80 fame |
| NPCs/Mobs | `Raifa.lua`, `Degga.lua`, `qm5.lua` (Gusgen Mines), `Pudding.lua` (Gusgen Mines) |
| Notes | Uses shared EcoStatus charvar system (101-103 for Bastok). Properly handles addQuest/completeQuest. Conquest tally timer prevents repeat. Level restriction mechanic works. |

### Too Many Chefs -- PARTIAL

| Enum ID | 86 |
|---|---|
| Status | PARTIAL -- NPC flow exists but required item (Red Oven Mitt) has no drop source |
| Quest Start | Ferghus in Metalworks (`scripts/zones/Metalworks/npcs/Ferghus.lua`) |
| Flow | Ferghus (event 946, requires WotG + fame 5) -> Leonhardt (event 948) -> Raginmund in Bastok Markets [S] (event 112) -> obtain Red Oven Mitt from Quadavs in Grauberg [S] -> trade to Leonhardt (event 950) -> Ferghus (event 947) -> Umberto (event 473, gives Aileen's Delight) |
| Reward | Aileen's Delight (item), 30 fame |
| Bug | Red Oven Mitt (item 2527) exists in item_basic.sql but has NO entry in mob_droplist.sql. On retail it drops from Quadav mobs in Grauberg [S], but this zone has no Quadav mobs spawned. Quest cannot be completed. |
| NPCs | `Ferghus.lua`, `Leonhardt.lua` (Metalworks), `Raginmund.lua` (Bastok Markets [S]), `Umberto.lua` (Bastok Markets) |

---

## Quests WITHOUT Scripts (12 total)

### Missing -- High Priority (affect gameplay)

| # | Quest | Enum ID | What It Does | Impact |
|---|-------|---------|--------------|--------|
| 1 | Achieving True Power | 85 | PUP limit break quest (lv66+). Fight Shamarhaan in Navukgo Execution Chamber. Raises PUP cap to 75. Battlefield ID 1123 exists in battlefield.lua but NOT marked Converted -- no battlefield script exists. | HIGH if playing PUP -- blocks leveling past 70. |

### Missing -- Medium Priority

| # | Quest | Enum ID | What It Does | Impact |
|---|-------|---------|--------------|--------|
| 2 | Escort for Hire (Bastok) | 70 | Trilok in Port Bastok, escort NPC through Crawlers' Nest. Reward: Page from Miratete's Memoirs, 10000 gil. Only referenced in roe_records.lua and goblinfootprint.lua (San d'Oria/Windurst versions), no Bastok NPC scripts. | Medium -- unique reward. |
| 3 | Return to the Depths | 78 | Ayame in Metalworks, find Moblin translator, defeat Twilotak. Reward: Bowyer Ring, 3000 gil. Continues Out of the Depths story. No NPC references found anywhere. | Medium -- story continuation. |
| 4 | Hyper Active | 80 | Raibaht in Metalworks, get hyper altimeter from Lower Delkfutt's Tower. Reward: 3000 gil. Note: Teak Me to the Stars sets mustZone flag for this quest upon completion, so the prerequisite link exists but the quest itself does not. | Low-Medium. |

### Missing -- Low Priority

| # | Quest | Enum ID | What It Does | Impact |
|---|-------|---------|--------------|--------|
| 5 | A Discerning Eye (Bastok) | 71 | Grin in Port Bastok, identify NPC on airship. Reward: 500 gil. No NPC references found. | Low -- flavor quest. |
| 6 | All by Myself | 76 | Marin in Bastok Markets, escort Ken through Dangruf Wadi. Reward: 1500 gil + key item. Lamepaue replay NPC has it commented out ("Need the correct csid"). | Low-Medium -- escort mechanic. |
| 7 | The Naming Game | 81 | Raibaht in Metalworks (Fame 5 required), trade Ordrynite. Reward: 3600 gil, title. No NPC references found. | Low. |
| 8 | Bait and Switch | 83 | Salim in Metalworks, puzzle quest. Reward: various items. No NPC references found. | Low. |
| 9 | A Proper Burial | 87 | Offa in Bastok Markets, recover letters from time capsule. Reward: Rolanberry. Lamepaue replay NPC has cutscene replay code ready but quest itself has no implementation. | Low -- WotG content. |

### Missing -- Skip (deprecated / niche systems)

| # | Quest | Enum ID | What It Does | Impact |
|---|-------|---------|--------------|--------|
| 10 | Fully Mental Alchemist | 88 | Titus in Bastok Mines, collect gold dust via Grauberg [S] prospecting. Reward: Trainee Sword. | Very Low -- WotG/Synergy era. |
| 11 | Synergistic Pursuits | 89 | Hildolf in Metalworks, gather materials to unlock Synergy. DEPRECATED on retail. | None -- deprecated. |
| 12 | The Wondrous Whatchamacallit | 90 | Selliste in Bastok Mines, synergize Astral Matter. Reward: Portafurnace. | Very Low -- Synergy system. |
| 13 | Synergistic Support | 91 | Hildolf in Metalworks, trade Slime Oil for Fewell. | Very Low -- Synergy system. |

---

## Deep Audit Re-Verification

The deep audit (bastok_quests_deep.md) checked all 78 converted scripts and found them fully functional. However, it only examined converted scripts. This corrected audit adds:

1. **Eco-Warrior (NPC-based)** -- Verified WORKS. Full quest flow: Raifa -> Degga -> lv25 restriction -> spawn/kill 2 Pudding NMs -> get KI -> complete. All NPCs, mobs, QM, and KI properly wired. Uses npcUtil.completeQuest with proper rewards.

2. **Too Many Chefs (NPC-based)** -- Verified PARTIAL. The deep audit missed this entirely. The NPC flow (Ferghus -> Leonhardt -> Raginmund -> Leonhardt -> Ferghus -> Umberto) is fully scripted with addQuest/completeQuest calls and proper charvar progression (steps 1-5). However, the Red Oven Mitt (item 2527) required at step 3->4 has no drop source in mob_droplist.sql and Grauberg [S] has no Quadav mobs spawned. This is a data gap, not a script gap.

3. **TODOs from deep audit remain accurate** -- 5 cosmetic TODOs in converted scripts (Blade of Darkness verification, A Test of True Love KI removal, Rivals sallet return, Curse Collector reminder, Iron Eater trust memories). None are functional blockers.

---

## Key Observations

1. **Core quests are solid.** All 78 converted + 1 NPC-based quest are fully functional. 86% implementation rate.

2. **One quest is partially broken:** Too Many Chefs has complete NPC scripts but the required Red Oven Mitt item cannot be obtained (no Quadav mobs in Grauberg [S], no drop list entry). This was missed by the previous audit which listed it as entirely missing.

3. **One gameplay blocker:** Achieving True Power (PUP lv70 cap quest) is missing entirely -- no quest script, no battlefield script (despite battlefield ID 1123 existing in battlefield.lua). Blocks PUP past lv70.

4. **Prerequisite wiring exists for missing quests:** Teak Me to the Stars correctly sets mustZone for Hyper Active, and Lamepaue (replay NPC) has completion-check code ready for several missing quests (Achieving True Power, Too Many Chefs, A Proper Burial). This means some quest infrastructure anticipates future implementation.

5. **All 3 AF job sets (WAR/MNK/DRK) fully implemented** with proper AF1/AF2/AF3 chains, level gates, NM fights, and key item progression.

6. **Trust: Bastok** has Iron Eater's memory function as TODO (returns 0). Cosmetic only.

---

## Recommendations

| Priority | Action |
|----------|--------|
| HIGH (if PUP used) | Implement Achieving True Power -- PUP limit break quest. Needs quest script + battlefield script (ID 1123). |
| MEDIUM | Fix Too Many Chefs -- add Red Oven Mitt to Quadav mob droplists or add Quadav mobs to Grauberg [S]. |
| LOW | Implement Escort for Hire, Return to the Depths, Hyper Active for completionists. |
| SKIP | Synergy quests (deprecated), Fully Mental Alchemist (WotG/Synergy niche). |
