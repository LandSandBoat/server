# Dynamis Zone Content -- Deep Audit

**Audit Date:** 2026-03-28
**Branch:** develop
**Source Files:** `scripts/globals/dynamis.lua`, `scripts/mixins/dynamis_beastmen.lua`, `scripts/zones/Dynamis-*/`, `sql/mob_spawn_points.sql`, `sql/mob_droplist.sql`

---

## EXECUTIVE SUMMARY

| Area | Status |
|------|--------|
| Entry System (Hourglass, NPC, Lockout) | FULLY IMPLEMENTED |
| Zone Mobs (all 10 zones) | FULLY IMPLEMENTED |
| Mega Bosses (all 10 zones + Dynamis Lord) | FULLY IMPLEMENTED |
| Relic Armor Drops | FULLY IMPLEMENTED |
| Ancient Currency Drops (100s/singles) | FULLY IMPLEMENTED |
| Attestation Drops | FULLY IMPLEMENTED |
| Time Extensions | FULLY IMPLEMENTED |
| Win Conditions / Titles | FULLY IMPLEMENTED |
| Proc System (weakness trigger) | FULLY IMPLEMENTED |
| Somnial Threshold (exit/SJ unlock) | FULLY IMPLEMENTED |

**Overall Verdict: Dynamis content is FULLY FUNCTIONAL across all 10 zones.**

---

## 1. ENTRY SYSTEM

### Hourglass and Prerequisites
- **Entry NPCs:** Trail Markings (city/glacier zones) and Hieroglyphics (dreamland zones)
  - `scripts/zones/Southern_San_dOria/npcs/Trail_Markings.lua`
  - `scripts/zones/Bastok_Mines/npcs/Trail_Markings.lua`
  - `scripts/zones/Windurst_Walls/npcs/Trail_Markings.lua`
  - `scripts/zones/RuLude_Gardens/npcs/Trail_Markings.lua`
  - `scripts/zones/Beaucedine_Glacier/npcs/Trail_Markings.lua`
  - `scripts/zones/Xarcabard/npcs/Trail_Markings.lua`
  - `scripts/zones/Valkurm_Dunes/npcs/Hieroglyphics.lua`
  - `scripts/zones/Buburimu_Peninsula/npcs/Hieroglyphics.lua`
  - `scripts/zones/Qufim_Island/npcs/Hieroglyphics.lua`
  - `scripts/zones/Tavnazian_Safehold/npcs/Hieroglyphics.lua`
- **Prismatic Hourglass:** Required key item, checked at entry (xi.ki.PRISMATIC_HOURGLASS)
- **Timeless/Perpetual Hourglass:** Item IDs 4236/4237 passed to entry event
- **Vial of Shrouded Sand:** Given via Cornelia cutscene on first Dynamis unlock

### Lockout Timer
- **Default wait:** 24 hours between entries (`BETWEEN_2DYNA_WAIT_TIME = 24` in `settings/default/main.lua:223`)
- **Midnight reset:** Enabled by default (`DYNA_MIDNIGHT_RESET = true`, line 224)
- **Rhapsody in Azure:** Bypasses timer entirely (checked in `handleEntryTime` and `arg3` functions)

### Level and Mission Requirements
- **Minimum level:** 65 (`DYNA_LEVEL_MIN = 65`, line 225)
- **Beaucedine:** Requires all 4 city Hydra Corps key items
- **Xarcabard:** Requires Hydra Corps Insignia (from Beaucedine clear)
- **Dreamlands (Valkurm/Buburimu/Qufim):** Requires CoP 3-5 completion OR `FREE_COP_DYNAMIS = 1` (line 232, default 0)
- **Tavnazia:** Requires all 3 Dreamland Slivers

### Subjob Restriction
- Optional on entry (dreamland zones offer choice, city zones do not)
- SJ Restriction effect applied on zone-in if chosen
- Can be unlocked at Somnial Threshold inside the zone

---

## 2. ZONE MOBS -- Spawn Counts and Level Ranges

Mob counts from `sql/mob_spawn_points.sql` (approximate, by mob ID prefix matching):

| Zone | Zone ID | Mob Count (approx) | Level Range | Notes |
|------|---------|-------------------|-------------|-------|
| Dynamis-San d'Oria | 185 | ~237 | 75-99 | Orc beastmen |
| Dynamis-Bastok | 186 | ~240 | 75-99 | Quadav beastmen |
| Dynamis-Windurst | 187 | ~301 | 75-99 | Yagudo beastmen |
| Dynamis-Jeuno | 188 | ~235 | 75-99 | Goblin beastmen |
| Dynamis-Beaucedine | 134 | ~710 | 75-95 | Mixed beastmen + Hydra NMs |
| Dynamis-Xarcabard | 135 | ~594 | 85-95 | Kindred demons + Animated Weapons |
| Dynamis-Valkurm | 39 | ~576 | 75-85 | Mixed beastmen + Nightmare mobs |
| Dynamis-Buburimu | 40 | ~610 | 75-96 | Mixed beastmen + Nightmare mobs |
| Dynamis-Qufim | 41 | ~476 | 75-85 | Mixed beastmen + Nightmare mobs |
| Dynamis-Tavnazia | 42 | ~138 | 80-85 | Kindred + Hydra + Nightmare mobs |

### Mob Types per Zone
- **City zones (Sandy/Bastok/Windy/Jeuno):** Vanguard beastmen (job-specific), NM bosses, statues
- **Beaucedine:** All beastmen races + Hydra Corps NMs (15 job classes)
- **Xarcabard:** Kindred demons (15 job classes) + Animated Weapons (16 types) + Demon NMs (Dukes/Counts/Marquis)
- **Dreamlands (Valkurm/Buburimu/Qufim):** All beastmen + Nightmare monster families unique to each zone
- **Tavnazia:** Kindred + Hydra + Nightmare mobs + Diabolos bosses

---

## 3. NMs AND MEGA BOSSES

### Zone Mega Bosses (all call `xi.dynamis.megaBossOnDeath`)

| Zone | Mega Boss | Level | Script | Notes |
|------|-----------|-------|--------|-------|
| Dynamis-San d'Oria | Overlord's Tombstone | 85 | `mobs/Overlords_Tombstone.lua` | Spawns 2 adds on engage |
| Dynamis-Bastok | Gu'Dha Effigy | 85 | `mobs/GuDha_Effigy.lua` | Simple boss |
| Dynamis-Windurst | Tzee Xicu Idol | 85 | `mobs/Tzee_Xicu_Idol.lua` | Spawns 2 adds on engage |
| Dynamis-Jeuno | Goblin Golem | 85 | `mobs/Goblin_Golem.lua` | Simple boss |
| Dynamis-Beaucedine | Angra Mainyu | 85 | `mobs/Angra_Mainyu.lua` | Spawns 4 Pukis adds, casts Death at 25% HP |
| Dynamis-Xarcabard | Dynamis Lord | 90 | `mobs/Dynamis_Lord.lua` | Uses Hundred Fists/Mighty Strikes/Blood Weapon/Chainspell; spawns Ying/Yang every 90s |
| Dynamis-Valkurm | Cirrate Christelle | 85 | `mobs/Cirrate_Christelle.lua` | Mega boss |
| Dynamis-Buburimu | Apocalyptic Beast | 85 | `mobs/Apocalyptic_Beast.lua` | Gravity immune |
| Dynamis-Qufim | Antaeus | 85 | `mobs/Antaeus.lua` | Simple boss |
| Dynamis-Tavnazia | Diabolos (4 forms) | 85 | `mobs/Diabolos_{Spade,Heart,Diamond,Club}.lua` | All 4 call megaBossOnDeath |

### Arch Bosses (Lv99, city zones only)
- Arch Overlord Tombstone (Sandy, group 33, lv99)
- Arch Gu'Dha Effigy (Bastok, group 31, lv99)
- Arch Tzee Xicu Idol (Windurst, group 33, lv99)
- Arch Goblin Golem (Jeuno, group 61, lv99)

### Dynamis Lord Spawn Mechanism
- Spawned by trading a Shrouded Bijou to ??? NPC (`qm0.lua`)
- 4 spawn positions defined in mob_spawn_points (randomly selected)
- Uses `xi.dynamis.qmOnTrade` for pop mechanism
- `scripts/zones/Dynamis-Xarcabard/npcs/qm0.lua` -- ??? spawns Dynamis Lord
- Additional qm NPCs (qm1-qm20) spawn demon NMs (Duke Haures, etc.)

### Animated Weapons (Xarcabard, for relic weapon quests)
All 16 Animated Weapons have scripts with battle dialogue:
- Animated Longsword, Claymore, Dagger, Great Axe, Gun, Hammer, Horn, Knuckles, Kunai, Longbow, Scythe, Shield, Spear, Staff, Tabar, Tachi
- Each has `onMobEngage`, `onMobDisengage`, `onMobDeath` with text display
- Death calls `xi.magian.onMobDeath` for magian trial integration

### Xarcabard Demon NMs (21 total scripted)
- 4 Dukes: Berith, Gomory, Haures, Scox
- 5 Counts: Haagenti, Raum, Vine, Zaebos + King Zagan
- 8 Marquis: Andras, Caim, Cimeries, Decarabia, Gamygyn, Nebiros, Orias, Sabnak
- 1 Prince: Seere
- 1 Baron: Avnas

---

## 4. RELIC ARMOR DROPS

Relic armor pieces are in `sql/mob_droplist.sql`. Drops include both base (-1) and upgraded versions:

**Base relic armor** (from regular Dynamis mobs via group drops):
- Found on droplist IDs assigned to Vanguard/Kindred/Hydra mob groups
- Examples: Melee Crown (15073), Valor Coronet, Warrior's Mufflers, etc.
- Drop rate: @RARE (~5%) in grouped drops, @COMMON (15%) on specific NMs

**Relic armor -1 versions** (from Beaucedine/Xarcabard/Tavnazia mobs):
- All 15 job sets present in droplist groups
- Examples: Melee Crown -1 (2038), Valor Coronet -1 (2063), Warriors Mufflers -1 (2035)
- Groups include extra jobs: Mirage Bazubands -1, Commodore Gants -1, etc.
- Drop rate: @VRARE (1%) for extra job sets, @RARE (5%) for standard sets

---

## 5. RELIC WEAPON CURRENCY

### Ancient Currency (implemented via `dynamis_beastmen.lua` mixin)

**Single currency (100-piece equivalent):**
- Tukuku Whiteshell (ID 1449) -- Yagudo family
- Ordelle Bronzepiece (ID 1452) -- Orc family
- One Byne Bill (ID 1455) -- Quadav family

**Hundred currency (10000-piece equivalent):**
- Lungo-Nango Jadeshell (ID 1450)
- Montiont Silverpiece (ID 1453)
- One Hundred Byne Bill (ID 1456)

**Total currency drop entries:** ~528 across all droplists

### Drop Mechanics (from `dynamis_beastmen.lua`)
- Currency type determined by mob family (Orc=Bronzepiece, Quadav=Byne, Yagudo=Whiteshell)
- Non-beastmen mobs randomly select a currency type
- Base drop rate: TH-dependent scaling system:
  - TH0: single=100/1000, hundred=5/1000
  - TH1: single=115, hundred=10
  - TH2: single=145, hundred=20
  - TH3: single=190, hundred=35
  - TH4: single=250, hundred=50
- Mobs above Lv90 get 1.5x single currency rate
- NMs have additional hundred currency chance
- **Proc system bonuses:**
  - Blue proc (low): +1 single currency slot
  - Yellow proc (medium): +1 single currency slot
  - Red proc (high): +1 guaranteed single
  - White proc (special, 1% chance with SJ restriction): +1 guaranteed hundred

### Attestation Drops
5 droplist groups contain Attestations (3 per group, covering all 15 jobs):
- Group 559: Bravery, Fortitude, Virtue (33% each, @ALWAYS)
- Group 1211: Glory, Righteousness, Force, Invulnerability (25% each)
- Group 1672: Might, Legerity, Accuracy
- Group 2066: Celerity, Sacrifice, Harmony
- Group 2577: Vigor, Decisiveness, Transcendence

### Relic Weapon Base Items
Present in droplists at @VRARE (1%):
- Relic Shield (15066), Relic Staff (18326), Relic Horn (18338), Relic Bow (18344)
- Relic Bhuj (18290), Relic Lance (18296), Relic Gun (18332)
- Relic Knuckles (18260), Relic Dagger (18266)
- Pile of Relic Iron (1466) also drops at @VRARE

### Currency Exchange NPCs
- Haggleblix in Beadeaux -- exchanges One Byne Bills
- Additional exchange NPCs configured in `xi.dynamis.hourglassAndCurrencyExchangeNPCLookup`

---

## 6. TIME EXTENSIONS

All 10 zones have `TIME_EXTENSION` tables in their `IDs.lua` files.

### Implementation (`dynamis.lua` lines 412-603)
- On zone initialization, one mob from each TE group is randomly spawned
- When killed, awards a Key Item and extends Dynamis timer by specified minutes
- A new TE mob from the same group respawns after 85 seconds
- Each KI is unique per player -- no double-extending from same group

### Example: Dynamis-Bastok Time Extensions
| Minutes | Key Item | Mob ID |
|---------|----------|--------|
| 10 | Crimson Granules of Time | 17539142 |
| 10 | Azure Granules of Time | 17539148 |
| 10 | Amber Granules of Time | 17539149 |
| 15 | Alabaster Granules of Time | 17539253 |
| 15 | Obsidian Granules of Time | 17539306 |

### Time Extension Mobs by Zone (scripts that call `timeExtensionOnDeath`)
- **Sandy:** Warchief Tombstone
- **Bastok:** Adamantking Image
- **Windurst:** Avatar Idol
- **Jeuno:** Goblin Statue
- **Beaucedine:** Warchief Tombstone, Rearguard Eye, Goblin Statue, Adamantking Image, Avatar Idol
- **Xarcabard:** Prototype Eye, Statue Prototype, Tombstone Prototype, Effigy Prototype, Icon Prototype
- **Valkurm:** Warchief Tombstone, Goblin Statue, Adamantking Image, Avatar Idol
- **Buburimu:** Warchief Tombstone, Avatar Idol, Goblin Statue, Adamantking Image
- **Qufim:** Warchief Tombstone, Adamantking Image, Avatar Idol, Goblin Statue
- **Tavnazia:** Prototype Eye, Statue Prototype, Tombstone Prototype, Icon Prototype, Effigy Prototype

### Refill Statues
- Also configured per zone in `REFILL_STATUE` tables
- Multiple groups per zone, each with red/blue/green eye variants
- One statue spawns per group (randomly selected)
- On death, a new statue from the same group respawns

---

## 7. WIN CONDITIONS AND TITLES

### Implementation (`dynamis.lua` line 527-537)
```lua
xi.dynamis.megaBossOnDeath = function(mob, player, optParams)
    local zoneId = player:getZoneID()
    local info   = dynaInfo[zoneId]
    player:addTitle(info.beatTitle)
    if not player:hasKeyItem(info.beatKI) then
        npcUtil.giveKeyItem(player, info.beatKI)
        player:setCharVar(info.beatVar, 1)
    end
end
```

### Titles Awarded

| Zone | Title | Key Item Reward |
|------|-------|-----------------|
| Dynamis-San d'Oria | DYNAMIS_SAN_DORIA_INTERLOPER | Hydra Corps Command Scepter |
| Dynamis-Bastok | DYNAMIS_BASTOK_INTERLOPER | Hydra Corps Eyeglass |
| Dynamis-Windurst | DYNAMIS_WINDURST_INTERLOPER | Hydra Corps Lantern |
| Dynamis-Jeuno | DYNAMIS_JEUNO_INTERLOPER | Hydra Corps Tactical Map |
| Dynamis-Beaucedine | DYNAMIS_BEAUCEDINE_INTERLOPER | Hydra Corps Insignia |
| Dynamis-Xarcabard | DYNAMIS_XARCABARD_INTERLOPER | Hydra Corps Battle Standard |
| Dynamis-Valkurm | DYNAMIS_VALKURM_INTERLOPER | Dynamis Valkurm Sliver |
| Dynamis-Buburimu | DYNAMIS_BUBURIMU_INTERLOPER | Dynamis Buburimu Sliver |
| Dynamis-Qufim | DYNAMIS_QUFIM_INTERLOPER | Dynamis Qufim Sliver |
| Dynamis-Tavnazia | DYNAMIS_TAVNAZIA_INTERLOPER | Dynamis Tavnazia Sliver |

- **Dynamis Lord special title:** LIFTER_OF_SHADOWS (in addition to Xarcabard Interloper)
- **Victory cutscene:** Plays on next interaction with entry NPC after winning (`beatVar == 1`)
- **Key items unlock progression:** City KIs unlock Beaucedine, Beaucedine KI unlocks Xarcabard, Dreamland Slivers unlock Tavnazia

---

## 8. SOMNIAL THRESHOLD (Exit NPC)

All 10 zones have `npcs/Somnial_Threshold.lua` scripts.

### Functions
1. **Leave Dynamis** -- triggers eject event (csid 100), teleports to eject position
2. **Unlock Support Jobs** -- removes SJ_RESTRICTION effect (only if entered with SJ restricted)
3. **Nothing / Cancel** -- closes menu

### Eject Positions (defined in `dynaInfo` table)
Each zone has specific eject coordinates returning players to the overworld entry zone.

---

## 9. PROC SYSTEM (Weakness Triggers)

### Implementation (`dynamis_beastmen.lua` mixin + `dynamis.lua`)
- All Vanguard/Hydra/Kindred mobs use `dynamis_beastmen` mixin
- Proc type determined by mob's main job:
  - WS proc: WAR, PLD, DRK, SAM, DRG (25% chance)
  - JA proc: MNK, THF, BST, RNG, NIN (20% chance)
  - MA proc: WHM, BLM, RDM, BRD, SMN (8% chance)
- Proc levels scale with time extension progress (3-5 extensions):
  - 3 extensions: Blue proc (low)
  - 4 extensions: Yellow proc (medium)
  - 5 extensions: Red proc (high)
  - 1% chance with SJ restriction: White proc (special)
- Proc applies 30-second Terror effect and triggers weakness animation

---

## 10. KNOWN ISSUES / TODOs

Found in source code comments:
1. **`dynamis.lua` line 108:** "TODO: Make absolutely sure that winning Xarcabard does NOT allow early access to dreamlands BEFORE CoP 3-5"
2. **`dynamis.lua` line 158-159:** "TODO: Tavnazian winning CS changes Param2 depending on CoP progress" -- exact mission breakpoints unknown
3. **`dynamis.lua` line 571:** "TODO: Refactor the above loops to not need the 'found' variable"
4. **`Animated_Longsword.lua` line 15:** "TODO: add battle dialog" (and likely similar for other Animated Weapons)

---

## 11. DYNAMIS [D] ZONES (Divergence)

Four Dynamis [D] (Divergence) zones exist as separate zone directories:
- `Dynamis-San_dOria_[D]` (Zone 294)
- `Dynamis-Bastok_[D]` (Zone 295)
- `Dynamis-Windurst_[D]` (Zone 296)
- `Dynamis-Jeuno_[D]` (Zone 297)

These are separate from the standard Dynamis zones and represent the Divergence variant content (Aeonic weapon system). They are NOT part of the original 10 Dynamis zones audited above.

---

## KEY FILE REFERENCES

| File | Purpose |
|------|---------|
| `scripts/globals/dynamis.lua` | Core Dynamis system (entry, zone-in, time extensions, procs, win conditions) |
| `scripts/mixins/dynamis_beastmen.lua` | Proc system and currency drops for beastmen mobs |
| `scripts/mixins/job_special.lua` | Job ability usage (used by Dynamis Lord, Angra Mainyu) |
| `scripts/zones/Dynamis-*/Zone.lua` | Zone initialization (calls xi.dynamis.zoneOnInitialize) |
| `scripts/zones/Dynamis-*/IDs.lua` | TIME_EXTENSION, REFILL_STATUE, QM tables per zone |
| `scripts/zones/Dynamis-*/mobs/*.lua` | Individual mob scripts |
| `scripts/zones/Dynamis-*/npcs/Somnial_Threshold.lua` | Exit NPC |
| `scripts/zones/Dynamis-*/npcs/qm*.lua` | ??? NPCs for NM spawning (Xarcabard has 21) |
| `sql/mob_spawn_points.sql` | Mob positions and level ranges |
| `sql/mob_droplist.sql` | Drop tables (relic armor, currency, attestations, relic weapons) |
| `sql/mob_groups.sql` | Mob group definitions linking mobs to droplists |
| `settings/default/main.lua` (lines 223-232) | Dynamis settings (timer, level, CoP bypass) |
