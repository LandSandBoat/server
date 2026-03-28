# Common Gear Stats Audit

## Source
- bg-wiki: individual item pages (URLs below)
- Codebase: `sql/item_mods.sql`, `sql/item_weapon.sql`, `sql/item_equipment.sql`, `sql/item_latents.sql`, `scripts/globals/gear_sets.lua`

## Summary
Most popular 75-era accessories and armor have correct stats. Several issues found with **Eminent (iLvl 117) weapons** having latent effects coded as permanent base mods or missing entirely, one stat mismatch on **Weatherspoon Robe** (MATT vs Magic Damage), a minor EVA error on **Weatherspoon Pants**, and relic weapons having incorrect hidden effect proc rates and damage multipliers.

---

## 1. Popular Accessories (Rings/Earrings/Belts)

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Rajas Ring | 15543 | STR+2~5, DEX+2~5, Store TP+5, Subtle Blow+5 | STR+2, DEX+2, Store TP+5, Subtle Blow+5 | WORKS | Level-scaling (2~5) not audited; base values correct |
| Tamas Ring | 15545 | MP+15~30, INT+2~5, MND+2~5, Enmity-3 | MP+15, INT+2, MND+2, Enmity-3 | WORKS | Level-scaling (2~5) not audited; base values correct |
| Sattva Ring | 15544 | HP+15~30, VIT+2~5, AGI+2~5, Enmity+3 | HP+15, VIT+2, AGI+2, Enmity+3 | WORKS | Level-scaling (2~5) not audited; base values correct |
| Suppanomimi | 14739 | AGI+2, Sword Skill+5, Dual Wield+5 | AGI+2, Sword+5, Dual Wield+5 | WORKS | |
| Colossus's Earring | 16058 | HP+10, MP+10, PDT-1% (2/256), PDT-2% under Light weather | HP+10, MP+10, DMGPHYS-100, DMGRANGE-100; latent: DMGPHYS-100/DMGRANGE-100 under Light weather | WORKS | Light weather latent present in item_latents.sql |
| Sniper's Ring | 13280 | DEF-10, Dark Resist-20, ACC+5, RACC+5 | DEF-10, Dark Resist-20, ACC+5, RACC+5 | WORKS | |
| Sniper's Ring +1 | 13281 | DEF-12, Dark Resist-25, ACC+7, RACC+7 | DEF-12, Dark Resist-25, ACC+7, RACC+7 | WORKS | |
| Woodsman Ring | 14675 | ACC+5, RACC+5, EVA-5 | ACC+5, RACC+5, EVA-5 | WORKS | |
| Swift Belt | 15457 | ACC+3, ATT-5, Haste+4% | ACC+3, ATT-5, Haste 400 (=3.9%) | WORKS | 400/1024 = 3.9%, retail 10/256 = 3.9% |
| Speed Belt | 13189 | Haste+6% | Haste 600 (=5.86%) | WORKS | 600/1024 = 5.86%, retail 15/256 = 5.86% |
| Velocious Belt | 15899 | Haste+6% | Haste 600 (=5.86%) | WORKS | Same encoding as Speed Belt |
| Defending Ring | 13566 | Damage Taken -10% (26/256) | DMG -1000 (mod 160) | WORKS | -1000 = -10% in LSB encoding |
| Serket Ring | 13552 | DEF+3, Converts 50 HP to MP | DEF+3, CONVHPTOMP+50 | WORKS | |
| Astral Ring | 13548 | Converts 25 HP to MP | CONVHPTOMP+25 | WORKS | |
| Peacock Charm | 13056 | Dark Resist-10, ACC+10, RACC+10 | Dark Resist-10, ACC+10, RACC+10 | WORKS | |

---

## 2. Popular Weapons/Armor (Lv75 Era)

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Ridill | 16555 | DMG:40, Delay:236, Attacks 2-3 times | DMG:40, Delay:236, Hit:3 (item_weapon) | WORKS | Multi-hit via hit count column, no additional mods needed |
| Kraken Club | 17440 | DMG:11, Delay:264, Attacks 2-8 times | DMG:11, Delay:264, Hit:8 (item_weapon) | WORKS | Multi-hit via hit count column |
| Mercurial Kris | 18020 | DMG:8, Delay:192, Attacks 2-3 times | DMG:8, Delay:192, Hit:3 (item_weapon) | WORKS | Multi-hit via hit count column |
| Haubergeon | 12555 | DEF:45, STR+5, DEX+5, AGI-5, ATT+10, ACC+10, EVA-20 | DEF:45, STR+5, DEX+5, AGI-5, ATT+10, ACC+10, EVA-20 | WORKS | |
| Haubergeon +1 | 13735 | DEF:46, STR+6, DEX+6, AGI-5, ATT+12, ACC+12, EVA-20 | DEF:46, STR+6, DEX+6, AGI-5, ATT+12, ACC+12, EVA-20 | WORKS | |
| Scorpion Harness | 12579 | DEF:40, HP+15, Ice-20, Water+15, Dark+15, ACC+10, EVA+10 | DEF:40, HP+15, Ice-20, Water+15, Dark+15, ACC+10, EVA+10 | WORKS | |
| Scorpion Harness +1 | 13734 | DEF:41, HP+20, Ice-20, Water+20, Dark+20, ACC+12, EVA+12 | DEF:41, HP+20, Ice-20, Water+20, Dark+20, ACC+12, EVA+12 | WORKS | |
| Optical Hat | 13915 | ACC+10, RACC+10, EVA+10 | ACC+10, RACC+10, EVA+10 | WORKS | |

---

## 3. iLvl 117 Eminent Gear (Sparks Vendor)

### Eminent Weapons

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Eminent Dagger | 20624 | DMG:85, Delay:183, ACC+24, EVA+24; Latent(TP<1000): DMG:89, ACC+39, ATT+10 | Base: ACC+24, EVA+24; Latent: ATT+10, ACC+39, DMG_RATING+89 | PARTIAL | **Latent DMG_RATING value 89 is wrong -- should be +4 (85+4=89), not +89 (85+89=174)** |
| Eminent Scimitar | 20726 | DMG:122, Delay:264; Latent(TP<1000): DMG:128, ACC+15, ATT+10 | Base: ATT+10, ACC+15; Latent: ATT+10, ACC+15, DMG_RATING+6 | PARTIAL | **ATT+10 and ACC+15 are in BOTH item_mods (permanent) AND item_latents -- should be latent ONLY. Double-counting when TP<1000.** |
| Eminent Sword | 20766 | DMG:199, Delay:430; Latent(TP<1000): DMG:209, ACC+15, ATT+10 | Base: ATT+10, ACC+15 (permanent in item_mods); NO latent entries | PARTIAL | **ATT+10, ACC+15 should be latent, not permanent. Missing latent entries entirely. Missing DMG boost latent.** |
| Eminent Wand | 21119 | DMG:134, Delay:288, INT+6, MND+6, MATT+14, MagicDmg+111; Latent(TP<1000): DMG:141, ACC+15, ATT+10 | Base: INT+6, MND+6, ATT+10, ACC+15, MATT+14, MAGIC_DAMAGE+111; NO latent entries | PARTIAL | **ATT+10, ACC+15 should be latent, not permanent. Missing latent entries entirely. Missing DMG boost latent.** |
| Eminent Staff | 21182 | DMG:170, Delay:366, INT+12, MND+12, MATT+25, MagicDmg+176; Latent(TP<1000): MACC+10, MagicDmg:185 | Base: INT+12, MND+12, MATT+25, MAGIC_DAMAGE+176; NO latent entries | PARTIAL | **Missing latent entries (MACC+10, MAGIC_DAMAGE boost). Base mods are correct.** |
| Eminent Lance | 20954 | DMG:227, Delay:492; Latent(TP<1000): DMG:239, ACC+15, ATT+10 | DMG:227, Delay:492 in item_weapon; NO mods, NO latent entries | PARTIAL | **Missing latent entries entirely (ACC+15, ATT+10, DMG boost).** |
| Eminent Bow | 21231 | DMG:263, Delay:720; Latent(TP<1000): DMG:277, RACC+15, RATT+10 | DMG:263, Delay:720 in item_weapon; NO mods, NO latent entries | PARTIAL | **Missing latent entries entirely (RACC+15, RATT+10, DMG boost).** |
| Eminent Gun | 21281 | DMG:97, Delay:600; Latent(TP<1000): DMG:102, RACC+15, RATT+10 | DMG:97, Delay:600 in item_weapon; NO mods, NO latent entries | PARTIAL | **Missing latent entries entirely (RACC+15, RATT+10, DMG boost).** |

### Outrider Armor Set (Melee)

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Outrider Mask | 27740 | DEF:105, HP+34, MP+22, STR+24, DEX+20, VIT+22, AGI+20, INT+19, MND+19, CHR+19, ATT+5, MDEF+2, MEVA+40, EVA+29, Haste+7% | All match | WORKS | Set bonus (PDT-10%) defined in gear_sets.lua |
| Outrider Mail | 27881 | DEF:133, HP+55, MP+42, STR+26, DEX+20, VIT+25, AGI+20, INT+20, MND+20, CHR+20, ATT+6, MDEF+3, MEVA+50, EVA+37, Haste+3% | All match | WORKS | |
| Outrider Mittens | 28029 | DEF:94, HP+24, STR+6, DEX+28, VIT+29, AGI+7, INT+9, MND+25, CHR+19, ATT+4, MDEF+1, MEVA+25, EVA+19, Haste+4% | All match | WORKS | |
| Outrider Hose | 28168 | DEF:116, HP+44, STR+31, VIT+19, AGI+14, INT+25, MND+15, CHR+12, ATT+4, MDEF+2, MEVA+70, EVA+19, Haste+5% | All match | WORKS | |
| Outrider Greaves | 28306 | DEF:77, HP+14, STR+14, DEX+17, VIT+14, AGI+30, MND+9, CHR+25, ATT+4, MDEF+2, MEVA+70, EVA+46, Haste+3% | All match | WORKS | |

### Espial Armor Set (DEX)

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Espial Cap | 27741 | DEF:94, HP+32, MP+17, STR+20, DEX+22, VIT+20, AGI+22, INT+20, MND+20, CHR+20, ACC+5, MDEF+3, MEVA+40, EVA+37, Haste+7% | All match | WORKS | Set bonus (Crit Rate +10%) in gear_sets.lua |
| Espial Gambison | 27882 | DEF:122, HP+53, MP+28, STR+22, DEX+27, VIT+21, AGI+27, INT+22, MND+22, CHR+22, ACC+6, MDEF+5, MEVA+60, EVA+49, Haste+3% | All match | WORKS | |
| Espial Bracers | 28030 | DEF:82, HP+22, MP+8, STR+7, DEX+33, VIT+25, AGI+8, INT+10, MND+28, CHR+16, ACC+4, MDEF+2, MEVA+25, EVA+24, Haste+4% | All match | WORKS | |
| Espial Hose | 28169 | DEF:105, HP+42, MP+14, STR+27, VIT+14, AGI+21, INT+28, MND+16, ACC+5, MDEF+5, MEVA+90, EVA+39, Haste+5% | All match | WORKS | |
| Espial Socks | 28307 | DEF:65, HP+12, MP+8, STR+10, DEX+20, VIT+10, AGI+33, MND+10, CHR+26, ACC+4, MDEF+3, MEVA+90, EVA+69, Haste+3% | All match | WORKS | |

### Weatherspoon Armor Set (Mage)

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Weatherspoon Corona | 27763 | DEF:60, HP+21, MP+35, INT+17, MND+17, CHR+17, MACC+10, MDEF+1, MEVA+43, EVA+10, Haste+5% | All match | WORKS | |
| Weatherspoon Robe | 27909 | DEF:78, HP+17, MP+46, STR+16, DEX+16, VIT+16, AGI+16, INT+20, MND+20, CHR+20, **Magic Damage+10**, MDEF+2, MEVA+47, EVA+12, Haste+2% | Server has **MATT+10 (mod 28)** instead of **MAGIC_DAMAGE+10 (mod 311)** | **MISMATCH** | **Wrong mod type: should be MAGIC_DAMAGE (311), not MATT (28). These are different stats.** |
| Weatherspoon Cuffs | 28048 | DEF:52, HP+22, MP+26, STR+3, DEX+14, VIT+13, AGI+2, INT+10, MND+17, CHR+10, Cure Potency+8%, MDEF+1, MEVA+21, EVA+6, Haste+3% | All match (Cure Potency = mod 374=8) | WORKS | |
| Weatherspoon Pants | 28190 | DEF:67, HP+23, MP+33, STR+13, VIT+6, AGI+9, INT+18, MND+12, CHR+10, Enmity-5, MDEF+2, MEVA+62, **EVA+8**, Haste+3% | Server has **EVA+9** (mod 68=9) | **MISMATCH** | **EVA should be 8, not 9.** |
| Weatherspoon Souliers | 28329 | DEF:41, HP+20, MP+27, STR+5, DEX+6, VIT+5, AGI+17, INT+9, MND+10, CHR+18, MATT+10, MDEF+1, MEVA+62, EVA+16, Haste+3% | All match | WORKS | |

---

## 4. Relic Weapons (Base 75 Versions)

| Item | ID | bg-wiki Stats | Server Mods | Match? | Issues |
|------|-----|---------------|-------------|--------|--------|
| Mandau | 18270 | DMG:39, Delay:176, ATT+20; Add.Effect: Poison (10/tick); Hidden: 5% triple dmg; WS: Mercy Stroke; Aftermath: Crit Rate+5% | DMG:39, Delay:176, ATT+20, Aftermath type 2, WS 26, Poison add.effect, EXTRA_DMG_CHANCE=50 (5%), OCC_DO_EXTRA_DMG=300 (3x) | WORKS | All values match bg-wiki |
| Ragnarok | 18282 | DMG:86, Delay:431, ACC+20, Crit Rate+5%; Hidden: **7%** chance **2.5x** dmg; WS: Scourge | ACC+20, Crit+5, EXTRA_DMG_CHANCE=**50** (5%), OCC_DO_EXTRA_DMG=250 (2.5x) | **MISMATCH** | **Hidden effect proc rate wrong: server=5% (50), should be 7% (70).** |
| Apocalypse | 18306 | DMG:103, Delay:513, ACC+20; Add.Effect: Blind; Hidden: **8%** chance **2x** dmg; WS: Catastrophe; Aftermath: Haste+10% | ACC+20, Blind add.effect, EXTRA_DMG_CHANCE=**50** (5%), OCC_DO_EXTRA_DMG=200 (2x) | **MISMATCH** | **Hidden effect proc rate wrong: server=5% (50), should be 8% (80).** |
| Gungnir | 18300 | DMG:100, Delay:492, ACC+20; Add.Effect: Def Down; Hidden: **7%** chance **2.5x** dmg; WS: Geirskogul; Aftermath: Shock Spikes | ACC+20, Def Down add.effect, EXTRA_DMG_CHANCE=**50** (5%), OCC_DO_EXTRA_DMG=**200** (2x) | **MISMATCH** | **Two issues: (1) Proc rate wrong: server=5% (50), should be 7% (70). (2) Damage multiplier wrong: server=2x (200), should be 2.5x (250).** |

---

## Critical Issues Summary

### HIGH Priority (gameplay-affecting mismatches)

1. **Eminent Weapons - Latent Effects Miscoded (6 weapons affected)**
   - Files: `sql/item_mods.sql`, `sql/item_latents.sql`
   - Eminent Sword (20766), Eminent Wand (21119): ATT+10/ACC+15 are permanent base mods but should be latent (TP<1000) only. Missing latent entries and DMG boost latent.
   - Eminent Scimitar (20726): ATT+10/ACC+15 exist in BOTH item_mods AND item_latents, causing double-counting when latent is active.
   - Eminent Lance (20954), Eminent Bow (21231), Eminent Gun (21281): Missing latent entries entirely (no ACC/ATT/RACC/RATT boost when TP<1000).
   - Eminent Dagger (20624): Latent DMG_RATING value may be too high (89 instead of 4).
   - Eminent Staff (21182): Missing latent entries (MACC+10, Magic Damage boost).

2. **Relic Weapon Hidden Effect Proc Rates (3 weapons affected)**
   - File: `sql/item_mods.sql`
   - Ragnarok (18282): EXTRA_DMG_CHANCE should be 70 (7%), is 50 (5%)
   - Apocalypse (18306): EXTRA_DMG_CHANCE should be 80 (8%), is 50 (5%)
   - Gungnir (18300): EXTRA_DMG_CHANCE should be 70 (7%), is 50 (5%); OCC_DO_EXTRA_DMG should be 250 (2.5x), is 200 (2x)

3. **Weatherspoon Robe (27909) - Wrong Mod Type**
   - File: `sql/item_mods.sql`
   - Has MATT (mod 28) = 10, should be MAGIC_DAMAGE (mod 311) = 10
   - Magic Attack Bonus and Magic Damage are different stats that affect spell damage calculations differently

### LOW Priority

4. **Weatherspoon Pants (28190) - Minor EVA Error**
   - File: `sql/item_mods.sql`
   - EVA (mod 68) = 9, should be 8 per bg-wiki

---

## Blockers
- Eminent weapon latent issues affect the primary sparks vendor weapons that most players will use at level 99
- Relic weapon proc rates are important for endgame melee DPS

## Fix Difficulty
- Eminent weapon latent fixes: **Medium** (need to move mods from item_mods.sql to item_latents.sql and add missing entries)
- Relic proc rate fixes: **Easy** (change single values in item_mods.sql)
- Weatherspoon Robe mod type: **Easy** (change modId from 28 to 311)
- Weatherspoon Pants EVA: **Easy** (change value from 9 to 8)
