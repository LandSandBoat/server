# San d'Oria Missions Rank 7-10

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:San_d%27Oria_Missions
- Codebase: `scripts/missions/sandoria/7_1_Prestige_of_the_Papsque.lua` through `9_2_The_Heir_to_the_Light.lua`
- Battlefields: `scripts/battlefields/Horlais_Peak/the_secret_weapon.lua`, `scripts/battlefields/QuBia_Arena/heir_to_the_light.lua`

## Summary
All six missions (7-1 through 9-2) have full, non-stub implementations with proper NPC interactions, cutscenes, NM fights, battlefield scripts, key item handling, and rank/gil rewards. No auto-completes or stubs found. Both BCNM battlefields support trusts and have multi-phase encounter logic.

## Checklist

| Item | Status | Notes |
|------|--------|-------|
| **7-1: Prestige of the Papsque** | WORKS | Full flow: Papal Chambers CS -> West Ronfaure QM -> fight Marauder Dvogzog -> get Ancient San d'Orian Tablet -> return. Mob in `mob_spawn_points.sql` (ID 17187273, lv67 MNK). Mob script exists. Reward: 1000 rank points. |
| **7-2: The Secret Weapon** | WORKS | Pre-accept CS flow with gate guards and Chateau d'Oraguille trigger area. BCNM at Horlais Peak with 5 mobs (3 Orcs + 2 Warmachines) x3 arena instances. Battlefield allows trusts, 30min timer, lv75 cap. Post-win: Crystal Dowser KI -> turn in to gate guard. Reward: Rank 8 + 60,000 gil. |
| **8-1: Coming of Age** | WORKS | Chateau d'Oraguille CS chain -> Halver -> Quicksand Caves Fountain of Kings -> fight Honor + Valor NMs -> get Drops of Amnio -> return to Halver. Both NMs in DB (Valor lv65, Honor lv70). Post-completion 1-minute wait + Northern San d'Oria CS with gate guard blocking logic. Reward: 800 rank points. |
| **8-2: Lightbringer** | WORKS | Great Hall CS -> Rahal gives Crystal Dowser -> Temple of Uggalepih: collect 3 Pieces of Broken Key from QMs -> fight Nio-A + Nio-Hum (lv72 dolls, in DB) -> Granite Door CS -> return to Great Hall. Optional post-completion Prince door cutscenes with bit-flag tracking. Reward: Rank 9 + 80,000 gil. |
| **9-1: Breaking Barriers** | WORKS | Great Hall CS -> collect 3 figures: Figure of Titan (Valley of Sorrows QM), Figure of Garuda (Xarcabard QM), Figure of Leviathan (Batallia Downs - fight Suparna + Suparna Fledgling, lv65-70, in DB) -> return to Great Hall. All 3 KIs defined in enum. Mob scripts exist. Optional post-completion Curilla/Rahal dialogue. Reward: 900 rank points. |
| **9-2: The Heir to the Light** | WORKS | Multi-zone CS chain: N. San d'Oria -> Chateau -> Fei'Yin -> Qu'Bia Arena BCNM (2-phase: Phase 1 = 11 mobs, Phase 2 = 3 named Orcs with Prince Trion ally spawned). 3 arena instances, trusts allowed, 30min, lv75 cap. Post-battle: N. San d'Oria CS -> Chateau Great Hall -> King Ranperre's Tomb Heavy Stone Door -> Halver final CS. San d'Orian Flag item delivery with inventory-full fallback. Reward: Rank 10 + 100,000 gil + San d'Orian Flag + title. |

### NPCs Verified in npc_list.sql
| NPC | Zone | Status |
|-----|------|--------|
| Papal Chambers door (_6fc) | Northern San d'Oria (231) | EXISTS |
| Halver | Chateau d'Oraguille (233) | EXISTS |
| Great Hall door (_6h4) | Chateau d'Oraguille (233) | EXISTS |
| Heavy Stone Door (_5a0) | King Ranperre's Tomb (190) | EXISTS |
| Gate Guards (Ambrotien, Grilau, Endracion) | S/N San d'Oria | EXISTS (referenced in mission scripts) |

### Mobs Verified in mob_spawn_points.sql
| Mob | Zone | Level | Status |
|-----|------|-------|--------|
| Marauder Dvogzog | West Ronfaure (100) | 67 | EXISTS + script |
| Honor | Quicksand Caves (208) | 70 | EXISTS + script |
| Valor | Quicksand Caves (208) | 65 | EXISTS + script |
| Nio-A | Temple of Uggalepih (159) | 72 | EXISTS + script |
| Nio-Hum | Temple of Uggalepih (159) | 72 | EXISTS + script |
| Suparna | Batallia Downs (105) | 65-70 | EXISTS + script |
| Suparna Fledgling | Batallia Downs (105) | 65-70 | EXISTS + script |
| Darokbok of Clan Reaper + allies | Horlais Peak (BCNM) | 68 | EXISTS (3 instances) |
| Warlord Rojgnoj + allies | Qu'Bia Arena (BCNM) | 75 | EXISTS (3 instances) |

### Key Items Verified in key_item.lua
| Key Item | ID | Status |
|----------|----|--------|
| ANCIENT_SAN_DORIAN_TABLET | 283 | EXISTS |
| CRYSTAL_DOWSER | 284 | EXISTS |
| PIECE_OF_A_BROKEN_KEY1 | 285 | EXISTS |
| PIECE_OF_A_BROKEN_KEY2 | 286 | EXISTS |
| PIECE_OF_A_BROKEN_KEY3 | 287 | EXISTS |
| DROPS_OF_AMNIO | 288 | EXISTS |
| FIGURE_OF_LEVIATHAN | 481 | EXISTS |
| FIGURE_OF_GARUDA | 482 | EXISTS |
| FIGURE_OF_TITAN | 483 | EXISTS |

### Battlefields
| Battlefield | Zone | Trusts | Cap | Timer | Phases | Status |
|-------------|------|--------|-----|-------|--------|--------|
| The Secret Weapon | Horlais Peak | Yes | 75 | 30min | 1 (5 mobs) | WORKS |
| Heir to the Light | Qu'Bia Arena | Yes | 75 | 30min | 2 (11 mobs -> 3 named + Trion ally) | WORKS |

## Blockers
- None identified. All missions appear fully implemented with complete NPC, mob, KI, and battlefield support.

## Fix Difficulty
- N/A - No fixes needed.

## Notes
- 7-2 (The Secret Weapon) has a unique pre-acceptance flow where gate guards trigger special cutscenes before the mission can be formally accepted, gated by rank 7 + rank points + completion of 7-1.
- 8-1 (Coming of Age) has a post-completion timer mechanic (1 Earth minute) blocking gate guard interaction until a final CS plays in Northern San d'Oria.
- 8-2 (Lightbringer) has optional post-completion Prince cutscenes tracked with bit-flag variables, cleaned up when 9-1 is accepted.
- 9-2 (The Heir to the Light) has the most complex battlefield in the set: a two-phase BCNM with a mid-fight cutscene transition and an NPC ally (Prince Trion) spawned for phase 2. Post-completion includes inventory-full fallback for the San d'Orian Flag item.
- There is no separate "Rank 10" mission; completing 9-2 grants Rank 10 directly.
