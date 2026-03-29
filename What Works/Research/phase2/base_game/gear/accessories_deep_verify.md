# Accessories Deep Verification Report

Verified: 2026-03-29
Source: bg-wiki.com vs sql/item_mods.sql + sql/item_latents.sql

## Summary

- **Items Checked:** 31
- **Items PASS:** 29
- **Items with MISMATCHES:** 1
- **Items AUGMENT-ONLY (no base mods):** 1

---

## MISMATCHES FOUND

### Jalzahn's Ring (15809) — SNAPSHOT LATENT VALUE WRONG
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| RACC (26) | 6 | Ranged Accuracy+6 | PASS |
| RATT (24) | 6 | Ranged Attack+6 | PASS |
| Latent AGI (11) [IN_ASSAULT] | 6 | AGI+6 | PASS |
| Latent SNAPSHOT (365) [IN_ASSAULT] | **1** | **Snapshot +5%** | **FAIL** |

**Fix:** In `sql/item_latents.sql`, change Jalzahn's Ring Snapshot latent from 1 to 5.

---

## AUGMENT-ONLY (Cannot Verify Base Mods)

### Moonshade Earring (11697) — AUGMENT ITEM
- No base mods in item_mods.sql or item_latents.sql (correct — stats come from augments)
- Augment options per bg-wiki:
  - Set 1 (choose one): ACC+4, ATT+4, RACC+4, RATT+4, MACC+4, MAB+4, HP+25, MP+25
  - Set 2 (choose one): Latent Regain, Latent Refresh, TP Bonus+250, Occ. dmg bonus+5%, Occ. max MACC+3%, Occ. quicken+3%, Counter+3, Occ. resist status+5
- **Status:** Cannot verify without checking augment system tables. No base mod issues.

---

## ALL ITEMS — DETAILED RESULTS

### RINGS

#### Sniper's Ring (13280) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | -10 | DEF: -10 | PASS |
| DARK_MEVA (22) | -20 | Dark -20 | PASS |
| ACC (25) | 5 | Accuracy+5 | PASS |
| RACC (26) | 5 | Ranged Accuracy+5 | PASS |

#### Sniper's Ring +1 (13281) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | -12 | DEF: -12 | PASS |
| DARK_MEVA (22) | -25 | Dark -25 | PASS |
| ACC (25) | 7 | Accuracy+7 | PASS |
| RACC (26) | 7 | Ranged Accuracy+7 | PASS |

#### Woodsman Ring (14675) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| ACC (25) | 5 | Accuracy+5 | PASS |
| RACC (26) | 5 | Ranged Accuracy+5 | PASS |
| EVA (68) | -5 | Evasion-5 | PASS |

#### Astral Ring (13548) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| CONVHPTOMP (7) | 25 | Converts 25 HP to MP | PASS |

Note: Astral Ring +1 does not exist in the server database (no item_basic entry). This item may not exist in retail FFXI.

#### Serket Ring (13552) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 3 | DEF:3 | PASS |
| CONVHPTOMP (7) | 50 | Converts 50 HP to MP | PASS |

#### Toreador's Ring (14674) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 1 | DEF:1 | PASS |
| HP (2) | 10 | HP+10 | PASS |
| ACC (25) | 7 | Accuracy+7 | PASS |

#### Ulthalam's Ring (15808) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| ACC (25) | 4 | Accuracy+4 | PASS |
| ATT (23) | 4 | Attack+4 | PASS |
| Latent STR (8) [IN_ASSAULT] | 4 | STR+4 | PASS |
| Latent DEX (9) [IN_ASSAULT] | 4 | DEX+4 | PASS |
| Latent REGEN (370) [IN_ASSAULT] | 1 | Regen | PASS |

#### Jalzahn's Ring (15809) — FAIL (see above)
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| RACC (26) | 6 | Ranged Accuracy+6 | PASS |
| RATT (24) | 6 | Ranged Attack+6 | PASS |
| Latent AGI (11) [IN_ASSAULT] | 6 | AGI+6 | PASS |
| Latent SNAPSHOT (365) [IN_ASSAULT] | **1** | **Snapshot +5%** | **FAIL** |

---

### EARRINGS

#### Brutal Earring (14813) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| STORETP (73) | 1 | Store TP+1 | PASS |
| DOUBLE_ATTACK (288) | 5 | Double Attack+5% | PASS |

#### Bushinomimi (14743) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| STR (8) | 2 | STR+2 | PASS |
| GKATANA (89) | 5 | Great Katana skill+5 | PASS |
| PARRY (110) | 5 | Parrying skill+5 | PASS |

#### Ethereal Earring (15965) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| HP (2) | 15 | HP+15 | PASS |
| ATT (23) | 5 | Attack+5 | PASS |
| EVA (68) | 5 | Evasion+5 | PASS |
| ABSORB_DMG_TO_MP (516) | 3 | Converts 3% of damage taken to MP | PASS |

#### Magnetic Earring (15963) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| MP (5) | 20 | MP+20 | PASS |
| MPHEAL (71) | 1 | MP recovered while healing +1 | PASS |
| SPELLINTERRUPT (168) | 8 | Spell interruption rate down 8% | PASS |
| CONSERVE_MP (296) | 5 | Conserve MP+5 | PASS |

#### Hollow Earring (15964) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEX (9) | 2 | DEX+2 | PASS |
| ACC (25) | 3 | Accuracy+3 | PASS |
| RACC (26) | 3 | Ranged Accuracy+3 | PASS |
| ENSPELL_DMG_BONUS (432) | 3 | Sword enhancement spell damage +3 | PASS |

#### Moonshade Earring (11697) — AUGMENT ITEM (see above)

---

### BELTS / WAIST

#### Swift Belt (15457) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| ACC (25) | 3 | Accuracy+3 | PASS |
| ATT (23) | -5 | Attack-5 | PASS |
| HASTE_GEAR (384) | 400 | Haste+4% | PASS |

Note: HASTE_GEAR uses 10000 base where 100 = 1%. 400 = 4%.

#### Speed Belt (13189) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| HASTE_GEAR (384) | 600 | Haste+6% | PASS |

#### Velocious Belt (15899) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| HASTE_GEAR (384) | 600 | Haste+6% | PASS |

#### Life Belt (13231) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| ACC (25) | 10 | Accuracy+10 | PASS |

#### Warwolf Belt (15294) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 6 | DEF:6 | PASS |
| STR (8) | 5 | STR+5 | PASS |
| DEX (9) | 5 | DEX+5 | PASS |
| VIT (10) | 5 | VIT+5 | PASS |
| ENMITY (27) | 3 | Enmity+3 | PASS |

#### Trance Belt (15895) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 5 | DEF:5 | PASS |
| HP (2) | 14 | HP+14 | PASS |
| ENMITY (27) | 4 | Enmity+4 | PASS |

#### Potent Belt (15884) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 5 | DEF:5 | PASS |
| STR (8) | 3 | STR+3 | PASS |
| ACC (25) | 8 | Accuracy+8 | PASS |

---

### NECK

#### Love Torque (15514) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEX (9) | 5 | DEX+5 | PASS |
| DAGGER (81) | 7 | Dagger skill+7 | PASS |
| POLEARM (87) | 7 | Polearm skill+7 | PASS |

#### Justice Torque (15508) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| STR (8) | 5 | STR+5 | PASS |
| SCYTHE (86) | 7 | Scythe skill+7 | PASS |
| GKATANA (89) | 7 | Great Katana skill+7 | PASS |

#### Temperance Torque (15513) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| CHR (14) | 5 | CHR+5 | PASS |
| AXE (84) | 7 | Axe skill+7 | PASS |
| STAFF (91) | 7 | Staff skill+7 | PASS |

#### Hope Torque (15509) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| AGI (11) | 5 | AGI+5 | PASS |
| KATANA (88) | 7 | Katana skill+7 | PASS |
| ARCHERY (104) | 7 | Archery skill+7 | PASS |

#### Faith Torque (15512) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| MND (13) | 5 | MND+5 | PASS |
| HTH (80) | 7 | Hand-to-Hand skill+7 | PASS |
| MARKSMAN (105) | 7 | Marksmanship skill+7 | PASS |

---

### BACK

#### Amemet Mantle (13645) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 7 | DEF:7 | PASS |
| STR (8) | 1 | STR+1 | PASS |
| ATT (23) | 10 | Attack+10 | PASS |
| RATT (24) | 10 | Ranged Attack+10 | PASS |

#### Amemet Mantle +1 (13646) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 8 | DEF:8 | PASS |
| STR (8) | 2 | STR+2 | PASS |
| ATT (23) | 15 | Attack+15 | PASS |
| RATT (24) | 15 | Ranged Attack+15 | PASS |

#### Cerberus Mantle (16212) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 12 | DEF:12 | PASS |
| STR (8) | 3 | STR+3 | PASS |
| FIRE_MEVA (15) | 10 | Fire+10 | PASS |
| ATT (23) | 12 | Attack+12 | PASS |
| ENMITY (27) | 3 | Enmity+3 | PASS |

#### Cerberus Mantle +1 (16216) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 13 | DEF:13 | PASS |
| STR (8) | 4 | STR+4 | PASS |
| FIRE_MEVA (15) | 12 | Fire+12 | PASS |
| ATT (23) | 15 | Attack+15 | PASS |
| ENMITY (27) | 4 | Enmity+4 | PASS |

#### Birdman Cape (15466) — PASS
| Mod | Server | bg-wiki | Status |
|-----|--------|---------|--------|
| DEF (1) | 7 | DEF:7 | PASS |
| MP (5) | 30 | MP+30 | PASS |
| CHR (14) | 9 | CHR+9 | PASS |
| PARALYZERES (242) | 2 | Enhances "Resist Paralyze" effect | PASS |

---

## ACTION ITEMS

1. **FIX: Jalzahn's Ring (15809) Snapshot latent** — Change value from 1 to 5 in `sql/item_latents.sql`
   - Line: `INSERT INTO item_latents VALUES (15809,365,1,58,0);`
   - Should be: `INSERT INTO item_latents VALUES (15809,365,5,58,0);`

2. **NOTE: Astral Ring +1** does not exist in the database. This appears to be correct as Astral Ring +1 may not exist in retail FFXI.

3. **NOTE: Moonshade Earring** is augment-based. Base mods correctly absent. Augment system should be verified separately.
