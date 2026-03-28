# Other Areas Quests (Non-Nation, Non-Jeuno) -- Phase 2 Audit

**Date:** 2026-03-28
**Source:** bg-wiki quest categories per area; `scripts/globals/quests.lua` quest ID definitions
**Script paths:**
- `scripts/quests/otherAreas/` -- Selbina, Mhaura, Tavnazia, misc
- `scripts/quests/outlands/` -- Kazham, Norg, Rabao
- `scripts/quests/ahtUrhgan/` -- Whitegate, Near East
- `scripts/quests/crystalWar/` -- WotG era (Crystal War side quests)
- `scripts/quests/abyssea/` -- Abyssea quests
- `scripts/quests/adoulin/` -- SoA era quests

---

## Overall Summary

| Area | Defined Quest IDs | Scripts Present | Coverage |
|---|---|---|---|
| Other Areas (Selbina/Mhaura/Tavnazia/misc) | 66 | 41 | 62.1% |
| Outlands (Kazham/Norg/Rabao) | 47 | 24 | 51.1% |
| Aht Urhgan (Whitegate/Near East) | 62 | 46 | 74.2% |
| Crystal War (WotG) | 79 | 30 | 38.0% |
| Abyssea | 155 | 49 | 31.6% |
| Adoulin (SoA) | 73 | 14 | 19.2% |
| **TOTAL** | **482** | **204** | **42.3%** |

> **Note on Abyssea:** 42 of the 49 Abyssea scripts are Dominion Ops (repeatable kill quests). The bulk of the missing Abyssea quests are story-related content (Ward Warden, Desert Rain, Crimson Carpet, Refuel & Replenish, Mightier Martello repeatable quests) and zone boss prerequisite chains. Of the 155 defined IDs, approximately 63 are zone maintenance repeatable quests (Ward Warden/Desert Rain/Crimson Carpet/Refuel/Martello) that have no scripts.

> **Note on Adoulin:** Most Adoulin quests lack scripts. The 14 that exist cover basic colonization tasks (Flavors of Our Lives, Breaking the Ice, etc.) plus a few story/Leafallia quests. The GEO and RUN unlock quests are NOT in the `scripts/quests/adoulin/` folder but are handled in zone NPC scripts (see below).

---

## Critical Job Unlock Quests

### Sub-Job Quest (Elder Memories / The Old Lady) -- WORKING
| Detail | Value |
|---|---|
| Quest IDs | `otherAreas.ELDER_MEMORIES` (24), `otherAreas.THE_OLD_LADY` (10) |
| Selbina NPC | `scripts/zones/Selbina/npcs/Isacio.lua` |
| Mhaura NPC | `scripts/zones/Mhaura/npcs/Vera.lua` |
| Status in quests.lua | `-- +` (implemented, not converted to Interaction Framework) |

**Verification:** These quests are implemented in NPC scripts (old-style), NOT as Interaction Framework quest files. Both have full handlers:
- `onTrade` -- accepts the 3 sequential trade items (Magicked Skull -> Damselfly Worm -> Crab Apron for Selbina; Wild Rabbit Tail -> Dhalmel Saliva -> Bloody Robe for Mhaura)
- `onTrigger` -- checks quest status, level requirement via `xi.settings.main.SUBJOB_QUEST_LEVEL`
- `onEventFinish` -- calls `player:unlockJob(0)` to enable subjobs, completes quest
- Mutual exclusion check: Isacio checks if THE_OLD_LADY is not available (meaning already done), Vera checks if ELDER_MEMORIES is not available

**Verdict: FULLY FUNCTIONAL** -- Both paths work correctly.

### SAM Unlock (Forge Your Destiny + The Sacred Katana) -- WORKING
| Detail | Value |
|---|---|
| Prereq quest | `scripts/quests/outlands/Forge_Your_Destiny.lua` (Converted) |
| AF1 quest | `scripts/quests/outlands/SAM_AF1_The_Sacred_Katana.lua` (Converted) |
| AF2 quest | `scripts/quests/outlands/SAM_AF2_Yomi_Okuri.lua` (Converted) |
| AF3 quest | `scripts/quests/outlands/SAM_AF3_A_Thief_in_Norg.lua` (Converted) |
| NPC | Jaucribaix in Norg |

**Verification:** Forge Your Destiny uses Interaction Framework. Proper checks: `player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL`. Rewards Mumeito sword. The Sacred Katana requires Forge Your Destiny complete + SAM main job + AF1_QUEST_LEVEL. Trades Mumeito + Crystal Scales key item for AF weapon Magoroku.

**Verdict: FULLY FUNCTIONAL** -- Complete SAM AF chain present.

### NIN Unlock (Ayame and Kaede) -- WORKING
| Detail | Value |
|---|---|
| Quest script | `scripts/quests/bastok/Ayame_and_Kaede.lua` (in Bastok quests, NOT outlands) |
| NPC | Kaede in Port Bastok |

**Verification:** Uses Interaction Framework. Level check via `xi.settings.main.ADVANCED_JOB_LEVEL`. Includes NM spawn logic (Korroloka Leeches in Korroloka Tunnel), proper quest progression, and rewards Shadow Walker title. The `unlockJob` call is handled in the quest completion chain.

**Verdict: FULLY FUNCTIONAL** -- Note: this quest is filed under Bastok quests, not Outlands.

### DNC Unlock (Lakeside Minuet) -- WORKING
| Detail | Value |
|---|---|
| Quest script | `scripts/quests/jeuno/Lakeside_Minuet.lua` (in Jeuno quests) |
| NPCs | Laila in Upper Jeuno, Valderotaux in Southern San d'Oria |
| Prerequisite | `xi.settings.main.ENABLE_WOTG == 1` |

**Verification:** Uses Interaction Framework. Requires ADVANCED_JOB_LEVEL + WotG enabled. Rewards title Troupe Brilioth Dancer. Glowing Pebbles in Jugner Forest involved. The `unlockJob` call is in the quest completion.

**Verdict: FULLY FUNCTIONAL** -- Note: filed under Jeuno quests, requires WotG expansion enabled.

### SCH Unlock (A Little Knowledge) -- WORKING
| Detail | Value |
|---|---|
| Quest script | `scripts/quests/crystalWar/A_Little_Knowledge.lua` (Converted) |
| NPC | Erlene in Eldieme Necropolis [S] |
| AF quests | `SCH_AF1_On_Sabbatical.lua`, `SCH_AF2_Downward_Helix.lua` |

**Verification:** Uses Interaction Framework. Level check via `ADVANCED_JOB_LEVEL`. Rewards Grimoire key item + JOB_GESTURE_SCHOLAR. Tucker NPC in Crawlers' Nest [S] for vellum trading. Valid mage job check for certain interactions (BLM, RDM, SMN, BLU). Grants title Schultz Scholar.

**Verdict: FULLY FUNCTIONAL**

### BLU Unlock (An Empty Vessel) -- WORKING
| Detail | Value |
|---|---|
| Quest script | `scripts/quests/ahtUrhgan/An_Empty_Vessel.lua` (Converted) |
| NPC | Waoud in Aht Urhgan Whitegate |
| AF quests | `BLU_AF1_Beginnings.lua`, `BLU_AF2_Omens.lua`, `BLU_AF3_Transformations.lua` |

**Verification:** Uses Interaction Framework. Requires ADVANCED_JOB_LEVEL. Has divination minigame (Waoud asks questions, tracks correct answers). Requires Siren's Tear, Valkurm Sunsand, Dangruf Stone trade items. Rewards title Bearer of the Mark of Zahak. BLU AF chain requires ToAU mission progress (Immortal Sentries complete).

**Verdict: FULLY FUNCTIONAL**

### COR Unlock (Luck of the Draw) -- WORKING
| Detail | Value |
|---|---|
| Quest script | `scripts/quests/ahtUrhgan/Luck_of_the_Draw.lua` (Converted) |
| NPC | Ratihb in Aht Urhgan Whitegate |

**Verification:** Uses Interaction Framework. Requires ADVANCED_JOB_LEVEL. Multi-zone quest involving Ratihb, Mafwahb, qm in Nashmau boat area, Rock Slab in Talacca Cove. Rewards Corsair Die + JOB_GESTURE_CORSAIR + title.

**Verdict: FULLY FUNCTIONAL**

### PUP Unlock (No Strings Attached) -- WORKING
| Detail | Value |
|---|---|
| Quest script | `scripts/quests/ahtUrhgan/No_Strings_Attached.lua` (Converted) |
| NPCs | Shamarhaan (Bastok Markets), Iruki-Waraki, Ghatsad (Whitegate) |

**Verification:** Uses Interaction Framework. Requires ADVANCED_JOB_LEVEL. Multi-zone quest. Rewards Animator + JOB_GESTURE_PUPPETMASTER + title Proud Automaton Owner.

**Verdict: FULLY FUNCTIONAL**

### GEO Unlock (Dances with Luopans) -- WORKING
| Detail | Value |
|---|---|
| Quest ID | `adoulin.DANCES_WITH_LUOPANS` (118) |
| NPC script | `scripts/zones/Western_Adoulin/npcs/Sylvie.lua` (zone NPC, NOT quest file) |

**Verification:** Handled entirely in Sylvie NPC script. Full quest flow:
1. Trigger at ADVANCED_JOB_LEVEL -> begin quest
2. Trade Petrified Log + have Fistful of Homeland Soil KI -> receive Luopan KI
3. Return with Luopan -> receive Indi-Poison + Matre Bell items
4. Calls `player:unlockJob(xi.job.GEO)` + grants JOB_GESTURE_GEOMANCER
5. Also handles replacement Matre Bell purchase (300k gil or 150k bayld)

**Verdict: FULLY FUNCTIONAL** -- No quest file in `scripts/quests/adoulin/`, but fully implemented in zone NPC.

### RUN Unlock (Children of the Rune) -- WORKING
| Detail | Value |
|---|---|
| Quest ID | `adoulin.CHILDREN_OF_THE_RUNE` (119) |
| NPC script | `scripts/zones/Eastern_Adoulin/npcs/Octavien.lua` (zone NPC, NOT quest file) |

**Verification:** Handled entirely in Octavien NPC script. Full quest flow:
1. Trigger at ADVANCED_JOB_LEVEL -> begin quest
2. Obtain Yahse Wildflower Petal KI
3. Return -> rune enhancement phase (halves HP/MP for dramatic effect)
4. Receive Sowilo Claymore + JOB_GESTURE_RUNE_FENCER
5. Calls `player:unlockJob(xi.job.RUN)`
6. Has REWARD_PENDING fallback for full inventory

**Verdict: FULLY FUNCTIONAL** -- No quest file in `scripts/quests/adoulin/`, but fully implemented in zone NPC.

---

## Area-by-Area Breakdown

### Other Areas (scripts/quests/otherAreas/) -- 41 scripts / 66 defined

#### Scripts Present (41 files)
| Script | Status | Notes |
|---|---|---|
| RQ1-RQ7 (Rycharde chain) | PRESENT (7 files, Converted) | Full Selbina cooking quest chain |
| The_Sand_Charm.lua | PRESENT (Converted) | Mhaura quest, requires fishing enabled |
| The_Gift.lua / The_Real_Gift.lua | PRESENT (Converted) | Selbina gift quest chain |
| The_Rescue.lua | PRESENT (Converted) | Selbina fame quest, reward Map of Ranguemont |
| Test_My_Mettle.lua | PRESENT (Converted) | |
| Inside_the_Belly.lua | PRESENT (Converted) | |
| Its_Raining_Mannequins.lua | PRESENT (Converted) | |
| Recycling_Rods.lua | PRESENT (Converted) | |
| Waking_the_Beast.lua | PRESENT (Converted) | Requires all 6 avatar spells |
| Monstrosity.lua | PRESENT (Converted) | |
| An_Explorers_Footsteps.lua | PRESENT (Converted) | |
| Under_the_Sea.lua | PRESENT (Converted) | |
| A_Hard_Days_Knight.lua | PRESENT (Converted) | CoP-era Tavnazia quest |
| X_Marks_The_Spot.lua | PRESENT (Converted) | |
| A_Bitter_Past.lua | PRESENT (Converted) | |
| The_Call_of_the_Sea.lua | PRESENT (Converted) | |
| Paradise_Salvation_and_Maps.lua | PRESENT (Converted) | |
| Go_Go_Gobmuffin.lua | PRESENT (Converted) | |
| Unforgiven.lua | PRESENT (Converted) | |
| Secrets_of_Ovens_Lost.lua | PRESENT (Converted) | |
| Petals_for_Parelbriaux.lua | PRESENT (Converted) | |
| Elderly_Pursuits.lua | PRESENT (Converted) | |
| Knocking_on_Forbidden_Doors.lua | PRESENT (Converted) | |
| Confessions_of_a_Bellmaker.lua | PRESENT (Converted) | |
| In_Search_of_the_Truth.lua | PRESENT (Converted) | |
| Tango_with_a_Tracker.lua | PRESENT (Converted) | |
| Bombs_Away.lua | PRESENT (Converted) | |
| Give_a_Moogle_a_Break.lua | PRESENT (Converted) | Moogle quest chain (4 quests) |
| The_Moogles_Picnic.lua | PRESENT (Converted) | |
| Moogles_in_the_Wild.lua | PRESENT (Converted) | |
| Missionary_Moblin.lua | PRESENT (Converted) | |
| For_The_Birds.lua | PRESENT (Converted) | |
| Better_The_Demon_You_Know.lua | PRESENT (Converted) | |
| Uninvited_Guests.lua | PRESENT (Converted) | |

#### Key MISSING Quests (Other Areas)
| Quest | ID | Impact |
|---|---|---|
| Orlando's Antiques | 7 | Selbina quest, low priority |
| A Potter's Preference | 9 | Minor quest |
| Fisherman's Heart | 11 | No implementation marker |
| Picture Perfect | 31 | No implementation marker |
| Survival of the Wisest | 33 | No implementation marker |
| The Big One | 70 | Fishing quest |
| Behind the Smile | 77 | No implementation marker |
| Requiem of Sin | 83 | No implementation marker |
| VW Ops (84-85) | 84-85 | Voidwatch operations |
| Mithran Delicacies | 97 | No implementation marker |
| An Understanding Overlord | 106 | Beastmen faction quests |
| An Affable Adamantking | 107 | Beastmen faction quests |
| A Generous General | 109 | Beastmen faction quests |
| Records of Eminence | 110 | RoE system (handled elsewhere) |
| Unity Concord | 111 | Unity system (handled elsewhere) |

> **Note:** Elder Memories (24) and The Old Lady (10) are marked `-- +` (implemented) but handled in zone NPC scripts, not quest files. They are fully functional.

---

### Outlands (scripts/quests/outlands/) -- 24 scripts / 47 defined

#### Scripts Present (24 files)
| Script | Status | Notes |
|---|---|---|
| A_Question_of_Taste.lua | PRESENT (Converted) | Kazham quest |
| Everyones_Grudging.lua | PRESENT (Converted) | Kazham quest |
| You_Call_That_a_Knife.lua | PRESENT (Converted) | Kazham quest |
| Cloak_and_Dagger.lua | PRESENT (Converted) | Kazham quest |
| Forge_Your_Destiny.lua | PRESENT (Converted) | SAM prereq, Norg |
| Stop_Your_Whining.lua | PRESENT (Converted) | Norg |
| Secret_of_the_Damp_Scroll.lua | PRESENT (Converted) | Norg |
| The_Sahagins_Stash.lua | PRESENT (Converted) | Norg |
| Like_Shining_Subligar.lua | PRESENT (Converted) | Norg, subligar quest |
| Like_Shining_Leggings.lua | PRESENT (Converted) | Norg |
| SAM_AF1_The_Sacred_Katana.lua | PRESENT (Converted) | SAM AF1 |
| SAM_AF2_Yomi_Okuri.lua | PRESENT (Converted) | SAM AF2 |
| SAM_AF3_A_Thief_in_Norg.lua | PRESENT (Converted) | SAM AF3 |
| The_Potential_Within.lua | PRESENT (Converted) | Norg, ENM access |
| Bugi_Soden.lua | PRESENT (Converted) | Norg |
| Wrath_of_the_Opo_Opos.lua | PRESENT (Converted) | Misc |
| Wandering_Souls.lua | PRESENT (Converted) | Misc |
| Soul_Searching.lua | PRESENT (Converted) | Misc |
| Divine_Might.lua | PRESENT (Converted) | Zilart endgame, earring rewards |
| Divine_Might_Repeat.lua | PRESENT (Converted) | Repeatable version |
| Open_Sesame.lua | PRESENT (Converted) | |
| The_Missing_Piece.lua | PRESENT (Converted) | Rabao |
| The_Kuftal_Tour.lua | PRESENT (Converted) | Rabao |
| Chasing_Dreams.lua | PRESENT (Converted) | CoP quest in Rabao |

#### Key MISSING Quests (Outlands)
| Quest | ID | Impact |
|---|---|---|
| The Firebloom Tree | 1 | Kazham quest |
| Greetings to the Guardian | 2 | Kazham quest |
| Missionary Man | 7 | Kazham |
| Gullible's Travels / Even More | 8-9 | Kazham |
| Personal Hygiene | 10 | Kazham |
| The Opo-opo and I | 11 | Kazham, gives Opo-opo Necklace (useful for Samurai) |
| Trial by Fire/Water/Wind | 12, 133, 194 | Avatar prime battles (handled via battlefield system) |
| The Sahagin's Key | 128 | Norg access quest |
| Black Market / Mama Mia | 130-131 | Norg quests |
| It's Not Your Vault | 137 | Norg |
| Twenty in Pirate Years / Big Box / True Will | 143-145 | SAM merit quests |
| Don't Forget the Antidote | 192 | Rabao |
| The Immortal Lu Shang | 196 | Lu Shang's fishing rod quest |
| Voidwatch Ops | 100-104 | Voidwatch (low priority) |

---

### Aht Urhgan (scripts/quests/ahtUrhgan/) -- 46 scripts / 62 defined

#### Scripts Present (46 files)
Highest coverage of all audited areas. Includes:
- **Job unlocks:** An_Empty_Vessel (BLU prereq), Luck_of_the_Draw (COR), No_Strings_Attached (PUP) -- ALL PRESENT
- **Job AF chains:** BLU AF1-3, COR AF1 -- PRESENT
- **Assault promotions:** All 9 promotion quests (PFC through 1st Lt) -- PRESENT
- **Story quests:** Saga of the Skyserpent, Ode to the Serpents, Waking the Colossus -- PRESENT
- **Side quests:** Keeping Notes, Arts and Crafts, Olduum, Got It All, etc. -- PRESENT
- **Besieged-related:** Give Peace a Chance, Fist of the People, Soothing Waters -- PRESENT

#### Key MISSING Quests (Aht Urhgan)
| Quest | ID | Impact |
|---|---|---|
| Get the Picture | 4 | Minor quest |
| Finding Faults | 8 | Minor quest |
| The Art of War | 10 | Minor quest |
| Totoroon's Treasure Hunt | 18 | Minor quest |
| PUP AF2-3 (Wayward Automaton, Operation Teatime) | 27-28 | PUP artifact armor |
| Puppetmaster Blues / Moment of Truth | 29-30 | PUP quests |
| Five Seconds of Fame | 32 | Minor quest |
| The Beast Within / Breaking Bonds of Fate | 40-41 | Important storyline quests |
| Promotion: Captain | 99 | Highest Assault rank |
| Scouting/Royal Painter/Targeting | 101-103 | Assault missions |
| An Imperial Heist / Duties Tasks and Deeds | 70-71 | Minor quests |
| Forging a New Myth / Coming Full Circle | 72-73 | Mythic weapon quests |
| The Rider Cometh / Unwavering Resolve / Stygian Pact | 76-78 | Summoner-related |

---

### Crystal War / WotG (scripts/quests/crystalWar/) -- 30 scripts / 79 defined

#### Scripts Present (30 files)
- **SCH unlock:** A_Little_Knowledge.lua + SCH AF1-2 -- PRESENT
- **WotG storyline:** Griffon chain (Gifts/Claws/Perils/Wrath of the Griffon) -- PRESENT
- **Side quests:** Lost in Translocation, Message on the Winds, Weekly Adventurer -- PRESENT
- **Her Memories chain:** 6 of ~10 quests present (Homecoming Queen, Operation Cupid, Carnelian Footfalls, Of Malign Maladies) -- PARTIAL
- **Misc:** Bonds That Never Die, Blood of Heroes, Boy and the Beast, Chasing Shadows, etc.

#### Key MISSING Quests (Crystal War)
| Quest | ID | Impact |
|---|---|---|
| Healing Herbs / Redeeming Rocks | 3-4 | Early WotG side quests |
| Better Part of Valor / Fires of Discontent | 12-13 | WotG quests |
| The Tigress Strikes | 18 | Continuation of Tigress storyline |
| Burden of Suspicion through Requiem for the Departed | 20-23 | Multiple WotG quests |
| Knot Quite There / Manifest Problem | 27-28 | WotG quests |
| Beast from the East / The Swarm | 30-31 | WotG quests |
| Seeing Blood Red / Storm on the Horizon | 34-35 | WotG quests |
| When One Man Is Not Enough / Feast for Gnats | 39-40 | WotG quests |
| Quelling the Storm / Honor Under Fire | 42-43 | WotG quests |
| The Long March North through What Price Loyalty | 46-50 | 5 WotG quests |
| Sins of the Mothers through The Truth Lies Hid | 53-58 | 6 WotG quests |
| Bonds of Mythril | 59 | WotG quest |
| Manifest Destiny / At Journey's End | 62-63 | WotG finale quests |
| Her Memories: Azure/Verdure Footfalls | 70-71 | Cavernous Maw quests |
| Champion of the Dawn through Forbidden Reunion | 73-75 | WotG finale |
| Voidwatch chain (80-98) | 80-98 | ~19 Voidwatch quests (largely unimplemented) |

---

### Abyssea (scripts/quests/abyssea/) -- 49 scripts / 155 defined

#### Scripts Present (49 files)
- **Entry quests:** A_Journey_Begins.lua, The_Truth_Beckons.lua -- PRESENT
- **Dominion Ops:** 42 scripts (14 each for Altepa, Uleguerand, Grauberg) -- ALL PRESENT
- **Story quests:** Scars_of_Abyssea.lua, A_Beaked_Blusterer.lua, A_Goldstruck_Gigas.lua, To_Paste_a_Peiste.lua, Megadrile_Menace.lua -- PRESENT

#### Key MISSING Quests (Abyssea)
| Category | Count | Impact |
|---|---|---|
| Zone maintenance quests (Ward Warden/Desert Rain/Crimson Carpet/Refuel/Martello) | ~63 | Repeatable zone buff quests |
| Zone boss prerequisite chains | ~15 | Access to NM fights |
| Story quests (Dawn of Death through Champions/Heroes of Abyssea) | ~20 | Abyssea storyline |
| Miscellaneous side quests | ~8 | Various NPC quests in Abyssea zones |

> **Critical note:** The Abyssea entry path (A Journey Begins -> The Truth Beckons) works. Dominion Ops (the primary repeatable content) are fully implemented. The missing quests are mostly story progression and zone maintenance -- the core Abyssea gameplay loop of farming NMs via Dominion Ops is functional.

---

### Adoulin / SoA (scripts/quests/adoulin/) -- 14 scripts / 73 defined

#### Scripts Present (14 files)
| Script | Status | Notes |
|---|---|---|
| A_Certain_Substitute_Patrolman.lua | PRESENT (Converted) | |
| A_Good_Pair_of_Crocs.lua | PRESENT (Converted) | |
| A_Shot_in_the_Dark.lua | PRESENT (Converted) | |
| A_Stones_Throw_Away.lua | PRESENT (Converted) | |
| Breaking_the_Ice.lua | PRESENT (Converted) | |
| Flavors_of_Our_Lives.lua | PRESENT (Converted) | |
| Hide_and_Go_Peak.lua | PRESENT (Converted) | |
| Hunger_Strikes.lua | PRESENT (Converted) | |
| Im_on_a_Boat.lua | PRESENT (Converted) | |
| It_Sets_My_Heart_Aflutter.lua | PRESENT (Converted) | |
| Lerenes_Lament.lua | PRESENT (Converted) | |
| The_Longest_Way_Round.lua | PRESENT (Converted) | |
| The_Starving.lua | PRESENT (Converted) | |
| Transporting.lua | PRESENT (Converted) | |

#### Key MISSING Quests (Adoulin)
| Quest | ID | Impact |
|---|---|---|
| Colonization quests (Twitherym Dust through Unsullied Lands) | 0-12 | Pioneer Coalition tasks |
| Waypoint quests | 50-51 | Waypoint unlocks |
| Leafallia story quests | 70-77 | SoA storyline |
| GEO-related quests (Geomancerrific, etc.) | 134+ | GEO advancement |
| RUN-related quests (Rune Fencing the Night Away) | 135 | RUN advancement |
| Most task/coalition quests | Various | SoA side content |

> **Critical note:** GEO unlock (Dances with Luopans, ID 118) and RUN unlock (Children of the Rune, ID 119) are NOT in this folder but ARE fully implemented in zone NPC scripts (`scripts/zones/Western_Adoulin/npcs/Sylvie.lua` and `scripts/zones/Eastern_Adoulin/npcs/Octavien.lua`). Both call `player:unlockJob()` correctly.

---

## Key Findings and Risk Assessment

### What WORKS (all job unlocks verified):
1. **Sub-job unlock** (Elder Memories / The Old Lady) -- fully functional in Selbina/Mhaura NPC scripts
2. **SAM unlock** (Forge Your Destiny -> The Sacred Katana) -- fully functional, complete AF chain
3. **NIN unlock** (Ayame and Kaede) -- fully functional (filed under Bastok quests)
4. **DNC unlock** (Lakeside Minuet) -- fully functional (filed under Jeuno quests, requires WotG enabled)
5. **SCH unlock** (A Little Knowledge) -- fully functional with AF chain
6. **BLU unlock** (An Empty Vessel) -- fully functional with AF chain
7. **COR unlock** (Luck of the Draw) -- fully functional
8. **PUP unlock** (No Strings Attached) -- fully functional
9. **GEO unlock** (Dances with Luopans) -- fully functional in zone NPC
10. **RUN unlock** (Children of the Rune) -- fully functional in zone NPC
11. **Divine Might** -- fully functional, earring rewards (Suppanomimi etc.) work
12. **Abyssea entry** (A Journey Begins + Truth Beckons) -- functional
13. **Abyssea Dominion Ops** -- all 42 implemented

### What is MISSING or at risk:
1. **Adoulin content** is the least complete (19.2% coverage) -- most SoA quests have no scripts
2. **Crystal War / WotG** has significant gaps (38.0%) -- many storyline quests missing
3. **Abyssea** has low raw coverage (31.6%) but the core gameplay loop works; missing quests are mostly repeatable maintenance and story
4. **PUP AF2-3** quests are missing (Wayward Automaton, Operation Teatime) -- PUP artifact armor beyond AF1 may not be obtainable via quests
5. **Mythic weapon quests** (Forging a New Myth, Coming Full Circle) are missing from Aht Urhgan
6. **SAM merit quests** (Twenty in Pirate Years, I'll Take the Big Box, True Will) -- marked `-- +` but no quest scripts in folder; may be in NPC scripts
7. **Trial by Fire/Water/Wind** avatar battles -- marked `-- +` but no quest scripts; likely handled via battlefield system
8. **Voidwatch** content is largely unimplemented across all areas

### Implementation Pattern Note:
Many quests marked `-- +` (implemented) in `quests.lua` do NOT have corresponding files in the quest script folders. These are handled in one of two ways:
- **Zone NPC scripts** (old-style, like the subjob quests)
- **Battlefield/global systems** (like Trial by Fire)

The `-- + Converted` marker means the quest uses the newer Interaction Framework and has a dedicated quest file. The `-- +` marker (without "Converted") means implemented but in older NPC-based scripts.
