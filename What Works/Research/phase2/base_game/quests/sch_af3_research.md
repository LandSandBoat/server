# SCH AF3 Research: Seeing Blood-red

## Quest Overview

| Field | Value |
|-------|-------|
| Quest Name | Seeing Blood-red |
| Quest Log | Crystal War |
| Quest ID | 34 (`SEEING_BLOOD_RED`) |
| Starting NPC | Erlene |
| Starting Zone | The Eldieme Necropolis [S] (zone 175), position: 376.936, -39.999, 17.914 |
| NPC Entity ID | 17494732 |
| Prerequisites | Complete "Downward Helix" (AF2, quest ID 33), zone + wait 1 game day, SCH main job, level >= AF3_QUEST_LEVEL (50) |
| Reward | Scholar's Mortarboard (item ID 16140, `xi.item.SCHOLARS_MORTARBOARD`) |
| Title | Summa Cum Laude |

## Quest Walkthrough (from BG-Wiki / cross-referenced sources)

### Step 1: Start quest
- Talk to **Erlene** at The Eldieme Necropolis [S] (J-8) as SCH main job.
- She tells you to return to where you previously found Schultz.
- Quest accepted.

### Step 2: Collect key item at Pashhow Marshlands [S]
- Travel to **Pashhow Marshlands [S]** (zone 90).
- Examine **Indescript Markings** near E-11 along the north wall edge.
  - This is the same offset=0 marking used in AF1 (`ID.npc.INDESCRIPT_MARKINGS_OFFSET + 0`).
  - NPC ID: 17146627 (pos: -457.366, 24.532, -364.607).
- Obtain key item: **Unaddressed sealed letter** (`xi.ki.UNADDRESSED_SEALED_LETTER`, KI ID 977).

### Step 3: Return to Erlene
- Go back to Erlene at The Eldieme Necropolis [S].
- Cutscene plays; she gives you the **Porting magic transcript** (`xi.ki.PORTING_MAGIC_TRANSCRIPT`, KI ID 978).

### Step 4: Travel to Grauberg [S]
- Go to **Grauberg [S]** (zone 89) at approximately E-10.
- Find the cave opposite the waterfall.
- Examine a "shimmering light on the ground" inside the cave.

### Step 5: Enter the battlefield instance in Ruhotz Silvermines
- Examine the **Indescript Markings** on the cave wall in Grauberg [S].
  - The Grauberg [S] IDs.lua has `INDESCRIPT_MARKINGS = GetFirstID('Indescript_Markings')` -- first NPC (17142582) is for SCH AF body quest, the second one (17142587) at -288.011, -56.000, -106.048 appears to be the BCNM entrance (code comment: "Second markings are bcnm entrance").
- This enters an instance in **Ruhotz Silvermines** (zone 93).

### Step 6: Battlefield -- Fight Ulbrecht
- **Instance zone**: Ruhotz Silvermines (zone 93)
- **Time limit**: 30 minutes
- **Party size**: Up to 6 members
- **Trusts**: Permitted
- **Enemy**: Ulbrecht (Level 67 Scholar NM, ~12,000 HP)
  - Mob pool ID: 4078
  - Mob group ID: 4659 (zone 93)
  - Uses Dark Arts Stratagems
  - Weapons: Dagger (Wasp Sting)
  - Spells: Aspir, Cure IV, Drain, Sleep, Storm spells, tier III elemental nukes
  - At 50% HP: Uses Tabula Rasa (2-hour ability)
  - **Immune to**: Silence
  - **Vulnerable to**: Bind, Gravity, Sleep

### Step 7: Complete the quest
- After winning the battlefield, return to **Erlene** at The Eldieme Necropolis [S].
- Final cutscene plays.
- Receive reward: **Scholar's Mortarboard**.

## Key Items Involved

| Key Item | Enum ID | Purpose |
|----------|---------|---------|
| Unaddressed sealed letter | `xi.ki.UNADDRESSED_SEALED_LETTER` (977) | Picked up at Pashhow Marshlands [S] markings |
| Porting magic transcript | `xi.ki.PORTING_MAGIC_TRANSCRIPT` (978) | Given by Erlene after returning with the letter |

## Zones Involved

| Zone | Zone ID | Purpose |
|------|---------|---------|
| The Eldieme Necropolis [S] | 175 | Quest start/progress/completion (Erlene NPC) |
| Pashhow Marshlands [S] | 90 | Indescript Markings -- pick up sealed letter |
| Grauberg [S] | 89 | Cave entrance to battlefield instance |
| Ruhotz Silvermines | 93 | Battlefield instance zone |

## Reward Item: Scholar's Mortarboard

| Field | Value |
|-------|-------|
| Item ID | 16140 |
| Enum | `xi.item.SCHOLARS_MORTARBOARD` |
| DEF | 15 |
| MP | +15 |
| INT | +4 |
| Sublimation Bonus | +1 per tick |
| Level | 60 |
| Jobs | SCH only |
| Slot | Head |

**Database status**:
- `sql/item_basic.sql`: EXISTS (line ~13568)
- `sql/item_equipment.sql`: EXISTS (line ~5889, level 60, job mask 524288=SCH)
- `sql/item_mods.sql`: EXISTS (4 entries: DEF 15, MP 15, INT 4, SUBLIMATION_BONUS 1)
- `scripts/enum/item.lua`: EXISTS as `SCHOLARS_MORTARBOARD = 16140`

## Codebase Status

### What EXISTS

| Component | Location | Notes |
|-----------|----------|-------|
| Quest ID | `scripts/globals/quests.lua` line 743 | `SEEING_BLOOD_RED = 34` in crystalWar section |
| RoE record | `scripts/globals/roe_records.lua` line 997 | Record 688 triggers on quest completion |
| Vingijard AF reset | `scripts/zones/Lower_Jeuno/npcs/Vingijard.lua` line 171 | SCH AF3 slot references this quest |
| Erlene NPC (default) | `scripts/zones/The_Eldieme_Necropolis_[S]/DefaultActions.lua` | Default event = 15 |
| Erlene NPC entity | `sql/npc_list.sql` line 21303 | ID 17494732, pos 376.936, -39.999, 17.914 |
| Ulbrecht mob pool | `sql/mob_pools.sql` line 4137 | Pool 4078, model exists |
| Ulbrecht mob group | `sql/mob_groups.sql` line 6574 | Group 4659, zone 93, spawn type 128 (instance) |
| Ulbrecht NPC entries | `sql/npc_list.sql` | Multiple entries in zones 175, 89, 90, etc. for cutscenes |
| Indescript Markings (Pashhow) | `scripts/zones/Pashhow_Marshlands_[S]/npcs/Indescript_Markings.lua` | Offset 0 = AF1 quest area, offsets 1/2 = pants/body sub-quests |
| Indescript Markings (Grauberg) | `scripts/zones/Grauberg_[S]/npcs/Indescript_Markings.lua` | Currently only handles SCH AF body quest; comment says "Second markings are bcnm entrance" |
| Key items | `scripts/enum/key_item.lua` lines 970-971 | Both KIs defined (977, 978) |
| Reward item | Multiple SQL files + enum | Fully defined, just unobtainable |
| Ruhotz Silvermines zone | `scripts/zones/Ruhotz_Silvermines/Zone.lua` | Instance zone exists with entry logic |
| Existing instances | `scripts/zones/Ruhotz_Silvermines/instances/` | `light_in_the_darkness.lua` (9300) and `doomvoid.lua` exist |

### What is MISSING

| Component | What is Needed |
|-----------|---------------|
| Quest script | `scripts/quests/crystalWar/SCH_AF3_Seeing_Blood_Red.lua` -- does NOT exist |
| Instance script | `scripts/zones/Ruhotz_Silvermines/instances/seeing_blood_red.lua` -- does NOT exist |
| Instance DB entry | No row in `sql/instance_list.sql` for seeing_blood_red -- need to add (likely ID 9302) |
| Ulbrecht mob script | No mob script at `scripts/zones/Ruhotz_Silvermines/mobs/Ulbrecht.lua` |
| Grauberg [S] BCNM entrance logic | `Indescript_Markings.lua` in Grauberg [S] has no AF3 quest handling for the BCNM entrance |
| Pashhow Marshlands AF3 handling | `Indescript_Markings.lua` in Pashhow [S] only handles pants (offset 1) and body (offset 2) sub-quests, not AF3 quest (offset 0) |

## Implementation Pattern (from AF1/AF2)

Both AF1 and AF2 use the **Quest framework** (`Quest:new()`). Key patterns:

### Quest file structure
```lua
local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_BLOOD_RED)

quest.reward = {
    item = xi.item.SCHOLARS_MORTARBOARD,
    title = xi.title.SUMMA_CUM_LAUDE,  -- verify title enum exists
}

quest.sections = {
    -- Section 1: Quest available check + start
    -- Section 2: Quest accepted + progression steps
}
```

### Progression pattern
1. **Section 1**: `check` verifies quest available + AF2 complete + timer expired + SCH job + level
2. **Section 2**: `check` verifies quest accepted, then defines handlers per zone

### Timer between quests
AF1 sets timer for AF2: `xi.quest.setVar(player, ..., 'Timer', VanadielUniqueDay() + 1)`
AF2 sets timer for AF3 the same way (already in AF2 script line 94).
AF3 check must verify: `xi.quest.getVar(player, ..., DOWNWARD_HELIX, 'Timer') <= VanadielUniqueDay()`

### Key item handling
- Give KI via `npcUtil.giveKeyItem(player, ki)`
- Delete KIs on quest completion via `player:delKeyItem(ki)`

## Instance Pattern (from light_in_the_darkness)

The existing Ruhotz Silvermines instance (`light_in_the_darkness.lua`, ID 9300) shows:

1. `registryRequirements` / `entryRequirements` -- check for a key item
2. `onInstanceCreated` -- spawn mobs
3. `onInstanceCreatedCallback` -- use `xi.instance.onInstanceCreatedCallback`
4. `afterInstanceRegister` -- delete entry KI, start cutscene
5. `onInstanceTimeUpdate` -- check win conditions
6. `onInstanceFailure` -- teleport player back to Grauberg [S]
7. `onInstanceComplete` -- set quest progress, start exit cutscene

Instance list entry format: `(id, name, zone_id, ?, ?, entry_x, entry_y, entry_z, entry_rot, ...)`
- light_in_the_darkness: `(9300, 'light_in_the_darkness', 93, 90, 0, -22.500, 1.600, 40.000, 192, ...)`
- fire_in_the_hole: `(9301, 'fire_in_the_hole', 93, 88, 0, 156.000, 0.000, -60.000, 0, ...)`

New instance would likely be ID **9302**.

## Files to Create/Modify

### New files
1. `scripts/quests/crystalWar/SCH_AF3_Seeing_Blood_Red.lua` -- main quest script
2. `scripts/zones/Ruhotz_Silvermines/instances/seeing_blood_red.lua` -- battlefield instance
3. `scripts/zones/Ruhotz_Silvermines/mobs/Ulbrecht.lua` -- Ulbrecht mob behavior

### Files to modify
1. `scripts/zones/Pashhow_Marshlands_[S]/npcs/Indescript_Markings.lua` -- add AF3 quest handling at offset 0
2. `scripts/zones/Grauberg_[S]/npcs/Indescript_Markings.lua` -- add BCNM entrance handling for AF3
3. `sql/instance_list.sql` -- add seeing_blood_red instance entry (ID 9302)
4. `scripts/zones/Ruhotz_Silvermines/IDs.lua` -- add ULBRECHT mob offset if needed

### Files to verify
1. `scripts/enum/title.lua` -- confirm `SUMMA_CUM_LAUDE` title exists
2. `scripts/zones/The_Eldieme_Necropolis_[S]/DefaultActions.lua` -- Erlene default event (15) should not conflict with quest events
3. Event IDs for cutscenes in each zone -- need to determine correct event IDs

## Resolved Questions

1. **SUMMA_CUM_LAUDE title**: CONFIRMED -- exists at `scripts/enum/title.lua` line 591 (`SUMMA_CUM_LAUDE = 591`).

2. **Grauberg [S] BCNM entrance NPC**: The second `Indescript_Markings` NPC (ID 17142587) at pos -288.011, -56.000, -106.048 is the BCNM entrance. It has NPC flag type=2 (instance entrance) vs the first one (17142582) which is for the body sub-quest. The Grauberg [S] `IDs.lua` uses `GetFirstID('Indescript_Markings')` which returns 17142582 -- the BCNM entrance is at offset +5 (17142587). The code in `Indescript_Markings.lua` already checks `npc:getID() == ID.npc.INDESCRIPT_MARKINGS` to distinguish them.

3. **Pashhow Indescript Markings offset 0**: AF1 handles offset 0 via the Quest framework in `SCH_AF1_On_Sabbatical.lua`, NOT in the NPC script. AF3 can do the same -- handle offset 0 in the Quest framework file. No conflict.

## Open Questions

1. **Event IDs**: What are the correct cutscene event IDs for Erlene and other NPCs during this quest? AF1 uses events 18-20 in Eldieme Necropolis [S]; AF2 uses events 23-27. AF3 likely uses events 28+ but exact IDs need verification from client DAT files. Pashhow [S] AF1 uses event 2; Grauberg [S] events need to be determined.

2. **Instance entry position**: What is the correct entry position for the seeing_blood_red instance inside Ruhotz Silvermines? The existing `light_in_the_darkness` uses (-22.5, 1.6, 40.0, rot 192). The Zone.lua exit event (10000) sends players to (-385.602, 21.970, 456.359) which is back in Grauberg [S].

3. **Ulbrecht mob specifics**: What spellset, skillset, and resistances does the Ulbrecht mob need? The mob pool exists (4078) with model data. Known: uses Dark Arts, dagger attacks, Wasp Sting, Aspir/Cure IV/Drain/Sleep/Storm spells/tier III nukes. Immune to Silence. Vulnerable to Bind/Gravity/Sleep. Uses Tabula Rasa at 50% HP. ~12,000 HP at level 67. Spellset/skillset IDs need to be determined or created.

4. **Grauberg [S] "shimmering light"**: The wiki mentions examining a "shimmering light on the ground" before the BCNM entrance. This might be a separate NPC (one of the blank NPCs near the Indescript_Markings) or it might be a cutscene triggered by the Indescript_Markings NPC itself. The blank NPC at 17142589 (type 2, flag 2051) near the BCNM entrance could be this.

## Source Verification Notes

- BG-Wiki page for "Seeing Blood-red" is currently EMPTY (no content).
- Quest details were obtained from BG-Wiki's Scholar's Mortarboard item page and the Downward Helix quest page (which lists Seeing Blood-red as next quest).
- Battlefield details were obtained from a successful WebFetch of the quest name (the fetcher found content on one attempt).
- Upstream LandSandBoat (github.com/LandSandBoat/server) also does NOT have this quest implemented -- only AF1 and AF2 exist.
- This will be a **from-scratch implementation** with no upstream reference.
