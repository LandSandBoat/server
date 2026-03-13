# ROV Mission TODO

## Known Bugs

### ROV 2-17 Sacrifice — Walk of Echoes Entry
- **Status**: Partially fixed (comment corrected)
- **Issue**: Players cannot reach Walk of Echoes (zone 182) to trigger the Ornate Door (`_521`)
- **Root Cause**: No functional entry point from Xarcabard [S] to Walk of Echoes is implemented
- **Script Fix Applied**: Comment corrected from `!pos -700 -20.25 -303.398 89` to `!pos -700 -20.25 -305.398 182` (zone 89=Grauberg_S was wrong, Z coord put player inside door)
- **Same fix applied to**: `scripts/missions/wotg/51_Maiden_of_the_Dusk.lua`
- **GM Workaround**: `!pos -700 -20.25 -305.398 182`
- **TODO**: Implement Walk of Echoes zone entry from Xarcabard [S]

---

## Stubbed Boss Battles

All boss fights currently auto-complete on zone-in. Mob data exists in SQL for all except Disjoined One.

### ROV 2-36 — Pretender to the Throne (Balamor)
- **File**: `scripts/missions/rov/2_36_Pretender_to_the_Throne.lua`
- **Zone**: Escha - Ru'Aun
- **Boss**: Balamor
- **Event Data**: Escha Ru'Aun events 6 (Selh'teus/Balamor pre-fight) and 7 (post-fight)
- **Mob Data**: Needs investigation
- **Difficulty**: Medium

### ROV 2-39 — Both Paths Taken (Disjoined One)
- **File**: `scripts/missions/rov/2_39_Both_Paths_Taken.lua`
- **Zone**: Empyreal Paradox (zone 36)
- **Boss**: Disjoined One
- **Battlefield**: Listed in Empyreal Paradox event 32000 as "Both Paths Taken"
- **Mob Data**: INCOMPLETE — mob_groups entry exists but NO mob_pools or mob_spawn_points entries
- **SQL needed**: mob_pools entry (pool ID, family, stats) and mob_spawn_points
- **Difficulty**: Medium-Hard

### ROV 3-17 — No Time Like the Future (Sempurne)
- **File**: `scripts/missions/rov/3_17_No_Time_Like_the_Future.lua`
- **Zone**: Desuetia - Empyreal Paradox (zone 290) — NOT regular Empyreal Paradox
- **Boss**: Sempurne
- **Battlefield**: Event 32000 in Desuetia-Empyreal Paradox
- **Event Data**: Event 2 (Sempurne dialogue), Cait Sith events 1-8 (cutscene support)
- **Mob Data**: Pool ID 4914, Family 475, Level 125, HP 20000, 3 spawn points
- **Mob Resistances**: Not found — needs investigation
- **Difficulty**: Medium

### ROV 3-26 — The Winds of Time (Metus)
- **File**: `scripts/missions/rov/3_26_The_Winds_of_Time.lua`
- **Zone**: Empyreal Paradox (zone 36)
- **Boss**: Metus
- **Battlefield**: Listed in Empyreal Paradox event 32000 as "The Winds of Time"
- **Event Data**: Empyreal Paradox events 9-17 surround this fight
- **Mob Data**: Pool ID 4820, Family 478 (Promathia-Metus), Level 125, HP 20000, 3 spawn points
- **Mob Resistances**: mob_resistances.sql line 529
- **Difficulty**: Medium (likely multi-phase)

### ROV 3-34 — The Orb's Radiance (Cloud of Darkness)
- **File**: `scripts/missions/rov/3_34_The_Orbs_Radiance.lua`
- **Zone**: Reisenjima Sanctorium (zone 293)
- **Boss**: Cloud of Darkness
- **Battlefield**: Event 32000 in Reisenjima Sanctorium ("The Orb's Radiance")
- **Event Data**: Reisenjima Sanctorium events 12-13 (Iroha/Selh'teus, Cloud of Darkness identified)
- **Mob Data**: Pool ID 4819, Family 497, Level 130, HP 20000, 3 spawn points
- **Mob Resistances**: mob_resistances.sql line 512
- **Cipher Reward**: Retail awards Cipher: Iroha II here — item not in DB
- **Difficulty**: Hard (final boss, likely complex phases, ally NPCs)

---

## Stubbed Kill Missions

Kill counter logic is implemented but mobs may not be spawning in-game.

### ROV 3-2 — The Brewing Storm
- **File**: `scripts/missions/rov/3_02_The_Brewing_Storm.lua`
- **Zone**: Reisenjima (zone 291)
- **Objective**: Kill 3 Perfervid Naraka
- **Mob Data**: Pool ID 5378, Family 472, Level 121-126, HP 9999, 11 spawn points, 180s respawn
- **Status**: Kill counter implemented. Verify mobs spawn in-game.
- **TODO**: Confirm mob scripts exist or create them. Test in-game.

### ROV 3-22 — From West to East
- **File**: `scripts/missions/rov/3_22_From_West_to_East.lua`
- **Zone**: Reisenjima (zone 291)
- **Objective**: Kill 11 Obstreperous Panopt
- **Mob Data**: Pool ID 5367, Family 463, Level 121-126, HP 9999, 32 spawn points, 180s respawn
- **Status**: Kill counter implemented. Verify mobs spawn in-game.
- **TODO**: Confirm mob scripts exist or create them. Test in-game.

---

## Missing Event IDs

These missions auto-complete without cutscenes. Event data not found in KnowOne134 CSID dumps.

### Eastern Adoulin Missions (ROV events mixed into SoA event infrastructure)
- **3-5 Forward Thinking** — Eastern Adoulin zone-in
- **3-7 What He Left Behind** — Eastern Adoulin zone-in
- **3-10 Solemnity** — Eastern Adoulin zone-in

### Walk of Echoes Missions (only event 28 found for Cait Sith/Lilisette)
- **3-15 What Remains of Hope** — Walk of Echoes zone-in
- **3-18 Sin** — Walk of Echoes zone-in
- **3-19 Penance** — Walk of Echoes zone-in (awards Rhapsody in Puce KI)
- **3-27 Calm After the Storm** — Walk of Echoes zone-in

### Reisenjima Missions (events 4, 5 unassigned)
- **3-21 The Lifestream of Reisenjima** — Reisenjima zone-in
- **3-23 Good Things Come in Threes** — Reisenjima zone-in

### Chapter 2 Missions (various zones)
- **2-26 Where Divinities Collide** — Shattered Telepoint (3 Crags)
- **2-27 Visions of Dread** — Hall of Transference zone-in
- **2-29 Escha Ru'Aun** — Misareaux Coast Undulating Confluence
- **2-30 The Decisive Heroine** — Escha Ru'Aun zone-in (events 2/4 likely)
- **2-31 Fall from Grace** — Shattered Telepoint (3 Crags)
- **2-33 Over the Rainbow** — Windurst Walls (Shantotto)
- **2-34 Cacophonous Discord** — Misareaux Coast Undulating Confluence
- **2-35 Eddies of Despair II** — Escha Ru'Aun zone-in
- **2-38 Call of the Void** — Telepoint at Crags (Dimensional Portal)

### Nation Zone-In Missions (no zone-specific events found)
- **2-41 Uncertain Futures** — nation zone-in (10 zones)
- **3-29 An Unending Song** — nation zone-in (10 zones)

---

## Missing Cipher Items

- **Cipher: Iroha** — awarded at ROV 3-28 (Nary a Cloud in Sight) on retail. Item not in `scripts/enum/item.lua`.
- **Cipher: Iroha II** — awarded at ROV 3-34 (The Orb's Radiance) on retail. Item not in `scripts/enum/item.lua`.

---

## Implementation Notes

### Battlefield Pattern Reference
See `scripts/battlefields/Empyreal_Paradox/dawn.lua` for a complete example of:
- `BattlefieldMission` class usage
- Multi-phase boss fights with ally NPCs
- Event 32001 victory detection → mission completion chain

### Event ID Sources
- **KnowOne134/FFXI_Events** — Dialogue text organized by actor
- **KnowOne134/DSP-Shared_Collection/Event CSID Dump** — CSID-to-dialogue mappings with actor IDs
- Client DAT files — definitive source for event IDs (requires DAT mining tools)
