# Limbus Enable Scope

## Executive Summary

Limbus is **disabled but substantially complete** in the codebase. A full reference implementation exists in `documentation/limbus/` with 15 files (the global module + 6 Apollyon areas + 8 Temenos areas). The work is primarily copying these reference files into place, uncommenting IDs, and adding missing text IDs.

**Upstream status**: Limbus is ALSO disabled upstream (LandSandBoat `base`). Every file checked -- Swirling_Vortex, Apollyon Zone.lua, Apollyon IDs.lua, Temenos IDs.lua, Sentinel_Column, Scanning_Device -- is identically commented out upstream. The `documentation/limbus/` directory is a pre-built implementation waiting to be installed.

**Estimated total effort**: 2-3 days of focused work.

---

## Component Breakdown

### 1. Entry System (Swirling Vortex in Al'Taieu)

**File**: `scripts/zones/AlTaieu/npcs/Swirling_Vortex.lua`
**Classification**: UNCOMMENT + DEPENDENCY

**What's commented out** (lines 6-23):
- `local ID = zones[xi.zone.ALTAIEU]` -- needs the NPC offset
- `onTrigger`: looks up NPC offset to start event 159 or 160
- `onEventFinish`: calls `xi.limbus.enter(player, 0)` or `xi.limbus.enter(player, 1)` based on which vortex

**What `xi.limbus.enter()` does** (from `documentation/limbus/limbus.lua` lines 10-21):
- Entrance 0: teleports player to Apollyon zone 38 at (-668, 0.1, -666) -- NW side
- Entrance 1: teleports player to Apollyon zone 38 at (643, 0.1, -600) -- SE side

**Dependencies**:
- Needs `xi.limbus` global module installed first
- Needs `SWIRLING_VORTEX_OFFSET` defined in Al'Taieu IDs.lua (must verify it exists)

**Work**: Uncomment 6 lines, ensure Al'Taieu IDs has the offset.

---

### 2. Cosmo-Cleanse / Chip System (Entry Items)

**File**: `scripts/zones/Port_Jeuno/npcs/Sagheera.lua`
**Classification**: WORKING

**Sagheera already handles**:
- Selling Cosmo Cleanse key item for 15,000 gil (or 1,000 with Rhapsody in Mauve)
- Cooldown timer (20h standard, 1h with Rhapsody in Mauve)
- AF+1 armor upgrade trades (requires Ancient Beastcoins + Temenos/Apollyon materials)
- Ancient Beastcoin storage/retrieval

**Key items verified in enum**: WHITE_CARD (349), RED_CARD (350), BLACK_CARD (351), COSMO_CLEANSE exists.

**Chip items**: Sentinel_Column accepts METAL_CHIP, SMALT_CHIP, SMOKY_CHIP, CHARCOAL_CHIP, MAGENTA_CHIP. Scanning_Device accepts METAL_CHIP, IVORY_CHIP, SCARLET_CHIP, EMERALD_CHIP plus items 1986/1908/1907.

**Work**: None needed. The entry item system is already functional.

---

### 3. Limbus Global Module

**File needed**: `scripts/globals/limbus.lua`
**Classification**: IMPLEMENT (copy from documentation)

**Reference**: `documentation/limbus/limbus.lua` (307 lines)

This file provides:
- `xi.limbus.enter(player, entrance)` -- zone-in teleport
- `xi.limbus.showRecoverCrate()` / `hideCrate()` / `spawnFrom()` / `spawnRecoverFrom()` -- crate management
- `Limbus` class extending `Battlefield` with:
  - `Limbus:new()`, `:register()`, `:onEventFinishEnter()`
  - `onBattlefieldInitialize()` -- sets up item/time/recover/loot crates with listeners
  - `onBattlefieldTick()` -- time tracking
  - `onBattlefieldEnter()` -- sets Cosmo_Cleanse_TIME
  - `onBattlefieldWin()` / `onBattlefieldLeave()` / `onBattlefieldDestroy()`
  - `extendTimeLimit()`, `openDoor()`, `closeDoors()`
  - Crate handlers: `handleOpenItemCrate`, `handleOpenTimeCrate`, `handleOpenRecoverCrate`, `handleOpenLootCrate`, `handleLinkedCrate`

**Dependencies**: Requires `scripts/globals/battlefield.lua` (exists) and `scripts/globals/interaction/container` (must verify).

**Work**: Copy `documentation/limbus/limbus.lua` to `scripts/globals/limbus.lua`. Verify it gets loaded (check if globals are auto-loaded or need explicit require).

---

### 4. Apollyon Zone

#### 4a. Apollyon IDs.lua
**File**: `scripts/zones/Apollyon/IDs.lua`
**Classification**: UNCOMMENT

**Currently commented out** (~190 of 245 lines):
- All mob IDs (lines 22-52): 30+ mob definitions for CS/NE/NW/SE/SW areas
- All NPC loot crate IDs (lines 56-61): CENTRAL/CS/NE/NW/SE/SW_LOOT_CRATE
- All sub-area definitions (lines 64-242): SW/SE/NW/NE/CENTRAL/CS_APOLLYON blocks containing:
  - NPC portal IDs
  - Item crate IDs
  - Recover crate IDs
  - Time crate IDs
  - Linked crate mappings

**Missing text IDs** (needed by limbus.lua but not in IDs.lua):
- `HUM`, `GATE_OPEN`, `TIME_EXTENDED`, `TIME_LEFT`, `YOU_INSERT_THE_CARD_POLISHED`

**Work**: Uncomment all mob/NPC/sub-area blocks. Add missing text IDs (need to find correct offsets for this zone).

#### 4b. Apollyon Zone.lua
**File**: `scripts/zones/Apollyon/Zone.lua`
**Classification**: UNCOMMENT

**Currently commented out** (lines 58-159): The entire `onTriggerAreaEnter` floor teleporter system -- a `switch/caseof` block handling 16 trigger areas for SE/NE/SW/NW teleporters between floors. Each checks if the portal animation is OPEN_DOOR before starting the cutscene.

**Active code**: `onInitialize` registers all trigger areas (works). `onEventFinish` handles SE_NE and NW_SW exits to Al'Taieu (works).

**Work**: Uncomment the teleporter switch block (~100 lines). This requires `ID.SE_APOLLYON.npc.PORTAL` etc. from IDs.lua to be uncommented first.

#### 4c. Apollyon Sentinel_Column NPC
**File**: `scripts/zones/Apollyon/npcs/Sentinel_Column.lua`
**Classification**: IMPLEMENT (needs onEventFinish)

**Currently**: Has onTrade (accepts chips) and onTrigger (shows menu) and onEventUpdate (shows timers). But **no onEventFinish handler** -- players can see which areas are active but cannot actually enter a Limbus instance through the column.

**Note**: The area scripts in `documentation/limbus/Apollyon/` use the `Limbus:new()` battlefield pattern with `entryNpc = '_127'` etc. The actual entry is handled by the Battlefield framework, not the Sentinel_Column directly. The column's chip trade starts an event, and the battlefield system's onEventFinish handles the actual entry.

**Work**: Need to add onEventFinish to handle chip consumption and battlefield entry. Check how other Limbus-style battlefields wire this up.

#### 4d. Apollyon Area Scripts (Battlefield Definitions)
**Directory needed**: `scripts/battlefields/Apollyon/` (does NOT exist)
**Classification**: IMPLEMENT (copy from documentation)

**Reference files in documentation/limbus/Apollyon/**:
- `sw_apollyon.lua` -- 616 lines, fully implemented with mob groups, loot tables, floor mechanics
- `se_apollyon.lua` -- SE area with 3 floors
- `ne_apollyon.lua` -- NE area with 4 floors
- `nw_apollyon.lua` -- NW area with 4 floors
- `central_apollyon.lua` -- Central area (Proto-Omega boss)
- `cs_apollyon.lua` -- CS area (combined boss area)

Each defines: `Limbus:new()` configuration, `content.sections` (event handlers), `content.groups` (mob groups with spawn/death logic), `content.loot` (per-crate loot tables), `content.paths` (mob patrol paths).

**Work**: Copy all 6 files to `scripts/battlefields/Apollyon/` (or wherever the battlefield system expects them -- need to verify path convention).

#### 4e. Apollyon Mob Scripts
**Directory**: `scripts/zones/Apollyon/mobs/`
**Classification**: EXISTS (37 mob scripts present)

**Key mobs present**: Proto-Omega (fully scripted with quadruped/biped/final form transitions, Pod Ejection, immunities), Kaiser_Behemoth, Tieholtsodi, Zlatorog, Cynoprosopi, Goobbue_Harvester, plus all the CS Apollyon faction mobs (Quadav, Yagudo, Orc variants).

**Potentially missing mobs** (referenced in sw_apollyon.lua but need to verify):
- Jidra / Jidra_Boss
- Fir_Bholg variants (THF/PLD/SAM/RDM/BLM)
- Arboricole variants (Hornet/Raven/Opo-opo/Spider/Beetle/Crawler)
- Apollyon_Sapling
- Various elementals (Air/Dark/Earth/Fire/Ice/Light/Thunder/Water)

Several of these DO exist as mob scripts already. The Fir_Bholg variants are present. Need to verify the others against what mob_spawn_points.sql contains.

---

### 5. Temenos Zone

#### 5a. Temenos IDs.lua
**File**: `scripts/zones/Temenos/IDs.lua`
**Classification**: UNCOMMENT

**Currently commented out** (~170 of 206 lines):
- NPC loot crate IDs (lines 26-33): C1/C2/C3/C4/CB/N/W_LOOT_CRATE
- TEMENOS_NORTHERN_TOWER block (lines 35-114): mob IDs, portal IDs, item/time/recover crate IDs, linked crates
- TEMENOS_WESTERN_TOWER block (lines 116-148): mob IDs, portal IDs, crate offsets
- TEMENOS_EASTERN_TOWER block (lines 150-181): mob IDs, portal IDs, crate offsets
- CENTRAL_TEMENOS_4TH_FLOOR block (lines 183-203): NPC groups, mob groups

**Missing**: No definitions for Central Temenos floors 1-3 or Basement (but reference implementations exist in documentation/limbus/Temenos/).

**Missing text IDs**: `HUM`, `GATE_OPEN`, `TIME_EXTENDED`, `TIME_LEFT`, `YOU_INSERT_THE_CARD_POLISHED`, `CITADEL_BASE` (Proto-Ultima uses CITADEL_BASE for Citadel Buster states).

Note: Temenos Zone.lua already references `ID.text.HUM` (line 92) and Proto-Ultima references `ID.text.CITADEL_BASE` (line 42), but these are NOT defined in IDs.lua. They need to be added.

**Work**: Uncomment all blocks, add missing sub-area definitions for Central floors 1-3 and Basement, add all missing text IDs.

#### 5b. Temenos Zone.lua
**File**: `scripts/zones/Temenos/Zone.lua`
**Classification**: UNCOMMENT

**Currently commented out** (lines 73-84): The `onTriggerAreaEnter` elevator system. Uses portal animation check and generates cutscene IDs from trigger area IDs.

**Active code**: All trigger area registrations (26 areas for N/E/W towers and Central floors). The `onEventFinish` is empty (needs handlers for the elevator cutscenes).

**Work**: Uncomment elevator logic (~12 lines). May also need onEventFinish handlers for the elevator cutscene completion.

#### 5c. Temenos Scanning_Device NPC
**File**: `scripts/zones/Temenos/npcs/Scanning_Device.lua`
**Classification**: IMPLEMENT (needs onEventFinish)

Same situation as Sentinel_Column -- has onTrade/onTrigger/onEventUpdate but no onEventFinish for actual entry.

#### 5d. Temenos Area Scripts (Battlefield Definitions)
**Directory needed**: `scripts/battlefields/Temenos/` (does NOT exist)
**Classification**: IMPLEMENT (copy from documentation)

**Reference files in documentation/limbus/Temenos/**:
- `temenos_northern_tower.lua` -- 7 floors, beastmen mobs
- `temenos_eastern_tower.lua` -- 7 floors, elemental mobs
- `temenos_western_tower.lua` -- 7 floors, beast mobs
- `central_temenos_4th_floor.lua` -- NPC/mob group spawning
- `central_temenos_3rd_floor.lua`
- `central_temenos_2nd_floor.lua`
- `central_temenos_1st_floor.lua`
- `central_temenos_basement.lua` -- Proto-Ultima boss area

**Work**: Copy all 8 files to correct location.

#### 5e. Temenos Mob Scripts
**Directory**: `scripts/zones/Temenos/mobs/`
**Classification**: EXISTS (79 mob scripts present)

Extensive mob coverage: Proto-Ultima (fully scripted with 5 phases, Citadel Buster mechanic, Dissipation, draw-in), all Mystic Avatars (Ifrit/Shiva/Garuda/Ramuh/Titan/Leviathan/Fenrir/Carbuncle plus _E variants), all elementals, beastmen faction mobs, Praetorian Guards, Cryptonberry mobs, etc.

---

### 6. Boss Fights

#### Proto-Omega (Apollyon)
**File**: `scripts/zones/Apollyon/mobs/Proto-Omega.lua`
**Classification**: EXISTS -- fully implemented

- Three forms: quadruped (phys resist), biped (magic resist), final (balanced)
- Form swapping every 2 minutes, final form at 25% HP
- Pod Ejection mechanic, stun additional effect
- Immunities, regain, counter mods

#### Proto-Ultima (Temenos)
**File**: `scripts/zones/Temenos/mobs/Proto-Ultima.lua`
**Classification**: EXISTS -- fully implemented

- Five phases based on HP thresholds (80/60/40/20%)
- Dissipation on phase changes, evolving skill lists
- Citadel Buster charging sequence with 10-state progression
- Draw-in mechanic, Holy II enabled in phase 3+
- Nuclear Waste -> random elemental conal combo

---

### 7. Loot System

**Classification**: IMPLEMENTED (in reference files)

Each area script in `documentation/limbus/` defines `content.loot` tables mapping crate IDs to weighted loot pools:
- **Ancient Beastcoins**: Primary currency, 5+ per crate, used for AF+1 upgrades at Sagheera
- **AF+1 crafting materials**: Temenos items (e.g., Spool of Light Filament, Ancient Brass Ingot) and Apollyon items (e.g., Argyro Rivet, Sheet of Kurogane)
- **Chips**: SW Apollyon drops Charcoal Chip (common) + Metal Chip (rare) from win crate
- **Rare materials**: Adaman Ore, Darksteel Sheet, Oxblood, etc.

The `Limbus:handleOpenItemCrate()` and `handleOpenLootCrate()` methods in limbus.lua use `self:handleLootRolls()` inherited from the Battlefield class.

---

## Missing Text IDs (Critical Blocker)

Both Apollyon and Temenos IDs.lua are missing required text IDs that the limbus.lua framework and area scripts reference:

| Text ID | Used By | Description |
|---------|---------|-------------|
| `HUM` | limbus.lua onEventFinishEnter, onBattlefieldLeave | Entry/exit message |
| `GATE_OPEN` | limbus.lua openDoor | Floor portal opened |
| `TIME_EXTENDED` | limbus.lua extendTimeLimit | Time crate bonus |
| `TIME_LEFT` | limbus.lua extendTimeLimit, openDoor | Remaining time display |
| `YOU_INSERT_THE_CARD_POLISHED` | All area scripts requiredKeyItems | Card consumption message |
| `CITADEL_BASE` | Proto-Ultima mob script | Citadel Buster charge messages (8 states) |

These must be found by checking the DAT files or upstream text ID documentation. The Temenos Zone.lua already uses `ID.text.HUM` meaning the ID was known at some point but never added to IDs.lua.

---

## Work Summary by Classification

### UNCOMMENT (straightforward)
1. Swirling_Vortex.lua entry logic (6 lines)
2. Apollyon IDs.lua mob/NPC/sub-area blocks (~190 lines)
3. Apollyon Zone.lua teleporter switch (~100 lines)
4. Temenos IDs.lua NPC/sub-area blocks (~170 lines)
5. Temenos Zone.lua elevator logic (~12 lines)

### IMPLEMENT (copy from documentation + adapt)
1. `scripts/globals/limbus.lua` -- copy from `documentation/limbus/limbus.lua` (307 lines)
2. 6 Apollyon battlefield scripts -- copy from `documentation/limbus/Apollyon/`
3. 8 Temenos battlefield scripts -- copy from `documentation/limbus/Temenos/`
4. Sentinel_Column onEventFinish handler
5. Scanning_Device onEventFinish handler
6. Missing text IDs for both zones
7. Missing Temenos IDs.lua sub-area definitions (Central floors 1-3, Basement)

### VERIFY (may need fixes)
1. Battlefield system wiring -- how `Limbus:new()` with `entryNpc` connects to Sentinel_Column/Scanning_Device events
2. Al'Taieu IDs.lua has SWIRLING_VORTEX_OFFSET defined
3. Global auto-loading includes limbus.lua
4. All mob scripts referenced in area files exist in mobs/ directories
5. mob_spawn_points.sql has all required mobs for each floor
6. NPC entities in npc_list.sql match the hardcoded IDs in the reference files

### NOT NEEDED
1. Sagheera / Cosmo-Cleanse purchasing -- already works
2. Proto-Omega mob script -- fully implemented
3. Proto-Ultima mob script -- fully implemented
4. Key item definitions (cards, cosmo cleanse) -- already in enum

---

## Recommended Implementation Order

1. **Install limbus.lua global** -- foundation for everything else
2. **Add missing text IDs** to both Apollyon and Temenos IDs.lua -- blocker for all area scripts
3. **Uncomment Apollyon IDs.lua** -- enables zone data
4. **Uncomment Temenos IDs.lua** + add missing sub-area defs
5. **Copy Apollyon area scripts** (6 files) from documentation
6. **Copy Temenos area scripts** (8 files) from documentation
7. **Uncomment Zone.lua teleporters** for both zones
8. **Wire up Sentinel_Column + Scanning_Device** event finish handlers
9. **Uncomment Swirling_Vortex** entry system
10. **Verify mob spawn points** in SQL match what area scripts expect
11. **Test each area** individually (SW Apollyon first as simplest)

---

## Risk Assessment

- **Low risk**: Uncommenting IDs and Zone.lua teleporters
- **Medium risk**: Text ID discovery (wrong offsets = garbled messages or crashes)
- **Medium risk**: Battlefield wiring for entry NPCs (may need to study how other battlefields like Dynamis connect)
- **High risk**: Mob spawn point mismatches between SQL and Lua (IDs are hardcoded in reference files, may not match current database)
- **Note**: The reference implementation in `documentation/limbus/` appears to be a complete, tested system. The primary challenge is installation and verification, not implementation from scratch.
