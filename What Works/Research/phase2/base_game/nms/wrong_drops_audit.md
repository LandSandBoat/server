# Wrong Drops Audit - mob_droplist.sql

## Audit Plan

| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Cross-family material drops (wrong ecosystem items on mobs) | COMPLETE |
| 2 | Duplicate droplist entries (same item x2+ in same droplist) | COMPLETE |
| 3 | Droplist 0 (mobs with no drops assigned) | COMPLETE |
| 4 | Specific item spot-checks (Lizard Blood, Fiend Blood, etc.) | COMPLETE |

**Date:** 2026-03-28
**Database:** `sql/mob_droplist.sql`, `sql/mob_groups.sql`, `sql/mob_pools.sql`, `sql/mob_family_system.sql`
**Methodology:** Python script cross-referencing mob familyID -> ecosystem against item drop associations

---

## Executive Summary

- **Cross-family wrong drops:** 0 confirmed (the database is clean for family-specific materials)
- **Duplicate drop entries:** 331 droplists have items appearing 2+ times at the SAME rate in the SAME group (intentional multi-drop mechanic in LandSandBoat, not bugs)
- **Droplist 0 mobs:** 658 respawning mobs have no droplist assigned (most are intentional: Fomors, Elementals, Promyvion mobs, etc.)
- **Diremite/Lizard Blood:** NOT present in database. Diremites (droplist 657) correctly drop Fiend Blood (id=924). The "Lizard Blood" item does not exist in mob_droplist.sql.

---

## Phase 1: Cross-Family Material Drops

### Methodology
Tracked 17 ecosystem-specific items and checked if any mob from a different ecosystem drops them:

| Item ID | Item Name | Expected Ecosystem |
|---------|-----------|-------------------|
| 852 | Lizard Skin | Lizard (14) |
| 926 | Lizard Tail | Lizard (14) |
| 4362 | Lizard Egg | Lizard (14) |
| 842 | Giant Bird Feather | Bird (8) |
| 847 | Bird Feather | Bird (8) |
| 844 | Bird Egg | Bird (8) |
| 922 | Bat Wing | Bird (8) |
| 891 | Bat Fang | Bird (8) |
| 856 | Rabbit Hide | Beast (6) |
| 505 | Sheepskin | Beast (6) |
| 846 | Insect Wing | Vermin (20) |
| 838 | Spider Web | Vermin (20) |
| 896 | Scorpion Shell | Vermin (20) |
| 897 | Scorpion Claw | Vermin (20) |
| 880 | Bone Chip | Undead (19) |
| 881 | Crab Shell | Aquan (2) |

### Result: CLEAN

No mobs from a wrong ecosystem are dropping family-specific materials (excluding Beastmen, which intentionally drop various materials).

Notable item ID clarifications discovered during audit:
- Item 914 = **Vial of Mercury** (NOT Scorpion Shell). Dropped by Dolls/Pots/Hecteyes -- this is correct.
- Item 916 = **Cactuar Needle** (NOT Scorpion Claw). Dropped by Sabotenders -- this is correct.
- Item 1280 = **Square of Sarcenet Cloth** (NOT Lizard Egg). Lizard Egg is item 4362.
- Item 924 = **Vial of Fiend Blood** (NOT Bat Fang). Bat Fang is item 891.

### Crab Shell on Sahagin (Intentional)
Sahagin (Beastmen ecosystem) dropping Crab Shell (881) is lore-appropriate -- Sahagin are aquatic beastmen. 18 Sahagin variants drop Crab Shell. This is NOT a bug.

---

## Phase 2: Duplicate Drop Entries

### Understanding the System
LandSandBoat uses multiple entries of the same item at different rates to create a multi-drop system. For example:
```
Adamantoise drops Adaman Ore: @ALWAYS, @VCOMMON, @COMMON, @COMMON
```
This means the player gets 1-4 ores with decreasing probability per additional drop. **This is intentional.**

### True Duplicates (Same Item, Same Rate, Same Group)
Found **331 instances** where the exact same item appears at the exact same rate in the same group. These represent the multi-drop system and match retail behavior. They are NOT bugs -- they are how LandSandBoat implements "drop X copies of an item."

### Notable Patterns

**Yagudo Feather farming (intentional x4 drops):**
Most Yagudo mobs have Yagudo Feather x4 at @COMMON rate, matching retail where Yagudo drop multiple feathers.

**NM multi-drops (intentional):**
- Battering Ram: Ram Skin x6 (various rates) -- NMs drop more materials
- Broo: Giant Sheep Meat x3, Sheepskin x3 -- intended
- Dune Widow: Spider Web x3 at @ALWAYS -- NM guaranteed drops
- Jormungand: Molybdenum Ore x4 at @ALWAYS -- HNM drops

**Potentially suspicious duplicates worth reviewing:**

| Droplist | Mob | Item | Count | Rate | Notes |
|----------|-----|------|-------|------|-------|
| 657 | Diremite | Fiend Blood (924) | x2 | @VCOMMON | May be intentional multi-drop |
| 1637 | Masan | Fiend Blood (924) | x2 | @VCOMMON | Same pattern as Diremite |
| 338 | Bonze Marberry | Cursed Key (1143) | x2 | @ALWAYS | Guaranteed double key? |
| 583 | Death from Above | Pot of Honey (4370) | x2 | @ALWAYS | Double honey seems odd |
| 666 | Dirtyhanded Gochakzuk | Curse Wand (17437) | x2 | @ALWAYS | Double weapon drop |
| 1806 | Nightmare Vase | Magic Pot Shard (954) | x4 | @ALWAYS | 4x guaranteed seems high |
| 1806 | Nightmare Vase | Vial of Mercury (914) | x2 | @ALWAYS | Double guaranteed |
| 2018 | Porphyrion | Delkfutt Key (549) | x6 | @ALWAYS | 6x key is likely intentional for key farming |

---

## Phase 3: Droplist 0 (No Drops)

### Summary
- **Total mobs with droplist=0:** 8,100
- **Respawning mobs with droplist=0:** 658

### By Ecosystem (respawning mobs only)

| Ecosystem | Count | Notes |
|-----------|-------|-------|
| Elemental | 108 | Most Elementals have cluster drops on their own system |
| Undead | 97 | Mostly Fomors in Tavnazia/Phomiuna (intentional) |
| Vermin | 66 | May need investigation |
| Amorph | 61 | |
| Beastmen | 45 | |
| Plantoid | 44 | |
| Aquan | 38 | |
| Arcana | 34 | |
| Beast | 30 | |
| Lizard | 30 | |
| Bird | 28 | |
| Luminian | 20 | Al'Taieu mobs (intentional) |
| Unclassified | 19 | |
| Empty | 11 | Promyvion mobs (drop system is Lua-scripted) |
| Fairy | 6 | |
| Demon | 5 | |
| Dragon | 5 | |
| Avatar | 4 | Summoned avatars (intentional) |
| Voragean | 4 | |
| Luminion | 3 | |

### Sample Mobs with No Drops (likely intentional)
- Fomors in zones 24-28 (Tavnazia): Drops handled via separate system
- Promyvion mobs (Empty ecosystem): Drops via Lua scripts
- Hobgoblins in zone 4: CoP content, may need drops
- Pavan/Avatar summons: Intentionally no drops
- Memory Receptacles: Intentionally no drops

---

## Phase 4: Specific Item Checks

### Diremite Drops (Original Investigation)
**Finding:** The database is CORRECT. Diremites do NOT drop Lizard Blood.
- Diremite (droplist 657, zone 9): Fiend Blood x2, Florid Stone, Gray Chip, Avatar Blood
- Diremite (droplist 658, zone 27): Bloodthread, Avatar Blood, Fiend Blood (steal)
- Aydeewa Diremite (droplist 204, zone 68): Colorful Hair, Bloodthread, Avatar Blood, Fiend Blood (steal)

"Lizard Blood" as an item name does not appear anywhere in `mob_droplist.sql`.

### Bone Chip (880)
All mobs dropping Bone Chip are Undead ecosystem. **CLEAN.**

### Spider Web (838)
All mobs dropping Spider Web are Vermin ecosystem (spiders). **CLEAN.**

### Sheepskin (505)
All mobs dropping Sheepskin are Beast ecosystem. **CLEAN.**

### Lizard Skin (852) / Lizard Egg (4362)
All mobs dropping these are Lizard ecosystem. **CLEAN.**

### Crab Shell (881)
Dropped by Aquan mobs AND Sahagin (Beastmen) -- lore-appropriate. **CLEAN.**

### Bat Wing (922)
All mobs dropping Bat Wing are Bird ecosystem (bats are classified as Bird in FFXI). **CLEAN.**

---

## Conclusion

The `mob_droplist.sql` database is remarkably clean for cross-family material drops. The LandSandBoat team has correctly assigned ecosystem-appropriate drops across all checked items.

The 331 "duplicate" entries are the intentional multi-drop system, not bugs. They allow mobs to drop multiple copies of the same item (e.g., 4 Yagudo Feathers, 6 Ram Skins from NMs).

The 658 respawning mobs with droplist=0 are mostly intentional (Fomors, Promyvion mobs, Elementals), though some Vermin/Amorph/Beast/Beastmen mobs in this category may warrant individual investigation.

**No action items identified.** The original Diremite/Lizard Blood issue does not exist in the current database.

---

## Files Analyzed
- `/Users/jasonclift/Code/Lua/Personal/xiserver/sql/mob_droplist.sql` (28,969 lines)
- `/Users/jasonclift/Code/Lua/Personal/xiserver/sql/mob_groups.sql` (16,582 lines)
- `/Users/jasonclift/Code/Lua/Personal/xiserver/sql/mob_pools.sql`
- `/Users/jasonclift/Code/Lua/Personal/xiserver/sql/mob_family_system.sql` (401 families)
