# Windurst Quests -- Full Audit (CORRECTED)

> **CORRECTED 2026-03-28.** Previous audit overcounted by including "A Chocobo Riding Game" which is not registered in quests.lua. Actual totals adjusted.
> Source: `scripts/globals/quests.lua` lines 224-316 (xi.questLog.WINDURST)
> Script path: `scripts/quests/windurst/`
> Date: 2026-03-28

---

## Summary

| Metric | Count |
|--------|-------|
| Quests registered in quests.lua (WINDURST) | 90 |
| Quests marked "+ Converted" (dedicated script file) | 45 |
| Quests marked "+" only (NPC-based, old-style) | 39 |
| Quests with NO mark (not implemented) | 6 |
| **Total implemented** | **84 / 90 (93.3%)** |

### Implementation Legend (from scripts/globals/quests.lua)
- **"+ Converted"** = Modern quest framework (`Quest:new()` in `scripts/quests/windurst/`). Best quality.
- **"+"** = Implemented via NPC scripts in zone directories (old-style). Functional but harder to maintain.
- **No marker** = Not implemented or only stub references exist.

---

## Quests with Dedicated Script Files (45 entries marked "+ Converted")

| # | Quest Name | ID | Script File |
|---|-----------|-----|-------------|
| 1 | Making Amends | 3 | Making_Amends.lua |
| 2 | Making the Grade | 4 | Making_the_Grade.lua |
| 3 | A Pose by Any Other Name | 7 | A_Pose_by_Any_Other_Name.lua |
| 4 | Star Struck | 10 | Star_Struck.lua |
| 5 | Blast from the Past | 11 | Blast_from_the_Past.lua |
| 6 | A Smudge on One's Record | 12 | A_Smudge_on_Ones_Record.lua |
| 7 | Chasing Tales | 13 | Chasing_Tales.lua |
| 8 | Food for Thought | 14 | Food_for_Thought.lua |
| 9 | Overnight Delivery | 15 | Overnight_Delivery.lua |
| 10 | Water Way to Go | 16 | Water_Way_to_Go.lua |
| 11 | Blue Ribbon Blues | 17 | Blue_Ribbon_Blues.lua |
| 12 | Early Bird Catches the Bookworm | 20 | Early_Bird_Catches_the_Bookworm.lua |
| 13 | All at Sea | 23 | All_At_Sea.lua |
| 14 | Mihgo's Amigo | 25 | Mihgos_Amigo.lua |
| 15 | Rock Racketeer | 26 | Rock_Racketeer.lua |
| 16 | Teacher's Pet | 28 | Teachers_Pet.lua |
| 17 | Glyph Hanger | 30 | Glyph_Hanger.lua |
| 18 | The Fanged One | 31 | The_Fanged_One.lua |
| 19 | Curses, Foiled Again! | 32 | Curses_Foiled_Again_1.lua |
| 20 | Curses, Foiled...Again!? | 33 | Curses_Foiled_Again_2.lua |
| 21 | Truth, Justice, and the Onion Way! | 36 | SOB1_Truth_Justice_and_the_Onion_Way.lua |
| 22 | Scooped! | 38 | Scooped.lua |
| 23 | Know One's Onions | 40 | SOB2_Know_Ones_Onions.lua |
| 24 | Inspector's Gadget! | 41 | SOB3_Inspectors_Gadget.lua |
| 25 | Onion Rings | 42 | SOB4_Onion_Rings.lua |
| 26 | In a Stew | 45 | In_a_Stew.lua |
| 27 | Let Sleeping Dogs Lie | 46 | Let_Sleeping_Dogs_Lie.lua |
| 28 | Say It with Flowers | 50 | Say_It_With_Flowers.lua |
| 29 | Curses, Foiled A-Golem!? | 63 | Curses_Foiled_A_Golem.lua |
| 30 | Acting in Good Faith | 64 | Acting_in_Good_Faith.lua |
| 31 | Flower Child | 65 | Flower_Child.lua |
| 32 | The Tenshodo Showdown (THF AF1) | 69 | THF_AF1_The_Tenshodo_Showdown.lua |
| 33 | As Thick as Thieves (THF AF2) | 70 | THF_AF2_As_Thick_as_Thieves.lua |
| 34 | Hitting the Marquisate (THF AF3) | 71 | THF_AF3_Hitting_the_Marquisate.lua |
| 35 | I Can Hear a Rainbow (SMN) | 75 | SMN_I_Can_Hear_a_Rainbow.lua |
| 36 | Crying Over Onions | 76 | SOB5_Crying_Over_Onions.lua |
| 37 | Wild Card | 77 | SOB6_Wild_Card.lua |
| 38 | The Promise | 78 | SOB7_The_Promise.lua |
| 39 | Toraimarai Turmoil | 80 | Toraimarai_Turmoil.lua |
| 40 | The Puppet Master (SMN AF1) | 81 | SMN_AF1_The_Puppet_Master.lua |
| 41 | From Saplings Grow | 85 | From_Saplings_Grow.lua |
| 42 | Orastery Woes | 86 | Orastery_Woes.lua |
| 43 | Blood and Glory | 87 | Blood_and_Glory.lua |
| 44 | One Good Deed? | 92 | One_Good_Deed.lua |
| 45 | Lure of the Wildcat | 94 | Marked Converted in quests.lua; logic in zone NPC scripts |

---

## Quests Implemented via NPC Zone Scripts (39 entries marked "+" only)

| # | Quest Name | ID |
|---|-----------|-----|
| 1 | Hat in Hand | 0 |
| 2 | A Feather in One's Cap | 1 |
| 3 | A Crisis in the Making | 2 |
| 4 | In a Pickle | 5 |
| 5 | Wondering Minstrel | 6 |
| 6 | Making Amens! | 8 |
| 7 | The Moonlit Path | 9 |
| 8 | The All-New C-3000 | 18 |
| 9 | The Postman Always K.O.'s Twice | 19 |
| 10 | Catch It If You Can! | 21 |
| 11 | The All-New C-2000 | 24 |
| 12 | Chocobilious | 27 |
| 13 | Reap What You Sow | 29 |
| 14 | Mandragora-Mad | 34 |
| 15 | To Bee or Not to Bee? | 35 |
| 16 | Making Headlines | 37 |
| 17 | Creepy Crawlies | 39 |
| 18 | A Greeting Cardian | 43 |
| 19 | Legendary Plan B | 44 |
| 20 | Can Cardians Cry? | 47 |
| 21 | Wonder Wands | 48 |
| 22 | Hoist the Jelly, Roger | 51 |
| 23 | Something Fishy | 52 |
| 24 | To Catch a Falling Star | 53 |
| 25 | Paying Lip Service | 60 |
| 26 | The Amazin' Scorpio | 61 |
| 27 | Twinstone Bonding | 62 |
| 28 | The Three Magi | 66 |
| 29 | Recollections | 67 |
| 30 | Sin Hunting | 72 |
| 31 | Fire and Brimstone | 73 |
| 32 | Unbridled Passion | 74 |
| 33 | Class Reunion (SMN) | 82 |
| 34 | Carbuncle Debacle (SMN) | 83 |
| 35 | Eco-Warrior (Windurst) | 84 |
| 36 | Tuning In | 90 |
| 37 | Tuning Out | 91 |
| 38 | Waking Dreams | 93 |
| 39 | Trust: Windurst | 96 |

---

## NOT Implemented (6 quests -- no mark in quests.lua, no script files)

| # | Quest Name | ID | Notes |
|---|-----------|-----|-------|
| 1 | Heaven Cent | 49 | Trade 1 gil for random reward. Simple fame-gated repeatable. Low priority. |
| 2 | The Root of the Problem | 68 | Part of SMN chain. Partial NPC refs in Koru-Moru/Chumimi but no complete handler. |
| 3 | Nothing Matters | 79 | See investigation below. |
| 4 | Escort for Hire | 88 | Escort NPC quest. Uses Goblin Footprint system. |
| 5 | A Discerning Eye | 89 | Trade crystal for reward. Simple fame quest. |
| 6 | Babban Ny Mheillea | 95 | WotG campaign quest. Not relevant to base game. |

---

## "Nothing Matters" Investigation

**Status:** NOT IMPLEMENTED. No quest script, no NPC zone handlers.

The only references to `NOTHING_MATTERS` in the codebase are:

1. `scripts/globals/quests.lua` line 298 -- enum definition (no + mark)
2. `scripts/quests/windurst/Blast_from_the_Past.lua` lines 95 and 147

**Does it block Blast from the Past?** NO. The Blast_from_the_Past.lua references are:
- Line 95: `xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)` -- called after completing Blast from the Past. This uses the NOTHING_MATTERS quest ID slot as a mustZone flag for Blast from the Past's own repeat-tracking (forces player to zone before seeing Yoran-Oran's post-completion event).
- Line 147: `not xi.quest.getMustZone(...)` -- checks if the player has zoned since completing Blast from the Past.

This is a **mustZone bookkeeping trick** -- it borrows the NOTHING_MATTERS quest slot to track whether the player has zoned after Blast from the Past completion. It does NOT check `QUEST_COMPLETED` status on Nothing Matters as a prerequisite. Blast from the Past works fine without Nothing Matters being implemented.

**Verdict:** Nothing Matters is NOT a blocker.

---

## Key Findings

### What Works Well
1. **Star Onion Brigade chain (7 quests):** Fully implemented with modern Quest:new() framework
2. **THF AF and SMN quest lines:** Complete with proper handlers
3. **Fame/repeatable quests:** Trade handlers, reward logic, fame checks all present
4. **93.3% implementation rate** from quests.lua entries

### What Is Missing (6 quests)
1. **Heaven Cent** (49) -- Simple 1-gil trade, easy to implement
2. **The Root of the Problem** (68) -- SMN chain gap, partial NPC refs exist
3. **Nothing Matters** (79) -- Not a blocker for anything (see investigation above)
4. **Escort for Hire** (88) -- Niche escort content
5. **A Discerning Eye** (89) -- Simple crystal trade
6. **Babban Ny Mheillea** (95) -- WotG content, not relevant

---

## File Locations

- Quest scripts: `scripts/quests/windurst/` (44 .lua files on disk)
- Quest enum: `scripts/globals/quests.lua` (lines 224-316)
- Quest framework: `scripts/globals/interaction/quest.lua`
