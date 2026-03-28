# Expansion-Specific Side Quests (ToAU, WotG, Adoulin)

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Aht_Urhgan_Quests
- bg-wiki: https://www.bg-wiki.com/ffxi/Wings_of_the_Goddess_Quests
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Adoulin_Quests
- Codebase: `scripts/quests/ahtUrhgan/`, `scripts/quests/crystalWar/`, `scripts/quests/adoulin/`
- Quest registry: `scripts/globals/quests.lua`

## Summary
Aht Urhgan is the strongest expansion at 61.3% implemented. Crystal War is at 30.6% with many quest chains incomplete. Adoulin is the weakest at 14.6% with almost no story quests, no RUN/GEO AF quests, no coalition assignments, and a stub Mog Garden.

---

## 1. Aht Urhgan Quests (ToAU)

**Retail total: 75 quests** (per bg-wiki) | **Registered in quests.lua: 62 entries** | **Script files: 46** | **Converted (full impl): 42**

### Overall: 46/75 = 61.3%

### Checklist - Implemented (46 scripts, 42 fully converted)

| Quest | Status | Notes |
|-------|--------|-------|
| Keeping Notes | WORKS | Converted |
| Arts and Crafts | WORKS | Converted |
| Olduum | WORKS | Converted |
| Got It All | WORKS | Converted |
| An Empty Vessel | WORKS | Converted |
| Luck of the Draw | WORKS | Converted |
| No Strings Attached | WORKS | Converted |
| Give Peace a Chance | WORKS | Converted |
| A Taste of Honey | WORKS | Converted |
| Such Sweet Sorrow | WORKS | Converted |
| Fear of the Dark II | WORKS | Converted |
| Cook-a-roon? | WORKS | Converted |
| The Die Is Cast | WORKS | Converted |
| Two Horn the Savage | WORKS | Converted |
| What Friends Are For | WORKS | Converted |
| Rock Bottom | WORKS | Converted |
| Three Men and a Closet | WORKS | Converted |
| Saga of the Skyserpent | WORKS | Converted |
| Ode to the Serpents | WORKS | Converted |
| When the Bow Breaks | WORKS | Converted |
| Fist of the People | WORKS | Converted |
| Soothing Waters | WORKS | Converted |
| Embers of His Past | WORKS | Converted |
| The Prankster | WORKS | Converted |
| Delivering the Goods | WORKS | Converted |
| Vanishing Act | WORKS | Converted |
| Striking a Balance | WORKS | Converted |
| Not Meant to Be | WORKS | Converted |
| Led Astray | WORKS | Converted |
| Rat Race | WORKS | Converted |
| The Prince and the Hopper | WORKS | Converted |
| Waking the Colossus | WORKS | Converted |
| Divine Interference | WORKS | Converted |
| **BLU AF: Beginnings** | WORKS | Converted (BLU_AF1) |
| **BLU AF: Omens** | WORKS | Converted (BLU_AF2) |
| **BLU AF: Transformations** | WORKS | Converted (BLU_AF3) |
| **COR AF: Equipped for All Occasions** | WORKS | Converted (COR_AF1) |
| **Promotion: Private First Class** | WORKS | Converted |
| **Promotion: Superior Private** | WORKS | Converted |
| **Promotion: Lance Corporal** | WORKS | Converted |
| **Promotion: Corporal** | WORKS | Converted |
| **Promotion: Sergeant** | WORKS | Converted |
| **Promotion: Sergeant Major** | WORKS | Converted |
| **Promotion: Chief Sergeant** | WORKS | Converted |
| **Promotion: Second Lieutenant** | WORKS | Converted |
| **Promotion: First Lieutenant** | WORKS | Converted |

### Checklist - Registered but NOT Implemented (16 entries, no script)

| Quest | Status | Notes |
|-------|--------|-------|
| Get the Picture | MISSING | Registered only (id=4) |
| Finding Faults | MISSING | Registered only (id=8) |
| The Art of War | MISSING | Registered only (id=10) |
| Totoroon's Treasure Hunt | MISSING | Registered only (id=18) |
| Navigating the Unfriendly Seas | PARTIAL | Marked "+" but no dedicated script; COR AF2 |
| Against All Odds | PARTIAL | Marked "+" but no dedicated script; COR AF3 |
| The Wayward Automaton | PARTIAL | Marked "+" but no dedicated script; PUP AF1 |
| Operation Teatime | PARTIAL | Marked "+" but no dedicated script; PUP AF2 |
| Puppetmaster Blues | MISSING | PUP AF3 - not marked as implemented |
| Moment of Truth | MISSING | Registered only (id=30) |
| Five Seconds of Fame | MISSING | Registered only (id=32) |
| The Beast Within | MISSING | Related to SMN quest |
| Breaking the Bonds of Fate | MISSING | Related to SMN quest |
| **Promotion: Captain** | MISSING | Final mercenary rank - not implemented |
| VW Op. 050: Aht Urhgan Assault | MISSING | Voidwatch quest |
| VW Op. 068: Subterranean Skirmish | MISSING | Voidwatch quest |

### Checklist - Not Even Registered (13 bg-wiki quests with no entry)

| Quest | Status | Notes |
|-------|--------|-------|
| A Stygian Pact | MISSING | Registered as id=78, no script |
| An Imperial Heist | MISSING | Registered as id=70, no script |
| Duties, Tasks, and Deeds | MISSING | Registered as id=71, no script |
| Forging a New Myth | MISSING | Registered as id=72, no script |
| Coming Full Circle | MISSING | Registered as id=73, no script |
| The Rider Cometh | MISSING | Registered as id=76, no script |
| Unwavering Resolve | MISSING | Registered as id=77, no script |
| Scouting the Ashu Talif | MISSING | Registered as id=101, no script |
| Royal Painter Escort | MISSING | Registered as id=102, no script |
| Targeting the Captain | MISSING | Registered as id=103, no script |
| Lure of the Wildcat | MISSING | Not in quests.lua at all |
| Five Seconds of Fame | MISSING | Registered but no script |
| Get the Picture | MISSING | Registered but no script |

### Key Missing Quests (Gameplay Impact)

| Quest | Impact | Notes |
|-------|--------|-------|
| **Promotion: Captain** | HIGH | Final mercenary rank, gates content |
| **Puppetmaster Blues** | MEDIUM | PUP AF3 quest - PUP job incomplete AF chain |
| **COR AF2-3 (Navigating/Against All Odds)** | MEDIUM | Marked "+" in quests.lua but no script files found |
| **PUP AF1-2 (Wayward Automaton/Teatime)** | MEDIUM | Marked "+" but no script files; may be handled by NPC scripts |
| **Soultrapper system** | WORKS | Item scripts exist (`scripts/items/soultrapper.lua`), ZNM system present |

---

## 2. Crystal War Quests (WotG)

**Retail total: ~98 quests** (per bg-wiki) | **Registered in quests.lua: 98 entries** | **Script files: 30** | **Converted (full impl): 28**

### Overall: 30/98 = 30.6%

### Implemented Quest Chains

#### Bastok [S] Chain (Griffon series)
| Quest | Status | Notes |
|-------|--------|-------|
| The Fighting Fourth | WORKS | Converted (WOTG_BAS_0) |
| Steamed Rams | WORKS | Converted |
| Claws of the Griffon | WORKS | Converted |
| Gifts of the Griffon | WORKS | Converted |
| Perils of the Griffon | WORKS | Converted |
| Wrath of the Griffon | WORKS | Converted |
| In a Haze of Glory | WORKS | Converted |
| **The Tigress Stirs** | MISSING | Marked "+" but no script |
| **The Tigress Strikes** | MISSING | No script |

#### San d'Oria [S] Chain
| Quest | Status | Notes |
|-------|--------|-------|
| Lost in Translocation | WORKS | Converted |
| Message on the Winds | WORKS | Converted |
| The Weekly Adventurer | WORKS | Converted |
| A Little Knowledge | WORKS | Converted |
| Light in the Darkness | WORKS | Converted |
| Seeing Spots | WORKS | Converted |
| The Flipside of Things | WORKS | Converted |
| Boy and the Beast | WORKS | Converted |
| The Lost Book | WORKS | Converted |
| Hammering Hearts | WORKS | Converted |
| The Dawn of Delectability | WORKS | Converted |

#### Windurst [S] Chain
| Quest | Status | Notes |
|-------|--------|-------|
| Songbirds in a Snowstorm | WORKS | Converted |
| Blood of Heroes | WORKS | Converted |

#### Her Memories Chain (Cait Sith storyline)
| Quest | Status | Notes |
|-------|--------|-------|
| Her Memories: Homecoming Queen | WORKS | Converted |
| Her Memories: Operation Cupid | WORKS | Converted |
| Her Memories: Carnelian Footfalls | WORKS | Converted |
| Her Memories: Of Malign Maladies | WORKS | Converted |
| Her Memories: Old Bean | PARTIAL | Marked "+" in quests.lua, no dedicated script found |
| Her Memories: The Faux Pas | PARTIAL | Marked "+" in quests.lua, no dedicated script found |
| Her Memories: Grave Resolve | PARTIAL | Marked "+" in quests.lua, no dedicated script found |
| Her Memories: Azure Footfalls | MISSING | Not implemented |
| Her Memories: Verdure Footfalls | MISSING | Not implemented |

#### Other Implemented
| Quest | Status | Notes |
|-------|--------|-------|
| SCH AF: On Sabbatical | WORKS | Converted (SCH_AF1) |
| SCH AF: Downward Helix | WORKS | Converted (SCH_AF2) |
| Chasing Shadows | WORKS | Converted |
| Face of the Future | WORKS | Converted |
| Bonds That Never Die | WORKS | Converted |
| The Price of Valor | WORKS | Converted |

### Major Missing Quest Chains

#### San d'Oria [S] - Missing Later Quests
| Quest | Status |
|-------|--------|
| Burden of Suspicion | MISSING |
| Evil at the Inlet | MISSING |
| The Fumbling Friar | MISSING |
| Requiem for the Departed | MISSING |
| The Forbidden Path | MISSING |
| Beneath the Mask | MISSING |
| A Jeweler's Lament | MISSING |

#### Bastok [S] - Missing Later Quests
| Quest | Status |
|-------|--------|
| The Tigress Stirs | MISSING |
| The Tigress Strikes | MISSING |
| Better Part of Valor | MISSING |
| Fires of Discontent | MISSING |
| Storm on the Horizon | MISSING |
| Fire in the Hole | MISSING |
| When One Man Is Not Enough | MISSING |
| Honor Under Fire | MISSING |

#### Windurst [S] - Almost Entirely Missing
| Quest | Status |
|-------|--------|
| Healing Herbs | MISSING |
| Redeeming Rocks | MISSING |
| Snake on the Plains | MISSING |
| A Feast for Gnats | MISSING |
| Quelling the Storm | MISSING |
| Sins of the Mothers | MISSING |
| Howl from the Heavens | MISSING |
| The Swarm | MISSING |
| Son and Father | MISSING |
| The Truth Lies Hid | MISSING |
| Bonds of Mythril | MISSING |

#### DNC AF Chain - MISSING
| Quest | Status | Notes |
|-------|--------|-------|
| Seeing Blood-red | MISSING | DNC AF quests not in crystalWar folder |
| Say It with a Handbag | PARTIAL | Noted in quests.lua: "Can be completed, but reward latent not implemented" |

#### Voidwatch/Walk of Echoes Chain - MISSING
| Quest | Status |
|-------|--------|
| Guardian of the Void | MISSING |
| Drafted by the Duchy | MISSING |
| Battle on a New Front | MISSING |
| All Voidwatch/WoE quests | MISSING |

#### Cait Sith Endgame Chain - MISSING
| Quest | Status |
|-------|--------|
| Champion of the Dawn | MISSING |
| The Dawn Also Rises | MISSING |
| A Forbidden Reunion | MISSING |
| Crystal Guardian | MISSING |
| Endings and Beginnings | MISSING |
| Ad Infinitum | MISSING |

### Key Missing Quests (Gameplay Impact)

| Quest | Impact | Notes |
|-------|--------|-------|
| **DNC AF chain** | HIGH | Dancer artifact armor quests not implemented |
| **SCH AF3** | MEDIUM | Only AF1-AF2 present (On Sabbatical, Downward Helix) |
| **Windurst [S] chain** | HIGH | Only 2 of ~13 quests implemented; gates WotG mission progression |
| **Cait Sith endgame** | HIGH | Final story quests missing (Champion of Dawn through Ad Infinitum) |
| **Later Sandy/Bastok [S]** | MEDIUM | Chains cut off partway through |

---

## 3. Adoulin Quests (SoA)

**Retail total: ~96 quests** (per bg-wiki) | **Registered in quests.lua: ~80 entries** | **Script files: 14** | **Coalition assignments registered: 96 entries (separate log)**

### Overall Side Quests: 14/96 = 14.6%

### Implemented Quests (14 scripts)

| Quest | Status | Notes |
|-------|--------|-------|
| A Certain Substitute Patrolman | WORKS | Converted |
| A Good Pair of Crocs | WORKS | Converted |
| A Shot in the Dark | WORKS | Converted |
| A Stone's Throw Away | WORKS | Converted |
| Breaking the Ice | WORKS | Converted |
| Flavors of Our Lives | WORKS | Converted |
| Hide and Go Peak | WORKS | Converted |
| Hunger Strikes | WORKS | Converted |
| I'm on a Boat | WORKS | Converted |
| It Sets My Heart Aflutter | WORKS | Converted |
| Lerene's Lament | WORKS | Converted |
| The Longest Way Round | WORKS | Converted |
| The Starving | WORKS | Converted |
| Transporting | WORKS | Converted |

### Major Missing Systems

#### RUN Artifact Quests - ALL MISSING
| Quest | Status | Notes |
|-------|--------|-------|
| Children of the Rune | MISSING | Registered in quests.lua (id=119), no script |
| Endeavoring to Awaken | MISSING | Registered (id=22), no script |
| Forging New Bonds | MISSING | Registered (id=23), no script |
| Rune Fencing the Night Away | MISSING | Registered (id=135), no script |
| Legacies Lost and Found | MISSING | Registered (id=24), no script |
| Destiny's Device | MISSING | Registered (id=25), no script |
| Epiphany | MISSING | Registered (id=143), no script |
| Quiescence | MISSING | Registered (id=132), no script |

#### GEO Artifact Quests - ALL MISSING
| Quest | Status | Notes |
|-------|--------|-------|
| Dances with Luopans | MISSING | Registered (id=118), no script |
| Elementary, My Dear Sylvie | MISSING | Registered (id=35), no script |
| For Whom the Bell Tolls | MISSING | Registered (id=36), no script |
| Geomancerrific | MISSING | Registered (id=134), no script |
| The Bloodline of Zacariah | MISSING | Registered (id=37), no script |
| The Communion | MISSING | Registered (id=38), no script |
| Treasures of the Earth | MISSING | Registered (id=142), no script |
| Saved by the Bell | MISSING | Registered (id=131), no script |

#### Coalition Assignments
| System | Status | Notes |
|--------|--------|-------|
| Coalition quest log | PARTIAL | 96 entries registered in quests.lua (Procure, Clear, Provide, Deliver, Support, Gather, Survey, Analyze, Preserve, Patrol, Recover, Research, Boost) |
| Coalition NPC scripts | PARTIAL | NPCs exist in Eastern/Western Adoulin but no assignment script files found |
| Actual assignment gameplay | MISSING | No quest scripts in a coalition folder; system is not functional |

#### Mog Garden
| System | Status | Notes |
|--------|--------|-------|
| Zone accessible | PARTIAL | `scripts/globals/mog_garden.lua` exists but is mostly TODO stubs |
| Green Thumb Moogle | PARTIAL | NPC script exists, hides all NPCs by default |
| Gardening/Fishing/Etc | MISSING | No gameplay systems implemented |

#### Story/Side Quest Chains - MISSING
| Quest Chain | Status | Notes |
|-------------|--------|-------|
| Vegetable Vegetable series (4 quests) | MISSING | Registered, no scripts |
| A Thirst series (4 quests) | MISSING | Registered, no scripts |
| Weatherspoon series (2 quests) | MISSING | Registered, no scripts |
| Waypoint quests (Western/Wes-Eastern/Wayward) | MISSING | Registered, no scripts |
| Melvien investigation chain | MISSING | Registered, no scripts |
| Velkkovert Operations | MISSING | Registered, no scripts |

### Key Missing Quests (Gameplay Impact)

| Quest/System | Impact | Notes |
|-------------|--------|-------|
| **RUN AF chain (8 quests)** | CRITICAL | Rune Fencer has no artifact armor quests at all |
| **GEO AF chain (8 quests)** | CRITICAL | Geomancer has no artifact armor quests at all |
| **Coalition assignments** | HIGH | Core Adoulin progression system; 96 assignments registered but none functional |
| **Mog Garden** | MEDIUM | Zone exists but completely non-functional |
| **Waypoint expansion quests** | MEDIUM | Western/Eastern waypoint unlock quests missing |

---

## Overall Expansion Quest Summary

| Expansion | Retail Quests | Implemented | Percentage | Key Gaps |
|-----------|--------------|-------------|------------|----------|
| **Aht Urhgan (ToAU)** | 75 | 46 | **61.3%** | Captain promo, PUP AF3, a few side quests |
| **Crystal War (WotG)** | 98 | 30 | **30.6%** | DNC AF, Windy [S] chain, Cait Sith endgame, most side quests |
| **Adoulin (SoA)** | 96 | 14 | **14.6%** | RUN AF, GEO AF, all coalitions, Mog Garden, most quests |
| **Combined** | 269 | 90 | **33.5%** | |

## Blockers
- **RUN/GEO jobs**: No artifact armor questlines at all - players must use alternative gear or GM intervention
- **DNC job**: AF quests not in crystalWar folder; may need to check other locations or are simply missing
- **Coalition system**: Infrastructure registered but no functional quest scripts
- **Mog Garden**: Zone stub only, no gameplay
- **WotG mission progression**: Some Crystal War side quests gate mission progression; missing chains may block story advancement

## Fix Difficulty
- **ToAU gaps**: Easy-Medium (mostly missing a few quests; PUP/COR AF may be partially handled by NPC zone scripts)
- **WotG gaps**: Hard (68 quests missing, multiple interconnected chains)
- **Adoulin gaps**: Massive (82 quests missing, two full AF chains, entire coalition system, Mog Garden)
