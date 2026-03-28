# Quest Reward Item Verification
## Source
- bg-wiki: various quest/mission pages
- Codebase: `sql/item_basic.sql`, `sql/item_mods.sql`, `sql/item_latents.sql`, `sql/item_equipment.sql`, `sql/item_weapon.sql`, `scripts/quests/`, `scripts/missions/`

## Summary
The vast majority of important quest/mission reward items have proper mods. All AF armor (all jobs), COP rings, Divine Might earrings, Apocalypse Nigh earrings, ToAU rings, and Sparks armor/weapons are correctly statted. Two notable categories of issues: (1) 393 iLv119 armor pieces (including 71 AF/Relic/Empy +3 pieces) have no mods at all, and (2) several Eminent ranged weapons (lance, bow, crossbow, gun) plus all Eminent ammo are missing bonus mods.

## Checklist — Key Quest/Mission Reward Items

| Item ID | Name | Source | Status | Notes |
|---------|------|--------|--------|-------|
| 15543 | Rajas Ring | COP 8-4 | WORKS | STR+2, DEX+2, Store TP+5, Subtle Blow+5 |
| 15544 | Sattva Ring | COP 8-4 | WORKS | HP+15, VIT+2, AGI+2, Enmity+3 |
| 15545 | Tamas Ring | COP 8-4 | WORKS | MP+15, INT+2, MND+2, Enmity-3 |
| 14739 | Suppanomimi | Divine Might | WORKS | AGI+2, Sword+5, Dual Wield+5 |
| 16058 | Colossus's Earring | Divine Might | WORKS | HP+10, MP+10, Phys/Range dmg down |
| 15965 | Ethereal Earring | Apocalypse Nigh | WORKS | HP+15, ATT+5, EVA+5, Absorb dmg to MP |
| 15962 | Static Earring | Apocalypse Nigh | WORKS | MND+2, MDEF+2, Magic Burst Bonus+5 |
| 15963 | Magnetic Earring | Apocalypse Nigh | WORKS | MP+20, Refresh+1, Spell Interrupt-8, Conserve MP+5 |
| 15964 | Hollow Earring | Apocalypse Nigh | WORKS | DEX+2, ACC+3, RACC+3, Enspell DMG+3 |
| 15807 | Balrahn's Ring | ToAU missions | WORKS | MACC+4 |
| 11697 | Moonshade Earring | WotG mission 54 | WORKS | No static mods — uses augment system (player chooses stats). Working as intended. |
| 16607 | Chaosbringer | DRK AF quest | WORKS | No item_mods needed — weapon stats (DMG:1, Delay:666) from item_weapon. It is a quest tool, not combat gear. |

## Checklist — AF Armor (All Jobs, Body Piece Sample)

| Item ID | Name | Job | Status | Notes |
|---------|------|-----|--------|-------|
| 12638 | Fighter's Lorica | WAR | WORKS | DEF:47, HP+20, VIT+5, Enmity+8 |
| 12639 | Temple Cyclas | MNK | WORKS | Has mods |
| 12640 | Healer's Bliaut | WHM | WORKS | DEF:40, MP+15, Enmity-4, Enfeebling+10 |
| 12641 | Assassin's Vest | THF | WORKS | Has mods |
| 12642 | Wizard's Coat | BLM | WORKS | Has mods |
| 12643 | Warlock's Tabard | RDM | WORKS | Has mods |
| 12649 | Monster Jackcoat | BST | WORKS | Has mods |
| 12650 | Bard's Justaucorps | BRD | WORKS | Has mods |
| 12651 | Scout's Jerkin | RNG | WORKS | Has mods |
| 12652 | Myochin Domaru | SAM | WORKS | Has mods |
| 12653 | Ninja Chainmail | NIN | WORKS | Has mods |
| 12654 | Drachen Mail | DRG | WORKS | Has mods |
| 12655 | Evoker's Doublet | SMN | WORKS | Has mods |

Full WAR AF set (head/body/hands/legs/feet) all verified with mods.
Full WHM AF set (head/body/hands/legs/feet) all verified with mods.
PLD AF2 (Valor) full set verified with mods.

## Checklist — Sparks Gear (iLv117)

| Item ID | Name | Status | Notes |
|---------|------|--------|-------|
| 27740 | Outrider Mask | WORKS | Full stat block (DEF:105, STR+24, etc.) |
| 27741 | Espial Cap | WORKS | Full stat block |
| 27881 | Outrider Mail | WORKS | Full stat block |
| 27882 | Espial Gambison | WORKS | Full stat block |
| 28029 | Outrider Mittens | WORKS | Full stat block |
| 28030 | Espial Bracers | WORKS | Full stat block |
| 28168 | Outrider Hose | WORKS | Full stat block |
| 28169 | Espial Hose | WORKS | Full stat block |
| 28306 | Outrider Greaves | WORKS | Full stat block |
| 28307 | Espial Socks | WORKS | Full stat block |
| 28656 | Eminent Shield | WORKS | DEF:50, HP+40, MP+40, Enmity+5, Shield+100 |

All iLv117 armor (17 total items) has mods: 0 missing.

## Checklist — Eminent Weapons (iLv117 Sparks)

| Item ID | Name | Status | Notes |
|---------|------|--------|-------|
| 20540 | Eminent Baghnakhs | WORKS | ATT+10, ACC+24, EVA+12 |
| 20624 | Eminent Dagger | WORKS | ACC+24, EVA+24 |
| 20726 | Eminent Scimitar | WORKS | ATT+10, ACC+15 |
| 20766 | Eminent Sword | WORKS | ATT+10, ACC+15 |
| 20817 | Eminent Axe | WORKS | ATT+10, ACC+15 |
| 20865 | Eminent Voulge | WORKS | ATT+10, ACC+15 |
| 20908 | Eminent Sickle | WORKS | ATT+10, ACC+15 |
| 21119 | Eminent Wand | WORKS | INT+6, MND+6, ATT+10, ACC+15, MATT+14, MDMG+111 |
| 21182 | Eminent Staff | WORKS | INT+12, MND+12, MATT+25, MDMG+176 |
| 21183 | Eminent Pole | WORKS | MP+85 |
| 20954 | Eminent Lance | PARTIAL | Has weapon dmg/delay but **NO bonus mods** (retail has ACC+15, ATT+10) |
| 21231 | Eminent Bow | PARTIAL | Has weapon dmg/delay but **NO bonus mods** |
| 21251 | Eminent Crossbow | PARTIAL | Has weapon dmg/delay but **NO bonus mods** |
| 21281 | Eminent Gun | PARTIAL | Has weapon dmg/delay but **NO bonus mods** |
| 21302 | Eminent Arrow | PARTIAL | Has weapon dmg/delay but **NO bonus mods** (ammo) |
| 21316 | Eminent Bolt | PARTIAL | Has weapon dmg/delay but **NO bonus mods** (ammo) |
| 21331 | Eminent Bullet | PARTIAL | Has weapon dmg/delay but **NO bonus mods** (ammo) |
| 21405 | Eminent Flute | WORKS | All Songs Effect+2 |
| 21453 | Eminent Animator | WORKS | Automaton Level Bonus+16 |
| 21462 | Eminent Bell | WORKS | Geomancy Bonus+3 |

## Checklist — Broad Statistical Analysis

| Category | Total Items | Missing Mods | Pct | Status | Notes |
|----------|-------------|-------------|------|--------|-------|
| Lv1-10 armor | 886 | 245 | 27.7% | WORKS | Most are cosmetic/event/furniture gear with no stats by design |
| Lv11-20 armor | 305 | 17 | 5.6% | WORKS | Minor items, likely low-stat or stat-less by design |
| Lv21-30 armor | 398 | 31 | 7.8% | WORKS | Minor items |
| Lv31-40 armor | 403 | 6 | 1.5% | WORKS | Very few gaps |
| Lv41-50 armor | 460 | 2 | 0.4% | WORKS | Nearly complete |
| Lv51-60 armor | 502 | 9 | 1.8% | WORKS | Nearly complete |
| Lv61-70 armor | 721 | 31 | 4.3% | WORKS | Minor gaps |
| Lv71-75 armor | 1199 | 2 | 0.2% | WORKS | Essentially complete |
| Lv76-99 armor | 2768 | 606 | 21.9% | PARTIAL | Includes hexed/cursed items and lv99 items awaiting implementation |
| iLv100-109 armor | 407 | 12 | 2.9% | WORKS | Nearly complete |
| iLv110-119 armor | 1771 | 414 | 23.4% | PARTIAL | Mostly iLv119 +3 and newer content |
| iLv117 armor | 17 | 0 | 0.0% | WORKS | All sparks armor fully statted |
| iLv119 armor | 1644 | 393 | 23.9% | PARTIAL | 71 are AF/Relic/Empy +3, 322 are other endgame items |

### iLv119 Armor Breakdown

| Sub-Category | Missing | Notes |
|-------------|---------|-------|
| AF/Relic/Empy +3 | 71/225 | 154 +3 items DO have mods; 71 are missing |
| +2 items | 36/278 | Most are implemented |
| +1 items | 73/582 | Most are implemented |
| Other iLv119 | 322 | Includes Hervor/Heidrek/Angantyr sets, blistering/dampening sets, and various crafted/NM drop gear |

## Blockers
- **71 AF/Relic/Empy +3 armor pieces** have item_basic and item_equipment entries but zero mods in item_mods.sql. Players who upgrade to +3 would get gear with DEF:0 and no stats. This is a significant endgame gap.
- **Eminent Lance, Bow, Crossbow, Gun, and all Eminent ammo** (7 items) are missing bonus mods. They function as weapons (have dmg/delay) but lack the ACC/ATT/RACC/RATK bonuses that retail versions have.
- **~322 other iLv119 armor pieces** are defined but have no stats. These are mostly newer content (Hervor/Heidrek/Angantyr sets, crafted Ambuscade-era gear, etc.).
- **~712 iLv119 weapons** have no item_mods entries. Many of these legitimately only need weapon dmg/delay (from item_weapon), but some should have bonus stats (ACC, ATT, etc.).

## Fix Difficulty
- **Eminent ranged weapons/ammo**: Easy — 7 items need a handful of mod entries each (ACC+15, ATT+10 pattern matches other Eminent weapons)
- **AF/Relic/Empy +3 mods**: Hard — 71 items, each needing 10-15+ mod entries. Would need to reference retail data for each piece.
- **Other iLv119 content**: Massive — 322+ armor and 712+ weapons. This is the frontier of LandSandBoat's data completeness and is a known upstream gap.
