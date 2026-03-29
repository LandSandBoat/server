# Weapon Additional Effects Verification Audit

**Date:** 2026-03-29
**Auditor:** Claude Opus 4.6
**Source of Truth:** bg-wiki.com, server SQL (`sql/item_mods.sql`), server C++ (`src/map/utils/attackutils.cpp`), server Lua scripts

---

## AUDIT_PLAN

| Phase | Task | Status |
|-------|------|--------|
| 1 | Identify all weapons with ADDEFFECT mods | DONE |
| 2 | Verify relic weapon additional effects vs bg-wiki | DONE |
| 3 | Verify relic hidden effects (occ extra dmg) vs bg-wiki | DONE |
| 4 | Check ADDEFFECT_SCRIPTED weapons for script existence | DONE |
| 5 | Find weapons with TYPE but no CHANCE (never proc) | DONE |
| 6 | Find weapons with STATUS but no DURATION (0-second debuff) | DONE |
| 7 | Verify aftermath effects in aftermath.lua | DONE |

---

## Summary Statistics

| Metric | Count |
|--------|-------|
| Items with ADDEFFECT_TYPE (mod 431) | 347 |
| Items with ADDEFFECT_CHANCE (mod 501) | 274 |
| Items with TYPE but NO CHANCE (broken) | 119 |
| Items with CHANCE but NO TYPE (spikes/armor - OK) | 46 |
| Items with STATUS but NO DURATION | 2 |
| Items with ADDEFFECT_SCRIPTED (mod 1181) | 10 |
| Total discrepancies found | 28+ |

---

## CRITICAL: Items with ADDEFFECT_TYPE but NO ADDEFFECT_CHANCE

**Impact:** These weapons will NEVER proc their additional effect. In `scripts/globals/additional_effects.lua` line 637: `if math.random(1, 100) > params.chance then return 0, 0, 0 end` -- when chance is 0, this always returns early.

### Non-Relic Weapons Missing CHANCE (Confirmed Bugs)

These weapons have additional effect data configured but will never activate:

| Item ID | Name | Type | Has DMG/Element | Issue |
|---------|------|------|-----------------|-------|
| 20672 | Ice Brand | DAMAGE (1) | DMG=20, Element=Ice(2) | **Missing CHANCE - never procs** |
| 20673 | Flametongue | DAMAGE (1) | DMG=20, Element=Fire(1) | **Missing CHANCE - never procs** |
| 21570 | Air Knife | DAMAGE (1) | DMG=20, Element=Wind(3) | **Missing CHANCE - never procs** |
| 20611 | Sangarius | HP_DRAIN (5) | None | **Missing CHANCE - HP drain never procs** |
| 20612 | Sangarius +1 | HP_DRAIN (5) | None | **Missing CHANCE - HP drain never procs** |
| 20723 | Dija Sword | TP_DRAIN (7) | None | **Missing CHANCE - TP drain never procs** |
| 20724 | Dija Sword +1 | TP_DRAIN (7) | None | **Missing CHANCE - TP drain never procs** |
| 19796 | Rosschinder | DEBUFF (2) | STATUS=4(Paralyze), DUR=30 | **Missing CHANCE and POWER** |
| 19797 | Rosschinder +1 | DEBUFF (2) | STATUS=4(Paralyze), DUR=30 | **Missing CHANCE and POWER** |
| 20640 | Nitric Baselard | DEBUFF (2) | STATUS=2(Sleep!), PWR=19, DUR=180 | **Missing CHANCE + WRONG STATUS (see below)** |
| 17750 | Anthos Xiphos | DAMAGE (1) | None | Placeholder/incomplete |
| 18696 | Paralysis Arrow | DAMAGE (1) | None | Placeholder/incomplete |
| 18762 | Custodes | DAMAGE (1) | None | Placeholder/incomplete |
| 18784 | Metasoma Katars | DAMAGE (1) | None | Placeholder/incomplete |
| 18785 | Grotesque Cesti | DAMAGE (1) | None | Placeholder/incomplete |
| 18810 | Cadushi Grip | DAMAGE (1) | None | Placeholder/incomplete |
| 19132 | Twilight Knife | DAMAGE (1) | None | Placeholder/incomplete |
| 19140 | Mantodea Harpe | DAMAGE (1) | None | Placeholder/incomplete |
| 19196 | Darkling Bolt | DAMAGE (1) | None | Placeholder/incomplete |
| 19261 | Jinx Discus | DAMAGE (1) | None | Placeholder/incomplete |
| 19296 | Ban | DAMAGE (1) | None | Placeholder/incomplete |
| 19315 | Erebus's Lance | DAMAGE (1) | None | Placeholder/incomplete |
| 19316 | Fetter Lance | DAMAGE (1) | None | Placeholder/incomplete |
| 20609 | Jugo Kukri +1 | DAMAGE (1) | None | Placeholder/incomplete |
| 20858 | Lightreaver | DAMAGE (1) | None | Placeholder/incomplete |
| 20904 | Cronus | DAMAGE (1) | None | Placeholder/incomplete |
| 21102 | Mafic Cudgel | DAMAGE (1) | None | Placeholder/incomplete |
| 21166 | Staccato Staff | DAMAGE (1) | None | Placeholder/incomplete |

### Relic 80/85/90/95/99/119 Weapons Missing Additional Effects

All relic weapons at level 80+ have `ADDEFFECT_TYPE=1` (DAMAGE) but **no CHANCE, STATUS, DURATION, or POWER mods**. bg-wiki confirms these weapons should retain the same additional effects as the level 75 versions. **This means 90 relic weapon upgrades are missing their signature proc effects** (only the hidden multiplier damage works).

Affected weapons (80/85/90/95 for each):
- Mandau (18271, 18638, 18652, 18666) -- should have Poison
- Guttler (18289, 18641, 18655, 18669) -- should have Choke
- Bravura (18295, 18642, 18656, 18670) -- should have Evasion Down
- Gungnir (18301, 18643, 18657, 18671) -- should have Defense Down
- Apocalypse (18307, 18644, 18658, 18672) -- should have Blind
- Kikoku (18313, 18645, 18659, 18673) -- should have Paralysis
- Amanomurakumo (18319, 18646, 18660, 18674) -- should have Attack Down
- Mjollnir (18325, 18647, 18661, 18675) -- should have MP Recover
- Claustrum (18331, 18648, 18662, 18676) -- should have Dispel

Also affected (99 versions): 19747, 19750-19757, 19840, 19843-19850
Also affected (119 versions): 20555, 20556, 20583, 20790, 20791, 20835, 20836, 20858, 20880, 20881, 20904, 20925, 20926, 20970, 20971, 21015, 21016, 21060, 21061, 21077, 21135, 21136, 21750, 21756, 21808, 21857, 21906, 21954, 22060

---

## CRITICAL: Nitric Baselard Wrong Status Effect

| Item ID | Name | Server Status | Server Meaning | bg-wiki Effect | Correct Status ID |
|---------|------|---------------|----------------|----------------|-------------------|
| 20640 | Nitric Baselard | 951=2 | SLEEP | Defense Down | 149 (DEFENSE_DOWN) |

**bg-wiki says:** "Weakens defense" (Defense Down), 48/256 (~18.75%) proc rate, 3 minutes duration
**Server has:** STATUS=2 (SLEEP!), POWER=19, DURATION=180, NO CHANCE
**Bugs:** (1) Wrong status effect - applies Sleep instead of Defense Down. (2) Missing CHANCE mod entirely.

---

## Items with ADDEFFECT_STATUS but NO ADDEFFECT_DURATION

| Item ID | Name | Status ID | Meaning | Issue |
|---------|------|-----------|---------|-------|
| 18551 | Twilight Scythe | 19 | SLEEP_II | **Duration defaults to 0 - sleep lasts 0 seconds** |
| 18566 | Crepuscular Scythe | 19 | SLEEP_II | **Duration defaults to 0 - sleep lasts 0 seconds** |

Both have TYPE=13 (DEATH), CHANCE=10%, SUBEFFECT=12. The DEATH proc type may handle this differently in the proc function, but the SLEEP_II status would have 0 duration if applied through normal paths.

---

## Relic Weapon Additional Effects vs bg-wiki

### Level 75 Additional Effect Verification

| Weapon | Effect | Server Status | bg-wiki Status | Server Power | bg-wiki Power | Server Duration | bg-wiki Duration | Server Chance | bg-wiki Chance | Verdict |
|--------|--------|---------------|----------------|--------------|---------------|-----------------|------------------|---------------|----------------|---------|
| Mandau (18270) | Poison | 3 (POISON) | Poison | 10 | 10 dmg/tick | 30s | unspecified | 10% | ~10% | **MATCH** |
| Guttler (18288) | Choke | 130 (CHOKE) | Choke | 17 | -17 VIT | 60s | 60s | 10% | unspecified | **MATCH** |
| Bravura (18294) | Eva Down | 148 (EVASION_DOWN) | Evasion Down | 15 | -40 eva | 60s | ~40s | 10% | ~10% | **MISMATCH: power=15 vs 40, duration=60 vs 40** |
| Gungnir (18300) | Def Down | 149 (DEFENSE_DOWN) | Defense Down | 17 | -17.5% | 60s | unspecified | 10% | unspecified | **NEEDS VERIFY: is 17 = 17.5%?** |
| Apocalypse (18306) | Blind | 5 (BLINDNESS) | Blindness | 15 | unspecified | 30s | unspecified | 10% | ~10% | **LIKELY OK** |
| Kikoku (18312) | Paralyze | 4 (PARALYSIS) | Paralysis | 17 | unspecified | 30s | unspecified | 10% | ~10% | **LIKELY OK** |
| Amanomurakumo (18318) | Atk Down | 147 (ATTACK_DOWN) | Attack Down | 10 | unspecified | 60s | unspecified | 10% | ~10% | **LIKELY OK** |
| Mjollnir (18324) | MP Heal | TYPE=4 (MP_HEAL) | Recover MP | DMG=16 (fixed) | 4-16 MP | n/a | n/a | 10% | ~10% | **MISMATCH: always 16 vs 4-16 range** |
| Claustrum (18330) | Dispel | TYPE=10 (DISPEL) | Dispel | n/a | n/a | n/a | n/a | 15% | ~10% | **MISMATCH: 15% vs 10%** |

### Level 75 Hidden Effect Verification (OCC_DO_EXTRA_DMG)

Mod 506 = EXTRA_DMG_CHANCE (divided by 10 in C++ = actual %)
Mod 507 = OCC_DO_EXTRA_DMG (divided by 100 in C++ = multiplier)

| Weapon | Server Chance (506) | Server % | bg-wiki % | Server Mult (507) | Server x | bg-wiki x | Verdict |
|--------|---------------------|----------|-----------|-------------------|----------|-----------|---------|
| Spharai (18264) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |
| Mandau (18270) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |
| Excalibur (18276) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |
| Ragnarok (18282) | 50 | 5% | 7% | 250 | 2.5x | 2.5x | **MISMATCH: 5% vs 7%** |
| Guttler (18288) | 50 | 5% | 7% | 250 | 2.5x | 2.5x | **MISMATCH: 5% vs 7%** |
| Bravura (18294) | 50 | 5% | 8% | 200 | 2.0x | 2x (double) | **MISMATCH: 5% vs 8%** |
| Gungnir (18300) | 50 | 5% | 7% | 200 | 2.0x | 2.5x | **MISMATCH: 5% vs 7% AND 2.0x vs 2.5x** |
| Apocalypse (18306) | 50 | 5% | 8% | 200 | 2.0x | 2x (double) | **MISMATCH: 5% vs 8%** |
| Kikoku (18312) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |
| Amanomurakumo (18318) | 50 | 5% | 7% | 250 | 2.5x | 2.5x | **MISMATCH: 5% vs 7%** |
| Mjollnir (18324) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |
| Claustrum (18330) | 50 | 5% | 7% | 250 | 2.5x | 2.5x | **MISMATCH: 5% vs 7%** |
| Annihilator (18336) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |
| Yoichinoyumi (18348) | 50 | 5% | 5% | 300 | 3.0x | 3x (triple) | **MATCH** |

**Pattern:** All 2.5x weapons have 5% chance in server but bg-wiki says 7%. All 2x weapons have 5% but bg-wiki says 8%. Only 3x weapons are correct at 5%.

**Gungnir is double-wrong:** Both chance (5% vs 7%) AND multiplier (2.0x vs 2.5x) are incorrect.

---

## Excalibur Scripted Additional Effect -- Proc Rate Discrepancy

All 10 Excalibur scripts (75/80/85/90/95/99/99ii/119/119ii/119iii) have the same code:
```lua
if math.random(1, 100) <= 7 then -- 7% chance
```

**bg-wiki says:** The additional effect "Deals Slashing Damage damage equal to 25% of the wielder's current HP" activates on **every hit** (100% proc rate).

**Server:** 7% proc rate.

**DISCREPANCY:** 7% vs 100% proc rate. This is a major functionality difference -- Excalibur's signature additional effect fires on only 1 in ~14 hits instead of every hit.

**Files affected:**
- `scripts/items/excalibur_75.lua` (ID: 18276)
- `scripts/items/excalibur_80.lua` (ID: 18277 -> 18639 maps here)
- `scripts/items/excalibur_85.lua`
- `scripts/items/excalibur_90.lua`
- `scripts/items/excalibur_95.lua`
- `scripts/items/excalibur_99.lua`
- `scripts/items/excalibur_99_ii.lua`
- `scripts/items/excalibur_119.lua`
- `scripts/items/excalibur_119_ii.lua`
- `scripts/items/excalibur_119_iii.lua`

---

## Aftermath Effects Verification

Aftermath effects in `scripts/globals/aftermath.lua` were verified against bg-wiki:

| Weapon | Aftermath | Server Value | bg-wiki Value | Verdict |
|--------|-----------|-------------|---------------|---------|
| Spharai | Subtle Blow +10 | xi.mod.SUBTLE_BLOW, 10 | Subtle Blow +10 | **MATCH** |
| Mandau | Crit Rate +5% | xi.mod.CRITHITRATE, 5 | Crit Rate +5% | **MATCH** |
| Excalibur | Regen +10/tick | xi.mod.REGEN, 10 | Regen +10/tick | **MATCH** |
| Ragnarok | Crit Rate +5% | xi.mod.CRITHITRATE, 5 | Crit Rate +5% | **MATCH** |
| Guttler | Attack +10% | xi.mod.ATTP, 10 | Attack +10% | **MATCH** |
| Bravura | DMG Taken -20% | xi.mod.DMG, -2000 | DMG Taken -20% | **MATCH** |
| Apocalypse | Haste | xi.mod.HASTE_GEAR, 1000 | Haste | **NEEDS VERIFY: value** |
| Gungnir | Shock Spikes | SPIKES+SPIKES_DMG=10 | Shock Spikes | **MATCH** |
| Kikoku | Subtle Blow +10 | xi.mod.SUBTLE_BLOW, 10 | Subtle Blow +10 | **MATCH** |
| Amanomurakumo | Store TP +7 | xi.mod.STORETP, 7 | Store TP | **NEEDS VERIFY: bg-wiki doesn't specify value** |
| Mjollnir | Accuracy +20 | xi.mod.ACC, 20 | Accuracy +20 | **MATCH** |
| Claustrum | Refresh +8 | xi.mod.REFRESH, 8 | Refresh +8/tick | **MATCH** |
| Yoichinoyumi | R.Acc +20 | xi.mod.RACC, 20 | R.Acc +20 | **MATCH** |
| Annihilator | Enmity -20 | xi.mod.ENMITY, -20 | Enmity -20 | **MATCH** |

Duration formula: `math.floor(tp * 0.02)` -- matches bg-wiki's `Floor(0.02 x TP)`.

---

## Spharai and Ragnarok -- No Additional Effect (Correct)

| Weapon | Server Mods | bg-wiki | Verdict |
|--------|-------------|---------|---------|
| Spharai (18264) | No ADDEFFECT mods, only hidden dmg (506=50, 507=300) | "Enhances Counter +5" (passive stat, not proc) | **CORRECT** - Counter is a passive mod, not an additional effect |
| Ragnarok (18282) | No ADDEFFECT mods, only hidden dmg (506=50, 507=250) | "Increases rate of critical hits" (passive stat) | **CORRECT** - Crit rate is a passive mod |

---

## All Discrepancies Summary

### SEVERITY: CRITICAL (Functionality Broken)

1. **119 weapons with ADDEFFECT_TYPE but no CHANCE** -- Additional effects never proc. Includes relic 80/85/90/95/99/119 versions and 28 non-relic weapons with actual effect data.
2. **Nitric Baselard (20640)** -- Applies SLEEP instead of Defense Down (wrong STATUS=2, should be 149).
3. **Excalibur all versions** -- 7% proc rate instead of 100%. Major damage loss.
4. **Ice Brand, Flametongue, Air Knife** -- Have complete effect data (damage, element) but no CHANCE = never proc.
5. **Sangarius/+1, Dija Sword/+1** -- HP/TP drain effects never proc (no CHANCE).
6. **Rosschinder/+1** -- Paralysis never procs (no CHANCE, no POWER).
7. **Twilight Scythe, Crepuscular Scythe** -- SLEEP_II with 0 duration.

### SEVERITY: HIGH (Wrong Values)

8. **Bravura (18294)** -- Evasion Down power=15, should be 40. Duration=60s, should be ~40s.
9. **Gungnir (18300)** -- Hidden effect multiplier 2.0x, should be 2.5x. Hidden chance 5%, should be 7%.
10. **Claustrum (18330)** -- Dispel chance 15%, should be 10%.
11. **Mjollnir (18324)** -- MP recovery always 16, should be random 4-16 range.

### SEVERITY: MEDIUM (Wrong Hidden Effect Chances)

12. **Ragnarok (18282)** -- Hidden chance 5%, bg-wiki says 7%.
13. **Guttler (18288)** -- Hidden chance 5%, bg-wiki says 7%.
14. **Bravura (18294)** -- Hidden chance 5%, bg-wiki says 8%.
15. **Apocalypse (18306)** -- Hidden chance 5%, bg-wiki says 8%.
16. **Amanomurakumo (18318)** -- Hidden chance 5%, bg-wiki says 7%.
17. **Claustrum (18330)** -- Hidden chance 5%, bg-wiki says 7%.

### SEVERITY: LOW (Minor / Needs Further Verification)

18. **Gungnir Defense Down** -- Power=17, bg-wiki says 17.5%. Need to verify if server uses % or flat value.
19. **Mandau Poison** -- "Cannot overwrite itself" behavior not verified in code.
20. **Amanomurakumo Attack Down** -- "Can overwrite itself" behavior not verified.

---

## Key File References

- `sql/item_mods.sql` -- All ADDEFFECT mod definitions
- `scripts/globals/additional_effects.lua` -- Global additional effect processing (chance check at line 637)
- `scripts/items/excalibur_*.lua` -- Excalibur scripted additional effects (10 files)
- `scripts/globals/aftermath.lua` -- Relic/mythic/empyrean aftermath handling
- `src/map/utils/attackutils.cpp` line 284-289 -- Hidden effect (OCC_DO_EXTRA_DMG) processing
- `src/map/utils/battleutils.cpp` -- Additional effect trigger logic (SCRIPTED vs global)
- `src/map/modifier.h` lines 912-931 -- ADDEFFECT mod ID definitions
- `src/map/status_effect.h` -- Status effect ID enum
