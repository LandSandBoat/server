# Mog House and Storage Systems

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Mog_House
- bg-wiki: https://www.bg-wiki.com/ffxi/Mog_Garden
- Codebase:
  - `scripts/globals/moghouse.lua` -- core mog house logic, locker management, exits, 2F unlock
  - `scripts/globals/mog_garden.lua` -- mog garden zone logic (stub)
  - `scripts/globals/porter_moogle.lua` -- porter moogle storage slip system
  - `scripts/globals/porter_slip_items.lua` -- slip item definitions
  - `scripts/globals/festive_moogle.lua` -- mog pell reward system
  - `scripts/quests/otherAreas/Give_a_Moogle_a_Break.lua` -- mog safe expansion 1
  - `scripts/quests/otherAreas/The_Moogles_Picnic.lua` -- mog safe expansion 2
  - `scripts/quests/otherAreas/Moogles_in_the_Wild.lua` -- mog safe expansion 3
  - `scripts/quests/jeuno/The_Gobbiebag_Part_I.lua` through `Part_X.lua` -- inventory expansion
  - `scripts/quests/jeuno/helpers.lua` -- gobbiebag quest framework
  - `scripts/quests/sandoria/Growing_Flowers.lua` -- exit quest (San d'Oria)
  - `scripts/quests/bastok/A_Ladys_Heart.lua` -- exit quest (Bastok)
  - `scripts/quests/windurst/Flower_Child.lua` -- exit quest (Windurst)
  - `sql/char_storage.sql` -- container size defaults
  - `sql/item_furnishing.sql` -- furniture/moghancement data (~520 rows)
  - `sql/gardening_results.sql` -- gardening outcome data (~2450 rows)
  - `src/map/utils/gardenutils.cpp` -- C++ gardening engine
  - `src/map/items/item_flowerpot.cpp` -- flowerpot item handling
  - `src/map/items/item_furnishing.cpp` -- furniture system
  - `src/map/utils/dboxutils.cpp` -- delivery box C++ backend
  - `settings/default/main.lua` -- START_INVENTORY=30, EQUIP_FROM_OTHER_CONTAINERS=false

## Summary
The Mog House core systems are well-implemented. Players can enter mog houses in all nations plus Jeuno, Whitegate, and Adoulin. Storage expansion quests (Gobbiebag I-X, Mog Safe expansions) are fully scripted. Mog Locker, delivery box, furniture/moghancement, gardening, and porter moogles all have working implementations. Mog Garden exists as a zone but is a **stub** with no gathering/tutorial quests. Mog Pell system is implemented via the festive moogle scripts.

## Checklist

### 1. Mog House Access
| Item | Status | Notes |
|------|--------|-------|
| San d'Oria mog house | WORKS | All 3 areas (S/N/Port) defined in `moghouse.lua` exits table |
| Bastok mog house | WORKS | All 3 areas (Mines/Markets/Port) defined, Markets has 2 entrances |
| Windurst mog house | WORKS | All 4 areas (Waters/Walls/Port/Woods) defined |
| Jeuno mog house | WORKS | All 4 areas (Ru'Lude/Upper/Lower/Port) defined |
| Whitegate mog house | WORKS | Defined in exits table |
| Al Zahbi mog house | WORKS | Defined in exits table |
| Adoulin mog house | WORKS | Both Western and Eastern Adoulin defined |
| Past-era mog houses | WORKS | S.Sandy[S], Bastok[S], Windurst[S] all defined |
| Mog House 2F unlock | WORKS | Unlocks after completing all 3 exit quests; CS IDs defined for all 10 home zones |
| Exit quests (Growing Flowers, A Lady's Heart, Flower Child) | WORKS | Scripts exist; tracked via moghouseFlag bits 0x0001-0x0004 |
| Mog House healing/job change | WORKS | Core engine feature; status effects cleared on zone-in |
| Mog House music (Orchestrion/Spinet) | WORKS | `trySetMusic()` handles furniture-based music selection |

### 2. Mog Safe
| Item | Status | Notes |
|------|--------|-------|
| Basic Mog Safe | WORKS | Default 50 slots per `char_storage.sql` |
| Give a Moogle a Break (expansion 1) | WORKS | Requires fame 3, bed placed. Adds 10 slots to both Safe and Safe2 |
| The Moogle's Picnic (expansion 2) | WORKS | Requires fame 5 + quest 1 complete. Adds 10 more slots |
| Moogles in the Wild (expansion 3) | WORKS | Requires fame 7 + quest 2 complete. Adds 10 more slots |
| Mog Safe 2 | WORKS | Unlocked with 2F after all 3 exit quests complete |

### 3. Mog Locker
| Item | Status | Notes |
|------|--------|-------|
| Mog Locker unlock | WORKS | `moghouse.lua` has `unlockMogLocker()` -- sets 30 slots |
| Mog Locker lease/renewal | WORKS | Rent via Imperial Bronze Pieces; 7 days/coin (Alzahbi) or 5 days/coin (all areas) |
| Mog Locker access types | WORKS | Alzahbi-only vs all-areas, tracked via char var |
| Locker lease expiry | WORKS | Timestamp-based system with auto-expire detection |
| Locker default size | WORKS | Default 0 in `char_storage.sql`, set to 30 on unlock |

### 4. Mog Satchel / Sack / Case
| Item | Status | Notes |
|------|--------|-------|
| Mog Satchel | WORKS | Default 0 slots in DB. Expands alongside inventory via Gobbiebag quests |
| Mog Sack | PARTIAL | Default 0 slots in DB. Container exists in engine. No quest/unlock script found to enable it |
| Mog Case | WORKS | Default 80 slots in `char_storage.sql` -- auto-enabled |

### 5. Mog Wardrobe 1-4 (and 5-8)
| Item | Status | Notes |
|------|--------|-------|
| Wardrobe 1 | WORKS | Default 80 slots in `char_storage.sql` |
| Wardrobe 2 | WORKS | Default 80 slots |
| Wardrobe 3 | WORKS | Default 80 slots |
| Wardrobe 4 | WORKS | Default 80 slots |
| Wardrobe 5-8 | WORKS | Default 80 slots each (server gives all 8 by default) |
| Equip from Satchel/Sack/Case | PARTIAL | Setting `EQUIP_FROM_OTHER_CONTAINERS` exists but is `false` by default. Requires client addon |

### 6. Storage Expansion (Gobbiebag)
| Item | Status | Notes |
|------|--------|-------|
| Gobbiebag Part I (30->35) | WORKS | Full quest script with NPC Bluffnix in Lower Jeuno |
| Gobbiebag Part II (35->40) | WORKS | Script exists |
| Gobbiebag Part III (40->45) | WORKS | Script exists |
| Gobbiebag Part IV (45->50) | WORKS | Script exists |
| Gobbiebag Part V (50->55) | WORKS | Script exists |
| Gobbiebag Part VI (55->60) | WORKS | Script exists |
| Gobbiebag Part VII (60->65) | WORKS | Script exists |
| Gobbiebag Part VIII (65->70) | WORKS | Script exists |
| Gobbiebag Part IX (70->75) | WORKS | Script exists |
| Gobbiebag Part X (75->80) | WORKS | Script exists |
| Satchel auto-expand | WORKS | Gobbiebag helper expands satchel alongside inventory if satchel >0 |
| GM command (!setbag) | WORKS | `scripts/commands/setbag.lua` allows GMs to set bag 30-80 |

### 7. Porter Moogles
| Item | Status | Notes |
|------|--------|-------|
| Porter Moogle NPCs | WORKS | Scripts in 17 zones: all nations, Jeuno, Whitegate, Adoulin, Tavnazia, Selbina, etc. |
| Storage slips 1-28 | WORKS | All 28 slips defined in `porter_moogle.lua` |
| Store items on slip | WORKS | Full bitmask-based storage system |
| Retrieve items from slip | WORKS | With proper extra-data tracking |
| Buy slips (1000 gil each) | WORKS | Purchase logic in `onEventFinish` |

### 8. Mog Garden
| Item | Status | Notes |
|------|--------|-------|
| Zone exists | WORKS | Zone 280, player can zone in |
| Green Thumb Moogle | PARTIAL | NPC exists. Opens mog house menu and seed shop. No garden-specific features |
| Mog Dinghy | WORKS | NPC exists for transport |
| Porter Moogle | WORKS | NPC exists in Mog Garden |
| Gathering (mining/logging/harvesting) | MISSING | No NPCs (Kuyin Hathdenna, Yeestog, Susuroon) or gathering scripts |
| Tutorial quests (Full Fields, etc.) | MISSING | No quest scripts for the 13-quest tutorial series |
| Monster Rearing | MISSING | No Chacharoon NPC or rearing system |
| GPS Crystal system | MISSING | TODO comment in `mog_garden.lua` for GPS announcements |
| Flotsam collection | MISSING | No beach pickup system |
| Per-player NPC visibility | MISSING | TODO comment notes system needed to show/hide NPCs per player |

### 9. Gardening
| Item | Status | Notes |
|------|--------|-------|
| Gardening system (C++) | WORKS | Full implementation in `gardenutils.cpp` with wilt timers, result calculations |
| Flower pot items | WORKS | `item_flowerpot.cpp` handles plant/check/crop/stop packets |
| Gardening results DB | WORKS | `gardening_results.sql` with ~2450 result entries |
| Gardening settings | WORKS | `map.lua` has GARDEN_DAY_MATTERS, GARDEN_MOONPHASE_MATTERS, GARDEN_POT_MATTERS, GARDEN_MH_AURA_MATTERS |
| Plant in mog house | WORKS | Packets `0x0fc` (plant add), `0x0fd` (plant check), `0x0fe` (crop), `0x0ff` (stop) all handled |

### 10. Furniture / Moghancement
| Item | Status | Notes |
|------|--------|-------|
| Furniture placement | WORKS | `item_furnishing.cpp` handles layout packet `0x0fa` |
| Furniture database | WORKS | `item_furnishing.sql` with ~490 furniture items defined |
| Moghancement field | WORKS | Column exists in `item_furnishing.sql` schema |
| Storage (up to 80 slots via furniture) | WORKS | Core engine feature |

### 11. Delivery Box
| Item | Status | Notes |
|------|--------|-------|
| Delivery box backend | WORKS | Full C++ implementation in `dboxutils.cpp` |
| Send items between characters | WORKS | Insert/send/confirm/retrieve all implemented |
| NODELIVERY flag check | WORKS | Items flagged as no-delivery are blocked |
| Delivery box SQL | WORKS | `delivery_box` table with triggers |

### 12. Mog Pell
| Item | Status | Notes |
|------|--------|-------|
| Mog Pell items | WORKS | 7 types: Gold, Red, Green, Ochre, Marble, Rainbow, Silver |
| Festive Moogle NPC | PARTIAL | Script exists in `festive_moogle.lua` with full reward tables, but no Festive_Moogle NPC scripts found in any zone. May need seasonal event activation |
| Pell purchase from sparks vendor | WORKS | Available in `shop.lua` for 10000 sparks each (requires Rhapsody in White KI) |
| Pell rewards | WORKS | Full reward tables for all 7 pell types including equipment, furnishing, and materials |

## Blockers
- **Mog Garden** is the primary blocker. The zone loads but has almost no functionality. No gathering NPCs, no tutorial quests, no monster rearing. Players can enter but cannot do anything beyond accessing mog house menu and buying seeds.
- **Mog Sack** has 0 default slots and no visible unlock mechanism in the scripts. On retail this was a special service (PlayOnline/FFXI Token). May need GM intervention (`!changeContainerSize`) to enable.
- **Festive Moogle NPC** scripts are not found in any zone -- the reward logic exists but the NPC may only appear during seasonal events or may need manual spawning.

## Fix Difficulty
- Mog House core: N/A (already works)
- Mog Garden: **Massive** -- needs full implementation of gathering system, 13 tutorial quests, monster rearing, NPC per-player visibility
- Mog Sack unlock: **Easy** -- could add a GM command or auto-grant on character creation by changing default in `char_storage.sql`
- Festive Moogle activation: **Easy** -- likely just needs seasonal event toggle or NPC spawn script
