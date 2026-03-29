# Reward Items Deep Verification Audit

**Date:** 2026-03-29
**Methodology:** Fetched bg-wiki for retail stats, cross-referenced every mod value in item_mods.sql and item_latents.sql.

> NOTE: Several item IDs provided in the audit request were INCORRECT. Correct IDs were located via item_equipment.sql. Corrected IDs are noted below.

---

## COP Rewards

### Rajas Ring (ID: 15543) -- PASS

**bg-wiki stats:** STR+2~5, DEX+2~5, Store TP+5, Subtle Blow+5
(2~5 = base 2, +1 every 15 levels starting at lv30)

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| STR | 8 | 2 | 2 (base) | YES |
| DEX | 9 | 2 | 2 (base) | YES |
| Store TP | 73 | 5 | 5 | YES |
| Subtle Blow | 289 | 5 | 5 | YES |

**item_latents.sql (level scaling):**
- STR+1 at levels 45, 60, 75 (base 2 + 3 = 5 max) -- CORRECT
- DEX+1 at levels 45, 60, 75 (base 2 + 3 = 5 max) -- CORRECT

**Verdict: ALL CORRECT**

---

### Sattva Ring (ID: 15544, NOT 15545 as listed in request) -- PASS

**bg-wiki stats:** HP+15~30, VIT+2~5, AGI+2~5, Enmity+3

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| HP | 2 | 15 | 15 (base) | YES |
| VIT | 10 | 2 | 2 (base) | YES |
| AGI | 11 | 2 | 2 (base) | YES |
| Enmity | 27 | 3 | 3 | YES |

**item_latents.sql (level scaling):**
- HP+1 at 15 level thresholds (33,36,39...75) = base 15 + 15 = 30 max -- CORRECT
- VIT+1 at levels 45, 60, 75 (base 2 + 3 = 5 max) -- CORRECT
- AGI+1 at levels 45, 60, 75 (base 2 + 3 = 5 max) -- CORRECT

**Verdict: ALL CORRECT**

---

### Tamas Ring (ID: 15545, NOT 15544 as listed in request) -- PASS

**bg-wiki stats:** MP+15~30, INT+2~5, MND+2~5, Enmity-3

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| MP | 5 | 15 | 15 (base) | YES |
| INT | 12 | 2 | 2 (base) | YES |
| MND | 13 | 2 | 2 (base) | YES |
| Enmity | 27 | -3 | -3 | YES |

**item_latents.sql (level scaling):**
- MP+1 at 15 level thresholds (33,36,39...75) = base 15 + 15 = 30 max -- CORRECT
- INT+1 at levels 45, 60, 75 (base 2 + 3 = 5 max) -- CORRECT
- MND+1 at levels 45, 60, 75 (base 2 + 3 = 5 max) -- CORRECT

**Verdict: ALL CORRECT**

---

## Divine Might Rewards

### Suppanomimi (ID: 14739, NOT 13144 as listed in request) -- PASS

> Note: ID 13144 is actually Wing Gorget. Suppanomimi is 14739.

**bg-wiki stats:** AGI+2, Sword Skill+5, Dual Wield+5

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| AGI | 11 | 2 | 2 | YES |
| Sword Skill | 82 | 5 | 5 | YES |
| Dual Wield | 259 | 5 | 5 | YES |

**Verdict: ALL CORRECT**

---

## ToAU Rewards

### Balrahn's Ring (ID: 15807) -- PASS

**bg-wiki stats:**
- Permanent: Magic Accuracy+4
- Assault-only: INT+4, MND+4, CHR+4, Refresh+1

**item_mods.sql (permanent):**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| MACC | 30 | 4 | 4 | YES |

**item_latents.sql (Assault zones, latent condition 58):**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| INT | 12 | 4 | 4 | YES |
| MND | 13 | 4 | 4 | YES |
| CHR | 14 | 4 | 4 | YES |
| Refresh | 369 | 1 | 1 | YES |

> **CORRECTION:** Previous audit flagged "missing Enmity-2". This was WRONG. bg-wiki confirms Balrahn's Ring has NO Enmity stat. The previous flag was a false positive.

**Verdict: ALL CORRECT**

---

## Popular Gear

### Defending Ring (ID: 13566, NOT 12519 as listed in request) -- PASS

> Note: ID 12519 is actually Drachen Armet. Defending Ring is 13566.

**bg-wiki stats:** Damage Taken -10%

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| DMG (DT%) | 160 | -1000 | -1000 (-10%, using /10000 scale) | YES |

**How it works:** Code divides by 10000, so -1000/10000 = -0.10 = -10% Damage Taken.

**Verdict: ALL CORRECT**

---

### Haubergeon (ID: 12555, NOT 14020 as listed in request) -- PASS

> Note: ID 14020 does not appear to be Haubergeon. Correct ID is 12555.

**bg-wiki stats:** DEF:45, STR+5, DEX+5, AGI-5, Accuracy+10, Attack+10, Evasion-20

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| DEF | 1 | 45 | 45 | YES |
| STR | 8 | 5 | 5 | YES |
| DEX | 9 | 5 | 5 | YES |
| AGI | 11 | -5 | -5 | YES |
| ATT | 23 | 10 | 10 | YES |
| ACC | 25 | 10 | 10 | YES |
| EVA | 68 | -20 | -20 | YES |

**Verdict: ALL CORRECT**

---

### Sniper's Ring (ID: 13280, NOT 13114 as listed in request) -- PASS

**bg-wiki stats:** DEF-10, Accuracy+5, Ranged Accuracy+5, Dark-20

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| DEF | 1 | -10 | -10 | YES |
| DARK_MEVA | 22 | -20 | -20 (Dark resistance) | YES |
| ACC | 25 | 5 | 5 | YES |
| RACC | 26 | 5 | 5 | YES |

> Note: FFXI "Dark -20" (elemental resistance) maps to DARK_MEVA (mod 22) in the LSB codebase. This is correct.

**Verdict: ALL CORRECT**

---

### Peacock Charm (ID: 13056, NOT 11522 as listed in request) -- PASS

**bg-wiki stats:** Accuracy+10, Ranged Accuracy+10, Dark-10

**item_mods.sql:**
| Mod | ID | Value | Expected | Match? |
|-----|----|-------|----------|--------|
| DARK_MEVA | 22 | -10 | -10 (Dark resistance) | YES |
| ACC | 25 | 10 | 10 | YES |
| RACC | 26 | 10 | 10 | YES |

**Verdict: ALL CORRECT**

---

## Summary

| Item | Correct ID | Status | Issues |
|------|-----------|--------|--------|
| Rajas Ring | 15543 | PASS | None |
| Sattva Ring | 15544 | PASS | None (ID was swapped with Tamas in request) |
| Tamas Ring | 15545 | PASS | None (ID was swapped with Sattva in request) |
| Suppanomimi | 14739 | PASS | None (request had wrong ID 13144) |
| Balrahn's Ring | 15807 | PASS | Previous "Enmity-2 missing" flag was FALSE POSITIVE |
| Defending Ring | 13566 | PASS | None (request had wrong ID 12519) |
| Haubergeon | 12555 | PASS | None (request had wrong ID 14020) |
| Sniper's Ring | 13280 | PASS | None (request had wrong ID 13114) |
| Peacock Charm | 13056 | PASS | None (request had wrong ID 11522) |

## Key Findings

1. **ALL 9 items have correct mod values.** Every stat matches bg-wiki retail data.
2. **COP rings have proper level scaling** via item_latents.sql with correct thresholds.
3. **Balrahn's Ring Assault-only effects** are correctly implemented via latent condition 58.
4. **Previous Balrahn's Ring Enmity-2 flag was a false positive** -- the ring has no Enmity stat on retail.
5. **6 of 9 item IDs in the request were incorrect** -- always verify IDs via item_equipment.sql.
