# Adoulin Quests Deep Audit

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Adoulin_Quests
- Codebase: `scripts/quests/adoulin/` (14 quest scripts)
- Codebase: `scripts/zones/*/npcs/` (NPC-based quest implementations)
- Quest IDs: `scripts/globals/quests.lua` lines 1010-1111 (98 quest IDs defined)

## Summary
14 of ~103 retail Adoulin quests have dedicated quest scripts (the "Converted" format using the InteractionFramework). An additional ~15-20 quests have partial NPC-based implementations in zone NPC scripts. The two most critical quests -- GEO unlock (Dances with Luopans) and RUN unlock (Children of the Rune) -- are fully implemented as NPC scripts. All GEO AF (2-6) and RUN AF (2-7) quests beyond the unlock are MISSING. Coalition assignments have IDs defined but no quest scripts. Mog Garden is a stub zone with minimal NPC scripts.

## Coverage Statistics

| Category | Retail Count | Implemented | Percentage |
|---|---|---|---|
| Western Adoulin Quests | ~26 | 8 converted + ~8 NPC-based | ~62% partial |
| Eastern Adoulin Quests | ~23 | 4 converted + ~3 NPC-based | ~30% partial |
| Ulbuka Field Quests | ~27 | 6 converted + 0 NPC-based | ~22% |
| Geomancer Quest Line | 7 | 1 (unlock only, NPC-based) | 14% |
| Rune Fencer Quest Line | 8 | 1 (unlock only, NPC-based) | 13% |
| Coalition Assignments | ~77 IDs defined | 0 scripts | 0% |
| **Total Adoulin Quests** | **~103** | **14 converted + ~12 NPC-based** | **~25%** |

## Implemented Quest Scripts -- Detailed Audit

### 1. A Certain Substitute Patrolman
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/A_Certain_Substitute_Patrolman.lua` | Converted (InteractionFramework) |
| Accept | WORKS | Requires SOA mission >= LIFE_ON_THE_FRONTIER. Talk Rising_Solstice, get KI patrol route |
| Progress | WORKS | Visit 7 NPCs in order (Zaoso through Nylene), sequential Prog var 0-6 |
| Completion | WORKS | Return to Rising_Solstice when Prog==7, deletes KI |
| Rewards | WORKS | 500 bayld, 1000 exp, Adoulin fame. Matches bg-wiki |
| Equipment | N/A | No equipment rewards |
| Issues | None | Clean implementation |

### 2. A Good Pair of Crocs (Fame Cycle 2/3)
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/A_Good_Pair_of_Crocs.lua` | Converted |
| Accept | WORKS | First time: talk Felmsy, option==1. Repeat: requires all 3 fame quests complete + tracker==1 |
| Progress | WORKS | Trade Velkk Necklace OR Velkk Mask to Felmsy |
| Completion | WORKS | confirmTrade, sets tracker to 2 |
| Rewards | WORKS | 6 fame, 200 bayld, 500 exp. Repeatable fame cycle |
| Equipment | N/A | No equipment rewards |
| Issues | None | Part of 3-quest repeatable fame cycle with It Sets My Heart Aflutter and A Shot in the Dark |

### 3. A Shot in the Dark (Fame Cycle 3/3)
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/A_Shot_in_the_Dark.lua` | Converted |
| Accept | WORKS | First time: talk Pudith, option==1. Repeat: requires all 3 complete + tracker==2 |
| Progress | WORKS | Trade Umbril Ooze to Pudith |
| Completion | WORKS | confirmTrade, resets tracker to 0 |
| Rewards | WORKS | 6 fame, 200 bayld, 500 exp. Repeatable |
| Equipment | N/A | No equipment rewards |
| Issues | None | Completes the fame cycle loop |

### 4. A Stone's Throw Away
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/A_Stones_Throw_Away.lua` | Converted |
| Accept | WORKS | Talk Apolliane in Morimar Basalt Fields |
| Progress | BLOCKED | TODO in code: "Morimar Basalt Fields HELM is not implemented." Requires Prog==1 which is set by mining, but mining points may not work. Trade Marble Nugget requires Prog==1 |
| Completion | PARTIAL | If Prog is manually set to 1, trade works. Gives Demolishing KI + 500 bayld |
| Rewards | WORKS (if reachable) | 500 bayld, Demolishing KI |
| Equipment | N/A | No equipment rewards |
| Issues | **BUG: Mining (HELM) not implemented in Morimar Basalt Fields.** Player cannot naturally set Prog to 1. Quest is effectively stuck after accept. Workaround: GM sets quest var manually |

### 5. Breaking the Ice
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Breaking_the_Ice.lua` | Converted |
| Accept | WORKS | Talk Traiffeaux in Kamihr Drifts, option==2 |
| Progress | WORKS | Trade 3x Rabbit Hide + 1x Raaz Tusk to Traiffeaux |
| Completion | WORKS | Gives Fuzzy Earmuffs KI + Fragmenting KI + 500 bayld |
| Rewards | WORKS | 500 bayld, Fragmenting + Fuzzy Earmuffs KIs |
| Equipment | N/A | No equipment rewards |
| Issues | Code comment: "This event may cause Windower to hang part-way through" -- potential client-side issue with event 26 |

### 6. Flavors of Our Lives
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Flavors_of_Our_Lives.lua` | Converted |
| Accept | WORKS | Talk Berghent in Western Adoulin. Handles refuse/re-offer flow |
| Progress | WORKS | Multi-step: Masad (Mummers') > Dewalt (Couriers') > Chalvava (Rala Waterways) > Harvest Blightberry in Yahse |
| Completion | PARTIAL | Returns to Berghent for reward. **TODO in code (line 198): "remove blightberry" -- Blightberry KI is NOT removed on completion** |
| Rewards | WORKS | 300 bayld, 500 exp, title Potation Pathfinder. Matches bg-wiki |
| Equipment | N/A | No equipment rewards |
| Issues | **BUG: Blightberry KI not removed on quest completion (line 198 TODO).** Also advances SOA mission Budding Prospects with timer -- this is intentional cross-quest interaction. Harvesting_Point HELM interaction may have issues if HELM not fully working |

### 7. Hide and Go Peak
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Hide_and_Go_Peak.lua` | Converted |
| Accept | WORKS | Talk Toppled_Tree in Marjami Ravine |
| Progress | WORKS | Get Large Strip of Velkk Hide KI from Velkk_Cache > return to Toppled_Tree (deletes hide KI, Prog=2) > interact with Scalable_Area_2 |
| Completion | WORKS | Gives Velkk Gloves KI + Climbing KI + 500 bayld |
| Rewards | WORKS | 500 bayld, Climbing KI, Velkk Gloves KI |
| Equipment | N/A | Key items only |
| Issues | None. Requires passing Colonization Reives with Demolishing skill (from A Stone's Throw Away which is BLOCKED) |

### 8. Hunger Strikes
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Hunger_Strikes.lua` | Converted |
| Accept | WORKS | Talk Westerly_Breeze in Western Adoulin |
| Progress | WORKS | Trade Bowl of Wisdom Soup. Also accepts wrong food items (consumes them with wrong-item event) |
| Completion | WORKS | confirmTrade, sets The_Starving timer for next day |
| Rewards | WORKS | 500 bayld, 1000 exp, Adoulin fame |
| Equipment | N/A | No equipment rewards |
| Issues | **Style: NPC key at section level without zone wrapper (line 43).** Works because Westerly_Breeze is unique, but inconsistent with other scripts. Not a functional bug |

### 9. I'm on a Boat
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Im_on_a_Boat.lua` | Converted |
| Accept | WORKS | Talk Choubollet in Foret de Hennetiel |
| Progress | WORKS | Trade 3x Dhalmel Leather + 1x Umbril Ooze + 1x Twitherym Scale > get Watercraft KI > practice at Castoff Points 4 and 5 > return when Prog==2 |
| Completion | WORKS | Deletes Watercraft KI, gives Watercrafting KI + 500 bayld |
| Rewards | WORKS | 500 bayld, Watercrafting KI. Also grants Toxin Tussler title from castoff practice |
| Equipment | N/A | No equipment rewards |
| Issues | None. Multi-step with practice mechanic. Well implemented |

### 10. It Sets My Heart Aflutter (Fame Cycle 1/3)
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/It_Sets_My_Heart_Aflutter.lua` | Converted |
| Accept | WORKS | Requires Pioneer's Badge KI. Talk Saldinor in Rala Waterways. Repeat: requires all 3 complete + tracker==0 |
| Progress | WORKS | Trade 2x Twitherym Wing to Saldinor |
| Completion | WORKS | confirmTrade, sets tracker to 1 |
| Rewards | WORKS | 6 fame, 200 bayld, 500 exp. First of repeatable fame cycle |
| Equipment | N/A | No equipment rewards |
| Issues | None |

### 11. Lerene's Lament
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Lerenes_Lament.lua` | Converted |
| Accept | WORKS | Talk Lerene in Outer Ra'Kaznar, option==2 |
| Progress | WORKS | Trade 2x Ancestral Cloth to Lerene |
| Completion | WORKS | Gives Lerene's Paten KI + Pulverizing KI + 500 bayld |
| Rewards | WORKS | 500 bayld, Pulverizing + Lerene's Paten KIs |
| Equipment | N/A | Key items only |
| Issues | None |

### 12. The Longest Way Round (Eastern Patrol)
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/The_Longest_Way_Round.lua` | Converted |
| Accept | WORKS | Requires SOA >= LIFE_ON_THE_FRONTIER. Talk Vastran, get Eastern Adoulin Patrol Route KI |
| Progress | WORKS | Visit 7 NPCs in order (Fostaig through Ndah_Tolohjin), sequential Prog 0-6 |
| Completion | WORKS | Return to Vastran when Prog==7, deletes KI |
| Rewards | WORKS | 500 bayld, 1000 exp, Adoulin fame. Matches bg-wiki |
| Equipment | N/A | No equipment rewards |
| Issues | None. Mirror of A Certain Substitute Patrolman for Eastern Adoulin |

### 13. The Starving
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/The_Starving.lua` | Converted |
| Accept | WORKS | Requires Timer <= VanadielUniqueDay (set by Hunger Strikes completion). Talk Westerly_Breeze |
| Progress | WORKS | Trade Goblin Drink. Handles wrong drinks (consumes) and wrong items (rejects) |
| Completion | WORKS | Sets up Always More Quoth the Ravenous (mustZone + timer) |
| Rewards | WORKS | 500 bayld, 1000 exp, Adoulin fame |
| Equipment | N/A | No equipment rewards |
| Issues | **Style: Same zone-wrapper omission as Hunger Strikes (line 43).** Functional but inconsistent |

### 14. Transporting
| Aspect | Status | Notes |
|---|---|---|
| Script | `scripts/quests/adoulin/Transporting.lua` | Converted |
| Accept | WORKS | Requires Adoulin fame >= 2. Talk Vaulois, get Misdelivered Parcel KI |
| Progress | WORKS | Talk Kongramm (Prog 0>1) > interact qm_sluice_gate_6 in Rala Waterways (Prog 1>2, deletes parcel KI) > return to Vaulois |
| Completion | WORKS | 300 bayld, 1000 exp, Adoulin fame |
| Rewards | WORKS | Matches bg-wiki |
| Equipment | N/A | No equipment rewards |
| Issues | None. Multi-zone quest, clean implementation |

## NPC-Based Quest Implementations (Not Converted)

These quests are implemented directly in NPC entity scripts rather than using the InteractionFramework Quest:new() pattern.

| Quest | NPC Script(s) | Status | Notes |
|---|---|---|---|
| Dances with Luopans (GEO Unlock) | `zones/Western_Adoulin/npcs/Sylvie.lua`, Ergon_Locus NPCs (3 zones) | WORKS | Full implementation: accept, soil KI from Ergon Locus, trade Petrified Log, charge Luopan, unlock GEO. Includes Matre Bell repurchase (300k gil / 150k bayld) |
| Children of the Rune (RUN Unlock) | `zones/Eastern_Adoulin/npcs/Octavien.lua`, Yahse_Wildflower NPC | WORKS | Full implementation: accept, get wildflower petal, rune enhancement minigame (HP/MP drain), Sowilo Claymore + unlock RUN. Handles full-inventory edge case |
| Always More Quoth the Ravenous | `zones/Western_Adoulin/npcs/Westerly_Breeze.lua` | WORKS | NPC-script based. Requires fame 3 + Starving chain. Trade Cursed Beverage to complete. 1500 exp, 1000 bayld, 30 fame |
| A Pioneer's Best Imaginary Friend | `zones/Western_Adoulin/npcs/Ruth.lua` + others | PARTIAL | Ruth NPC grants Ionis buff as quest progress. Start/complete logic likely in other NPCs |
| The Old Man and the Harpoon | `zones/Western_Adoulin/npcs/Shipilolo.lua` + others | PARTIAL | Shipilolo handles Broken Harpoon > Extravagant Harpoon exchange. Other steps in other NPC scripts |
| Fertile Ground | `zones/Western_Adoulin/npcs/Shipilolo.lua` + others | PARTIAL | Shipilolo gives Fertilizer X KI. Other steps in other NPC scripts |
| Wayward Waypoints | `zones/Western_Adoulin/npcs/Shipilolo.lua` + others | PARTIAL | Shipilolo gives Waypoint Recalibration Kit KI |
| Exotic Delicacies | `zones/Western_Adoulin/npcs/Flapano.lua` + others | PARTIAL | NPC-based, likely functional |
| Scaredy-Cats | `zones/Western_Adoulin/npcs/Barenngo.lua` | PARTIAL | NPC-based |
| Raptor Rapture | `zones/Western_Adoulin/npcs/Bilp.lua` | PARTIAL | NPC-based |
| Don't Ever Leaf Me | `zones/Western_Adoulin/npcs/Pagnelle.lua` | PARTIAL | NPC-based |
| Keep Your Bloomers On, Erisa | `zones/Western_Adoulin/npcs/Gontrain.lua` | PARTIAL | NPC-based |
| Open the Floodgates | `zones/Western_Adoulin/npcs/Dewalt.lua` | PARTIAL | NPC-based |
| No Laughing Matter | `zones/Western_Adoulin/npcs/Eamonn.lua` | PARTIAL | NPC-based |
| Order Up | `zones/Western_Adoulin/npcs/Mastan.lua` | PARTIAL | NPC-based |
| One Good Turn | `zones/Western_Adoulin/npcs/Clautaire.lua` | PARTIAL | NPC-based |
| F.A.I.L.ure Is Not an Option | `zones/Western_Adoulin/npcs/Oka_Qhantari.lua` | PARTIAL | NPC-based |

## Critical Missing Quests

### GEO Artifact Quest Line (6 missing of 7)
| Quest | ID | Status | Impact |
|---|---|---|---|
| Dances with Luopans (Unlock) | 118 | WORKS (NPC) | GEO job unlock functional |
| Elementary, My Dear Sylvie | 35 | MISSING | GEO AF body piece |
| For Whom the Bell Tolls | 36 | MISSING | GEO AF legs piece |
| The Bloodline of Zacariah | 37 | MISSING | GEO AF hands piece |
| The Communion | 38 | MISSING | GEO AF feet piece |
| Geomancerrific | 134 | MISSING | GEO AF head piece |
| Treasures of the Earth | 142 | MISSING | GEO Relic weapon quest |
| Saved by the Bell | 131 | MISSING | GEO AF upgrade quest |

### RUN Artifact Quest Line (7 missing of 8)
| Quest | ID | Status | Impact |
|---|---|---|---|
| Children of the Rune (Unlock) | 119 | WORKS (NPC) | RUN job unlock functional |
| Endeavoring to Awaken | 22 | MISSING | RUN AF body piece |
| Forging New Bonds | 23 | MISSING | RUN AF legs piece |
| Legacies Lost and Found | 24 | MISSING | RUN AF hands piece |
| Destiny's Device | 25 | MISSING | RUN AF feet piece |
| Rune Fencing the Night Away | 135 | MISSING | RUN AF head piece |
| Epiphany | 143 | MISSING | RUN Relic weapon quest |
| Quiescence | 132 | MISSING | RUN AF upgrade quest |

### Coalition Assignments (0 of 77 implemented)
Coalition assignments have 77 quest IDs defined in `scripts/globals/quests.lua` (lines 1116-1195) covering Procure, Clear, Provide, Deliver, Support, Gather, Survey, Analyze, Preserve, and Patrol categories across all Ulbuka zones. **Zero** coalition assignment scripts exist. This is the largest missing system in Adoulin content.

### Other Notable Missing Quests
| Quest | Type | Impact |
|---|---|---|
| Grind to Sawdust | Ulbuka (skill) | Logging survival skill |
| Western Waypoints Ho! | Waypoint | Western Adoulin waypoint activation |
| Wes...Eastern Waypoints Ho! | Waypoint | Cross-city waypoint |
| The Whole Place Is Abuzz | Ulbuka | Field content |
| Orobon Appetit | Ulbuka | Field content |
| Unsullied Lands | Ulbuka | Field content |
| Megalomaniac | Eastern Adoulin | Story content |
| Cafeteria | Eastern Adoulin | Story content |
| Vegetable Vegetable series (4) | Western Adoulin | Mog Garden related chain |
| A Thirst series (4) | Eastern Adoulin | Repeatable chain |
| Flowers for Svenja | Western Adoulin | Story quest |
| Thorn in the Side | Eastern Adoulin | Story quest |
| Do Not Go Into the Light | Western Adoulin | Story quest |
| Weatherspoon series (2) | Western/Eastern | Story chain |
| Curious Case of Melvien | Eastern Adoulin | Story quest |
| All the Way to the Bank | Western Adoulin | Economy quest (Westerly_Breeze NPC has partial gruel-trade code) |

### Mog Garden
The Mog Garden zone exists (`scripts/zones/Mog_Garden/`) with minimal NPCs:
- Ephemeral_Moogle_Garden.lua
- Green_Thumb_Moogle.lua
- Mog_Dinghy.lua
- Porter_Moogle.lua

The full Mog Garden system (gardening, fishing, harvesting, monster rearing, furious Frank) is not implemented. The Vegetable Vegetable quest series (4 quests) depends on Mog Garden functionality.

## Bugs Found

| Bug | File | Line | Severity | Fix Difficulty |
|---|---|---|---|---|
| Blightberry KI not removed on completion | Flavors_of_Our_Lives.lua | 198 | Low | Easy -- add `player:delKeyItem(xi.ki.BLIGHTBERRY)` |
| HELM/Mining not implemented in Morimar | A_Stones_Throw_Away.lua | 49 | High | Hard -- requires full HELM system for Adoulin zones |
| Zone wrapper omission | Hunger_Strikes.lua | 43 | Cosmetic | Easy -- wrap in `[xi.zone.WESTERN_ADOULIN]` |
| Zone wrapper omission | The_Starving.lua | 43 | Cosmetic | Easy -- wrap in `[xi.zone.WESTERN_ADOULIN]` |

## Blockers
- **HELM system not implemented for Adoulin zones** -- blocks A Stone's Throw Away (mining) and potentially Flavors of Our Lives (harvesting, though that has a workaround via direct HELM call). The Demolishing KI from A Stone's Throw Away is required for Colonization Reives, which block Hide and Go Peak's Climbing KI
- **No coalition assignment system** -- 77 defined quest IDs with zero implementation. This is the core repeatable content loop for Adoulin
- **No GEO/RUN AF armor** -- job unlock works but all 13 AF armor quests are missing. Players can level GEO/RUN but cannot obtain their artifact armor
- **Mog Garden not implemented** -- blocks Vegetable Vegetable quest series and related content

## Fix Difficulty
- Blightberry KI bug: **Easy** (one line)
- Zone wrapper style fixes: **Easy** (restructure tables)
- HELM for Adoulin: **Hard** (system-level)
- GEO/RUN AF quests: **Hard** (13 multi-step quests with NMs, cutscenes, AF armor items)
- Coalition assignments: **Massive** (77 quest scripts + coalition rank system + imprimatur system)
- Mog Garden: **Massive** (entire zone system)
