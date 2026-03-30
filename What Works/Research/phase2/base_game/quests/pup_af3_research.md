# PUP AF3 Quest: Puppetmaster Blues - Research

## Source
- BG-Wiki: https://www.bg-wiki.com/ffxi/Puppetmaster_Blues
- Codebase: xiserver (LandSandBoat fork)

---

## Quest Overview

| Field | Value |
|---|---|
| Quest Name | Puppetmaster Blues |
| Quest Log | Aht Urhgan, ID 29 |
| Battlefield ID | 1090 (in bcnm_records) |
| Previous Quest | Operation Teatime (AF2, ID 28) |
| Next Quest | Achieving True Power |
| Required Level | 50+ Puppetmaster (uses `xi.settings.main.AF3_QUEST_LEVEL`) |
| Required Fame | Aht Urhgan (unknown level) |
| Title Reward | Paragon of Puppetmaster Excellence (`xi.title.PARAGON_OF_PUPPETMASTER_EXCELLENCE = 489`) |
| Item Reward | Puppetry Taj (`xi.item.PUPPETRY_TAJ = 15267`) |
| Repeatable | Yes (after memory reset) |

---

## Walkthrough (Step-by-Step)

### Step 1: Start the Quest
- Talk to **Iruki-Waraki** in **Aht Urhgan Whitegate** (K-9)
  - `!pos 101.329 -6.999 -29.042 50`
  - Must be PUP level 50+
  - Must have completed Operation Teatime (AF2)
  - Cutscene: asks you to speak with his mentor Shamarhaan
  - **After this cutscene, you can be any job for the rest of the quest**

### Step 2: Speak to Shamarhaan
- Talk to **Shamarhaan** in **Bastok Markets** (F-9)
  - `!pos -285.382 -13.021 -84.743 235`
  - Cutscene: gives KI **Valkeng's memory chip** (`xi.ki.VALKENGS_MEMORY_CHIP = 843`)
  - Tells you to retrieve an item from Mount Zhayolm

### Step 3: Get Toggle Switch from Mount Zhayolm
- Travel to **Mount Zhayolm** and investigate the **???** at position (L-8)
  - The ??? is on a round steam vent on the ground
  - Receive KI **Toggle switch** (`xi.ki.TOGGLE_SWITCH = 844`)
  - Easiest access: Voidwatch warp, head north then turn left toward south part of map

### Step 4: Battlefield in Talacca Cove
- Travel to **Talacca Cove** (zone 57)
  - Entrance next to Caedarva Mire Home Point
- Examine the **Rock Slab** (NPC `_1l0`) in the NW direction for cutscene
- Enter battlefield to fight **Valkeng**

### Step 5: The Valkeng Fight
- **Party size**: Up to 6 players
- **Time limit**: 30 minutes
- **Trusts**: Allowed
- **Trivial** at iLvl 119 solo on any job

#### Valkeng Mechanics
Valkeng is an Automaton-type mob. Starts as **Harlequin Frame** and changes form every 30 seconds based on damage type received:
- **50%+ Melee damage** -> Valoredge Frame
- **50%+ Ranged damage** -> Sharpshot Frame
- **50%+ Magic damage** -> Stormwaker Frame
- Never returns to Harlequin Frame

| Frame | Behavior |
|---|---|
| Harlequin | Casts Dia II, uses Slapstick WS, normal damage taken |
| Valoredge | Very fast attack, high ACC/ATT, very high physical damage reduction, uses Chimera Ripper + String Clipper |
| Sharpshot | High ACC/EVA, ranged attacks every 5s, uses Slapstick + Arcuballista, low physical DEF |
| Stormwaker | Casts high-level elemental magic every 10s, uses Slapstick, very high MDEF, normal physical damage |

### Step 6: Post-Battle
- Cutscene after defeating Valkeng (dialogue choice doesn't matter)

### Step 7: Return to Shamarhaan
- Talk to **Shamarhaan** in **Bastok Markets** for cutscene (choice doesn't matter)

### Step 8: Talk to Iruki-Waraki
- Return to **Aht Urhgan Whitegate**, speak with **Iruki-Waraki** for cutscene

### Step 9: Talk to Sajhra
- Travel to **Nashmau**, speak with **Sajhra** at (H-9) in the docks for cutscene

### Step 10: Final Turn-in
- Return to **Iruki-Waraki** in **Aht Urhgan Whitegate** for final cutscene
- Receive reward: **Puppetry Taj**

---

## Artifact Commission System (Triggered by This Quest)

After receiving Puppetmaster Blues, you can commission 3 AF pieces from **Dhima Polevhia** in Aht Urhgan Whitegate.

| Piece | Item ID | Ingredients | Cost |
|---|---|---|---|
| Puppetry Babouches (feet) | 15686 | Ruby, Wamoura Cloth, Marid Leather, Platinum Sheet | Imperial Mythril Piece x2 |
| Puppetry Dastanas (hands) | 14930 | Rainbow Thread, Wamoura Cloth, Marid Leather, Platinum Sheet | Imperial Mythril Piece x1 |
| Puppetry Tobe (body) | 14523 | Ruby, Wamoura Cloth, Moblinweave, Scarlet Linen | Imperial Gold Piece x1 |

Must wait one Vana'diel day between each commission. Order is player's choice.

---

## PUP AF Piece Distribution Across Quests

| Quest | Type | Reward |
|---|---|---|
| No Strings Attached | Unlock Quest (ID 7) | Animator (not AF armor) |
| The Wayward Automaton | AF1 (ID 27) | Turbo Animator (item 17858, not AF armor) |
| Operation Teatime | AF2 (ID 28) | Puppetry Churidars (legs, item 15602) |
| Puppetmaster Blues | AF3 (ID 29) | Puppetry Taj (head, item 15267) |
| Dhima Polevhia Commission | Triggered by AF3 | Puppetry Tobe (body), Puppetry Dastanas (hands), Puppetry Babouches (feet) |

All 5 PUP AF armor pieces:
- Head: Puppetry Taj (15267) - from AF3 quest reward
- Body: Puppetry Tobe (14523) - from commission
- Hands: Puppetry Dastanas (14930) - from commission
- Legs: Puppetry Churidars (15602) - from AF2 quest reward
- Feet: Puppetry Babouches (15686) - from commission

---

## Codebase Status

### Quest ID
- **Exists** in `scripts/globals/quests.lua` as `PUPPETMASTER_BLUES = 29` (Aht Urhgan quest log)
- Marked WITHOUT `-- +` or `-- + Converted`, indicating **not implemented**

### Battlefield
- **Exists** in `scripts/globals/battlefield.lua` as `PUPPETMASTER_BLUES = 1090`
- **Exists** in `sql/bcnm_info.sql`: `(1090,57,'puppetmaster_blues','nobody',0,1800)` -- zone 57 (Talacca Cove), 30 min
- **NO battlefield script** at `scripts/battlefields/Talacca_Cove/puppetmaster_blues.lua` -- MUST CREATE

### NPCs

| NPC | Zone | Script Exists? | Has PUP AF3 Logic? |
|---|---|---|---|
| Iruki-Waraki | Aht Urhgan Whitegate (50) | YES (`scripts/zones/Aht_Urhgan_Whitegate/npcs/Iruki-Waraki.lua`) | NO - only handles AF1 (Wayward Automaton) and AF2 (Operation Teatime), falls through to event 777 after OT completion |
| Shamarhaan | Bastok Markets (235) | NO script (only in DefaultActions.lua with default event 433) | NO - needs NPC script created at `scripts/zones/Bastok_Markets/npcs/Shamarhaan.lua` |
| Sajhra | Nashmau | YES (`scripts/zones/Nashmau/npcs/Sajhra.lua`) | NO - only handles ferry ticket logic |
| Dhima Polevhia | Aht Urhgan Whitegate | NO script (only in DefaultActions.lua with default event 788) | NO - commission system not implemented |
| Rock Slab (_1l0) | Talacca Cove (57) | In DefaultActions.lua only (`messageSpecial = -1`) | NO - battlefield entrance exists but no quest-specific logic |

### Mob Data (Valkeng)
- **mob_pools.sql**: Two entries - `Valkeng` (pool 4123, Automaton family 28) and `Valkeng_Large` (pool 7288)
- **mob_groups.sql**:
  - Zone 57 (Talacca Cove): group 9 (pool 4123) and group 16 (pool 7288)
  - Zone 64 (Navukgo Execution Chamber): group 6 (pool 4123)
- **mob_spawn_points.sql**:
  - Talacca Cove: 3 Valkeng mobs (IDs 17010719-17010721) -- for the 3 battlefield instances
  - Navukgo: 3 Valkeng + 3 Shamarhaan mobs (paired, IDs 17039394-17039399) -- appears to be Navukgo battlefield version
- **NO mob script** at `scripts/zones/Talacca_Cove/mobs/Valkeng.lua` -- MUST CREATE with frame-changing logic

### Key Items
- `xi.ki.VALKENGS_MEMORY_CHIP = 843` -- EXISTS in enum
- `xi.ki.TOGGLE_SWITCH = 844` -- EXISTS in enum

### Reward Items
- Puppetry Taj (15267) -- EXISTS in item_basic.sql and item_mods.sql with full stats
- All commission items exist in item_basic.sql and item_mods.sql

### ??? NPC in Mount Zhayolm
- No existing ??? NPC for this quest found
- qm1-qm5 exist but are for other purposes (ZNM spawns etc.)
- **Need to identify which NPC ID** corresponds to the ??? at (L-8) for the Toggle Switch
- May need to check npc_list.sql for Mount Zhayolm zone for unnamed/??? NPCs

---

## Files to Create/Modify for Implementation

### New Files Needed
1. `scripts/battlefields/Talacca_Cove/puppetmaster_blues.lua` - Battlefield script
2. `scripts/zones/Talacca_Cove/mobs/Valkeng.lua` - Mob script with frame-switching AI
3. `scripts/zones/Bastok_Markets/npcs/Shamarhaan.lua` - NPC script (currently only default action)

### Files to Modify
1. `scripts/zones/Aht_Urhgan_Whitegate/npcs/Iruki-Waraki.lua` - Add AF3 quest logic (start quest, mid-quest check-in, final reward)
2. `scripts/zones/Nashmau/npcs/Sajhra.lua` - Add AF3 cutscene trigger
3. `scripts/zones/Talacca_Cove/IDs.lua` - Add VALKENG mob reference to mob table
4. `scripts/zones/Talacca_Cove/DefaultActions.lua` - May need to update _1l0 battlefield entrance
5. Mount Zhayolm ??? NPC - Need to identify correct NPC for Toggle Switch KI pickup (likely a new qm script or existing unnamed NPC)

### Optional (Commission System)
6. `scripts/zones/Aht_Urhgan_Whitegate/npcs/Dhima_Polevhia.lua` - AF commission NPC (separate feature)

---

## Open Questions for Implementation

1. **Mount Zhayolm ??? NPC**: Which NPC ID in npc_list.sql corresponds to the steam vent at (L-8)? Need to check npc_list.sql for Mount Zhayolm zone for an unnamed NPC near that position.
2. **Event IDs**: What are the cutscene event IDs for:
   - Iruki-Waraki AF3 start/progress/completion events (likely 782-787 range, after Operation Teatime's 778-781)
   - Shamarhaan's AF3 events in Bastok Markets (separate from default 433/435)
   - Sajhra's AF3 event in Nashmau
   - Talacca Cove battlefield entry/exit events
3. **Valkeng frame-switching**: Need to implement damage tracking system to determine which frame to switch to every 30 seconds
4. **Navukgo Execution Chamber Valkeng**: There are Valkeng+Shamarhaan mob pairs in zone 64 -- purpose unclear, may be related to a different quest or alternate battlefield version
5. **Commission system (Dhima Polevhia)**: Is this in scope? It is a significant sub-system with item trading, Vana'diel day timers, and multiple commission choices
