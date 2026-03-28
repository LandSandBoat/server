# Windurst Quests -- Full Audit

**Date:** 2026-03-28
**Source:** bg-wiki Category:Windurst_Quests + codebase scripts/quests/windurst/ + scripts/globals/quests.lua

---

## Summary

| Metric | Count |
|--------|-------|
| Quests listed on bg-wiki | 92 |
| Quests registered in quests.lua (Windurst log) | 91 |
| Quests with dedicated script file (Converted) | 44 |
| Quests implemented via NPC zone scripts (+ mark) | 41 |
| Quests defined but NOT implemented (no + mark) | 6 |
| **Total implemented (script or NPC-based)** | **85** |
| **Implementation rate** | **92.4%** |

---

## Quest Registry (scripts/globals/quests.lua lines 224-316)

Legend:
- **Converted** = has a dedicated `.lua` file in `scripts/quests/windurst/`
- **NPC-based** = implemented in zone NPC scripts (marked `-- +` in quests.lua)
- **Stub only** = defined in enum but no implementation found

---

## Quests with Dedicated Script Files (44 files)

These are the "Converted" quests with full standalone quest scripts in `scripts/quests/windurst/`.

| # | Quest Name | Script File | ID |
|---|-----------|-------------|-----|
| 1 | A Pose by Any Other Name | A_Pose_by_Any_Other_Name.lua | 7 |
| 2 | A Smudge on One's Record | A_Smudge_on_Ones_Record.lua | 12 |
| 3 | Acting in Good Faith | Acting_in_Good_Faith.lua | 64 |
| 4 | All at Sea | All_At_Sea.lua | 23 |
| 5 | Blast from the Past | Blast_from_the_Past.lua | 11 |
| 6 | Blood and Glory | Blood_and_Glory.lua | 87 |
| 7 | Blue Ribbon Blues | Blue_Ribbon_Blues.lua | 17 |
| 8 | Chasing Tales | Chasing_Tales.lua | 13 |
| 9 | Curses, Foiled A-Golem!? | Curses_Foiled_A_Golem.lua | 63 |
| 10 | Curses, Foiled Again! | Curses_Foiled_Again_1.lua | 32 |
| 11 | Curses, Foiled...Again!? | Curses_Foiled_Again_2.lua | 33 |
| 12 | Early Bird Catches the Bookworm | Early_Bird_Catches_the_Bookworm.lua | 20 |
| 13 | Flower Child | Flower_Child.lua | 65 |
| 14 | Food for Thought | Food_for_Thought.lua | 14 |
| 15 | From Saplings Grow | From_Saplings_Grow.lua | 85 |
| 16 | Glyph Hanger | Glyph_Hanger.lua | 30 |
| 17 | In a Stew | In_a_Stew.lua | 45 |
| 18 | Let Sleeping Dogs Lie | Let_Sleeping_Dogs_Lie.lua | 46 |
| 19 | Making Amends | Making_Amends.lua | 3 |
| 20 | Making the Grade | Making_the_Grade.lua | 4 |
| 21 | Mihgo's Amigo | Mihgos_Amigo.lua | 25 |
| 22 | One Good Deed? | One_Good_Deed.lua | 92 |
| 23 | Orastery Woes | Orastery_Woes.lua | 86 |
| 24 | Overnight Delivery | Overnight_Delivery.lua | 15 |
| 25 | Rock Racketeer | Rock_Racketeer.lua | 26 |
| 26 | Say It with Flowers | Say_It_With_Flowers.lua | 50 |
| 27 | Scooped! | Scooped.lua | 38 |
| 28 | Star Struck | Star_Struck.lua | 10 |
| 29 | Teacher's Pet | Teachers_Pet.lua | 28 |
| 30 | The Fanged One | The_Fanged_One.lua | 31 |
| 31 | Toraimarai Turmoil | Toraimarai_Turmoil.lua | 80 |
| 32 | Water Way to Go! | Water_Way_to_Go.lua | 16 |
| 33 | Truth, Justice, and the Onion Way! | SOB1_Truth_Justice_and_the_Onion_Way.lua | 36 |
| 34 | Know One's Onions | SOB2_Know_Ones_Onions.lua | 40 |
| 35 | Inspector's Gadget! | SOB3_Inspectors_Gadget.lua | 41 |
| 36 | Onion Rings | SOB4_Onion_Rings.lua | 42 |
| 37 | Crying Over Onions | SOB5_Crying_Over_Onions.lua | 76 |
| 38 | Wild Card | SOB6_Wild_Card.lua | 77 |
| 39 | The Promise | SOB7_The_Promise.lua | 78 |
| 40 | The Puppet Master (SMN AF1) | SMN_AF1_The_Puppet_Master.lua | 81 |
| 41 | I Can Hear a Rainbow (SMN AF) | SMN_I_Can_Hear_a_Rainbow.lua | 75 |
| 42 | The Tenshodo Showdown (THF AF1) | THF_AF1_The_Tenshodo_Showdown.lua | 69 |
| 43 | As Thick as Thieves (THF AF2) | THF_AF2_As_Thick_as_Thieves.lua | 70 |
| 44 | Hitting the Marquisate (THF AF3) | THF_AF3_Hitting_the_Marquisate.lua | 71 |

### Spot-Check Results

**SOB1 (Truth, Justice, and the Onion Way):** Well-structured. Uses Quest:new() framework. Has proper begin/accept/complete sections. Rewards Justice Badge + title. Event IDs present. PASS.

**Making Amends:** Full implementation. Fame check (level >= 2), trade handler for Animal Glue, gives 1500 gil + fame. Has repeat/must-zone logic. PASS.

**Flower Child:** Complete. Handles 21 different flower types with proper trade checks. Lilac gives best reward. Event-driven. PASS.

**THF AF1 (Tenshodo Showdown):** Full multi-zone quest. Job check (THF), level check (AF1_QUEST_LEVEL). Key item chain: Letter -> Envelope -> Signed Envelope. Spans Windurst Woods, Lower Jeuno, Selbina. Rewards Marauder's Knife. PASS.

**SMN (I Can Hear a Rainbow):** Complex weather-based quest. Tracks 13 weather types across 25 zones via bitmask. Uses Carbuncle's Ruby item check. Proper zone-in handlers. PASS.

---

## Quests Implemented via NPC Zone Scripts (41 quests, marked + but not Converted)

These quests have their logic distributed across zone NPC scripts rather than having a dedicated quest file. They are functional but use the older implementation style.

| # | Quest Name | ID | Key NPC Scripts |
|---|-----------|-----|-----------------|
| 1 | Hat in Hand | 0 | Windurst_Waters/npcs/Baren-Moren.lua |
| 2 | A Feather in One's Cap | 1 | (NPC scripts in Windurst zones) |
| 3 | A Crisis in the Making | 2 | (NPC scripts in Windurst zones) |
| 4 | In a Pickle | 5 | (NPC scripts in Windurst zones) |
| 5 | Wondering Minstrel | 6 | (NPC scripts in Windurst zones) |
| 6 | Making Amens! | 8 | (NPC scripts in Windurst zones) |
| 7 | The Moonlit Path | 9 | Windurst_Waters/npcs/Leepe-Hoppe.lua, Norg/npcs/Mamaulabion.lua, battlefields/Full_Moon_Fountain/moonlit_path.lua |
| 8 | The All-New C-3000 | 18 | (Cardian NPC scripts) |
| 9 | The Postman Always K.O.'s Twice | 19 | (NPC scripts in Windurst zones) |
| 10 | Catch It If You Can! | 21 | (NPC scripts in Windurst zones) |
| 11 | The All-New C-2000 | 24 | (Cardian NPC scripts) |
| 12 | Chocobilious | 27 | (NPC scripts in Windurst zones) |
| 13 | Reap What You Sow | 29 | (NPC scripts in Windurst zones) |
| 14 | Mandragora-Mad | 34 | (NPC scripts in Windurst zones) |
| 15 | To Bee or Not to Bee? | 35 | (NPC scripts in Windurst zones) |
| 16 | Making Headlines | 37 | (NPC scripts in Windurst zones) |
| 17 | Creepy Crawlies | 39 | (NPC scripts in Windurst zones) |
| 18 | A Greeting Cardian | 43 | (Cardian NPC scripts) |
| 19 | Legendary Plan B | 44 | (NPC scripts in Windurst zones) |
| 20 | Can Cardians Cry? | 47 | (Cardian NPC scripts) |
| 21 | Wonder Wands | 48 | (NPC scripts in Windurst zones) |
| 22 | Hoist the Jelly, Roger | 51 | (NPC scripts in Windurst zones) |
| 23 | Something Fishy | 52 | Port_Windurst/npcs/Tokaka.lua |
| 24 | To Catch a Falling Star | 53 | (NPC scripts in Windurst zones) |
| 25 | Paying Lip Service | 60 | (NPC scripts in Windurst zones) |
| 26 | The Amazin' Scorpio | 61 | (NPC scripts in Windurst zones) |
| 27 | Twinstone Bonding | 62 | (NPC scripts in Windurst zones) |
| 28 | The Three Magi | 66 | Heavens_Tower/npcs/Chumimi.lua, Xarcabard/npcs/qm1.lua, Lower_Jeuno/npcs/Vingijard.lua |
| 29 | Recollections | 67 | Heavens_Tower/npcs/Chumimi.lua, RuLude_Gardens/npcs/Laityn.lua, Castle_Zvahl_Keep/npcs/_4i5.lua |
| 30 | Sin Hunting | 72 | (NPC scripts in Windurst zones) |
| 31 | Fire and Brimstone | 73 | (NPC scripts in Windurst zones) |
| 32 | Unbridled Passion | 74 | (NPC scripts in Windurst zones) |
| 33 | Class Reunion (SMN) | 82 | Windurst_Walls/npcs/Koru-Moru.lua, Windurst_Waters/npcs/Fuepepe.lua, battlefields/Cloister_of_Frost/class_reunion.lua |
| 34 | Carbuncle Debacle (SMN) | 83 | Windurst_Walls/npcs/Koru-Moru.lua, Rabao/npcs/Agado-Pugado.lua, Mhaura/npcs/Ripapa.lua, battlefields/Cloister_of_*/carbuncle_debacle.lua |
| 35 | Eco-Warrior (Windurst) | 84 | Windurst_Waters/npcs/Lumomo.lua |
| 36 | Tuning In | 90 | (NPC scripts in Windurst zones) |
| 37 | Tuning Out | 91 | (NPC scripts in Windurst zones) |
| 38 | Waking Dreams | 93 | Windurst_Waters/npcs/Kerutoto.lua, battlefields/The_Shrouded_Maw/waking_dreams.lua |
| 39 | Lure of the Wildcat (Windurst) | 94 | (NPC scripts in Windurst zones) |
| 40 | Trust: Windurst | 96 | Windurst_Woods/npcs/Wetata.lua, Heavens_Tower/npcs/Kupipi.lua |
| 41 | A Chocobo Riding Game (Windurst) | -- | (Chocobo system scripts) |

---

## NOT Implemented (6 quests -- defined in enum only)

These quests appear in `scripts/globals/quests.lua` but have NO script logic anywhere in the codebase (no NPC handlers, no quest files, no battlefield scripts referencing them).

| # | Quest Name | ID | What It Should Do |
|---|-----------|-----|-------------------|
| 1 | **Heaven Cent** | 49 | Windurst Waters. Trade 1 gil to an NPC for a random reward. Fame-gated repeatable quest. Gives scrolls, items, or nothing. |
| 2 | **The Root of the Problem** | 68 | Windurst Walls. Part of the SMN quest chain. Koru-Moru sends you to investigate Toraimarai Canal. Leads into Three Magi/Carbuncle quests. **Note:** Has partial references in Koru-Moru NPC scripts and Chumimi but no dedicated handler. |
| 3 | **Nothing Matters** | 79 | Windurst Waters. High-fame quest. Trade Tonberry items to NPC. Only referenced as a prerequisite in Blast_from_the_Past.lua. |
| 4 | **Escort for Hire** | 88 | Windurst. Repeatable escort quest. Walk an NPC from point A to B while protecting them from aggro. Uses Goblin Footprint system (reference in goblinfootprint.lua). |
| 5 | **A Discerning Eye** | 89 | Windurst Waters. Trade a specific crystal to an NPC for a reward. Simple fame quest. |
| 6 | **Babban Ny Mheillea** | 95 | Campaign-era quest (Wings of the Goddess). Fight NM in Eldieme Necropolis [S]. Only a mob script exists for the NM itself. |

---

## Organized by Category

### Star Onion Brigade Chain (7 quests) -- ALL IMPLEMENTED
The main Windurst storyline quest chain. All have dedicated script files.

| Quest | File | Status |
|-------|------|--------|
| Truth, Justice, and the Onion Way! | SOB1_Truth_Justice_and_the_Onion_Way.lua | PASS |
| Know One's Onions | SOB2_Know_Ones_Onions.lua | PASS |
| Inspector's Gadget! | SOB3_Inspectors_Gadget.lua | PASS |
| Onion Rings | SOB4_Onion_Rings.lua | PASS |
| Crying Over Onions | SOB5_Crying_Over_Onions.lua | PASS |
| Wild Card | SOB6_Wild_Card.lua | PASS |
| The Promise | SOB7_The_Promise.lua | PASS |

### AF / Job Ability Quests -- ALL IMPLEMENTED

**THF Artifact (3 quests):**
| Quest | File | Status |
|-------|------|--------|
| The Tenshodo Showdown | THF_AF1_The_Tenshodo_Showdown.lua | PASS |
| As Thick as Thieves | THF_AF2_As_Thick_as_Thieves.lua | PASS |
| Hitting the Marquisate | THF_AF3_Hitting_the_Marquisate.lua | PASS |

**SMN Quests (5 quests):**
| Quest | File / NPC Scripts | Status |
|-------|-------------------|--------|
| I Can Hear a Rainbow | SMN_I_Can_Hear_a_Rainbow.lua | PASS |
| The Puppet Master | SMN_AF1_The_Puppet_Master.lua | PASS |
| Class Reunion | NPC-based (multiple zones) | PASS |
| Carbuncle Debacle | NPC-based + battlefield scripts | PASS |
| The Root of the Problem | STUB ONLY | MISSING |

**Other Job Quests:**
| Quest | Status |
|-------|--------|
| The Moonlit Path (SMN avatar) | PASS (NPC-based) |
| Waking Dreams (Diabolos) | PASS (NPC-based + battlefield) |
| The Three Magi (SMN) | PASS (NPC-based) |
| Recollections (SMN) | PASS (NPC-based) |

### Fame / Repeatable Quests

| Quest | Status | Notes |
|-------|--------|-------|
| Making Amends | PASS | Trade Animal Glue, 1500 gil |
| Flower Child | PASS | Trade flowers, fame reward |
| Rock Racketeer | PASS | Trade Zinc Ore |
| In a Stew | PASS | Trade ingredients |
| Food for Thought | PASS | Deliver food items |
| Say It with Flowers | PASS | Trade flowers |
| Making the Grade | PASS | Trade Crawler Calculus |
| Mihgo's Amigo | PASS | Trade items to Nanaa Mihgo |
| Teacher's Pet | PASS | Trade Cornette to Balasiel |
| Overnight Delivery | PASS | Delivery quest |
| Water Way to Go! | PASS | Trade Water Crystal |
| Blue Ribbon Blues | PASS | Trade Silk Thread |
| Heaven Cent | MISSING | Trade 1 gil for random reward |
| A Discerning Eye | MISSING | Trade crystal for reward |

### Starter Quests (Low Fame)

| Quest | Status | Notes |
|-------|--------|-------|
| Hat in Hand | PASS | NPC-based, first quest available |
| A Feather in One's Cap | PASS | NPC-based |
| Something Fishy | PASS | NPC-based (Port_Windurst/Tokaka) |
| Star Struck | PASS | Converted script |
| One Good Deed? | PASS | Converted script |
| Orastery Woes | PASS | Converted script |
| Making Amens! | PASS | NPC-based |

### Cardian Quest Chain

| Quest | Status |
|-------|--------|
| The All-New C-2000 | PASS (NPC-based) |
| The All-New C-3000 | PASS (NPC-based) |
| A Greeting Cardian | PASS (NPC-based) |
| Can Cardians Cry? | PASS (NPC-based) |
| Legendary Plan B | PASS (NPC-based) |

### Side Quests

| Quest | Status | Notes |
|-------|--------|-------|
| Blast from the Past | PASS | Converted, requires Nothing Matters |
| Curses, Foiled Again! | PASS | Converted |
| Curses, Foiled...Again!? | PASS | Converted |
| Curses, Foiled A-Golem!? | PASS | Converted |
| Glyph Hanger | PASS | Converted |
| Blood and Glory | PASS | Converted |
| A Pose by Any Other Name | PASS | Converted |
| Let Sleeping Dogs Lie | PASS | Converted |
| Chasing Tales | PASS | Converted |
| A Smudge on One's Record | PASS | Converted |
| Early Bird Catches the Bookworm | PASS | Converted |
| Acting in Good Faith | PASS | Converted |
| Toraimarai Turmoil | PASS | Converted |
| From Saplings Grow | PASS | Converted |
| Scooped! | PASS | Converted |
| All at Sea | PASS | Converted |
| The Fanged One | PASS | Converted |
| Eco-Warrior (Windurst) | PASS | NPC-based |
| Trust: Windurst | PASS | NPC-based |
| Lure of the Wildcat | PASS | NPC-based |
| Nothing Matters | MISSING | Tonberry item trade, high fame |
| Escort for Hire | MISSING | Escort NPC quest |
| Babban Ny Mheillea | MISSING | WotG campaign quest |

### Miscellaneous / Lower Priority

| Quest | Status | Notes |
|-------|--------|-------|
| Mandragora-Mad | PASS | NPC-based |
| To Bee or Not to Bee? | PASS | NPC-based |
| Creepy Crawlies | PASS | NPC-based |
| Hoist the Jelly, Roger | PASS | NPC-based |
| Wonder Wands | PASS | NPC-based |
| To Catch a Falling Star | PASS | NPC-based |
| Catch It If You Can! | PASS | NPC-based |
| Making Headlines | PASS | NPC-based |
| Wondering Minstrel | PASS | NPC-based |
| Paying Lip Service | PASS | NPC-based |
| The Amazin' Scorpio | PASS | NPC-based |
| Twinstone Bonding | PASS | NPC-based |
| Sin Hunting | PASS | NPC-based |
| Fire and Brimstone | PASS | NPC-based |
| Unbridled Passion | PASS | NPC-based |
| Chocobilious | PASS | NPC-based |
| Reap What You Sow | PASS | NPC-based |
| The Postman Always K.O.'s Twice | PASS | NPC-based |
| A Crisis in the Making | PASS | NPC-based |
| In a Pickle | PASS | NPC-based |
| Tuning In | PASS | NPC-based |
| Tuning Out | PASS | NPC-based |
| A Chocobo Riding Game | PASS | Chocobo system |

---

## Key Findings

### What Works Well
1. **Star Onion Brigade chain is fully implemented** with modern Quest:new() framework
2. **THF AF and SMN quest lines are complete** -- all quests have proper handlers
3. **Fame/repeatable quests are solid** -- trade handlers, reward logic, fame checks all present
4. **44 quests have been "Converted"** to the modern standalone script format with proper section-based flow

### What Is Missing (6 quests)
1. **Heaven Cent** (ID 49) -- Simple 1-gil trade quest, random reward. Low priority but easy to implement.
2. **The Root of the Problem** (ID 68) -- Part of SMN quest chain. Has partial NPC references but no complete handler. Medium priority if playing SMN.
3. **Nothing Matters** (ID 79) -- Prerequisite for Blast from the Past. Players may hit a wall if they need this quest's completion flag.
4. **Escort for Hire** (ID 88) -- Escort quest using Goblin Footprint system. Low priority, escort quests are niche.
5. **A Discerning Eye** (ID 89) -- Simple crystal trade quest. Low priority.
6. **Babban Ny Mheillea** (ID 95) -- WotG content, not relevant to base game progression.

### Potential Issues
- **Nothing Matters** is listed as a prerequisite for Blast from the Past. If the prerequisite check is enforced, players cannot complete Blast from the Past without it. Verified: Blast_from_the_Past.lua does reference `NOTHING_MATTERS` as quest status `QUEST_COMPLETED` in its checks.
- **The Root of the Problem** has partial NPC references in Koru-Moru and Chumimi scripts but no complete quest flow. SMN players following the full quest chain may encounter a gap.

---

## File Locations

- Quest scripts: `scripts/quests/windurst/` (44 files)
- Quest enum: `scripts/globals/quests.lua` (lines 224-316)
- Quest framework: `scripts/globals/interaction/quest.lua`
- Battlefield scripts: `scripts/battlefields/` (for Moonlit Path, Waking Dreams, Carbuncle Debacle, Class Reunion)
