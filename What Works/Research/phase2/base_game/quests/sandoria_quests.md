# San d'Oria Quests -- Corrected Audit

> **CORRECTED VERSION** -- Previous audit undercounted NPC-script quests and included
> Chocobo Riding Game (a global system, not in the SANDORIA quest log). This version
> uses `scripts/globals/quests.lua` SANDORIA section as the authoritative source,
> then verifies each quest's implementation status.

**Date:** 2026-03-28 (corrected)
**Source:** `scripts/globals/quests.lua` lines 35-119 (SANDORIA section, 82 entries)
**Verification:** Cross-referenced with `scripts/quests/sandoria/` and `scripts/zones/` NPC scripts

---

## Summary

| Metric | Count |
|--------|-------|
| Total quests in SANDORIA quest log | 82 |
| Converted to Quest:new() framework | 56 |
| Implemented via NPC scripts (marked "-- +") | 20 |
| Implemented via NPC scripts (unmarked, verified) | 1 |
| **Total implemented** | **77 / 82 (93.9%)** |
| Not implemented | 5 |

### How Markers Work in quests.lua

- `-- + Converted` = Migrated to modern `Quest:new()` framework in `scripts/quests/sandoria/`. Best quality.
- `-- +` = Implemented via NPC scripts in zone directories (old-style). Functional but logic spread across files.
- No marker = Usually not implemented. Exception: UNDER_OATH (implemented but missing its marker).

---

## Complete Quest List (from quests.lua SANDORIA section)

### Converted Quests (56 total, "-- + Converted")

| # | Quest Name | ID | Notes |
|---|-----------|-----|-------|
| 1 | A Sentry's Peril | 0 | Fame 1 starter. Trade Ointment Case to Glenne. |
| 2 | Waters of the Cheval | 1 | Fame 1 starter. Fill waterskin at river. |
| 3 | Rosel the Armorer | 2 | Fame 1. Deliver receipt to prince. |
| 4 | The Pickpocket | 3 | Fame 1. Multi-step: Eagle Button, Gilt Glasses. |
| 5 | Father and Son | 4 | Fame 1. Ailbeche/Exoroche chain. Willow Fishing Rod. |
| 6 | The Seamstress | 5 | Fame 1. Trade 3 Sheepskins. Repeatable. |
| 7 | The Dismayed Customer | 6 | Requires A Taste for Meat. Find document in W. Ronfaure. |
| 8 | The Trader in the Forest | 7 | Fame 1. Buy Batagreens from Phairet. |
| 9 | The Sweetest Things | 8 | Fame 2. Trade 5 Honey. Repeatable. |
| 10 | The Vicasque's Sermon | 9 | Requires Waters of the Cheval. Buy Blue Peas. |
| 11 | A Squire's Test | 10 | Fame 1. WAR/MNK/THF chain start. Revival Tree Root. |
| 12 | Grave Concerns | 11 | Fame 1. Fill waterskin at tomb. 560 gil. |
| 13 | The Brugaire Consortium | 12 | Fame 1. 3-step delivery. Lauan Shield. |
| 14 | Lizard Skins | 15 | Fame 2. Trade 3 Lizard Skins. Repeatable fame quest. |
| 15 | A Squire's Test II | 19 | Requires Squire's Test. Stalactite Dew. PLD chain. |
| 16 | Tiger's Teeth | 23 | Fame 3. Trade 3 Black Tiger Fangs. Repeatable. |
| 17 | A Purchase of Arms | 27 | Fame 2. Requires Father and Son. Elm Staff. |
| 18 | A Knight's Test | 29 | **Paladin job unlock**. Trade Knight's Soul. Kite Shield. |
| 19 | The Medicine Woman | 30 | Fame 3. Requires Trader in Forest. Multi-step. |
| 20 | Black Tiger Skins | 31 | Fame 3. Requires Lizard Skins. Trade 3 Tiger Hides. |
| 21 | Growing Flowers | 58 | Trade any flower. 120 fame per turn-in. |
| 22 | The General's Secret | 60 | Fame 2. Horlais Peak Hot Springs. Lynx Baghnakhs. |
| 23 | The Rumor | 61 | Fame 3. Trade Beastman Blood. Scroll of Drain. |
| 24 | Her Majesty's Garden | 62 | Fame 4. Derfland Humus. Map of Northlands KI. |
| 25 | Introduction to Teamwork | 63 | Fame 2, Lv10. Party check (same nation). |
| 26 | Intermediate Teamwork | 64 | Requires Intro Teamwork. Party check (same race). |
| 27 | Advanced Teamwork | 65 | Requires Intermediate. Party check (same job). |
| 28 | Grimy Signposts | 66 | Fame 2. Clean 4 signposts. 1500 gil. |
| 29 | A Job for the Consortium | 67 | Fame 5. Tenshodo card. Delivery to Norg. |
| 30 | Trouble at the Sluice | 68 | Requires The Rumor. Multi-step. Heavy Axe. |
| 31 | The Merchant's Bidding | 69 | Trade 3 Rabbit Hides. Repeatable. |
| 32 | Blackmail | 71 | Fame 3, Rank 3. Envelope to Halver. 900 gil repeatable. |
| 33 | The Setting Sun | 72 | Fame 5. Requires Blackmail. 10000 gil. |
| 34 | Distant Loyalties | 74 | Fame 4. Sandy to Bastok Markets. White Cape. |
| 35 | The Rivalry | 75 | Fame 4. 10000 carp to Gallijaux. Lu Shang's Rod. **BUG: see below** |
| 36 | The Competition | 76 | Fame 4. 10000 carp to Joulet. Lu Shang's Rod. **BUG: see below** |
| 37 | Starting a Flame | 77 | Trade 4 Flint Stones. Repeatable. |
| 38 | Fear of the Dark | 78 | Trade 2 Bat Wings. Repeatable. |
| 39 | Warding Vampires | 79 | Fame 3. Trade 2 Shaman Garlic. Repeatable. |
| 40 | Sleepless Nights | 80 | Fame 2. Trade Mary's Milk. 5000 gil. |
| 41 | Lufet's Lake Salt | 81 | Trade 3 Lufet Salt. 600 gil. |
| 42 | The Crimson Trial | 84 | RDM AF1. Orcish Dried Food from Davoi. Fencing Degen. |
| 43 | Enveloped in Darkness | 85 | RDM AF2. Multi-zone chain. Warlock's Boots. |
| 44 | Messenger from Beyond | 87 | WHM AF1. Pop NM, Tavnazia Pass. Blessed Hammer. |
| 45 | Prelude of Black and White | 88 | WHM AF2. Yagudo Holy Water. Healer's Duckbills. |
| 46 | Sharpening the Sword | 90 | PLD AF1. Pop NM Polevik. Honor Sword. **MINOR BUG: see below** |
| 47 | Methods Create Madness | 98 | Polearm 240+. Impulse Drive WS unlock. |
| 48 | Souls in Shadow | 99 | Scythe 240+. Spiral Hell WS unlock. |
| 49 | A Taste for Meat | 100 | Fame 3. Trade 5 Hare Meat. 150 gil. |
| 50 | Exit the Gambler | 101 | Cutscene chain. Map of King Ranperre's Tomb KI. |
| 51 | Old Wounds | 102 | Sword 240+. Savage Blade WS unlock. |
| 52 | A Timely Visit | 105 | Fame 4. Multi-step with NM fight. Medieval Collar. |
| 53 | Signed in Blood | 108 | Fame 3. Multi-step. Cunning Earring + 3500 gil. |
| 54 | Tea with a Tonberry? | 109 | Requires Signed in Blood. Multi-zone. Willpower Torque. |
| 55 | Spice Gals | 110 | CoP 3-1. Rivernewort. Miratete's Memoirs. Repeatable. |
| 56 | Atelloune's Lament | 114 | Fame 2. Ladybug Wing. Trainee Gloves. |

### NPC-Script Quests (20 marked "-- +", plus 1 unmarked = 21 total)

| # | Quest Name | ID | Marker | Key Files | Notes |
|---|-----------|-----|--------|-----------|-------|
| 1 | Flyers for Regine | 16 | + | `Port_San_dOria/npcs/Regine.lua` + 15 delivery NPCs | 15 flyers. 440 gil + title. |
| 2 | Gates to Paradise | 18 | + | `Southern_San_dOria/npcs/Olbergieut.lua` | Scripture exchange. Cotton Cape. |
| 3 | To Cure a Cough | 20 | + | `Northern_San_dOria/npcs/Nenne.lua` + Amaura + Davoi qm | Multi-step. 3000 gil. |
| 4 | Undying Flames | 26 | + | `Southern_San_dOria/npcs/Pagisalis.lua` | Trade 2 Beeswax. Friar's Rope. |
| 5 | Trial by Ice | 59 | + | `Port_San_dOria/npcs/Gulmama.lua` + Cloister of Frost | **Shiva avatar fight**. Fame 6. |
| 6 | Healing the Land | 82 | + | `Northern_San_dOria/npcs/Eperdur.lua` | Fame 4. Scroll of Teleport-Holla. |
| 7 | Sorcery of the North | 83 | + | `Northern_San_dOria/npcs/Eperdur.lua` | Sequel to Healing the Land. Teleport-Vahzl. |
| 8 | Peace for the Spirit | 86 | + | Curilla + Fei'Yin + Garlaige NPCs | RDM AF Head (Warlock's Chapeau). |
| 9 | Pieuje's Decision | 89 | + | `Northern_San_dOria/npcs/Narcheral.lua` + Fei'Yin | WHM AF Body (Healer's Bliaut). |
| 10 | A Boy's Dream | 91 | + | `Southern_San_dOria/npcs/Ailbeche.lua` + `_6h0.lua` | PLD AF Feet (Gallant Leggings). |
| 11 | Under Oath | 92 | (none) | `Chateau_dOraguille/npcs/_6h0.lua` + `Vemalpeau.lua` + `Exoroche.lua` | PLD AF Body (Gallant Surcoat). **Missing "+" marker in quests.lua but fully implemented.** |
| 12 | The Holy Crest | 93 | + | `Southern_San_dOria/npcs/Ceraulian.lua` + Ghelsba battlefield | **Dragoon job unlock**. |
| 13 | A Craftsman's Work | 94 | + | `Southern_San_dOria/npcs/Miaux.lua` + E. Altepa NPCs | DRG AF1. Peregrine weapon. |
| 14 | Chasing Quotas | 95 | + | `Southern_San_dOria/npcs/Ceraulian.lua` + zone NPCs | DRG AF Legs (Drachen Brais). |
| 15 | Knight Stalker | 96 | + | `Southern_San_dOria/npcs/Ceraulian.lua` + `Rahal.lua` | DRG AF Head (Drachen Armet). |
| 16 | Eco-Warrior (San d'Oria) | 97 | + | `Northern_San_dOria/npcs/Norejaie.lua` | Dragon Chronicles + 5000 gil. Weekly. |
| 17 | Trial-Size Trial by Ice | 107 | + | `Southern_San_dOria/npcs/Castilchat.lua` | Mini Shiva fight (SMN Lv20). |
| 18 | Over the Hills and Far Away | 112 | + | `Port_San_dOria/npcs/Antreneau.lua` + Uleguerand qm | Map + 2000 EXP + 2000 gil. |
| 19 | Lure of the Wildcat (San d'Oria) | 113 | + | 20+ NPC scripts across all Sandy zones | WildcatSandy variable system. |
| 20 | Thick Shells | 117 | + | `Port_San_dOria/npcs/Vounebariont.lua` | Trade 5 Beetle Shells. 750 gil. |
| 21 | Trust: San d'Oria | 119 | + | `Southern_San_dOria/npcs/Gondebaud.lua` | Lv5. Trust permit + Excenmille spell. |

### NOT Implemented (5 quests, no marker, no zone scripts found)

| # | Quest Name | ID | Why Missing |
|---|-----------|-----|-------------|
| 1 | Unexpected Treasure | 70 | Mog House furniture quest. No NPC scripts reference it. |
| 2 | Escort for Hire (San d'Oria) | 103 | Escort NPC through Eldieme Necropolis. No scripts found. |
| 3 | A Discerning Eye (San d'Oria) | 104 | Airship NPC identification minigame. No scripts found. |
| 4 | Fit for a Prince | 106 | Find bride for Prince Trion. Only referenced in Trust memory checks (`_6h0.lua`, `Curilla.lua`), not actually implemented. |
| 5 | Forest for the Trees | 118 | Woodworking Guild quest. No scripts found. |

None of these block progression or unlock essential content. All are optional side content.

---

## Verified Bugs

### BUG: The Competition (ID 76) + The Rivalry (ID 75) -- `keyitem` vs `keyItem`

**Files:**
- `scripts/quests/sandoria/The_Competition.lua` line 16
- `scripts/quests/sandoria/The_Rivalry.lua` line 16

**Problem:** Both define their reward as `keyitem = xi.ki.TESTIMONIAL` (lowercase 'i'). The `npcUtil.completeQuest` function in `scripts/globals/npc_util.lua` checks for `params['keyItem']` (camelCase). Since `keyitem` != `keyItem`, the Testimonial key item is never awarded.

**Impact:** Players get the Lu Shang's Fishing Rod and title but NOT the Testimonial key item.

**Fix:** Change `keyitem` to `keyItem` in both files.

**Verified:** Confirmed by reading both quest files and npc_util.lua. No `ki` alias exists either -- only `keyItem` is checked.

### MINOR BUG: Sharpening the Sword (ID 90) -- Two errors on one line

**File:** `scripts/quests/sandoria/Sharpening_the_Sword.lua` line 132

**Problem:** Post-complete section has:
```lua
player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM) == xi.quest.status.AVAILABLE
```

Two issues:
1. `xi.quest.status.AVAILABLE` should be `xi.questStatus.QUEST_AVAILABLE` (wrong namespace, evaluates to nil)
2. `A_BOY_S_DREAM` should be `A_BOYS_DREAM` (wrong quest ID constant)

**Impact:** Cosmetic only. The post-completion Ailbeche dialogue about A Boy's Dream never triggers. Does not affect quest completion or rewards.

### MINOR: Exit the Gambler (ID 101) -- No quest:begin() call

**File:** `scripts/quests/sandoria/Exit_the_Gambler.lua`

**Problem:** Quest uses a Stage variable and goes straight to `quest:complete()`. Quest log never shows "Accepted" status. Appears intentional for this short cutscene chain.

### MINOR: The Competition / The Rivalry -- TODO counter behavior

Both files have TODO notes about NPC counter display not matching retail. Cosmetic -- quest completion works correctly.

---

## Corrections from Previous Audit

1. **Chocobo Riding Game removed.** The previous audit listed "A Chocobo Riding Game (San d'Oria)" as side quest #38, but this is a global system (`scripts/globals/chocobo_riding_game.lua`) that is NOT in the `xi.questLog.SANDORIA` section of `quests.lua`. It does not belong in this count. The total of 82 quests is correct because it comes from quests.lua entries, not from adding Chocobo Riding Game.

2. **UNDER_OATH marker corrected.** UNDER_OATH (ID 92) has no `-- +` marker in quests.lua but is fully implemented in zone NPC scripts (`_6h0.lua`, `Vemalpeau.lua`, `Exoroche.lua`, `Vingijard.lua`). The previous audit correctly identified it as implemented but did not flag the missing marker.

3. **Sharpening the Sword bug detail corrected.** The previous deep audit reported `xi.quest.status.AVAILABLE` on "line 132" -- the line number is correct but it missed the second bug on the same line: the quest ID `A_BOY_S_DREAM` does not match the actual constant `A_BOYS_DREAM`.

4. **Final counts unchanged.** Despite corrections to individual items, the overall counts remain the same: 77/82 implemented (93.9%). The methodology is now properly grounded in quests.lua rather than bg-wiki page counts.

---

## Implementation Breakdown by Category

| Category | Total | Implemented | % |
|----------|-------|-------------|---|
| Starter quests (Fame 1-2) | 17 | 17 | 100% |
| Fame quests (repeatable) | 6 | 6 | 100% |
| Job unlock quests (PLD, DRG, SMN) | 4 | 4 | 100% |
| AF armor chains (PLD/RDM/WHM/DRG) | 11 | 11 | 100% |
| Teleport quests | 2 | 2 | 100% |
| Weaponskill unlock quests | 3 | 3 | 100% |
| Eco-Warrior | 1 | 1 | 100% |
| Trust quest | 1 | 1 | 100% |
| Side/story quests | 37 | 32 | 86.5% |
| **TOTAL** | **82** | **77** | **93.9%** |

---

## Key Findings

1. **All critical quests are implemented**: Job unlocks (PLD, DRG, Shiva), AF armor chains (PLD, RDM, WHM, DRG), teleport scrolls, Trust, weaponskill unlocks, and all starter quests work.

2. **56 quests use the modern Quest:new() framework** (Converted). These are highest quality with proper reward handling, fame tracking, and prerequisite checking.

3. **21 quests use older NPC-based implementations**. These are fully functional but logic is spread across multiple NPC files. One (Under Oath) is missing its `-- +` marker in quests.lua.

4. **5 quests are not implemented**, all optional side content:
   - Unexpected Treasure (furniture/mog house quest)
   - Escort for Hire (escort NPC through Eldieme Necropolis)
   - A Discerning Eye (airship NPC identification minigame)
   - Fit for a Prince (requires matching female PC)
   - Forest for the Trees (Woodworking Guild quest)

5. **One real bug exists**: The `keyitem` typo in The Competition and The Rivalry prevents the Testimonial key item from being awarded. Easy fix (change to `keyItem`).

6. **One cosmetic bug exists**: Sharpening the Sword has a broken post-completion check with two errors (wrong namespace + wrong quest ID constant). Does not affect gameplay.
