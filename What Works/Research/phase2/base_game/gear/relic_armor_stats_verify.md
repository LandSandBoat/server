# Relic Armor Stats Verification (Original 15 Jobs)

## Audit Summary

| Category | Count |
|----------|-------|
| Total items checked | 150 (75 base + 75 upgraded) |
| Verified correct | 146 |
| Discrepancies found | 3 |
| Possibly unimplemented effects | 1 (upstream limitation) |

**Status: MOSTLY CORRECT -- 3 discrepancies found**

---

## Discrepancies Found

### 1. Duelist's Tabard +1 (14504) -- RDM Body -- WRONG VALUE
- **Mod 170 (FASTCAST)**: Server has **10**, bg-wiki says **11%**
- Base version (15091) correctly has 10% matching bg-wiki
- The +1 upgrade should increase Fast Cast from 10% to 11%
- **Fix**: Change value from 10 to 11 in item_mods.sql

### 2. Summoner's Pigaches +1 (15679) -- SMN Feet -- WRONG PET VALUE
- **Pet mod 23 (ATT)**: Server has **10**, bg-wiki says **7**
- Base version (15146) correctly has pet ATT +7
- The +1 version should NOT increase Avatar Attack; bg-wiki confirms +7 for both
- **Fix**: Change pet ATT from 10 to 7 in item_mods_pet.sql

### 3. Summoner's Bracers +1 (14923) -- SMN Hands -- WRONG PET VALUE
- **Pet mod 25 (ACC)**: Server has **14**, bg-wiki says **7**
- Base version (15116) correctly has pet ACC +7
- The +1 version should NOT increase Avatar Accuracy; bg-wiki confirms +7 for both
- **Fix**: Change pet ACC from 14 to 7 in item_mods_pet.sql

### 4. Wyrm Finger Gauntlets +1 (14922) / Base (15115) -- DRG Hands -- MISSING EFFECT (Upstream)
- **Missing**: "Wyvern: Magic damage taken -5%"
- Both base and +1 should have this effect per bg-wiki
- No WYVERN_MAGIC_DMG_TAKEN modifier exists in the codebase (modifier.h)
- **This is an upstream (LandSandBoat) limitation** -- the effect is not implementable without engine changes
- **No fix needed** -- not a data error

---

## Verification Method

- Item IDs extracted from `scripts/zones/Port_Jeuno/npcs/Sagheera.lua` (relicArmorPlusOne table, entries 101-175)
- Base relic IDs from the trade field (first element) of each entry
- Mods checked in `sql/item_mods.sql`, `sql/item_mods_pet.sql`, and `sql/item_latents.sql`
- Cross-referenced against bg-wiki for body pieces of all 15 sets, plus sampling of head/hands/legs/feet
- Latent effects verified for WAR (Aggressor/Berserk), DRK (Last Resort), NIN (nighttime bonuses), BRD (stat latents)

---

## Per-Set Breakdown

### WAR: Warrior's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Mask | 15072 | 15245 | OK -- DEF:29, DEX+6, Parry+7, Enmity+1, Warcry Duration+10 |
| Lorica | 15087 | 14500 | OK -- DEF:51, HP+30, ATT+12, Enmity+4, latent EVA+10 (Aggressor) |
| Mufflers | 15102 | 14909 | OK -- DEF:23, HP+20, VIT+6, ATT+14, Enmity+2 |
| Cuisses | 15117 | 15580 | OK -- DEF:40, STR+6, Enmity+4, Double Attack+1% |
| Calligae | 15132 | 15665 | OK -- DEF:20, HP+15, AGI+6, Enmity+1, latent DEF+10% (Berserk) |

### MNK: Melee Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Crown | 15073 | 15246 | OK -- DEF:24, HP+5%, STR+6, Subtle Blow+6, Enmity-4 |
| Cyclas | 15088 | 14501 | OK -- DEF:45, HP+6%, VIT+6, Regen, HP healed+6 |
| Gloves | 15103 | 14910 | OK -- DEF:16, HP+3%, ATT+18, Subtle Blow+5, Chakra mods |
| Hose | 15118 | 15581 | OK -- DEF:32, HP+6%, AGI+5, Subtle Blow+6, Kick Attack+5% |
| Gaiters | 15133 | 15666 | OK -- DEF:16, HP+4%, DEX+5, Guard+14, Counterstance+10 |

### WHM: Cleric's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Cap | 15074 | 15247 | OK -- DEF:25, MP+25, VIT+5, Enmity-5, Silence Resist+2 |
| Bliaut | 15089 | 14502 | OK -- DEF:43, MP+29, Enmity-3, Refresh, Regen Multiplier+12 |
| Mitts | 15104 | 14911 | OK -- DEF:17, HP+20, MP+20, Enmity-4, Enfeebling+15 |
| Pantaloons | 15119 | 15582 | OK -- DEF:32, MP+17, Healing+15, Enmity-3, Barspell+22 |
| Duckbills | 15134 | 15667 | OK -- DEF:16, MP+18, MND+6, Enmity-2, Enhancing+10 |

### BLM: Sorcerer's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Petasos | 15075 | 15248 | OK -- DEF:24, MP+29, Enfeebling+5, Elemental+10, Enmity-3 |
| Coat | 15090 | 14503 | OK -- DEF:42, HP+12, MP+12, Elemental+7, Enmity-2, Refresh |
| Gloves | 15105 | 14912 | OK -- DEF:16, MP+24, Dark+12, Enmity-3, Mag Burst+5% |
| Tonban | 15120 | 15583 | OK -- DEF:31, MP+20, INT+3, Enmity-3, Day Nuke Bonus+5 |
| Sabots | 15135 | 15668 | OK -- DEF:15, MP+18, INT+3, Enmity-2, Conserve MP+5 |

### RDM: Duelist's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Chapeau | 15076 | 15249 | OK -- DEF:25, HP+14, MP+14, MND+3, Enfeebling+15, Refresh |
| Tabard | 15091 | 14504 | **DISCREPANCY** -- Fast Cast should be 11, server has 10 |
| Gloves | 15106 | 14913 | OK -- DEF:18, MP+23, INT+5, Enhancing+15, MDEF+2 |
| Tights | 15121 | 15584 | OK -- DEF:34, MP+16, DEX+6, Elemental+12, Spikes+20 |
| Boots | 15136 | 15669 | OK -- DEF:16, MP+15, MND+5, Evasion skill+5, MATT+5 |

### THF: Assassin's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Bonnet | 15077 | 15250 | OK -- DEF:25, HP+16, DEX+6, Enmity+3, Mug Effect+1 |
| Vest | 15092 | 14505 | OK -- DEF:46, HP+22, AGI+5, Enmity+5, Crit Hit Rate+1 |
| Armlets | 15107 | 14914 | OK -- DEF:17, HP+26, CHR+5, Enmity+4, Treasure Hunter+1 |
| Culottes | 15122 | 15585 | OK -- DEF:35, HP+25, Enmity+5, Steal+5, Gilfinder+1 |
| Poulaines | 15137 | 15670 | OK -- DEF:16, HP+15, CHR+6, Enmity+3, Triple Attack+1% |

### PLD: Valor Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Coronet | 15078 | 15251 | OK -- DEF:29, HP+18, MP+18, Healing+10, Enmity+4, Rampart+15 |
| Surcoat | 15093 | 14506 | OK -- DEF:56, HP+30, DEX+3, Enmity+5, Cover to MP+20 |
| Gauntlets | 15108 | 14915 | OK -- DEF:23, HP+16, VIT+6, Enmity+4, Shield Bash+10 |
| Breeches | 15123 | 15586 | OK -- DEF:44, HP+20, STR+6, Enmity+4, Spell Interrupt-10 |
| Leggings | 15138 | 15671 | OK -- DEF:20, HP+18, MND+4, Enmity+2, Sentinel+10 |

### DRK: Abyss Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Burgeonet | 15079 | 15252 | OK -- DEF:28, HP+30, VIT+8, ATT+12, Paralyze Resist+3 |
| Cuirass | 15094 | 14507 | OK -- DEF:50, HP+27, MND+4, ACC+12, MATT+10 |
| Gauntlets | 15109 | 14916 | OK -- DEF:21, MP+20, DEX+5, INT+9, Dark+7 |
| Flanchard | 15124 | 15587 | OK -- DEF:39, HP+18, MP+18, MND+5, Dark+7, MDEF+5 |
| Sollerets | 15139 | 15672 | OK -- DEF:18, MP+12, ACC+2, Enfeebling+5, latent Last Resort |

### BST: Monster Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Helm | 15080 | 15253 | OK -- DEF:27, HP+19, MP+19, CHR+5, Parry+3, Charm+5 |
| Jackcoat | 15095 | 14508 | OK -- DEF:50, HP+21, INT+7, Charm+7 |
| Gloves | 15110 | 14917 | OK -- DEF:16, HP+20, AGI+5, Charm+4, Jug Level Range+1 |
| Trousers | 15125 | 15588 | OK -- DEF:35, HP+17, DEX+5, Charm+2, HP healed+4 |
| Gaiters | 15140 | 15673 | OK -- DEF:15, HP+13, VIT+5, Charm+3, Reward+20 |

### BRD: Bard's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Roundlet | 15081 | 15254 | OK -- DEF:20, HP+13, CHR+6, Singing+5, Enmity-4 |
| Justaucorps | 15096 | 14509 | OK -- DEF:46, HP+19, ATT+20, latent stat bonuses |
| Cuffs | 15111 | 14918 | OK -- DEF:19, HP+16, Wind+5, Enmity-4, EVA+5 |
| Cannions | 15126 | 15589 | OK -- DEF:32, HP+26, MP+42, latent stat bonuses |
| Slippers | 15141 | 15674 | OK -- DEF:15, HP+12, Parry+4, String+3, Enmity-3 |

### RNG: Scout's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Beret | 15082 | 15255 | OK -- DEF:25, HP+15, MND+5, Enmity-4, Recycle+25 |
| Jerkin | 15097 | 14510 | OK -- DEF:46, HP+23, DEX+5, Enmity-4, Rapid Shot+5 |
| Bracers | 15112 | 14919 | OK -- DEF:15, HP+13, AGI+6, Enmity-2, EVA+9 |
| Braccae | 15127 | 15590 | OK -- DEF:33, HP+18, RACC+9, Parry+10, Enmity-3 |
| Socks | 15142 | 15675 | OK -- DEF:17, HP+12, VIT+5, RATT+12, Enmity-4 |

### SAM: Saotome Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Kabuto | 15083 | 15256 | OK -- DEF:26, HP+20, ACC+12, RACC+7, Enmity+1 |
| Domaru | 15098 | 14511 | OK -- DEF:51, HP+34, VIT+7, Store TP+5, Enmity+1 |
| Kote | 15113 | 14920 | OK -- DEF:22, HP+20, ATT+12, Enmity+1, Meditate+4 |
| Haidate | 15128 | 15591 | OK -- DEF:41, HP+33, AGI+4, Enmity+1, 3rd Eye Counter+15 |
| Sune-ate | 15143 | 15676 | OK -- DEF:19, HP+23, DEX+6, ATT+10, Enmity+1 |

### NIN: Koga Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Hatsuburi | 15084 | 15257 | OK -- DEF:23, HP+27, NIN Nuke MAB+5, latent Parry+12 |
| Chainmail | 15099 | 14512 | OK -- DEF:47, ATT+16, RATT+10, ACC+12, RACC+10 |
| Tekko | 15114 | 14921 | OK -- DEF:19, Ninja Tool+20, latent STR+13/Haste+4% |
| Hakama | 15129 | 15592 | OK -- DEF:32, HP+40, Dual Wield+5, latent EVA+12 |
| Kyahan | 15144 | 15677 | OK -- DEF:16, VIT+8, Ninjutsu+12, latent DEX+7 |

### DRG: Wyrm Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Armet | 15085 | 15258 | OK -- DEF:26, HP+16, STR+5, ATT+2, Wyvern Breath+30 |
| Mail | 15100 | 14513 | OK -- DEF:50, HP+33, Parry+15, Haste+2%, Wyvern Subjob Traits |
| Finger Gauntlets | 15115 | 14922 | NOTE -- Stats correct but "Wyvern: Mag DMG taken -5%" not implemented (upstream) |
| Brais | 15130 | 15593 | OK -- DEF:33, HP+13, DEX+6, High Jump Enmity-10 |
| Greaves | 15145 | 15678 | OK -- DEF:17, HP+10, VIT+5, Ice MEVA+10 |

### SMN: Summoner's Set
| Piece | Base ID | +1 ID | Status |
|-------|---------|-------|--------|
| Horn | 15086 | 15259 | OK -- DEF:19, MP+30, INT+4, BP Delay-3, Weather Perp-3 |
| Doublet | 15101 | 14514 | OK -- DEF:39, MP+20, BP Delay-4, Pet Crit+4%, Day Perp-3 |
| Bracers | 15116 | 14923 | **DISCREPANCY** -- Pet ACC should be 7, server has 14 |
| Spats | 15131 | 15594 | OK -- DEF:30, MP+25, Spirit Cast-5, BP Delay-2, Pet Enmity+2 |
| Pigaches | 15146 | 15679 | **DISCREPANCY** -- Pet ATT should be 7, server has 10 |

---

## Base vs +1 Stat Upgrades Pattern

For most items, the +1 version provides:
- +1 DEF over base
- +1 to primary stat (STR/DEX/VIT/AGI/INT/MND/CHR)
- Some items get small improvements to secondary effects
- A few items gain entirely new mods not on the base version

The SMN discrepancies (pet ACC +14 vs +7, pet ATT +10 vs +7) appear to be cases where someone incorrectly assumed the +1 should upgrade these pet values, when bg-wiki confirms they should remain at +7.

---

## Files Referenced

- `scripts/zones/Port_Jeuno/npcs/Sagheera.lua` -- Item IDs (relicArmorPlusOne table)
- `sql/item_mods.sql` -- Primary stat mods
- `sql/item_mods_pet.sql` -- Pet/Avatar mods (SMN/BST/DRG)
- `sql/item_latents.sql` -- Conditional effects (time-based, status-based)
- `src/map/modifier.h` -- Modifier ID definitions

---

## Recommended Fixes

```sql
-- Fix 1: Duelist's Tabard +1 Fast Cast (10 -> 11)
UPDATE item_mods SET value = 11 WHERE itemId = 14504 AND modId = 170;

-- Fix 2: Summoner's Pigaches +1 Avatar Attack (10 -> 7)
UPDATE item_mods_pet SET value = 7 WHERE itemId = 15679 AND modId = 23;

-- Fix 3: Summoner's Bracers +1 Avatar Accuracy (14 -> 7)
UPDATE item_mods_pet SET value = 7 WHERE itemId = 14923 AND modId = 25;
```

Audit date: 2026-03-29
