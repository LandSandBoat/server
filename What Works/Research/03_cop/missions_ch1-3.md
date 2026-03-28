# Chains of Promathia Missions - Chapters 1-3

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Chains_of_Promathia_Missions
- Codebase:
  - `scripts/missions/cop/1_1_The_Rites_of_Life.lua` through `3_5_Darkness_Named.lua`
  - `scripts/missions/cop/helpers.lua`
  - `scripts/battlefields/Spire_of_Dem/ancient_flames_beckon.lua`
  - `scripts/battlefields/Spire_of_Holla/ancient_flames_beckon.lua`
  - `scripts/battlefields/Spire_of_Mea/ancient_flames_beckon.lua`
  - `scripts/battlefields/Monarch_Linn/ancient_vows.lua`
  - `scripts/battlefields/The_Shrouded_Maw/darkness_named.lua`
  - `scripts/zones/Phomiuna_Aqueducts/npcs/Wooden_Ladder.lua`
  - `settings/default/main.lua` (ENABLE_COP = 1)
  - `sql/zone_settings.sql`, `sql/mob_spawn_points.sql`

## Summary
COP Chapters 1-3 (missions 1-1 through 3-5) are fully scripted with no stubs or auto-completes. All 13 missions have complete multi-step logic including cutscenes, NPC interactions, zone transitions, battlefield fights, and proper mission chaining. All required zones, NPCs, mobs, and battlefields exist in the database. Trusts are allowed in all BCNM fights, which is a significant QoL improvement for a small server.

## Checklist

### Chapter 1: Ancient Flames Beckon

| Item | Status | Notes |
|------|--------|-------|
| 1-1: The Rites of Life | WORKS | Cutscene-only mission. Enter Lower Delkfutt's from Qufim, cutscene in Upper Jeuno, talk to Monberaux. Multi-step CS chain (events 22/36/37/38/39) fully scripted. Grants Mysterious Amulet KI. Requires ENABLE_COP=1 (confirmed set). |
| 1-2: Below the Arks | WORKS | Talk to Pherimociel in Ru'Lude Gardens. Enter Promyvion via Shattered Telepoints in Konschtat/La Theine/Tahrongi. Hall of Transference cermet gates and Large Apparatus fully scripted. Complete one Promyvion (Dem, Holla, or Mea). Spire battlefield grants Light of [crag] KI. |
| 1-3: The Mothercrystals | WORKS | Complete remaining two Promyvions. Special cutscenes for 2nd/3rd Promyvion entries. On clearing all three, auto-teleports to Lufaise Meadows (Tavnazia access granted). Grants title "Ancient Flame Follower". Post-completion Shattered Telepoints still allow Hall of Transference access. |
| Promyvion-Dem zone | WORKS | Zone 18 exists in zone_settings. Regular mobs (Thinkers, etc.) spawned across floors. |
| Promyvion-Holla zone | WORKS | Zone 16 exists in zone_settings. |
| Promyvion-Mea zone | WORKS | Zone 20 exists in zone_settings. |
| Spire of Dem BCNM | WORKS | Battlefield "Ancient Flames Beckon" scripted. Boss: Progenerator + 4 adds per area (3 areas). Level cap 30, 30min, 6 players, trusts allowed. 1500 XP reward. Mob spawn points confirmed in DB. |
| Spire of Holla BCNM | WORKS | Same structure as Dem. Boss: Wreaker + adds. Level cap 30, trusts allowed. |
| Spire of Mea BCNM | WORKS | Same structure as Dem. Boss: Delver + adds. Level cap 30, trusts allowed. |

### Chapter 2: The Isle of Forgotten Saints

| Item | Status | Notes |
|------|--------|-------|
| 2-1: An Invitation West | WORKS | Zone into Lufaise Meadows for cutscene (Mysterious Amulet stolen). Zone into Tavnazian Safehold for completion. Simple 2-step mission. |
| 2-2: The Lost City | WORKS | Talk to Despachiaire in Tavnazian Safehold, then interact with sewer entrance (_0q1). Unlocks Phomiuna Aqueducts access. Post-completion NPC dialogue persists until mission 3-5. |
| 2-3: Distant Beliefs | WORKS | Kill Minotaur in Phomiuna Aqueducts (mob confirmed in DB at zone 27, ID 16887889). Climb Wooden Ladder (event 35, sets status 1->2, handled in NPC script). Interact with Ornate Gate (_0r5, status 2->3). Return to Justinius in Tavnazian Safehold to complete. |
| 2-4: An Eternal Melody | WORKS | Walnut Door cutscene in Tavnazian Safehold, grants Mysterious Amulet. Visit Dilapidated Gate on Misareaux Coast. Return to Tavnazian Safehold trigger area for completion. Unlocks Riverne Site A01 access. |
| 2-5: Ancient Vows | WORKS | Dilapidated Gate on Misareaux Coast, cutscene in Riverne Site A01. Battlefield at Monarch Linn: 3x Mammet-19 Epsilon (confirmed in DB). Level cap 40, 30min, trusts allowed. On win, teleports to South Gustaberg. Grants 1000 XP and title "Tavnazian Traveler". Entry requirement checks player did not enter from Riverne Site B01. |
| Lufaise Meadows zone | WORKS | Zone 24 in zone_settings. |
| Misareaux Coast zone | WORKS | Zone 25 in zone_settings. |
| Tavnazian Safehold zone | WORKS | Zone 26 in zone_settings. Town zone. |
| Phomiuna Aqueducts zone | WORKS | Zone 27 in zone_settings. Dungeon zone. |
| Riverne Site A01 zone | WORKS | Zone 30 in zone_settings. |
| Monarch Linn battlefield | WORKS | Zone 31 in zone_settings. Mammet-19 Epsilon mobs confirmed (9 spawns across 3 areas). |

### Chapter 3: A Transient Dream

| Item | Status | Notes |
|------|--------|-------|
| 3-1: The Call of the Wyrmking | WORKS | Cutscene in South Gustaberg (auto on zone-in after 2-5 win). Trigger area in Port Bastok. Talk to Cid in Metalworks to complete. Straightforward 3-step cutscene mission. |
| 3-2: A Vessel Without a Captain | WORKS | Talk to Cid in Metalworks (once per zone). Neptune's Spire door in Lower Jeuno, then Harnek NPC dialogue. Trigger area in Ru'Lude Gardens for completion. Checks if player has defeated Shadow Lord (nation mission). |
| 3-3: The Road Forks | WORKS | Two parallel sub-paths required (San d'Oria + Windurst). **San d'Oria path**: N. San d'Oria cutscenes, Chasalvige NPC, fight Overgrown Ivy at Carpenter's Landing (mob confirmed in DB, ID 16785709), talk to Hinaree in S. San d'Oria. **Windurst path**: Multiple NPCs in Windurst Waters/Walls/Port, Yoran-Oran quest chain, fight Lioumere at Attohwa Chasm (mob confirmed in DB, ID 16806031), timed Mimeo Jewel mechanic (30min timer with periodic messages, breaks on zone). Both paths end at status 14, then talk to Cid in Metalworks. Complex mission with extended mission status system. |
| 3-4: Tending Aged Wounds | WORKS | Talk to Cid in Metalworks (once per zone). Zone into Lower Jeuno for cutscene. Neptune's Spire door interaction to complete. Simple 3-step mission. |
| 3-5: Darkness Named | WORKS | Talk to Monberaux in Upper Jeuno (gives up Mysterious Amulet). Talk to NPCs in Lower Jeuno (Aldo, Harnek, Sattal-Mansal, Ghebi Damomohe). Trade chip to Ghebi for Pso'Xja Pass KI + 500 gil. Enter The Shrouded Maw for cutscene. **Diabolos BCNM**: Level cap 40, 30min, trusts allowed. Boss: Diabolos + 6 Diremite adds per area. Complex battlefield with falling-tile mechanic (tile animations, arena boundary tracking, Diremite enmity reset on fall, 10s Diremite respawn). On win, grants title "Transient Dreamer". Return to Monberaux to complete. |
| Attohwa Chasm zone | WORKS | Zone 7 in zone_settings. Lioumere + Cradle of Rebirth NPCs confirmed. |
| Carpenter's Landing zone | WORKS | Zone 2 in zone_settings. Overgrown Ivy + Guilloud NPC confirmed. |
| Pso'Xja zone | WORKS | Zone 9 in zone_settings. |
| The Shrouded Maw battlefield | WORKS | Zone 10 in zone_settings. Diabolos_DN mobs (3 areas x 7 mobs = 21 spawns confirmed). Tile mechanic fully implemented with boundary boxes. |

## Blockers
- None identified. All 13 missions have complete scripting with no TODOs that would block progression.
- Minor TODOs in code are cosmetic/edge-case only:
  - 1-1: TODO about pos-change resume on disconnect (does not block completion)
  - 2-3: TODO about Wooden Ladder NPC naming (handled in NPC script, works fine)
  - 3-2/3-4: TODO about Harnek duplicate door/NPC events (cosmetic only)

## Fix Difficulty
- N/A -- No fixes needed. COP Chapters 1-3 appear fully implemented.

## Notes for Small Server (1-4 players)
- All BCNMs allow trusts, which is critical for a small server:
  - Promyvion Spires: Level cap 30, trusts allowed
  - Monarch Linn (2-5): Level cap 40, trusts allowed
  - Shrouded Maw / Diabolos (3-5): Level cap 40, trusts allowed
- The Promyvion level cap of 30 may be challenging with trusts depending on which trusts are available at that level. Consider ENABLE_COP_ZONE_CAP setting (currently 0 = disabled, meaning no level cap in Promyvion zones themselves, only in the Spire BCNMs).
- Mission 3-3 (The Road Forks) is the longest mission, requiring travel to multiple cities and two NM fights. The 30-minute Mimeo Jewel timer in Attohwa Chasm could be tight for underleveled players.
