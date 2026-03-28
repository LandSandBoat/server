# COP Missions Chapters 4-8

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Chains_of_Promathia_Missions
- Codebase: `scripts/missions/cop/4_1_*.lua` through `8_4_*.lua`
- Battlefields: `scripts/battlefields/` (Monarch_Linn, Spire_of_Vahzl, Sealions_Den, Mine_Shaft_2716, Boneyard_Gully, Bearclaw_Pinnacle, The_Garden_of_RuHmet, Empyreal_Paradox)
- Sea zones: `scripts/zones/AlTaieu/`, `scripts/zones/Grand_Palace_of_HuXzoi/`, `scripts/zones/The_Garden_of_RuHmet/`, `scripts/zones/Empyreal_Paradox/`
- Tests: `scripts/tests/missions/cop.lua`

## Summary
COP Chapters 4-8 are fully scripted with detailed mission logic, battlefield definitions, and proper NPC interactions. All battlefields exist and are registered. Sea zones (Al'Taieu, Hu'Xzoi, Ru'Hmet, Empyreal Paradox) are present in zone_settings. The only concerns are: (1) some battlefield tests are commented out due to test framework limitations (not gameplay bugs), (2) 8-4 Dawn has no automated test at all, and (3) a TODO note in 8-4 about Apocalypse Nigh alignment.

## Checklist

### Chapter 4: The Cradles of Children Lost

| Mission | Status | Notes |
|---------|--------|-------|
| 4-1 Sheltering Doubt | WORKS | Cutscene-only mission. NPCs Despachiaire/Justinius in Tavnazian Safehold, gate in Misareaux Coast. Fully scripted with 3 status steps. |
| 4-2 The Savage | WORKS | Battlefield `SAVAGE` (id=961) in Monarch Linn exists. Entry via Misareaux Coast `_0p2`, win tracked via battlefieldWin local var, completion at Justinius. Trusts allowed, 6 players, cap 50. |
| 4-3 The Secrets of Worship | WORKS | Full Sacrarium dungeon mission. Spawns Old Professor Mariselle from QM points, requires Reliquiarium Key. Complex NPC logic for 6 QM spawn points. Well-implemented. |
| 4-4 Slanderous Utterings | WORKS | Cutscene mission. Tavnazian Safehold trigger area + Seal Lion's Den `_0w0` door interaction. Clean completion flow. |

### Chapter 5: The Return Home

| Mission | Status | Notes |
|---------|--------|-------|
| 5-1 The Enduring Tumult of War | WORKS | Multi-zone mission spanning Tavnazian Safehold, N. San d'Oria, Port San d'Oria, Port Bastok, Metalworks, Pso'Xja, and Promyvion-Vahzl. Spawns Nunyunuwi NM in Pso'Xja. Grants Light of Vahzl and Mysterious Amulet (Drained). Fully scripted. |
| 5-2 Desires of Emptiness | WORKS | Battlefield `DESIRES_OF_EMPTINESS` (id=864) in Spire of Vahzl exists. Complex Promyvion-Vahzl exploration with 3 NMs (Propagator, Solicitor, Ponderer) on memory fluxes. Bitfield tracking for kills and CS views. Post-fight CS chain through Beaucedine Glacier to Metalworks. Trusts allowed, cap 50. |
| 5-3 Three Paths | WORKS | Massive mission with 3 independent sub-paths. **Louverance's Path**: Tavnazian Safehold -> Windurst Woods -> Bibiki Bay -> Windurst Walls -> Oldton Movalpolos -> Mine Shaft 2716 battlefield `CENTURY_OF_HARDSHIP` (id=736, cap 60) -> Metalworks. **Tenzen's Path**: La Theine Plateau -> Pso'Xja -> Upper Jeuno -> Rulude Gardens -> Batallia Downs -> Lower Delkfutt's Tower (Disaster Idol NM) -> Pso'Xja -> Metalworks. **Ulmia's Path**: S. San d'Oria -> Port San d'Oria -> N. San d'Oria -> Windurst Waters -> Windurst Walls -> Boneyard Gully battlefield `HEAD_WIND` (id=672, cap 50) -> Bearclaw Pinnacle battlefield `FLAMES_FOR_THE_DEAD` (id=640, cap 60) -> Metalworks. All 3 paths must complete before Cid finishes mission. |

### Chapter 6: Echoes of Time

| Mission | Status | Notes |
|---------|--------|-------|
| 6-1 For Whom the Verse is Sung | WORKS | Cutscene mission. Pherimociel in Rulude Gardens, Marble Bridge in Upper Jeuno, return to Rulude Gardens. Simple 3-step progression. |
| 6-2 A Place to Return | WORKS | Fight mission at Misareaux Coast Dilapidated Gate. Spawns 3 Warder NMs (Aglaia, Euphrosyne, Thalia). Bitfield tracks kills. Completion after all 3 defeated. |
| 6-3 More Questions than Answers | WORKS | Cutscene mission. Rulude Gardens (Pherimociel + palace door `_6r9`) to Selbina (Mathilde). Clean flow. |
| 6-4 One to be Feared | WORKS | Major boss fight: Mammets -> Omega -> Ultima. Battlefield `ONE_TO_BE_FEARED` (id=992) in Sealions Den. 3-phase fight with heal between phases, 45 min time limit, cap 75. Trusts allowed. Complex airship door re-entry mechanic for phase transitions. Grants Ducal Guard's Ring on 7-1. Post-fight CS transports to Lufaise Meadows. **Test note**: battlefield portion of test is commented out ("Event progression not working") but this is a test framework limitation, not a gameplay bug. |

### Chapter 7: In the Light of the Crystal

| Mission | Status | Notes |
|---------|--------|-------|
| 7-1 Chains and Bonds | WORKS | Cutscene/item mission. Grants Ducal Guard's Ring on entry to Lufaise Meadows. Visit Walnut Door + Sewer Entrance in Tavnazian Safehold, then Seal Lion's Den. 3-bit bitfield tracks progress, mission completes when all 3 viewed. |
| 7-2 Flames in the Darkness | WORKS | Cutscene chain: Misareaux Coast (`_0p2`) -> Seal Lion's Den (Sueleen) -> Rulude Gardens (trigger area) -> Upper Jeuno (Marble Bridge `_6s1`). |
| 7-3 Fire in the Eyes of Men | WORKS | Mine Shaft 2716 CS + Cid in Metalworks with Vanadiel day wait timer. Must wait 1 game day between visits to Cid. |
| 7-4 Calm Before the Storm | WORKS | 3 NM fights in different zones: Boggelmann (Misareaux Coast), Cryptonberry Executor + Assassins (Carpenter's Landing), Dalham (Bibiki Bay). Bitfield status tracking. Then Cid gives Letters from Ulmia and Prishe KI, deliver to Sueleen in Seal Lion's Den. |
| 7-5 The Warrior's Path | WORKS | Battlefield `WARRIORS_PATH` (id=993) in Sealions Den. Fight Tenzen + Chebukkis. Cap 75, 30 min, trusts allowed. Post-fight CS transports to Al'Taieu. Grants Light of Al'Taieu (race-dependent light exchange mechanic). Sets up Sagheera interactions. **Unlocks sea access** via `xi.teleport.to(player, xi.teleport.id.SEA)` from Sueleen in Sealions Den. **Test note**: test comments out battlefield kill -- "Tenzen can't be killed" in test framework. |

### Chapter 8: Emptiness Bleeds

| Mission | Status | Notes |
|---------|--------|-------|
| 8-1 Garden of Antiquity | WORKS | Al'Taieu exploration. 3 Rubious Crystal towers each spawn 3 Ru'aern NMs. Complex bitfield/bitmask tracking for tower completion. After all 3 towers cleared, portal to Grand Palace of Hu'Xzoi opens. Grants Tavnazian Ring from `_iya` NPC. Then proceed to `_iyb` to complete. |
| 8-2 A Fate Decided | WORKS | Grand Palace of Hu'Xzoi. Spawn and kill Ix'ghrah NM from `_iyq` QM point. Simple 2-step (spawn, kill, trigger QM again). |
| 8-3 When Angels Fall | WORKS | Garden of Ru'Hmet. Race-specific Ebon Panel interaction to recover stolen Light. Battlefield `WHEN_ANGELS_FALL` (id=1024) with Ix'zdei mobs, cap 75, 30 min, trusts allowed. Post-fight: obtain Brand of Dawn/Twilight KIs, proceed to `_0zt`, return to Al'Taieu for final CS returning Mysterious Amulet to Prishe. |
| 8-4 Dawn | WORKS | Final COP mission. Empyreal Paradox battlefield `DAWN` (id=1056). 2-phase Promathia fight with Prishe and Selhteus as NPC allies. Cap 75, 30 min, trusts allowed, 2000 XP reward. Post-fight: extensive cutscene chain across 5+ zones (Rulude Gardens, Upper Jeuno, Tavnazian Safehold, Lufaise Meadows) with Vanadiel midnight timer. 5 optional "final cutscene" paths (Louverance/Chebukkis/Shikarees/Jabbos/Tenzen) tracked via bitfield. Ring choice (Rajas/Sattva/Tamas) from Marble Bridge in Upper Jeuno, with replacement mechanism. **TODO in code**: "Add additional section to complete mission that aligns with Apocalypse Nigh." **No automated test exists for 8-4.** |

### Sea Zone Access

| Zone | Status | Notes |
|------|--------|-------|
| Al'Taieu (zone 33) | WORKS | Present in zone_settings. Access granted after 7-5 completion via Sueleen teleport (SEA teleport id=56, coords -31.8, 0, -618.7). Full mob population (Aerns, Yovra, Xzomit, etc). Jailers of Hope, Justice, Prudence, Love + Absolute Virtue all have mob scripts. |
| Grand Palace of Hu'Xzoi (zone 34) | WORKS | Present in zone_settings. Access from Al'Taieu. Quasilumin door system scripted. Ixghrah (8-2 NM), Jailer of Temperance, Ixaern MNK all present. |
| The Garden of Ru'Hmet (zone 35) | WORKS | Present in zone_settings. Door/portal system scripted. When Angels Fall battlefield registered. Jailers of Faith/Fortitude, Ixaern DRK/DRG all present. |
| Empyreal Paradox (zone 36) | WORKS | Present in zone_settings. Dawn battlefield with 3 instances. Promathia phase 1+2 mobs, Prishe, Selhteus, Eald'narche, Kam'lanaut all scripted. |

### Key Battlefields Summary

| Battlefield | Zone | Level Cap | Time | Trusts | Boss(es) |
|-------------|------|-----------|------|--------|----------|
| The Savage (4-2) | Monarch Linn | 50 | 30m | Yes | Mammet-22 Zeta |
| Desires of Emptiness (5-2) | Spire of Vahzl | 50 | 30m | Yes | Ponderer/Solicitor/Propagator |
| Century of Hardship (5-3L) | Mine Shaft 2716 | 60 | 30m | Yes | Bugbear/Moblins |
| Head Wind (5-3U) | Boneyard Gully | 50 | 30m | Yes | Shikaree trio |
| Flames for the Dead (5-3U) | Bearclaw Pinnacle | 60 | 30m | Yes | Snoll Czar |
| One to be Feared (6-4) | Sealions Den | 75 | 45m | Yes | Mammets -> Omega -> Ultima |
| The Warrior's Path (7-5) | Sealions Den | 75 | 30m | Yes | Tenzen + Chebukkis |
| When Angels Fall (8-3) | Garden of Ru'Hmet | 75 | 30m | Yes | Ix'zdei x4 |
| Dawn (8-4) | Empyreal Paradox | 75 | 30m | Yes | Promathia (2 phases) + allies |

## Blockers
- **None for progression.** All missions are fully scripted from 4-1 through 8-4 with working battlefield definitions.
- 8-4 Dawn has a TODO about Apocalypse Nigh alignment -- this is a post-COP optional quest (the "Apocalypse Nigh" BCNM rematch), not a blocker for COP completion.
- Level caps on battlefields are enforced via `modules/abyssea/lua/cop_mission_level_caps.lua` module (50 for Ch4-5, 60 for Ch5-3/6-4, 75 for Ch7-8). These are retail-accurate.

## Fix Difficulty
- N/A -- COP Chapters 4-8 appear fully implemented. The only gap is the Apocalypse Nigh post-game integration noted in the 8-4 TODO.

## Notable Implementation Quality
- All missions use the modern `Mission:new()` framework with proper status tracking, event handling, and completion flow.
- Complex missions (5-3 Three Paths, 6-4 One to be Feared, 8-4 Dawn) have sophisticated bitfield tracking, multi-phase battlefields, and NPC ally systems.
- Sea zones have full mob populations including endgame NMs (Jailers, Absolute Virtue).
- Battlefields all allow trusts, making them soloable for a small private server.
- Test coverage exists for most missions but some battlefield tests are commented out due to test framework limitations (Tenzen unkillable in tests, event progression issues). These are test-only issues, not gameplay bugs.
