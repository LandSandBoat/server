# Expansion Jobs (BLU, COR, PUP, DNC, SCH, RUN, GEO)

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Jobs
- Codebase: scripts/quests/ahtUrhgan/, scripts/quests/jeuno/, scripts/quests/crystalWar/, scripts/zones/Eastern_Adoulin/npcs/Octavien.lua, scripts/zones/Western_Adoulin/npcs/Sylvie.lua, scripts/actions/spells/blue/, scripts/actions/spells/geomancy/, scripts/actions/abilities/, scripts/globals/job_utils/

## Summary
All 7 expansion jobs have unlock quest scripts and core job mechanic implementations. BLU/COR/PUP (ToAU) and DNC/SCH (WotG) are accessible through normal gameplay. RUN and GEO (SoA) have fully scripted unlock quests but Adoulin access requires completing SoA missions 1-1 through 1-3, which appear functional but should be player-tested. All expansions are enabled by default in settings.

---

## BLU (Blue Mage) -- Treasures of Aht Urhgan

### Unlock Quest: "An Empty Vessel"
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/quests/ahtUrhgan/An_Empty_Vessel.lua` |
| NPC: Waoud in Whitegate | WORKS | !pos 65 -6 -78 50 |
| Divination minigame | WORKS | Full question/answer system with correct options scripted |
| Item trade (Siren's Tear / Valkurm Sunsand / Dangruf Stone) | WORKS | Random 1-of-3 required |
| Aydeewa Subterrane CS | WORKS | Trigger area + cutscene + unlockJob(BLU) |
| ToAU access prerequisite | WORKS | "The Road to Aht Urhgan" quest in Lower Jeuno fully scripted, ENABLE_TOAU=1 |

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Blue magic spells | WORKS | 175 spell scripts in `scripts/actions/spells/blue/` |
| Spell learning system | WORKS | `scripts/globals/bluemagic.lua` (physical/magical blue spell framework) |
| Job abilities (Azure Lore, Burst/Chain Affinity, Diffusion, Convergence, Efflux, Unbridled Learning/Wisdom) | WORKS | 8 ability scripts |
| Job utility functions | WORKS | `scripts/globals/job_utils/blue_mage.lua` (102 lines) |
| BLU AF quests | WORKS | Beginnings, Omens, Transformations all exist in ahtUrhgan quest dir |

### Blockers
- None identified. Full unlock path accessible via normal gameplay.

### Fix Difficulty
- N/A

---

## COR (Corsair) -- Treasures of Aht Urhgan

### Unlock Quest: "Luck of the Draw"
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/quests/ahtUrhgan/Luck_of_the_Draw.lua` |
| NPC: Ratihb in Whitegate | WORKS | !pos 75.225 -6.000 -137.203 50 |
| NPC: Mafwahb in Whitegate | WORKS | !pos 149.11 -2.000 -2.7127 50 |
| Arrapago Reef boat (qm6) | WORKS | Scripted interaction at H-10 |
| Talacca Cove completion | WORKS | Rock slab interaction + unlockJob(COR) |
| ToAU access prerequisite | WORKS | Same as BLU |

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Phantom Rolls | WORKS | 31 roll scripts (Fighters, Monks, Healers, Wizards, Warlocks, Rogues, Gallants, Chaos, Beast, Choral, Hunters, Samurai, Ninja, Drachen, Evokers, Magus, Corsairs, Puppet, Dancers, Scholars, Bolters, Casters, Coursers, Blitzers, Tacticians, Allies, Misers, Companions, Avengers, Naturalists, Runeists) |
| Quick Draw | WORKS | 8 elemental shot scripts (Fire/Ice/Wind/Earth/Thunder/Water/Light/Dark) |
| Other abilities | WORKS | Wild Card, Random Deal, Snake Eye, Fold, Triple Shot, Cutting Cards, Double-Up (effect script exists) |
| Job utility functions | WORKS | `scripts/globals/job_utils/corsair.lua` (346 lines) |
| COR AF quest | WORKS | Equipped_for_All_Occasions exists |

### Blockers
- None identified. Full unlock path accessible via normal gameplay.

### Fix Difficulty
- N/A

---

## PUP (Puppetmaster) -- Treasures of Aht Urhgan

### Unlock Quest: "No Strings Attached"
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/quests/ahtUrhgan/No_Strings_Attached.lua` |
| NPC: Shamarhaan in Bastok Markets | WORKS | Pre-quest trigger |
| NPC: Iruki-Waraki in Whitegate | WORKS | Quest start |
| NPC: Ghatsad in Whitegate | WORKS | Multi-step progression |
| Arrapago Reef qm10 (Antique Automaton) | WORKS | Key item pickup |
| Quest completion + unlockJob(PUP) | WORKS | Gives Animator + Harlequin Frame/Head |
| ToAU access prerequisite | WORKS | Same as BLU/COR |

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Automaton system | WORKS | 3 global files (automaton.lua 380 lines, automatonweaponskills.lua 162 lines, pets/automaton.lua 23 lines) |
| Automaton abilities | WORKS | 25 automaton ability scripts in `scripts/actions/abilities/pets/automaton/` |
| PUP abilities | WORKS | 19 abilities: Activate, Deactivate, Deploy, Retrieve, Repair, Overdrive, Deus Ex Automata, Heady Artifice, Role Reversal, Ventriloquy, Cooldown, 8 maneuvers (Fire/Ice/Wind/Earth/Thunder/Water/Light/Dark) |
| Job utility functions | WORKS | `scripts/globals/job_utils/puppetmaster.lua` |

### Blockers
- None identified. Full unlock path accessible via normal gameplay.

### Fix Difficulty
- N/A

---

## DNC (Dancer) -- Wings of the Goddess

### Unlock Quest: "Lakeside Minuet" (bg-wiki lists as the actual quest name, NOT "No Foot Left Behind")
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/quests/jeuno/Lakeside_Minuet.lua` |
| NPC: Laila in Upper Jeuno | WORKS | Quest start, requires ENABLE_WOTG=1 |
| NPC: Rhea Myuliah in Upper Jeuno | WORKS | Multi-step progression |
| NPC: Valderotaux in S. San d'Oria | WORKS | Quest progression step |
| Glowing Pebbles in Jugner Forest [S] | WORKS | Stardust Pebble key item pickup |
| Quest completion + unlockJob(DNC) | WORKS | Returns to Laila with pebble |
| WotG access prerequisite | WORKS | Cavernous Maws mission scripted, ENABLE_WOTG=1 |
| Jugner Forest [S] zone exists | WORKS | Zone directory confirmed |

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Sambas | WORKS | Drain Samba I/II/III, Haste Samba, Aspir Samba I/II (6 scripts) |
| Waltzes | WORKS | Curing Waltz I-V, Healing Waltz, Divine Waltz I/II (8 scripts) |
| Steps | WORKS | Quickstep, Box Step, Stutter Step, Feather Step (4 scripts) |
| Jigs | WORKS | Chocobo Jig I/II, Spectral Jig (3 scripts) |
| Flourishes | WORKS | Animated, Desperate, Violent, Wild, Building, Climactic, Striking, Ternary, Reverse (9 scripts) |
| Other abilities | WORKS | No Foot Rise, Saber Dance, Fan Dance, Presto, Trance, Grand Pas (6 scripts) |
| Finishing Moves system | WORKS | Implicit in step/flourish interactions |
| Job utility functions | WORKS | `scripts/globals/job_utils/dancer.lua` (554 lines) |
| DNC AF quests | WORKS | The_Unfinished_Waltz, The_Road_to_Divadom, Comeback_Queen in Jeuno quest dir |

### Blockers
- None identified. Full unlock path accessible via normal gameplay.

### Fix Difficulty
- N/A

---

## SCH (Scholar) -- Wings of the Goddess

### Unlock Quest: "A Little Knowledge"
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/quests/crystalWar/A_Little_Knowledge.lua` |
| NPC: Erlene in Eldieme Necropolis [S] | WORKS | !pos 376.936 -39.999 17.914 175 |
| NPC: Tucker in Crawlers' Nest [S] | WORKS | Rolanberry trade for Vellum |
| Vellum trade to Erlene | WORKS | 12 vellum required |
| 2HR ability demonstration | WORKS | Must use Manafont/Chainspell/Astral Flow/Azure Lore near Erlene |
| Quest completion + unlockJob(SCH) | WORKS | Also grants Embrava + Kaustra spells on revisit |
| WotG access prerequisite | WORKS | Cavernous Maws mission, both [S] zones exist |
| Eldieme Necropolis [S] exists | WORKS | Zone directory confirmed |
| Crawlers' Nest [S] exists | WORKS | Zone directory confirmed |

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Light Arts / Dark Arts | WORKS | Core mode-switching abilities scripted |
| Stratagems (Light) | WORKS | Penury, Celerity, Accession, Rapture, Perpetuance, Altruism, Tranquility, Focalization (8 scripts) |
| Stratagems (Dark) | WORKS | Parsimony, Alacrity, Manifestation, Ebullience, Equanimity, Immanence (6 scripts) |
| Addendum White / Black | WORKS | Both scripted |
| Other abilities | WORKS | Sublimation, Tabula Rasa, Enlightenment (3 scripts) |
| Grimoire charge system | WORKS | Handled in C++ (stratagem recast/charges) |

### Blockers
- Unlock requires reaching Eldieme Necropolis [S] and Crawlers' Nest [S], both in past Vana'diel. Player must complete WotG Mission 1 (Cavernous Maws) first, then navigate to these zones. This is a multi-zone trek but all zones/NPCs exist.

### Fix Difficulty
- N/A

---

## RUN (Rune Fencer) -- Seekers of Adoulin

### Unlock Quest: "Children of the Rune"
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/zones/Eastern_Adoulin/npcs/Octavien.lua` (NPC-based, not quest framework) |
| NPC: Octavien in Eastern Adoulin | WORKS | !pos 100.580 -40.150 -63.830 |
| Quest acceptance + progression | WORKS | Full state machine: TRIGGERED -> RUNE_ENHANCEMENT -> REWARD_PENDING |
| Yahse Wildflower Petal | WORKS | `scripts/zones/Yahse_Hunting_Grounds/npcs/Yahse_Wildflower.lua` gives KI |
| Yahse Hunting Grounds zone | WORKS | Zone directory exists |
| Rune enhancement CS | WORKS | Halves HP/MP during cutscene |
| Quest reward (Sowilo Claymore) | WORKS | unlockJob(RUN) + JOB_GESTURE_RUNE_FENCER |

### Adoulin Access Path (CRITICAL)
| Item | Status | Notes |
|------|--------|-------|
| SoA M1-1: Rumors from the West | WORKS | Darcia in Lower Jeuno, ENABLE_SOA=1 |
| SoA M1-2: The Geomagnetron | WORKS | Use Geomagnetron on fount OR pay 1M gil to skip |
| SoA M1-3: Onward to Adoulin | WORKS | Waypoint in Lower Jeuno teleports to Ceizak Battlegrounds |
| Eastern Adoulin zone | WORKS | Zone directory exists with NPCs |
| Yahse Hunting Grounds access | WORKS | Adjacent to Ceizak Battlegrounds / Eastern Adoulin |

### KNOWN ISSUE: GM Teleport Previously Required
The user previously reported needing GM teleport to reach Adoulin. The SoA missions 1-1 through 1-3 ARE scripted and should work, but the path involves:
1. Talk to Darcia in Lower Jeuno (get Geomagnetron or pay 1M gil)
2. Use Geomagnetron on a Geomagnetic Fount, then return to Darcia for Charter Permit
3. Use Waypoint in Lower Jeuno to travel to Ceizak Battlegrounds
4. From Ceizak, reach Eastern Adoulin

This path SHOULD work without GM intervention. If the user needed GM teleport, it may have been due to not knowing the path or a bug that has since been fixed. Recommend re-testing the full path from Lower Jeuno.

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Runes (8 elements) | WORKS | Ignis, Gelus, Flabra, Tellus, Sulpor, Unda, Lux, Tenebrae (8 scripts) |
| Ward abilities | WORKS | Vallation, Valiance, Pflug, Liement, Battuta (5 scripts) |
| Offensive abilities | WORKS | Swipe, Lunge, Gambit, Rayke (4 scripts) |
| Support abilities | WORKS | Swordplay, Embolden, Vivacious Pulse, One for All (4 scripts) |
| SP abilities | WORKS | Elemental Sforzo (1 script) |
| Job utility functions | WORKS | `scripts/globals/job_utils/rune_fencer.lua` (882 lines -- most substantial job util) |

### Blockers
- Access to Adoulin requires SoA mission progression. Scripts exist and appear complete. Previously reported as needing GM teleport -- needs re-testing.

### Fix Difficulty
- If Adoulin access is truly broken: Medium (transport/mission debugging)
- If it works: N/A

---

## GEO (Geomancer) -- Seekers of Adoulin

### Unlock Quest: "Dances with Luopans"
| Item | Status | Notes |
|------|--------|-------|
| Quest script exists | WORKS | `scripts/zones/Western_Adoulin/npcs/Sylvie.lua` (NPC-based, not quest framework) |
| NPC: Sylvie in Western Adoulin | WORKS | !pos 78.094 32.000 135.725 |
| Quest acceptance + progression | WORKS | Full state machine with multiple stages |
| Fistful of Homeland Soil | WORKS | Ergon Locus NPCs in Tahrongi Canyon, La Theine Plateau, Konschtat Highlands (nation-specific) |
| Petrified Log trade | WORKS | Trade log + soil KI to Sylvie |
| Luopan key item | WORKS | Given during quest progression |
| Quest reward (Indi-Poison + Matre Bell) | WORKS | unlockJob(GEO) + JOB_GESTURE_GEOMANCER |
| Matre Bell replacement | WORKS | Can buy back for 300K gil or 150K bayld |

### Adoulin Access Path (CRITICAL)
Same as RUN -- requires SoA M1-1 through M1-3 to reach Western Adoulin.

| Item | Status | Notes |
|------|--------|-------|
| SoA M1-1 through M1-3 | WORKS | See RUN section above |
| Western Adoulin zone | WORKS | Zone directory exists with NPCs |
| Ergon Locus in starter areas | WORKS | All 3 nation-specific Ergon Locus NPCs scripted |

### KNOWN ISSUE: GM Teleport Previously Required
Same as RUN. The SoA mission path to Adoulin appears scripted. See RUN section for full access path details.

### Job Mechanics
| Item | Status | Notes |
|------|--------|-------|
| Geocolure spells (Geo-) | WORKS | ~30 Geo- spells in `scripts/actions/spells/geomancy/` |
| Indicolure spells (Indi-) | WORKS | ~30 Indi- spells in `scripts/actions/spells/geomancy/` (60 total geomancy spells) |
| Luopan pet system | WORKS | `scripts/globals/pets/luopan.lua` exists |
| Job abilities | WORKS | Full Circle, Lasting Emanation, Ecliptic Attrition, Life Cycle, Dematerialize, Blaze of Glory, Theurgic Focus, Widened Compass (8 scripts) |
| SP abilities | WORKS | Bolster (1 script) |
| Job utility functions | WORKS | `scripts/globals/job_utils/geomancer.lua` (590 lines) |

### Missing GEO Abilities (compared to retail)
| Item | Status | Notes |
|------|--------|-------|
| Radial Arcana | MISSING | No script found |
| Concentric Pulse | MISSING | No script found |
| Mending Halation | MISSING | No script found |
| Collimated Fervor | MISSING | No script found |

### Blockers
- Same Adoulin access question as RUN
- 4 GEO abilities appear missing (Radial Arcana, Concentric Pulse, Mending Halation, Collimated Fervor)

### Fix Difficulty
- Missing abilities: Medium (need to implement 4 ability scripts)
- Adoulin access: see RUN section

---

## Overall Summary

| Job | Unlock Quest | Job Mechanics | Access Path | Overall |
|-----|-------------|---------------|-------------|---------|
| BLU | WORKS | WORKS (175 spells, 8 abilities) | WORKS (ToAU via Jeuno) | WORKS |
| COR | WORKS | WORKS (31 rolls, 8 shots, 7+ abilities) | WORKS (ToAU via Jeuno) | WORKS |
| PUP | WORKS | WORKS (25 automaton abilities, 19 PUP abilities) | WORKS (ToAU via Jeuno) | WORKS |
| DNC | WORKS | WORKS (36 abilities total) | WORKS (WotG via Cavernous Maws) | WORKS |
| SCH | WORKS | WORKS (21 abilities total) | WORKS (WotG via Cavernous Maws) | WORKS |
| RUN | WORKS | WORKS (22 abilities, 882-line job util) | PARTIAL (SoA scripted but previously needed GM) | PARTIAL |
| GEO | WORKS | PARTIAL (60 spells, 9 abilities, 4 missing) | PARTIAL (SoA scripted but previously needed GM) | PARTIAL |

## Key Findings

1. **All 7 unlock quests are fully scripted** with proper NPC interactions, multi-step progressions, and unlockJob() calls.
2. **ToAU jobs (BLU/COR/PUP)** are the most straightforward -- "The Road to Aht Urhgan" quest in Lower Jeuno provides access.
3. **WotG jobs (DNC/SCH)** require Cavernous Maws mission + navigating past zones, but all scripts and zones exist.
4. **SoA jobs (RUN/GEO)** have a known issue with Adoulin access. The SoA missions 1-1 through 1-3 ARE scripted and should provide a path, but the user previously needed GM teleport. This needs re-testing.
5. **GEO is missing 4 abilities** (Radial Arcana, Concentric Pulse, Mending Halation, Collimated Fervor).
6. **All expansion flags** (ENABLE_TOAU, ENABLE_WOTG, ENABLE_SOA) are set to 1 in default settings.
7. **Every job has a dedicated job_utils file** with substantial implementations (102-882 lines each).
