# Vendors, Currency Systems, and Gear Vendors

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Currency
- Codebase: scripts/globals/sparkshop.lua, scripts/globals/shop.lua, scripts/globals/conquest.lua, scripts/globals/unity.lua, scripts/globals/ambuscade.lua, scripts/globals/dynamis.lua, scripts/zones/*/npcs/

## Summary
Most currency vendor systems are implemented and functional. Sparks shop (via RoE NPC), Curio Vendor Moogle, Conquest CP shop, Unity Accolade shop, Cruor Prospectors, and Dynamis relic upgrade (Switchstix) all have working handlers. Ambuscade reward spending is STUB (menus present, purchases not implemented). Domain Invasion vendor (Zurim) has a full item list and purchase handler but Domain Invasion battles themselves are not implemented, so players cannot earn points. Bayld is earned via Adoulin quests; spending options are limited to maps (Sifa Alani) and the Peacekeepers Coalition (Ujlei Zelekko) -- no dedicated bayld gear vendor exists.

---

## 1. Sparks Vendor (RoE NPC / Spark Shop)

### NPC Scripts
- `scripts/zones/Southern_San_dOria/npcs/Rolandienne.lua` (Sandy)
- Equivalent NPCs exist in Bastok Markets and Windurst Woods

### Status: WORKS

### How It Works
- Player talks to RoE NPC (e.g., Rolandienne)
- NPC checks for Memorandoll KI (initial RoE setup)
- Opens spark shop via `xi.sparkshop.onTrigger` -> event 995
- Purchase logic in `xi.sparkshop.onEventUpdate` handles item granting, currency deduction

### Gear Tiers Available (from `scripts/globals/sparkshop.lua`)
| Category | Level Range | Sparks Cost | Status |
|----------|-------------|-------------|--------|
| [3] Equipment Lv.1-9 | 1-9 | 50 each | WORKS |
| [4] Equipment Lv.10-19 | 10-19 | 60-520 each | WORKS |
| [5] Equipment Lv.20-29 | 20-29 | 70-525 each | WORKS |
| [6] Equipment Lv.30-39 | 30-39 | 80-540 each | WORKS |
| [7] Equipment Lv.40-49 | 40-49 | (exists in file) | WORKS |
| [8] Equipment Lv.50-59 | 50-59 | (exists in file) | WORKS |
| [9] Equipment Lv.60-69 | 60-69 | (exists in file) | WORKS |
| [10] Equipment Lv.70-98 | 70-98 | (exists in file) | WORKS |
| [11] Eminent/iLvl 117 | 99 (iLvl 117) | 2000-10000 | WORKS |

### iLvl 117 Gear (Category 11)
Includes: Eminent weapons (all types, 7000 sparks), Temachtiani armor set (2000 sparks each), Eminent rings/earrings (10000 sparks), Eminent ammo (5000-7000 for stacks of 99), plus trust ciphers for Alter Ego Extravaganza.

### Consumables & Other Items (Category 1-2)
- Instant Warp/Reraise scrolls (10 sparks)
- Rem's Tale chapters 1-10 (7500-15000 sparks)
- Capacity Ring (5000 sparks)
- Skill-up tomes for all weapon/magic skills (200 sparks each, 33 total)
- Etched Memory (10000 sparks)

### Currency Exchange (Category 20, via Copper A.M.A.N. Vouchers)
Copper Vouchers can be exchanged for 1000 of various currencies: sparks, CP, imperial standing, allied notes, bayld, valor points, assault points (5 types), cruor, kinetic units, obsidian fragments, mweya plasm, ballista points, unity accolades, resistance credits.

### Sparks-to-Gil Exchange
There is NO direct sparks-to-gil conversion in the spark shop. On retail, players sell spark-purchased items to NPC shops for gil (the "sparks to gil" method). This works as long as NPC shops buy items -- which is standard behavior.

### Weekly Exchange Limit
- `settings/default/main.lua` line 62-64: ENABLE_EXCHANGE_LIMIT = 1, WEEKLY_EXCHANGE_LIMIT = 100000
- Enforced in sparkshop.lua and unity.lua
- Tracks via `weekly_sparks_spent` charVar

---

## 2. Curio Vendor Moogle

### NPC Scripts
- `scripts/zones/Port_Bastok/npcs/Curio_Vendor_Moogle.lua`
- `scripts/zones/Port_Windurst/npcs/Curio_Vendor_Moogle.lua`
- `scripts/zones/Port_San_dOria/npcs/Curio_Vendor_Moogle.lua`

### Status: WORKS

### Prerequisite
- Requires `xi.ki.RHAPSODY_IN_WHITE` key item (correct, matches retail)
- Without it, event 9600 plays (no shop access)
- With it, event 9601 opens the menu

### Stock (from `scripts/globals/shop.lua` lines 426-668+)
Items are gated by progressive Rhapsody KIs:

| Category | Contents | KI Gate |
|----------|----------|---------|
| Medicine | Potions, Hi-Potions, Ethers, Elixirs, Antidotes, Prism Powder, Silent Oil, Reraisers, Mog Pells | White through Azure |
| Ammunition | Arrow/Bolt/Bullet/Shuriken quivers/pouches (all tiers) | White through Crimson |
| Ninjutsu Tools | All toolbags (Uchitake through Soshi) | White through Crimson |
| Food Stuffs | Extensive food list: melee/mage/ranged foods, sushi, pies, mochi | White through Crimson |
| Scrolls | Instant Warp/Reraise/Retrace/Protect/Shell/Stoneskin | White through Umber |
| Keys | All dungeon chest/coffer keys (18 chest keys, 14 coffer keys) | White/Umber |
| Equipment | Cosmetic/AF-era gear (Enif/Adhara/Murzim/Shedir sets, Custom/Magna/Wonder/Savage/Elder sets) | Umber |

### Purchase Mechanism
- `xi.shop.curioVendorMoogle()` in shop.lua lines 60-80
- Filters stock by which Rhapsody KIs the player has
- Creates a shop with only eligible items
- Standard shop purchase (player pays gil from stock prices)
- Note: comment on line 94 says "keyitems not implemented yet"

---

## 3. Conquest Points (CP)

### NPC Scripts
- `scripts/globals/conquest.lua` -- main system (1488+ lines)
- Overseer NPCs in each nation city + outposts + Jeuno

### Status: WORKS

### What Players Can Buy
Defined in `overseerInvCommon` (line 709) and `overseerInvNation` (line 727):

**Common Items (all nations):**
| Item | CP Cost |
|------|---------|
| Scroll of Instant Reraise | 7 |
| Scroll of Instant Warp | 10 |
| Return Ring | 2,500 |
| Homing Ring | 9,000 |
| Chariot Band (exp ring) | 500 |
| Empress Band (exp ring) | 1,000 |
| Emperor Band (exp ring) | 2,000 |
| Warp Ring | 5,000 |
| Trust Ciphers (Tenzen, Rahal, Kukki, Makki) | 1,000 each |
| Refined Chair Set | 20,000 (Rank 10) |
| Kingdom/Republic/Federation Signet Staff | 5,000 |

**Nation-specific gear:** Ranked equipment from Rank 1 (1,000 CP) through Rank 10 (56,000 CP), covering weapons, armor, shields, and accessories. Each nation has ~35 unique items.

### Purchase Flow
1. Player talks to Overseer -> `xi.conquest.overseerOnTrigger` (line 1179)
2. Menu shows CP balance, available items based on nation rank
3. `overseerOnEventUpdate` (line 1232) validates job/level/CP
4. `overseerOnEventFinish` (line 1341) grants item, deducts CP

### Additional CP Features
- Crystal donation for rank points (line 1089)
- Exp ring recharge (lines 1127-1175)
- Supply runs for outpost teleport access
- Signet (line 1353)
- Homepoint setting (line 1400)

---

## 4. Cruor Prospectors (Abyssea)

### NPC Scripts
- `scripts/zones/Abyssea-La_Theine/npcs/Cruor_Prospector.lua` (and 8 other Abyssea zones)

### Status: WORKS (previously audited)

### Stock
Each Cruor Prospector has zone-specific key items plus shared items/temps/buffs from global tables (`xi.abyssea.visionsCruorProspectorItems`, etc.). Purchase flow delegates to `xi.abyssea.visionsCruorProspectorOnTrigger` and `OnEventFinish`.

---

## 5. Bayld Vendors (Adoulin)

### Status: PARTIAL

### Bayld Earning
Bayld is earned through Adoulin quests. Multiple NPCs award bayld on quest completion:
- Jorin (The Old Man and the Harpoon): 300 bayld
- Pagnelle (Raptor Rapture): 1,000 bayld
- Clautaire (F.A.I.L.ure Is Not an Option): 500 bayld
- Westerly Breeze (Always More Quoth the Ravenous): 1,000 bayld
- Merleg (A Pioneer's Best Imaginary Friend): 200 bayld
- Bayld rate multiplied by `xi.settings.main.BAYLD_RATE`

### Bayld Spending NPCs

| NPC | Zone | What They Sell | Status |
|-----|------|---------------|--------|
| Sifa Alani | Eastern Adoulin | Maps (Adoulin/Ulbuka zones, 0-2000 bayld each) | WORKS |
| Ujlei Zelekko | Eastern Adoulin | Potions, ethers, scrolls, trust ciphers (10-2500 bayld) | PARTIAL -- only opens during Extravaganza campaigns |
| Sylvie | Western Adoulin | Matre Bell replacement (150,000 bayld option for GEO) | WORKS |

### Missing
- **No dedicated bayld gear vendor** -- on retail, bayld can buy iLvl 119 Alluvion Skirmish gear and other Adoulin equipment. This does not appear to be implemented.
- Ujlei Zelekko's shop only opens during Extravaganza campaigns (line 37: `if active > 0 then`), so normally he just stares blankly.
- Coalition assignments (which earn bayld) are not implemented (TODO in code).

### Fix Difficulty
- Medium (Ujlei Zelekko always-open fix is easy; bayld gear vendor would need new NPC/stock data)

---

## 6. Unity Accolades

### NPC Scripts
- `scripts/globals/unity.lua`
- Unity Concord NPCs in S. Sandy, Bastok Markets, Windurst Woods, Western Adoulin

### Status: WORKS

### What Players Can Buy (from `unityOptions[4]`, line 79-94)

| Item | Cost (Accolades) |
|------|-----------------|
| Refractive Crystal | 15,000 |
| Special Gobbiedial Key | 15,000 |
| Instant Warp/Reraise/Protect/Shell scrolls | 10 each |
| Moist Rolanberry, Ravaged Moko Grass, etc. (bait/pet items) | 10 each |
| Training Manual | 10 |
| Pinch of Prize Powder | 10 |

### Unity Warps
Extensive warp list (55+ destinations) defined in `unityOptions[1]` (lines 20-77). All functional -- previous fix forced unity rank to 1 so all warps are available.

### Unity Leader Change
- Players can switch Unity leader for an accolade cost (100-5000 depending on rank difference)
- One change per week enforced via `unity_changed` charVar

### Missing from Unity Shop
- On retail, Unity NPCs also sell Unity-ranked weapons, augmented gear, and trust ciphers beyond what's listed. The current shop is quite limited (only consumables).

### Fix Difficulty
- Medium (adding more items to `unityOptions[4]` table)

---

## 7. Ambuscade Currency (Hallmarks / Gallantry)

### NPC Scripts
- `scripts/globals/ambuscade.lua`
- `scripts/zones/Mhaura/npcs/Gorpa-Masorpa.lua` (reward NPC)
- Ambuscade Tome (entry NPC) in same zone

### Status: STUB

### Currency Earning
- `xi.ambuscade.onInstanceComplete` (line 149) grants hallmarks and gallantry after clearing
- Hallmarks: 200-3600 based on difficulty, multiplied by party size
- Gallantry: 20-300 based on difficulty, multiplied by (party size - 1)
- Currency stored via `current_hallmarks`, `total_hallmarks`, `gallantry`

### Gorpa-Masorpa (Reward NPC)
- Menu opens (event 386) showing hallmark/gallantry balances
- **All reward purchase handlers are empty stubs:**
  - Option 1 (Hallmarks menu): `player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)` -- no items granted
  - Option 5 (Total Hallmarks menu): same empty update
  - Option 9 (Gallantry menu): same empty update
- `onEventFinishGorpaMasorpa` only handles the intro CS (event 385) for RoE record 499

### Ambuscade Entry (Tome)
- `onTriggerTome` (line 97): hardcoded to only show Intense difficulty (regular/light hidden)
- `onEventUpdateTome` (line 120): marked `--TODO`, does nothing
- `onEventFinishTome` (line 138): only option 5 (Intense VE) creates an instance
- Instance creation works for Intense VE only

### Verdict
**Players can earn hallmarks/gallantry but CANNOT spend them on rewards.** The reward menus display but purchasing any item does nothing.

### Fix Difficulty
- Hard (requires mapping all hallmark/gallantry reward item tables and implementing purchase logic in onEventUpdate handlers)

---

## 8. Domain Invasion Points

### NPC Script
- `scripts/zones/Norg/npcs/Zurim.lua`

### Status: PARTIAL (vendor WORKS, earning MISSING)

### Zurim's Shop (Fully Implemented!)
Contrary to the prior note that Domain Invasion is "known MISSING," the **vendor NPC is fully functional** with a complete item catalog:

| Page | Items | Cost (points) |
|------|-------|---------------|
| 1 | Eschalixir +2, Frayed Sacks (Fecundity/Plenty/Opulence) | 10 |
| 2 | Hervor armor set (5pc), Heidrek armor set (5pc), Angantyr armor set (5pc) | 40 |
| 3 | Voluspa weapons (16 types + ammo) | 80 |
| 4 | Sanctity Necklace, Gishdubar Sash, Eabani Earring, Etana Ring, Izdubar/Solemnity Cape | 100 |
| 5 | Instigator, Hammerfists, Queller Rod, Lathi, Emissary, Shijo, + 16 more weapons | 200 |
| 6 | Abjuration sets (Triton/Bushin/Vale/Grove/Abyssal/Shinryu/Cronian/Arean/Jovian/Venerian/Cyllenian) | 400 |
| 7 | Domain earrings (18 types) | 600 |
| 8 | Augmentable weapons + Odyssean/Valorous/Herculean/Chironic/Merlinic armor sets | 800 |
| 9 | Premium ammo, accessories (earrings, rings, sashes) | 1000 |
| 10 | Pile of Wyrm Ash | 1200 |

### Purchase Mechanism
- `onTrigger`: reads `domain_points` currency, opens event 9512
- `onEventUpdate`: parses page/subpage/selection from option bits, calls `npcUtil.giveItem`, deducts currency
- Fully functional purchasing

### What's Missing
- **Domain Invasion battles themselves** -- the actual Escha zone events that award domain points are not implemented
- Players have no way to earn `domain_points` currency without GM commands
- Workaround: `!addcurrency domain_points <amount>`

### Fix Difficulty
- Massive (Domain Invasion is a complex instanced content system)

---

## 9. Dynamis Currency / Relic Weapons

### NPC Scripts
- `scripts/globals/dynamis.lua` (entry system)
- `scripts/zones/Castle_Zvahl_Baileys/npcs/Switchstix.lua` (relic upgrade NPC)

### Status: WORKS

### Dynamis Entry
- Full entry system with 10+ Dynamis zones defined in `entryInfo` table
- Entry requires specific key items, prior Dynamis clears, etc.
- Mobs in Dynamis drop ancient currency (100-byne bills, Montiont Silverpieces, Lungo-Nango Jadeshells)

### Relic Weapon Upgrade (Switchstix)
- Complete upgrade path defined for all relic weapons
- Multi-stage upgrades requiring traded items + ancient currency
- Example path: Relic Knuckles -> requires Koh-i-Noor + Griffon Leather + Adaman Sheet + 4x 100-byne bills (stage 1)
- Continues through Militant -> Dynamis -> final stages requiring attestations and progressively more currency

### Sagheera (Port Jeuno)
- `scripts/zones/Port_Jeuno/npcs/Sagheera.lua`
- Handles AF armor +1 upgrades via Limbus (Temenos/Apollyon items + ABC currency + crafted materials)
- Complete trade tables for all 22 jobs' AF armor pieces

---

## Overall Checklist

| Vendor System | NPC Exists | Script Handles Purchase | Items Granted | Earning Method Works | Overall |
|--------------|------------|------------------------|---------------|---------------------|---------|
| Sparks Shop (RoE NPC) | Yes | Yes | Yes | Yes (RoE objectives) | WORKS |
| Curio Vendor Moogle | Yes (3 cities) | Yes | Yes | N/A (gil shop, gated by KIs) | WORKS |
| Conquest Points | Yes (many overseers) | Yes | Yes | Yes (conquest activities) | WORKS |
| Cruor Prospectors | Yes (9 zones) | Yes | Yes | Yes (Abyssea activities) | WORKS |
| Bayld (Maps) | Yes (Sifa Alani) | Yes | Yes (KIs) | Yes (Adoulin quests) | WORKS |
| Bayld (Consumables) | Yes (Ujlei Zelekko) | Yes | Yes | PARTIAL (only during Extravaganza) | PARTIAL |
| Bayld (Gear) | No | N/A | N/A | N/A | MISSING |
| Unity Accolades (Items) | Yes | Yes | Yes | Yes (Unity RoE) | WORKS |
| Unity Accolades (Gear) | No | N/A | N/A | N/A | MISSING |
| Ambuscade (Hallmarks) | Yes (Gorpa-Masorpa) | STUB | No | Yes (instance clear) | STUB |
| Ambuscade (Gallantry) | Yes (Gorpa-Masorpa) | STUB | No | Yes (instance clear) | STUB |
| Domain Invasion (Zurim) | Yes | Yes | Yes | No (battles not implemented) | BLOCKED |
| Dynamis / Relic (Switchstix) | Yes | Yes | Yes | Yes (Dynamis drops) | WORKS |
| AF +1 Upgrade (Sagheera) | Yes | Yes | Yes | Yes (Limbus drops) | WORKS |

## Blockers
- **Ambuscade rewards**: Menu shows but all purchase handlers are empty stubs. Players earn currency but cannot spend it.
- **Domain Invasion battles**: Not implemented. Vendor is complete but players cannot earn domain points.
- **Bayld gear vendors**: No Adoulin gear vendors exist for bayld purchases.
- **Unity gear**: Shop only sells consumables, not the ranked weapons/gear available on retail.
- **Ujlei Zelekko**: Only opens during Extravaganza campaigns (easy fix: remove the `if active > 0` gate).

## Fix Difficulty
- Ujlei Zelekko always-open: **Easy** (remove campaign check)
- Unity shop expanded items: **Medium** (add item tables)
- Ambuscade reward purchasing: **Hard** (implement full reward tables and purchase handlers)
- Bayld gear vendor: **Medium** (create NPC + stock tables based on retail data)
- Domain Invasion battles: **Massive** (complex instanced content)
