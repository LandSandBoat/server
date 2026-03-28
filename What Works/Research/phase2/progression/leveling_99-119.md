# Leveling 99-119 and Gear Upgrade Paths

## Overview

After level 99, FFXI progression shifts from EXP-based leveling to **item level (iLvl) gear progression**. A player's effective "level" is determined by the iLvl of their equipment, up to iLvl 119. This document audits every gear upgrade path from 99 to 119 in the codebase.

---

## 1. Capacity Points and Job Points

### How It Works (Retail)
- After completing the "Beyond Infinity" limit break (LB10), players receive the **Job Breaker** key item
- Killing mobs level 100+ in field zones earns **Capacity Points (CP)**
- CP fills a bar; when full, you earn 1 **Job Point (JP)**
- JP are spent on passive job-specific upgrades (e.g., +2 enmity for Provoke)
- JP spending is done via the Job Points menu (packet 0x0bf)

### Codebase Status: WORKS
- **LB10 quest exists:** `scripts/quests/jeuno/LB10_Beyond_Infinity.lua` -- grants JOB_BREAKER key item
- **CP distribution C++ code exists:** `src/map/utils/charutils.cpp` line 5136, function `DistributeCapacityPoints()`
  - Checks for JOB_BREAKER key item and level 99
  - Calculates CP based on mob level vs 99
  - Supports capacity chains for mobs 100+
  - Party/alliance distribution handled
- **JP spending handler exists:** `src/map/packets/c2s/0x0bf_job_points_spend.cpp`
- **JP data structures:** `src/map/job_points.cpp`, `src/map/job_points.h`
- **Capacity Ring** available in spark shop (5000 sparks, item 28546) -- boosts CP gain

### Verdict: FUNCTIONAL
Players can earn CP by killing lv100+ mobs after completing Beyond Infinity. JP spending works through the client menu.

---

## 2. Sparks Gear at Level 99

### How It Works (Retail)
The Spark Shop NPC sells gear for Sparks of Eminence currency. At level 99, four armor sets and Eminent weapons become available.

### Codebase Status: WORKS
**File:** `scripts/globals/sparkshop.lua`

#### Level 99 Armor Sets Available (page [10]):
| Set | Slots | Cost per piece | Type |
|-----|-------|---------------|------|
| Outrider (DD melee) | Head/Body/Hands/Legs/Feet | 3000-5000 | iLvl 117 |
| Espial (DEX/AGI) | Head/Body/Hands/Legs/Feet | 3000-5000 | iLvl 117 |
| Wayfarer (Mage) | Head/Body/Hands/Legs/Feet | 3000-5000 | iLvl 117 |
| Temachtiani (Pet) | Head/Body/Hands/Legs/Feet | 2000-3000 | iLvl 117 |

#### Eminent Weapons (7000 sparks each):
Full set of iLvl 117 weapons for all weapon types: baghnakhs, dagger, scimitar, sword, axe, voulge, sickle, lance, katana, great katana, wand, staff, pole, bow, crossbow, gun, shield, animator, sachet, bell, flute.

#### Accessories (10000 sparks each):
Enlivened/Vehemence/Longshot/Fistmele/Perception/Acumen rings, Influx/Upsurge/Allegro/Impregnable/Flashward/Spellbreaker earrings.

### Verdict: FUNCTIONAL
This is the primary "fresh 99" gearing path. Full iLvl 117 sets available for all roles.

---

## 3. Curio Vendor Moogle Gear

### How It Works (Retail)
Curio Vendor Moogles sell gear and consumables for gil, gated behind Rhapsody key items from RoV missions.

### Codebase Status: WORKS
**Files:**
- `scripts/zones/Port_San_dOria/npcs/Curio_Vendor_Moogle.lua`
- `scripts/zones/Port_Bastok/npcs/Curio_Vendor_Moogle.lua`
- `scripts/zones/Port_Windurst/npcs/Curio_Vendor_Moogle.lua`
- `scripts/globals/shop.lua` (line 426, `curioVendorMoogleStock`)

#### Equipment Available (Rhapsody in Umber required):
- Enif/Adhara/Murzim/Shedir armor pieces (30000 gil each) -- these are lv75-era endgame pieces, NOT iLvl gear
- Sortiarius Earring, Patentia Sash, etc.

#### Key Items for Reforging:
- **Rem's Tale chapters 1-10** (7500-15000 sparks each from spark shop) -- these are the materials needed for armor reforging at Monisette

### Verdict: FUNCTIONAL but LIMITED
The Curio Vendor does NOT sell iLvl 119 gear. It sells convenience items, old endgame pieces, and consumables. The important thing is that **Rem's Tale chapters are available from the spark shop**, which are needed for armor reforging.

---

## 4. Bayld Gear (Seekers of Adoulin)

### How It Works (Retail)
Bayld is earned through SoA quests, coalition assignments, and Reives. Various NPCs in Adoulin sell gear for bayld.

### Codebase Status: PARTIALLY IMPLEMENTED

#### Bayld Earning: WORKS
- Quests award bayld (verified in Jorin, Westerly Breeze scripts)
- Sparkshop can exchange sparks for bayld (1000 sparks = 1000 bayld)
- `BAYLD_RATE` setting multiplier exists

#### Bayld Gear Vendors: LIMITED
- **Sifa Alani** (Eastern Adoulin): Sells **maps** for bayld only, NOT gear
- **Ujlei Zelekko** (Eastern Adoulin): Sells potions, ciphers, and scrolls for bayld -- NOT armor/weapons
- **No dedicated bayld armor vendor found** in codebase

### Verdict: PARTIALLY BROKEN
Players can earn bayld, but **there is no NPC selling bayld-purchasable armor** (the Coalition gear vendors that sell iLvl 109/119 armor on retail are not implemented). The currency exchange from sparks works though.

---

## 5. AF/Relic/Empyrean Armor Reforging -- THE CRITICAL PATH

This is the **most important endgame gear upgrade path** on retail FFXI.

### 5a. Monisette (Port Jeuno) -- iLvl 109/119 Armor Reforging

#### How It Works (Retail)
1. Trade Monisette your AF/Relic/Empyrean base armor + Rem's Tale chapters + gil
2. She returns the iLvl 109 version
3. Trade the 109 version + more Rem's Tales + more gil for iLvl 119 version

Materials per slot:
- **AF to iLvl 109:** Base AF armor + Rem's Tale chapters (varies by slot) + ~10,000 gil
- **AF 109 to iLvl 119:** AF 109 armor + more Rem's Tale chapters + ~100,000-200,000 gil
- Same pattern for Relic and Empyrean armor

#### Codebase Status: BROKEN -- NO SCRIPT EXISTS

- **Entity exists in npc_list.sql:** ID 17784989, positioned at (-6, 0.001, -11) in Port Jeuno
- **DefaultActions.lua:** Has `['Monisette'] = { event = 384 }` -- generic dialogue only
- **NO script file:** `scripts/zones/Port_Jeuno/npcs/Monisette.lua` does NOT exist
- **NO trade handler, NO reforging logic anywhere in codebase**

#### Impact: CRITICAL
Without Monisette, players **cannot upgrade AF/Relic/Empyrean armor to iLvl 109 or 119**. This blocks the primary armor upgrade path for every job. On retail, this is how most players get their first iLvl 119 armor.

**Materials ARE available though:**
- Rem's Tale chapters 1-10 can be purchased from the spark shop (7500-15000 sparks each)
- This means the materials exist but the NPC to use them does not

### 5b. Oboro (Port Jeuno) -- REMA Weapon Reforging

#### How It Works (Retail)
1. Trade Oboro your Relic/Mythic/Empyrean level 99 weapon + 300 Pluton/Beitetsu/Riftborn Boulder
2. He returns the iLvl 119 version
3. Further upgrades to 119 III with 10,000 materials + Scintillating Rhapsody KI
4. JSE (job-specific) weapons also crafted via Oboro

#### Codebase Status: BROKEN -- NO SCRIPT EXISTS

- **Entity exists in npc_list.sql:** ID 17784988, positioned at (-180, 11, 86) in Port Jeuno
- **DefaultActions.lua:** Has `['Oboro'] = { event = 365 }` -- generic dialogue only
- **NO script file:** `scripts/zones/Port_Jeuno/npcs/Oboro.lua` does NOT exist

#### Impact: HIGH (but secondary)
This affects players who have completed Relic/Mythic/Empyrean weapons (a very long grind). For a 4-player server this may be lower priority than Monisette, but it still blocks REMA weapon upgrades entirely.

### 5c. Sagheera (Port Jeuno) -- OLD AF+1/Relic+1 Upgrades

#### Codebase Status: WORKS (for old-style upgrades only)
**File:** `scripts/zones/Port_Jeuno/npcs/Sagheera.lua`

Sagheera handles:
- **AF armor to AF+1** (Limbus-era upgrades using Ancient Beastcoins + Temenos/Apollyon items + crafted items)
- **Relic armor to Relic+1** (using Dynamis currency + relic -1 items + ingredients)
- **Ancient Beastcoin shop** (accessories like Brutal Earring, Loquacious Earring)
- **Cosmo Cleanse** (resetting Limbus entry)

**Important:** Sagheera handles the **old** upgrade path (pre-iLvl system). She does NOT handle iLvl 109/119 reforging. That is Monisette's job.

The old AF+1 and Relic+1 are level 75 gear, not iLvl gear. They are stepping stones in the upgrade chain:
- Base AF (lv52-60) -> AF+1 (lv75, via Sagheera) -> AF iLvl 109 -> AF iLvl 119 (via Monisette, BROKEN)

### Verdict: Sagheera WORKS for her part, but Monisette is MISSING so the chain is broken at iLvl 109+.

---

## 6. Ambuscade Gear

### How It Works (Retail)
Ambuscade is the primary repeatable endgame content. Players earn Hallmarks and Gallantry currency, which are spent on iLvl 119 armor and weapons at Gorpa-Masorpa in Mhaura.

### Codebase Status: PARTIALLY IMPLEMENTED (mostly TODO)

**Files:**
- `scripts/globals/ambuscade.lua` -- core logic
- `scripts/zones/Mhaura/npcs/Gorpa-Masorpa.lua` -- reward vendor
- `scripts/zones/Mhaura/npcs/Ambuscade_Tome.lua` -- battle entry
- `scripts/zones/Maquette_Abdhaljs-Legion_B/instances/ambuscade.lua` -- instance

#### What Works:
- Gorpa-Masorpa NPC exists and shows menus
- Currency tracking (hallmarks, total_hallmarks, gallantry) is implemented
- Instance creation fires (createInstance(30000))
- Post-battle hallmark/gallantry distribution logic exists

#### What's Broken/TODO:
- `onTradeGorpaMasorpa` = `-- TODO` (cannot spend hallmarks on gear)
- `onEventUpdateGorpaMasorpa` option handlers all return `player:updateEvent(0,0,0,0,0,0,0,0)` -- no actual item purchase logic
- Ambuscade Tome difficulty selection = `--TODO`
- Instance monster rotation not implemented (monthly rotation system)
- The battle entry process is stub-level

### Verdict: BROKEN
Players can technically enter Ambuscade and earn hallmarks, but **cannot spend hallmarks/gallantry on gear**. The reward purchase system is entirely TODO. This is the second most important endgame gear source after Monisette.

---

## 7. Escha Gear

### How It Works (Retail)
- Enter Escha zones (Zi'Tah, Ru'Aun, Reisenjima) and fight NMs
- NMs drop armor/weapons directly, plus stones (Ghastly Stone, etc.)
- Trade stones to NPCs for additional gear

### Codebase Status: MOSTLY MISSING

#### Escha Zi'Tah:
- Zone exists with portals and navigation NPCs
- **NO mob scripts** -- `scripts/zones/Escha_ZiTah/mobs/` directory has zero files
- No NMs to fight = no gear drops

#### Escha Ru'Aun:
- Zone exists
- Only 2 mob scripts: `Eschan_Gargouille.lua`, `Eschan_Ilaern.lua` (basic trash mobs)
- **No NM scripts** for gear-dropping bosses

#### Reisenjima:
- Zone exists with Ethereal Ingress navigation NPCs (#1-#9)
- **NO mob scripts** -- zero files in mobs directory
- No NMs to fight

#### Stone Exchange:
- `GHASTLY_STONE_P2` (item 3956) exists in enum and dealer_moogle data
- But no NPC exchange system for Escha gear

### Verdict: BROKEN
Escha zones exist as empty shells. No NMs, no gear drops, no stone exchange. This entire gear path is non-functional.

---

## 8. Unity Gear

### How It Works (Retail)
- Unity Concord NPCs sell gear upgrades using Unity Accolades
- Includes the **Perle/Aurore/Teal +1 upgrade** (see section 9)
- Unity Wanted NMs drop upgrade materials (Harold's Ore, etc.)

### Codebase Status: PARTIALLY WORKING

**File:** `scripts/globals/unity.lua`

#### What Works:
- Unity joining and leader selection: WORKS
- Unity warps: WORKS (full zone list implemented)
- Unity accolades earning: WORKS (via Records of Eminence)
- Unity item shop: WORKS (Refractive Crystal, skill-up items, convenience items)

#### What's Missing:
- **Gear upgrade system NOT implemented** -- Unity NPCs only handle warps, item purchases, and leader changes
- No handler for armor trade-in upgrades (category for gear upgrades not in the code)
- Unity Wanted NM spawn system: NOT VERIFIED (would need separate check)

### Verdict: PARTIALLY WORKING
Unity warps and accolades work, but the gear upgrade path (which is how Perle/Aurore/Teal +1 is obtained) is not implemented in the Unity NPC script.

---

## 9. Perle/Aurore/Teal +1 Upgrade Path

### How It Works (Retail)
Per bg-wiki:
- Base Perle/Aurore/Teal gear is lv78, obtained from Abyssea
- +1 versions are lv90, obtained via **Unity NPC upgrades**
- Trade base armor + **3x Harold's Ore** (or equivalent material per set) to a Unity NPC
- Harold's Ore drops from the Unity Wanted NM "Hugemaw Harold" in East Ronfaure

### Codebase Status: BROKEN

#### Materials:
- **Harold's Ore** (item 8974, `chunk_of_harold_hugemaws_red_ore`) exists in `item_basic.sql`
- Item is categorized under Smithing materials
- Referenced in `scripts/enum/item.lua` (item ID 8974 referenced)

#### Upgrade NPC:
- Unity NPCs exist (Southern San d'Oria, Bastok Markets, Windurst Woods, Western Adoulin)
- **Unity NPC trade handler is empty:** `xi.unity.onTrade = function(player, npc, trade) end` -- literally does nothing
- No gear upgrade logic exists anywhere in the Unity system

#### NM Source:
- Hugemaw Harold NM and Harold's Coffer (item 6312) exist in item database
- Whether the NM actually spawns and drops correctly needs in-game testing

### Verdict: BROKEN
The items exist in the database but the Unity NPC has no trade handler, so even if a player obtains Harold's Ore, they cannot trade it to upgrade their gear. The +1 sets we previously added mods for (head/body/hands IDs 26711-26713, 27851-27853, 27997-27999) have stats but no way to obtain them in-game.

---

## 10. Domain Invasion Gear

### Codebase Status: MISSING (confirmed from Phase 1)
- No domain invasion scripts found
- No `DOMAIN_INVASION` references in scripts
- This daily Escha content is entirely unimplemented

---

## 11. Magian Trials (Weapon Upgrades)

### Codebase Status: PARTIALLY IMPLEMENTED

**Files:**
- `scripts/globals/magian_data.lua` -- trial definitions
- `scripts/globals/magian.lua` -- trial system logic

Magian trials exist for upgrading weapons through kill/trade requirements. This is the old (pre-iLvl) weapon upgrade path. Trials are defined and the system appears functional, but coverage of all trials needs verification.

---

## Summary: Gear Progression Gaps

### What WORKS (player can use today):
| Path | Status | iLvl | Notes |
|------|--------|------|-------|
| Spark shop lv99 gear | WORKS | 117 | Full armor sets + weapons for all jobs |
| Capacity Points / Job Points | WORKS | N/A | Passive stat boosts |
| Sagheera AF+1/Relic+1 | WORKS | N/A (lv75) | Old-style upgrades only |
| Curio Vendor consumables | WORKS | N/A | Rem's Tales available for purchase |
| Magian Trials | PARTIAL | N/A (lv75-90) | Old weapon upgrade path |

### What's BROKEN (blocks progression):
| Path | Status | Impact | Fix Difficulty |
|------|--------|--------|---------------|
| **Monisette (AF/Relic/Emp reforging)** | NO SCRIPT | CRITICAL -- blocks ALL iLvl 109/119 armor | HIGH -- needs full NPC implementation |
| **Oboro (REMA weapon reforging)** | NO SCRIPT | HIGH -- blocks REMA weapon upgrades | HIGH -- needs full NPC implementation |
| **Ambuscade gear purchases** | TODO stubs | HIGH -- primary repeatable endgame gear | MEDIUM -- framework exists, needs reward logic |
| **Unity gear upgrades** | Empty trade handler | MEDIUM -- blocks Perle/Aurore/Teal +1 | MEDIUM -- needs trade handler in unity.lua |
| **Escha NMs and gear** | No mobs | HIGH -- entire zone system empty | VERY HIGH -- needs hundreds of NM scripts |
| **Bayld armor vendors** | Not implemented | MEDIUM -- SoA gear path blocked | MEDIUM -- needs vendor NPC scripts |
| **Domain Invasion** | Not implemented | LOW | VERY HIGH -- entire system missing |

### The Critical Bottleneck

**A player at level 99 can buy iLvl 117 sparks gear, but has NO path to iLvl 119.**

The progression is supposed to be:
```
Lv99 -> Sparks gear (iLvl 117) -> AF/Relic/Emp reforged (iLvl 109 -> 119)
                                -> Ambuscade gear (iLvl 119)
                                -> Escha NM drops (iLvl 119)
```

All three iLvl 119 paths are broken. **Monisette is the single most impactful missing NPC** because:
1. Every job has AF/Relic/Empyrean armor
2. Rem's Tales (the materials) are already purchasable from spark shop
3. It's a straightforward trade-based system (trade items, get upgrade)
4. It covers ALL 5 armor slots for ALL 22 jobs

### Recommended Priority for Fixes:
1. **Monisette** -- implement AF/Relic/Empyrean armor reforging to iLvl 109 and 119
2. **Ambuscade reward spending** -- implement hallmark/gallantry gear purchases
3. **Unity trade handler** -- implement Perle/Aurore/Teal +1 upgrades
4. **Oboro** -- implement REMA weapon reforging (lower priority for small server)
5. **Bayld armor vendors** -- implement coalition gear shops
6. **Escha NMs** -- very large project, lowest priority

---

## Key File Locations Reference

| File | Purpose |
|------|---------|
| `scripts/zones/Port_Jeuno/npcs/Sagheera.lua` | AF+1/Relic+1 old upgrades (WORKS) |
| `scripts/zones/Port_Jeuno/DefaultActions.lua` | Monisette/Oboro generic dialogue |
| `scripts/globals/sparkshop.lua` | Spark shop gear (iLvl 117 at 99) |
| `scripts/globals/shop.lua` | Curio Vendor Moogle stock |
| `scripts/globals/unity.lua` | Unity NPC system (warps work, gear doesn't) |
| `scripts/globals/ambuscade.lua` | Ambuscade system (mostly TODO) |
| `scripts/globals/magian_data.lua` | Magian trial definitions |
| `scripts/globals/magian.lua` | Magian trial system |
| `src/map/utils/charutils.cpp:5136` | Capacity Points distribution |
| `src/map/job_points.cpp` | Job Points system |
| `sql/npc_list.sql:31584-31585` | Monisette/Oboro entity definitions |
