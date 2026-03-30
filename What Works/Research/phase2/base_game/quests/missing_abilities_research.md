# Missing Abilities Research

Date: 2026-03-30

---

## PLD "Guardian" -- CORRECTION: This is NOT SP2

### bg-wiki Findings (https://www.bg-wiki.com/ffxi/Guardian)

Guardian is a **Job Trait** (Group 2 Merit), NOT an SP2 ability.

- **Type:** Merit Trait (Group 2 PLD)
- **Job:** Paladin
- **Description:** Reduces enmity loss while using Sentinel.
- **Ranks Available:** 5
- **Effect per Rank:** Reduces enmity loss during Sentinel by 19% per merit level.
- **Equipment modifier:** Valor Leggings +2 / Caballarius Leggings (+1/+2/+3) -- Increases Sentinel's duration by +2s per merit level (max +10s).

### Codebase Status: FULLY IMPLEMENTED

Guardian is already completely implemented in the server:

| Component | Location | Status |
|-----------|----------|--------|
| Trait enum | `scripts/enum/trait.lua` line 81: `GUARDIAN = 78` | EXISTS |
| Merit enum | `scripts/enum/merit.lua` line 366: `GUARDIAN = meritCategory.PLD_2 + 0x06` | EXISTS |
| Mod enum | `scripts/enum/mod.lua` line 519: `ENHANCES_GUARDIAN = 1065` | EXISTS |
| SQL trait | `sql/traits.sql` line 453: Job 7 (PLD), level 75, TOAU era | EXISTS |
| Implementation | `scripts/globals/job_utils/paladin.lua` lines 177-183 | EXISTS |

The implementation in `paladin.lua` applies Guardian's merit within the `useSentinel` function:
- Reads merit level via `player:getMerit(xi.merit.GUARDIAN)`
- Reads ENHANCES_GUARDIAN mod (from Caballarius Leggings etc.) and scales by merit
- Extends Sentinel duration by the enhanced amount
- Passes guardian merit + JP value as subPower to the Sentinel status effect (for enmity loss reduction)

**Conclusion: No work needed. Guardian is fully functional.**

---

## GEO Missing Abilities

### 1. Collimated Fervor

#### bg-wiki Data (https://www.bg-wiki.com/ffxi/Collimated_Fervor)

- **Type:** Level ability (obtained at GEO level 40)
- **Description:** Enhances the influence of your next Cardinal Chant cast.
- **Duration:** 1 minute or until next spell
- **Recast:** 5 minutes
- **Enmity:** 0 CE / 320 VE
- **Effect:** Increases directional effects from Cardinal Chant by 50%. Consumed by any spell, including ones unaffected by Cardinal Chant.
- **JP Category:** Concentric Pulse Effect (20 ranks, +1% damage each) -- note: this JP is for Concentric Pulse, not Collimated Fervor

#### Codebase Status: MISSING ABILITY SCRIPT ONLY

| Component | Location | Status |
|-----------|----------|--------|
| Ability SQL | `sql/abilities.sql` line 356: ID 348 | EXISTS |
| Job Ability enum | `scripts/enum/job_ability.lua` line 338: `COLLIMATED_FERVOR = 348` | EXISTS |
| Effect enum | `scripts/enum/effect.lua` line 516: `COLLIMATED_FERVOR = 517` | EXISTS |
| Effect script | `scripts/effects/collimated_fervor.lua` | EXISTS (stub -- empty handlers) |
| Job utils function | `scripts/globals/job_utils/geomancer.lua` line 370: `collimatedFervor()` | EXISTS |
| Cardinal Chant integration | `scripts/globals/spells/damage_spell.lua` lines 271-274 | EXISTS (checks for effect, applies 1.5x) |
| **Ability action script** | `scripts/actions/abilities/collimated_fervor.lua` | **MISSING** |

**What needs to be created:** A single file `scripts/actions/abilities/collimated_fervor.lua` that:
- Calls `xi.job_utils.geomancer.collimatedFervor(player, target, ability)` in `onUseAbility`
- Pattern: identical to `bolster.lua` / `ecliptic_attrition.lua`

The underlying logic is already complete -- the effect is applied in geomancer.lua, and damage_spell.lua already checks for the effect and applies the 1.5x multiplier.

---

### 2. Concentric Pulse

#### bg-wiki Data (https://www.bg-wiki.com/ffxi/Concentric_Pulse)

- **Type:** Level ability (obtained at GEO level 90)
- **Description:** Causes your luopan to vanish and deals damage to enemies within area of effect.
- **Range:** 10 yalms
- **Recast:** 5:00
- **Enmity:** 1 CE / 80 VE
- **Effect:** Deals damage equal to the luopan's current HP. Damage counts as Magic. Does not scale with number of targets.
- **JP:** Concentric Pulse Effect -- 20 ranks, +1% damage per rank.
- **Equipment:** Bagua Galero +2/+3/+4 makes it use Luopan max HP instead of current HP.

#### Codebase Status: FULLY IMPLEMENTED

| Component | Location | Status |
|-----------|----------|--------|
| Ability SQL | `sql/abilities.sql` line 361: ID 353 | EXISTS |
| Job Ability enum | `scripts/enum/job_ability.lua` line 343: `CONCENTRIC_PULSE = 353` | EXISTS |
| Pet ability script | `scripts/actions/abilities/pets/concentric_pulse.lua` | EXISTS |

The pet ability script is complete:
- Uses `geoOnConcentricPulseAbilityCheck` for validation
- Reads luopan HP (or max HP with Bagua Galero +2/+3)
- Applies JP damage boost
- Handles Stoneskin, deals magical damage, kills luopan after 200ms

**Conclusion: No work needed. Concentric Pulse is fully functional.**

---

### 3. Mending Halation

#### bg-wiki Data (https://www.bg-wiki.com/ffxi/Mending_Halation)

- **Type:** Merit ability (Group 2 GEO, obtained at level 75)
- **Description:** Causes your luopan to vanish and restores HP of party members within area of effect.
- **Range:** 10 yalms
- **Recast:** 5:00
- **Ranks:** 5 (+5% HP restored per rank)
- **Formula:** HP Healed = 7 * Luopan Level * (1 + 0.05 * (Merit Level - 1)) * Relic Pants Bonus
- **Notes:** Light-based cure, suffers Darkness day/weather penalties. Luopan max HP modifiers affect the result.
- **Equipment:** Bagua Pants (+1/+2/+3) enhances by 4% per merit level (max +20%).

#### Codebase Status: FULLY IMPLEMENTED

| Component | Location | Status |
|-----------|----------|--------|
| Ability SQL | `sql/abilities.sql` line 362: ID 354 | EXISTS |
| Job Ability enum | `scripts/enum/job_ability.lua` line 344: `MENDING_HALATION = 354` | EXISTS |
| Pet ability script | `scripts/actions/abilities/pets/mending_halation.lua` | EXISTS |

The pet ability script is complete with merit scaling and equipment modifier support.

**Conclusion: No work needed. Mending Halation is fully functional.**

---

### 4. Radial Arcana

#### bg-wiki Data (https://www.bg-wiki.com/ffxi/Radial_Arcana)

- **Type:** Merit ability (Group 2 GEO, obtained at level 75)
- **Description:** Causes your luopan to vanish and restores MP of party members within area of effect.
- **Range:** 10 yalms
- **Recast:** 5:00
- **Ranks:** 5 (+3% MP restored per rank)
- **Formula:** MP Healed = (3 * Luopan Level * [1 + (0.03 * (Merit Level - 1))] + 1) * 1.X (where X = Bagua Sandals bonus)
- **Notes:** Luopan Level capped at 99. Luopan max HP modifiers, weather, and day can affect MP return.
- **Equipment:** Bagua Sandals (+1/+2/+3) increases total MP restored by +5% per merit level (max +20%).

#### Codebase Status: FULLY IMPLEMENTED

| Component | Location | Status |
|-----------|----------|--------|
| Ability SQL | `sql/abilities.sql` line 363: ID 355 | EXISTS |
| Job Ability enum | `scripts/enum/job_ability.lua` line 345: `RADIAL_ARCANA = 355` | EXISTS |
| Pet ability script | `scripts/actions/abilities/pets/radial_arcana.lua` | EXISTS |

The pet ability script is complete with merit scaling and equipment modifier support.

**Conclusion: No work needed. Radial Arcana is fully functional.**

---

## Summary

| Ability | Job | Type | Status | Work Needed |
|---------|-----|------|--------|-------------|
| Guardian | PLD | Merit Trait (NOT SP2) | COMPLETE | None |
| Collimated Fervor | GEO | Level 40 ability | **MISSING ability script** | Create `scripts/actions/abilities/collimated_fervor.lua` |
| Concentric Pulse | GEO | Level 90 ability | COMPLETE | None |
| Mending Halation | GEO | Merit (Group 2) | COMPLETE | None |
| Radial Arcana | GEO | Merit (Group 2) | COMPLETE | None |

### Only Action Item

**Collimated Fervor** needs one file created: `scripts/actions/abilities/collimated_fervor.lua`

The file should follow the pattern of other GEO abilities (bolster.lua, ecliptic_attrition.lua):
- `onAbilityCheck`: Check if effect is already active (return `xi.msg.basic.EFFECT_ALREADY_ACTIVE`)
- `onUseAbility`: Call `xi.job_utils.geomancer.collimatedFervor(player, target, ability)`

All SQL definitions, enums, effect scripts, job utility functions, and Cardinal Chant integration already exist and are functional. The only missing piece is the routing script that connects the ability ID to the implementation.
