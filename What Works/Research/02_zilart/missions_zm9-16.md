# Zilart Missions 9-16 (Endgame)

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Rise_of_the_Zilart_Missions
- Codebase:
  - `scripts/missions/rotz/09_RoMaeve.lua` through `17_Awakening.lua`
  - `scripts/battlefields/LaLoff_Amphitheater/ark_angels_1-5.lua`, `divine_might.lua`
  - `scripts/battlefields/The_Celestial_Nexus/celestial_nexus.lua`
  - `scripts/zones/LaLoff_Amphitheater/mobs/Ark_Angel_*.lua`
  - `scripts/zones/The_Celestial_Nexus/mobs/Ealdnarche.lua`, `Ealdnarche_2.lua`, `Exoplates.lua`, `Orbital.lua`
  - `scripts/quests/outlands/Divine_Might.lua`
  - `scripts/zones/Hall_of_the_Gods/npcs/Shimmering_Circle.lua`
  - `scripts/tests/missions/rotz.lua` (automated test coverage for full ZM line)
  - `sql/mob_pools.sql` (all boss mobs confirmed present)
  - `sql/zone_settings.sql` (all zones confirmed present)

## Summary
ZM9-16 (and ZM17 Awakening) are fully implemented with detailed boss AI, multi-phase battlefield scripts, proper mission progression, key item tracking, and automated test coverage. The Ark Angel fights (individual and Divine Might) and the Celestial Nexus (Eald'narche two-phase fight) are the highlights -- all have real combat mechanics, not stubs. Trusts are allowed in all battlefields.

## Checklist

| Item | Status | Notes |
|------|--------|-------|
| ZM9 - Ro'Maeve | WORKS | Talk to Aldo in Lower Jeuno, then Oaken Door in Norg. Cutscene-based, no combat. Ro'Maeve zone exists with full mob population. |
| ZM10 - The Temple of Desolation | WORKS | Visit Hall of the Gods gate `_6z0` for cutscene. Awards title SEALER_OF_THE_PORTAL_OF_THE_GODS. |
| ZM11 - The Hall of the Gods | WORKS | Examine depression in Hall of the Gods, then Oaken Door in Norg. Cutscene mission. |
| ZM12 - The Mithra and the Crystal | WORKS | Multi-step: Maryoh Comyujah in Rabao, spawn/kill Ancient Vessel in Quicksand Caves for Scrap of Papyrus KI, return for Cerulean Crystal KI, then use at Shimmering Circle in Hall of the Gods. All NPCs, mobs, KIs scripted. Ancient Vessel in mob_pools. |
| ZM13 - The Gate of the Gods | WORKS | Zone into Ru'Aun Gardens for auto-cutscene. Unlocks Sky access via Shimmering Circle (requires ZM13+ complete). Zone confirmed in zone_settings. |
| ZM14 - Ark Angels (Individual) | WORKS | 5 separate battlefields in La'Loff Amphitheater. Each fight awards a shard KI (Apathy/Cowardice/Envy/Arrogance/Rage). All 5 must be collected. 6-player cap, Lv75 cap, 30min, trusts allowed. All 5 Ark Angel mob scripts have detailed AI: immunities, job specials (Mighty Strikes, Mijin Gakure, Benediction, Invincible, Blood Weapon, Manafont), pet spawns (Tiger/Mandragora for MR, Wyvern for GK), teleport behavior (TT). |
| ZM14 - Divine Might (all 5 at once) | WORKS | Alternative path via `Divine_Might.lua` quest. Requires Ark Pentasphere (crafted at Qu'Hau Spring in Ro'Maeve during full moon). 18-player cap, Lv99 cap, 30min, trusts allowed. Awards all 5 shards at once. Earring reward (Suppanomimi/Knight's/Abyssal/Beastly/Bushinomimi) on quest completion. Has repeat quest support. |
| ZM15 - The Sealed Shrine | WORKS | Cutscene chain: Oaken Door in Norg, Aldo in Lower Jeuno, then zone into Shrine of Ru'Avitau for Lion cutscene. |
| ZM16 - The Celestial Nexus | WORKS | Two-phase boss fight vs Eald'narche. Phase 1: Eald'narche is unkillable/shielded until Exoplates are destroyed (3 phase shifts at 66%/33%/1% HP). Exoplates have unique scripted phase-shift TP moves. Orbitals spawn continuously. Phase 2: Eald'narche transforms with 60% fast cast, -75% phys damage, regain, teleport behavior. 6-player, Lv75 cap, 30min, trusts allowed. On win, player teleported to Hall of the Gods. Awards title BURIER_OF_THE_ILLUSION. |
| ZM17 - Awakening (epilogue) | WORKS | Post-completion epilogue. Optional cutscenes in Norg and Lower Jeuno. Uses bitfield-based mission status to track which cutscenes have been viewed. Leads to THE_LAST_VERSE. |
| Sky Access (Shimmering Circle) | WORKS | `Hall_of_the_Gods/npcs/Shimmering_Circle.lua` checks ZM13+ completion to allow teleport to Ru'Aun Gardens. |
| Zone Availability | WORKS | All zones confirmed in zone_settings.sql: RoMaeve (122), Ru'Aun Gardens (130), La'Loff Amphitheater (180), The Celestial Nexus (181), Hall of the Gods (251). |
| Mob Data | WORKS | All boss mobs in mob_pools.sql: Ancient Vessel, all 5 Ark Angels + pets, Ealdnarche (phase 1+2), Exoplates, Kamlanaut. |
| Automated Tests | WORKS | `scripts/tests/missions/rotz.lua` has end-to-end test coverage for ZM9 through ZM17 including battlefield wins, KI checks, and zone transitions. |

## Blockers
- None identified. The entire ZM9-16 line appears fully functional.

## Notes
- Ark Angel EV has a TODO comment: "Shield Bash every 10 seconds" -- but Shield Strike is implemented at 17-second intervals, so the mechanic exists even if timing differs slightly from the TODO note.
- Divine Might uses a forever charVar (`DM_Earring`) to track earring choice, with a TODO to find a better approach. This is cosmetic/tracking only and does not affect functionality.
- All battlefields allow trusts, which is important for a small (max 4 player) server.
- The Lv75 cap on Ark Angels individual fights and Celestial Nexus is retail-accurate for the original era versions.
- Divine Might is Lv99 cap (uncapped), which matches the modern retail version.

## Fix Difficulty
- N/A -- everything works.
