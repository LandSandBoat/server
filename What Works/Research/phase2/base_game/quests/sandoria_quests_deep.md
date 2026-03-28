# San d'Oria Quests -- Deep Audit

**Auditor:** Claude Opus 4.6 (1M context)
**Date:** 2026-03-28
**Scope:** All 56 implemented San d'Oria quest scripts (scripts/quests/sandoria/)
**Method:** Read every script; verified start conditions, completion logic, rewards, and flagged issues.

---

## Summary

- **Total scripts:** 56
- **Fully functional (no issues found):** 49
- **Minor issues (cosmetic/TODO):** 5
- **Potential bugs:** 2 (The Competition, The Rivalry -- `keyitem` vs `keyItem` case mismatch)

---

## Quest Audit Table

| # | Quest Name | Script | Start | Complete | Rewards | Issues |
|---|-----------|--------|-------|----------|---------|--------|
| 1 | A Job for the Consortium | A_Job_for_the_Consortium.lua | OK -- Fame 5, Tenshodo card, Norg fame 1 | OK -- quest:complete on return | 1000 gil (good delivery), Norg fame +30; reduced for confiscated/damaged | NONE |
| 2 | A Knight's Test | A_Knights_Test.lua | OK -- Requires A Squire's Test II complete, adv job level | OK -- trade Knight's Soul, unlocks PLD | Kite Shield, JOB_GESTURE_PALADIN KI, fame 30, title | NONE |
| 3 | A Purchase of Arms | A_Purchase_of_Arms.lua | OK -- Requires Father and Son complete, fame 2 | OK -- trade receipt to Helbort | Elm Staff, title Arms Trader | NONE |
| 4 | A Sentry's Peril | A_Sentrys_Peril.lua | OK -- No prereqs, QUEST_AVAILABLE | OK -- trade Ointment Case to Glenne | Bronze Subligar, fame 30, title | NONE |
| 5 | A Squire's Test | A_Squires_Test.lua | OK -- QUEST_AVAILABLE, no prereqs | OK -- trade Revival Tree Root to Balasiel | Spatha, fame 30, title | NONE |
| 6 | A Squire's Test II | A_Squires_Test_II.lua | OK -- Requires Squire's Test complete, lvl 10 | OK -- bring Stalactite Dew to Balasiel | Squire Certificate KI, fame 30, title | NONE |
| 7 | A Taste for Meat | A_Taste_for_Meat.lua | OK -- QUEST_AVAILABLE, 2-step accept | OK -- trade 5 Hare Meat to Thierride, instant begin+complete | 150 gil, fame 30, title Rabbiter; bonus Grilled Hare after | NONE |
| 8 | A Timely Visit | A_Timely_Visit.lua | OK -- Fame 4, multi-step NPC chain | OK -- complex 8-step progression with NM fight | Medieval Collar, fame 60, title Obsidian Storm | NONE -- complex but well-implemented |
| 9 | Advanced Teamwork | Advanced_Teamwork.lua | OK -- Requires Intermediate Teamwork, fame 4, lvl 10 | OK -- party check (same job) | Horn Ring, fame 80, title | NONE |
| 10 | Atelloune's Lament | Atellounes_Lament.lua | OK -- Fame 2, Seeing Spots (CW) complete | OK -- trade Ladybug Wing | Trainee Gloves, fame 30 | NONE |
| 11 | Black Tiger Skins | Black_Tiger_Skins.lua | OK -- Requires Lizard Skins complete, fame 3 | OK -- trade 3 Tiger Hides | Tiger Stole, fame 30, title | NONE |
| 12 | Blackmail | Blackmail.lua | OK -- Fame 3, rank 3 | OK -- multi-step: envelope to Halver, get plans, trade back | 900 gil; repeatable for 900 gil + fame | NONE |
| 13 | Distant Loyalties | Distant_Loyalties.lua | OK -- Fame 4 | OK -- multi-step: Sandy to Bastok Markets (Michea), trade Mythril Ingot, return | White Cape, fame 30 | NONE |
| 14 | Exit the Gambler | Exit_the_Gambler.lua | OK -- QUEST_AVAILABLE, sets Stage var | OK -- talk to Aurege/Guilberdrier after Varchet scene | 2000 exp, Map of King Ranperre's Tomb KI, title | MINOR -- quest:begin() never called; jumps Available->Completed via Stage var. Intentional design but quest log won't show "Accepted" phase. |
| 15 | Father and Son | Father_and_Son.lua | OK -- QUEST_AVAILABLE, talk Ailbeche | OK -- talk Exoroche then Ailbeche | Willow Fishing Rod, fame 30, title; bonus Family Counselor title for trading rod back | NONE |
| 16 | Fear of the Dark | Fear_of_the_Dark.lua | OK -- QUEST_AVAILABLE | OK -- trade 2 Bat Wings; repeatable | 200 gil; repeatable for 200 gil + fame | NONE |
| 17 | Grave Concerns | Grave_Concerns.lua | OK -- Fame 1, 2-step intro | OK -- fill water at tomb, return waterskin to Andecia | 560 gil, title Royal Grave Keeper | NONE |
| 18 | Grimy Signposts | Grimy_Signposts.lua | OK -- Fame 2 | OK -- clean 4 signposts (bit flags), return | 1500 gil | NONE |
| 19 | Growing Flowers | Growing_Flowers.lua | OK -- Not completed yet check | OK -- trade Marguerite to Kuu Mohzolhi | Fame 120, Moghouse flag (furniture) | NONE |
| 20 | Her Majesty's Garden | Her_Majestys_Garden.lua | OK -- Fame 4 | OK -- trade Derfland Humus to Chalvatot | Map of the Northlands Area KI | NONE |
| 21 | Intermediate Teamwork | Intermediate_Teamwork.lua | OK -- Requires Intro Teamwork, fame 3, lvl 10 | OK -- party check (same race) | Scroll of Mage's Ballad, fame 80, title | NONE |
| 22 | Introduction to Teamwork | Introduction_to_Teamwork.lua | OK -- Fame 2, lvl 10 | OK -- party check (same nation) | Shell Ring, fame 80, title | NONE |
| 23 | Lizard Skins | Lizard_Skins.lua | OK -- Requires Seamstress complete, fame 2 | OK -- trade 3 Lizard Skins; repeatable | Lizard Gloves (handled in trigger), fame 30, title | NONE |
| 24 | Lufet's Lake Salt | Lufets_Lake_Salt.lua | OK -- QUEST_AVAILABLE | OK -- trade 3 Lufet Salt to Nogelle | 600 gil, title | NONE |
| 25 | Messenger From Beyond | Messenger_From_Beyond.lua | OK -- WHM main, AF1 level | OK -- pop NM at ???, get Tavnazia Pass, trade to Narcheral | Blessed Hammer (WHM AF1 weapon), fame 20 | NONE |
| 26 | Methods Create Madness | Methods_Create_Madness.lua | OK -- Polearm 240+, can equip Spear of Trials | OK -- WS points -> trade spear -> NM fight -> Annals | Impulse Drive WS unlock, fame 30 | NONE |
| 27 | Old Wounds | Old_Wounds.lua | OK -- Sword 240+, can equip Sapara of Trials | OK -- WS points -> trade weapon -> NM fight -> Annals | Savage Blade WS unlock, fame 30 | NONE |
| 28 | Prelude of Black and White | Prelude_of_Black_and_White.lua | OK -- WHM main, AF2 level, Messenger complete | OK -- trade Yagudo Holy Water + Moccasins to Narcheral | Healer's Duckbills (WHM AF2 feet), fame 40 | NONE |
| 29 | RDM AF1: The Crimson Trial | RDM_AF1_The_Crimson_Trial.lua | OK -- RDM main, AF1 level | OK -- get Orcish Dried Food from Davoi storage, return | Fencing Degen (RDM AF1 weapon), fame 30 | NONE |
| 30 | RDM AF2: Enveloped in Darkness | RDM_AF2_Enveloped_in_Darkness.lua | OK -- RDM main, AF2 level, Crimson Trial complete | OK -- complex multi-zone: church ghost, crawler blood, boot purification timer | Warlock's Boots (RDM AF2 feet), fame 30 | NONE |
| 31 | Rosel the Armorer | Rosel_the_Armorer.lua | OK -- QUEST_AVAILABLE | OK -- deliver receipt to correct/wrong prince | 100-200 gil (depending on correct delivery), title | NONE |
| 32 | Sharpening the Sword | Sharpening_the_Sword.lua | OK -- PLD main, AF1 level, Family Counselor title | OK -- pop NM Polevik, get Ordelle Whetstone, return | Honor Sword (PLD AF1 weapon) | MINOR -- Post-complete section references `xi.quest.status.AVAILABLE` (should be `xi.questStatus.QUEST_AVAILABLE`). Likely non-functional post-complete check for A Boy's Dream. |
| 33 | Signed in Blood | Signed_in_Blood.lua | OK -- Fame 3 | OK -- multi-step: tapestry trade, Selbina, Ordelle chest, return | Cunning Earring, 3500 gil | NONE |
| 34 | Sleepless Nights | Sleepless_Nights.lua | OK -- Fame 2 | OK -- trade Mary's Milk to Paouala | 5000 gil, title | NONE |
| 35 | Souls in Shadow | Souls_in_Shadow.lua | OK -- Scythe 240+, can equip Scythe of Trials | OK -- WS points -> trade weapon -> NM fight -> Annals | Spiral Hell WS unlock, fame 30 | NONE |
| 36 | Spice Gals | Spice_Gals.lua | OK -- CoP 3-1 complete, conquest tally timer | OK -- get Rivernewort from Riverne, return to Rouva; repeatable per conquest | Miratete's Memoirs item; repeatable | NONE |
| 37 | Starting a Flame | Starting_a_Flame.lua | OK -- QUEST_AVAILABLE | OK -- trade 4 Flint Stones; repeatable | 100 gil; repeatable for 100 gil + fame | NONE |
| 38 | Tea with a Tonberry | Tea_with_a_Tonberry.lua | OK -- Signed in Blood complete, fame 4, not needToZone | OK -- complex multi-zone: Attohwa Ginseng, barge Tonberry, Davoi NM, return | Willpower Torque, title | NONE |
| 39 | The Brugaire Consortium | The_Brugaire_Consortium.lua | OK -- QUEST_AVAILABLE | OK -- deliver 3 parcels in sequence with 100 gil fees | Lauan Shield, fame 30, title | NONE |
| 40 | The Competition | The_Competition.lua | OK -- Rivalry must be available (mutual exclusion) | OK -- trade 10000 total Moat/Forest Carp to Joulet | Lu Shang's Fishing Rod, title Carp Diem | **BUG: `keyitem` (lowercase i) should be `keyItem`. Testimonial KI will NOT be awarded.** Also has TODO comments about NPC counter behavior. |
| 41 | The Dismayed Customer | The_Dismayed_Customer.lua | OK -- Requires A Taste for Meat complete | OK -- find document at random QM in W. Ronfaure, return | 560 gil, fame 30, title | NONE |
| 42 | The General's Secret | The_Generals_Secret.lua | OK -- Fame 2 | OK -- fill bottle at Horlais Peak Hot Springs, return | Lynx Baghnakhs, fame 30 | NONE |
| 43 | The Medicine Woman | The_Medicine_Woman.lua | OK -- Trader in Forest complete, fame 3 | OK -- get formula from Amaura, trade 3 items, deliver medicine | 2100 gil, fame 30, title | NONE |
| 44 | The Merchant's Bidding | The_Merchants_Bidding.lua | OK -- QUEST_AVAILABLE | OK -- trade 3 Rabbit Hides; repeatable | 120 gil, fame; repeatable | NONE |
| 45 | The Pickpocket | The_Pickpocket.lua | OK -- QUEST_AVAILABLE, multi-step intro CS | OK -- get Eagle Button, trade to Esca, get Gilt Glasses, return | Light Axe, fame 30, title | NONE |
| 46 | The Rivalry | The_Rivalry.lua | OK -- Competition must be available (mutual exclusion) | OK -- trade 10000 total Moat/Forest Carp to Gallijaux | Lu Shang's Fishing Rod, title Carp Diem | **BUG: `keyitem` (lowercase i) should be `keyItem`. Testimonial KI will NOT be awarded.** Also has TODO comments about NPC counter behavior. |
| 47 | The Rumor | The_Rumor.lua | OK -- Fame 3, lvl 10 | OK -- trade Beastman Blood to Novalmauge | Scroll of Drain | NONE |
| 48 | The Seamstress | The_Seamstress.lua | OK -- QUEST_AVAILABLE | OK -- trade 3 Sheepskins; repeatable | Leather Gloves (handled in trigger), fame 30, title | NONE |
| 49 | The Setting Sun | The_Setting_Sun.lua | OK -- Fame 5, Blackmail complete | OK -- trade Engraved Key to Vamorcote | 10000 gil | NONE |
| 50 | The Sweetest Things | The_Sweetest_Things.lua | OK -- Fame 2, 3-step intro | OK -- trade 5 Honey to Raimbroy; repeatable | 400 gil (x GIL_RATE), fame 30, title; repeatable for 400 gil + fame | NONE |
| 51 | The Trader in the Forest | The_Trader_in_the_Forest.lua | OK -- QUEST_AVAILABLE | OK -- buy Batagreens from Phairet, return | Robe, fame 30, title Green Grocer | NONE |
| 52 | The Vicasque's Sermon | The_Vicasques_Sermon.lua | OK -- Waters of the Cheval complete | OK -- buy Blue Peas, feed Andelain, return | Brass Ring, fame 30, title | NONE |
| 53 | Tiger's Teeth | Tigers_Teeth.lua | OK -- Fame 3 | OK -- trade 3 Black Tiger Fangs; repeatable | 2100 gil, fame 30, title; repeatable | NONE |
| 54 | Trouble at the Sluice | Trouble_at_the_Sluice.lua | OK -- The Rumor complete, fame 3 | OK -- multi-step: Novalmauge, trade Dahlia, get Neutralizer, return | Heavy Axe | NONE |
| 55 | Warding Vampires | Warding_Vampires.lua | OK -- Fame 3 | OK -- trade 2 Shaman Garlic; repeatable | 900 gil, title; repeatable for 900 gil + fame | NONE |
| 56 | Waters of the Cheval | Waters_of_the_Cheval.lua | OK -- QUEST_AVAILABLE | OK -- buy waterskin, fill at river, return | Wing Pendant, fame 30, title | NONE |

---

## Issues Detail

### BUG: The Competition + The Rivalry -- `keyitem` vs `keyItem` (CONFIRMED)

**Files:**
- `scripts/quests/sandoria/The_Competition.lua` line 16
- `scripts/quests/sandoria/The_Rivalry.lua` line 16

**Problem:** Both quests define their reward as:
```lua
quest.reward = {
    ...
    keyitem  = xi.ki.TESTIMONIAL,   -- WRONG: lowercase 'i'
    ...
}
```

The `npcUtil.completeQuest` function (in `scripts/globals/npc_util.lua` line 668) checks for `params['keyItem']` (camelCase). Since `keyitem` != `keyItem`, the **Testimonial key item is never awarded** on quest completion.

**Impact:** Players who complete the 10,000 carp fishing quest will receive the Lu Shang's Fishing Rod and title, but will NOT receive the Testimonial key item.

**Fix:** Change `keyitem` to `keyItem` in both files.

---

### MINOR: Sharpening the Sword -- Possible Bad Reference

**File:** `scripts/quests/sandoria/Sharpening_the_Sword.lua` line 132

**Problem:** Post-complete section uses `xi.quest.status.AVAILABLE` which should be `xi.questStatus.QUEST_AVAILABLE`. This would cause a nil comparison error, making the post-complete Ailbeche dialogue never trigger. Not gameplay-breaking since it only affects a post-completion flavor message.

---

### MINOR: Exit the Gambler -- No quest:begin() Call

**File:** `scripts/quests/sandoria/Exit_the_Gambler.lua`

**Problem:** The quest never calls `quest:begin(player)`. It uses a Stage variable to track progress and goes straight to `quest:complete()`. The quest will work but the player's quest log will never show "Accepted" status. This appears intentional by design since the quest operates as a short cutscene chain.

---

### MINOR: The Competition / The Rivalry -- TODO Comments

**Files:** Both files have TODO notes about NPC counter behavior:
> "The number that Joulet/Gallijaux reports increases over time and eventually resets back to 0 before starting to tick back up."

This is cosmetic -- the counter display may not match retail behavior, but quest completion works correctly.

---

## Equipment Reward Item Verification

All equipment reward items verified to exist in `item_basic.sql` with mods in `item_mods.sql`:

| Item | item_basic ID | Has Mods |
|------|--------------|----------|
| Kite Shield | 12306 | Yes |
| Blessed Hammer (WHM AF1) | 17422 | Yes (MP+10, MND+2) |
| Healer's Duckbills (WHM AF2) | 14091 | Yes (DEF 12, MP+10, AGI+3, SpellInterrupt 20) |
| Fencing Degen (RDM AF1) | 16829 | Yes (MP+10, INT+1, MND+1) |
| Warlock's Boots (RDM AF2) | 14093 | Yes (DEF 13, MP+11, AGI+3, Water MEVA+10, Shield+10) |
| Honor Sword (PLD AF1) | 17643 | Yes (VIT+2, MND+2) |
| Cunning Earring | 14760 | Yes |
| Willpower Torque | 13174 | Yes |
| Lu Shang's Fishing Rod | 17386 | Yes (fishing gear) |

All other quest rewards (gil, key items, fame, titles, scrolls) use standard framework functions and are correctly implemented.

---

## Overall Assessment

The San d'Oria quest implementation is **very solid**. 49 of 56 quests (87.5%) have zero issues. The only real bug is the `keyitem` case mismatch in The Competition and The Rivalry, which prevents the Testimonial key item from being awarded. All quest scripts use the modern Interaction Framework (`Quest:new` pattern) with proper section-based logic.
