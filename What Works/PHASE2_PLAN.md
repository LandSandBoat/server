# Phase 2 Audit — Step-by-Step Verification

## Problem with Phase 1
Phase 1 checked "does the script file exist" — that's necessary but not sufficient. A script can exist and still:
- Have broken NPC dialogue (wrong event IDs, missing text)
- Not give the correct reward items
- Not properly advance mission/quest flags
- Have broken trade handlers (item consumed but nothing happens)
- Reference NPCs that don't have scripts
- Auto-complete instead of running the actual content
- Have position/proximity checks that silently fail

## Phase 2 Methodology
For each quest/mission/system, trace the COMPLETE player path:

1. **Where do I start?** — What NPC? What zone? What prerequisite?
2. **What do I need?** — Items, key items, level, fame, prior quests?
3. **What do I do?** — Trade item? Talk to NPC? Kill mob? Enter zone?
4. **Does each step have a script?** — Not just "file exists" but does the handler do the right thing?
5. **What do I get?** — Reward items in DB? Key items granted? Flags set? Next quest unlocked?
6. **Cross-reference with bg-wiki** — Does every step match retail behavior?

## File Organization
Each file covers ONE specific quest chain or system at granular detail.

```
what works/Research/phase2/
  base_game/
    quests/
      sandoria_starter_quests.md      — First quests a new Sandy player does
      bastok_starter_quests.md
      windurst_starter_quests.md
      subjob_quest.md                 — Selbina/Mhaura unlock chain
      limit_break_1.md                — Genkai 1 (lv50→55)
      limit_break_2.md                — Genkai 2 (lv55→60)
      limit_break_3.md                — Genkai 3 (lv60→65)
      limit_break_4.md                — Genkai 4 (lv65→70)
      limit_break_5.md                — Genkai 5 (lv70→75)
      maat_cap_quest.md               — Maat fight for lv75 cap
      af_quests_war.md                — Artifact armor quest chain (per job)
      af_quests_whm.md
      ... (one per job the user plays)
    gear/
      perle_aurore_teal_upgrade.md    — Base→+1 full path
      af_reforge_109.md              — AF armor to iLvl 109 (Monisette)
      af_reforge_119.md              — AF armor to iLvl 119 (Monisette)
      relic_armor_reforge.md          — Relic armor to 109/119
      empyrean_armor_reforge.md       — Empyrean armor to 109/119
      rema_weapons.md                 — Relic/Empyrean/Mythic/Aeonic weapons full path
      magian_trials.md                — Magian trial system walkthrough
      sparks_gear.md                  — Sparks vendor gear availability
      ambuscade_gear.md               — Ambuscade reward gear
    npcs/
      sparks_vendor.md                — What can you buy? Is everything there?
      auction_house.md                — Does AH work? Stocking?
      signet_sanction_sigil.md        — Do nation buffs work?
  cop/
    each_mission_detailed.md          — Step-by-step for every COP mission
  zilart/
    each_mission_detailed.md
  toau/
    each_mission_detailed.md
  progression/
    leveling_1_to_30.md              — Can a new player level to 30?
    leveling_30_to_50.md             — Fields of Valor, parties, etc.
    leveling_50_to_75.md             — Merit parties, camps
    leveling_75_to_99.md             — Abyssea, GoV, etc.
    leveling_99_to_119.md            — iLvl gear, CP, job points
    currency_earning.md              — How to earn sparks/cruor/bayld/etc.
```

## Priority Order (based on user's current progress)
User is: Level 76, Rank 6, COP 3-4

### Immediate Priority (affects current gameplay)
1. Limit breaks (already past 75 but verify the chain works)
2. COP 3-4 through 4-x (where they are now)
3. Gear upgrades available at lv75-90 range
4. Sparks vendor — what gear is available?
5. AF quest for their main job

### Medium Priority
6. Nation quests (starter through fame)
7. Zilart missions step-by-step
8. ToAU access and early missions

### Lower Priority (future content)
9. Abyssea entry and basic loop
10. SoA access
11. ROV through chapter 1
12. Endgame gear paths

## How to Research Each Item
For each quest/mission, the agent should:
1. Fetch the bg-wiki page for the quest
2. List every step from the wiki
3. For EACH step, check the codebase:
   - Does the NPC script handle this step?
   - Does the correct dialogue/event fire?
   - Are trade items consumed correctly?
   - Are rewards granted correctly?
4. Flag any step where the code doesn't match the wiki

This is slow, thorough work. Each file may take 30-60 minutes per agent.
Batch size: 1-2 files per batch.
