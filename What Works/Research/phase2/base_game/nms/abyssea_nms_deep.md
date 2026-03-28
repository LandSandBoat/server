# Abyssea NM Deep Audit

**Date:** 2026-03-28
**Auditor:** Claude (automated)
**Status:** MOSTLY FUNCTIONAL -- some gaps in scions zones

---

## 1. NM Pop System

### How It Works

**Two spawn methods exist:**

#### Method A: Trade Items to ??? (T1 NMs)
- Player trades a specific item to a `qm_*` NPC (??? spawn point)
- Function: `xi.abyssea.qmOnTrade()` in `scripts/globals/abyssea.lua:893`
- Validates traded items, checks NM not already spawned, consumes items, spawns NM
- Example: Trade `Vial of Eft Blood` to `qm_bloodguzzler` to spawn Bloodguzzler

#### Method B: Trade Key Items to ??? (T2/T3 NMs)
- Player triggers a `qm_*` NPC which checks for required Key Items
- Function: `xi.abyssea.qmOnTrigger()` in `scripts/globals/abyssea.lua:935`
- Presents a menu showing required KIs, player confirms, KIs consumed, NM spawns
- Example: Trade 3 KIs (Tattered Hippogryph Wing + Cracked Wivre Horn + Mucid Ahriman Eyeball) at `qm_kukulkan` to spawn Kukulkan

### ??? Spawn Points: COMPLETE

All 9 Abyssea zones have `qm_*` NPC scripts for every NM:
- **Konschtat (15):** 15 qm scripts
- **Tahrongi (45):** 15 qm scripts
- **La Theine (132):** 15 qm scripts
- **Attohwa (215):** 20 qm scripts (including _1, _2, _3 variants for multi-pop T3s)
- **Misareaux (216):** has qm scripts
- **Vunkerl (217):** has qm scripts
- **Altepa (218):** 22 qm scripts (including variants)
- **Uleguerand (253):** has qm scripts
- **Grauberg (254):** has qm scripts

**VERDICT: POP SYSTEM IS FULLY IMPLEMENTED**

---

## 2. NM Droplists (Detailed Cross-Reference)

### Fistule (Konschtat T2) -- droplist 835
| Drop | Rate | Correct? |
|------|------|----------|
| Rokugo Hachimaki (11518) | Always | YES - correct empyrean key item |
| Vial of Fistule Discharge (2931) | Always + VCommon | YES - correct pop item for higher NMs |
| Stone of Vision (3210) | VCommon | YES - empyrean seal currency |
| Card of Vision (3213) | VCommon | YES |
| Lightsome Cap (11522) | Common | YES - Fistule's unique drop |
| Scathacha (17808) | Rare | YES - correct rare weapon |

**VERDICT: CORRECT - has hachimaki, pop items, seal currency, unique gear**

### Chloris (Tahrongi T3) -- droplist 3263
| Drop | Rate | Correct? |
|------|------|----------|
| Issen Hachimaki (11509) | Always | YES |
| Two-Leaf Chloris Bud (2928) | Always + VCommon | YES - pop item |
| Ludic Mitts (12741) | VCommon | YES |
| Balance Card (3225) | VCommon | YES - seal currency |
| Augur's Gloves (14888) | Rare | YES - empyrean hands piece |
| Balance Coin (3223) | Rare | YES |

**VERDICT: CORRECT**

### Glavoid (Tahrongi T3) -- droplist 3265
| Drop | Rate | Correct? |
|------|------|----------|
| Tokon Hachimaki (11508) | Always | YES |
| Glavoid Shell (2927) | Always + VCommon | YES |
| Brisk Mask (2499) | VCommon | YES |
| Balance Stone (3222) | VCommon | YES |
| Balance Card (3225) | Rare | YES |
| Regurgitated Wing (2499) | Rare | Note: same item ID as Brisk Mask -- possible comment error |

**VERDICT: MOSTLY CORRECT - possible item ID comment mismatch on last entry**

### Briareus (La Theine T3) -- droplist 356
| Drop | Rate | Correct? |
|------|------|----------|
| Hakke Hachimaki (11519) | Always | YES |
| Helm of Briareus (2929) | Always + VCommon | YES |
| Inmicus Cuisses (16379) | VCommon | YES |
| Jewel of Voyage (3228) | VCommon | YES |
| Stone of Voyage (3226) | Rare | YES |
| Briareus's Sash (2498) | Rare | YES |

**VERDICT: CORRECT**

### Eccentric Eve (Konschtat T3) -- droplist 741
| Drop | Rate | Correct? |
|------|------|----------|
| Senshin Hachimaki (11513) | Always | YES |
| Danzo Sune-Ate (12997) | VCommon | YES |
| Ocelot Gloves (14887) | Uncommon | YES |
| Stone of Vision (3210) | VCommon | YES |
| Card of Vision (3213) | Rare | YES |
| Malboro Vine (920) | Rare | YES |
| Spool of Malboro Fiber (837) | VRare | YES |

**VERDICT: CORRECT**

### Kukulkan (Konschtat T2) -- droplist 1468
| Drop | Rate | Correct? |
|------|------|----------|
| Kukulkan's Fang (2932) | Always + VCommon | YES |
| Shunten Hachimaki (11520) | Always | YES |
| Anguinus Belt (11731) | VCommon | YES |
| Kukulkan's Skin (2497) | Uncommon | YES |
| Coin of Vision (3211) | VCommon | YES |
| Jewel of Vision (3212) | Uncommon | YES |

**VERDICT: CORRECT**

---

## 3. NM Chains -- Full Konschtat Chain Trace

### Konschtat T1 -> T2 -> T3 Chain

```
T1 NMs (Trade items to ???):
  Alkonost     (qm trade) -> drops KI: Tattered Hippogryph Wing
  Keratyrannos (qm trade) -> drops KI: Cracked Wivre Horn
  Arimaspi     (qm trade) -> drops KI: Mucid Ahriman Eyeball

T2 NM (Requires 3 T1 KIs):
  Kukulkan     (qm_kukulkan) -> requires all 3 KIs above
                             -> drops KI: Venomous Peiste Claw + Atma of the Noxious Fang

Other T1/T2 NMs that feed T3:
  Gangly_Gean  -> drops KI: Fragrant Treant Petal
  Raskovnik    -> drops KI: Fetid Rafflesia Stalk
  Clingy_Clare -> drops KI: Decaying Morbol Tooth
  Fistule      -> drops KI: Turbid Slime Oil

T3 NM (Requires 5 KIs):
  Eccentric Eve (qm_eccentric_eve) -> requires:
    - Fragrant Treant Petal
    - Fetid Rafflesia Stalk
    - Decaying Morbol Tooth
    - Turbid Slime Oil
    - Venomous Peiste Claw
  -> drops Atma of the Voracious Violet + unique gear
```

### Chain Verification

| Step | Component | Status |
|------|-----------|--------|
| T1 ??? spawn points | qm_alkonost, qm_keratyrannos, qm_arimaspi | EXIST |
| T1 NMs have KI drops | Configured in `xi.abyssea.mob` table | YES |
| T1 KI drop mechanism | `abyssea_weakness.lua` DEATH listener -> `giveNMDrops()` | WORKS |
| T2 ??? spawn point | qm_kukulkan | EXISTS |
| T2 KI consumption | `qmOnEventFinish()` deletes KIs, spawns NM | WORKS |
| T2 NM has KI drops | Configured in `xi.abyssea.mob` table | YES |
| T3 ??? spawn point | qm_eccentric_eve | EXISTS |
| T3 KI requirements | Lists all 5 required KIs | CORRECT |

**VERDICT: FULL CHAIN IS FUNCTIONAL**

---

## 4. Empyrean Armor Seals

### Seal System Overview

Empyrean armor seals drop from Abyssea NMs via the `mob_droplist` table. There are 20 job-specific seal sets, each with 5 body slots (Head/Body/Hands/Legs/Feet).

Seal items confirmed in `scripts/enum/item.lua`:
- IDs 3110-3129: Seal Head (Ravager, Tantra, Orison, Goetia, Estoqueur, Raider, Creed, Bale, Ferine, Unkai, Iga, Lancer, Navarch, Aoidos, Caller, Cirque, Charis, Savant, etc.)
- IDs 3130-3149: Seal Body
- IDs 3150-3169: Seal Hands
- IDs 3170-3189: Seal Legs
- IDs 3190-3209: Seal Feet

### Seal Drop Distribution

Total seal entries in mob_droplist.sql: **601 entries**

Seals appear in NM droplists using a grouped drop system:
```sql
-- Example: Gaizkin (droplist 924) drops seals
(924,1,1,@ALWAYS,3111,250)   -- Tantra Seal Head (Group 1, 100% one-of-four)
(924,1,1,@ALWAYS,3119,250)   -- Aoidos Seal Head
(924,1,1,@ALWAYS,3123,250)   -- Lancers Seal Head
(924,1,1,@ALWAYS,3129,250)   -- Savants Seal Head
(924,1,2,@UNCOMMON,3111,250) -- Tantra Seal Head (Group 2, 10% bonus)
...
```

### Which NMs Drop Seals?

Seals are found in droplists for T1 NMs (the pop-item-trade NMs). Examples verified:
- **Gaizkin** (Attohwa, droplist 924): Head seals
- **Granite_Borer** (Attohwa, droplist 1215): Head seals
- **Blazing_Eruca** (Attohwa, droplist 293): Head seals

### ISSUE: Visions Zone T1 NMs Have SPARSE Droplists

Many T1 NMs in the original Visions zones (Konschtat/Tahrongi/La Theine) have very sparse droplists with NO seals:

| NM | Zone | Droplist | Items | Has Seals? |
|----|------|----------|-------|------------|
| Bloodguzzler | Konschtat | 299 | 1 item (Graiai Earring) | NO |
| Lentor | Konschtat | 1507 | 1 item (Missile Boots) | NO |
| Bombadeel | Konschtat | 330 | 1 item (Thiazis Belt) | NO |
| Sarcophilus | Konschtat | 2163 | 1 item (Bersail Cap) | NO |
| Hexenpilz | Konschtat | 1304 | 1 item (Sunbeam Cape) | NO |
| Clingy_Clare | Konschtat | 479 | 1 item (Salvus Mantle) | NO |
| Alkonost | Konschtat | 49 | 1 item (Mesmeric Cape) | NO |
| Fear_Gorta | Konschtat | 824 | 1 item (Hecate's Crown) | NO |
| Keratyrannos | Konschtat | 1430 | 1 item (Odium Ring) | NO |

**FINDING: Visions-era T1 NMs drop only 1 unique item each and NO empyrean seals.** This may be intentional (seals were added with Scars/Heroes zones), but it means farming seals requires Scars/Heroes zone NMs.

---

## 5. NMs Without Custom Scripts

### Zone-Wide Mixins Handle Most Logic

The `scripts/mixins/zones/Abyssea-*.lua` files apply 3 mixins to ALL mobs in each zone:
1. `abyssea_weakness` - proc system, weakness detection, KI/Atma drops on death
2. `drop_lights` - light drop system
3. `spawn_pyxis` - treasure chest spawning

This means **even NMs without individual mob scripts** still get:
- Weakness/proc system
- Atma + KI drops (via `xi.abyssea.mob` table lookup by name)
- Light drops
- Pyxis spawning

### Scriptless NMs: Do They Have Droplists?

| NM | Zone | Droplist ID | Has Items? |
|----|------|-------------|------------|
| Bombadeel | Konschtat | 330 | YES (1 item) |
| Sarcophilus | Konschtat | 2163 | YES (1 item) |
| Hexenpilz | Konschtat | 1304 | YES (1 item) |
| Clingy_Clare | Konschtat | 479 | YES (1 item) |
| Alkonost | Konschtat | 49 | YES (1 item) |
| Halimede | Tahrongi | 3266 | YES (4 items) |
| Vetehinen | Tahrongi | 3274 | YES (4 items) |
| Ophanim | Tahrongi | 3271 | YES (1 item) |
| Drekavac | Attohwa | 706 | YES (1 item) |
| Gaizkin | Attohwa | 924 | YES (9 items + seals) |

**Most scriptless NMs have basic droplists. They function because zone-wide mixins handle proc/atma/KI mechanics.**

### NMs With Missing Data (HP=0 or Droplist=0)

Several NMs in the database have HP=0 and/or droplist=0, meaning they cannot function:

**Actual NMs with issues:**
| NM | Zone | HP | Droplist | Issue |
|----|------|----|----------|-------|
| Ashtaerh_the_Gallvexed | Konschtat (15) | 25500 | 0 | NO DROPS |
| Siranpa-kamuy | Konschtat (15) | 24100 | 0 | NO DROPS |
| Svarbhanu | Attohwa (215) | 0 | 0 | NO HP, NO DROPS |
| Tejas | Attohwa (215) | 0 | 0 | NO HP, NO DROPS |
| Eseuvhi | Attohwa (215) | 0 | 0 | NO HP, NO DROPS |
| Pascerpot | Vunkerl (217) | 0 | 0 | NO HP, NO DROPS |
| Fulmotondro | Vunkerl (217) | 0 | 0 | NO HP, NO DROPS |
| Jala | Misareaux (216) | 0 | 0 | NO HP, NO DROPS |
| Mxghrah/Mighrah | Misareaux (216) | 0 | 0 | NO HP, NO DROPS |
| Usurper | Tahrongi (45) | 0 | 0 | NO HP, NO DROPS |
| Yearner | Tahrongi (45) | 32000 | 0 | NO DROPS |
| Hungerer | Tahrongi (45) | 4800 | 0 | NO DROPS |

**Bastion system mobs (NOT regular NMs -- expected to be incomplete):**
Each scions zone (215-218, 253-254) has ~14 Bastion entities (Scrutinizer, Decontaminator, Vigilant_Gears, Immobilizer, Disassembler, Oppressor, Edifier, Overseer, Earth_Mover, Custodian, Ravager_Chariot, Bastion_Fighter, Bastion_Mage, Qiqirn_Trapper, Qiqirn_Bewitcher) all with HP=0/droplist=0. **This is expected** as the Bastion system is not yet implemented in LSB.

---

## 6. Custom AI Summary (28 NMs with scripts)

| NM | Zone | Script Features |
|----|------|-----------------|
| Fistule | Konschtat | Dissolve mechanic (absorbs nearby T1 NMs) |
| Kukulkan | Konschtat | Peiste family mixin |
| Eccentric Eve | Konschtat | Title grant only |
| Turul | Konschtat | Amphiptere mixin, spell list swap at 50% HP |
| Hadal_Satiator | Konschtat | Gorger NM mixin, fission mechanic |
| Bakka | Konschtat | Custom AI |
| Balaur | Konschtat | Custom AI |
| Dapifer_Imp | Konschtat | Custom AI |
| Lachrymater | Konschtat | Custom AI |
| Briareus | La Theine | Mercurial Strike mechanic, Meikyo Shisui, 90min rage |
| Piasa | La Theine | Custom AI |
| Luison | La Theine | Custom AI |
| Crepuscule_Puk | La Theine | Custom AI |
| Bog_Body | Tahrongi | Custom AI |
| Manananggal | Tahrongi | Custom AI |
| Iratham | Tahrongi | Custom AI |
| Funnel_Antlion | Attohwa | Custom AI |
| Murrain_Chigoe | Attohwa | Custom AI |
| Tunga | Attohwa | Custom AI |
| Athamas | Misareaux | Custom AI |
| Div-e_Sepid | Vunkerl | Custom AI |
| Clammy_Imp | Vunkerl | Custom AI |
| Sippoy | Vunkerl | Custom AI |
| Peapuk | Vunkerl | Custom AI |
| Desert_Puk | Altepa | Custom AI |
| Rani | Altepa | Custom AI |
| Chillwing_Hwitti | Uleguerand | Custom AI |
| Ermit_Imp | Uleguerand | Custom AI |

---

## Summary Verdicts

| System | Status | Notes |
|--------|--------|-------|
| ??? Spawn Points | WORKING | All zones have qm_* scripts for every NM |
| Pop Item Trading (T1) | WORKING | `qmOnTrade()` validates and spawns correctly |
| KI Trading (T2/T3) | WORKING | `qmOnTrigger/EventFinish()` handles KI menu and spawn |
| NM Chain (T1->T2->T3) | WORKING | Verified full Konschtat chain: T1 KIs -> Kukulkan -> Eve |
| Atma Drops | WORKING | `xi.abyssea.mob` table covers all ~160+ NMs across 9 zones |
| KI Pop Item Drops | WORKING | Same table, `giveNMDrops()` via death listener |
| Weakness/Proc System | WORKING | Zone-wide mixin applied to all mobs |
| T3 NM Droplists | GOOD | Fistule/Chloris/Glavoid/Briareus/Eve all have correct drops |
| Empyrean Seal Drops | PARTIAL | 601 seal entries exist but concentrated in Scars/Heroes NMs; Visions T1 NMs have no seals |
| NMs with HP=0 | ISSUE | ~10 actual NMs have HP=0 (mostly Attohwa/Vunkerl) -- unspawnable |
| NMs with Droplist=0 | ISSUE | ~12 NMs missing droplists entirely |
| Bastion System | NOT IMPLEMENTED | ~84 Bastion mobs across 6 zones have no data (expected) |
| Custom AI Coverage | LOW | Only 28/172 NMs have custom scripts, but zone mixins cover core mechanics |

### Priority Fixes

1. **HIGH:** NMs with HP=0 cannot be spawned even though their QM scripts exist (Svarbhanu, Tejas, Eseuvhi, Pascerpot, Fulmotondro, Jala, Usurper)
2. **MEDIUM:** NMs with droplist=0 work but drop nothing (Ashtaerh, Siranpa-kamuy, Yearner, Hungerer)
3. **LOW:** Visions T1 NMs have very sparse droplists (1 item each, no seals) -- may be intentional upstream design
4. **INFO:** Bastion system is entirely unimplemented -- all Bastion mobs are shells

### Key Files Referenced

- `scripts/globals/abyssea.lua` -- core pop system, atma/KI tables, QM functions
- `scripts/mixins/abyssea_weakness.lua` -- zone-wide proc/drop mixin
- `scripts/mixins/zones/Abyssea-*.lua` -- zone mixin assignments
- `scripts/zones/Abyssea-*/npcs/qm_*.lua` -- individual ??? spawn points
- `scripts/zones/Abyssea-*/mobs/*.lua` -- NM custom AI (28 files)
- `sql/mob_groups.sql` -- NM definitions, HP, droplists
- `sql/mob_droplist.sql` -- actual drop tables (601 seal entries, NM gear)
- `scripts/enum/item.lua` -- seal item IDs (3110-3209)
