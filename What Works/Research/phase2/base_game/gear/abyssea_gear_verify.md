# Abyssea Era Gear Verification

**Date:** 2026-03-29
**Source:** bg-wiki.com cross-referenced with sql/item_mods.sql
**Status:** MOSTLY CORRECT with minor issues noted

---

## PERLE SET (Base, lv78) — Melee Tank/DD

### Perle Salade (11503) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 37 | 37 | OK |
| STR | 5 | 5 | OK |
| VIT | 5 | 5 | OK |
| ATT | 7 | 7 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Perle Hauberk (13759) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 61 | 61 | OK |
| STR | 8 | 8 | OK |
| DEX | 4 | 4 | OK |
| ACC | 8 | 8 | OK |
| ATT | 8 | 8 | OK |
| CRITHITRATE | 2 | 2% | OK |
| HASTE_GEAR | (none) | Set: Haste+5% | OK (set bonus in gear_sets.lua) |

### Perle Moufles (12745) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 23 | 23 | OK |
| STR | 4 | 4 | OK |
| DEX | 2 | 2 | OK |
| ATT | 10 | 10 | OK |
| HASTE_GEAR | 200 (2%) | 2% | OK |

### Perle Brayettes (14210) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 37 | 37 | OK |
| DEX | 5 | 5 | OK |
| VIT | 5 | 5 | OK |
| ACC | 10 | 10 | OK |
| ENMITY | 2 | 2 | OK |
| HASTE_GEAR | 200 (2%) | 2% | OK |

### Perle Sollerets (11413) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 21 | 21 | OK |
| STR | 5 | 5 | OK |
| DEX | 3 | 3 | OK |
| ENMITY | 2 | 2 | OK |
| HASTE_GEAR | 200 (2%) | 2% | OK |

### Perle Set Bonus (gear_sets.lua [11])
- All 5 pieces required, grants Haste+5% (500) — **OK matches bg-wiki**

**PERLE BASE VERDICT: ALL CORRECT**

---

## PERLE +1 SET (lv90)

### Perle Salade +1 (26711) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 39 | 39 | OK |
| STR | 9 | 9 | OK |
| VIT | 9 | 9 | OK |
| ACC | 10 | 10 | OK |
| ATT | 15 | 15 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Perle Hauberk +1 (27851) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 69 | 69 | OK |
| STR | 9 | 9 | OK |
| DEX | 9 | 9 | OK |
| ACC | 15 | 15 | OK |
| ATT | 15 | 15 | OK |
| DOUBLE_ATTACK | 2 | 2% | OK |
| CRITHITRATE | 3 | 3% | OK |

### Perle Moufles +1 (27997) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 33 | 33 | OK |
| STR | 10 | 10 | OK |
| DEX | 5 | 5 | OK |
| ATT | 13 | 13 | OK |
| HASTE_GEAR | 200 (2%) | 2% | OK |

### Perle Brayettes +1 (28138) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 55 | 55 | OK |
| DEX | 7 | 7 | OK |
| VIT | 7 | 7 | OK |
| ACC | 15 | 15 | OK |
| ENMITY | 4 | 4 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Perle Sollerets +1 (28277) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 28 | 28 | OK |
| STR | 8 | 8 | OK |
| DEX | 8 | 8 | OK |
| ATT | 10 | 10 | OK |
| ENMITY | 4 | 4 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Perle +1 Set Bonus (gear_sets.lua [76])
- 2-5 pieces, Haste +2-5% (scaling 200-500) — **OK matches bg-wiki**

**PERLE +1 VERDICT: ALL CORRECT**

---

## AURORE SET (Base, lv78) — DEX/Ranged

### Aurore Beret (11504) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 29 | 29 | OK |
| DEX | 4 | 4 | OK |
| AGI | 4 | 4 | OK |
| HASTE_GEAR | 400 (4%) | 4% | OK |

### Aurore Doublet (13760) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 56 | 56 | OK |
| STR | 4 | 4 | OK |
| DEX | 4 | 4 | OK |
| AGI | 4 | 4 | OK |
| ACC | 8 | 8 | OK |
| RACC | 8 | 8 | OK |
| EVA | 8 | 8 | OK |
| DOUBLE_ATTACK | 2 | 2% | OK |

### Aurore Gloves (12746) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 21 | 21 | OK |
| STR | 4 | 4 | OK |
| AGI | 4 | 4 | OK |
| HASTE_GEAR | 200 (2%) | 2% | OK |

### Aurore Brais (14257) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 35 | 35 | OK |
| ACC | 9 | 9 | OK |
| RACC | 9 | 9 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Aurore Gaiters (11414) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 19 | 19 | OK |
| DEX | 5 | 5 | OK |
| EVA | 5 | 5 | OK |
| HASTE_GEAR | 200 (2%) | 2% | OK |

### Aurore Set Bonus (gear_sets.lua [12])
- All 5 pieces, Store TP +8 — **OK matches bg-wiki**

**AURORE BASE VERDICT: ALL CORRECT**

---

## AURORE +1 SET (lv90)

### Aurore Beret +1 (26712) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 37 | 37 | OK |
| DEX | 8 | 8 | OK |
| AGI | 8 | 8 | OK |
| ACC | 7 | 7 | OK |
| SNAPSHOT | 5 | 5 | OK |
| HASTE_GEAR | 400 (4%) | 4% | OK |

### Aurore Doublet +1 (27852) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 62 | 62 | OK |
| STR | 9 | 9 | OK |
| DEX | 9 | 9 | OK |
| AGI | 9 | 9 | OK |
| ACC | 13 | 13 | OK |
| RACC | 13 | 13 | OK |
| EVA | 13 | 13 | OK |
| DOUBLE_ATTACK | 3 | 3% | OK |

### Aurore Gloves +1 (27998) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 27 | 27 | OK |
| STR | 9 | 9 | OK |
| AGI | 9 | 9 | OK |
| ACC | 6 | 6 | OK |
| ATT | 6 | 6 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Aurore Brais +1 (28139) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 48 | 48 | OK |
| ACC | 15 | 15 | OK |
| RACC | 15 | 15 | OK |
| SUBTLE_BLOW | 7 | 7 | OK |
| HASTE_GEAR | 400 (4%) | 4% | OK |

### Aurore Gaiters +1 (28278) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 23 | 23 | OK |
| DEX | 8 | 8 | OK |
| MACC | 10 | 10 | OK |
| EVA | 15 | 15 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Aurore +1 Set Bonus (gear_sets.lua [75])
- 2-5 pieces, Store TP +2/4/6/8 — **OK matches bg-wiki**

**AURORE +1 VERDICT: ALL CORRECT**

---

## TEAL SET (Base, lv78) — Mage

### Teal Chapeau (11505) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 22 | 22 | OK |
| HP | 17 | 17 | OK |
| INT | 6 | 6 | OK |
| MND | 6 | 6 | OK |
| ENMITY | -2 | -2 | OK |

### Teal Saio (13778) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 48 | 48 | OK |
| HP | 24 | 24 | OK |
| MP | 24 | 24 | OK |
| INT | 6 | 6 | OK |
| MND | 6 | 6 | OK |
| CHR | 6 | 6 | OK |
| MATT | 4 | 4 | OK |
| MACC | 4 | 4 | OK |

### Teal Cuffs (12747) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 19 | 19 | OK |
| HP | 12 | 12 | OK |
| MND | 3 | 3 | OK |
| CHR | 3 | 3 | OK |
| MACC | 5 | 5 | OK |
| ENMITY | -2 | -2 | OK |

### Teal Slops (14258) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 32 | 32 | OK |
| HP | 14 | 14 | OK |
| INT | 5 | 5 | OK |
| CHR | 5 | 5 | OK |
| MATT | 3 | 3 | OK |
| MACC | 3 | 3 | OK |

### Teal Pigaches (11415) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 16 | 16 | OK |
| HP | 8 | 8 | OK |
| MND | 6 | 6 | OK |
| CHR | 6 | 6 | OK |
| ENMITY | -4 | -4 | OK |

### Teal Set Bonus (gear_sets.lua [13])
- 2-5 pieces, Fast Cast +4/6/8/10% — **OK matches bg-wiki**

**TEAL BASE VERDICT: ALL CORRECT**

---

## TEAL +1 SET (lv90)

### Teal Chapeau +1 (26713) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 32 | 32 | OK |
| HP | 25 | 25 | OK |
| MP | 25 | 25 | OK |
| INT | 9 | 9 | OK |
| MND | 9 | 9 | OK |
| MACC | 5 | 5 | OK |
| ENMITY | -4 | -4 | OK |

### Teal Saio +1 (27853) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 53 | 53 | OK |
| HP | 40 | 40 | OK |
| MP | 40 | 40 | OK |
| INT | 13 | 13 | OK |
| MND | 13 | 13 | OK |
| CHR | 13 | 13 | OK |
| MACC | 9 | 9 | OK |
| MATT | 9 | 9 | OK |
| REFRESH | 2 | 2 | OK |

### Teal Cuffs +1 (27999) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 23 | 23 | OK |
| HP | 20 | 20 | OK |
| MP | 20 | 20 | OK |
| MND | 8 | 8 | OK |
| CHR | 8 | 8 | OK |
| MACC | 10 | 10 | OK |
| ENMITY | -4 | -4 | OK |

### Teal Slops +1 (28140) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 43 | 43 | OK |
| HP | 30 | 30 | OK |
| INT | 12 | 12 | OK |
| CHR | 12 | 12 | OK |
| MATT | 5 | 5 | OK |
| MACC | 5 | 5 | OK |

**NOTE:** BG-Wiki does not list MP for Teal Slops +1. Server has no MP mod. OK.

### Teal Pigaches +1 (28279) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 19 | 19 | OK |
| HP | 15 | 15 | OK |
| MP | 15 | 15 | OK |
| MND | 10 | 10 | OK |
| CHR | 10 | 10 | OK |
| ENMITY | -6 | -6 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Teal +1 Set Bonus (gear_sets.lua [74])
- 2-5 pieces, Fast Cast +4/6/8/10% — **OK matches bg-wiki**

**TEAL +1 VERDICT: ALL CORRECT**

---

## EMPYREAN ARMOR +2 — WAR (Ravager's)

### Ravager's Mask +2 (11064) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 38 | 38 | OK |
| STR | 8 | 8 | OK |
| VIT | 8 | 8 | OK |
| ACC | 14 | 14 | OK |
| ATT | 14 | 14 | OK |
| CRITHITRATE | 3 | 3% | OK |
| DOUBLE_ATTACK | 4 | 4% | OK |

### Ravager's Lorica +2 (11084) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 68 | 68 | OK |
| ACC | 20 | 20 | OK |
| ATT | 20 | 20 | OK |
| STORETP | 8 | 8 | OK |
| GAXE (skill 85) | 7 | 7 | OK |
| ENHANCES_BLOOD_RAGE (1046) | 30 | +30s duration | OK |

### Ravager's Mufflers +2 (11104) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 32 | 32 | OK |
| STR | 9 | 9 | OK |
| DEX | 9 | 9 | OK |
| ACC | 12 | 12 | OK |
| AXE (skill 84) | 5 | 5 | OK |
| ENHANCES_RESTRAINT (1045) | 100 | doubles WS bonus | OK |

### Ravager's Cuisses +2 (11124) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 54 | 54 | OK |
| ATT | 15 | 15 | OK |
| DOUBLE_ATTACK | 5 | 5% | OK |
| HASTE_GEAR | 700 (7%) | 7% | OK |
| FENCER_TP_BONUS (903) | 50 | "Fencer"+1 | OK |
| FENCER_CRITHITRATE (904) | 1 | (part of Fencer) | OK |

### Ravager's Calligae +2 (11144) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 27 | 27 | OK |
| ACC | 7 | 7 | OK |
| HASTE_GEAR | 500 (5%) | 5% | OK |
| RETALIATION (414) | 20 | +20% | OK |
| CRIT_DMG_INCREASE (421) | 10 | +10% | OK |

**RAVAGER'S +2 VERDICT: ALL CORRECT**

---

## EMPYREAN ARMOR +2 — BRD (Aoidos')

### Aoidos' Calot +2 (11073) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 33 | 33 | OK |
| CHR | 8 | 8 | OK |
| ENMITY | -7 | -7 | OK |
| MADRIGAL_EFFECT (438) | 1 | +1 | OK |
| SONG_SPELLCASTING_TIME (455) | 12 | -12% | OK |

### Aoidos' Hongreline +2 (11093) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 51 | 51 | OK |
| CHR | 10 | 10 | OK |
| SINGING (119) | 10 | 10 | OK |
| WIND (121) | 10 | 10 | OK |
| MINUET_EFFECT (434) | 1 | +1 | OK |
| SONG_DURATION_BONUS (454) | 10 | +10% | OK |

### Aoidos' Manchettes +2 (11113) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 24 | 24 | OK |
| CHR | 12 | 12 | OK |
| MACC | 8 | 8 | OK |
| SINGING (119) | 8 | 8 | OK |
| STRING (120) | 8 | 8 | OK |
| WIND (121) | 8 | 8 | OK |
| MARCH_EFFECT (443) | 1 | +1 | OK |

### Aoidos' Rhingrave +2 (11133) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 42 | 42 | OK |
| SINGING (119) | 10 | 10 | OK |
| MACC | 7 | 7 | OK |
| BALLAD_EFFECT (442) | 1 | +1 | OK |
| SONG_RECAST_DELAY (833) | 6 | -6 | OK |

### Aoidos' Cothurnes +2 (11153) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 18 | 18 | OK |
| CHR | 11 | 11 | OK |
| REGEN (370) | 2 | "Regen" effect | OK |
| SCHERZO_EFFECT (451) | 1 | +1 | OK |
| MOVE_SPEED_GEAR_BONUS (76) | 12 | +12% | OK |

**AOIDOS' +2 VERDICT: ALL CORRECT**

---

## EMPYREAN ARMOR — BLM (Hagondes, iLv113)

### Hagondes Hat (27772) — HEAD
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 78 | 78 | OK |
| HP | 24 | 24 | OK |
| MP | 29 | 29 | OK |
| STR | 15 | 15 | OK |
| DEX | 15 | 15 | OK |
| VIT | 15 | 15 | OK |
| AGI | 15 | 15 | OK |
| INT | 19 | 19 | OK |
| MND | 19 | 19 | OK |
| CHR | 19 | 19 | OK |
| MATT | 13 | 13 | OK |
| MDEF | 3 | 3 | OK |
| MEVA | 60 | 60 | OK |
| EVA | 24 | 24 | OK |
| HASTE_GEAR | 500 (5%) | 5% | OK |

### Hagondes Coat (27916) — BODY
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 102 | 102 | OK |
| HP | 37 | 37 | OK |
| MP | 53 | 53 | OK |
| STR | 17 | 17 | OK |
| DEX | 17 | 17 | OK |
| VIT | 17 | 17 | OK |
| AGI | 17 | 17 | OK |
| INT | 28 | 28 | OK |
| MND | 23 | 23 | OK |
| CHR | 23 | 23 | OK |
| MATT | 10 | 10 | OK |
| MDEF | 4 | 4 | OK |
| MEVA | 65 | 65 | OK |
| EVA | 28 | 28 | OK |
| REFRESH | 1 | "Refresh" | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Hagondes Cuffs (28055) — HANDS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 68 | 68 | OK |
| HP | 23 | 23 | OK |
| MP | 21 | 21 | OK |
| STR | 5 | 5 | OK |
| DEX | 22 | 22 | OK |
| VIT | 20 | 20 | OK |
| AGI | 4 | 4 | OK |
| INT | 15 | 15 | OK |
| MND | 26 | 26 | OK |
| CHR | 15 | 15 | OK |
| MACC | 20 | 20 | OK |
| MDEF | 2 | 2 | OK |
| MEVA | 30 | 30 | OK |
| EVA | 15 | 15 | OK |
| ENMITY | -8 | -8 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |

### Hagondes Pants (28196) — LEGS
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 88 | 88 | OK |
| HP | 29 | 29 | OK |
| MP | 26 | 26 | OK |
| STR | 20 | 20 | OK |
| VIT | 10 | 10 | OK |
| AGI | 14 | 14 | OK |
| INT | 27 | 27 | OK |
| MND | 19 | 19 | OK |
| CHR | 15 | 15 | OK |
| MATT | 25 | 25 | OK |
| MDEF | 4 | 4 | OK |
| MEVA | 86 | 86 | OK |
| EVA | 18 | 18 | OK |
| MAGIC_DAMAGE (311) | 10 | 10 | OK |
| HASTE_GEAR | 400 (4%) | 4% | OK |

### Hagondes Sabots (28336) — FEET
| Mod | Server | BG-Wiki | Status |
|-----|--------|---------|--------|
| DEF | 53 | 53 | OK |
| HP | 19 | 19 | OK |
| MP | 23 | 23 | OK |
| STR | 8 | 8 | OK |
| DEX | 9 | 9 | OK |
| VIT | 8 | 8 | OK |
| AGI | 26 | 26 | OK |
| INT | 14 | 14 | OK |
| MND | 15 | 15 | OK |
| CHR | 27 | 27 | OK |
| MDEF | 3 | 3 | OK |
| MEVA | 86 | 86 | OK |
| EVA | 37 | 37 | OK |
| HASTE_GEAR | 300 (3%) | 3% | OK |
| Avatar MAB | **MISSING** | +25 | **ISSUE** |

**HAGONDES VERDICT: 1 ISSUE FOUND**

---

## ISSUES SUMMARY

### Issue 1: Hagondes Sabots (28336) Missing Avatar: Magic Atk. Bonus +25
- **Severity:** LOW-MEDIUM (only affects SMN using these feet, and SMN is not a primary equippable job for this piece anyway -- BLM/RDM/SMN/BLU/SCH/GEO can equip it)
- **Fix:** Add `INSERT INTO item_mods VALUES (28336,992,25); -- PET_MAB_MDB: 25` to sql/item_mods.sql
- **Note:** The mod ID for this is `PET_MAB_MDB = 992` which handles both pet MAB and MDB. BG-Wiki says "Avatar: 'Magic Atk. Bonus'+25" which means it should only apply to avatars. The mod 992 applies to all pets, which may be slightly broader than intended but is the standard approach used by the codebase.

### All Other Items: CORRECT
- All 10 Perle base + Perle +1 pieces: values match bg-wiki exactly
- All 10 Aurore base + Aurore +1 pieces: values match bg-wiki exactly
- All 10 Teal base + Teal +1 pieces: values match bg-wiki exactly
- All 5 Ravager's +2 (WAR empyrean): values match bg-wiki exactly
- All 5 Aoidos' +2 (BRD empyrean): values match bg-wiki exactly
- 4 of 5 Hagondes (BLM empyrean): values match bg-wiki exactly
- Set bonuses in gear_sets.lua all verified correct

---

## VERIFICATION STATS
- **Total items checked:** 40
- **Total individual mod values verified:** 250+
- **Mismatches found:** 1 (Hagondes Sabots missing Avatar MAB)
- **Zero-mod items found:** 0
- **Data source:** bg-wiki.com fetched 2026-03-29
