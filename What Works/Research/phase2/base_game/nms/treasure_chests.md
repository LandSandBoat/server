# Treasure Chest / Coffer / Casket / Pool System

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Treasure_Chest / https://www.bg-wiki.com/ffxi/Treasure_Coffer / https://www.bg-wiki.com/ffxi/Treasure_Casket
- Codebase:
  - `scripts/globals/treasure.lua` (chests and coffers framework)
  - `scripts/globals/caskets.lua` (field caskets)
  - `scripts/globals/casket_loot.lua` (casket loot tables)
  - `src/map/treasure_pool.cpp` / `treasure_pool.h` (party loot distribution)
  - `scripts/globals/abyssea/sturdypyxis/` (Abyssea pyxis system)
  - `scripts/mixins/spawn_casket.lua` (casket spawn mixin)
  - `scripts/mixins/spawn_pyxis.lua` (pyxis spawn mixin)
  - `scripts/quests/jeuno/helpers.lua` (Borghertz AF quest framework)
  - `settings/default/main.lua` (casket/chest settings)

## Summary
The treasure system is comprehensive and well-implemented. Treasure Chests and Coffers have a complete framework with spawn positions, key validation, loot tables, lockpicking, traps, and mimics across 30+ dungeons. Field Caskets spawn from mob kills with puzzle mechanics. The party treasure pool (lot/pass) is fully functional. Abyssea Sturdy Pyxis has a complete light-based reward system. AF armor from coffers works through the Borghertz quest system.

---

## 1. Treasure Chests (Locked, Need Keys)

### Checklist
| Item | Status | Notes |
|------|--------|-------|
| Framework exists | WORKS | `scripts/globals/treasure.lua` -- full implementation |
| Chests spawn in dungeons | WORKS | `xi.treasure.initZone()` called in 39+ zone Zone.lua files; spawns one chest per zone at a random position from `posTable` |
| Spawn positions defined | WORKS | Position tables cover all 30+ zones with multiple spawn points each |
| Key validation | WORKS | `keyTable` maps each zone to its required chest key item ID |
| THF lockpicking | WORKS | Thief's Tools, Living Key, Skeleton Key all supported with success/fail/trap rates in `thiefKeyInfo` |
| Trap mechanic | WORKS | Applies Weakness effect, duration scaled by player level vs zone level |
| Illusion mechanic | WORKS | Cooldown timer (30-60 min configurable) prevents re-opening same chest |
| Respawn after open | WORKS | Chest hides for ~3 min then moves to new random position |
| Gil rewards | WORKS | Formula: `members * level^2 + members * level * random(0, level)`, split among party |
| Item rewards (gems etc.) | WORKS | Weighted loot tables per zone (e.g., Garnet, Ametrine, Goshenite) |
| Map key items | WORKS | `mapTable` defines map KIs per zone (e.g., Sea Serpent Grotto map from chest) |
| Quest KI from chests | WORKS | `bypassType=2` gives KI (e.g., Crawler Blood from Crawlers' Nest chest, Fei'Yin Magic Tome from Fei'Yin) |
| Mob key drops | WORKS | Keys in `sql/mob_droplist.sql` -- e.g., Garlaige Chest Key (item 1041) at @RARE (5%) on multiple mobs |

### Zones with Treasure Chests (27 zones)
Pso'Xja, Oldton Movalpolos, Sacrarium, Fort Ghelsba, Yughott Grotto, Palborough Mines, Giddeus, Beadeaux, Davoi, Castle Oztroja, Middle/Upper Delkfutt's Tower, Castle Zvahl Baileys/Keep, Sea Serpent Grotto, King Ranperre's Tomb, Dangruf Wadi, Inner/Outer Horutoto Ruins, Ordelle's Caves, The Eldieme Necropolis, Gusgen Mines, Crawlers' Nest, Maze of Shakhrami, Garlaige Citadel, Fei'Yin, Labyrinth of Onzozo

---

## 2. Treasure Coffers (AF Armor Source)

### Checklist
| Item | Status | Notes |
|------|--------|-------|
| Framework exists | WORKS | Same `scripts/globals/treasure.lua` handles coffers |
| Coffers spawn in dungeons | WORKS | `xi.treasure.initZone()` spawns coffers alongside chests |
| Spawn positions defined | WORKS | 19 zones have coffer position tables |
| Key validation | WORKS | `keyTable` maps zones to coffer key items |
| THF lockpicking | WORKS | Different rates than chests -- 65% success, 15% fail, 10% trap, 10% mimic |
| Mimic spawns | WORKS | Uses `ID.mob.MIMIC` per zone, spawns via `npcUtil.popFromQM` |
| Gil rewards | WORKS | Same formula as chests, using zone level |
| Item rewards (gems) | WORKS | Higher-tier gems (Aquamarine, Chrysoberyl, Jadeite, Moonstone, etc.) |
| Map key items | WORKS | e.g., Boyahda Tree map, Temple of Uggalepih map, Kuftal Tunnel map |
| AF armor from coffers | WORKS | Borghertz quest system hooks into coffers via `bypassType=1` (item) and `bypassType=2` (KI) |
| Mob coffer key drops | WORKS | e.g., Garlaige Coffer Key (item 1047) drops from 8+ mob lists at @RARE/5% |
| Quest KI from coffers | WORKS | e.g., Mique's Paintbrush (Zvahl Baileys), Old Gauntlets (Borghertz), Large Trick Box (Kuftal) |

### AF Coffers (Borghertz Quests)
| Item | Status | Notes |
|------|--------|-------|
| Quest framework | WORKS | `scripts/quests/jeuno/helpers.lua` -- `BorghertzQuests` base class handles all 15 jobs |
| Quest initiation | WORKS | Talk to Guslam in Upper Jeuno; requires job lv50+, AF2 quest started/complete |
| Old Gauntlets from coffer | WORKS | `bypassType=2` gives `xi.keyItem.OLD_GAUNTLETS` from zone-specific coffer |
| Dark Spark NM fight | WORKS | Castle Zvahl Baileys -- pop from Torch, kill for Shadow Flames KI |
| AF hands reward | WORKS | Complete quest in Port Jeuno for job-specific AF hands |
| Optional AF from coffers | WORKS | `bypassType=1` gives AF body/head from coffers in secondary zones (e.g., WHM: Healer's Pantaloons from Crawlers' Nest, Healer's Cap from Garlaige) |
| All 15 jobs covered | WORKS | WAR through SMN all have individual quest scripts |

### Zones with Treasure Coffers (19 zones)
Beadeaux, Castle Oztroja, Castle Zvahl Baileys, Crawlers' Nest, Den of Rancor, Garlaige Citadel, Ifrit's Cauldron, Kuftal Tunnel, Monastic Cavern, Newton Movalpolos, Quicksand Caves, Ru'Aun Gardens, Sea Serpent Grotto, Temple of Uggalepih, The Boyahda Tree, The Eldieme Necropolis, Toraimarai Canal, Ve'Lugannon Palace, Port Jeuno

### Key AF Dungeons Spot-Checked
| Dungeon | Chest | Coffer | AF Zone | initZone Called |
|---------|-------|--------|---------|----------------|
| Garlaige Citadel | Yes (10 positions) | Yes (7 positions) | WHM Cap, BLM body, etc. | Yes |
| Castle Oztroja | Yes (13 positions) | Yes (10 positions) | WAR body, MNK hands, etc. | Yes |
| Crawlers' Nest | Yes (13 positions) | Yes (7 positions) | WHM legs, THF body, etc. | Yes |
| Eldieme Necropolis | Yes (10 positions) | Yes (9 positions) | PLD, RDM, BRD AF | Yes |
| Fei'Yin | Yes (14 positions) | No | Fei'Yin Magic Tome KI | Yes |
| Temple of Uggalepih | No | Yes (10 positions) | DRK, BST AF | Yes |

---

## 3. Field Caskets (Modern Era)

### Checklist
| Item | Status | Notes |
|------|--------|-------|
| Framework exists | WORKS | `scripts/globals/caskets.lua` -- full puzzle/chest mechanics |
| Spawn from mob kills | WORKS | `spawn_casket` mixin applied to mobs in 60+ zones via zone mixins |
| Drop rate | WORKS | 10% base (`CASKET_DROP_RATE`), modified by GoV Prowess |
| Blue caskets (unlocked) | WORKS | 85% chance; contain temp items (meds, food, etc.) |
| Brown caskets (locked) | WORKS | 15% chance; contain equipment/materials; requires number puzzle |
| Number puzzle mechanic | WORKS | Random 2-digit combo (10-99), 4-6 attempts, hint system with 7 hint types |
| Hint system | WORKS | Greater/less than, even/odd digits, digit range, specific digit hints |
| Casket loot tables | WORKS | `scripts/globals/casket_loot.lua` defines temp and item drops per zone |
| Split zone support | WORKS | Some zones (Zeruhn, Korroloka, etc.) have high/low level loot tables |
| Party ownership | WORKS | Casket tied to party leader ID, only party members can open |
| Despawn timer | WORKS | 3-minute despawn timer after spawn |
| NPC entities exist | WORKS | 961 Treasure_Casket entries in `sql/npc_list.sql` |
| Kupowers bonus | PARTIAL | Myriad Mystery Boxes commented out as "not implemented yet" |
| Evolith drops | MISSING | `casketInfo.dropTypes.EVOLITH` exists but noted "not implemented" |

---

## 4. Treasure Pool (Party Loot Distribution)

### Checklist
| Item | Status | Notes |
|------|--------|-------|
| Framework exists | WORKS | `src/map/treasure_pool.cpp` -- full C++ implementation |
| Pool types | WORKS | Solo (1), Party (6), Alliance (18), Zone (128) |
| Lot on items | WORKS | `lotItem()` -- validates inventory space, rare item check, broadcasts lot |
| Pass on items | WORKS | `passItem()` -- sets lot to 0, can override previous lot |
| Auto-resolve | WORKS | Evaluates immediately when all members lot/pass |
| Timeout handling | WORKS | 5-minute `treasure_livetime`; items auto-distributed on expiry |
| Solo auto-loot | WORKS | Solo mode: auto-distributes to player if inventory has space |
| Rare item filtering | WORKS | Won't add rare items to pool if all members already own one |
| Overflow handling | WORKS | When pool full (10 items), replaces oldest non-rare/non-ex item |
| Member join/leave | WORKS | Properly adds/removes members; cleans up lot info on leave |
| RoE integration | WORKS | Fires `ROE_EVENT::ROE_LOOTITEM` on item addition to pool |
| Random assignment | WORKS | If no one lots and timer expires, random eligible member receives item |

### Treasure Hunter Effect on Drops
| Item | Status | Notes |
|------|--------|-------|
| TH trait system | WORKS | `src/map/utils/battleutils.cpp` -- TH procs on hit |
| TH level tracking | WORKS | `m_THLvl` on mob entity tracks highest TH applied |
| TH cap | WORKS | Cap at 12 + job gifts (`TREASURE_HUNTER_CAP` mod) |
| TH proc rate | WORKS | Base proc rate with bonus from `TREASURE_HUNTER_PROC` mod |
| TH on drop rate | WORKS | `thDropRateFunction()` modifies both group and item drop rates |
| Configurable | WORKS | `DISABLE_TREASURE_HUNTER_PROCS` setting available |

---

## 5. Sturdy Pyxis (Abyssea Treasure)

### Checklist
| Item | Status | Notes |
|------|--------|-------|
| Framework exists | WORKS | `scripts/globals/abyssea/sturdypyxis/` -- 16 script files |
| Spawn from mob kills | WORKS | `spawn_pyxis` mixin fires on non-NM death in all 9 Abyssea zones |
| Light-based rewards | WORKS | `chestLightValues` defines Pearl/Ruby/Azure/Amber/Golden/Silvery/Ebon per tier (1-5) |
| Blue chests (temp items) | WORKS | `blue_chest.lua` -- temp item drops |
| Red chests | WORKS | `red_chest.lua` -- standard item drops |
| Gold chests | WORKS | `gold_chest.lua` -- high-value rewards |
| Experience chests | WORKS | `experience.lua` -- XP reward |
| Cruor chests | WORKS | `cruor.lua` -- currency reward |
| Time extension | WORKS | `time.lua` -- adds visit time |
| Restore chests | WORKS | `restore.lua` -- HP/MP recovery |
| Key item rewards | WORKS | `keyitem.lua` -- Abyssea KIs |
| Pop item rewards | WORKS | `popitem.lua` -- NM trigger items |
| Augmented items | WORKS | `augmented_item.lua` -- augment system |
| NPC entities exist | WORKS | 699 Sturdy_Pyxis entries in `sql/npc_list.sql` |
| NPC interaction | WORKS | `npc.lua` handles trade/trigger/event for pyxis |
| All 9 Abyssea zones | WORKS | La Theine, Konschtat, Tahrongi, Misareaux, Vunkerl, Attohwa, Altepa, Grauberg, Uleguerand |

---

## Blockers
- **Evolith drops from caskets**: Not implemented (minor -- evoliths are a niche system)
- **Kupowers Myriad Mystery Boxes**: Not implemented (minor -- affects casket drop rate bonus)
- **Riftworn Pyxis**: No implementation found. These are the Abyssea NM-specific treasure containers distinct from Sturdy Pyxis. NM kills in Abyssea may use Sturdy Pyxis instead.

## Fix Difficulty
- Easy (Evoliths and Kupowers are cosmetic/minor features, not core functionality)
- The core chest/coffer/casket/pool/pyxis systems are fully functional
