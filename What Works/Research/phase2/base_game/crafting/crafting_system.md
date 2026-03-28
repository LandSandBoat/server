# Crafting System

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Crafting
- Codebase:
  - `src/map/utils/synthutils.cpp` (1380 lines) -- core synthesis engine (success/fail, skillup, HQ)
  - `src/map/utils/fishingutils.cpp` (3246 lines) -- fishing engine
  - `src/map/utils/guildutils.cpp` -- guild shop loading from DB
  - `scripts/globals/hobbies/crafting/utils.lua` -- guild table, skill utilities
  - `scripts/globals/hobbies/crafting/guild_master.lua` -- rank-up test item system
  - `scripts/globals/hobbies/crafting/guild_points.lua` -- GP turn-in, key items, GP items
  - `scripts/globals/hobbies/crafting/image_support.lua` -- imagery buffs (all 9 crafts)
  - `scripts/globals/hobbies/crafting/ephemeral_moogle.lua` -- crystal storage moogles
  - `scripts/globals/synergy.lua` (557 lines) -- synergy furnace system
  - `sql/synth_recipes.sql` -- 4,389 recipes
  - `sql/guild_shops.sql` -- 1,334 guild shop entries
  - `sql/guild_item_points.sql` -- 1,297 GP turn-in item entries
  - `sql/guilds.sql` -- 9 guilds defined
  - `sql/synergy_recipes.sql` -- 7 synergy recipes
  - `sql/fishing_*.sql` -- full fishing DB (catch, fish, rod, bait, zone, area, contest tables)
  - `settings/default/map.lua` lines 136-164 -- crafting settings

## Summary
The crafting system is comprehensively implemented. All 8 crafts have guild masters, guild point NPCs, image support NPCs, guild shops, and rank-up systems. The recipe database contains 4,389 recipes including 586 desynth recipes. Fishing has a full engine but is **disabled by default** (`FISHING_ENABLE = false`). Synergy exists but is minimal (7 recipes). Escutcheon quests are NOT implemented (items exist in DB only).

## Checklist

### Core Synthesis Engine
| Item | Status | Notes |
|------|--------|-------|
| Synthesis success/failure | WORKS | Full C++ engine in `synthutils.cpp`, checks skill vs recipe level, crystal + ingredients |
| Skill-up system | WORKS | `doSynthSkillUp()` in synthutils.cpp with logarithmic formula, respects `CRAFT_CHANCE_MULTIPLIER` and `CRAFT_AMOUNT_MULTIPLIER` settings |
| HQ system (HQ1/HQ2/HQ3) | WORKS | Three HQ tiers supported; each recipe has `ResultHQ1`, `ResultHQ2`, `ResultHQ3` with quantities; `CRAFT_HQ_CHANCE_MULTIPLIER` setting available |
| Modern skill-up system | WORKS | `CRAFT_MODERN_SYSTEM = true` (retail-style rates, skill-up within 10 levels of recipe) |
| Desynth | WORKS | 586 desynth recipes in DB; `Desynth` column in recipe table; `SYNTH_SUCCESS_RATE_DESYNTHESIS` mod supported in C++ |
| Specialization system | WORKS | `CRAFT_COMMON_CAP = 700`, `CRAFT_SPECIALIZATION_POINTS = 400` (retail values) |

### All 8 Crafts + Fishing

| Craft | Guild Master NPC | GP NPC | Image Support NPCs | Guild Shop | Status |
|-------|-----------------|--------|-------------------|------------|--------|
| Woodworking | Cheupirudaux (N. San d'Oria) | Macuillie (N. San d'Oria) | Ulycille/Amarefice/Ramua + Yudi_Yolhbi (Al Zahbi) | Yes (guildid 5132) | WORKS |
| Smithing | Ghemp (Metalworks) + Mevreauche (N. San d'Oria) | Lorena (Metalworks) + Andreas (N. San d'Oria) | Wise_Owl/Hugues/Romero + Greubaque/Pinok-Morok/Beadurinc + Macici (Al Zahbi) | Yes | WORKS |
| Goldsmithing | Reinberta (Bastok Markets) | Ellard (Bastok Markets) | Fatimah/Wulfnoth/Ulrike + Rajaaha (Al Zahbi) | Yes | WORKS |
| Clothcraft | Ponono (Windurst Woods) | Hauh_Colphioh (Windurst Woods) | Terude-Harude/Nikkoko/Anillah + Gidappa (Al Zahbi) | Yes | WORKS |
| Leathercraft | Faulpie (S. San d'Oria) | Alivatand (S. San d'Oria) | Orechiniel/Kipopo/Tek_Lengyon + Zwaluh (Al Zahbi) | Yes | WORKS |
| Bonecraft | Peshi_Yohnts (Windurst Woods) | Samigo-Pormigo (Windurst Woods) | Lih_Pituu/Ronana/Kyaa_Taali + Nudahaal (Al Zahbi) | Yes | WORKS |
| Alchemy | Abd-al-Raziq (Bastok Mines) | Hemewmew (Bastok Mines) | Azima/Titus/Sieglinde + Sulbahn/Hadayah/Shahau (Al Zahbi) | Yes | WORKS |
| Cooking | Piketo-Puketo (Windurst Waters) | Qhum_Knaidjn (Windurst Waters) | Kipo-Opo/Jacodaut/Hakeem + Numaaf (Al Zahbi) | Yes | WORKS |
| Fishing | Thubu_Parohren (Port Windurst) | Fennella (Port Windurst) | Panja-Nanja/Erabu-Fumulubu/Degong + Kemha_Flasehp (Al Zahbi) | Yes | PARTIAL |

### Recipe Database Spot Checks
| Item | Status | Notes |
|------|--------|-------|
| Bronze Ingot | WORKS | Multiple recipes (ID 10001-10005): Fire Crystal + Copper Ore x3-4 or Copper Ingot + Ore combos; Smithing skill 1-3 |
| Iron Ingot | WORKS | Recipes exist (ID 10520-11005): Fire Crystal + Iron Ore x4; Smithing skill 20-21 |
| Mythril Ingot | WORKS | Recipes exist (ID 21527-22001): Fire Crystal + Mythril Ore x4; Goldsmithing skill 38-41 |

### Guild Systems
| Item | Status | Notes |
|------|--------|-------|
| Guild shops (buy materials) | WORKS | 1,334 items across all guilds; C++ handles buy/sell via `guildutils.cpp`; dynamic pricing with min/max/quantity |
| Guild point turn-ins | WORKS | 1,297 GP items defined; daily GP contract system; full Lua implementation |
| GP key items | WORKS | All crafts have purchasable key items (purification, ensorcellment, etc.) at various rank requirements |
| GP reward items | WORKS | Belts, gloves/spectacles, aprons, signboards, rings, emblems, kits, furnishings for all crafts |
| GP HQ crystals | WORKS | All 8 HQ crystals + Robber Rig purchasable with GP |
| Rank-up exams | WORKS | Guild masters give test items at each rank; trade back signed item to advance; up to Expert rank |
| Expert quest | WORKS | Special quest for Expert rank requiring Key Item + signed test item |
| Rank renouncement | WORKS | Can renounce ranks above CRAFT_COMMON_CAP threshold; highest craft protected |
| Image Support (buff NPCs) | WORKS | Free, advanced, and dual-type support NPCs for all crafts; grants Imagery status effects |
| Ephemeral Moogles | WORKS | Crystal storage NPCs in all guild cities; 8 NPCs + Mog Garden placeholder |

### Fishing
| Item | Status | Notes |
|------|--------|-------|
| Fishing engine | PARTIAL | Full C++ engine (3,246 lines) exists; comprehensive SQL tables for fish, bait, rods, zones, areas, mobs |
| Fishing enabled | BLOCKED | `FISHING_ENABLE = false` in `settings/default/map.lua` -- **disabled by default** |
| Fishing DB tables | WORKS | `fishing_catch` (165 entries), `fishing_fish` (138), `fishing_rod` (20), `fishing_bait` (39), `fishing_zone` (294), `fishing_bait_affinity` table |
| Fishing contest | WORKS | Contest system with `fishing_contest.sql`, `fishing_contest_entries.sql`, `char_fishing_contest_history.sql`, script at `scripts/globals/fishing_contest.lua` |
| Fishing guild NPCs | WORKS | Guild master (Thubu_Parohren), GP NPC (Fennella), image support NPCs all have scripts |

### Synergy
| Item | Status | Notes |
|------|--------|-------|
| Synergy furnace script | WORKS | `scripts/zones/Bastok_Markets/npcs/Synergy_Furnace.lua` exists with full handler |
| Synergy global logic | WORKS | 557-line `scripts/globals/synergy.lua` with furnace claiming, distance checks, recipe processing |
| Synergy recipes | PARTIAL | Only 7 recipes exist (all Amateur rank): Alliance Shirt +1, Excalipoor II, Galley Kitchen, Poroggo items, White Rarab Cap +1 |
| Synergy furnace in other zones | PARTIAL | DefaultActions references in Port Bastok, Port Windurst, N. San d'Oria suggest furnaces exist there too |

### Escutcheons (Crafting Shields)
| Item | Status | Notes |
|------|--------|-------|
| Escutcheon items | PARTIAL | All 8 escutcheons exist in `item_basic.sql` (IDs 26427-26462, one per craft) |
| Escutcheon quests | MISSING | No quest scripts found; `utils.lua` references escutcheon bits (27-30) as "unknown" |
| Escutcheon stages | MISSING | No stage progression or quest chain implementation |

### Settings (defaults, no overrides present)
| Setting | Value | Notes |
|---------|-------|-------|
| CRAFT_CHANCE_MULTIPLIER | 1.0 | Retail default |
| CRAFT_AMOUNT_MULTIPLIER | 1 | Retail default |
| CRAFT_MODERN_SYSTEM | true | Retail-style skill-ups |
| CRAFT_COMMON_CAP | 700 | Retail (lv70 base before specialization) |
| CRAFT_SPECIALIZATION_POINTS | 400 | Retail (allows one craft to 110) |
| CRAFT_HQ_CHANCE_MULTIPLIER | 1.0 | Retail default |
| FISHING_ENABLE | false | **Fishing disabled** |
| FISHING_MIN_LEVEL | 1 | Default |

## Blockers
- **Fishing is disabled**: `FISHING_ENABLE = false` in default settings. No settings override file exists. To enable, create `settings/map.lua` with `FISHING_ENABLE = true`. Note the default comment says "ENABLE AT YOUR OWN RISK" suggesting possible stability concerns.
- **Escutcheon quests not implemented**: Items exist but no quest chain to obtain or upgrade them. This is a LandSandBoat upstream limitation -- these complex multi-stage quests have not been scripted.
- **Synergy is minimal**: Only 7 amateur-rank recipes. The system works mechanically but has almost no content. This is also an upstream limitation.

## Fix Difficulty
- Fishing enable: **Easy** -- create one settings override line
- Escutcheon quests: **Massive** -- complex multi-stage quest chains per craft, not implemented upstream
- Synergy recipes: **Hard** -- hundreds of recipes would need to be added to `synergy_recipes.sql`
