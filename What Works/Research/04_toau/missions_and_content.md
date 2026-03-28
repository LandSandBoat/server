# Treasures of Aht Urhgan -- Missions & Content Systems

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Treasures_of_Aht_Urhgan_Missions
- Codebase: `scripts/missions/toau/`, `scripts/globals/assault.lua`, `scripts/globals/besieged.lua`, `scripts/globals/salvage.lua`, `scripts/globals/nyzul.lua`, `scripts/globals/einherjar/`, `scripts/globals/transport.lua`

## Summary
All 48 ToAU missions have scripts and appear to be fully implemented (no stubs). Near East zones are fully present with transport from Mhaura. Endgame content systems vary: Nyzul Isle Investigation and Einherjar are substantially implemented, Salvage has all 4 remnant zones scripted, Assault has only 9 of 50 scenarios implemented, and Besieged battles do not exist (only the NPC/currency/Sanction framework).

---

## 1. ToAU Missions (48/48 scripts exist)

| # | Mission | Lines | Status | Notes |
|---|---------|-------|--------|-------|
| 1 | Land of Sacred Serpents | 48 | WORKS | Entry to Whitegate |
| 2 | Immortal Sentries | 180 | WORKS | Largest early mission |
| 3 | President Salaheem | ~55 | WORKS | |
| 4 | Knight of Gold | 109 | WORKS | |
| 5 | Confessions of Royalty | 47 | WORKS | |
| 6 | Easterly Winds | ~55 | WORKS | |
| 7 | Westerly Winds | 67 | WORKS | |
| 8 | A Mercenary Life | 90 | WORKS | |
| 9 | Undersea Scouting | ~55 | WORKS | |
| 10 | Astral Waves | ~55 | WORKS | |
| 11 | Imperial Schemes | 73 | WORKS | |
| 12 | Royal Puppeteer | 77 | WORKS | |
| 13 | Lost Kingdom | 111 | WORKS | |
| 14 | The Dolphin Crest | 42 | WORKS | |
| 15 | The Black Coffin | 97 | WORKS | Boss fight mission |
| 16 | Ghosts of the Past | 88 | WORKS | |
| 17 | Guests of the Empire | 136 | WORKS | |
| 18 | Passing Glory | ~55 | WORKS | |
| 19 | Sweets for the Soul | 49 | WORKS | |
| 20 | Teahouse Tumult | ~55 | WORKS | |
| 21 | Finders Keepers | 42 | WORKS | |
| 22 | Shield of Diplomacy | 71 | WORKS | |
| 23 | Social Graces | ~55 | WORKS | |
| 24 | Foiled Ambition | 66 | WORKS | |
| 25 | Playing the Part | ~55 | WORKS | |
| 26 | Seal of the Serpent | ~55 | WORKS | |
| 27 | Misplaced Nobility | 47 | WORKS | |
| 28 | Bastion of Knowledge | 49 | WORKS | |
| 29 | Puppet in Peril | ~55 | WORKS | |
| 30 | Prevalence of Pirates | ~55 | WORKS | |
| 31 | Shades of Vengeance | 68 | WORKS | |
| 32 | In the Blood | 46 | WORKS | |
| 33 | Sentinels' Honor | ~55 | WORKS | |
| 34 | Testing the Waters | 81 | WORKS | |
| 35 | Legacy of the Lost | 47 | WORKS | |
| 36 | Gaze of the Saboteur | 67 | WORKS | |
| 37 | Path of Blood | ~55 | WORKS | |
| 38 | Stirrings of War | 51 | WORKS | |
| 39 | Allied Rumblings | ~55 | WORKS | |
| 40 | Unraveling Reason | 122 | WORKS | |
| 41 | Light of Judgement | 47 | WORKS | |
| 42 | Path of Darkness | 124 | WORKS | Instance fight in Nyzul Isle (Amnaf BLU + Naja) |
| 43 | Fangs of the Lion | 50 | WORKS | |
| 44 | Nashmeira's Plea | 90 | WORKS | Instance fight in Nyzul Isle (Raubahn + Razfahd/Alexander) |
| 45 | Ragnarok | 41 | WORKS | Cutscene only |
| 46 | Imperial Coronation | 179 | WORKS | Largest mission script |
| 47 | The Empress Crowned | 50 | WORKS | |
| 48 | Eternal Mercenary | 31 | WORKS | Finale cutscene |

**Key boss fights:**
- Mission 42 (Path of Darkness): Instance `path_of_darkness.lua` exists with Amnaf BLU and Naja Salaheem mobs
- Mission 44 (Nashmeira's Plea): Instance `nashmeiras_plea.lua` exists with Raubahn and Razfahd mobs; Alexander_NP mob script (89 lines) present
- Alexander_WTC (Waking the Colossus quest variant): 108 lines, separate instance
- No Odin mob found in Nyzul Isle zone (Odin appears in The Rider Cometh quest, checked separately)

**Verdict: All 48 missions are implemented with real logic (no stubs). Mission instances for boss fights exist.**

---

## 2. Near East Zone Access

| Zone | Exists | Notes |
|------|--------|-------|
| Aht_Urhgan_Whitegate | WORKS | 80+ NPC scripts, home points, survival guide, auction counter |
| Al_Zahbi | WORKS | Sanction NPCs, besieged framework |
| Nashmau | WORKS | |
| Wajaom_Woodlands | WORKS | |
| Bhaflau_Thickets | WORKS | |
| Mount_Zhayolm | WORKS | |
| Caedarva_Mire | WORKS | |
| Halvung | WORKS | |
| Mamook | WORKS | |
| Arrapago_Reef | WORKS | |
| Alzadaal_Undersea_Ruins | WORKS | Hub for Salvage/Nyzul |
| Open_sea_route_to_Al_Zahbi | WORKS | Ferry zone with mobs/npcs |
| Silver_Sea_route_to_Al_Zahbi | WORKS | |
| Silver_Sea_route_to_Nashmau | WORKS | |

**Transport from Jeuno/Mhaura:**
- `scripts/globals/transport.lua` defines routes: Mhaura -> Whitegate (Open Sea), Whitegate -> Nashmau (Silver Sea)
- NPCs: Dieh_Yamilsiah / Laughing_Bison (Mhaura), Baya_Hiramayuh (Whitegate), Kuhn_Tsahnpri (Whitegate), Yohj_Dukonlhy (Nashmau)
- All 24 Near East zones exist with zone scripts

**Verdict: WORKS -- full Near East zone access via ferry from Mhaura.**

---

## 3. Assault

| Item | Status | Notes |
|------|--------|-------|
| Assault framework | WORKS | `scripts/globals/assault.lua` -- entry, orders, level cap, registration |
| Assault enum | WORKS | `scripts/enum/assault.lua` -- all 52 assaults defined (50 regular + Nyzul Investigation + Nyzul Uncharted) |
| Assault zones | PARTIAL | 5 of 6 zones have instance dirs (Mamook has none) |
| Implemented scenarios | PARTIAL | **9 of 50** regular assaults have instance scripts |

**Implemented assaults by zone:**

| Zone | Implemented | Total Retail |
|------|-------------|-------------|
| Leujaoam Sanctum | 1 (Leujaoam Cleansing) | 10 |
| Mamook | 0 | 10 |
| Lebros Cavern | 3 (Excavation Duty, Troll Fugitives, Wamoura Farm Raid) | 10 |
| Periqia | 3 (Requiem, Seagull Grounded, Shades of Vengeance) | 10 |
| Ilrusi Atoll | 2 (Extermination, Golden Salvage) | 10 |
| **Total** | **9** | **50** |

**Verdict: PARTIAL -- framework works but only 18% of assault scenarios are playable. Most players will encounter missing content quickly.**

---

## 4. Besieged

| Item | Status | Notes |
|------|--------|-------|
| Besieged battles | MISSING | No battle system implemented |
| Sanction buff | WORKS | NPC interaction, duration based on mercenary rank |
| Imperial Standing currency | WORKS | Full shop with items by rank |
| Mercenary rank system | WORKS | Badge-based rank tracking (PSC through Captain) |
| Imperial Standing shop | WORKS | Items, maps, trust ciphers purchasable |
| Astral Candescence | PARTIAL | Variable checked but hardcoded; defense stats return zeros |

Key comment in `besieged.lua` line 144: *"hardcoded constants for now until we have a Besieged system"* -- `getImperialDefenseStats()` returns all zeros.

**Verdict: PARTIAL -- the NPC/currency/Sanction framework works. The actual Besieged battle event (beastman armies attacking Al Zahbi) does NOT exist. Players can get Sanction and spend Imperial Standing but cannot participate in Besieged battles.**

---

## 5. Salvage

| Item | Status | Notes |
|------|--------|-------|
| Salvage global framework | WORKS | `scripts/globals/salvage.lua` -- cell system, debuff removal, equipment strip |
| Zhayolm Remnants | WORKS | 444-line instance, 20+ mob scripts, NPC scripts (crates, slots, sockets) |
| Bhaflau Remnants | WORKS | 256-line instance, 15+ mob scripts, extensive NPC scripts |
| Arrapago Remnants | PARTIAL | 161-line instance (smaller), mob/NPC scripts present |
| Silver Sea Remnants | PARTIAL | 92-line instance (smallest), may be incomplete |
| Cell items | WORKS | 16 cell item scripts (undulatus, velum, virga, stratus, etc.) |
| Entry via Alzadaal | WORKS | Runic Portal scripts in Alzadaal zone |

**Verdict: PARTIAL -- Salvage system framework exists and all 4 remnant zones have instance scripts. Zhayolm and Bhaflau appear most complete. Silver Sea Remnants instance is small (92 lines) and may lack full floor logic.**

---

## 6. Nyzul Isle Investigation

| Item | Status | Notes |
|------|--------|-------|
| Investigation instance | WORKS | 188-line instance with floor generation, objectives |
| Floor generation | WORKS | `scripts/globals/nyzul/floor_generation.lua` (1453 lines) -- extensive |
| Nyzul global | WORKS | 377 lines -- base weapons, objectives, floor layouts |
| Armoury Crate drops | WORKS | 291-line crate script |
| Pathos system | WORKS | 236-line pathos script |
| Vending Box | WORKS | 179 lines |
| Mob population | WORKS | 174 mob scripts including classic NMs (Fafnir, Behemoth, Adamantoise, etc.) |
| Boss floors (every 20) | WORKS | Floor generation forces ELIMINATE_ENEMY_LEADER every 20 floors |
| Objectives | WORKS | 6 types: eliminate leader, specified enemies, activate lamps, specified enemy, all enemies, free floor |
| Mission instances | WORKS | Path of Darkness + Nashmeira's Plea instances |

**Verdict: WORKS -- Nyzul Isle Investigation appears to be one of the most complete ToAU endgame systems. Full floor generation, multiple objective types, extensive mob roster, boss floors, and drop tables.**

---

## 7. Einherjar

| Item | Status | Notes |
|------|--------|-------|
| Einherjar system | WORKS | `scripts/globals/einherjar/system.lua` (700 lines) |
| Chamber definitions | WORKS | `chambers.lua` (241 lines) |
| Lamp mechanics | WORKS | `lamp.lua` (180 lines) |
| Floor planning | WORKS | `planner.lua` (392 lines) |
| Reservation system | WORKS | `reservation.lua` (93 lines) |
| Treasure/rewards | WORKS | `treasure.lua` (312 lines) |
| Lockout timer | WORKS | `lockout.lua` (24 lines) |
| Settings | WORKS | `settings.lua` (40 lines) |
| Zone: Hazhalm Testing Grounds | WORKS | Zone.lua with Einherjar reconnection/ejection logic |
| Mob scripts | WORKS | 57 mob scripts including Odin's minions, Vampyrs, bosses |
| NPC entry (_260) | WORKS | Gate NPC present |
| Armoury Crate | WORKS | Drop crate script present |
| Entry NPC (Kilusha) | WORKS | In Nashmau |

**Verdict: WORKS -- Einherjar has a comprehensive implementation with ~2000 lines of global framework code, 57 mob scripts, chamber/lamp/reservation systems, and treasure tables.**

---

## Overall ToAU Expansion Status

| System | Status | Completeness |
|--------|--------|-------------|
| ToAU Missions (1-48) | WORKS | 48/48 (100%) |
| Near East Zones | WORKS | 24/24 zones |
| Transport (Mhaura ferry) | WORKS | All routes |
| Assault | PARTIAL | 9/50 scenarios (18%) |
| Besieged | PARTIAL | NPC/currency only, no battles |
| Salvage | PARTIAL | All 4 zones exist, varying completeness |
| Nyzul Isle Investigation | WORKS | Full system |
| Einherjar | WORKS | Full system |

## Blockers
- **Assault**: 41 of 50 assault scenarios are missing instance scripts. The framework works but most content is not playable.
- **Besieged**: Battle system not implemented. Comment in code confirms this is intentional placeholder. Players cannot earn Imperial Standing through Besieged (only via other means).
- **Salvage**: Silver Sea Remnants may be incomplete (92-line instance vs 444 for Zhayolm).

## Fix Difficulty
- Assault scenarios: **Massive** -- each scenario needs unique instance logic, mob spawns, objectives, and win conditions. 41 scenarios to implement.
- Besieged battles: **Massive** -- would require a new large-scale battle system with beastman army AI, wave mechanics, NPC defense, and reward distribution. This is a known unimplemented system across most private servers.
- Salvage completion: **Medium** -- framework exists, smaller remnants may just need more floor/mob logic.
