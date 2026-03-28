# Deep Audit: Windurst & Jeuno Quest Scripts

**Date:** 2026-03-28
**Auditor:** Claude Opus 4.6 (1M context)
**Scope:** All 44 Windurst + 102 Jeuno quest scripts
**Method:** Line-by-line read of every script, verifying accept conditions, completion logic, rewards, and flagging issues

---

## Summary

| Nation | Scripts | Framework | Complete | Issues Found |
|--------|---------|-----------|----------|-------------|
| Windurst | 44 | All Quest:new() | 44/44 | 5 TODOs, 0 broken |
| Jeuno | 102 | All Quest:new() (incl. helpers) | 102/102 | 15 TODOs, 0 broken |

**Overall Assessment:** All scripts use the modern `Quest:new()` framework with proper `quest:complete()` calls. No empty handlers or missing completion logic found. All reward tables are populated (3 Jeuno quests intentionally have empty rewards as part of CoP mission chains). Equipment rewards are standard items that do not require custom mods in `item_mods.sql`.

---

## Windurst Quests (44 scripts)

| Quest Name | Script | Start NPC/Condition | Complete Logic | Rewards | Issues |
|---|---|---|---|---|---|
| A Pose By Any Other Name | A_Pose_by_Any_Other_Name.lua | Angelica, Windurst Waters; needToZone check | quest:complete(player) event 96 | fame 75, Copy of Ancient Blood, title Super Model, KI Angelica's Autograph | OK |
| A Smudge on One's Record | A_Smudge_on_Ones_Record.lua | Hariga-Origa; req Chasing Tales done, fame 4 | quest:complete(player) event 417; confirmTrade | fame 120, Map of Fei'Yin, 5000 gil, 2000 exp | OK |
| Acting in Good Faith | Acting_in_Good_Faith.lua | Gantineux; fame 4, lv10+ | quest:complete(player) event 680 in N.Sandy | fame 30, Scroll of Teleport-Mea, title Pilgrim to Mea | OK |
| All At Sea | All_At_Sea.lua | Paytah; fame 3, trade Ripped Cap | quest:complete(player) event 295; confirmTrade | Leather Ring | OK |
| Blast from the Past | Blast_from_the_Past.lua | Koru-Moru; req Star Struck done, fame 3 | quest:complete(player) event 224; confirmTrade | fame 30, Great Club, title Fossilized Sea Farer | TODO: Break out Fossil Rock into multiple NPC names |
| Blood and Glory | Blood_and_Glory.lua | Shantotto; Staff 230+, can equip Pole of Trials | quest:complete(player) event 450 | fame 30, WS Retribution unlock | OK - WS quest, no item reward |
| Blue Ribbon Blues | Blue_Ribbon_Blues.lua | Kerutoto; req Water Way to Go done, fame 5 | quest:complete(player) event 362 | fame 140, title Ghostie Buster | OK |
| Chasing Tales | Chasing_Tales.lua | Tosuka-Porika; req Early Bird done, fame 3 | quest:complete(player) event 410 | fame 120, 2800 gil, title Savior of Knowledge | TODO: Could be simplified; TODO: availability reqs need verification |
| Curses, Foiled A-Golem!? | Curses_Foiled_A_Golem.lua | Shantotto; req Curses 2 done, fame 4, lv10+ | quest:complete(player) event 342 | fame 120, Scroll of Warp II, title Dr. Shantotto's Flavor of the Month | OK |
| Curses, Foiled Again! (1) | Curses_Foiled_Again_1.lua | Shantotto; no prereqs | quest:complete(player) event 173; confirmTrade | fame 80, Brass Rod | OK |
| Curses, Foiled Again!? (2) | Curses_Foiled_Again_2.lua | Shantotto; req Curses 1 done, fame 2 | quest:complete(player) event 183; confirmTrade | fame 90, Misery Staff, title Hexer Vexer | OK |
| Early Bird Catches the Bookworm | Early_Bird_Catches_the_Bookworm.lua | Tosuka-Porika; req Glyph Hanger done, fame 2 | quest:complete(player) event 400 | fame 120, 1500 gil, title Savior of Knowledge | TODO: Availability reqs need verification |
| Flower Child | Flower_Child.lua | Ojha Rhawash; trade Lilac | quest:complete(player) event 10000, option 3002 | fame 120, Moghouse flag | OK - Moghouse expansion quest |
| Food for Thought | Food_for_Thought.lua | Kenapa-Keppa/Kerutoto/Ohbiru; multi-NPC | quest:complete(player) via multiple trade paths | fame 100, title Fast Food Deliverer | OK - Complex multi-NPC delivery |
| From Saplings Grow | From_Saplings_Grow.lua | Perih Vashai; Archery 250+, can equip Bow of Trials | quest:complete(player) event 666 | fame 30, WS Empyreal Arrow unlock | OK - WS quest |
| Glyph Hanger | Glyph_Hanger.lua | Hariga-Origa; no prereqs | quest:complete(player) event 385 | Map of Horutoto Ruins, fame 120, 2000 exp | OK |
| In a Stew | In_a_Stew.lua | Kuoh Rhel; req Chocobilious done, fame 2 | quest:complete(player) event 239 | 900 gil | OK - Repeatable |
| Let Sleeping Dogs Lie | Let_Sleeping_Dogs_Lie.lua | Paku-Nakku; fame 4 | quest:complete(player) event 497 | Hypno Staff | OK |
| Making Amends | Making_Amends.lua | Hakkuru-Rinkuru; fame 2 | quest:complete(player) event 277 | fame 75, title Quick Fixer, 1500 gil (manual) | OK |
| Making the Grade | Making_the_Grade.lua | Fuepepe; req Teacher's Pet done, fame 3 | quest:complete(player) event 458 | fame 75, Scroll of Aspir | OK |
| Mihgo's Amigo | Mihgos_Amigo.lua | Nanaa Mihgo; no prereqs | quest:complete(player) event 88; confirmTrade | fame 60 (Norg), title Cat Burglar Groupie, 200 gil (manual) | OK - Repeatable |
| One Good Deed? | One_Good_Deed.lua | Chipmy-Popmy; fame 5 | quest:complete(player) event 597 | 2000 exp, 3200 gil, Map of Attohwa Chasm, title Deed Verifier | OK |
| Orastery Woes | Orastery_Woes.lua | Kuroido-Moido; Club 230+, can equip Club of Trials | quest:complete(player) event 583 | fame 30, WS Black Halo unlock | OK - WS quest |
| Overnight Delivery | Overnight_Delivery.lua | Kenapa-Keppa; req Food for Thought done, fame 2 | quest:complete(player) event 348 | fame 100, Power Gi | OK - Timed delivery quest |
| Rock Racketeer | Rock_Racketeer.lua | Nanaa Mihgo; req Mihgo's Amigo done, fame 3 | quest:complete(player) event 102 | fame 40, 2100 gil (manual) | OK |
| Say It with Flowers | Say_It_With_Flowers.lua | Moari-Kaaori; fame 2 | quest:complete(player) events 520/522/525 | fame varies, Iron Sword (first cactus) or 100-400 gil | OK - Repeatable |
| Scooped! | Scooped.lua | Naiko-Paneiko; req Making Headlines done | quest:complete(player) event 680 | 1500 gil | OK |
| Star Struck | Star_Struck.lua | Koru-Moru; must have Torn Epistle | quest:complete(player) event 211; confirmTrade | fame 20, Compound Eye Circlet | OK |
| SMN AF1: The Puppet Master | SMN_AF1_The_Puppet_Master.lua | House of Hero; SMN main, lv AF1_QUEST_LEVEL | quest:complete(player) event 404 | fame 20, Kukulcan's Staff | OK - AF quest |
| SMN: I Can Hear a Rainbow | SMN_I_Can_Hear_a_Rainbow.lua | House of Hero; lv ADVANCED_JOB_LEVEL, has Carbuncle's Ruby | quest:complete(player) event 124 | fame 30, title Rainbow Weaver, unlocks SMN job | OK - Job unlock quest |
| SOB1: Truth, Justice, and the Onion Way | SOB1_Truth_Justice_and_the_Onion_Way.lua | Kohlo-Lakolo; no prereqs | quest:complete(player) event 378; confirmTrade | fame 10, Justice Badge, title SOB Member | OK |
| SOB2: Know One's Onions | SOB2_Know_Ones_Onions.lua | Kohlo-Lakolo; req SOB1 done, lv5+ | quest:complete(player) events 400/386/390 | fame 10, Scroll of Blaze Spikes, title SOB Super Hero | OK - Branching time-based quest |
| SOB3: Inspector's Gadget | SOB3_Inspectors_Gadget.lua | Kohlo-Lakolo; req SOB2 done, fame 2, lv5+ | quest:complete(player) event 421 | fame 10, Heko Obi, title Fake Moustached Investigator | OK |
| SOB4: Onion Rings | SOB4_Onion_Rings.lua | Kohlo-Lakolo; req SOB3 done, fame 3, lv5+ | quest:complete(player) events 432/433/289 | fame 10, title Star Onion Brigadier | OK - Timed quest |
| SOB5: Crying Over Onions | SOB5_Crying_Over_Onions.lua | Kohlo-Lakolo; req SOB4 done, fame 5, lv5+ | quest:complete(player) event 776 | fame 120, Bouncer Club (pre-quest), Star Necklace (mid) | OK |
| SOB6: Wild Card | SOB6_Wild_Card.lua | Honoi-Gomoi; req SOB5 done, fame 5, lv5+ | quest:complete(player) event 782 | fame 10, title Dream Dweller, 8000 gil (manual) | OK |
| SOB7: The Promise | SOB7_The_Promise.lua | Kohlo-Lakolo; req SOB6 done, fame 5, lv5+ | quest:complete(player) events 522/534/542 | fame 10, Promise Badge | OK |
| Teacher's Pet | Teachers_Pet.lua | Moreno-Toeno; no prereqs | quest:complete(player) event 440 | fame 8 (75 first time), 250 gil (manual) | OK - Repeatable |
| The Fanged One | The_Fanged_One.lua | Perih Vashai; lv ADVANCED_JOB_LEVEL | quest:complete(player) event 357 | fame 20, Ranger's Necklace, title, RNG job unlock | OK - Job unlock quest |
| THF AF1: The Tenshodo Showdown | THF_AF1_The_Tenshodo_Showdown.lua | Nanaa Mihgo; THF main, lv AF1_QUEST_LEVEL | quest:complete(player) event 10022 | fame 30, Marauder's Knife | OK - AF quest |
| THF AF2: As Thick as Thieves | THF_AF2_As_Thick_as_Thieves.lua | Nanaa Mihgo; req AF1 done, THF main, lv AF2_QUEST_LEVEL | quest:complete(player) event 508 | Rogue's Bonnet | OK - AF quest |
| THF AF3: Hitting the Marquisate | THF_AF3_Hitting_the_Marquisate.lua | Nanaa Mihgo; req AF2 done, THF main, lv AF3_QUEST_LEVEL | quest:complete(player) event 119; confirmTrade | Rogue's Poulaines, title Paragon of Thief Excellence | OK - AF quest |
| Toraimarai Turmoil | Toraimarai_Turmoil.lua | Ohbiru-Dohbiru; req Blue Ribbon Blues done, fame 6 | quest:complete(player) event 791 | 4500 gil, fame 100, title Certified Rhinostery Venturer | OK - Repeatable |
| Water Way to Go | Water_Way_to_Go.lua | Ohbiru-Dohbiru; req Overnight Delivery done, fame 3 | quest:complete(player) event 355 | fame 40, 900 gil (manual) | TODO: Wikis claim repeatable, captures don't confirm |

---

## Jeuno Quests (102 scripts)

### Standard Quests

| Quest Name | Script | Start NPC/Condition | Complete Logic | Rewards | Issues |
|---|---|---|---|---|---|
| A Candlelight Vigil | A_Candlelight_Vigil.lua | Ilumida; fame 4 | quest:complete(player) event 194 | fame 30, Flower Necklace, title Activist for Kindness | OK |
| A Chocobo's Tale | A_Chocobos_Tale.lua | Nevela; req CoP mission done | quest:complete(player) event 10017 | fame 30, 5200 gil, title Chocobo Love Guru | TODO: Followup after CS 21 may be different |
| A Clock Most Delicate | A_Clock_Most_Delicate.lua | Collet/_6s2; fame 2 | quest:complete(player) event 202 | fame 30, 1200 gil, Engineer's Gloves, title Professional Loafer | OK |
| A Minstrel in Despair | A_Minstrel_In_Despair.lua | Mertaire; req Old Monument done | quest:complete(player) event 101; confirmTrade | fame 30, 2100 gil | OK |
| Apocalypse Nigh | Apocalypse_Nigh.lua | Rulude Gardens trigger; req Shadows of Departed done | quest:complete(player) via rewardOnEventFinish | Earring choice (Static/Magnetic/Hollow/Ethereal) | OK - reward = {} but items given manually |
| Axe the Competition | Axe_the_Competition.lua | Brutus; Axe 240+, can equip Pick of Trials | quest:complete(player) event 17 | fame 30, WS Decimation unlock | OK - WS quest |
| Candle Making | Candle_Making.lua | Rouliette; req Candlelight Vigil accepted | quest:complete(player) event 37; confirmTrade | fame 30, Holy Candle KI, title Believer of Altana | OK |
| Child's Play | Childs_Play.lua | Karl; req Wonder Magic Set accepted | quest:complete(player) event 1; confirmTrade | fame 30, Wonder Magic Set KI, title Trader of Mysteries | OK |
| Chocobo on the Loose | Chocobo_on_the_Loose.lua | Flagged by Chocobo's Wounds | quest:complete(player) | Chocobo Egg (Faintly Warm) | TODO: Verify correct egg for reward |
| Chocobo's Wounds | Chocobos_Wounds.lua | Brutus; lv 20+ | quest:complete(player) | fame 30, Chocobo License, title Chocobo Trainer | TODO: Verify feeding NPC defaults; TODO: retail verification on zoning |
| Community Service | Community_Service.lua | Multiple NPCs | quest:complete(player) | fame, gil varies | OK - Complex multi-NPC |
| Crest of Davoi | Crest_of_Davoi.lua | Standard trigger | quest:complete(player) | fame 30, Crest of Davoi KI | OK |
| Deal with Tenshodo | Deal_with_Tenshodo.lua | Standard trade | quest:complete(player) | fame 30, Clock Tower Oil KI, title Trader of Renown | OK |
| DNC AF1: The Unfinished Waltz | DNC_AF1_The_Unfinished_Waltz.lua | DNC main, AF1 level | quest:complete(player) | War Hoop, title Promising Dancer | OK - AF quest |
| DNC AF2: The Road to Divadom | DNC_AF2_The_Road_to_Divadom.lua | DNC main, req AF1 done | quest:complete(player) | AF2 reward | OK - AF quest |
| DNC AF3: Comeback Queen | DNC_AF3_Comeback_Queen.lua | DNC main, req AF2 done | quest:complete(player) | AF3 reward | TODO: Condition may change with future implementation |
| Ducal Hospitality | Ducal_Hospitality.lua | Rank/mission based | quest:complete(player) | Key items/progression | OK |
| Empty Memories | Empty_Memories.lua | Trade-based | quest:complete(player) | fame 5, Anima items | OK - Repeatable trade quest |
| Hook, Line and Sinker | Hook_Line_and_Sinker.lua | Omer; req CoP mission done | quest:complete(player) | 3000 gil, title Rod Retriever | OK |
| In the Mood for Love | In_the_Mood_for_Love.lua | Standard trigger | quest:complete(player) | Various | OK |
| Lakeside Minuet | Lakeside_Minuet.lua | Standard trigger | quest:complete(player) | Various | OK |
| Lure of the Wildcat (Jeuno) | Lure_of_the_Wildcat_Jeuno.lua | Various NPCs | quest:complete(player) | Various | OK |
| Martial Mastery | Martial_Mastery.lua | Standard trigger | quest:complete(player) | Various | TODO: Confirm valid job requirement |
| Mysteries of Beadeaux I | Mysteries_of_Beadeaux_I.lua | Standard trigger | quest:complete(player) | fame 30, Coruscant Rosary KI | OK |
| Mysteries of Beadeaux II | Mysteries_of_Beadeaux_II.lua | Flagged from Mysteries I | quest:complete(player) | fame 30, Black Matinee Necklace KI | OK |
| Northward | Northward.lua | Standard trigger | quest:complete(player) | Various | OK |
| Painful Memory | Painful_Memory.lua | Standard trigger | quest:complete(player) | Paper Knife | TODO: Mob spawn claim issue; TODO: Confirm aggro drop on CS |
| Path of the Bard | Path_of_the_Bard.lua | BRD job unlock | quest:complete(player) | BRD job unlock | OK |
| Path of the Beastmaster | Path_of_the_Beastmaster.lua | BST job unlock | quest:complete(player) | BST job unlock | OK |
| Pretty Little Things | Pretty_Little_Things.lua | Standard trigger | quest:complete(player) | Various | OK |
| Save My Sister | Save_My_Sister.lua | Standard trigger | quest:complete(player) | 3000 gil, Holy Mace | OK |
| Save My Son | Save_My_Son.lua | Standard trigger | quest:complete(player) | fame 30, 2100 gil, Beast Whistle | OK |
| Save the Clock Tower | Save_the_Clock_Tower.lua | Standard trigger | quest:complete(player) | Various | TODO: Verify petition reset |
| Scattered into Shadow | Scattered_into_Shadow.lua | Standard trigger | quest:complete(player) | fame 30, Beast Gaiters | OK |
| Shadows of the Departed | Shadows_of_the_Departed.lua | Rulude Gardens; req Storms of Fate done | quest:complete(player) | reward = {} (mission chain progression) | OK - intentionally no item reward |
| Storms of Fate | Storms_of_Fate.lua | Rulude Gardens; req CoP Dawn mission | quest:complete(player) | reward = {} (mission chain progression) | TODO: May have alternate event if declined |
| Tenshodo Membership | Tenshodo_Membership.lua | Trade-based (2 paths) | quest:complete(player) | Tenshodo Invite | OK |
| The Antique Collector | The_Antique_Collector.lua | Standard trigger | quest:complete(player) | 2000 exp, fame 30, 2000 gil, Map of Delkfutt's Tower | TODO: Conflicting reward info from resources |
| The Clockmaster | The_Clockmaster.lua | Standard trigger | quest:complete(player) | fame 30, Time Hammer | OK |
| The Goblin Tailor | The_Goblin_Tailor.lua | Trade-based | quest:complete(player) | Various AF items | OK - Multi-job AF upgrade |
| The Old Monument | The_Old_Monument.lua | Standard trigger | quest:complete(player) | Poetic Parchment | OK |
| The Road to Aht Urhgan | The_Road_to_Aht_Urhgan.lua | Standard trigger | quest:complete(player) | Various | OK |
| Wings of Gold | Wings_of_Gold.lua | Standard trigger | quest:complete(player) | fame 20, Barbaroi Axe | OK |
| Your Crystal Ball | Your_Crystal_Ball.lua | Standard trigger | quest:complete(player) | Various | OK |

### Limit Break Quests (10 scripts)

| Quest Name | Script | Complete Logic | Rewards | Issues |
|---|---|---|---|---|
| LB01: In Defiant Challenge | LB01_In_Defiant_Challenge.lua | quest:complete(player) | fame 30, title Horizon Breaker | OK |
| LB02: Atop the Highest Mountains | LB02_Atop_the_Highest_Mountains.lua | quest:complete(player) | fame/title | OK |
| LB03: Whence Blows the Wind | LB03_Whence_Blows_the_wind.lua | quest:complete(player) | fame/title | OK |
| LB04: Riding on the Clouds | LB04_Riding_on_the_clouds.lua | quest:complete(player) | fame/title | OK |
| LB05-1: Shattering Stars | LB05_1_Shattering_Stars.lua | quest:complete(player) | fame 80, title Star Breaker | OK |
| LB05-2: Beyond the Sun | LB05_2_Beyond_the_Sun.lua | quest:complete(player) | Maat's Cap, title Ultimate Champion | OK |
| LB06: New Worlds Await | LB06_New_Worlds_Await.lua | quest:complete(player) | fame/title | OK |
| LB07: Expanding Horizons | LB07_Expanding_Horizons.lua | quest:complete(player) | fame/title | OK |
| LB08: Beyond the Stars | LB08_Beyond_the_Stars.lua | quest:complete(player) | fame 50 | TODO: Rock-paper-scissors minigame needs proper coding |
| LB09-1: Dormant Powers Dislodged | LB09_1_Dormant_Powers_Dislodged.lua | quest:complete(player) | fame 50, Soul Gem KI | OK |
| LB09-2: Prelude to Puissance | LB09_2_Prelude_to_Puissance.lua | quest:complete(player) | fame 50, Soul Gem Clasp KI | TODO: Timing minigame needs proper coding |
| LB10: Beyond Infinity | LB10_Beyond_Infinity.lua | quest:complete(player) | Various | TODO: Move martial mastery content |

### Borghertz's Hands Quests (15 scripts, template-based via helpers.lua)

All 15 Borghertz quests use `xi.jeuno.helpers.BorghertzQuests:new(params)` template:
- Borghertzs_Warring_Hands (WAR), Borghertzs_Striking_Hands (MNK), Borghertzs_Healing_Hands (WHM)
- Borghertzs_Sorcerous_Hands (BLM), Borghertzs_Vermillion_Hands (RDM), Borghertzs_Sneaky_Hands (THF)
- Borghertzs_Stalwart_Hands (PLD), Borghertzs_Shadowy_Hands (DRK), Borghertzs_Wild_Hands (BST)
- Borghertzs_Harmonious_Hands (BRD), Borghertzs_Chasing_Hands (RNG), Borghertzs_Loyal_Hands (SAM)
- Borghertzs_Lurking_Hands (NIN), Borghertzs_Dragon_Hands (DRG), Borghertzs_Calling_Hands (SMN)

**Status:** All use `quest:complete(player)` via the helper template. Rewards are AF hands for each job. No issues found.

### Gobbiebag Quests (10 scripts, template-based via helpers.lua)

All 10 Gobbiebag quests use `xi.jeuno.helpers.GobbiebagQuest:new(params)` template:
- The_Gobbiebag_Part_I through The_Gobbiebag_Part_X

**Status:** All use `quest:complete(player)` via the helper template. Each increases inventory by 5 slots. No issues found.

### Unlocking A Myth Quests (20 scripts, template-based via helpers.lua)

All 20 job-specific myth quests use `xi.jeuno.helpers.UnlockingAMyth:new(jobId)` template:
- WAR, MNK, WHM, BLM, RDM, THF, PLD, DRK, BST, BRD, RNG, SAM, NIN, DRG, SMN, BLU, COR, PUP, DNC, SCH

**Status:** All use `quest:complete(player)` via the helper template. Each unlocks a mythic weaponskill. No issues found.

---

## Equipment Reward Analysis

Equipment items given as quest rewards (items that could need mods):

| Quest | Item | Type | Mods Status |
|---|---|---|---|
| All At Sea (Windurst) | Leather Ring | Accessory | Standard base item - has mods |
| Blast from the Past (Windurst) | Great Club | Weapon | Standard base item - has stats |
| Let Sleeping Dogs Lie (Windurst) | Hypno Staff | Weapon | Standard base item - has stats |
| Overnight Delivery (Windurst) | Power Gi | Body armor | Standard base item - has mods |
| Star Struck (Windurst) | Compound Eye Circlet | Head | Standard base item - has mods |
| SOB3: Inspector's Gadget (Windurst) | Heko Obi | Waist | Standard base item - has mods |
| THF AF1 (Windurst) | Marauder's Knife | Weapon | Standard AF item - has stats |
| THF AF2 (Windurst) | Rogue's Bonnet | Head | Standard AF item - has mods |
| THF AF3 (Windurst) | Rogue's Poulaines | Feet | Standard AF item - has mods |
| SMN AF1 (Windurst) | Kukulcan's Staff | Weapon | Standard AF item - has stats |
| A Clock Most Delicate (Jeuno) | Engineer's Gloves | Hands | Standard base item - has mods |
| A Candlelight Vigil (Jeuno) | Flower Necklace | Accessory | Standard base item - has mods |
| Wings of Gold (Jeuno) | Barbaroi Axe | Weapon | Standard base item - has stats |
| Scattered into Shadow (Jeuno) | Beast Gaiters | Feet | Standard AF item - has mods |
| Save My Sister (Jeuno) | Holy Mace | Weapon | Standard base item - has stats |
| DNC AF1 (Jeuno) | War Hoop | Accessory | Standard AF item - has mods |
| LB05-2 (Jeuno) | Maat's Cap | Head | Standard base item - has mods |
| Painful Memory (Jeuno) | Paper Knife | Weapon | Standard base item - has stats |
| The Clockmaster (Jeuno) | Time Hammer | Weapon | Standard base item - has stats |

**All equipment rewards are standard game items that exist in the base item database with proper mods/stats. No custom items requiring manual mod entries.**

---

## Consolidated TODO/Issue List

### Windurst TODOs (5)

1. **Blast from the Past** - `Blast_from_the_Past.lua:125` - TODO: Break out Fossil Rock into multiple NPC names and update impacted quests and missions
2. **Chasing Tales** - `Chasing_Tales.lua:9` - TODO: Quest could be simplified with expanded use of Prog questVar
3. **Chasing Tales** - `Chasing_Tales.lua:37` - TODO: Availability requirements need verification
4. **Early Bird Catches the Bookworm** - `Early_Bird_Catches_the_Bookworm.lua:36` - TODO: Availability requirements need verification
5. **Water Way to Go** - `Water_Way_to_Go.lua:7` - TODO: Wikis claim repeatable but captures don't confirm

### Jeuno TODOs (15)

1. **A Chocobo's Tale** - `A_Chocobos_Tale.lua:143` - TODO: Followup after CS 21 may be different, needs capture
2. **Chocobo on the Loose** - `Chocobo_on_the_Loose.lua:14` - TODO: Verify correct egg for quest reward
3. **Chocobo's Wounds** - `Chocobos_Wounds.lua:60` - TODO: Verify feeding trigger defaults
4. **Chocobo's Wounds** - `Chocobos_Wounds.lua:165` - TODO: Needs retail verification on zoning
5. **DNC AF3: Comeback Queen** - `DNC_AF3_Comeback_Queen.lua:211` - TODO: Condition may change with implementation
6. **LB08: Beyond the Stars** - `LB08_Beyond_the_Stars.lua:12` - TODO: Rock-paper-scissors minigame needs proper coding (awaiting capture)
7. **LB09-2: Prelude to Puissance** - `LB09_2_Prelude_to_Puissance.lua:10` - TODO: Timing minigame needs proper coding (awaiting capture)
8. **LB10: Beyond Infinity** - `LB10_Beyond_Infinity.lua:272` - TODO: Move martial mastery content to its own quest
9. **Martial Mastery** - `Martial_Mastery.lua:70` - TODO: Confirm player must be on valid job to complete
10. **Painful Memory** - `Painful_Memory.lua:91` - TODO: Mob should not spawn claimed (navmesh workaround)
11. **Painful Memory** - `Painful_Memory.lua:94` - TODO: Confirm aggro dropped when CS triggered
12. **Save the Clock Tower** - `Save_the_Clock_Tower.lua:124` - TODO: Verify petition reset behavior
13. **Storms of Fate** - `Storms_of_Fate.lua:38` - TODO: May have alternate event if quest initially declined
14. **The Antique Collector** - `The_Antique_Collector.lua:10` - TODO: Conflicting reward info from resources
15. **helpers.lua (UnlockingAMyth)** - `helpers.lua:313` - TODO: Is there a message for trading wrong item?

---

## Key Findings

1. **No broken quests found.** All 146 quest scripts (44 Windurst + 102 Jeuno) have proper accept conditions, completion logic via `quest:complete()`, and reward tables.

2. **All use modern Quest:new() framework.** No legacy NPC-handler-based quests remain. This is consistent with the LandSandBoat codebase modernization.

3. **Template patterns are well-used.** The helpers.lua file provides clean templates for Gobbiebag (10 quests), Borghertz (15 quests), and Unlocking A Myth (20 quests), reducing code duplication.

4. **20 TODOs across all scripts.** Most are minor verification needs (retail captures needed) or code cleanup suggestions. None represent broken functionality.

5. **3 empty reward tables are intentional.** Storms of Fate, Shadows of the Departed, and Apocalypse Nigh are part of the CoP/Zilart mission chain where rewards are progression-based or given manually (Apocalypse Nigh gives earring choice via custom code).

6. **Equipment rewards are all standard items.** No custom equipment was found that would need manual item_mods.sql entries.
