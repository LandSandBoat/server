# Sparks Vendor Gear Deep Verification (iLvl 117)

**Date:** 2026-03-29
**Scope:** All Eminent weapons, Outrider/Espial/Weatherspoon armor sets
**Method:** Value-by-value comparison of item_mods.sql / item_latents.sql against bg-wiki retail data
**Status:** CRITICAL issues found

---

## SUMMARY OF FINDINGS

| Category | Items Checked | Issues Found | Severity |
|----------|:---:|:---:|----------|
| Eminent Weapons (latents) | 14 melee/ranged | 12 missing latents, 1 wrong values | CRITICAL |
| Eminent Weapons (base mods) | 14 melee/ranged | 4 missing base mods | HIGH |
| Eminent Support Weapons | 5 (sachet/flute/animator/bell/animator II) | 1 missing base mod | MEDIUM |
| Eminent Shield | 1 | 1 wrong DEF value | HIGH |
| Outrider Armor (5pc) | 5 | 1 wrong value | LOW |
| Espial Armor (5pc) | 5 | 1 missing mod | LOW |
| Weatherspoon Armor (5pc) | 5 | 2 wrong mods | MEDIUM |
| **TOTAL** | **35** | **~22 discrepancies** | |

---

## CRITICAL: EMINENT WEAPON LATENT EFFECTS (TP < 1000)

All Eminent weapons should have latent effects (latentId=6, TP_UNDER, param=1000) that activate when TP < 1000 and persist during weapon skills. This is the primary stat boost for these weapons.

### Weapons WITH latents (3 of 14) - PARTIAL

| Item ID | Weapon | Latent Mods in Server | Status |
|---------|--------|----------------------|--------|
| 20540 | Em. Baghnakhs | ATT+10, ACC+15, DMG_RATING+4 | OK |
| 20624 | Em. Dagger | ATT+10, ACC+39, DMG_RATING+89 | **BUG** |
| 20726 | Em. Scimitar | ATT+10, ACC+15, DMG_RATING+6 | OK |

#### Eminent Dagger Latent Bug (ID 20624)
- **DMG_RATING (287):** Server has +89, should be +4 (base 85 + 4 = 89 total)
- **ACC (25):** Server has +39, should be +15 (base 24 + 15 = 39 total)
- The server is using the TOTAL values as additions instead of the DELTA
- Result: Dagger gets DMG 174 instead of 89, and ACC 63 instead of 39 during latent
- **File:** `sql/item_latents.sql` lines 3236-3238

### Weapons COMPLETELY MISSING latents (11 of 14)

| Item ID | Weapon | Expected Latent (bg-wiki) |
|---------|--------|--------------------------|
| 20766 | Em. Sword | DMG:209 (+10), ACC+15, ATT+10 |
| 20817 | Em. Axe | DMG:141 (+7), ACC+15, ATT+10 |
| 20865 | Em. Voulge | DMG:246 (+12), ACC+15, ATT+10 |
| 20908 | Em. Sickle | DMG:244 (+12), ACC+15, ATT+10 |
| 20954 | Em. Lance | DMG:239 (+12), ACC+15, ATT+10 |
| 21119 | Em. Wand | DMG:141 (+7), ACC+15, ATT+10 |
| 21182 | Em. Staff | MACC+10, Magic Damage+185 (see note) |
| 21183 | Em. Pole | Avatar: MATT+114, Avatar: MACC+10 (see note) |
| 21231 | Em. Bow | DMG:277 (+14) |
| 21251 | Em. Crossbow | DMG:93 (+5), RACC+15, RATT+10 |
| 21281 | Em. Gun | DMG:102 (+5) |

**Note on Em. Staff latent:** bg-wiki lists "Magic Accuracy+10 Magic Damage+185". Base has Magic Damage+176. The latent addition should be MACC(30)+10, MAGIC_DAMAGE(311)+9 (if 185 is total) or +185 (if additive). Needs retail testing to confirm.

**Note on Em. Pole latent:** bg-wiki lists "Avatar: Magic Accuracy+10, Magic Atk. Bonus+114". Uses PET_MACC_MEVA(993) and PET_MAB_MDB(992). Base has Avatar MATT+108 (also missing, see below).

**Note on Em. Bow:** bg-wiki only mentions DMG:277 for latent (no RACC/RATT in latent, but has RACC+15 / RATT+10 as base stats that are also missing from mods).

**Note on Em. Gun:** bg-wiki only mentions DMG:102 for latent. Base stats RACC+15 / RATT+10 also missing from mods.

---

## HIGH: MISSING BASE MODS ON WEAPONS

### Eminent Lance (20954) - NO MODS AT ALL
- bg-wiki: No base stat mods listed beyond skills (latent provides all combat stats)
- Server: No mods. Correct for base, but latent is completely missing.

### Eminent Bow (21231) - MISSING BASE MODS
- bg-wiki base stats: Ranged Accuracy+15, Ranged Attack+10
- Server: NO mods at all
- **Missing:** RACC(26)+15, RATT(24)+10

### Eminent Crossbow (21251) - MISSING BASE MODS
- bg-wiki base stats: (none beyond skills per main listing)
- Server: NO mods at all
- Need to verify if base RACC/RATT are listed (crossbow page showed them in latent only)

### Eminent Gun (21281) - MISSING BASE MODS
- bg-wiki base stats: Ranged Accuracy+15, Ranged Attack+10
- Server: NO mods at all
- **Missing:** RACC(26)+15, RATT(24)+10

### Eminent Pole (21183) - MISSING AVATAR MATT
- bg-wiki: Avatar: "Magic Atk. Bonus"+108
- Server: Only has MP+85
- **Missing:** PET_MAB_MDB(992)+108

---

## HIGH: EMINENT SHIELD (28656) - WRONG DEF

| Stat | Server | bg-wiki | Status |
|------|:------:|:-------:|--------|
| DEF (1) | 50 | 95 | **WRONG** |
| HP (2) | 40 | 40 | OK |
| MP (5) | 40 | 40 | OK |
| Enmity (27) | 5 | 5 | OK |
| Shield Skill (109) | 100 | 100 | OK |
| Damage Taken (160) | -300 (-3%) | -3% | OK |

**DEF is 50 instead of 95.** This is a 45-point deficit - nearly half the intended value.

---

## MEDIUM: WEATHERSPOON ROBE (27909) - WRONG MOD TYPE

| Stat | Server | bg-wiki | Status |
|------|:------:|:-------:|--------|
| DEF (1) | 78 | 78 | OK |
| HP (2) | 17 | 17 | OK |
| MP (5) | 46 | 46 | OK |
| STR (8) | 16 | 16 | OK |
| DEX (9) | 16 | 16 | OK |
| VIT (10) | 16 | 16 | OK |
| AGI (11) | 16 | 16 | OK |
| INT (12) | 20 | 20 | OK |
| MND (13) | 20 | 20 | OK |
| CHR (14) | 20 | 20 | OK |
| **MATT (28)** | **10** | **--** | **WRONG MOD** |
| MDEF (29) | 2 | 2 | OK |
| MEVA (31) | 47 | 47 | OK |
| EVA (68) | 12 | 12 | OK |
| HASTE (384) | 200 (2%) | 2% | OK |
| **MAGIC_DAMAGE (311)** | **missing** | **10** | **MISSING** |

**Server has MATT+10 (mod 28). bg-wiki says Magic Damage+10 (mod 311).** This is the wrong mod entirely. MATT boosts spell damage multiplicatively; Magic Damage adds flat damage to spells. Different mechanics.

---

## LOW-MEDIUM: WEATHERSPOON PANTS (28190) - WRONG EVA

| Stat | Server | bg-wiki | Status |
|------|:------:|:-------:|--------|
| DEF (1) | 67 | 67 | OK |
| HP (2) | 23 | 23 | OK |
| MP (5) | 33 | 33 | OK |
| STR (8) | 13 | 13 | OK |
| VIT (10) | 6 | 6 | OK |
| AGI (11) | 9 | 9 | OK |
| INT (12) | 18 | 18 | OK |
| MND (13) | 12 | 12 | OK |
| CHR (14) | 10 | 10 | OK |
| Enmity (27) | -5 | -5 | OK |
| MDEF (29) | 2 | 2 | OK |
| MEVA (31) | 62 | 62 | OK |
| **EVA (68)** | **9** | **8** | **WRONG (+1)** |
| HASTE (384) | 300 (3%) | 3% | OK |

---

## LOW: OUTRIDER HOSE (28168) - WRONG ATT

| Stat | Server | bg-wiki | Status |
|------|:------:|:-------:|--------|
| DEF (1) | 116 | 116 | OK |
| HP (2) | 44 | 44 | OK |
| STR (8) | 31 | 31 | OK |
| VIT (10) | 19 | 19 | OK |
| AGI (11) | 14 | 14 | OK |
| INT (12) | 25 | 25 | OK |
| MND (13) | 15 | 15 | OK |
| CHR (14) | 12 | 12 | OK |
| **ATT (23)** | **4** | **5** | **WRONG (-1)** |
| MDEF (29) | 2 | 2 | OK |
| MEVA (31) | 70 | 70 | OK |
| EVA (68) | 19 | 19 | OK |
| HASTE (384) | 500 (5%) | 5% | OK |

---

## LOW: ESPIAL HOSE (28169) - MISSING CHR

| Stat | Server | bg-wiki | Status |
|------|:------:|:-------:|--------|
| DEF (1) | 105 | 105 | OK |
| HP (2) | 42 | 42 | OK |
| MP (5) | 14 | 14 | OK |
| STR (8) | 27 | 27 | OK |
| VIT (10) | 14 | 14 | OK |
| AGI (11) | 21 | 21 | OK |
| INT (12) | 28 | 28 | OK |
| MND (13) | 16 | 16 | OK |
| **CHR (14)** | **missing** | **10** | **MISSING** |
| ACC (25) | 5 | 5 | OK |
| MDEF (29) | 5 | 5 | OK |
| MEVA (31) | 90 | 90 | OK |
| EVA (68) | 39 | 39 | OK |
| HASTE (384) | 500 (5%) | 5% | OK |

---

## VERIFIED CORRECT (Full Sets)

### Outrider Mask (27740) - ALL OK
DEF:105, HP+34, MP+22, STR+24, DEX+20, VIT+22, AGI+20, INT+19, MND+19, CHR+19, ATT+5, MDEF+2, MEVA+40, EVA+29, Haste+7% -- all match bg-wiki.

### Espial Cap (27741) - ALL OK
DEF:94, HP+32, MP+17, STR+20, DEX+22, VIT+20, AGI+22, INT+20, MND+20, CHR+20, ACC+5, MDEF+3, MEVA+40, EVA+37, Haste+7% -- all match bg-wiki.

### Weatherspoon Corona (27763) - ALL OK
DEF:60, HP+21, MP+35, INT+17, MND+17, CHR+17, MDEF+1, MACC+10, MEVA+43, EVA+10, Haste+5% -- all match bg-wiki.

### Outrider Mail (27881) - ALL OK
DEF:133, HP+55, MP+42, STR+26, DEX+20, VIT+25, AGI+20, INT+20, MND+20, CHR+20, ATT+6, MDEF+3, MEVA+50, EVA+37, Haste+3% -- all match bg-wiki.

### Espial Gambison (27882) - ALL OK
DEF:122, HP+53, MP+28, STR+22, DEX+27, VIT+21, AGI+27, INT+22, MND+22, CHR+22, ACC+6, MDEF+5, MEVA+60, EVA+49, Haste+3% -- all match bg-wiki.

### Weatherspoon Cuffs (28048) - ALL OK
DEF:52, HP+22, MP+26, STR+3, DEX+14, VIT+13, AGI+2, INT+10, MND+17, CHR+10, MDEF+1, MEVA+21, EVA+6, Cure Potency+8%, Haste+3% -- all match bg-wiki.

### Outrider Mittens (28029) - ALL OK
DEF:94, HP+24, STR+6, DEX+28, VIT+29, AGI+7, INT+9, MND+25, CHR+19, ATT+4, MDEF+1, MEVA+25, EVA+19, Haste+4% -- all match bg-wiki.

### Espial Bracers (28030) - ALL OK
DEF:82, HP+22, MP+8, STR+7, DEX+33, VIT+25, AGI+8, INT+10, MND+28, CHR+16, ACC+4, MDEF+2, MEVA+25, EVA+24, Haste+4% -- all match bg-wiki.

### Outrider Greaves (28306) - ALL OK
DEF:77, HP+14, STR+14, DEX+17, VIT+14, AGI+30, MND+9, CHR+25, ATT+4, MDEF+2, MEVA+70, EVA+46, Haste+3% -- all match bg-wiki.

### Espial Socks (28307) - ALL OK
DEF:65, HP+12, MP+8, STR+10, DEX+20, VIT+10, AGI+33, MND+10, CHR+26, ACC+4, MDEF+3, MEVA+90, EVA+69, Haste+3% -- all match bg-wiki.

### Weatherspoon Souliers (28329) - ALL OK
DEF:41, HP+20, MP+27, STR+5, DEX+6, VIT+5, AGI+17, INT+9, MND+10, CHR+18, MATT+10, MDEF+1, MEVA+62, EVA+16, Haste+3% -- all match bg-wiki.

### Eminent Baghnakhs (20540) - Base mods OK, Latent OK
Base: ATT+10, ACC+24, EVA+12. Latent: ATT+10, ACC+15, DMG+4. All correct.

### Eminent Scimitar (20726) - Base mods OK, Latent OK
Base: ATT+10, ACC+15. Latent: ATT+10, ACC+15, DMG+6. All correct.

### Eminent Wand (21119) - Base mods OK (latent missing, see above)
INT+6, MND+6, ATT+10, ACC+15, MATT+14, Magic Damage+111 -- base mods match bg-wiki.

### Eminent Staff (21182) - Base mods OK (latent missing, see above)
INT+12, MND+12, MATT+25, Magic Damage+176 -- base mods match bg-wiki.

### Eminent Sachet (21383) - ALL OK
BP Delay II -3, Avatar Lv. Bonus +16 (=Lv.115). Matches bg-wiki.

### Eminent Flute (21405) - ALL OK
All Songs +2. Matches bg-wiki.

### Eminent Animator (21453) - ALL OK
Automaton Lv. Bonus +16 (=Lv.115). Matches bg-wiki.

### Eminent Bell (21462) - ALL OK
Geomancy +3. Matches bg-wiki.

### Eminent Animator II (22260) - ALL OK
Automaton Lv. Bonus +16 (=Lv.115). Matches bg-wiki.

---

## FIX PRIORITY

### P0 - CRITICAL (11 weapons missing latents)
These weapons are ~5-10% weaker than intended without their TP<1000 latent bonuses. Every melee/ranged Eminent weapon should have latents.

**Files to fix:** `sql/item_latents.sql`

Required latent entries (latentId=6, latentParam=1000):
```sql
-- Eminent Sword (20766)
INSERT INTO `item_latents` VALUES (20766,23,10,6,1000);  -- ATT+10 TP<1000
INSERT INTO `item_latents` VALUES (20766,25,15,6,1000);  -- ACC+15 TP<1000
INSERT INTO `item_latents` VALUES (20766,287,10,6,1000); -- DMG+10 TP<1000 (199+10=209)

-- Eminent Axe (20817)
INSERT INTO `item_latents` VALUES (20817,23,10,6,1000);  -- ATT+10 TP<1000
INSERT INTO `item_latents` VALUES (20817,25,15,6,1000);  -- ACC+15 TP<1000
INSERT INTO `item_latents` VALUES (20817,287,7,6,1000);  -- DMG+7 TP<1000 (134+7=141)

-- Eminent Voulge (20865)
INSERT INTO `item_latents` VALUES (20865,23,10,6,1000);  -- ATT+10 TP<1000
INSERT INTO `item_latents` VALUES (20865,25,15,6,1000);  -- ACC+15 TP<1000
INSERT INTO `item_latents` VALUES (20865,287,12,6,1000); -- DMG+12 TP<1000 (234+12=246)

-- Eminent Sickle (20908)
INSERT INTO `item_latents` VALUES (20908,23,10,6,1000);  -- ATT+10 TP<1000
INSERT INTO `item_latents` VALUES (20908,25,15,6,1000);  -- ACC+15 TP<1000
INSERT INTO `item_latents` VALUES (20908,287,12,6,1000); -- DMG+12 TP<1000 (232+12=244)

-- Eminent Lance (20954)
INSERT INTO `item_latents` VALUES (20954,23,10,6,1000);  -- ATT+10 TP<1000
INSERT INTO `item_latents` VALUES (20954,25,15,6,1000);  -- ACC+15 TP<1000
INSERT INTO `item_latents` VALUES (20954,287,12,6,1000); -- DMG+12 TP<1000 (227+12=239)

-- Eminent Wand (21119)
INSERT INTO `item_latents` VALUES (21119,23,10,6,1000);  -- ATT+10 TP<1000
INSERT INTO `item_latents` VALUES (21119,25,15,6,1000);  -- ACC+15 TP<1000
INSERT INTO `item_latents` VALUES (21119,287,7,6,1000);  -- DMG+7 TP<1000 (134+7=141)

-- Eminent Staff (21182) - uses MACC and MAGIC_DAMAGE, not ACC/ATT/DMG
INSERT INTO `item_latents` VALUES (21182,30,10,6,1000);  -- MACC+10 TP<1000
INSERT INTO `item_latents` VALUES (21182,311,9,6,1000);  -- MAGIC_DAMAGE+9 TP<1000 (176+9=185)
-- NOTE: If bg-wiki means +185 additional (not total), use 185 instead of 9. Needs retail verify.

-- Eminent Pole (21183) - Avatar stats
INSERT INTO `item_latents` VALUES (21183,993,10,6,1000); -- PET_MACC_MEVA+10 TP<1000
INSERT INTO `item_latents` VALUES (21183,992,6,6,1000);  -- PET_MAB_MDB+6 TP<1000 (108+6=114)
-- NOTE: If bg-wiki means +114 additional (not total), use 114 instead of 6. Needs retail verify.

-- Eminent Bow (21231) - ranged weapon, uses RANGED_DMG_RATING
INSERT INTO `item_latents` VALUES (21231,376,14,6,1000); -- RANGED_DMG_RATING+14 TP<1000 (263+14=277)

-- Eminent Crossbow (21251)
INSERT INTO `item_latents` VALUES (21251,26,15,6,1000);  -- RACC+15 TP<1000
INSERT INTO `item_latents` VALUES (21251,24,10,6,1000);  -- RATT+10 TP<1000
INSERT INTO `item_latents` VALUES (21251,376,5,6,1000);  -- RANGED_DMG_RATING+5 TP<1000 (88+5=93)

-- Eminent Gun (21281)
INSERT INTO `item_latents` VALUES (21281,376,5,6,1000);  -- RANGED_DMG_RATING+5 TP<1000 (97+5=102)
```

### P0 - CRITICAL (Dagger latent values wrong)
**File:** `sql/item_latents.sql` lines 3236-3238

Fix Eminent Dagger (20624):
```sql
-- CURRENT (WRONG - using totals as additions):
INSERT INTO `item_latents` VALUES (20624,23,10,6,1000);  -- ATT+10 (OK)
INSERT INTO `item_latents` VALUES (20624,25,39,6,1000);  -- ACC: should be 15, not 39
INSERT INTO `item_latents` VALUES (20624,287,89,6,1000); -- DMG: should be 4, not 89

-- FIXED:
INSERT INTO `item_latents` VALUES (20624,25,15,6,1000);  -- ACC+15 TP<1000 (24+15=39)
INSERT INTO `item_latents` VALUES (20624,287,4,6,1000);  -- DMG+4 TP<1000 (85+4=89)
```

### P1 - HIGH (Shield DEF)
**File:** `sql/item_mods.sql`

Eminent Shield (28656): Change DEF from 50 to 95.
```sql
-- CURRENT: INSERT INTO `item_mods` VALUES (28656,1,50);
-- FIXED:   INSERT INTO `item_mods` VALUES (28656,1,95);
```

### P1 - HIGH (Missing base mods on ranged weapons)
**File:** `sql/item_mods.sql`

```sql
-- Eminent Bow (21231) - missing base RACC and RATT
INSERT INTO `item_mods` VALUES (21231,26,15); -- RACC: 15
INSERT INTO `item_mods` VALUES (21231,24,10); -- RATT: 10

-- Eminent Gun (21281) - missing base RACC and RATT
INSERT INTO `item_mods` VALUES (21281,26,15); -- RACC: 15
INSERT INTO `item_mods` VALUES (21281,24,10); -- RATT: 10
```

### P1 - HIGH (Missing Eminent Pole base Avatar MATT)
**File:** `sql/item_mods.sql`

```sql
-- Eminent Pole (21183) - missing Avatar MATT+108
INSERT INTO `item_mods` VALUES (21183,992,108); -- PET_MAB_MDB: 108
```

### P2 - MEDIUM (Weatherspoon Robe wrong mod type)
**File:** `sql/item_mods.sql`

```sql
-- CURRENT (WRONG): INSERT INTO `item_mods` VALUES (27909,28,10); -- MATT: 10
-- FIXED:           INSERT INTO `item_mods` VALUES (27909,311,10); -- MAGIC_DAMAGE: 10
```

### P3 - LOW (Minor value errors)
**File:** `sql/item_mods.sql`

```sql
-- Outrider Hose (28168): ATT 4 -> 5
-- CURRENT: INSERT INTO `item_mods` VALUES (28168,23,4);
-- FIXED:   INSERT INTO `item_mods` VALUES (28168,23,5);

-- Espial Hose (28169): Add missing CHR+10
INSERT INTO `item_mods` VALUES (28169,14,10); -- CHR: 10

-- Weatherspoon Pants (28190): EVA 9 -> 8
-- CURRENT: INSERT INTO `item_mods` VALUES (28190,68,9);
-- FIXED:   INSERT INTO `item_mods` VALUES (28190,68,8);
```

---

## OPEN QUESTIONS

1. **Eminent Staff latent Magic Damage:** Is bg-wiki's "Magic Damage+185" the total (latent adds 9) or additional (latent adds 185)? The DMG pattern on melee weapons uses total values, but Magic Damage as a stat mod might work differently. Needs retail testing.

2. **Eminent Pole latent Avatar MATT:** Same question - is "+114" the total (adds 6 to base 108) or additional (adds 114)? The base has 108 and the latent shows 114.

3. **Eminent Bow/Gun base mods:** bg-wiki lists RACC+15 / RATT+10 on the main stat block (not under latent). Verify these are permanent base stats and not part of the latent. The Crossbow page showed RACC/RATT only under the latent section.

4. **Ranged weapon latent mod:** Should ranged weapons use mod 376 (RANGED_DMG_RATING) instead of 287 (DMG_RATING) for the DMG latent? Need to verify which mod applies to archery/marksmanship.

---

## FILES AFFECTED

- `sql/item_latents.sql` - 11 weapons need new latent entries, 1 weapon needs value corrections
- `sql/item_mods.sql` - 1 DEF fix, 1 wrong mod type, 2 value corrections, 1 missing mod, 4+ missing base mods
