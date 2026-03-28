# Mob Spawns and Behavior in Key Zones

## Source
- Codebase: `sql/mob_spawn_points.sql`, `sql/mob_pools.sql`, `scripts/zones/*/mobs/`
- bg-wiki: zone mob lists cross-referenced for expected populations

## Summary
All core leveling zones (lv1-75) have healthy mob populations with appropriate level ranges and good NM scripting. Expansion endgame zones (Escha, Reisenjima) have spawn data but zero mob scripts, meaning mobs exist but rely entirely on default AI. Geas Fete and Domain Invasion systems are not implemented.

---

## Key Leveling Zones (Starter: lv1-10)

### West Ronfaure (Zone 100)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 602 total entries (86 are lv0 Astral Boxes/Spriggans) |
| Level range | WORKS | Combat mobs lv1-95; normal mobs lv1-10, high-lv entries are NMs (Marauder Dvogzog lv67, Lancing Lamorak lv94-95, Pixie lv51-54) |
| Custom mob scripts | WORKS | 18 scripts for 58 unique mob types. Key NMs scripted: Jaggedy-Eared Jack (PH system, spawn points, hunt check), Amanita, Marauder Dvogzog |
| Mob variety | WORKS | Forest Hare(86), Wild Sheep(45), Ding Bats(40), Carrion Worm(36), Tunnel Worm, Scarab Beetle, Goblin mobs, Orcish mobs |
| Issues | NONE | Population is retail-accurate |

### East Ronfaure (Zone 101)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 551 total entries (82 are lv0 Astral Boxes/Spriggans) |
| Level range | WORKS | Combat mobs lv1-95; normal mobs lv1-10, NMs up to lv95 (Sarimanok, Yilbegan, Krabkatoa, etc.) |
| Custom mob scripts | WORKS | 23 scripts for 57 unique mob types. Includes NMs: Bigmouth Billy, Capricornus, Rambukk, Swamfisk, Yacumama, Yilbegan, Krabkatoa |
| Mob variety | WORKS | Forest Hare(75), Ding Bats(41), Wild Sheep(32), Carrion Worm(30), plus Orcish and Pugil families |
| Issues | NONE | Well-populated starter zone |

### North Gustaberg (Zone 106)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 610 total entries (77 are lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-101; normal mobs lv1-10 |
| Custom mob scripts | WORKS | 21 scripts for 69 unique mob types. Key NMs: Stinging Sophie, Bedrock Barry, Gambilox Wanderling, Lamprey Lord, Shoggoth, Blobdingnag, Maighdean Uaine, Yilbegan |
| Mob variety | WORKS | Stone Eater(69), Maneating Hornet(40), Walking Sapling(40), Ding Bats(33), Quadav mobs, Rock Lizard, Vulture |
| Issues | NONE | Excellent coverage |

### South Gustaberg (Zone 107)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 604 total entries (94 are lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-99 |
| Custom mob scripts | WORKS | 21 scripts for 54 unique mob types. Key NMs: Leaping Lizzy (famous for Bounding Boots), Bubbly Bernie, Carnero, Tococo |
| Mob variety | WORKS | Stone Eater(68), Walking Sapling(49), Vulture(42), Rock Lizard(33), plus crab families and Goblins |
| Issues | NONE | |

### West Sarutabaruta (Zone 115)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 490 total entries (78 are lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-92 |
| Custom mob scripts | WORKS | 21 scripts for 61 unique mob types. Key NMs: Tom Tit Tat, Nunyenunc, Numbing Norman, Orcus, Jyeshtha, Yilbegan |
| Mob variety | WORKS | Savanna Rarab(66), Crawler(41), Carrion Crow(38), Mandragora(32), Bumblebee, Yagudo mobs |
| Issues | NONE | |

### East Sarutabaruta (Zone 116)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 573 total entries (66 are lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-97 |
| Custom mob scripts | WORKS | 13 scripts for 48 unique mob types. Key NMs: Spiny Spipi, Duke Decapod, Sharp-Eared Ropipi, Bolster |
| Mob variety | WORKS | Savanna Rarab(78), Mandragora(51), Crawler(45), Carrion Crow(41) |
| Issues | NONE | Slightly fewer scripts than other starters but all key NMs covered |

---

## Mid-Level Zones (lv10-30)

### Valkurm Dunes (Zone 103)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 515 total entries (8 are lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-95; primary leveling mobs lv10-20 |
| Custom mob scripts | WORKS | 26 scripts for 65 unique mob types. Extensive NM coverage: Valkurm Emperor (full PH system + spawn points + Magian trigger), Heike Crab, Golden Bat, Hippomaritimus, Metal Shears, Marchelute, Doman, Onryo |
| Mob variety | WORKS | Damselfly(53), Sand Hare(51), Snipper(50), Hill Lizard(42), Ghoul(36) - classic Dunes lineup |
| Issues | NONE | Excellent implementation. Ghoul script sets NO_STANDBACK correctly |

### Qufim Island (Zone 126)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 549 total entries (9 are lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-99; primary leveling mobs lv20-30 |
| Custom mob scripts | WORKS | 19 scripts for 87 unique mob types. Key NMs: Slippery Sucker, Trickster Kinetix, Ophiotaurus, Dosetsu Tree, Atkorkamuy, Qoofim, plus regular mob scripts for Clipper, Giant family, Wight, etc. |
| Mob variety | WORKS | Clipper(62), Sprinkler(39), Wight(28), Groundskeeper(24), Flamingo(22), Giant family, Dancing Weapon |
| Issues | NONE | Good population density for the primary leveling zone |

---

## Mid-High Level Zones (lv30-50)

### Garlaige Citadel (Zone 200)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 319 total entries (0 lv0 mobs) |
| Level range | WORKS | All mobs lv40-99 - appropriate for dungeon content |
| Custom mob scripts | WORKS | 31 scripts for 45 unique mob types. Very high script coverage (~69%). NMs: Serket (full implementation - rage mixin, draw-in, custom skill selection, respawn timer, immunities), Old Two-Wings, Frogamander, Skewer Sam, Guardian Statue, plus Mimic scripts |
| Mob variety | WORKS | Fortalice Bats(26), Fallen Officer(24), Siege Bat(22), Citadel Bats(22), Funnel Bats(18), beetles, undead |
| Issues | NONE | One of the best-scripted zones. Serket is a showcase NM implementation |

### Crawlers' Nest (Zone 197)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 302 total entries (0 lv0 mobs) |
| Level range | WORKS | All mobs lv40-96 |
| Custom mob scripts | WORKS | 29 scripts for 39 unique mob types. Very high coverage (~74%). NMs: Demonic Tiphia, Dynast Beetle, Aqrabuamelu, Awd Goggie, Dreadbug. Plus extensive regular mob scripts (crawlers, beetles, wasps, funguars) |
| Mob variety | WORKS | Worker Crawler(21), King Crawler(20), Vespo(20), Dancing Jewel(20), Olid Funguar(20) |
| Issues | NONE | Excellent dungeon implementation |

---

## High-Level Zones (lv50-75)

### The Boyahda Tree (Zone 153)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 475 total entries (1 lv0 mob) |
| Level range | WORKS | Combat mobs lv60-135 (high end is endgame NMs) |
| Custom mob scripts | WORKS | 26 scripts for 42 unique mob types (~62% coverage). NMs: Aquarius, Voluptuous Vivian, Ancient Goobbue, Beet Leafhopper, Ellyllon, Leshonki, Unut |
| Mob variety | WORKS | Mourioche(57), Moss Eater(44), Bark Tarantula(33), Bark Spider(30), Elder Goobbue(30) |
| Issues | NONE | |

### Gustav Tunnel (Zone 212)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 275 total entries (39 lv0 - Goblin Mines are trap entities) |
| Level range | WORKS | Combat mobs lv44-105 |
| Custom mob scripts | WORKS | 35 scripts for 42 unique mob types (~83% coverage - highest of any zone checked). NMs: Ungur, Taxim, Bune, Amikiri, Goblinsavior Heronox, Wyvernpoacher Drachlox, Baobhan Sith, Antares, Baronial Bat, Gigaplasm |
| Mob variety | WORKS | Goblin Mine(24), Doom Warlock(23), Demonic Pugil(23), Doom Guard(22), Boulder Eater(16) |
| Issues | NONE | Extremely well-scripted zone |

### Bhaflau Thickets (Zone 52)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 348 total entries (0 lv0 mobs) |
| Level range | WORKS | All mobs lv60-137 |
| Custom mob scripts | WORKS | 26 scripts for 73 unique mob types (~36% coverage). NMs: Ameretat, Nis Puk, Mahishasura. Regular mobs: Colibri family, Mamool Ja family, Troll family, Marid |
| Mob variety | WORKS | Locus Colibri(49), Aht Urhgan Attercop(23), Colibri(22), Lesser Colibri(21), Treant Sapling(17) |
| Issues | NONE | Classic ToAU colibri camp is properly populated |

---

## Expansion Zones (Spot Checks)

### Abyssea - Konschtat (Zone 15)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 409 total entries (6 lv0 special entities) |
| Level range | WORKS | Combat mobs lv74-90 - appropriate for Abyssea |
| Custom mob scripts | PARTIAL | 9 scripts for 56 unique mob types (~16% coverage). Only boss NMs have scripts: Fistule (complex AI - Dissolve mechanic, absorbs other NMs), Eccentric Eve, Hadal Satiator, Kukulkan, Turul, Bakka, Balaur, Dapifer Imp, Lachrymater |
| Mob variety | WORKS | Trotting Sapling(24), Sods Limule(24), Ley Clionid(23), Shadow Lizard(21), Morboling(17) |
| Issues | PARTIAL | Normal mobs use default AI only. NM scripts are well-implemented with custom mechanics (Fistule's absorb system is particularly good) |

### Escha - Zi'Tah (Zone 288)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 526 total entries (9 lv0 special entities) |
| Level range | WORKS | Combat mobs lv50-135 |
| Custom mob scripts | MISSING | 0 mob scripts in `scripts/zones/Escha_ZiTah/mobs/`. Zone has Zone.lua and NPC scripts (Portals, Undulating Confluence) but no mob AI at all |
| Mob variety | WORKS | Eschan Tarichuk(40), Eschan Wasp(37), Eschan Opo-opo(36), Eschan Worm(29), Eschan Puk(28) |
| Issues | PARTIAL | Mobs spawn and can be fought with default AI, but no Geas Fete NM system exists. No pop items, no NM triggers. Zone is basically a field of generic mobs with no endgame purpose |

### Reisenjima (Zone 291)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 594 total entries (14 lv0 special entities) |
| Level range | WORKS | Combat mobs lv119-129 - appropriate for endgame |
| Custom mob scripts | MISSING | 0 mob scripts in `scripts/zones/Reisenjima/mobs/`. Zone has Zone.lua and NPC scripts (Ethereal Ingress x10, ethereal droplet) but no mob AI |
| Mob variety | WORKS | Lentic Toad(52), Indomitable Faaz(35), Porxie(34), Devouring Mosquito(33), Obstreperous Panopt(32) |
| Issues | PARTIAL | Same as Escha Zi'Tah - mobs exist at correct levels but no Geas Fete system. Mobs serve as generic lv119 fodder only. No HTMB NMs, no pop system |

### Ceizak Battlegrounds (Zone 261)

| Item | Status | Notes |
|------|--------|-------|
| Mob spawn count | WORKS | 404 total entries (13 lv0 special entities) |
| Level range | WORKS | Combat mobs lv1-116 (wide range, SoA design) |
| Custom mob scripts | PARTIAL | 4 scripts for 41 unique mob types (~10% coverage). Scripts: Knotted Root, Transcendent Scorpion, Mastop, Unfettered Twitherym |
| Mob variety | WORKS | Careening Twitherym(49), Twigtrip Lapinion(37), Fernfelling Chapuli(35), Blanched Mandragora(22), Longclaw Raptor(22) |
| Issues | PARTIAL | Basic SoA field zone. Mobs spawn correctly but colonization/Wildskeeper NM systems likely incomplete |

---

## Zones With Suspiciously Few/Zero Mobs

| Zone | Count | Explanation |
|------|-------|-------------|
| Temenos (37) | 0 | Limbus zone - uses dynamic spawning system, not mob_spawn_points |
| Apollyon (38) | 0 | Limbus zone - uses dynamic spawning system, not mob_spawn_points |
| Abyssea - Empyreal Paradox (255) | 3 | Boss arena - minimal mobs expected |
| Desuetia - Empyreal Paradox (290) | 3 | Boss arena - minimal mobs expected |
| Altar Room (152) | 9 | Boss chamber for Shadow Lord fight |

All low-count zones are boss arenas, ship routes, or instanced content - no legitimate outdoor/dungeon zones have missing mobs.

---

## Missing Systems (Affecting Endgame Zones)

| System | Status | Impact |
|--------|--------|--------|
| Geas Fete | MISSING | No NM pop system for Escha Zi'Tah, Escha Ru'Aun, Reisenjima. Mobs exist but no triggered NMs |
| Domain Invasion | MISSING | Only 1 file references it (Norg NPC Zurim). No invasion spawn system |
| Wildskeeper Reives | MISSING | SoA NM system not found |
| Reisenjima Henge NMs | MISSING | Henge zone exists (Zone 292) but no Geas Fete triggers |

---

## Overall Assessment

### What Works Well
- **All core leveling zones (lv1-75)** have healthy populations with retail-accurate mob types and levels
- **NM scripts are high quality** - proper PH systems, spawn points, rage timers, custom skill selection, hunt check integration, Magian triggers
- **Dungeon zones** (Garlaige Citadel, Crawlers' Nest, Gustav Tunnel) have exceptionally high script coverage (69-83%)
- **Level ranges are correct** across all zones - no level mismatches found
- **Lv0 entries are all legitimate** - Astral Boxes, Spriggans, Goblin Mines (trap entities)
- **No empty overworld/dungeon zones** detected

### What Needs Work
- **Escha Zi'Tah and Reisenjima** have zero mob scripts - mobs exist but serve no endgame purpose without Geas Fete
- **Geas Fete system is entirely missing** - this is the primary endgame content for RoV-era
- **Domain Invasion is not implemented** - affects daily endgame activity
- **Abyssea normal mobs** rely on default AI (only boss NMs scripted)
- **SoA zones** have minimal scripting (Ceizak has only 4 scripts for 41 mob types)

## Blockers
- Geas Fete implementation would be a Massive undertaking (custom NM AI, pop item system, reward tables for dozens of NMs)
- Domain Invasion would be Hard (spawn system, timer logic, reward currency)
- Missing mob scripts in endgame zones are cosmetic - mobs still function with default AI

## Fix Difficulty
- Starter/mid zones: N/A (already working well)
- Escha/Reisenjima mob scripts: Medium (add per-mob scripts for special behavior)
- Geas Fete system: Massive (entirely new system)
- Domain Invasion: Hard (new system)
