# NM (Notorious Monster) Systems and Drop Tables

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Notorious_Monsters
- Codebase:
  - `scripts/globals/mobs.lua` (NM spawn framework: `phOnDespawn`, `updateNMSpawnPoint`)
  - `scripts/globals/combat/treasure_hunter.lua` (TH drop rate system)
  - `scripts/globals/caskets.lua` + `scripts/globals/casket_loot.lua` (field caskets)
  - `sql/mob_droplist.sql` (all drop tables)
  - `sql/mob_spawn_points.sql` (spawn point data)
  - `sql/mob_pools.sql` (mob pool definitions)
  - `modules/toau/sql/pre_rmt_drops.sql` (optional pre-RMT drop replacements)
  - `scripts/mixins/rage.lua` (rage timer for HNMs)
  - `scripts/mixins/job_special.lua` (2-hour ability usage for NMs)
  - `scripts/mixins/draw_in.lua` (draw-in behavior)

## Summary
NM systems are **WORKS** overall. The spawn framework is fully implemented with lottery, timed, and force-pop systems. Drop tables are comprehensive (19,108 entries across 3,468 unique mobs). Treasure Hunter is fully implemented with a 15-tier scaling table. HNMs have detailed custom AI scripts. One notable finding: by default the server uses post-2007 RMT-nerfed drops (Bounding Boots, Empress Hairpin, Velocious Belt) rather than the original iconic items (Leaping/Strider Boots, Emperor Hairpin, Speed Belt). An optional module exists to revert this but is NOT enabled.

---

## 1. NM Spawn Systems

### Lottery NMs (Placeholder System)
| Item | Status | Notes |
|------|--------|-------|
| Lottery framework (`xi.mob.phOnDespawn`) | WORKS | Full implementation in `scripts/globals/mobs.lua` line 92. Takes placeholder mob, NM ID, chance (1/N), cooldown, and optional params. |
| Placeholder scripts | WORKS | 744 mob scripts use `phOnDespawn` or `phList` for lottery spawning. |
| Spawn point randomization (`updateNMSpawnPoint`) | WORKS | NMs can spawn at random positions from a defined `spawnPoints` table in their script. |
| Optional params | WORKS | Supports: `immediate`, `dayOnly`, `nightOnly`, `noPosUpdate`, custom `spawnPoints`, `doNotEnablePhSpawn`. |

**How lottery NMs work:**
1. Placeholder mob (e.g., Rock Lizard) dies
2. `onMobDespawn` calls `xi.mob.phOnDespawn(mob, nmId, chance, cooldown)`
3. System checks if the dead mob's ID is in the NM's `phList` table
4. Rolls chance (e.g., 9 = 1/9 chance); if successful, NM spawns instead of placeholder
5. Cooldown prevents NM from spawning too quickly after death

**Example -- Leaping Lizzy:**
- Placeholder: Rock Lizard (`scripts/zones/South_Gustaberg/mobs/Rock_Lizard.lua`)
- Calls `xi.mob.phOnDespawn(mob, ID.mob.LEAPING_LIZZY[1], 9, 1)` -- pure lottery, 1/9 chance, 1s cooldown
- Leaping Lizzy script has 2 placeholder entries and 65 spawn points

**Example -- Valkurm Emperor:**
- Placeholder: Damselfly (`scripts/zones/Valkurm_Dunes/mobs/Damselfly.lua`)
- Calls `xi.mob.phOnDespawn(mob, ID.mob.VALKURM_EMPEROR, 10, 3600)` -- 1/10 chance, 1hr cooldown
- 1 placeholder entry, 50 spawn points

### Timed NMs
| Item | Status | Notes |
|------|--------|-------|
| Timed spawn framework | WORKS | 191 mob scripts use `setRespawnTime` for timed spawning. |
| Simurgh (Rolanberry Fields) | WORKS | Respawns 1-2 hours after death (`math.random(3600, 7200)`). Has draw-in, rage timer, immunities, job_special mixin. |
| King Arthro (Jugner Forest) | WORKS | Complex respawn: Knight Crabs spawn 15min-3h15min after KA dies; KA itself respawns 21h05m-24h05m. Knight Crabs are suppressed while KA is up. |

### Force-Pop NMs (??? System)
| Item | Status | Notes |
|------|--------|-------|
| Force-pop framework (`npc_util.lua`) | WORKS | `FORCE_SPAWN_QM_RESET_TIME` setting (default 300 seconds) controls how long ??? is hidden after NM despawns. |
| Fafnir/Nidhogg ??? | WORKS | Fafnir script despawns `FAFNIR_QM` on spawn, respawns it via `updateNPCHideTime` on despawn. |
| Aspidochelone ??? | WORKS | Same pattern with `ADAMANTOISE_QM`. |
| King Behemoth ??? | WORKS | Same pattern with `BEHEMOTH_QM`. |

---

## 2. Drop Lists

### Overview
| Item | Status | Notes |
|------|--------|-------|
| Total drop entries | WORKS | 19,108 INSERT statements in `mob_droplist.sql` |
| Unique mobs with drops | WORKS | ~3,468 unique mob names have droplists |
| Drop rate tiers | WORKS | 6 tiers: Always (100%), VCommon (24%), Common (15%), Uncommon (10%), Rare (5%), VRare (1%) |
| Group drops (abjurations etc.) | WORKS | Supports grouped drops with weighted sub-items (e.g., abjuration pools) |
| Despoil drops | WORKS | Type 4 entries for BST Despoil ability |
| Steal drops | WORKS | Type 2 entries for THF Steal |
| `DROP_RATE_MULTIPLIER` setting | WORKS | C++ code in `mobentity.cpp` applies `map.DROP_RATE_MULTIPLIER` to all non-fixed drops (default 1.0) |

### Spot-Check: Famous NMs

| NM | Zone | Drops | Status | Notes |
|----|------|-------|--------|-------|
| Leaping Lizzy | South Gustaberg | Lizard Tail (15%), Lizard Skin (10%) | PARTIAL | **Missing Strider Boots!** Base drop is post-RMT. Nyzul version drops Bounding Boots (15%). See pre-RMT module below. |
| Valkurm Emperor | Valkurm Dunes | Insect Wing (15%) | PARTIAL | **Missing Emperor Hairpin!** Base drop is shared with generic flies. Pre-RMT module replaces Empress Hairpin -> Emperor Hairpin. Empress Hairpin exists on droplist 2533 (separate mob pool). |
| Simurgh | Rolanberry Fields | Giant Bird Feather (10%), Giant Bird Plume (1%) | PARTIAL | **Missing Trotter/Strider Boots!** Pre-RMT module replaces Trotter -> Strider Boots. Nyzul version has Trotter Boots (15%), Arcana Breaker (100%), Damascus Ingot (5%). |
| King Arthro | Jugner Forest | Avalon Shield (24%), Avalon Breastplate (24%), Damascene Cloth (5%), Magic Cuisses (5%), Velocious Belt (5%) | PARTIAL | **Has Velocious Belt, not Speed Belt.** Pre-RMT module replaces Velocious -> Speed Belt. |

### Pre-RMT Drop Module (NOT ENABLED)
| Item | Status | Notes |
|------|--------|-------|
| Module location | EXISTS | `modules/toau/sql/pre_rmt_drops.sql` |
| Module activation | NOT LOADED | **Not listed in `modules/init.txt`**. Only `custom/commands/` and `custom/lua/test_npcs_in_gm_home.lua` are enabled. |
| Replacements available | 12 NMs | Leaping Lizzy (Bounding->Leaping Boots), Valkurm Emperor (Empress->Emperor Hairpin), King Arthro (Velocious->Speed Belt), Simurgh (Trotter->Strider Boots), Argus (Peacock Amulet->Charm), Lord of Onzozo (Octave->Kraken Club), Roc (Dryad->Healing Staff), plus 5 others. |

**To enable pre-RMT drops:** Add `toau` to `modules/init.txt` and re-import SQL.

---

## 3. HNM System

### Dragon's Aery (Fafnir / Nidhogg)
| Item | Status | Notes |
|------|--------|-------|
| Fafnir spawn point | WORKS | `mob_spawn_points.sql` entry exists (ID 17408018, zone 154, lv90). 50 randomized spawn positions. |
| Nidhogg spawn point | WORKS | `mob_spawn_points.sql` entry exists (ID 17408019, zone 154, lv90). 50 randomized spawn positions. |
| Fafnir AI script | WORKS | Has rage timer (60 min), draw-in, custom ATT/REGEN/weapon damage, grants title. |
| Nidhogg AI script | WORKS | Has rage timer (60 min), AOE_HIT_ALL, 2-hour ability (super_buff every 60-120s after first 30-90s), draw-in, higher stats than Fafnir, grants title. |
| Fafnir droplist | WORKS | Dragon Talon (100%), Andvaranauts (24%), Aegishjalmr (15%), Dragon Scales (24%x2), Dragon Heart (15%), Balmung (10%), Hrotti (10%), plus abjuration groups. |
| Nidhogg droplist | WORKS | Dragon Heart (100%), Dragon Blood (24%x2), Dragon Meat (5%), Nidhogg Scales (10%x4), Wyrm Beard (24%), plus abjuration groups (Earthen Body, Martial Body, Aquarian Body, Neptunal Legs). |
| Force-pop ??? | WORKS | QM hidden on spawn, restored after despawn (300s default). |

### Valley of Sorrows (Adamantoise / Aspidochelone)
| Item | Status | Notes |
|------|--------|-------|
| Adamantoise spawn point | WORKS | `mob_spawn_points.sql` entry exists (ID 17301537, zone 128, lv70). |
| Aspidochelone spawn point | WORKS | `mob_spawn_points.sql` entry exists (ID 17301538, zone 128, lv85). 50 spawn positions. |
| Aspidochelone AI script | WORKS | Very detailed: shell state mechanic (withdraw/emerge at 1000 HP intervals), 90s shell timer, massive REGEN (130) and -95% phys/ranged damage in shell, pops out with 3000 TP. Has rage timer, sleep/dark sleep immunity, Double Attack +20, AOE_HIT_ALL. |
| Aspidochelone droplist | WORKS | Adaman Ore (100% + 24% + 15%x2), Adamantoise Shell (15%), Adamantoise Egg (24%), Sipar (10%), plus abjuration groups (Aquarian Body, Dryadic Feet, Martial Feet, Wyrmal Body). |
| Force-pop ??? | WORKS | Same pattern as Fafnir. |

### Behemoth's Dominion (Behemoth / King Behemoth)
| Item | Status | Notes |
|------|--------|-------|
| Behemoth spawn point | WORKS | `mob_spawn_points.sql` entry exists (ID 17093000, zone 127, lv80). |
| King Behemoth AI script | WORKS | Very detailed: immunities (stun, silence, sleep, petrify), Meteor spell every 40s (AoE radius 25), stun additional effect (20% chance), rage timer 60 min, draw-in, Triple Attack +5, high ATT/DEF/EVA. 50 spawn positions. |
| King Behemoth droplist | WORKS | Behemoth Hide (100% + 15%), Behemoth Meat (5%), Behemoth Horn (100% + 15%), Shining Cloth (24%), Pixie Earring (95%), plus abjuration groups (Wyrmal Head, Earthen Legs, Martial Legs, Aquarian Feet). |
| Force-pop ??? | WORKS | Same pattern as Fafnir/Aspidochelone. |

---

## 4. NM Mob Scripts

| Item | Status | Notes |
|------|--------|-------|
| Total mob scripts (all zones) | WORKS | 4,286 mob scripts exist across all zones |
| NMs with rage timer mixin | WORKS | 39 NMs include `scripts/mixins/rage` |
| NMs with job_special mixin (2hr abilities) | WORKS | 1,004 mob scripts include `scripts/mixins/job_special` |
| NMs with draw-in mixin | WORKS | 33 NMs include `scripts/mixins/draw_in` |
| Lottery NM placeholder scripts | WORKS | 744 scripts use `phOnDespawn`/`phList` |
| Timed NM scripts | WORKS | 191 scripts use `setRespawnTime` |

### AI Quality Spot-Check
| NM | AI Features | Status |
|----|-------------|--------|
| Nidhogg | 2-hour ability (super_buff), draw-in boundary check, AOE_HIT_ALL, rage timer, high stats | WORKS |
| King Behemoth | Meteor every 40s (AoE r25), stun add effect, immunities (stun/silence/sleep/petrify), draw-in, Triple Attack | WORKS |
| Aspidochelone | Shell state mechanic with HP-based transitions, 90s shell timer, massive damage reduction in shell, TP on emerge, rage timer | WORKS |
| King Arthro | Knight Crab management (suppressed while KA up), complex respawn timer (21-24hr), paralysis add effect, fast cast | WORKS |
| Simurgh | Draw-in (range-based), 1-2hr timed respawn, always aggro, custom damage/EVA/ACC | WORKS |

---

## 5. Treasure Hunter System

| Item | Status | Notes |
|------|--------|-------|
| TH trait for THF | WORKS | Implemented in `src/map/utils/battleutils.cpp`. Requires THF main job + TH trait. |
| TH proc on hit | WORKS | First melee swing that deals damage can proc TH. Auto-upgrades mob TH level to player's TH mod level up to TH8, then probabilistic procs above that. |
| TH level cap | WORKS | Caps at 12 + job gift bonus (`TREASURE_HUNTER_CAP` mod). |
| TH drop rate scaling | WORKS | Full 15-tier table (TH0-TH14) in `scripts/globals/combat/treasure_hunter.lua`. Each tier boosts all drop brackets. |
| TH drop rate examples (at TH0 vs TH14) | WORKS | Common: 15% -> 70%, Rare: 5% -> 20%, VRare: 1% -> 1.5%, Super Rare: 0.5% -> 1.5% |
| Proc rate formula | WORKS | Base 4% proc rate, halved per TH level above player's TH mod. Feint and job gifts provide bonus. |
| Sneak/Trick Attack TH bonus | WORKS | SA/TA provide additional TH proc chance bonuses. |
| `DISABLE_TREASURE_HUNTER_PROCS` setting | WORKS | Can be disabled via `map.DISABLE_TREASURE_HUNTER_PROCS`. |

---

## 6. Field Caskets / Treasure System

| Item | Status | Notes |
|------|--------|-------|
| Casket framework | WORKS | `scripts/globals/caskets.lua` (912 lines) -- full implementation with spawn, lock mechanics, hints, and loot distribution. |
| Casket loot tables | WORKS | `scripts/globals/casket_loot.lua` (4,059 lines) -- extensive per-zone loot tables. |
| Casket types | WORKS | Supports Basic Chest, Blue/Brown/Bronze/Red/Gold Caskets, Odd Chest. |
| Lock combination system | WORKS | Number guessing game with hints (greater/less, even/odd, digit hints, range hints). |
| Spawn on mob kill | WORKS | Caskets spawn when monsters are killed, tracked via `SPAWNTIME` local var. |

---

## Blockers

1. **Pre-RMT drops not enabled** -- The server uses post-2007 nerfed drops by default. Famous items like Strider Boots, Emperor Hairpin, Speed Belt, Kraken Club, Peacock Charm, and others are replaced with lesser versions. The `toau` module in `modules/init.txt` would fix this, but it is not loaded.
   - **Fix:** Add `toau` to `modules/init.txt` and re-import SQL via dbtool.

2. **Leaping Lizzy base droplist is minimal** -- Even ignoring the pre-RMT issue, Leaping Lizzy's droplist (ID 103) only has Lizard Tail and Lizard Skin. The Nyzul Isle version (droplist 1504) has Bounding Boots. The pre-RMT module replaces "bounding_boots" with "leaping_boots" (not Strider Boots -- those are a different item). This is intentionally era-accurate: Strider Boots (item 13227) were never a Leaping Lizzy drop; Leaping Boots were the original, later nerfed to Bounding Boots.

3. **Valkurm Emperor has NO unique drops in overworld** -- CONFIRMED BUG. The overworld Valkurm Emperor (zone 77, mob_groups entry) is assigned droplist 571, which is a generic fly droplist containing only Insect Wing. The Empress Hairpin is on droplist 2533, which is only assigned to the Nyzul Isle version (zone 103). The pre-RMT module's `replace_drop('Valkurm_Dunes', 'Valkurm_Emperor', 'empress_hairpin', 'emperor_hairpin')` would fail silently because droplist 571 doesn't contain Empress Hairpin. This means Valkurm Emperor drops nothing unique in the overworld, even with the pre-RMT module enabled.

## Fix Difficulty
- **Pre-RMT drops**: Easy -- add `toau` to `modules/init.txt` and run dbtool
- **Valkurm Emperor droplist**: Medium -- need to either create a unique droplist for the overworld version or add Empress/Emperor Hairpin to droplist 571 (but 571 is shared with other flies). Best fix: create a new droplist for the mob_groups entry and assign it to zone 77's Valkurm Emperor.
- **Everything else**: Already working
