# Popular Level 75-Era Gear Verification

**Date:** 2026-03-29
**Verified by:** Deep audit against bg-wiki.com
**Server branch:** develop

---

## Summary

| Item | ID | Status | Notes |
|------|-----|--------|-------|
| Haubergeon | 12555 | PASS | All 7 mods match |
| Haubergeon +1 | 13735 | PASS | All 7 mods match |
| Scorpion Harness | 12579 | PASS | All 7 mods match |
| Scorpion Harness +1 | 13734 | PASS | All 7 mods match |
| Vermillion Cloak | 13748 | PASS | All 5 mods match |
| Errant Houppelande | 14380 | PASS | All 10 mods match |
| Dalmatica | 13787 | PASS | All 5 mods match |
| Dalmatica +1 | 13788 | PASS | All 5 mods match |
| Noble's Tunic | 12605 | PASS | All 4 mods match |
| Optical Hat | 13915 | PASS | All 3 mods match |
| Walahra Turban | 15270 | PASS | All 3 mods match |
| Homam Zucchetto | 15240 | PASS | All 6 mods match |
| Dusk Gloves | 12701 | PASS | All 5 mods match |
| Dusk Gloves +1 | 14825 | PASS | All 5 mods match |
| Byakko's Haidate | 12818 | PASS | All 4 mods match |
| Homam Cosciales | 15576 | PASS | All 6 mods match |
| Homam Gambieras | 15661 | PASS | All 6 mods + pet mod match |
| Kraken Club | 17440 | PASS | DMG 11, Delay 264, hit 2-8 |
| Mercurial Kris | 18020 | PASS | DMG 8, Delay 192, hit 2-3 |
| Joyeuse | 17652 | PASS | DMG 35, Delay 224, hit 2, Dark +14 |

**Result: 20/20 items PASS -- No mismatches found.**

---

## Detailed Verification

### Body Armor

#### Haubergeon (ID: 12555)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 45 | mod 1 = 45 | PASS |
| STR | +5 | mod 8 = 5 | PASS |
| DEX | +5 | mod 9 = 5 | PASS |
| AGI | -5 | mod 11 = -5 | PASS |
| Attack | +10 | mod 23 = 10 | PASS |
| Accuracy | +10 | mod 25 = 10 | PASS |
| Evasion | -20 | mod 68 = -20 | PASS |

#### Haubergeon +1 (ID: 13735)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 46 | mod 1 = 46 | PASS |
| STR | +6 | mod 8 = 6 | PASS |
| DEX | +6 | mod 9 = 6 | PASS |
| AGI | -5 | mod 11 = -5 | PASS |
| Attack | +12 | mod 23 = 12 | PASS |
| Accuracy | +12 | mod 25 = 12 | PASS |
| Evasion | -20 | mod 68 = -20 | PASS |

#### Scorpion Harness (ID: 12579)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 40 | mod 1 = 40 | PASS |
| HP | +15 | mod 2 = 15 | PASS |
| Ice Resist | -20 | mod 16 (ICE_MEVA) = -20 | PASS |
| Water Resist | +15 | mod 20 (WATER_MEVA) = 15 | PASS |
| Dark Resist | +15 | mod 22 (DARK_MEVA) = 15 | PASS |
| Accuracy | +10 | mod 25 = 10 | PASS |
| Evasion | +10 | mod 68 = 10 | PASS |

#### Scorpion Harness +1 (ID: 13734)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 41 | mod 1 = 41 | PASS |
| HP | +20 | mod 2 = 20 | PASS |
| Ice Resist | -20 | mod 16 (ICE_MEVA) = -20 | PASS |
| Water Resist | +20 | mod 20 (WATER_MEVA) = 20 | PASS |
| Dark Resist | +20 | mod 22 (DARK_MEVA) = 20 | PASS |
| Accuracy | +12 | mod 25 = 12 | PASS |
| Evasion | +12 | mod 68 = 12 | PASS |

#### Vermillion Cloak (ID: 13748)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 46 | mod 1 = 46 | PASS |
| MP | +10 | mod 5 = 10 | PASS |
| MP +1% | +1% | mod 6 (MPP) = 1 | PASS |
| Evasion | -10 | mod 68 = -10 | PASS |
| Refresh | 1 MP/tick | mod 369 = 1 | PASS |

Note: "Cannot Equip Headgear" restriction is handled via equipment slot flags in item_equipment.sql (removeSlot=16 = head slot).

#### Errant Houppelande (ID: 14380)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 42 | mod 1 = 42 | PASS |
| STR | -7 | mod 8 = -7 | PASS |
| DEX | -7 | mod 9 = -7 | PASS |
| VIT | -7 | mod 10 = -7 | PASS |
| AGI | -7 | mod 11 = -7 | PASS |
| INT | +10 | mod 12 = 10 | PASS |
| MND | +10 | mod 13 = 10 | PASS |
| CHR | +10 | mod 14 = 10 | PASS |
| Enmity | -3 | mod 27 = -3 | PASS |
| MP recovered while healing | +5 | mod 71 (MPHEAL) = 5 | PASS |

#### Dalmatica (ID: 13787)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 45 | mod 1 = 45 | PASS |
| Converts HP to MP | 50 | mod 7 (CONVHPTOMP) = 50 | PASS |
| Magic Def. Bonus | +5 | mod 29 (MDEF) = 5 | PASS |
| Resist Paralyze | Enhanced | mod 242 (PARALYZERES) = 2 | PASS |
| Refresh | 1 MP/tick | mod 369 = 1 | PASS |

#### Dalmatica +1 (ID: 13788)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 46 | mod 1 = 46 | PASS |
| Converts HP to MP | 55 | mod 7 (CONVHPTOMP) = 55 | PASS |
| Magic Def. Bonus | +6 | mod 29 (MDEF) = 6 | PASS |
| Resist Paralyze | Enhanced | mod 242 (PARALYZERES) = 3 | PASS |
| Refresh | 1 MP/tick | mod 369 = 1 | PASS |

#### Noble's Tunic (ID: 12605)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 40 | mod 1 = 40 | PASS |
| MP | +17 | mod 5 = 17 | PASS |
| Refresh | 1 MP/tick | mod 369 = 1 | PASS |
| Cure Potency | +10% | mod 374 = 10 | PASS |

---

### Head Armor

#### Optical Hat (ID: 13915)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| Accuracy | +10 | mod 25 = 10 | PASS |
| Ranged Accuracy | +10 | mod 26 = 10 | PASS |
| Evasion | +10 | mod 68 = 10 | PASS |

Note: No DEF listed on bg-wiki and no DEF mod in server. Consistent.

#### Walahra Turban (ID: 15270)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| HP | +30 | mod 2 = 30 | PASS |
| MP | +30 | mod 5 = 30 | PASS |
| Haste | +5% | mod 384 (HASTE_GEAR) = 500 | PASS |

Note: Haste uses x100 scale (500 = 5%). No DEF listed on bg-wiki and no DEF mod in server.

#### Homam Zucchetto (ID: 15240)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 26 | mod 1 = 26 | PASS |
| HP | +22 | mod 2 = 22 | PASS |
| MP | +22 | mod 5 = 22 | PASS |
| Accuracy | +4 | mod 25 = 4 | PASS |
| Magic Accuracy | +4 | mod 30 (MACC) = 4 | PASS |
| Haste | +3% | mod 384 (HASTE_GEAR) = 300 | PASS |

---

### Hands

#### Dusk Gloves (ID: 12701)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 24 | mod 1 = 24 | PASS |
| HP | +20 | mod 2 = 20 | PASS |
| Attack | +5 | mod 23 = 5 | PASS |
| Movement Speed | Decreases | mod 75 (MOVE_SPEED_STACKABLE) = -5 | PASS |
| Haste | +3% | mod 384 (HASTE_GEAR) = 300 | PASS |

#### Dusk Gloves +1 (ID: 14825)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 25 | mod 1 = 25 | PASS |
| HP | +22 | mod 2 = 22 | PASS |
| Attack | +6 | mod 23 = 6 | PASS |
| Movement Speed | Decreases | mod 75 (MOVE_SPEED_STACKABLE) = -4 | PASS |
| Haste | +4% | mod 384 (HASTE_GEAR) = 400 | PASS |

---

### Legs

#### Byakko's Haidate (ID: 12818)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 42 | mod 1 = 42 | PASS |
| DEX | +15 | mod 9 = 15 | PASS |
| Lightning (Thunder) Resist | +50 | mod 19 (THUNDER_MEVA) = 50 | PASS |
| Haste | +5% | mod 384 (HASTE_GEAR) = 500 | PASS |

#### Homam Cosciales (ID: 15576)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 35 | mod 1 = 35 | PASS |
| HP | +26 | mod 2 = 26 | PASS |
| MP | +26 | mod 5 = 26 | PASS |
| Accuracy | +3 | mod 25 = 3 | PASS |
| Fast Cast | +5% | mod 170 (FASTCAST) = 5 | PASS |
| Haste | +3% | mod 384 (HASTE_GEAR) = 300 | PASS |

---

### Feet

#### Homam Gambieras (ID: 15661)

| Stat | bg-wiki | Server (item_mods.sql) | Match |
|------|---------|----------------------|-------|
| DEF | 16 | mod 1 = 16 | PASS |
| HP | +31 | mod 2 = 31 | PASS |
| MP | +31 | mod 5 = 31 | PASS |
| Accuracy | +6 | mod 25 = 6 | PASS |
| Ranged Accuracy | +6 | mod 26 = 6 | PASS |
| Haste | +3% | mod 384 (HASTE_GEAR) = 300 | PASS |
| Wyvern HP | +50 | item_mods_pet: pet_type=2 (Wyvern), mod 2 = 50 | PASS |

---

### Weapons

#### Kraken Club (ID: 17440)

| Stat | bg-wiki | Server (item_weapon.sql) | Match |
|------|---------|--------------------------|-------|
| DMG | 11 | dmg = 11 | PASS |
| Delay | 264 | delay = 264 | PASS |
| Skill | Club | skill = 11 (Club) | PASS |
| Hit count | 2-8 times | hit = 8 | PASS |

Note: The `hit` column stores the max hit count. The `getHitCount()` function in `src/map/utils/attackutils.cpp` handles the random distribution between 2 and max.

#### Mercurial Kris (ID: 18020)

| Stat | bg-wiki | Server (item_weapon.sql) | Match |
|------|---------|--------------------------|-------|
| DMG | 8 | dmg = 8 | PASS |
| Delay | 192 | delay = 192 | PASS |
| Skill | Dagger | skill = 2 (Dagger) | PASS |
| Hit count | 2-3 times | hit = 3 | PASS |

#### Joyeuse (ID: 17652)

| Stat | bg-wiki | Server | Match |
|------|---------|--------|-------|
| DMG | 35 | dmg = 35 (item_weapon.sql) | PASS |
| Delay | 224 | delay = 224 (item_weapon.sql) | PASS |
| Skill | Sword | skill = 3 (Sword) | PASS |
| Hit count | Attacks twice | hit = 2 (item_weapon.sql) | PASS |
| Dark | +14 | mod 22 (DARK_MEVA) = 14 (item_mods.sql) | PASS |

Note: bg-wiki reports a 45% activation rate for the double attack effect. The `hit=2` value enables the mechanic; activation rate is handled by `getHitCount()` in C++ source.

---

## Files Examined

- `sql/item_basic.sql` - Item ID lookup
- `sql/item_mods.sql` - All stat modifiers
- `sql/item_weapon.sql` - Weapon DMG, delay, hit count
- `sql/item_equipment.sql` - Equipment slot data
- `sql/item_mods_pet.sql` - Pet-specific modifiers (Homam Gambieras wyvern HP)
- `src/map/modifier.h` - Modifier ID definitions
- `src/map/utils/attackutils.cpp` - Multi-hit weapon logic
- `src/map/attackround.cpp` - Attack round / hit count checking
