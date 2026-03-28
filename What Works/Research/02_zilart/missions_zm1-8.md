# Zilart Missions 1-8

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Rise_of_the_Zilart_Missions
- Codebase: `scripts/missions/rotz/01_The_New_Frontier.lua` through `08_Return_to_Delkfutts_Tower.lua`
- Battlefields: `scripts/battlefields/Sacrificial_Chamber/temple_of_uggalepih.lua`, `scripts/battlefields/Chamber_of_Oracles/through_the_quicksand_caves.lua`, `scripts/battlefields/Stellar_Fulcrum/return_to_delkfutts_tower.lua`

## Summary
All 8 Zilart missions (ZM1-ZM8) have full script implementations with proper NPC interactions, battlefield encounters, key item grants, and mission progression. No stubs or auto-completes found. All required NPCs, mobs, and battlefield entries exist in the database. One minor TODO noted (headstone distance check in ZM5).

## Checklist

| Mission | Status | Notes |
|---------|--------|-------|
| ZM1 - The New Frontier | WORKS | Cutscene on zoning into Norg. Requires Rank 6. Grants Map of Norg KI. Oaken Door `_700` (NPC 17809458) and Comitiolus replay CSes present. |
| ZM2 - Welcome t'Norg | WORKS | Talk to Oaken Door `_700` in Norg. Cutscene with event 2 and updateEvent for cipher display. Advances to ZM3. |
| ZM3 - Kazham's Chieftainess | WORKS | Talk to Gilgamesh in Norg (event 7), then Jakoh Wahcondalo in Kazham (event 114). Grants Sacrificial Chamber Key KI. Both NPCs exist in DB. |
| ZM4 - The Temple of Uggalepih | WORKS | Battlefield in Sacrificial Chamber vs Grav'iton mobs (3 sets of 3 + elementals + avatars). BCNM registered with `battlefield.id.TEMPLE_OF_UGGALEPIH`, 30min timer, lv75 cap, trusts allowed, 6 players. Post-battle cutscenes (events 7, 8) handle mission status progression. Grants Dark Fragment KI and title. Also handles RoV mission transition for The Cursed Temple. Note: CS blocked if Evisceration quest is active. |
| ZM5 - Headstone Pilgrimage | WORKS | Visit 7 Cermet Headstones across the world to collect elemental fragments. All 7 headstones exist in `npc_list.sql`. NM spawns at 4 locations: Ancient Weapon + Legendary Weapon (Behemoth's Dominion), Axesarion the Wanderer (Cape Teriggan), Doomed Pilgrims (Sanctuary of Zi'Tah), Tipha + Carthi (Yuhtunga Jungle). 3 locations are non-combat (Cloister of Frost, La Theine, Western Altepa). All mobs exist in `mob_spawn_points.sql`. Cooldown mechanic implemented (fight first visit, KI on return). Has a TODO for Cermet headstone distance check (minor). |
| ZM6 - Through the Quicksand Caves | WORKS | Navigate Quicksand Caves to Chamber of Oracles battlefield. BCNM vs Centurio V-III mobs (3 groups of 3). Registered with `battlefield.id.THROUGH_THE_QUICKSAND_CAVES`, 30min timer, lv75 cap, trusts allowed. Gilgamesh dialogue in Norg (event 12). All mobs confirmed in spawn points. |
| ZM7 - The Chamber of Oracles | WORKS | Place all 8 elemental fragments into pedestals in Chamber of Oracles. All 8 pedestal NPCs exist in DB (Fire, Earth, Ice, Wind, Water, Lightning, Light, Darkness). Bitmask system tracks which fragments placed (sum to 255 = all placed). Grants Prismatic Fragment KI and Lightweaver title. Handles pre-mission, active, and post-completion states. |
| ZM8 - Return to Delkfutt's Tower | WORKS | Optional Aldo cutscene in Lower Jeuno (event 104), optional zone-in CS in Lower Delkfutt's Tower (event 15), Gilgamesh dialogue in Norg (event 13). Battlefield in Stellar Fulcrum vs Kam'lanaut (3 instances). BCNM registered with `battlefield.id.RETURN_TO_DELKFUTTS_TOWER`, 30min timer, lv75 cap, trusts allowed. Post-battle completion CS (event 17). Grants Destroyer of Antiquity title. |

## Key Details

### NPCs Verified in Database
- Gilgamesh (Norg, zone 252) - NPC 17809411 at pos 122,-8,-12
- Jakoh Wahcondalo (Kazham, zone 250) - NPC 17801224 at pos 101,-15,-115
- Oaken Door `_700` (Norg) - NPC 17809458
- Aldo (Lower Jeuno, zone 245) - NPC 17310070
- 7x Cermet Headstone NPCs across 7 zones
- 8x Pedestal NPCs in Chamber of Oracles (zone 168)

### Battlefields Verified
- Sacrificial Chamber (zone 163): temple_of_uggalepih - BCNM record 128
- Chamber of Oracles (zone 168): through_the_quicksand_caves - BCNM record 192
- Stellar Fulcrum (zone 179): return_to_delkfutts_tower - BCNM record 256

### Key Items Verified in enum
- MAP_OF_NORG (417), SACRIFICIAL_CHAMBER_KEY (238)
- FIRE_FRAGMENT (239), WATER_FRAGMENT (240), EARTH_FRAGMENT (241), WIND_FRAGMENT (242)
- LIGHTNING_FRAGMENT (243), ICE_FRAGMENT (244), LIGHT_FRAGMENT (245), DARK_FRAGMENT (246)
- PRISMATIC_FRAGMENT (247)

### All Battlefield Settings
- All three BCNMs: 30min timer, lv75 cap, trusts allowed, 6-player max, no EXP loss

## Blockers
- None identified. All missions should be completable end-to-end.

## Minor Issues
- ZM5: TODO in script for Cermet headstone distance check (cosmetic, does not block completion)
- ZM4: Evisceration quest can block Jakoh Wahcondalo cutscene in Kazham (retail-accurate behavior, not a bug)

## Fix Difficulty
- N/A (all missions functional)
