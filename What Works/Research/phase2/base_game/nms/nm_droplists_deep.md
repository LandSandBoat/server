# NM Droplists Deep Audit

## Source
- bg-wiki: Individual NM pages cross-referenced
- Codebase: `sql/mob_spawn_points.sql`, `sql/mob_groups.sql`, `sql/mob_pools.sql`, `sql/mob_droplist.sql`, `sql/item_mods.sql`, `scripts/zones/*/mobs/*.lua`

## Summary
All 20 audited NMs exist in the database with spawn points, mob groups, and droplists. Most droplists match retail (bg-wiki) accurately. A few minor discrepancies exist (noted below). All key signature items have correct mods. One NM (Stroper Chyme) lacks a dedicated mob script, and one (Mysticmaker Profblix) has its script in the wrong zone folder. No show-stopping issues found.

---

## Field NMs

| NM | Zone | Spawn? | Script? | Droplist ID | Signature Drop(s) | Drops Match Retail? | Item Mods? | Status |
|----|------|--------|---------|-------------|-------------------|---------------------|------------|--------|
| Leaping Lizzy | South Gustaberg (107) | YES (17215868) | YES (`scripts/zones/South_Gustaberg/mobs/Leaping_Lizzy.lua`) | 1504 | Bounding Boots (15351) @COMMON 15% | YES - Bounding Boots, Lizard Tail, Lizard Skin all present | YES - DEF:3, DEX:3, AGI:3 | WORKS |
| Valkurm Emperor | Valkurm Dunes (103) | YES (17199438) | YES (`scripts/zones/Valkurm_Dunes/mobs/Valkurm_Emperor.lua`) | 2533 | Empress Hairpin (15224) @COMMON 15% | PARTIAL - bg-wiki says 24%+ (Very Common), server has 15% (Common) | YES - HP:-15, DEX:3, AGI:3, EVA:10 | PARTIAL |
| Stroper Chyme | Ordelle's Caves (193) | YES (17568083, 17568133) | NO dedicated script | 2349 | Shikaree Ring (15551) @VRARE 1% | YES - Shikaree Ring, Slime Oil x2, Ordelle Chest Key | YES - ACC:2, RACC:2 | PARTIAL |
| Argus | Maze of Shakhrami (198) | YES (17588674) | YES (`scripts/zones/Maze_of_Shakhrami/mobs/Argus.lua`) | 165 | Peacock Amulet (15515) @VCOMMON 24% | YES - matches bg-wiki exactly (Mercury, 2x Hecteyes Eye, Peacock Amulet) | YES - DARK_MEVA:-10, ACC:10, RACC:10 | WORKS |
| Mysticmaker Profblix | Labyrinth of Onzozo (213) | YES (17649693) | YES (`scripts/zones/Labyrinth_of_Onzozo/mobs/Mysticmaker_Profblix.lua`) | 1763 | Moldavite Earring (14724) @COMMON 15% | YES - Goblin Armor, Goblin Mask, spell group (Thunder III/IV, Thundaga III, Burst), Moldavite Earring | YES - MATT:5 | WORKS |
| Simurgh | Rolanberry Fields (110) | YES (17228242) | YES (`scripts/zones/Rolanberry_Fields/mobs/Simurgh.lua`) | 2255 | Trotter Boots (15736) @COMMON 15%, Arcana Breaker (17416) @ALWAYS | YES - Reraiser, Vile Elixir, Arcana Breaker, Trotter Boots, Damascus Ingot | YES - Trotter Boots: DEF:4, AGI:2, MOVE_SPEED:12; Arcana Breaker: weapon stats only (no item_mods, stats from item_weapon) | WORKS |
| Roc | Sauromugue Champaign (120) | YES (17269106) | YES (`scripts/zones/Sauromugue_Champaign/mobs/Roc.lua`) | 2112 | Crimson Blade (16822) @ALWAYS, Dryad Staff (18587) @COMMON | YES - Reraiser, Vile Elixir, Crimson Blade, Dryad Staff, Damascus Ingot | YES - Crimson Blade: MP:10, INT:5; Dryad Staff: MP:50, CURE_POTENCY:10 | WORKS |
| Serket | Garlaige Citadel (200) | YES (17596720) | YES (`scripts/zones/Garlaige_Citadel/mobs/Serket.lua`) | 2203 | Serket Ring (13552) @COMMON 15%, Serket Shield (12348) @COMMON 15% | PARTIAL - Missing Scorpion Claw/Shell from bg-wiki; has Venomous Claw instead. Has extra Triple Dagger not on bg-wiki. | YES - Serket Ring: DEF:3, CONVHPTOMP:50; Serket Shield: DEF:12, ICE_MEVA:-5 | PARTIAL |
| King Arthro | Jugner Forest (104) | YES (17203216) | YES (`scripts/zones/Jugner_Forest/mobs/King_Arthro.lua`) | 1449 | Velocious Belt (15899) @RARE 5%, Magic Cuisses (12924) @ALWAYS | YES - Reraiser, Vile Elixir, Magic Cuisses, Damascene Cloth x0-3, Velocious Belt | YES - Velocious Belt: HASTE_GEAR:600; Magic Cuisses: DEF:26, INT:3, MND:3 | WORKS |

### Field NM Notes
- **Valkurm Emperor**: bg-wiki lists Empress Hairpin as "Very Common (24%+)" but server has it at @COMMON (15%). Minor rate discrepancy.
- **Stroper Chyme**: No dedicated mob script (`scripts/zones/Ordelles_Caves/mobs/Stroper_Chyme.lua` does not exist). There is a `Stroper.lua` for the normal mob but not for the NM. This means Stroper Chyme will use default mob behavior -- it will still spawn and drop loot, but may lack any special NM AI/mechanics.
- **Mysticmaker Profblix**: Often confused with Davoi, but this NM is correctly placed in Labyrinth of Onzozo (zone 213), matching retail.
- **Serket**: Droplist has Venomous Claw instead of Scorpion Claw/Shell. Also includes Triple Dagger (16767) which bg-wiki does not list. Minor discrepancy but Serket Ring (the signature drop) is present and correct.
- **Classic items removed**: Peacock Charm (13056), Astral Ring (13548), and Speed Belt (13189) are NOT in any NM droplist. These were replaced in later retail updates with Peacock Amulet, Moldavite Earring, and Velocious Belt respectively. This matches modern retail behavior.

---

## HNMs

| NM | Zone | Spawn? | Script? | Droplist ID | Signature Drop(s) | Drops Match Retail? | Item Mods? | Status |
|----|------|--------|---------|-------------|-------------------|---------------------|------------|--------|
| Fafnir | Dragon's Aery (154) | YES (17408018) | YES (`scripts/zones/Dragons_Aery/mobs/Fafnir.lua`) | 805 | Ridill (16555) @VRARE 1%, Andvaranauts (14075), Aegishjalmr (13914), Balmung (16942), Hrotti (17653) | YES - All items match bg-wiki. Abjurations: Neptunal Head, Aquarian Hands, Earthen Hands, Aquarian Feet (Group 1 guaranteed + Group 2 uncommon) | YES - Ridill: weapon stats in item_weapon (DMG:40, Delay:236, 3 hits); Andvaranauts: DEF:12, INT:-7, GILFINDER; Aegishjalmr: DEF:23, HP:25; Balmung: HPP:-5, ATT:13, ACC:5; Hrotti: FIRE_MEVA:15, DMGBREATH:-1000 | WORKS |
| Nidhogg | Dragon's Aery (154) | YES (17408019) | YES (`scripts/zones/Dragons_Aery/mobs/Nidhogg.lua`) | 1781 | Wyrm Beard (1526), Abjurations: Earthen Body, Martial Body, Aquarian Body, Neptunal Legs | YES - Dragon Heart, Dragon Blood x0-2, Dragon Meat, Nidhogg's Scales x0-4, Wyrm Beard, all abjurations (Group 1 guaranteed + Group 2 uncommon) | N/A (crafting mats and abjurations) | WORKS |
| Aspidochelone | Valley of Sorrows (128) | YES (17301538) | YES (`scripts/zones/Valley_of_Sorrows/mobs/Aspidochelone.lua`) | 183 | Abjurations: Aquarian Body, Dryadic Feet, Martial Feet, Wyrmal Body | YES - Adaman Ore x1-4, Adamantoise Shell, Adamantoise Egg, Sipar, Heavy Cuirass, all abjurations | YES - Sipar: DEF:20, ICE_MEVA:-20 | WORKS |
| Adamantoise | Valley of Sorrows (128) | YES (17301537) | YES (`scripts/zones/Valley_of_Sorrows/mobs/Adamantoise.lua`) | 21 | Sipar (12361), Heavy Cuirass (13794) | YES - Adaman Ore x1-4, Sipar, Heavy Cuirass, Red Pondweed. No abjurations (correct, only Aspid drops those). | YES - Sipar: DEF:20, ICE_MEVA:-20 | WORKS |
| King Behemoth | Behemoth's Dominion (127) | YES (17297441) | YES (`scripts/zones/Behemoths_Dominion/mobs/King_Behemoth.lua`) | 1450 | Defending Ring (13566) @RARE 5% in Group 3 with Pixie Earring 95%, Abjurations: Wyrmal Head, Earthen Legs, Martial Legs, Aquarian Feet | YES - Behemoth Hide, Behemoth Horn, Behemoth Tongue, Shining Cloth, Behemoth Meat, all abjurations, Defending Ring/Pixie Earring group | YES - Defending Ring: DMG:-1000 (physical damage taken -10%) | WORKS |
| Behemoth | Behemoth's Dominion (127) | YES (17297440) | YES (`scripts/zones/Behemoths_Dominion/mobs/Behemoth.lua`) | 251 | Thundercloud (16869) 90% / Comet Tail (17294) 10% in Group 1, Savory Shank @RARE 5% | YES - Behemoth Hide x2, Savory Shank, Thundercloud/Comet Tail group | YES - Thundercloud: DEX:3, elemental resistances | WORKS |

### HNM Notes
- **Fafnir/Nidhogg**: Share spawn in Dragon's Aery. Both have complete droplists with correct abjuration groups. Ridill has 1% drop rate which is retail-accurate.
- **Defending Ring**: Correctly implemented as Group 3 with 95% Pixie Earring / 5% Defending Ring, matching retail's mutually exclusive drop mechanic.
- **Aspidochelone vs Adamantoise**: Correctly differentiated -- Aspidochelone has abjurations, Adamantoise does not. Both share Valley of Sorrows.
- **Behemoth**: Savory Shank (3342) at 5% matches the retail dev-confirmed rate.

---

## Sky NMs (Ru'Aun Gardens, zone 130)

| NM | Spawn? | Script? | Droplist ID | Signature Drop(s) | Drops Match Retail? | Item Mods? | Status |
|----|--------|---------|-------------|-------------------|---------------------|------------|--------|
| Genbu | YES (17309980) | YES (`scripts/zones/RuAun_Gardens/mobs/Genbu.lua`) | 946 | Genbu's Kabuto (12434), Genbu's Shield (12296), Seal of Genbu (1404), Arctic Wind (18161) | YES - All items match bg-wiki. Abjurations: Wyrmal Feet, Aquarian Head, Aquarian Hands, Martial Hands (Group 1 guaranteed + Group 2 uncommon). Also Venomous Claw, Adamantoise Shell, Oxblood, Adaman Ingot, Beetle Blood, Divine Log. | YES - Kabuto: DEF:35, HP:50, VIT:15; Shield: DEF:24, EVA:10, DMGPHYS:-1000, DMGRANGE:-1000 | WORKS |
| Seiryu | YES (17309981) | YES (`scripts/zones/RuAun_Gardens/mobs/Seiryu.lua`) | 2196 | Seiryu's Sword (17659), Seiryu's Kote (12690), Seal of Seiryu (1405), East Wind (18162) | YES - All items match bg-wiki. Abjurations: Wyrmal Hands, Dryadic Head, Aquarian Legs, Martial Head (Group 1 guaranteed + Group 2 uncommon). Also Dragon Talon, Dragon Blood, Dragon Meat, Damascene Cloth, Malboro Fiber, Dragon Heart. | YES - Kote: DEF:26, HP:50, AGI:15, RACC:10; Sword: WATER_MEVA:10, EVA:5 | WORKS |
| Suzaku | YES (17309983) | YES (`scripts/zones/RuAun_Gardens/mobs/Suzaku.lua`) | 2362 | Suzaku's Sune-Ate (12946), Suzaku's Scythe (18043), Seal of Suzaku (1407), Antarctic Wind (18164) | YES - All items match bg-wiki. Abjurations: Neptunal Feet, Dryadic Hands, Earthen Head, Aquarian Legs (Group 1 guaranteed + Group 2 uncommon). Also Siren's Hair x0-3, Beetle Blood, Damascene Cloth, Orichalcum Ingot, Shining Cloth, Venomous Claw. | YES - Sune-Ate: DEF:30, MND:15, FIRE_MEVA:50, additional fire effect; Scythe: FIRE_MEVA:10, ACC:5 | WORKS |
| Byakko | YES (17309982) | YES (`scripts/zones/RuAun_Gardens/mobs/Byakko.lua`) | 394 | Byakko's Haidate (12818), Byakko's Axe (18198), Seal of Byakko (1406), Zephyr (18163) | YES - All items match bg-wiki. Abjurations: Neptunal Hands, Dryadic Legs, Earthen Feet, Aquarian Head (Group 1 guaranteed + Group 2 uncommon). Also Behemoth Hide x0-2, Damascus Ingot, Divine Log, Malboro Fiber, Oxblood. | YES - Haidate: DEF:42, DEX:15, THUNDER_MEVA:50, HASTE_GEAR:500; Axe: WIND_MEVA:10, ATT:5 | WORKS |
| Kirin | YES (17506670, zone 178 Shrine of Ru'Avitau) | YES (`scripts/zones/The_Shrine_of_RuAvitau/mobs/Kirin.lua`) | 2819 | Kirin's Osode (12562), Kirin's Pole (17567) | YES - Osode and Pole at 15%, scrolls (Raise III, Quake) at 10%, crafting mats (Damascus Ingot, Orichalcum Ingot, Shining Cloth) in groups, Abjurations: Dryadic Body, Wyrmal Legs, Neptunal Body in two groups. | YES - Osode: DEF:52, MP:30, all stats +10, LIGHT_MEVA:50; Pole: HP:20, MP:20, INT:10, MND:10, all elemental MEVA +15 | WORKS |

### Sky NM Notes
- **All four sky gods** have complete and accurate droplists with proper abjuration group mechanics (guaranteed + uncommon second chance).
- **Kirin** spawns in The Shrine of Ru'Avitau (zone 178), NOT Ru'Aun Gardens. Has script and full droplist.
- **Byakko's Haidate** is one of the most sought-after items and is correctly implemented with DEX:15 and 5% Haste.
- **Kirin's Osode** has all stats +10 and is correctly one of the best body pieces in the game.

---

## Comprehensive Abjuration Coverage

All three HNM tiers and sky gods cover the full set of abjurations:

| Abjuration | Source NM | Present? |
|-----------|-----------|----------|
| Aquarian Head | Genbu, Byakko | YES |
| Aquarian Body | Nidhogg, Aspidochelone | YES |
| Aquarian Hands | Fafnir, Genbu | YES |
| Aquarian Legs | Seiryu, Suzaku | YES |
| Aquarian Feet | Fafnir, King Behemoth | YES |
| Dryadic Head | Seiryu | YES |
| Dryadic Body | Kirin | YES |
| Dryadic Hands | Suzaku | YES |
| Dryadic Legs | Byakko | YES |
| Dryadic Feet | Aspidochelone | YES |
| Earthen Head | Suzaku | YES |
| Earthen Body | Nidhogg | YES |
| Earthen Hands | Fafnir | YES |
| Earthen Legs | King Behemoth | YES |
| Earthen Feet | Byakko | YES |
| Martial Head | Seiryu | YES |
| Martial Body | Nidhogg | YES |
| Martial Hands | Genbu | YES |
| Martial Legs | King Behemoth | YES |
| Martial Feet | Aspidochelone | YES |
| Neptunal Head | Fafnir | YES |
| Neptunal Body | Kirin | YES |
| Neptunal Hands | Byakko | YES |
| Neptunal Legs | Nidhogg | YES |
| Neptunal Feet | Suzaku | YES |
| Wyrmal Head | King Behemoth | YES |
| Wyrmal Body | Aspidochelone | YES |
| Wyrmal Hands | Seiryu | YES |
| Wyrmal Legs | Kirin | YES |
| Wyrmal Feet | Genbu | YES |

All 30 abjuration pieces are obtainable. Complete coverage confirmed.

---

## Issues Found

| Issue | Severity | NM | Details |
|-------|----------|-----|---------|
| Empress Hairpin drop rate | LOW | Valkurm Emperor | bg-wiki says 24%+ (Very Common), server has 15% (Common). |
| No dedicated mob script | LOW | Stroper Chyme | No `Stroper_Chyme.lua` in Ordelle's Caves. Will use default mob behavior. NM still spawns and drops loot normally via DB. |
| Serket minor drop mismatch | LOW | Serket | Has Venomous Claw instead of Scorpion Claw/Shell. Has Triple Dagger not listed on bg-wiki. Signature drops (Serket Ring, Shield) are correct. |
| Arcana Breaker no item_mods | NONE | Simurgh | Weapon stats come from item_weapon table (DMG:34, Delay:324). No bonus mods needed -- this is normal for weapons whose power is in base stats. |
| Ridill no item_mods | NONE | Fafnir | Weapon stats from item_weapon (DMG:40, Delay:236, 3 hits). Triple attack comes from multi-hit weapon data. Working as intended. |

---

## Blockers
- None. All major NMs spawn, have droplists, and drop correct signature items with proper stats.

## Fix Difficulty
- Empress Hairpin rate: **Easy** -- change `@COMMON` to `@VCOMMON` in droplist 2533 if desired
- Stroper Chyme script: **Easy** -- create `Stroper_Chyme.lua` if custom NM behavior is wanted (lottery pop from Stroper, etc.)
- Serket drops: **Easy** -- add Scorpion Claw (897) and Scorpion Shell (896) to droplist 2203 if desired
