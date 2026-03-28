# Assault System -- Detailed Audit

**Date:** 2026-03-28
**Server:** xiserver (LandSandBoat fork)
**Branch:** develop

---

## Executive Summary

- **Total Assault Scenarios:** 50 (across 5 staging points) + 2 Nyzul Isle
- **Implemented:** 11 instance scripts (10 assaults + 1 TOAU mission using assault zone)
- **Nyzul Isle:** 1 fully implemented (Investigation), 1 stub (Uncharted Area Survey)
- **Missing:** 40 of 50 standard assaults have NO instance scripts
- **Implementation Rate:** 10/50 standard assaults = **20%**

---

## Framework Assessment

### Core Framework: `scripts/globals/assault.lua`
**Status: FUNCTIONAL**

The assault framework is well-built and handles:
- Entry validation (key items, party size, level requirements)
- Instance creation callbacks (level cap, armband consumption)
- Player registration (fireflies, mob spawning, level restriction)
- Instance failure (mob despawn, failure message, exit cutscene)
- Instance completion (Rune of Release + Ancient Lockbox activation)
- **Assault points system:** Fully coded in `runeReleaseFinish()`
  - First-clear bonus: 1.5x points + 5 promotion points
  - Repeat clears: base points + 1 promotion point
  - Party size penalty: `max((#chars - 3) * 0.1, 0)` reduction
  - Armband bonus: 1.1x multiplier
  - Points stored per area via `addAssaultPoint()`
- Level scaling: `adjustMobLevel()` reduces mob levels by 5/15/25 for 70/60/50 caps

### Enum Definitions: `scripts/enum/assault.lua`
**Status: COMPLETE** -- All 50 assaults + 2 Nyzul defined with IDs 1-52

### Mission Info Table: `scripts/enum/assault.lua`
**Status: COMPLETE** -- All 50 assaults have `suggestedLevel` and `minimumPoints` defined

### Mercenary Rank System: `scripts/globals/besieged.lua`
**Status: FUNCTIONAL**
- Rank determined by wildcat badge key items (PFC through Captain)
- `getMercenaryRank()` checks badges in reverse order, returns rank 0-9
- Ranks gate map purchases and sanction duration

### Settings: `settings/default/main.lua`
- `ASSAULT_MINIMUM = 1` (retail was 3, set to 1 for small server -- good)

### Appraisal System: `scripts/globals/appraisal.lua`
**Status: FUNCTIONAL** -- Handles lockbox loot tables for assault rewards

---

## Staging Point Entry Chain

The full entry path is:

1. **Aht Urhgan Whitegate** -> Runic Portal (`scripts/zones/Aht_Urhgan_Whitegate/npcs/Runic_Portal.lua`)
2. **Staging Point** (overworld zone, e.g., Caedarva Mire) -> Runic Portal teleports back or enters staging
3. **Assault Zone** (instanced) -> Entry NPC creates instance

Staging point Runic Portals exist for all 5 areas:
- Caedarva Mire: Azouph + Dvucca (Leujaoam + Periqia)
- Bhaflau Thickets (Mamool Ja)
- Mount Zhayolm (Lebros)
- Arrapago Reef (Ilrusi)
- Alzadaal Undersea Ruins (Nyzul)

---

## All 50 Assaults -- Status by Staging Point

### Legend
- **WORKS** = Instance script exists, has entry/completion logic, mobs spawn, points can be awarded
- **PARTIAL** = Instance script exists but uses older non-standard framework (missing registryRequirements, etc.)
- **MISSION** = Not an assault; is a TOAU mission instance sharing the zone
- **MISSING** = No instance script exists

---

### 1. Leujaoam Sanctum (Azouph Staging Point -- Caedarva Mire)
Assault IDs 1-10

| # | ID | Assault Name | Rank | Status | Notes |
|---|-----|------|------|--------|-------|
| 1 | 1 | Leujaoam Cleansing | PSC | **WORKS** | Full framework: entry reqs, mob spawn via MOBS_START, progress >= 1 completes, Rune/Lockbox positioned, points awarded |
| 2 | 2 | Orichalcum Survey | PSC | MISSING | Lockbox loot table exists in Ancient_Lockbox.lua but no instance script |
| 3 | 3 | Escort Professor Chanoix | PFC | MISSING | |
| 4 | 4 | Shanarha Grass Conservation | PSC | MISSING | |
| 5 | 5 | Counting Sheep | PFC | MISSING | |
| 6 | 6 | Supplies Recovery | SP | MISSING | |
| 7 | 7 | Azure Experiments | SP | MISSING | |
| 8 | 8 | Imperial Code | SP | MISSING | |
| 9 | 9 | Red Versus Blue | LC | MISSING | |
| 10 | 10 | Bloody Rondo | LC | MISSING | |

**Implemented: 1/10**

Mob scripts present: `Imp.lua`, `Leujaoam_Worm.lua`
NPCs: `Ancient_Lockbox.lua` (loot tables for missions 1+2), `Rune_of_Release.lua`

---

### 2. Mamool Ja Training Grounds (Mamool Ja Staging Point -- Bhaflau Thickets)
Assault IDs 11-20

| # | ID | Assault Name | Rank | Status | Notes |
|---|-----|------|------|--------|-------|
| 1 | 11 | Imperial Agent Rescue | PSC | **WORKS** | Full framework, sets progress to random POT_HATCH NPC, Rune/Lockbox positioned |
| 2 | 12 | Preemptive Strike | PSC | **PARTIAL** | Older style: no registryRequirements/entryRequirements, manual instance creation, spawns ID.mob[1] not ID.mob[12], progress >= 13 completes |
| 3 | 13 | Sagelord Elimination | PFC | MISSING | |
| 4 | 14 | Breaking Morale | PFC | MISSING | |
| 5 | 15 | The Double Agent | SP | MISSING | |
| 6 | 16 | Imperial Treasure Retrieval | PSC | MISSING | |
| 7 | 17 | Blitzkrieg | SP | MISSING | |
| 8 | 18 | Marids in the Mist | SP | MISSING | |
| 9 | 19 | Azure Ailments | LC | MISSING | |
| 10 | 20 | The Susanoo Shuffle | LC | MISSING | |

**Implemented: 2/10**

Mob scripts: `Mamool_Ja_Executioner.lua`, `Mamool_Ja_Warder.lua`, `Mamool_Jas_Lizard.lua`, `Puk_Executioner.lua`, `Dilapidated_Gate.lua`, `Chigoe.lua`
NPCs: `Ancient_Lockbox.lua`, `Rune_of_Release.lua`, `_jul.lua`/`_jum.lua`/`_jun.lua` (pot hatches for Agent Rescue)

---

### 3. Lebros Cavern (Halvung Staging Point -- Mount Zhayolm)
Assault IDs 21-30

| # | ID | Assault Name | Rank | Status | Notes |
|---|-----|------|------|--------|-------|
| 1 | 21 | Excavation Duty | PSC | **WORKS** | Full framework, progress >= 5 completes, Rune/Lockbox positioned |
| 2 | 22 | Lebros Supplies | PFC | MISSING | |
| 3 | 23 | Troll Fugitives | SP | **PARTIAL** | Older style: no registryRequirements, manual instance setup, spawns ID.mob[23], progress >= 15 completes |
| 4 | 24 | Evade and Escape | SP | MISSING | |
| 5 | 25 | Siegemaster Assassination | SP | MISSING | |
| 6 | 26 | Apkallu Breeding | PFC | MISSING | |
| 7 | 27 | Wamoura Farm Raid | SP | **PARTIAL** | Older style: no registryRequirements, spawns ID.mob[27], progress >= 15 completes, Rune/Lockbox positioned on complete |
| 8 | 28 | Egg Conservation | SP | MISSING | |
| 9 | 29 | Operation: Black Pearl | LC | MISSING | |
| 10 | 30 | Better Than One | LC | MISSING | |

**Implemented: 3/10**

Mob scripts: `Broken_Troll_Soldier.lua`, `Qiqirn_Ceramist.lua`, `Qiqirn_Mine.lua`, `Qiqirn_Volcanist.lua`, `Ranch_Wamoura.lua`, `Ranch_Wamouracampa.lua`, `Volcanic_Bomb.lua`, `Brittle_Rock.lua`

---

### 4. Periqia (Dvucca Staging Point -- Caedarva Mire)
Assault IDs 31-40

| # | ID | Assault Name | Rank | Status | Notes |
|---|-----|------|------|--------|-------|
| 1 | 31 | Seagull Grounded | PSC | **WORKS** | Full framework + extensive escort AI (650+ lines). NPC Excaliace follows complex pathing with mob avoidance, player proximity detection, branching paths. Most sophisticated assault implementation. |
| 2 | 32 | Requiem | PSC | **PARTIAL** | Older style: no registryRequirements, spawns ID.mob[32], progress >= 18 completes. TODO comment: "random the chest locations" |
| 3 | 33 | Saving Private Ryaaf | PFC | MISSING | |
| 4 | 34 | Shooting Down the Baron | PFC | MISSING | |
| 5 | 35 | Building Bridges | SP | MISSING | |
| 6 | 36 | Stop the Bloodshed | PSC | MISSING | |
| 7 | 37 | Defuse the Threat | PFC | MISSING | |
| 8 | 38 | Operation: Snake Eyes | SP | MISSING | |
| 9 | 39 | Wake the Puppet | SP | MISSING | |
| 10 | 40 | The Price is Right | LC | MISSING | |

**Also present:** `shades_of_vengeance.lua` -- This is TOAU Mission 31, NOT an assault. Uses Periqia zone but is a story mission instance (ID.mob[79]).

**Implemented: 2/10** (not counting Shades of Vengeance)

Mob scripts: `Batteilant_Bhoot.lua`, `Darkling_Draugar.lua`, `Draconic_Draugar.lua`, `Excaliace.lua` (escort NPC for Seagull Grounded), `K23H1-LAMIA.lua`, `Putrid_Immortal_Guard.lua`

---

### 5. Ilrusi Atoll (Ilrusi Staging Point -- Arrapago Reef)
Assault IDs 41-50

| # | ID | Assault Name | Rank | Status | Notes |
|---|-----|------|------|--------|-------|
| 1 | 41 | Golden Salvage | PSC | **PARTIAL** | Older style: no registryRequirements, spawns ID.mob[1] (wrong?), uses random chest offset, no auto-complete in onInstanceProgressUpdate. TODO: "random the chest locations" |
| 2 | 42 | Lamia No. 13 | PSC | MISSING | |
| 3 | 43 | Extermination | PFC | **PARTIAL** | Older style: no registryRequirements, spawns ID.mob[43], sets gate animations, progress == 20 completes |
| 4 | 44 | Demolition Duty | PSC | MISSING | |
| 5 | 45 | Searat Salvation | PFC | MISSING | |
| 6 | 46 | Apkallu Seizure | SP | MISSING | |
| 7 | 47 | Lost and Found | SP | MISSING | |
| 8 | 48 | Deserter | SP | MISSING | |
| 9 | 49 | Desperately Seeking Cephalopods | LC | MISSING | |
| 10 | 50 | Bellerophon's Bliss | LC | MISSING | |

**Implemented: 2/10**

Mob scripts: `Carrion_Crab.lua`, `Carrion_Leech.lua`, `Carrion_Slime.lua`, `Carrion_Toad.lua`, `Cursed_Chest.lua`, `Imp.lua`, `Undead_Crab.lua`, `Undead_Leech.lua`, `Undead_Slime.lua`, `Undead_Toad.lua`

---

### 6. Nyzul Isle (Alzadaal Staging Point -- Alzadaal Undersea Ruins)
Assault IDs 51-52

| # | ID | Assault Name | Rank | Status | Notes |
|---|-----|------|------|--------|-------|
| 1 | 51 | Nyzul Isle Investigation | Any | **WORKS** | Full implementation with floor system, objectives, boss stages, NM spawns. Most complete assault in the codebase. |
| 2 | 52 | Nyzul Isle Uncharted Area Survey | Captain | MISSING | No instance script (this is the Mythic weapon path) |

**Also present:** `nashmeiras_plea.lua`, `path_of_darkness.lua`, `waking_the_colossus.lua` -- These are TOAU missions, not assaults.

---

## Summary Table

| Staging Point | Zone | Implemented | Missing | Total |
|---|---|---|---|---|
| Leujaoam Sanctum | Caedarva Mire (Azouph) | 1 | 9 | 10 |
| Mamool Ja Training Grounds | Bhaflau Thickets | 2 | 8 | 10 |
| Lebros Cavern | Mount Zhayolm | 3 | 7 | 10 |
| Periqia | Caedarva Mire (Dvucca) | 2 | 8 | 10 |
| Ilrusi Atoll | Arrapago Reef | 2 | 8 | 10 |
| **TOTALS** | | **10** | **40** | **50** |

Nyzul Isle Investigation: **WORKS** (separate from the 50 count)

---

## Quality Assessment of Implemented Assaults

### Tier 1: Full Modern Framework (3 assaults)
These use `registryRequirements`, `entryRequirements`, call `xi.assault.afterInstanceRegister()` for proper firefly/armband handling, and use `xi.assault.onInstanceComplete()` for standardized completion. Points are awarded through the Rune of Release via `xi.assault.runeReleaseFinish()`.

1. **Leujaoam Cleansing** (ID 1) -- Leujaoam Sanctum
2. **Imperial Agent Rescue** (ID 11) -- Mamool Ja Training Grounds
3. **Excavation Duty** (ID 21) -- Lebros Cavern
4. **Seagull Grounded** (ID 31) -- Periqia

### Tier 2: Older/Non-Standard Framework (6 assaults)
These are missing `registryRequirements`/`entryRequirements`, use manual `onInstanceCreatedCallback` instead of the framework helper, and some spawn mobs using wrong IDs (e.g., `ID.mob[1]` instead of `ID.mob[assaultID]`). They may not properly award assault points because they bypass `xi.assault.afterInstanceRegister()`.

5. **Preemptive Strike** (ID 12) -- Mamool Ja Training Grounds
6. **Troll Fugitives** (ID 23) -- Lebros Cavern
7. **Wamoura Farm Raid** (ID 27) -- Lebros Cavern
8. **Requiem** (ID 32) -- Periqia
9. **Extermination** (ID 43) -- Ilrusi Atoll
10. **Golden Salvage** (ID 41) -- Ilrusi Atoll

### Issues with Tier 2 Assaults
- **No assault point rewards:** Without calling `xi.assault.afterInstanceRegister()`, the `assaultEntered` charvar is not set, and the Rune of Release `runeReleaseFinish()` may not correctly process points.
- **No armband handling:** The framework normally deletes the armband key item and sets a charvar for the 1.1x bonus. Tier 2 assaults skip this.
- **No level cap support:** `xi.assault.afterInstanceRegister()` applies level restriction effects; Tier 2 assaults skip this.
- **No firefly temp items:** Players may not receive the zone-illumination fireflies.
- **Golden Salvage spawns `ID.mob[1]`:** This appears to be a bug -- should likely be `ID.mob[41]`.

---

## Complete List of 40 Missing Assaults

### Leujaoam Sanctum (9 missing)
| ID | Name | Suggested Lv | Min Points |
|----|------|-------------|------------|
| 2 | Orichalcum Survey | 50 | 1200 |
| 3 | Escort Professor Chanoix | 60 | 1100 |
| 4 | Shanarha Grass Conservation | 50 | 1333 |
| 5 | Counting Sheep | 60 | 1166 |
| 6 | Supplies Recovery | 70 | 1000 |
| 7 | Azure Experiments | 70 | 1000 |
| 8 | Imperial Code | 70 | 1333 |
| 9 | Red Versus Blue | 70 | 1666 |
| 10 | Bloody Rondo | 70 | 1500 |

### Mamool Ja Training Grounds (8 missing)
| ID | Name | Suggested Lv | Min Points |
|----|------|-------------|------------|
| 13 | Sagelord Elimination | 70 | 1200 |
| 14 | Breaking Morale | 60 | 1333 |
| 15 | The Double Agent | 70 | 1200 |
| 16 | Imperial Treasure Retrieval | 50 | 1200 |
| 17 | Blitzkrieg | 70 | 1533 |
| 18 | Marids in the Mist | 70 | 1333 |
| 19 | Azure Ailments | 70 | 1000 |
| 20 | The Susanoo Shuffle | 70 | 1500 |

### Lebros Cavern (7 missing)
| ID | Name | Suggested Lv | Min Points |
|----|------|-------------|------------|
| 22 | Lebros Supplies | 60 | 1200 |
| 24 | Evade and Escape | 70 | 1000 |
| 25 | Siegemaster Assassination | 70 | 1100 |
| 26 | Apkallu Breeding | 60 | 1300 |
| 28 | Egg Conservation | 70 | 1333 |
| 29 | Operation: Black Pearl | 70 | 1400 |
| 30 | Better Than One | 70 | 1500 |

### Periqia (8 missing)
| ID | Name | Suggested Lv | Min Points |
|----|------|-------------|------------|
| 33 | Saving Private Ryaaf | 70 | 1100 |
| 34 | Shooting Down the Baron | 60 | 1100 |
| 35 | Building Bridges | 70 | 1200 |
| 36 | Stop the Bloodshed | 50 | 1000 |
| 37 | Defuse the Threat | 60 | 1600 |
| 38 | Operation: Snake Eyes | 70 | 1333 |
| 39 | Wake the Puppet | 70 | 1200 |
| 40 | The Price is Right | 70 | 1500 |

### Ilrusi Atoll (8 missing)
| ID | Name | Suggested Lv | Min Points |
|----|------|-------------|------------|
| 42 | Lamia No. 13 | 70 | 1200 |
| 44 | Demolition Duty | 50 | 1000 |
| 45 | Searat Salvation | 60 | 1166 |
| 46 | Apkallu Seizure | 70 | 1000 |
| 47 | Lost and Found | 60 | 1000 |
| 48 | Deserter | 70 | 1000 |
| 49 | Desperately Seeking Cephalopods | 70 | 1000 |
| 50 | Bellerophon's Bliss | 70 | 1500 |

---

## Key File Locations

| Component | Path |
|-----------|------|
| Assault framework | `scripts/globals/assault.lua` |
| Assault enum/mission info | `scripts/enum/assault.lua` |
| Appraisal (lockbox loot) | `scripts/globals/appraisal.lua` |
| Besieged/mercenary ranks | `scripts/globals/besieged.lua` |
| Assault minimum setting | `settings/default/main.lua` (line 244) |
| Leujaoam instances | `scripts/zones/Leujaoam_Sanctum/instances/` |
| Mamool Ja instances | `scripts/zones/Mamool_Ja_Training_Grounds/instances/` |
| Lebros instances | `scripts/zones/Lebros_Cavern/instances/` |
| Periqia instances | `scripts/zones/Periqia/instances/` |
| Ilrusi instances | `scripts/zones/Ilrusi_Atoll/instances/` |
| Nyzul instances | `scripts/zones/Nyzul_Isle/instances/` |

---

## Recommendations

### Priority 1: Fix Existing Tier 2 Assaults
The 6 older-style assaults should be updated to use the modern framework pattern (matching Leujaoam Cleansing / Excavation Duty). This means adding:
- `registryRequirements()` and `entryRequirements()` functions
- Calling `xi.assault.onInstanceCreatedCallback()` instead of manual instance setup
- Calling `xi.assault.afterInstanceRegister()` for proper firefly/armband/level cap handling
- Fix Golden Salvage's `ID.mob[1]` -> `ID.mob[41]`

### Priority 2: Upstream Tracking
Check LandSandBoat upstream (`remotes/upstream/base`) for any newly implemented assaults that could be merged. The framework is mature; individual assaults may have been added since the fork.

### Priority 3: New Implementations
For a 4-player private server, focus on PSC/PFC rank assaults first (the ones players will encounter earliest):
- Orichalcum Survey (ID 2) -- lockbox loot already defined
- Sagelord Elimination (ID 13)
- Imperial Treasure Retrieval (ID 16)
- Demolition Duty (ID 44)
- Stop the Bloodshed (ID 36)

---

## Final Score

| Metric | Value |
|--------|-------|
| Standard assaults implemented | 10/50 (20%) |
| Using modern framework | 4/10 (40% of implemented) |
| Using older framework (needs fixes) | 6/10 (60% of implemented) |
| Nyzul Isle Investigation | WORKS |
| Framework/infrastructure | COMPLETE |
| Staging point entry chain | FUNCTIONAL |
| Assault point system | CODED (untested for Tier 2) |
| Mercenary rank system | FUNCTIONAL |
