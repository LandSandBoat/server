# Battlefield Access Audit

**Audited:** 2026-03-28
**Scope:** Can players enter and complete all battlefield content without GM help?

---

## Summary

| System | Status | Notes |
|--------|--------|-------|
| BCNM (Orb fights) | WORKS | 104 Battlefield:new scripts, Shami sells orbs |
| ENM (Empty NM) | WORKS | 7 ENM scripts across Spires, Monarch Linn, etc. |
| Mission battlefields | WORKS | 42 BattlefieldMission scripts across all expansions |
| Quest battlefields (Maat, AF) | WORKS | Maat fights for all 15 base jobs, AF quest battles |
| Limbus | BROKEN | Swirling Vortex entry script entirely commented out |
| Dynamis | WORKS | All 10 entry NPCs functional, hourglass purchasable |
| Einherjar | DISABLED | EINHERJAR_ENABLED defaults to false, not set in settings |

---

## 1. BCNM (Burning Circle NM) -- WORKS

### Battlefield scripts per BCNM zone

| Zone | Script Count | Types |
|------|-------------|-------|
| Horlais Peak | 19 | 11 BCNM, 3 Maat, rank mission, Beyond Infinity, quest |
| Waughroon Shrine | 20 | 11 BCNM, 3 Maat, rank mission, Beyond Infinity, quest |
| Balga's Dais | 19 | 11 BCNM, 3 Maat, rank mission, Beyond Infinity, quest |
| Qu'Bia Arena | 19 | 11 BCNM, 3 Maat, rank 5, Beyond Infinity, quest |
| Throne Room | 4 | Shadow Lord, Kindred Spirits, mission/quest fights |
| Chamber of Oracles | 9 | 4 BCNM, 3 Maat (SAM/NIN/DRG), mission, quest |
| Sacrificial Chamber | 3 | 2 BCNM, 1 mission |
| Ghelsba Outpost | 5 | 3 BCNM, 2 mission/quest |

### Entry system
- **Entry NPC:** `BC_Entrance` (referenced by all battlefield scripts as `entryNpc`)
- Entry is handled by the C++ battlefield handler -- the Lua Battlefield:new() framework registers with `entryNpc` and `exitNpc` names
- The system handles item trading, registration, party entry, and time limits

### Orb acquisition (Shami in Port Jeuno)
- **File:** `scripts/zones/Port_Jeuno/npcs/Shami.lua`
- Shami sells all orb types for Beastmen Seals / Kindred Seals / Crests:
  - Cloudy Orb: 20 Beastmen's Seals
  - Sky Orb: 30 BS
  - Star Orb: 40 BS
  - Comet Orb: 50 BS
  - Moon Orb: 60 BS
  - Clotho/Lachesis/Atropos Orb: 30 Kindred's Seals each
  - Themis Orb: 99 Kindred's Seals
  - Phobos/Deimos Orb: 30/50 Kindred's Crests
  - Zelos/Bia Orb: 30/50 High Kindred's Crests
  - Microcosmic/Macrocosmic Orb: 10/20 Sacred Kindred's Crests
- Seals drop from mobs (handled in C++), so players can obtain them naturally

### Trusts in BCNMs
- **54 battlefields allow trusts** (`allowTrusts = true`)
- These are primarily mission/quest battlefields, not orb BCNMs
- Only 1 battlefield explicitly sets `allowTrusts = false` (Spire of Dem: You Are What You Eat)
- Standard orb BCNMs do NOT set allowTrusts, so they default to `false`
- This is correct retail behavior -- BCNMs did not allow trusts

### Verdict: WORKS
Players can earn seals from mobs, buy orbs from Shami, and enter BCNMs through Burning Circles. The full entry registration system is implemented in the Battlefield framework.

---

## 2. ENM (Empty Notorious Monster) -- WORKS

### ENM scripts found

| Zone | ENM Name | Level Cap | Entry Requirement |
|------|----------|-----------|-------------------|
| Spire of Holla | Simulant | 30 | KI: Censer of Abandonment |
| Spire of Dem | You Are What You Eat | 30 | (KI from Promyvion) |
| Spire of Mea | Playing Host | 30 | (KI from Promyvion) |
| Monarch Linn | Fire in the Sky | 99 | (ENM) |
| Monarch Linn | Beloved of the Atlantes | -- | (ENM) |
| Monarch Linn | Uninvited Guests | -- | (ENM) |
| Bearclaw Pinnacle | When Hell Freezes Over | -- | (ENM) |

### Entry system
- ENMs use the same Battlefield framework as BCNMs
- Entry requires key items obtained from the respective zones (e.g., Censer of Abandonment from Promyvion-Holla)
- The key items are given during zone exploration, not purchased

### Verdict: WORKS
ENM entry system functions through the standard battlefield framework. Key items are obtainable through normal gameplay.

---

## 3. Mission Battlefields -- WORKS

### Count: 42 BattlefieldMission scripts total

These are spread across:
- **Nation missions:** Rank 2 (Horlais/Waughroon/Balga), Rank 5 (Qu'Bia), Shadow Lord (Throne Room)
- **Zilart:** Return to Delkfutt's Tower, Ark Angels 1-5, Divine Might, Celestial Nexus
- **COP:** Spire fights (Holla/Dem/Mea/Vahzl), Storms of Fate, Ancient Vows, One to be Feared, Warrior's Path, Head Wind, Darkness Named, Century of Hardship, Flames for the Dead, When Angels Fall, Dawn, Apocalypse Nigh
- **ToAU:** Shield of Diplomacy, Puppet in Peril, Legacy of the Lost
- **WotG:** Purple the New Black
- **Other:** Sugar-coated Directive (6 Cloisters), Moonlit Path, Moon Reading

All use `BattlefieldMission:new()` which validates mission progress before entry. Most allow trusts.

### Verdict: WORKS (already audited in mission audits)

---

## 4. Quest Battlefields -- WORKS

### Maat / Shattering Stars (Limit Break 5)
All 15 base job Maat fights exist:
- Horlais Peak: WAR, BLM, RNG
- Waughroon Shrine: RDM, THF, BST
- Balga's Dais: MNK, WHM, SMN
- Qu'Bia Arena: PLD, DRK, BRD
- Chamber of Oracles: SAM, NIN, DRG

Each requires the job's testimony item (3 uses per testimony).

### Other quest battles
- Beyond Infinity: Horlais, Waughroon, Balga, Qu'Bia (4 scripts, allows trusts)
- The Secret Weapon (Horlais)
- On My Way, Thief in Norg (Waughroon)
- Saintly Invitation (Balga)
- Heir to the Light, Those Who Lurk in Shadows (Qu'Bia)
- Holy Crest, Save the Children (Ghelsba)
- Cat Burglar Bares Fangs, Through the Quicksand Caves (Chamber of Oracles)
- Temple of Uggalepih (Sacrificial Chamber)

### Verdict: WORKS

---

## 5. Limbus -- BROKEN

### Critical issue: Entry script is completely commented out

**File:** `scripts/zones/AlTaieu/npcs/Swirling_Vortex.lua`

The entire onTrigger and onEventFinish logic is commented out:
```lua
entity.onTrigger = function(player, npc)
    -- local offset = npc:getID() - ID.npc.SWIRLING_VORTEX_OFFSET
    -- if offset >= 0 and offset <= 1 then
    --     player:startEvent(159 + offset)
    -- end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- if csid == 160 and option == 1 then
    --     xi.limbus.enter(player, 1)
    -- elseif csid == 159 and option == 1 then
    --     xi.limbus.enter(player, 0)
    -- end
end
```

### Additionally: Internal zone logic is commented out
- `scripts/zones/Apollyon/Zone.lua` -- All teleporter trigger area logic is commented out
- `scripts/zones/Temenos/Zone.lua` -- All elevator trigger area logic is commented out
- There is no `scripts/globals/limbus.lua` file (the `xi.limbus.enter()` function called in the commented code does not exist)

### What IS implemented
- Apollyon and Temenos zone files exist with area registrations
- Sentinel Column (Apollyon) and Scanning Device (Temenos) NPCs can accept chip trades
- Battlefield IDs for all 18 Limbus encounters are defined (NW/SW/NE/SE/CS/Central Apollyon + Temenos towers and basement/floors)
- All 18 are marked "Converted" in battlefield.lua
- Cosmo-Cleanse purchasable from Sagheera in Port Jeuno (15,000 gil)
- Chip items exist in the item database

### What is NOT implemented
- No way to zone into Apollyon or Temenos from Al'Taieu (Swirling Vortex commented out)
- No `xi.limbus` global module exists
- Floor progression within Apollyon/Temenos is commented out

### Verdict: BROKEN -- Cannot enter Limbus at all. The backend (battlefields, mobs, loot) appears mostly implemented but the entry path and floor progression are disabled.

---

## 6. Dynamis -- WORKS

### Entry system
- **10 Dynamis entry NPCs** exist, one per Dynamis zone:
  - Trail Markings: San d'Oria, Bastok, Windurst (renamed from city zones), Beaucedine, Xarcabard
  - Hieroglyphics: Valkurm, Buburimu, Qufim, Tavnazia
  - Trail Markings: Ru'Lude Gardens (Jeuno)
- All call `xi.dynamis.entryNpcOnTrigger()` and `xi.dynamis.entryNpcOnEventFinish()`

### Entry requirements
- **Level minimum:** 65 (configurable via `DYNA_LEVEL_MIN`)
- **Prismatic Hourglass:** Required KI, purchased for 50,000 gil from Goblin NPCs
- **Vial of Shrouded Sand:** Required KI, obtained through initial Dynamis quest chain
- **Zone progression:**
  - Cities (Sandy/Bastok/Windy/Jeuno): No prerequisite beyond hourglass
  - Beaucedine: Requires beating all 4 city Dynamis (4 Hydra Corps KIs)
  - Xarcabard: Requires beating Beaucedine
  - Dreamlands (Valkurm/Buburimu/Qufim): Requires COP 3-5 completion OR FREE_COP_DYNAMIS setting
  - Tavnazia: Requires all 3 dreamland slivers

### Hourglass vendor NPCs
- **Haggleblix** (Beadeaux) -- Byne bill exchange
- **Antiqix** (Castle Oztroja) -- Shell exchange
- **Lootblox** (Davoi) -- Bronzepiece/silverpiece/goldpiece exchange
- All handle hourglass purchase, currency exchange, and item shops

### Verdict: WORKS -- Full Dynamis entry chain is functional. Players can obtain hourglass, enter all zones, and exchange currency.

---

## 7. Einherjar -- DISABLED BY DEFAULT

### Implementation status
- **Complete implementation exists** in `scripts/globals/einherjar/`:
  - `settings.lua` -- Configuration
  - `reservation.lua` -- Chamber reservation system
  - `chambers.lua` -- Chamber definitions
  - `lamp.lua` -- Smoldering/Glowing lamp system
  - `system.lua` -- Core system logic
  - `planner.lua` -- Chamber planning
  - `lockout.lua` -- Reentry lockout
  - `treasure.lua` -- Reward system

### Entry flow (when enabled)
1. Talk to **Kilusha** in Nashmau to buy Smoldering Lamp (60,000 gil; 1,000 with ROV KI)
2. Trade Smoldering Lamp to **Entry Gate (_260)** in Hazhalm Testing Grounds
3. Select a chamber to reserve -- lamp becomes Glowing Lamp
4. Trade Glowing Lamp to enter the reserved chamber
5. Requirements: Level 60+, ToAU Mission 2 (Immortal Sentries) completed

### The problem
- `EINHERJAR_ENABLED` defaults to `false` in `scripts/globals/einherjar/settings.lua` line 11
- This setting is NOT overridden in `settings/default/main.lua` or any custom settings
- The entry gate NPC (`_260.lua`) checks this at line 18: `if not xi.einherjar.settings.EINHERJAR_ENABLED then return end`
- Result: Trading a lamp to the entry gate does nothing

### Mob scripts exist
- Hazhalm Testing Grounds has mob scripts for bosses: Hildesvini, Motsognir, Freke, etc.
- Armoury Crate loot is implemented

### Fix required
Add to `settings/default/main.lua` (or custom settings):
```lua
EINHERJAR_ENABLED = true,
```

### Verdict: DISABLED -- Full implementation exists but is turned off by a single setting. Easy fix.

---

## Total Battlefield Script Count

| Category | Count |
|----------|-------|
| Battlefield:new (BCNM/ENM/quest) | 104 |
| BattlefieldMission:new (mission) | 42 |
| Limbus (defined but no scripts) | 18 IDs defined, 0 scripts |
| **Total battlefield scripts** | **146** |
| **Total battlefield IDs defined** | ~200 (includes unimplemented) |

---

## Key Files

- Battlefield framework: `scripts/globals/battlefield.lua`
- Orb vendor (Shami): `scripts/zones/Port_Jeuno/npcs/Shami.lua`
- Dynamis system: `scripts/globals/dynamis.lua`
- Dynamis entry NPCs: `scripts/zones/*/npcs/Trail_Markings.lua`, `scripts/zones/*/npcs/Hieroglyphics.lua`
- Dynamis hourglass NPCs: `scripts/zones/Davoi/npcs/Lootblox.lua`, `scripts/zones/Beadeaux/npcs/Haggleblix.lua`, `scripts/zones/Castle_Oztroja/npcs/Antiqix.lua`
- Einherjar settings: `scripts/globals/einherjar/settings.lua`
- Einherjar lamp vendor: `scripts/zones/Nashmau/npcs/Kilusha.lua`
- Einherjar entry: `scripts/zones/Hazhalm_Testing_Grounds/npcs/_260.lua`
- Limbus entry (BROKEN): `scripts/zones/AlTaieu/npcs/Swirling_Vortex.lua`
- Apollyon zone: `scripts/zones/Apollyon/Zone.lua`
- Temenos zone: `scripts/zones/Temenos/Zone.lua`
- Cosmo-Cleanse vendor: `scripts/zones/Port_Jeuno/npcs/Sagheera.lua`

---

## Action Items

1. **LIMBUS (High Priority):** Entry script at Swirling Vortex is entirely commented out. No `xi.limbus` module exists. This is a significant missing system -- Limbus provides AF+1 upgrade materials (Ancient Beastcoins, chip items) needed by Sagheera for artifact armor upgrades. Without Limbus, the AF+1 upgrade path documented in Sagheera's trade table is inaccessible.

2. **EINHERJAR (Low Priority):** Add `EINHERJAR_ENABLED = true` to settings. The full system is implemented and just needs the toggle flipped. Einherjar provides Therion Ichor for gear rewards from Kilusha.
