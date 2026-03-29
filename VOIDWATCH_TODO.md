# Voidwatch Implementation Plan

## Status Key
- [ ] Not started
- [x] Complete
- [~] In progress
- [!] Blocked (see notes)

---

## Phase 0 — Data Gathering

- [x] **Dump event CSIDs** — extracted via xi-tinkerer from client DATs (`FFXI_DATS_Decoded/raw_data/events/`)
- [x] **Verify text IDs** — confirmed `output/` dump matches server IDs.lua (client `30251101_1`)
- [x] **Catalog Planar Rift event IDs** — all use CSIDs 6000/6001/6002 per zone
- [ ] **Identify NM mob IDs** — need mob entity data for Voidwatch battle zones

---

## Phase 1 — Foundation

### 1A. Database Schema
- [x] No new tables needed — uses existing `char_vars` and `char_points`
- [x] Voidstones already tracked in `char_points.voidstones`
- [x] Cruor already tracked in `char_points.cruor`
- [x] Items (cells, displacers, voiddust, petrifacts) already in `item_basic.sql`

### 1B. Global Voidwatch Module
- [x] Create `scripts/globals/voidwatch.lua` with:
  - [x] Constants: stratum abyssite KI IDs, periapt KI IDs, atmacite KI IDs
  - [x] Chapter/path/tier definitions
  - [x] Voidstone management functions (capacity, regen, grant, consume)
  - [x] Atmacite system (levels via char_vars, enrichment costs, infuse/remove)
  - [x] Progression helpers (tier checking, path access)
  - [ ] Spectral alignment calculation helpers
  - [ ] Reward calculation functions

---

## Phase 2 — NPC Scripts

### 2A. Voidwatch Officer (7 locations with CSIDs)

| Zone | Entity ID | CSIDs | Script | Status |
|------|-----------|-------|--------|--------|
| Southern San d'Oria | 17719635 | 977,978,979,981-985,963,993 | `Southern_San_dOria/npcs/Voidwatch_Officer.lua` | [ ] |
| Bastok Markets | 17739951 | 11,12,13,16-19,21,9,24 | `Bastok_Markets/npcs/Voidwatch_Officer.lua` | [ ] |
| Windurst Waters | 17752374 | 1035-1037,1039-1043,1024 | `Windurst_Waters/npcs/Voidwatch_Officer.lua` | [ ] |
| Batallia Downs | 17207943 | 10-17,8 | `Batallia_Downs/npcs/Voidwatch_Officer.lua` | [ ] |
| Rolanberry Fields | 17228397 | 9-16,7 | `Rolanberry_Fields/npcs/Voidwatch_Officer.lua` | [ ] |
| Sauromugue Champaign | 17269282 | 10-17,8 | `Sauromugue_Champaign/npcs/Voidwatch_Officer.lua` | [ ] |
| Qufim Island | 17293815 | 52-59,50 | `Qufim_Island/npcs/Voidwatch_Officer.lua` | [ ] |

### 2B. Voidwatch Purveyor (13 locations with CSIDs)

| Zone | Entity ID | CSIDs | Script | Status |
|------|-----------|-------|--------|--------|
| Southern San d'Oria | 17719636 | 975,993 | `Southern_San_dOria/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Bastok Markets | 17739952 | 10,24 | `Bastok_Markets/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Windurst Waters | 17752375 | 1034 | `Windurst_Waters/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Lower Jeuno | 17780980 | 10109 | `Lower_Jeuno/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Upper Jeuno | 17776885 | 10213 | `Upper_Jeuno/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Port Jeuno | 17784986 | 351 | `Port_Jeuno/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Ru'Lude Gardens | 17772838 | 10187 | `RuLude_Gardens/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Port Windurst | 17760468 | 875 | `Port_Windurst/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Northern San d'Oria | 17723671 | 877 | `Northern_San_dOria/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Bastok Mines | 17735871 | 288 | `Bastok_Mines/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Port Bastok | 17744058 | 32718-32720 | `Port_Bastok/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Windurst Woods | 17764602 | 836,848 | `Windurst_Woods/npcs/Voidwatch_Purveyor.lua` | [ ] |
| Aht Urhgan Whitegate | 16982636 | 968 | `Aht_Urhgan_Whitegate/npcs/Voidwatch_Purveyor.lua` | [ ] |

### 2C. Atmacite Refiner (3 city locations with CSIDs)

| Zone | Entity ID | CSIDs | Script | Status |
|------|-----------|-------|--------|--------|
| Southern San d'Oria | 17719634 | 962,993 | `Southern_San_dOria/npcs/Atmacite_Refiner.lua` | [ ] |
| Bastok Markets | 17739950 | 8,24 | `Bastok_Markets/npcs/Atmacite_Refiner.lua` | [ ] |
| Windurst Waters | 17752373 | 1023 | `Windurst_Waters/npcs/Atmacite_Refiner.lua` | [ ] |

### 2D. Ardrick (Jugner Forest)

| Zone | Entity ID | CSIDs | Status |
|------|-----------|-------|--------|
| Jugner Forest | 17203945 | 61,62 | [ ] |

---

## Phase 3 — Planar Rift & Battle System

### 3A. Planar Rift CSIDs (all zones use 6000/6001/6002 for rifts, 6003/6004/6005 for pyxis)

| Zone | Rift Entity IDs | Pyxis Entity IDs |
|------|----------------|-----------------|
| East Ronfaure | 17191577-79 | 17191580-82 |
| West Sarutabaruta | 17248914-16 | (check npc_list) |
| North Gustaberg | 17212116-18 | (check npc_list) |
| Jugner Forest | 17203939-41 | 17203942-44 |
| Ordelle's Caves | 17568199-201 | (check npc_list) |
| Gusgen Mines | 17580411-13 | (check npc_list) |
| Pashhow Marshlands | 17224371-73 | (check npc_list) |
| Maze of Shakhrami | 17588783-85 | (check npc_list) |
| Meriphataud Mountains | 17265315-17 | (check npc_list) |

### 3B. Battle Engine
- [ ] **Voidwatcher status effect** — proximity check to rift (~50 foot leash)
- [ ] **NM spawn logic** — 30-min despawn timer, full HP/MP restore on start
- [ ] **Void Cluster debuff** — reduce NM level by 5 per cluster (max -25)
- [ ] **Spectral alignment tracking** — 5 colors with caps

### 3C. Weakness/Stagger System
- [ ] Random vulnerability assignment per NM spawn (1 extreme, 2 high, 6 normal)
- [ ] Stagger window (5-30 sec based on tier)
- [ ] Synchronic Blitz bonus during stagger
- [ ] `/fume` emote reroll after 5 min alive

### 3D. Riftworn Pyxis (Rewards)
- [ ] Spawn after NM death at rift location
- [ ] Calculate loot from spectral alignment values
- [ ] Voidstone consumed on reward claim (not battle entry)
- [ ] NM-specific drop tables

---

## Phase 4 — NM Implementation

### Chapter I — Starter Nations (12 NMs, 3 paths x 4 tiers)

**San d'Oria Path (Crimson Stratum Abyssite I-IV)**:

| Tier | Zone | NM | Status |
|------|------|----|--------|
| I | East Ronfaure | TBD | [ ] |
| II | Ordelle's Caves | TBD | [ ] |
| III | Jugner Forest | TBD | [ ] |
| IV | King Ranperre's Tomb | TBD | [ ] |

**Bastok Path (Indigo Stratum Abyssite I-IV)**:

| Tier | Zone | NM | Status |
|------|------|----|--------|
| I | North Gustaberg | TBD | [ ] |
| II | Gusgen Mines | TBD | [ ] |
| III | Pashhow Marshlands | TBD | [ ] |
| IV | Dangruf Wadi | TBD | [ ] |

**Windurst Path (Jade Stratum Abyssite I-IV)**:

| Tier | Zone | NM | Status |
|------|------|----|--------|
| I | West Sarutabaruta | TBD | [ ] |
| II | Maze of Shakhrami | TBD | [ ] |
| III | Meriphataud Mountains | TBD | [ ] |
| IV | Outer Horutoto Ruins | TBD | [ ] |

### Chapter II+ NMs
- [ ] Chapter II — Jeuno/Zilart paths (5-6 NMs)
- [ ] Chapter III — Jeuno II/Tavnazia/Aht Urhgan paths (8-10 NMs)
- [ ] Provenance — 4 endgame battles (Walk of Echoes)

---

## Phase 5 — Atmacite Combat System

- [ ] Track atmacite ownership and levels per character (char_vars)
- [ ] Apply stat buffs during Voidwatch battles only
- [ ] Aura mechanics — party-only buffs in 10-foot radius (excluding self)
- [ ] Enrichment cost scaling with Rhapsody in Mauve discount
- [ ] All 40 atmacite types with correct stat bonuses per level

---

## Phase 6 — Quest Chain

- [ ] "Guardian of the Void" — entry quest (Walk of Echoes, requires WotG "Cait Sith")
- [ ] "Drafted by the Duchy" — follow-up quest
- [ ] Voidwatch Ops assignment/tracking per chapter
- [ ] Stratum abyssite upgrade triggers (defeat tier final NM → eligible for upgrade)

---

## Reference Data

### Event CSID Source
- **xi-tinkerer decoded DATs**: `FFXI_DATS_Decoded/raw_data/events/<Zone>.yml`
- **Verified text IDs**: `~/Code/Lua/Personal/UpdateExtractor/output/dialog-table-<zoneID>.xml`
- **Client version**: `30251101_1` (Nov 2025) — matches server text IDs

### Existing Codebase Assets
- **Key Items**: All atmacites (1806-1845), stratum abyssites, periapts (~80 KIs) in `scripts/enum/key_item.lua`
- **Status Effect**: VOIDWATCHER (ID 475) in `scripts/enum/effect.lua`
- **Quest IDs**: 5 defined in `scripts/globals/quests.lua` (IDs 100-104)
- **Voidstone counter**: `char_points.voidstones` + packet `0x113`
- **Cruor**: `char_points.cruor`
- **Items**: Cobalt Cell=3434, Rubicund Cell=3435, Xanthous Cell=3436, Jade Cell=3437, Voiddust=3450, Phase Displacer=3853, Crystal Petrifact=3508

### Template Systems
- **Abyssea vendor pattern**: `scripts/zones/Abyssea-Konschtat/npcs/Cruor_Prospector.lua`
- **NM spawn system**: `scripts/globals/voidwalker.lua`
- **Atma/buff system**: `scripts/globals/abyssea/atma.lua`

Testing checklist:
1. !addkeyitem 2048 — gives Voidwatch Alarum
2. Talk to Officer in Windurst Waters — see if CSID 1035 shows the right menu
3. Click each menu option and check the log for the option values
4. If CSID 1035 doesn't work, try the others: !cs 1036, !cs 1037, etc.
5. Same for Purveyor (CSID 1034) and Refiner (CSID 1023)
