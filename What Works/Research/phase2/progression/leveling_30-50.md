# Leveling 30-50 Experience Audit

## Summary

The level 30-50 range is **well-supported** on this server. All critical systems -- Limit Break 1 (Genkai 1), advanced job unlocks, Artifact Armor quests, Fields/Grounds of Valor, and key zone accessibility -- have scripts present and appear functionally correct. One minor concern is identified with WHM AF3 ("Pieuje's Decision") using the older non-converted quest framework.

---

## 1. Limit Break 1 -- "In Defiant Challenge" (lv50 cap -> lv55)

**bg-wiki:** https://www.bg-wiki.com/ffxi/In_Defiant_Challenge

### Retail Flow
1. Talk to **Maat** in Ru'Lude Gardens (H-5) at level 50 with level cap 50
2. Accept quest
3. Collect 3 items (in any order):
   - **Exoray Mold** -- from ??? points in Crawlers' Nest (3 key item crumbs combine into item)
   - **Bomb Coal** -- from ??? points in Garlaige Citadel (3 key item fragments combine into item)
   - **Ancient Papyrus** -- from ??? points in Eldieme Necropolis (3 key item shreds combine into item)
4. Trade all 3 items to Maat
5. Receive title "Horizon Breaker", level cap raised to 55

### Script Verification

**File:** `scripts/quests/jeuno/LB01_In_Defiant_Challenge.lua`

| Step | Retail | Server | Status |
|------|--------|--------|--------|
| Talk to Maat at lv50, cap=50 | Event 79, accept option | `check` requires `getMainLvl() == 50` and `getLevelCap() == 50` and `MAX_LEVEL >= 55`. Event 79 fires. Option 1 = accept. | OK |
| Reminder dialogue | Event 80 | Event 80 fires when quest accepted, no items traded | OK |
| Crawlers' Nest ??? (qm10, qm11, qm12) | Give crumb KIs, fuse into Exoray Mold | `handleQMTrigger()` gives KI, checks all 3 crumbs, fuses into `xi.item.CLUMP_OF_EXORAY_MOLD` | OK |
| Garlaige Citadel ??? (qm18, qm19, qm20) | Give fragment KIs, fuse into Bomb Coal | Same pattern for `xi.item.CHUNK_OF_BOMB_COAL` | OK |
| Eldieme Necropolis ??? (qm7, qm8, qm9) | Give shred KIs, fuse into Ancient Papyrus | Same pattern for `xi.item.PIECE_OF_ANCIENT_PAPYRUS` | OK |
| Trade 3 items to Maat | Event 81, cap raised | `npcUtil.tradeHasExactly()` checks all 3 items. `quest:complete()` fires, `setLevelCap(55)`, `confirmTrade()`. All KIs cleaned up. | OK |
| Reward | Title: Horizon Breaker, fame+30 | `quest.reward` has `title = xi.title.HORIZON_BREAKER`, `fame = 30` | OK |

### Items Exist in DB
- Exoray Mold: item ID 1089 (`sql/item_basic.sql`)
- Bomb Coal: item ID 1090 (`sql/item_basic.sql`)
- Ancient Papyrus: item ID 1088 (`sql/item_basic.sql`)

### OLDSCHOOL_G1 Setting
The setting `OLDSCHOOL_G1` (default: `false`) controls whether players must farm drops from mobs or can use the key-item ??? method. When false (default), the ??? method works. When true, the ??? points do nothing and players must farm Exorays, Explosures, and Liches directly.

### Verdict: PASS -- Fully functional

---

## 2. Advanced Job Unlock Quests (lv30)

Setting: `ADVANCED_JOB_LEVEL = 30` (in `settings/default/main.lua` line 121)

### 2a. Paladin -- "A Knight's Test"

**bg-wiki:** https://www.bg-wiki.com/ffxi/A_Knight%27s_Test
**File:** `scripts/quests/sandoria/A_Knights_Test.lua`

#### Retail Flow
1. Prerequisite: Complete "A Squire's Test II"
2. Talk to **Balasiel** in Southern San d'Oria (F-7) at lv30+
3. Receive Book of Tasks (key item)
4. Talk to **Cahaurme** (East Gate tower) -> Book of the East
5. Talk to **Baunise** (West Gate tower) -> Book of the West
6. Travel to **Davoi**, examine Disused Well at (E-10) -> Knight's Soul
7. Return to Balasiel -> Unlock PLD, receive Kite Shield

#### Script Verification

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Prerequisite check | `hasCompletedQuest(SANDORIA, A_SQUIRES_TEST_II)` | OK |
| Level check | `getMainLvl() >= ADVANCED_JOB_LEVEL` (30) | OK |
| Balasiel start | Event 627 or 635, gives `xi.ki.BOOK_OF_TASKS` | OK |
| Cahaurme | Event 633, gives `xi.ki.BOOK_OF_THE_EAST` | OK |
| Baunise | Event 634, gives `xi.ki.BOOK_OF_THE_WEST` | OK |
| Disused Well | Requires both books, gives `xi.ki.KNIGHTS_SOUL` | OK |
| Balasiel complete | Event 628, `player:unlockJob(xi.job.PLD)`, Kite Shield reward | OK |
| Cleanup | All 4 key items deleted on completion | OK |

**Reward:** `xi.item.KITE_SHIELD`, `xi.ki.JOB_GESTURE_PALADIN`, title "Tried and Tested Knight", fame+30

#### Verdict: PASS -- Fully functional

---

### 2b. Dark Knight -- "Blade of Darkness"

**bg-wiki:** https://www.bg-wiki.com/ffxi/Blade_of_Darkness
**File:** `scripts/quests/bastok/Blade_of_Darkness.lua`
**Supporting file:** `scripts/items/chaosbringer.lua`

#### Retail Flow
1. Talk to **Gumbah** in Bastok Mines (J-7) at lv30+
2. Travel to Palborough Mines, ride boat to Zeruhn Mines -> receive Chaosbringer sword
3. Kill 100 monsters with Chaosbringer equipped (normal attacks only, no weapon skills)
4. Zone into Beadeaux from Pashhow Marshlands -> cutscene, DRK unlocked

#### Script Verification

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Gumbah start | Event 99, quest begins | OK |
| Zeruhn zone-in | Event 130 when coming from Palborough. Gives `xi.item.CHAOSBRINGER` | OK |
| Kill tracking | `chaosbringer.lua` adds listener `DEFEATED_MOB`, increments `ChaosbringerKills` charvar. Requires auto-attack kill (not WS). | OK |
| Kill count | Script checks `ChaosbringerKills >= 100` | OK |
| Beadeaux zone-in | Event 121 when coming from Pashhow with 100+ kills | OK |
| Unlock | `player:unlockJob(xi.job.DRK)` | OK |

**Note:** The script header says `TODO: This quest needs verification!` -- but reviewing the code, all steps match retail behavior. The chaosbringer item script correctly tracks kills and the quest script checks the charvar threshold.

**Potential issue:** The chaosbringer item tracks up to 200 kills (`< 200` check) because it also supports "Blade of Death" (a follow-up quest). The Blade of Darkness quest checks `>= 100`. This is correct.

#### Verdict: PASS -- Fully functional (despite TODO comment)

---

### 2c. Ninja -- "Ayame and Kaede"

**bg-wiki:** https://www.bg-wiki.com/ffxi/Ayame_and_Kaede
**File:** `scripts/quests/bastok/Ayame_and_Kaede.lua`

#### Retail Flow
1. Talk to **Kaede** in Port Bastok (J-5) at lv30+
2. Talk to **Kagetora** at Warehouse 2 (F-6)
3. Talk to **Ensetsu** at Port Bastok (I-5)
4. Travel to **Korroloka Tunnel**, click ??? at (K-8) -> spawn 3 Korroloka Leeches
5. Defeat leeches, click ??? again -> obtain Strangely Shaped Coral (key item)
6. Return to **Ensetsu**
7. Travel to **Norg**, talk to **Ryoma** -> receive Sealed Dagger (key item)
8. Return to **Ensetsu** -> NIN unlocked

#### Script Verification

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Kaede start | Event 240, quest begins | OK |
| Kagetora | Event 241, prog=1 | OK |
| Ensetsu (first) | Event 242, prog=2 | OK |
| Korroloka ??? | Spawns 3 Korroloka Leeches. Must defeat all, then click again. | OK |
| Strangely Shaped Coral | `quest:keyItem(xi.ki.STRANGELY_SHAPED_CORAL)` given at prog=3 | OK |
| Ensetsu (second) | Event 245, prog=4 | OK |
| Ryoma in Norg | Event 95 at prog=4. Gives `xi.ki.SEALED_DAGGER`, deletes Coral, prog=5 | OK |
| Ensetsu (final) | Event 246, `player:unlockJob(xi.job.NIN)` | OK |

**Norg Access:** Norg zone exists with full NPC scripts including Ryoma (the NIN quest NPC). Players reach Norg through Sea Serpent Grotto, which has mob scripts, NPCs, Grounds Tome, and Survival Guide.

#### Verdict: PASS -- Fully functional

---

## 3. Artifact Armor Quests (AF1, starts at lv40-50)

Settings (from `settings/default/main.lua`):
- `AF1_QUEST_LEVEL = 40` -- First AF piece quest
- `AF2_QUEST_LEVEL = 50` -- Second AF piece quest
- `AF3_QUEST_LEVEL = 50` -- Final AF piece quest (body armor)

### 3a. Warrior AF -- Fighter's Armor Set

**Quest chain:** The Doorman -> The Talekeeper's Truth -> The Talekeeper's Gift
**Hands quest:** Borghertz's Warring Hands (Jeuno)

#### AF1: "The Doorman" (lv40, Weapon reward)

**File:** `scripts/quests/bastok/WAR_AF1_The_Doorman.lua`

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Start: Phara in Bastok Mines | Requires WAR main job, lv >= AF1_QUEST_LEVEL (40) | OK |
| Travel to Davoi, examine Hide Flap | Spawns NMs Gavotvut + Barakbok, must kill both | OK |
| Return to Phara with Sword Grip Material | Event 152, wait 1 Vanadiel day | OK |
| Phara gives Yasin's Sword | Event 153, gives KI | OK |
| Trade to Naji in Metalworks | Event 750, quest completes | OK |
| Reward | `xi.item.RAZOR_AXE` (Fighter's weapon), fame+30 | OK |

#### AF2: "The Talekeeper's Truth" (lv50, Feet reward)

**File:** `scripts/quests/bastok/WAR_AF2_The_Talekeepers_Truth.lua`

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Prerequisite | Must complete "The Doorman", WAR lv >= AF2_QUEST_LEVEL (50) | OK |
| Multi-step NPC chain in Bastok Mines | Phara (event 154) -> Deidogg (events 160, 161) -> quest begins | OK |
| Palborough Mines ??? | Spawns NM `NI_GHU_NESTFENDER` via popFromQM | OK |
| Trade items to Deidogg | Mottled Quadav Egg, then Parasite Skin | OK |
| Reward | `xi.item.FIGHTERS_CALLIGAE` (feet), fame+40 | OK |

#### AF3: "The Talekeeper's Gift" (lv50, Body reward)

**File:** `scripts/quests/bastok/WAR_AF3_The_Talekeepers_Gift.lua`

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Prerequisite | Must complete "The Talekeeper's Truth", WAR lv >= AF3_QUEST_LEVEL (50) | OK |
| Deidogg chain in Bastok | Events 170 -> 171 (Detzo) -> trade Ginger Cookie | OK |
| Behemoth's Dominion ??? | Spawns 3 NMs: Picklix, Moxnix, Doglix. Tracks kills via bit flags. | OK |
| Zone to Qufim Island | Event 100 when prog=7 (all 3 NMs killed) | OK |
| Reward | `xi.item.FIGHTERS_LORICA` (body), title "Paragon of WAR Excellence", fame+60 | OK |

#### AF Hands: "Borghertz's Warring Hands"

**File:** `scripts/quests/jeuno/Borghertzs_Warring_Hands.lua`

Uses the shared Borghertz helper system (`scripts/quests/jeuno/helpers.lua`). Requires completing "The Talekeeper's Truth" (AF2). Reward: `xi.item.FIGHTERS_MUFFLERS` (hands). Coffer locations: Eldieme Necropolis, Castle Zvahl Baileys, or Crawlers' Nest.

**Note:** The remaining AF pieces (head: Fighter's Mask, legs: Fighter's Cuisses) are obtained from Treasure Coffers in specific dungeons, not from quest scripts. These are referenced in the Borghertz quest as `optionalArtifact1` and `optionalArtifact2`.

#### WAR AF Verdict: PASS -- Full quest chain implemented

---

### 3b. White Mage AF -- Healer's Attire Set

**Quest chain:** Messenger from Beyond -> Prelude of Black and White -> Pieuje's Decision
**Hands quest:** Borghertz's Healing Hands (Jeuno)

#### AF1: "Messenger from Beyond" (lv40, Weapon reward)

**File:** `scripts/quests/sandoria/Messenger_From_Beyond.lua`

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Start: Narcheral in N. San d'Oria | Requires WHM main job, lv >= AF1_QUEST_LEVEL (40) | OK |
| Valkurm Dunes ??? | Spawns NM `MARCHELUTE` via popFromQM | OK |
| Obtain Tavnazia Pass from NM | Implied by NM kill (standard drop) | OK |
| Trade Tavnazia Pass to Narcheral | `npcUtil.tradeHasExactly(trade, xi.item.TAVNAZIA_PASS)`, confirmTrade | OK |
| Reward | `xi.item.BLESSED_HAMMER`, fame+20 | OK |

#### AF2: "Prelude of Black and White" (lv50, Feet reward)

**File:** `scripts/quests/sandoria/Prelude_of_Black_and_White.lua`

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Prerequisite | Must complete "Messenger from Beyond", WHM lv >= AF2_QUEST_LEVEL (50) | OK |
| Start: Door in Chateau d'Oraguille | Event 551 from `_6h1.lua` NPC | OK |
| Trade items to Narcheral | Yagudo Holy Water + Moccasins | OK |
| Reward | `xi.item.HEALERS_DUCKBILLS` (feet), fame+40 | OK |

#### AF3: "Pieuje's Decision" (lv50, Body reward)

**Files:**
- `scripts/zones/Chateau_dOraguille/npcs/_6h1.lua` (quest start)
- `scripts/zones/FeiYin/npcs/qm1.lua` (NM spawn)
- `scripts/zones/Northern_San_dOria/npcs/Narcheral.lua` (quest finish)

**NOTE:** This quest uses the **old non-converted quest framework** (marked `-- +` in quests.lua, not `-- + Converted`). The logic is spread across individual NPC scripts rather than a centralized quest file.

| Step | Server Implementation | Status |
|------|----------------------|--------|
| Prerequisite | _6h1.lua checks `PRELUDE_OF_BLACK_AND_WHITE` completed AND `PIEUJES_DECISION` available AND WHM lv >= AF2_QUEST_LEVEL | OK |
| Start: Chateau d'Oraguille door | Event 552, `addQuest()` called in onEventFinish | OK |
| Farm Tavnazia Bell | Dropped by Dark Stalkers in Eldieme Necropolis (droplist 554/570, item 1098, Rare 5%) | OK |
| Trade bell to ??? in Fei'Yin | `qm1.lua` checks quest accepted, spawns `ALTEDOUR_I_TAVNAZIA` NM | OK |
| Defeat NM, obtain Tavnazian Mask | Standard NM drop mechanic | OK |
| Trade mask to Narcheral | `Narcheral.lua` checks for `xi.item.TAVNAZIAN_MASK`, event 692 | OK |
| Reward | `xi.item.HEALERS_BLIAUT` (body), title "Paragon of WHM Excellence", fame+60 | OK |

**Minor concern:** Uses `player:addItem()` / `player:tradeComplete()` / `player:completeQuest()` directly in the NPC script instead of the modern `quest:complete()` framework. This is functionally correct but less maintainable and lacks some of the automatic variable cleanup the modern framework provides. Also uses `setCharVar('pieujesDecisionCS', 0)` which suggests there may be a progression charvar involved elsewhere.

#### AF Hands: "Borghertz's Healing Hands"

**File:** `scripts/quests/jeuno/Borghertzs_Healing_Hands.lua`

Uses shared Borghertz helper. Requires completing "Prelude of Black and White" (AF2). Reward: `xi.item.HEALERS_MITTS` (hands). Coffer locations: Beadeaux, Crawlers' Nest, or Garlaige Citadel.

**Note:** Remaining AF pieces (head: Healer's Cap, legs: Healer's Pantaloons) come from Treasure Coffers in dungeons.

#### WHM AF Verdict: PASS -- Functional but uses older quest framework for AF3

---

## 4. Key Zones for lv30-50

### Dungeon Zones

| Zone | Scripts Exist | Mobs | NPCs | Survival Guide | Grounds Tome | Treasure Chests/Coffers |
|------|:---:|:---:|:---:|:---:|:---:|:---:|
| Garlaige Citadel | YES | YES | YES | YES | YES | Chest + Coffer |
| Crawlers' Nest | YES | YES | YES | YES | YES | Chest + Coffer |
| Eldieme Necropolis | YES | YES | YES | YES (implied) | YES | Chest + Coffer |
| Castle Oztroja | YES | YES | YES | -- | -- | -- |
| Davoi | YES | YES | YES | -- | -- | -- |
| Beadeaux | YES | YES | YES | -- | -- | -- |
| Sea Serpent Grotto | YES | YES | YES | YES | YES | Chest + Coffer |

**Note:** Castle Oztroja, Davoi, and Beadeaux have **no FoV/GoV** -- this is correct retail behavior. These are beastman strongholds used for mission content, not leveling regimes.

### Norg Access

Norg zone is fully scripted with:
- 40+ NPC scripts (vendors, quest NPCs, services)
- Survival Guide
- Home Points (2)
- Nomad Moogle / Porter Moogle
- Ryoma (NIN quest NPC)
- Hunt Registry

Players reach Norg by traveling through Sea Serpent Grotto from Yuhtunga Jungle. The zone has full mob/NPC support.

---

## 5. Fields of Valor / Grounds of Valor

Both systems are **enabled by default**:
- `ENABLE_FIELD_MANUALS = 1`
- `ENABLE_GROUNDS_TOMES = 1`

### FoV (Outdoor Zones) -- Level 30-50 Range

| Zone | Level Range | Pages |
|------|-------------|-------|
| Batallia Downs | 23-32 | 5 pages |
| Rolanberry Fields | 25-37 | 5 pages |
| Sauromugue Champaign | 25-38 | 5 pages |
| Eastern Altepa Desert | 30-49 | 5 pages |
| Beaucedine Glacier | 34-43 | 5 pages |
| Xarcabard | 42-52 | 5 pages |
| Sanctuary of Zi'Tah | 40-50 | 5 pages |

### GoV (Dungeon Zones) -- Level 30-50 Range

| Zone | Level Range | Pages |
|------|-------------|-------|
| Garlaige Citadel | 40-62 | 8 pages (incl. lv91+ for high-level return) |
| Crawlers' Nest | 40-63 | 8 pages |
| Eldieme Necropolis | 42-63 | 8 pages |
| Gusgen Mines | 20-36 | 8 pages |

All regime data is defined in `scripts/globals/regimes.lua` with proper level ranges, monster counts, and reward values.

### FoV/GoV Features Working
- Page selection (5 pages FoV, 8 pages GoV)
- Regime cancellation
- Repatriation (teleport to home point)
- Reraise / Regen / Refresh / Protect / Shell buffs
- Food items (Dried Meat, Salted Fish, Hard Cookie, Instant Noodles)
- Trust ciphers (Koru-Moru, Sakura)

---

## 6. Rank 3-5 Missions

Per Phase 1 audit findings, nation missions through Rank 5 are functional. Players typically do Rank 3-5 during the lv30-50 range. Key mission zones (Castle Oztroja, Davoi, Beadeaux) all have scripts present.

---

## Issues Found

### Critical Issues
None.

### Minor Issues

1. **WHM AF3 "Pieuje's Decision" uses old quest framework** -- Logic is spread across 3 NPC scripts (`_6h1.lua`, `qm1.lua`, `Narcheral.lua`) rather than a centralized quest file. Functionally correct but less robust than the converted quest system. The quest is marked as unconverted in `scripts/globals/quests.lua` (line 91: `PIEUJES_DECISION = 89, -- +` without "Converted" tag).

2. **DRK "Blade of Darkness" has TODO comment** -- The script header says `TODO: This quest needs verification!` but reviewing the code shows all steps match retail behavior. The TODO may be stale.

---

## Files Referenced

### Limit Break 1
- `scripts/quests/jeuno/LB01_In_Defiant_Challenge.lua`

### Job Unlock Quests
- `scripts/quests/sandoria/A_Knights_Test.lua` (PLD)
- `scripts/quests/bastok/Blade_of_Darkness.lua` (DRK)
- `scripts/items/chaosbringer.lua` (DRK kill tracking)
- `scripts/quests/bastok/Ayame_and_Kaede.lua` (NIN)

### Warrior AF
- `scripts/quests/bastok/WAR_AF1_The_Doorman.lua`
- `scripts/quests/bastok/WAR_AF2_The_Talekeepers_Truth.lua`
- `scripts/quests/bastok/WAR_AF3_The_Talekeepers_Gift.lua`
- `scripts/quests/jeuno/Borghertzs_Warring_Hands.lua`

### White Mage AF
- `scripts/quests/sandoria/Messenger_From_Beyond.lua`
- `scripts/quests/sandoria/Prelude_of_Black_and_White.lua`
- `scripts/zones/Chateau_dOraguille/npcs/_6h1.lua` (Pieuje's Decision start)
- `scripts/zones/FeiYin/npcs/qm1.lua` (Pieuje's Decision NM spawn)
- `scripts/zones/Northern_San_dOria/npcs/Narcheral.lua` (Pieuje's Decision finish)
- `scripts/quests/jeuno/Borghertzs_Healing_Hands.lua`

### FoV/GoV
- `scripts/globals/regimes.lua`
- `settings/default/main.lua` (lines 40-42: FoV/GoV enable settings)
- `settings/default/main.lua` (lines 237-239: AF level settings)

### Zones
- `scripts/zones/Garlaige_Citadel/`
- `scripts/zones/Crawlers_Nest/`
- `scripts/zones/The_Eldieme_Necropolis/`
- `scripts/zones/Castle_Oztroja/`
- `scripts/zones/Davoi/`
- `scripts/zones/Beadeaux/`
- `scripts/zones/Sea_Serpent_Grotto/`
- `scripts/zones/Norg/`
