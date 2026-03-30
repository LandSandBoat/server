# RUN & GEO Artifact Armor Quest Chain Scope

Date: 2026-03-30

## Key Finding: SoA Jobs Use a Different AF System

Rune Fencer and Geomancer do NOT have traditional AF armor (coffer-based like original 15 jobs).
Instead, they have two separate armor tracks:

1. **Artifact Armor (AF)** - iL109 "Runeist" / "Geomancy" sets, obtained via quest chains + NPC commissions
2. **Relic Armor** - iL109 "Futhark" / "Bagua" sets, obtained via a separate commission system (Yestin-Ovestin / Wescolina) after collecting a key item from Celennia Memorial Library while wearing all 5 AF pieces

This document scopes **Track 1 (AF)** for both jobs. Track 2 (Relic) is a follow-on that requires Track 1 to be complete first.

---

## RUN AF: Runeist Armor Set

### Quest Chain (5 quests, sequential)

| # | Quest | NPC | Zone | Reward | Level |
|---|-------|-----|------|--------|-------|
| 1 | Children of the Rune | Octavien | Eastern Adoulin (I-8) | Sowilo Claymore + RUN job unlock | 30+ |
| 2 | Endeavoring to Awaken | Octavien | Eastern Adoulin (I-8) | 3000 Bayld, level cap to 75 | 66+ |
| 3 | Forging New Bonds | Octavien | Eastern Adoulin (I-8) | Beorc Sword + unlocks Jerra Ndala commissions | 90+ |
| 4 | Legacies Lost and Found | Octavien | Eastern Adoulin (I-8) | Runeist Trousers + Bayld | Post-Forging |
| 5 | Destiny's Device | Octavien | Eastern Adoulin (I-8) | Runeist Coat | Post-Legacies |

### Commission Pieces (via Jerra Ndala at Rala Waterways E-10, unlocked after quest 3)

| Piece | Slot | Bayld | Materials |
|-------|------|-------|-----------|
| Runeist Bandeau | Head | 12,500 | Corroded Ore x2, Rhodium Ingot, Vermilion Lacquer, Mithran Tomato |
| Runeist Mitons | Hands | 10,000 | Redoubtable Silk Thread, Runeweave, Rhodium Ingot, Gold Thread, Mithran Tomato |
| Runeist Bottes | Feet | 10,000 | Redoubtable Silk Thread, Runeweave, Uragnite Shell, Tiger Leather, Mithran Tomato |

**Summary:** 3 pieces via commission, 2 via quests (Trousers from quest 4, Coat from quest 5).

### Detailed Quest Steps

#### Quest 1: Children of the Rune (IMPLEMENTED)
- Talk to Octavien -> get sent to Yahse Hunting Grounds (K-7) for Yahse Wildflower Petal
- Return to Octavien, do rune enhancement attempts
- Reward: Sowilo Claymore + RUN unlock
- **Status: FULLY IMPLEMENTED** (Octavien.lua + Yahse_Wildflower.lua)

#### Quest 2: Endeavoring to Awaken (NOT IMPLEMENTED)
- Talk to Octavien -> receive Ephemeral Endeavor KI
- Travel to Rala Waterways (M-6), speak to Yeggha Dolashi, enter Rala Waterways (U)
- **NM Fight:** Zurko-Bazurko (~1100 HP) then Sverdheid (~4000 HP) in instanced area
- Subjob is locked during fight; trusts allowed with Rhapsody in Umber
- Return to Octavien
- **Dependencies:** Rala Waterways (U) instance system, Yeggha Dolashi NPC handler, 2 NM spawns

#### Quest 3: Forging New Bonds (NOT IMPLEMENTED)
- Talk to Octavien -> optionally talk to Gaddiux (Inventors' Coalition, Western Adoulin J-10)
- Check Inconspicuous Barrel (Western Adoulin I-4) -> Yestin-Ovestin requests Rune Saber + Frost-encrusted Flame Gem
- Visit Jerra Ndala at Rala Waterways (E-10) -> trade Sowilo Claymore OR Elixir for Rune Saber KI
- Get Flask of Fruiserum KI -> trade Ifritite to Molten Rift in Moh Gates (K-8)
- **NM Fight:** Staumarth at Molten Rift
- Return to Inconspicuous Barrel, wait 1 game day
- Talk to Octavien
- **Dependencies:** Gaddiux NPC, Inconspicuous Barrel handler, Jerra Ndala NPC (Rala Waterways), Molten Rift interaction point (Moh Gates), Staumarth NM spawn

#### Quest 4: Legacies Lost and Found (NOT IMPLEMENTED)
- Talk to Octavien -> receive Letter from Octavien KI
- Travel to Port Windurst (E-7) -> talk to Ohruru in Orastery
- Use Ignis rune, talk to Ohruru twice
- Visit 3+ of 8 Strange Apparatuses across world, use specific runes 3x each, examine Hazy Runes for stone KIs
- Return to Ohruru, answer trivia questions
- Receive Secrets of Runic Enhancement KI
- Return to Octavien -> Inconspicuous Barrel -> wait 1 game day
- **Dependencies:** Ohruru handler expansion (already has script for other quests), Strange Apparatus interactions (global system exists at scripts/globals/strangeapparatus.lua), Inconspicuous Barrel handler
- **No NM fights**

#### Quest 5: Destiny's Device (NOT IMPLEMENTED)
- Talk to Octavien -> receive Runic Kinegraver KI
- Talk to Gaddiux (Inventors' Coalition)
- Collect Yahse Wildflower Petal at Yahse Hunting Grounds (K-7)
- Travel to Marjami Ravine (I-8) -> use Ignis 3x at ??? near waterfall -> get Vial of Vivid Rainbow Extract
- Talk to Gaddiux again -> return to Octavien
- Travel to Foret de Hennetiel (J-11) -> examine Bloodstained Glove for cutscene
- **NM Fight:** Insidio (Orobon) - has Mayhem Lantern (AoE charm + phys dmg reduction)
- Return to Octavien
- **Dependencies:** Gaddiux NPC, ??? interaction point in Marjami Ravine, Bloodstained Glove in Foret de Hennetiel, Insidio NM spawn + AI

### RUN AF Item Mods Status

All 5 Runeist pieces have mods in item_mods.sql:
- Runeist Bandeau (27787): **NO MODS FOUND** - needs adding
- Runeist Coat (27927): has mods (DEF 104, HP 108, etc.)
- Runeist Mitons (28067): **NO MODS FOUND** - needs adding
- Runeist Trousers (28207): has mods (DEF 91, HP 22, etc.)
- Runeist Bottes (28347): has mods (DEF 61, HP 36, etc.)

**Action needed:** Add mods for Runeist Bandeau (27787) and Runeist Mitons (28067).

---

## GEO AF: Geomancy Attire Set

### Quest Chain (5 quests, sequential)

| # | Quest | NPC | Zone | Reward | Level |
|---|-------|-----|------|--------|-------|
| 1 | Dances with Luopans | Sylvie | Western Adoulin (I-5) | Indi-Poison scroll + Matre Bell + GEO job unlock | 30+ |
| 2 | Elementary, My Dear Sylvie | Sylvie | Western Adoulin (I-5) | 3000 Bayld, level cap to 75 | 66+ |
| 3 | For Whom the Bell Tolls | Sylvie | Western Adoulin (I-5) | Filiae Bell + Dowser's Wand + unlocks Wescolina commissions | 90+ |
| 4 | The Bloodline of Zacariah | Sylvie | Western Adoulin (I-5) | Geomancy Mitaines | 90+ |
| 5 | The Communion | Sylvie | Western Adoulin (I-5) | Geomancy Pants | 90+ |

### Commission Pieces (via Wescolina at Western Adoulin H-7, unlocked after quest 3 or 4)

| Piece | Slot | Bayld | Materials |
|-------|------|-------|-----------|
| Geomancy Galero | Head | 12,500 | Atramenterrane, Urunday Lumber, Akaso Thread, Sekishitsu |
| Geomancy Tunic | Body | 15,000 | Lavarion, Silk Cloth, Akaso Cloth, Akaso Thread |
| Geomancy Sandals | Feet | 10,000 | Cyclone Cotton, Sheep Leather, Gold Ingot, Akaso Thread |

**Summary:** 3 pieces via commission, 2 via quests (Mitaines from quest 4, Pants from quest 5).

### Detailed Quest Steps

#### Quest 1: Dances with Luopans (IMPLEMENTED)
- Talk to Sylvie -> go to nation's crag for Fistful of Homeland Soil
- Trade Petrified Log + soil to Sylvie -> get Luopan KI
- Charge Luopan at Ergon Locus in Ceizak/Yahse
- Return to Sylvie
- **Status: FULLY IMPLEMENTED** (Sylvie.lua handles full chain)

#### Quest 2: Elementary, My Dear Sylvie (NOT IMPLEMENTED)
- Talk to Sylvie -> go to Morimar Basalt Fields Bivouac #1 (J-8)
- Talk to Dabnorrin -> get Vessel of Summoning KI
- Enter unmapped area via entrance at J-6 -> click Primordial Convergence
- **NM Fight:** Burgeoning Flames (Fire Elemental, ~3800 HP, solo fight, subjob locked)
- Click Primordial Convergence again
- Return to Sylvie
- **Dependencies:** Dabnorrin NPC (Morimar Basalt Fields), Primordial Convergence interaction, Burgeoning Flames NM, instance/solo fight system

#### Quest 3: For Whom the Bell Tolls (NOT IMPLEMENTED)
- Talk to Sylvie -> talk to Nhili Uvolep (Eastern Adoulin I-7)
- Go to Morimar Basalt Fields (K-10) Frontier Station -> talk to Vestavius
- Travel to Morimar Basalt Fields (J-6) -> examine Ergon Locus ??? for Silver Luopan KI + cutscene
- Examine again -> **NM Fight:** Deranged Ameretat (~75k HP, immune to most enfeebles)
- Examine again for cutscene -> return to Sylvie
- **Dependencies:** Nhili Uvolep handler expansion, Vestavius handler expansion, Ergon Locus ??? interaction, Deranged Ameretat NM

#### Quest 4: The Bloodline of Zacariah (NOT IMPLEMENTED)
- Talk to Sylvie -> obtain and trade 3x Acuex Ore to Sylvie
- Travel to Cirdas Caverns (M-8/9) -> examine Overgrown Grave
- Talk to Nhili Uvolep (Eastern Adoulin I-7)
- **Dependencies:** Sylvie handler expansion (trade handler), Overgrown Grave interaction (Cirdas Caverns), Nhili Uvolep handler expansion
- **No NM fights** (may need to clear a Colonization Reive to reach objective)

#### Quest 5: The Communion (NOT IMPLEMENTED)
- Talk to Sylvie -> talk to Nhili Uvolep for Lhaiso Neftereh's Bell KI
- Travel to Cirdas Caverns (M-8/9) -> examine Overgrown Grave for cutscene
- Examine again -> **NM Fight:** Ancestral Rage (~70k HP, high phys dmg reduction, Sleepga 2, AoE Drain/Aspir)
- Examine again for cutscene -> return to Sylvie
- **Dependencies:** Overgrown Grave NM spawn system, Ancestral Rage NM + AI

### GEO AF Item Mods Status

All 5 Geomancy pieces have mods in item_mods.sql:
- Geomancy Galero (27786): has mods (DEF 70, HP 17, Cardinal Chant Bonus, etc.)
- Geomancy Tunic (27926): has mods (DEF 91, HP 25, etc.)
- Geomancy Mitaines (28066): has mods (DEF 61, HP 35, Geomancy Skill +15, etc.)
- Geomancy Pants (28206): has mods (DEF 78, HP 55, etc.)
- Geomancy Sandals (28346): has mods (DEF 61 - needs verification, seen in grep)

**GEO mods appear complete.** Verify Geomancy Sandals (28346) has full mod set.

---

## Existing Codebase Infrastructure

### What Already Exists

| Component | Status | Notes |
|-----------|--------|-------|
| Quest IDs in quests.lua | YES | All 10 quests have IDs (CHILDREN_OF_THE_RUNE=119, ENDEAVORING_TO_AWAKEN=22, FORGING_NEW_BONDS=23, LEGACIES_LOST_AND_FOUND=24, DANCES_WITH_LUOPANS=118, ELEMENTARY_MY_DEAR_SYLVIE=35, FOR_WHOM_THE_BELL_TOLLS=36, THE_BLOODLINE_OF_ZACARIAH=37, THE_COMMUNION=38) |
| Key Items in key_item.lua | YES | All relevant KIs exist (EPHEMERAL_ENDEAVOR, ENLIGHTENED_ENDEAVOR, RUNE_SABER, FROST_ENCRUSTED_FLAME_GEM, RUNIC_KINEGRAVER, VESSEL_OF_SUMMONING, SILVER_LUOPAN, LHAISO_NEFTEREHS_BELL, etc.) |
| Item enums in item.lua | YES | All armor pieces + quest reward items defined (RUNEIST_BANDEAU=27787 through RUNEIST_BOTTES=28347, GEOMANCY_GALERO=27786 through GEOMANCY_SANDALS=28346, BEORC_SWORD=20776, etc.) |
| Item mods in item_mods.sql | PARTIAL | RUN: missing Bandeau (27787) and Mitons (28067). GEO: appears complete. |
| Octavien NPC (RUN quest giver) | PARTIAL | Only handles Children of the Rune (quest 1). Needs expansion for quests 2-5. |
| Sylvie NPC (GEO quest giver) | PARTIAL | Only handles Dances with Luopans (quest 1) + Matre Bell replacement. Needs expansion for quests 2-5. |
| Yahse Wildflower NPC | YES | Handles KI for Children of the Rune. |
| Ohruru NPC (Port Windurst) | EXISTS | Has script but only for Catch It If You Can + Wonder Wands. Needs RUN quest 4 handler. |
| Nhili Uvolep (Eastern Adoulin) | STUB | Only in DefaultActions.lua with event 545. Needs full NPC script for GEO quests 3-5. |
| Yeggha Dolashi (Rala Waterways) | STUB | Only in DefaultActions.lua with event 319. Needs handler for RUN quest 2. |
| Vestavius (Morimar Basalt Fields) | STUB | Only in DefaultActions.lua with event 502. Needs handler for GEO quest 3. |
| Gaddiux (Inventors' Coalition) | NOT FOUND | No script exists. Needs creation for RUN quests 3-5. |
| Jerra Ndala (Rala Waterways) | NOT FOUND | No script exists. Needs creation as commission NPC. |
| Wescolina (Western Adoulin) | NOT FOUND | No script exists. Needs creation as commission NPC. |
| Inconspicuous Barrel (Rala Waterways) | STUB | In DefaultActions.lua as "NOTHING_OUT_OF_ORDINARY". Needs quest handler. |
| Inconspicuous Barrel (Western Adoulin) | NOT FOUND | Not in any scripts. Needs creation for RUN quests 3-4. |
| Hestefa (Celennia Memorial Library) | STUB | In DefaultActions.lua with event 23. Needed for relic armor (Track 2), not AF. |
| Strange Apparatus system | EXISTS | scripts/globals/strangeapparatus.lua exists. May need extension for RUN quest 4 rune interactions. |
| Rala Waterways (U) instance | EXISTS | behind_the_sluices instance exists but is for SoA mission 2.2.2, not RUN quest 2. A separate instance may be needed. |
| SoA Missions | 106 scripts | Extensive SoA mission infrastructure exists. |

### Zone Directories That Exist (but lack quest NPCs/interactions)

- Rala Waterways: has zone but no quest NPCs beyond stubs
- Rala Waterways (U): has instance for SoA mission
- Morimar Basalt Fields: has zone, Vestavius stub, Geomantic Reservoirs
- Cirdas Caverns: has zone with IDs.lua, Zone.lua, and mobs only - no NPCs dir
- Foret de Hennetiel: has zone with basic NPCs
- Moh Gates: has zone but no NPCs dir
- Yahse Hunting Grounds: has Yahse Wildflower + Waypoint + Geomantic Reservoir
- Outer Ra'Kaznar: has zone with DefaultActions stubs (needed for relic, not AF)

---

## Complexity Estimate

### RUN AF (Quests 2-5 + 3 commissions)

| Work Item | Count | Complexity |
|-----------|-------|------------|
| New quest scripts | 4 | High - each has multiple steps, zone transitions, cutscenes |
| NPC scripts to create | 3 | Gaddiux, Jerra Ndala (commission), Inconspicuous Barrel (W. Adoulin) |
| NPC scripts to expand | 2 | Octavien (add quests 2-5), Ohruru (add quest 4 handler) |
| NPC stubs to promote | 2 | Yeggha Dolashi, Inconspicuous Barrel (Rala Waterways) |
| NM mobs to create | 4 | Zurko-Bazurko, Sverdheid (quest 2), Staumarth (quest 3), Insidio (quest 5) |
| Interaction points | 4+ | Molten Rift (Moh Gates), ??? (Marjami Ravine), Bloodstained Glove (Foret), Hazy Runes at Strange Apparatuses |
| Instance/battlefield | 1 | Quest 2 needs instanced fight in Rala Waterways (U) or similar |
| Item mod additions | 2 | Runeist Bandeau (27787), Runeist Mitons (28067) |

### GEO AF (Quests 2-5 + 3 commissions)

| Work Item | Count | Complexity |
|-----------|-------|------------|
| New quest scripts | 4 | High |
| NPC scripts to create | 2 | Wescolina (commission), Dabnorrin (Morimar Basalt Fields) |
| NPC scripts to expand | 1 | Sylvie (add quests 2-5 + trade handlers) |
| NPC stubs to promote | 2 | Nhili Uvolep, Vestavius |
| NM mobs to create | 3 | Burgeoning Flames (quest 2), Deranged Ameretat (quest 3), Ancestral Rage (quest 5) |
| Interaction points | 3 | Primordial Convergence (Morimar), Ergon Locus ??? (Morimar), Overgrown Grave (Cirdas Caverns) |
| Instance/battlefield | 1 | Quest 2 solo fight (subjob locked, instance-like) |
| Cirdas Caverns NPCs dir | 1 | Directory needs creating (currently only has mobs) |

### Shared / Infrastructure Work

| Work Item | Notes |
|-----------|-------|
| Commission NPC framework | Both jobs use a "trade materials + bayld, wait 1 game day" pattern. Could create a shared commission handler. |
| Jumping Rabbit NPC | Replacement NPC at Yahse Hunting Grounds (K-9) for lost AF pieces. Needed for both jobs. |
| Bayld currency checks | Commission trades require bayld + items. Trade handler needs to verify both. |
| Game day wait system | Commissions require waiting 1 game day. Need char var + vana'diel time check. |

---

## Adoulin Infrastructure Dependencies

### Prerequisites

- **Adoulin Fame Level 1**: Required for quest 1 (job unlock) for both jobs. Fame system needs to work.
- **SoA Pack access**: Players need to be able to reach Adoulin zones. Already working (job unlock quests are implemented).
- **No specific SoA mission requirements** for AF quests themselves. The quests only require prior quests in their own chain + level requirements.
- **Colonization Reive**: GEO quest 4 (Bloodline of Zacariah) may require clearing a reive at Cirdas Caverns M-8 to reach the Overgrown Grave. Reive system status unknown.
- **Coalition rank**: NOT required for AF quests. Only relevant for some relic armor prerequisites potentially.

### Zones That Need NPC/Interaction Work

| Zone | What's Needed |
|------|---------------|
| Eastern Adoulin | Nhili Uvolep full NPC script (promote from stub) |
| Western Adoulin | Wescolina NPC, Inconspicuous Barrel NPC |
| Rala Waterways | Jerra Ndala NPC, Inconspicuous Barrel handler, Yeggha Dolashi handler |
| Rala Waterways (U) | New instance for RUN quest 2 fight |
| Morimar Basalt Fields | Dabnorrin NPC, Ergon Locus ???, Primordial Convergence |
| Cirdas Caverns | NPCs directory, Overgrown Grave interaction |
| Moh Gates | Molten Rift interaction + Staumarth NM |
| Foret de Hennetiel | Bloodstained Glove interaction + Insidio NM |
| Marjami Ravine | ??? interaction point near waterfall |
| Port Windurst | Ohruru expansion for RUN quest 4 |
| Yahse Hunting Grounds | Jumping Rabbit NPC (AF replacement) |

---

## Recommended Implementation Order

### Phase 1: Foundation
1. Add missing item mods (Runeist Bandeau, Runeist Mitons)
2. Create commission NPC framework (shared between Jerra Ndala + Wescolina)
3. Create Jumping Rabbit replacement NPC

### Phase 2: GEO AF Chain (simpler, fewer zone dependencies)
1. Elementary, My Dear Sylvie (quest 2) - solo NM fight
2. For Whom the Bell Tolls (quest 3) - NM fight + unlocks commissions
3. Wescolina commission NPC (3 pieces)
4. The Bloodline of Zacariah (quest 4) - no NM fight
5. The Communion (quest 5) - NM fight

### Phase 3: RUN AF Chain (more complex, more zones involved)
1. Endeavoring to Awaken (quest 2) - instanced fight
2. Forging New Bonds (quest 3) - NM fight + unlocks commissions
3. Jerra Ndala commission NPC (3 pieces)
4. Legacies Lost and Found (quest 4) - Strange Apparatus integration
5. Destiny's Device (quest 5) - NM fight with charm mechanic

### Phase 4: Relic Armor Track (requires all AF complete)
- Hestefa (Celennia Memorial Library) handler
- Outer Ra'Kaznar interactions (Meeting Point / Geomantic Fumes)
- Yestin-Ovestin commission (RUN relic) - already has Inconspicuous Barrel stub
- Wescolina expansion for GEO relic commissions

---

## Total Effort Summary

| Category | RUN | GEO | Total |
|----------|-----|-----|-------|
| Quest scripts (new) | 4 | 4 | 8 |
| NPC scripts (new) | 3 | 2 | 5 (+1 shared Jumping Rabbit) |
| NPC scripts (expand) | 2 | 1 | 3 |
| NPC stubs (promote) | 2 | 2 | 4 |
| NM mobs (new) | 4 | 3 | 7 |
| Interaction points | 4+ | 3 | 7+ |
| Instances/battlefields | 1 | 1 | 2 |
| Item mod additions | 2 | 0 | 2 |
| Zones touched | 7 | 5 | 10 (unique) |

**Overall estimate: Medium-Large project.** The quest logic itself is straightforward (talk to NPC, get KI, go to zone, fight NM, return), but the breadth of zones and NPCs involved is significant. The commission system is reusable between both jobs. The NM fights range from trivial (~1100 HP) to challenging (~75k HP with special mechanics).
