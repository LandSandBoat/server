# Expansion-Specific Quests (ToAU, WotG, Abyssea, Adoulin, Coalition) -- Phase 2 Audit (CORRECTED)

**CORRECTION NOTE:** Previous audit undercounted quests. This file is corrected using the definitive source: `scripts/globals/quests.lua` markers (`+` = implemented, `Converted` = Interaction Framework). Previous audit counted scripts in quest folders only; this audit counts implementation markers which also cover quests implemented in zone NPC scripts.

**Date:** 2026-03-28 (corrected)
**Source:** `scripts/globals/quests.lua` quest ID definitions and implementation markers

---

## Overall Summary

| Expansion | Defined in quests.lua | Implemented (+/Converted) | Coverage | Change from Previous |
|-----------|----------------------|--------------------------|----------|---------------------|
| Aht Urhgan (ToAU) | 72 | 50 | **69.4%** | was 61.3% (46/75) |
| Crystal War (WotG) | 95 | 37 | **38.9%** | was 30.6% (30/98) |
| Abyssea | 192 | 49 | **25.5%** | was 31.6% (49/155) |
| Adoulin (SoA) | 97 | 18 | **18.6%** | was 14.6% (14/96) |
| Coalition | 95 | 0 | **0.0%** | unchanged |
| **TOTAL** | **551** | **154** | **28.0%** | |

> **Note on Abyssea coverage drop:** The raw percentage dropped from 31.6% to 25.5% because the previous audit only counted 155 defined quests. The correct count is 192 (including zone maintenance quests like Ward Warden, Desert Rain, Crimson Carpet, Refuel & Replenish, Mightier Martello). The 49 implemented quests are unchanged.

> **Note on Adoulin increase:** 4 additional quests found with `+` markers (Exotic Delicacies, A Pioneer's Best Imaginary Friend, The Old Man and the Harpoon, Always More Quoth the Ravenous) that were not counted previously because they have no dedicated quest script files.

---

## 1. Aht Urhgan Quests (ToAU) -- 50/72 (69.4%)

### Implemented Quests (50)

| Quest | ID | Marker | Notes |
|-------|-----|--------|-------|
| Keeping Notes | 0 | Converted | |
| Arts and Crafts | 1 | Converted | |
| Olduum | 2 | Converted | |
| Got It All | 3 | Converted | |
| An Empty Vessel | 5 | Converted | BLU unlock |
| Luck of the Draw | 6 | Converted | COR unlock |
| No Strings Attached | 7 | Converted | PUP unlock |
| Give Peace a Chance | 9 | Converted | Besieged-related |
| A Taste of Honey | 12 | Converted | |
| Such Sweet Sorrow | 13 | Converted | |
| Fear of the Dark II | 14 | Converted | |
| Cook-a-roon? | 15 | Converted | |
| The Die Is Cast | 16 | Converted | |
| Two Horn the Savage | 17 | Converted | |
| What Friends Are For | 19 | Converted | |
| Rock Bottom | 20 | Converted | |
| Beginnings | 21 | Converted | BLU AF1 |
| Omens | 22 | Converted | BLU AF2 |
| Transformations | 23 | Converted | BLU AF3 |
| Equipped for All Occasions | 24 | Converted | COR AF1 |
| Navigating the Unfriendly Seas | 25 | + | COR AF2 (zone NPC script) |
| Against All Odds | 26 | + | COR AF3 (zone NPC script) |
| The Wayward Automaton | 27 | + | PUP AF1 (zone NPC script) |
| Operation Teatime | 28 | + | PUP AF2 (zone NPC script) |
| Three Men and a Closet | 31 | Converted | |
| Saga of the Skyserpent | 43 | Converted | |
| Ode to the Serpents | 44 | Converted | |
| When the Bow Breaks | 45 | Converted | |
| Fist of the People | 46 | Converted | Besieged-related |
| Soothing Waters | 47 | Converted | |
| Embers of His Past | 48 | Converted | |
| The Prankster | 60 | Converted | |
| Delivering the Goods | 61 | Converted | |
| Vanishing Act | 62 | Converted | |
| Striking a Balance | 63 | Converted | |
| Not Meant to Be | 64 | Converted | |
| Led Astray | 65 | Converted | |
| Rat Race | 66 | Converted | |
| The Prince and the Hopper | 67 | Converted | |
| Waking the Colossus | 74 | Converted | |
| Divine Interference | 75 | Converted | |
| Promotion: Private First Class | 90 | Converted | Assault rank |
| Promotion: Superior Private | 91 | Converted | Assault rank |
| Promotion: Lance Corporal | 92 | Converted | Assault rank |
| Promotion: Corporal | 93 | Converted | Assault rank |
| Promotion: Sergeant | 94 | Converted | Assault rank |
| Promotion: Sergeant Major | 95 | Converted | Assault rank |
| Promotion: Chief Sergeant | 96 | Converted | Assault rank |
| Promotion: Second Lieutenant | 97 | Converted | Assault rank |
| Promotion: First Lieutenant | 98 | Converted | Assault rank |

### Missing Quests (22)

| Quest | ID | Impact |
|-------|-----|--------|
| Get the Picture | 4 | Minor quest |
| Finding Faults | 8 | Minor quest |
| The Art of War | 10 | Minor quest |
| Totoroon's Treasure Hunt | 18 | Minor quest |
| Puppetmaster Blues | 29 | PUP AF3 -- PUP artifact armor chain incomplete |
| Moment of Truth | 30 | Minor quest |
| Five Seconds of Fame | 32 | Minor quest |
| The Beast Within | 40 | SMN-related storyline |
| Breaking the Bonds of Fate | 41 | SMN-related storyline |
| VW Op. 050: Aht Urhgan Assault | 68 | Voidwatch (low priority) |
| VW Op. 068: Subterranean Skirmish | 69 | Voidwatch (low priority) |
| An Imperial Heist | 70 | Minor quest |
| Duties, Tasks, and Deeds | 71 | Minor quest |
| Forging a New Myth | 72 | Mythic weapon quest |
| Coming Full Circle | 73 | Mythic weapon quest |
| The Rider Cometh | 76 | SMN-related |
| Unwavering Resolve | 77 | SMN-related |
| A Stygian Pact | 78 | SMN-related |
| Promotion: Captain | 99 | Final mercenary rank -- gates content |
| Scouting the Ashu Talif | 101 | Assault mission |
| Royal Painter Escort | 102 | Assault mission |
| Targeting the Captain | 103 | Assault mission |

### Key Missing (Gameplay Impact)

| Quest | Impact | Notes |
|-------|--------|-------|
| **Promotion: Captain** | HIGH | Final mercenary rank, gates content |
| **Puppetmaster Blues** | MEDIUM | PUP AF3 -- incomplete AF chain (AF1-2 work via NPC scripts) |
| **Mythic weapon quests** | MEDIUM | Forging a New Myth / Coming Full Circle |
| **SMN quests** | LOW | Beast Within / Rider Cometh chain |

---

## 2. Crystal War Quests (WotG) -- 37/95 (38.9%)

### Implemented Quests (37)

| Quest | ID | Marker | Notes |
|-------|-----|--------|-------|
| Lost in Translocation | 0 | Converted | Sandy [S] |
| Message on the Winds | 1 | Converted | Sandy [S] |
| The Weekly Adventurer | 2 | Converted | Sandy [S] |
| The Dawn of Delectability | 5 | Converted | Sandy [S] |
| A Little Knowledge | 6 | Converted | SCH unlock |
| The Fighting Fourth | 7 | Converted | Bastok [S] |
| Snake on the Plains | 8 | + | Windy [S] |
| Steamed Rams | 9 | Converted | Bastok [S] |
| Seeing Spots | 10 | Converted | Sandy [S] |
| The Flipside of Things | 11 | Converted | Sandy [S] |
| Hammering Hearts | 14 | Converted | Sandy [S] |
| Gifts of the Griffon | 15 | Converted | Bastok [S] Griffon chain |
| Claws of the Griffon | 16 | Converted | Bastok [S] Griffon chain |
| The Tigress Stirs | 17 | + | Bastok [S] (zone NPC script) |
| Light in the Darkness | 19 | Converted | Sandy [S] |
| Boy and the Beast | 24 | Converted | Sandy [S] |
| Wrath of the Griffon | 25 | Converted | Bastok [S] Griffon chain |
| The Lost Book | 26 | Converted | Sandy [S] |
| Beans Ahoy | 29 | + | |
| On Sabbatical | 32 | Converted | SCH AF1 |
| Downward Helix | 33 | Converted | SCH AF2 |
| Perils of the Griffon | 37 | Converted | Bastok [S] Griffon chain |
| In a Haze of Glory | 38 | Converted | Bastok [S] |
| Say It with a Handbag | 41 | + | DNC AF (reward latent NOT implemented) |
| The Price of Valor | 44 | Converted | |
| Bonds That Never Die | 45 | Converted | |
| Songbirds in a Snowstorm | 51 | Converted | Windy [S] |
| Blood of Heroes | 52 | Converted | Windy [S] |
| Chasing Shadows | 60 | Converted | |
| Face of the Future | 61 | Converted | |
| Her Memories: Homecoming Queen | 64 | Converted | Cait Sith chain |
| Her Memories: Old Bean | 65 | Converted | Cait Sith chain |
| Her Memories: The Faux Pas | 66 | Converted | Cait Sith chain |
| Her Memories: The Grave Resolve | 67 | Converted | Cait Sith chain |
| Her Memories: Operation Cupid | 68 | Converted | Cait Sith chain |
| Her Memories: Carnelian Footfalls | 69 | Converted | Cait Sith chain |
| Her Memories: Of Malign Maladies | 72 | Converted | Cait Sith chain |

### Missing Quests (58)

| Quest | ID | Impact |
|-------|-----|--------|
| Healing Herbs | 3 | Windy [S] early quest |
| Redeeming Rocks | 4 | Windy [S] early quest |
| Better Part of Valor | 12 | Bastok [S] |
| Fires of Discontent | 13 | Bastok [S] |
| The Tigress Strikes | 18 | Bastok [S] |
| Burden of Suspicion | 20 | Sandy [S] |
| Evil at the Inlet | 21 | Sandy [S] |
| The Fumbling Friar | 22 | Sandy [S] |
| Requiem for the Departed | 23 | Sandy [S] |
| Knot Quite There | 27 | |
| A Manifest Problem | 28 | |
| Beast from the East | 30 | |
| The Swarm | 31 | Windy [S] |
| Seeing Blood-red | 34 | DNC AF |
| Storm on the Horizon | 35 | |
| Fire in the Hole | 36 | |
| When One Man Is Not Enough | 39 | |
| A Feast for Gnats | 40 | Windy [S] |
| Quelling the Storm | 42 | |
| Honor Under Fire | 43 | |
| The Long March North | 46 | |
| The Forbidden Path | 47 | |
| A Jeweler's Lament | 48 | |
| Beneath the Mask | 49 | |
| What Price Loyalty | 50 | |
| Sins of the Mothers | 53 | Windy [S] |
| Howl from the Heavens | 54 | |
| Succor to the Sidhe | 55 | |
| The Young and the Threadless | 56 | |
| Son and Father | 57 | |
| The Truth Lies Hid | 58 | |
| Bonds of Mythril | 59 | |
| Manifest Destiny | 62 | WotG finale |
| At Journey's End | 63 | WotG finale |
| Her Memories: Azure Footfalls | 70 | Cait Sith chain |
| Her Memories: Verdure Footfalls | 71 | Cait Sith chain |
| Champion of the Dawn | 73 | WotG finale |
| The Dawn Also Rises | 74 | WotG finale |
| A Forbidden Reunion | 75 | WotG finale |
| Guardian of the Void | 80 | Voidwatch |
| Drafted by the Duchy | 81 | Voidwatch |
| Battle on a New Front | 82 | Voidwatch |
| Voidwalker Op. 126 | 83 | Voidwatch |
| A Cait Calls | 84 | Voidwatch |
| The Truth Is Out There | 85 | Voidwatch |
| Redrafted by the Duchy | 86 | Voidwatch |
| A New Menace | 87 | Voidwatch |
| No Rest for the Weary | 88 | Voidwatch |
| A World in Flux | 89 | Voidwatch |
| Between a Rock and Rift | 90 | Voidwatch |
| A Farewell to Felines | 91 | Voidwatch |
| Third Tour of Duchy | 92 | Voidwatch |
| Glimmer of Hope | 93 | Voidwatch |
| Brace for the Unknown | 94 | Voidwatch |
| Provenance | 95 | Voidwatch |
| Crystal Guardian | 96 | Cait Sith endgame |
| Endings and Beginnings | 97 | Cait Sith endgame |
| Ad Infinitum | 98 | Cait Sith endgame |

### Key Missing (Gameplay Impact)

| Quest/System | Impact | Notes |
|-------------|--------|-------|
| **DNC AF chain** | HIGH | Seeing Blood-red (34) missing; Say It with a Handbag works but reward latent broken |
| **SCH AF3** | MEDIUM | Only AF1-AF2 present (On Sabbatical, Downward Helix) |
| **Windurst [S] chain** | HIGH | Only 3 of ~13 quests (Snake on Plains, Songbirds, Blood of Heroes) |
| **Cait Sith endgame** | HIGH | 7 of 9 Her Memories present, but Champion of Dawn through Ad Infinitum missing |
| **Voidwatch** | MEDIUM | All 16 Voidwatch quests missing |
| **WotG finale** | HIGH | Manifest Destiny, At Journey's End, Dawn Also Rises missing |

---

## 3. Abyssea Quests -- 49/192 (25.5%)

### Implemented Quests (49)

#### Dominion Ops (42 quests, all Converted)
| Quest Range | Zone | Count |
|-------------|------|-------|
| Dominion Op 01-14 Altepa | Abyssea - Altepa | 14 |
| Dominion Op 01-14 Uleguerand | Abyssea - Uleguerand | 14 |
| Dominion Op 01-14 Grauberg | Abyssea - Grauberg | 14 |

#### Story/Entry Quests (7 quests)
| Quest | ID | Marker | Notes |
|-------|-----|--------|-------|
| A Journey Begins | 160 | Converted | Abyssea entry |
| The Truth Beckons | 161 | Converted | Abyssea entry |
| A Goldstruck Gigas | 163 | Converted | Story quest |
| To Paste a Peiste | 164 | Converted | Story quest |
| Megadrile Menace | 165 | Converted | Story quest |
| Scars of Abyssea | 175 | Converted | Story quest |
| A Beaked Blusterer | 176 | Converted | Story quest |

### Missing Quests (143)

| Category | ID Range | Count | Impact |
|----------|----------|-------|--------|
| Zone side quests (Attohwa/Misareaux/Vunkerl) | 0-49 | 50 | NPC-given side quests |
| Zone side quests (La Theine/Konschtat/Tahrongi) | 50-69 | 20 | NPC-given side quests |
| Zone side quests (Altepa/Uleguerand/Grauberg) | 70-86 | 17 | NPC-given side quests |
| Ward Warden (I & II, 3 zones) | 124-129 | 6 | Zone maintenance repeatable |
| Desert Rain (I & II, 3 zones) | 130-135 | 6 | Zone maintenance repeatable |
| Crimson Carpet (I & II, 3 zones) | 136-141 | 6 | Zone maintenance repeatable |
| Refuel and Replenish (9 zones) | 142-150 | 9 | Zone maintenance repeatable |
| A Mightier Martello (9 zones) | 151-159 | 9 | Zone maintenance repeatable |
| Story quests (Dawn of Death through Moonlight Requite) | 162, 166-186 | 20 | Abyssea storyline progression |

### Key Notes
- **Core gameplay loop works:** Abyssea entry (A Journey Begins + The Truth Beckons) is functional, and all 42 Dominion Ops (the primary repeatable content) are fully implemented.
- **Zone maintenance quests** (36 total: Ward Warden, Desert Rain, Crimson Carpet, Refuel, Martello) are all missing -- these are repeatable zone buff quests.
- **87 NPC side quests** (IDs 0-86) are all missing -- these cover a wide range of zone-specific content.
- **20 story quests** missing -- Dawn of Death through Moonlight Requite; gates storyline progression.

---

## 4. Adoulin Quests (SoA) -- 18/97 (18.6%)

### Implemented Quests (18)

| Quest | ID | Marker | Notes |
|-------|-----|--------|-------|
| Flavors of Our Lives | 46 | Converted | Colonization task |
| Breaking the Ice | 54 | Converted | Colonization task |
| I'm on a Boat | 55 | Converted | |
| A Stone's Throw Away | 56 | Converted | |
| Hide and Go Peak | 57 | Converted | |
| Exotic Delicacies | 74 | + | Zone NPC script |
| A Pioneer's Best Imaginary Friend | 75 | + | Zone NPC script |
| Hunger Strikes | 76 | Converted | |
| The Old Man and the Harpoon | 77 | + | Zone NPC script |
| A Certain Substitute Patrolman | 78 | Converted | |
| It Sets My Heart Aflutter | 79 | Converted | |
| Transporting | 82 | Converted | |
| The Starving | 84 | Converted | |
| Always More Quoth the Ravenous | 88 | + | Zone NPC script |
| The Longest Way Round | 91 | Converted | |
| A Good Pair of Crocs | 93 | Converted | |
| A Shot in the Dark | 96 | Converted | |
| Lerene's Lament | 126 | Converted | |

### Missing Quests (79)

| Category | Examples | Count | Impact |
|----------|----------|-------|--------|
| Pioneer Coalition colonization tasks | Twitherym Dust (0), To Catch a Predator (1), Empty Nest (2), etc. | 10 | Early Adoulin progression |
| Waypoint quests | Western Waypoints Ho (50), Weseastern Waypoints Ho (51) | 2 | Waypoint unlocks |
| Side quests (general) | Grind to Sawdust (53), The Whole Place Is Abuzz (58), etc. | 18 | Various side content |
| Leafallia story quests | Don't Ever Leaf Me (70), Keep Your Bloomers On (71), etc. | 4 | SoA storyline |
| GEO artifact quests | Elementary My Dear Sylvie (35), For Whom the Bell Tolls (36), etc. | 6 | GEO AF chain |
| GEO advancement | Geomancerrific (134), Saved by the Bell (131), Treasures of the Earth (142) | 3 | GEO progression |
| RUN artifact quests | Endeavoring to Awaken (22), Forging New Bonds (23), etc. | 4 | RUN AF chain |
| RUN advancement | Rune Fencing the Night Away (135), Quiescence (132), Epiphany (143) | 3 | RUN progression |
| Vegetable Vegetable series | Revolution (108), Evolution (109), Crisis (110), Frustration (111) | 4 | Quest chain |
| A Thirst series | Ages (114), Eons (115), Eternity (116), Before Time (117) | 4 | Quest chain |
| Weatherspoon/Melvien chain | Weatherspoon Inquisition (136), Eye of the Beholder (137), etc. | 6 | Investigation chain |
| Comedy/misc quests | No Laughing Matter (102), To Laugh Is to Love (104), etc. | 4 | Side content |
| Other missing | Flowers for Svenja (120), Velkkovert Operations (123), etc. | 11 | Various |

> **Critical note:** GEO unlock (Dances with Luopans, ID 118) and RUN unlock (Children of the Rune, ID 119) are registered in quests.lua but have NO `+` marker in quests.lua. However, they ARE fully implemented in zone NPC scripts (`scripts/zones/Western_Adoulin/npcs/Sylvie.lua` and `scripts/zones/Eastern_Adoulin/npcs/Octavien.lua`). Both call `player:unlockJob()` correctly. They appear as "missing" by the quests.lua marker methodology but are functional.

### Key Missing (Gameplay Impact)

| Quest/System | Impact | Notes |
|-------------|--------|-------|
| **RUN AF chain (7 quests)** | CRITICAL | Rune Fencer has no artifact armor quests |
| **GEO AF chain (9 quests)** | CRITICAL | Geomancer has no artifact armor quests |
| **Waypoint expansion** | MEDIUM | Western/Eastern waypoint unlock quests missing |
| **Mog Garden** | MEDIUM | Zone exists but non-functional (separate system) |

---

## 5. Coalition Assignments -- 0/95 (0.0%)

### Status: NOT IMPLEMENTED

All 95 coalition assignment quest IDs are registered in quests.lua but none have any implementation marker. These cover:

| Type | Zones | Count |
|------|-------|-------|
| Procure | 8 zones | 8 |
| Clear | 8 zones | 8 |
| Provide | 5 zones | 5 |
| Deliver | 5 zones | 5 |
| Support | 6 zones | 6 |
| Gather | 16 zones | 16 |
| Survey | 9 zones | 9 |
| Analyze | 7 zones | 7 |
| Preserve | 9 zones | 9 |
| Patrol | 7 zones | 7 |
| Recover | 6 zones | 6 |
| Research | 7 zones | 7 |
| Boost | 3 zones | 3 |
| **Total** | | **95** (1 blank entry excluded) |

The coalition system is the core repeatable content loop for Adoulin. All 95 assignments are registered but have zero implementation.

---

## Blockers

- **RUN/GEO jobs**: Unlock quests work (via NPC scripts), but no artifact armor questlines -- players must use alternative gear or GM intervention
- **DNC AF**: Say It with a Handbag (41) completable but reward latent not implemented; Seeing Blood-red (34) entirely missing
- **Coalition system**: All 95 assignments registered but none functional -- core Adoulin progression blocked
- **WotG mission progression**: Missing Crystal War side quests may block story advancement
- **Cait Sith endgame**: Final story quests (Champion of Dawn through Ad Infinitum) missing

## Fix Difficulty

| Area | Difficulty | Notes |
|------|-----------|-------|
| ToAU gaps | Easy-Medium | 22 quests missing; PUP AF3 and Captain promo most important |
| Crystal War gaps | Hard | 58 quests missing; multiple interconnected chains |
| Abyssea gaps | Hard | 143 quests missing; 87 side quests + 36 maintenance + 20 story |
| Adoulin gaps | Massive | 79 quests missing; two full AF chains, most side content |
| Coalition | Massive | 95 assignments; entire system needs building |
