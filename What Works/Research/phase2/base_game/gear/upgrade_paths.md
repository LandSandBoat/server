# Item Upgrade and Augment Paths - Complete Audit

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Monisette, https://www.bg-wiki.com/ffxi/Oboro, https://www.bg-wiki.com/ffxi/Perle_Hauberk_%2B1
- Codebase: scripts/zones/Port_Jeuno/npcs/Sagheera.lua, scripts/zones/Port_Jeuno/DefaultActions.lua, scripts/zones/Castle_Zvahl_Baileys/npcs/Switchstix.lua, scripts/globals/magian.lua, scripts/globals/magian_data.lua, scripts/globals/ambuscade.lua, scripts/globals/unity.lua, scripts/globals/synergy.lua, scripts/globals/nyzul/, modules/abyssea/lua/unlocking_a_myth.lua

## Summary
Most gear upgrade paths from the 75-era (Sagheera AF/Relic +1, Switchstix relic weapons, Magian trials) are functional. All modern upgrade paths (Monisette reforging, Oboro REMA reforging, Ambuscade gear, Aeonic weapons) are either completely MISSING or STUB implementations. Perle/Aurore/Teal +1 upgrades are MISSING (no synergy recipe). Mythic weapon creation path is PARTIAL.

---

## 1. Monisette (AF/Relic/Empyrean Armor Reforging iLvl 109/119)

| Item | Status | Notes |
|------|--------|-------|
| NPC exists in zone | WORKS | Listed in Port_Jeuno DefaultActions.lua |
| NPC script | MISSING | No `scripts/zones/Port_Jeuno/npcs/Monisette.lua` exists |
| NPC interaction | STUB | Only fires generic event 384 from DefaultActions.lua |
| AF reforging (iLvl 109) | MISSING | No implementation |
| AF reforging (iLvl 119 +1) | MISSING | No implementation |
| Relic reforging (iLvl 109) | MISSING | No implementation |
| Relic reforging (iLvl 119 +1) | MISSING | No implementation |
| Empyrean reforging (iLvl 109) | MISSING | No implementation |
| Empyrean reforging (iLvl 119 +1) | MISSING | No implementation |
| Rem's Tale storage | MISSING | No implementation |

### What SHOULD exist (from bg-wiki)
Monisette in Port Jeuno (I-8) handles three upgrade categories:
- **Artifact Armor reforging**: Upgrades AF to iLvl 109, then to iLvl 119 (+1). Requires Rem's Tale chapters (various chapters per piece) plus job-specific materials. Limbus access required to unlock.
- **Relic Armor reforging**: Upgrades Relic armor to iLvl 109, then to iLvl 119 (+1). Requires Rem's Tale chapters plus job-specific materials.
- **Empyrean Armor reforging**: Upgrades Empyrean armor to iLvl 109, then to iLvl 119 (+1). Requires Rem's Tale chapters. Vagary boss titles required per armor slot.
- **Rem's Tale storage**: Can store up to 255 of each chapter type.

### Material Availability
- Rem's Tale chapters: Items exist in `item_basic.sql` and can be obtained via RoE sparks. Available via `sparkshop.lua` and `dealer_moogle.lua`.
- The reforging script logic itself is completely absent.

### Blockers
- No Monisette script exists at all. This is the single biggest gear upgrade gap on the server.
- All iLvl 109/119 AF/Relic/Empyrean armor is unobtainable through normal gameplay.

### Fix Difficulty
- **Hard** - Requires implementing full NPC trade logic for ~330+ armor piece combinations across 22 jobs, 3 armor types, 5 slots each, at 2 tiers.

---

## 2. Oboro (REMA Weapon Reforging)

| Item | Status | Notes |
|------|--------|-------|
| NPC exists in zone | WORKS | Listed in Port_Jeuno DefaultActions.lua |
| NPC script | MISSING | No `scripts/zones/Port_Jeuno/npcs/Oboro.lua` exists |
| NPC interaction | STUB | Only fires generic event 365 from DefaultActions.lua |
| Relic weapon 119 reforging | MISSING | No implementation |
| Empyrean weapon 119 reforging | MISSING | No implementation |
| Mythic weapon 119 reforging | MISSING | No implementation |
| Ergon weapon 119 reforging | MISSING | No implementation |
| Afterglow upgrades | MISSING | No implementation |
| JSE iLvl 119 weapons | MISSING | No implementation |
| Divergence equipment augmentation | MISSING | No implementation |

### What SHOULD exist (from bg-wiki)
Oboro in Port Jeuno (E-6) handles REMA weapon upgrades through three stages:
- **Stage 1 (119 I/II)**: Trade 300 Plutons (Relic), 300 Riftborn Boulders (Empyrean), or 300 Beitetsu (Mythic)
- **Stage 2 (119 III)**: Requires Scintillating Rhapsody KI. Trade 10,000 matching stones (or 1 for Afterglow variants)
- **Stage 3 (Augmented)**: Requires Job Point KI. Upgrade via Astral Detritus crystals to Rank 15.
- **JSE Weapons**: Creates job-specific iLvl 119 weapons using 150 stones plus Delve materials.

### Material Availability
- Pluton, Riftborn Boulder, Beitetsu: Items exist in `item_basic.sql`. Obtainable via RoE records (Pluton Case from 500 mob kills, Beitetsu Parcel from WS damage records).
- No mechanism to actually use these materials with Oboro.

### Blockers
- No Oboro script exists. All REMA weapon upgrades to iLvl 119 are impossible.
- This blocks the entire endgame weapon progression for players who complete relic/empyrean/mythic base weapons.

### Fix Difficulty
- **Hard** - Requires implementing trade logic for 60+ weapons across 4 weapon types, 3 upgrade stages each, plus JSE weapon creation.

---

## 3. Sagheera (AF +1 / Relic +1 Armor - 75 Era)

| Item | Status | Notes |
|------|--------|-------|
| NPC script | WORKS | Full implementation at `scripts/zones/Port_Jeuno/npcs/Sagheera.lua` |
| AF Armor +1 upgrades (22 jobs) | WORKS | 100 AF +1 combinations defined (combinationIds 1-100, plus 201-205 for DNC duplicates) |
| Relic Armor +1 upgrades (22 jobs) | WORKS | 100 Relic +1 combinations defined (combinationIds 101-200) |
| Ancient Beastcoin purchases | WORKS | 10 items purchasable with ABCs |
| Chip-to-ABC exchange | WORKS | Tier 1 chips = 5 ABC, Tier 2 chips = 10 ABC |
| Cosmo Cleanse | WORKS | Implemented with timer (3600s with Rhapsody in Mauve, 72000s without) |
| Trade validation | WORKS | Full material + currency checking |

### Details
- AF +1: Requires base AF piece + 2 Temenos/Apollyon items + 1 crafted item + Ancient Beastcoins (15-40 per piece)
- Relic +1: Requires base Relic piece + Relic -1 piece + crafted ingredient + Dynamis currency (20-30 per piece)
- All 22 jobs covered (WAR through SCH), including both DNC variants

### Blockers
- None. Fully functional.

### Fix Difficulty
- N/A

---

## 4. Magian Trials

| Item | Status | Notes |
|------|--------|-------|
| Trial system infrastructure | WORKS | `scripts/globals/magian.lua` fully implemented with caching, progress tracking, 10 trial slots |
| Trial data | WORKS | `scripts/globals/magian_data.lua` - 15,237 lines, ~1,156 individual trial entries |
| Magian Moogle NPCs | WORKS | Blue (armor) and Orange (weapon) moogles defined |
| Weapon augment trials | WORKS | Stat augment paths (ATK, ACC, DMG, etc.) via mob kills |
| Empyrean weapon trials (75-99) | WORKS | Full chains: e.g., Verethragna 75 -> 85 -> 90 -> 95 -> 99 -> 99 II |
| Relic weapon afterglow trials | WORKS | e.g., Trial 5056: Aegis 99 -> Aegis 99 II via 250 Umbral Marrow |
| AF +2 armor via trials | WORKS | e.g., Trials 4846-4853: Argute armor -> +2 via Forgotten items |
| Relic +2 armor via trials | WORKS | Trade Forgotten items for upgrades |
| Empyrean +2 armor trials | WORKS | EXP-based trials in Dynamis zones |
| Delivery crate trades | WORKS | tradeItem system for material turn-ins |
| Kill-based trials | WORKS | Mob kill counting with zone/weather/day requirements |

### Scope
- ~1,156 trial entries covering:
  - Weapon stat augment paths (multiple tiers per element/stat)
  - Empyrean weapon creation chain (Trial weapons -> 75 -> 85 -> 90 -> 95 -> 99 -> 99 II)
  - AF/Relic/Empyrean armor +2 upgrades via Forgotten items
  - Relic weapon afterglow trials (99 -> 99 II via Umbral Marrow)
  - Various specialty augments

### Blockers
- None for the trial system itself. Individual trials may have missing mob spawns or items, but the framework is solid.
- Note: Empyrean weapon trials beyond 99 II (to iLvl 119) require Oboro, which is MISSING.

### Fix Difficulty
- N/A (system works)

---

## 5. Perle/Aurore/Teal +1 Upgrades

| Item | Status | Notes |
|------|--------|-------|
| Base Perle/Aurore/Teal items | WORKS | Items exist, mods defined in `item_mods.sql` |
| +1 items in database | WORKS | IDs 26711-26713 (head), 27851-27853 (body), 27997-27999 (hands) + legs/feet exist |
| +1 item mods | WORKS | Added previously per project memory |
| Harold's Ore (upgrade material) | PARTIAL | Item exists in `item_basic.sql` (ID 8974) but no way to obtain in normal gameplay |
| Synergy recipe for +1 | MISSING | No synergy recipe exists in `synergy_recipes.sql` for these items |
| Unity NPC upgrade path | MISSING | Unity NPCs only sell basic consumables, no armor upgrade trades |
| Any NPC to perform upgrade | MISSING | No NPC handles Perle/Aurore/Teal +1 creation |

### How it SHOULD work (from bg-wiki)
- Upgrade via Unity NPCs using Harold's Ore x3 per piece
- Harold's Ore drops from Hugemaw Harold (Unity NM in Pashhow Marshlands)
- Trade base piece + 3x Harold's Ore to Unity NPC

### Material Chain
1. Join Unity Concord -> WORKS (Unity NPCs functional for joining/warps/items)
2. Fight Unity NMs -> PARTIAL (Unity NM system implementation unclear)
3. Obtain Harold's Ore -> MISSING (Harold's Coffer exists as item 6312 but no mob drops it)
4. Trade to Unity NPC -> MISSING (Unity NPCs have no onTrade handler - `xi.unity.onTrade` is empty)

### Blockers
- `xi.unity.onTrade` in `scripts/globals/unity.lua` line 116-117 is an empty function
- No Unity NM combat system to obtain Harold's Ore
- No trade logic to exchange ore + base armor for +1

### Fix Difficulty
- **Medium** - Need to: (1) implement Unity NM drops for Harold's Ore, (2) add trade logic to Unity NPCs for armor upgrades, covering 15 pieces (5 slots x 3 sets)

---

## 6. Relic Weapon Upgrade Path (Switchstix)

| Item | Status | Notes |
|------|--------|-------|
| NPC script | WORKS | Full implementation at `scripts/zones/Castle_Zvahl_Baileys/npcs/Switchstix.lua` (1068 lines) |
| Stage 1 (Base -> Relic) | WORKS | Trade relic item + 3 crafted materials |
| Stage 2 (Relic -> Stage 2) | WORKS | Trade 3 common items + currency (14-16 bills/silverpieces/jadeshells) |
| Stage 3 (Stage 2 -> Dynamis) | WORKS | Trade Attestation + currency (60-62 bills/silverpieces/jadeshells) |
| Stage 4 (Dynamis -> Final 75) | WORKS | Trade fragment + Necropsyche + 1 high-value currency |
| All 16 weapons + Aegis | WORKS | Spharai, Mandau, Excalibur, Ragnarok, Guttler, Bravura, Gungnir, Apocalypse, Kikoku, Amanomurakumo, Mjollnir, Claustrum, Annihilator, Gjallarhorn, Yoichinoyumi, Aegis |
| Wait timers between stages | WORKS | Vana'diel midnight (stage 1), configurable wait times (stages 2-3) |
| Cancellation system | WORKS | Option 666 to cancel in-progress relic |
| Duplicate handling | WORKS | Warns if player already has next-stage weapon |
| Conquest tally wait | WORKS | Must wait for conquest tally between completions |
| Aegis special currency | WORKS | Uses all 3 currency types simultaneously |

### Upgrade Stages
1. **Base relic** (from Dynamis drop) + 3 crafted materials -> Start timer
2. Trade Dynamis currency (14-16 units) -> Wait for completion
3. Trade 3 common weapons + Dynamis currency (14-16 units) -> Wait for completion
4. Trade Attestation (from Dynamis) + Dynamis currency (60-62 units) -> Wait for completion
5. Trade Fragment + Shard of Necropsyche + 1 high-denomination currency -> Final weapon

### Currencies
- One Hundred Byne Bill, Montiont Silverpiece, Lungo-Nango Jadeshell (stages 1-3)
- Ten Thousand Byne Bill, Ranperre Goldpiece, Rimilala Stripeshell (stage 4)

### Beyond Level 75
- **75 -> 99**: Via Magian Trials (afterglow path) - WORKS (trial 5056 etc.)
- **99 -> 119**: Via Oboro - MISSING (no Oboro script)

### Blockers
- 75-era path is fully functional
- Progression beyond 99 blocked by missing Oboro NPC

### Fix Difficulty
- N/A for 75-era path

---

## 7. Empyrean Weapon Upgrade Path

| Item | Status | Notes |
|------|--------|-------|
| Magian trial weapon chain | WORKS | Full chain from trial weapons through 75 -> 85 -> 90 -> 95 -> 99 -> 99 II |
| Abyssea NM drops for trials | PARTIAL | Depends on Abyssea NM implementation (zone-by-zone) |
| Trial progression system | WORKS | Kill counts, item trades, EXP gain all functional |
| Verethragna (MNK) chain | WORKS | Trials verified: 75 -> 85 -> 90 -> 95 -> 99 -> 99 II |
| Other empyrean weapons | WORKS | All empyrean weapon data present in magian_data.lua |
| 99 -> 119 via Oboro | MISSING | No Oboro script |

### Trial Chain Example (Verethragna)
- Trial weapons -> Empyrean 75 (via Magian trial kills)
- 75 -> 85 -> 90 -> 95 -> 99 (via progressive Magian trials with Abyssea NM items)
- 99 -> 99 II (via Magian trial: 250 Umbral Marrow)
- 99 II -> 119 via Oboro (MISSING)

### Blockers
- The Magian trial chain to 99 II is complete
- Oboro blocks 119 progression

### Fix Difficulty
- N/A for Magian portion

---

## 8. Mythic Weapon Upgrade Path

| Item | Status | Notes |
|------|--------|-------|
| Nyzul Isle Investigation | PARTIAL | Floor generation, bosses, pathos system exist in `scripts/globals/nyzul/` |
| Floor 100 boss fights | PARTIAL | Boss offsets defined for floors 60-100 |
| Vigil weapons (WS unlock) | WORKS | Module at `modules/abyssea/lua/unlocking_a_myth.lua` with WS point scaling |
| Weapon skill unlocking | WORKS | 20 vigil weapons defined with floor-based WS point requirements |
| Assault Points accumulation | PARTIAL | Assault system exists but completeness unclear |
| Mythic weapon creation NPC | MISSING | No dedicated NPC script for final mythic weapon creation |
| Aftermath effects | WORKS | Tier 1/2/3 Mythic aftermath defined in `scripts/globals/aftermath.lua` |
| 99 -> 119 via Oboro | MISSING | No Oboro script |

### Mythic Weapon Path (Retail)
1. Complete Nyzul Isle Investigation floor 100 -> Get Vigil weapon
2. Unlock hidden weapon skill via WS points on Vigil weapon -> WORKS
3. Obtain base mythic weapon via Zalsuhm trade -> MISSING (no Zalsuhm NPC found)
4. Upgrade through stages via assault points + items -> MISSING
5. 99 -> 119 via Oboro -> MISSING

### Blockers
- Vigil weapons and WS unlocking work
- The actual mythic weapon creation/upgrade NPC chain is not implemented
- Multiple steps require NPCs and trade systems that do not exist

### Fix Difficulty
- **Massive** - Requires implementing the entire mythic weapon creation chain: Zalsuhm NPC, assault point trades, multi-stage upgrades, plus Oboro for 119

---

## 9. Aeonic Weapons

| Item | Status | Notes |
|------|--------|-------|
| Reisenjima zone | WORKS | Zone loads, has entry point and Ethereal Ingress NPCs |
| Geas Fete NM system | MISSING | No Geas Fete implementation found (only reference in `dealer_moogle.lua`) |
| Reisenjima NMs | MISSING | No NM scripts in Reisenjima zone |
| Aeonic weapon items | PARTIAL | Items likely exist in DB, aftermath effects defined |
| Aeonic weapon quest chain | MISSING | No quest scripts for aeonic weapon acquisition |
| Domain Invasion | MISSING | No implementation found |

### Retail Path
1. Unlock Reisenjima via RoV missions -> PARTIAL (RoV missions exist but completeness varies)
2. Defeat Geas Fete T1/T2/T3 NMs in Escha zones -> MISSING
3. Defeat specific Reisenjima NMs -> MISSING
4. Complete Aeonic weapon quest -> MISSING
5. Receive weapon from quest NPC -> MISSING

### Blockers
- Entire Geas Fete and Reisenjima NM system is unimplemented
- No aeonic weapon quest chain exists

### Fix Difficulty
- **Massive** - Requires implementing Geas Fete system, dozens of NMs across 3 Escha zones + Reisenjima, and the quest chains for each weapon

---

## 10. Ambuscade Gear

| Item | Status | Notes |
|------|--------|-------|
| Ambuscade Tome NPC | STUB | Can register for battle but most logic is TODO |
| Gorpa-Masorpa (currency shop) | STUB | Menu opens, currencies tracked, but no actual item exchange |
| Hallmark tracking | WORKS | `current_hallmarks`, `total_hallmarks`, `gallantry` currencies exist |
| Hallmark earning | PARTIAL | Intense hallmarks awarded on instance completion (hardcoded VE difficulty) |
| Instance entry | PARTIAL | `player:createInstance(30000)` called but battle content is minimal |
| Hallmark item shop | MISSING | `onEventUpdateGorpaMasorpa` returns all zeros - no items purchasable |
| Total Hallmark shop | MISSING | Same - no items |
| Gallantry shop | MISSING | Same - no items |
| Ambuscade armor sets | MISSING | Cannot purchase any armor |
| Ambuscade armor upgrades (+1/+2) | MISSING | No upgrade mechanism |
| Monthly rotation | MISSING | Battle content does not rotate |
| Regular Ambuscade | MISSING | Only Intense partially works |
| Difficulty selection | STUB | Options defined but TODO |

### Blockers
- The currency tracking framework exists but the shops are completely empty
- Cannot spend hallmarks/gallantry on anything
- Battle content is minimal stub

### Fix Difficulty
- **Hard** - Requires: (1) populating all 3 shops with correct items and prices, (2) implementing actual battle content with difficulty scaling, (3) monthly rotation system, (4) armor upgrade paths

---

## Summary Matrix

| Upgrade Path | Can START? | Can GATHER materials? | Can COMPLETE? | Overall |
|---|---|---|---|---|
| Monisette (AF/Relic/Emp iLvl reforging) | NO | PARTIAL (Rem's Tales obtainable) | NO | MISSING |
| Oboro (REMA 119 reforging) | NO | PARTIAL (Pluton/Beitetsu/Boulders obtainable) | NO | MISSING |
| Sagheera (AF/Relic +1, 75 era) | YES | YES | YES | WORKS |
| Magian Trials (weapon augments) | YES | YES | YES | WORKS |
| Magian Trials (Empyrean weapons 75-99) | YES | PARTIAL (Abyssea NM dependent) | YES | PARTIAL |
| Magian Trials (AF/Relic/Emp armor +2) | YES | YES (Forgotten items) | YES | WORKS |
| Perle/Aurore/Teal +1 | NO | NO (Harold's Ore unobtainable) | NO | MISSING |
| Relic weapons (75 era, Switchstix) | YES | YES | YES | WORKS |
| Relic weapons (99 afterglow, Magian) | YES | YES | YES | WORKS |
| Relic weapons (119, Oboro) | NO | PARTIAL | NO | MISSING |
| Empyrean weapons (75-99, Magian) | YES | PARTIAL | YES | PARTIAL |
| Empyrean weapons (119, Oboro) | NO | PARTIAL | NO | MISSING |
| Mythic weapons (full path) | PARTIAL | PARTIAL | NO | PARTIAL |
| Aeonic weapons | NO | NO | NO | MISSING |
| Ambuscade gear | PARTIAL | NO (shops empty) | NO | STUB |

---

## Priority Recommendations

1. **Monisette** (CRITICAL) - Blocks all iLvl 109/119 AF/Relic/Empyrean armor for every job. Single biggest gear gap.
2. **Oboro** (CRITICAL) - Blocks all REMA weapon progression to iLvl 119. Second biggest gap.
3. **Ambuscade shops** (HIGH) - Even if battles are stub, populating the currency shops would let GMs grant hallmarks for gear access.
4. **Perle/Aurore/Teal +1** (LOW) - Only relevant for lv78-90 range; quickly outpaced by other gear.
5. **Mythic weapon chain** (LOW) - Massive scope, affects few players.
6. **Aeonic weapons** (LOW) - Requires entire Geas Fete system; massive scope.
