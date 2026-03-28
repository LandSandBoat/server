# Base Game Zone Paths -- Can a Player Walk Everywhere?

## Source
- Codebase: `sql/zonelines.sql`, `scripts/zones/*/Zone.lua`, `scripts/zones/*/npcs/*.lua`
- bg-wiki: zone connection maps

## Summary
All base game overworld and dungeon zonelines exist in zonelines.sql. Every major zone chain is traversable without GM commands. A few dungeon gates have special mechanics (Garlaige banishing gates, Eldieme gates, Oztroja passwords/levers, Quicksand Caves weight system, Sea Serpent Grotto beastcoin doors) -- all are fully scripted and functional. The Garlaige banishing gates use a **Pouch of Weighted Stones** key item (obtainable in-zone) instead of requiring 4 players, which is a deliberate solo-friendly change.

---

## San d'Oria Chain

| Transition | Zoneline | Status | Notes |
|-----------|----------|--------|-------|
| S. Sandy (230) <-> N. Sandy (231) | 230->231, 231->230 | WORKS | Standard zonelines exist |
| N. Sandy (231) -> Chateau (233) | Trigger area in Zone.lua | WORKS | Event 569, requires Rank 2 (Sandy) or Rank 3 (others) |
| Chateau (233) -> Bostaunieux Oubliette (167) | 233->167 (via NPC door) | WORKS | Zoneline 845690490 |
| Bostaunieux Oubliette (167) -> W. Ronfaure (100) | 167->100 | WORKS | Zoneline 846083194 |
| S. Sandy (230) -> E. Ronfaure (101) | 230->101 | WORKS | Zoneline 811939450 |
| S. Sandy (230) -> W. Ronfaure (100) | 230->100 | WORKS | Zoneline 845493882 |
| N. Sandy (231) -> W. Ronfaure (100) | 231->100 | WORKS | Zonelines 845559418, 946222714 |
| N. Sandy (231) -> Port Sandy (232) | 231->232 | WORKS | Zoneline 912668282 |
| Port Sandy (232) -> N. Sandy (231) | 232->231 | WORKS | Zoneline 812070522 |
| W. Ronfaure (100) <-> E. Ronfaure (101) | 100->101, 101->100 | WORKS | Multiple zonelines each direction |
| E. Ronfaure (101) -> King Ranperre's Tomb (190) | 101->190 | WORKS | Zonelines 913584762, 947139194 |
| King Ranperre's Tomb (190) -> E. Ronfaure (101) | 190->101 | WORKS | Zonelines 811677050, 845231482 |
| E. Ronfaure (101) -> Ranguemont Pass (166) | 101->166 | WORKS | Zoneline 1635005050 |
| Ranguemont Pass (166) -> E. Ronfaure (101) | 166->101 | WORKS | Zoneline 812463226 |
| Ranguemont Pass (166) -> Beaucedine Glacier (111) | 166->111 | WORKS | Zoneline 846017658 |
| W. Ronfaure (100) -> La Theine (102) | 100->102 | WORKS | Zoneline 1668493946 |
| La Theine (102) -> Ordelle's Caves (193) | 102->193 | WORKS | Zonelines 913650298, 947204730, 1635070586 |
| Ordelle's Caves (193) -> La Theine (102) | 193->102 | WORKS | Zonelines 811873658, 845428090, 878982522 |
| W. Ronfaure (100) -> Ghelsba Outpost (140) | 100->140 | WORKS | Zoneline 947073658 |
| Ghelsba Outpost (140) -> W. Ronfaure (100) | 140->100 | WORKS | Zoneline 813118330 |
| Ghelsba Outpost (140) -> Fort Ghelsba (141) | 140->141 | WORKS | Zoneline 880227194 |
| Fort Ghelsba (141) -> Ghelsba Outpost (140) | 141->140 | WORKS | Zoneline 813183866 |
| Ghelsba Outpost (140) -> Yughott Grotto (142) | 140->142 | WORKS | Zoneline 846672762 |
| Fort Ghelsba (141) -> Yughott Grotto (142) | 141->142 | WORKS | Zonelines 846738298, 880292730, 913847162 |
| Yughott Grotto (142) -> Fort Ghelsba (141) | 142->141 | WORKS | Zonelines 813249402, 846803834, 880358266 |
| Yughott Grotto (142) -> Ghelsba Outpost (140) | 142->140 | WORKS | Zoneline 913912698 |
| La Theine (102) -> Jugner Forest (104) | 102->104 | WORKS | Zoneline 846541434 |
| Jugner Forest (104) -> La Theine (102) | 104->102 | WORKS | Zoneline 813118074 |
| Jugner Forest (104) -> Batallia Downs (105) | 104->105 | WORKS | Zoneline 846672506 |
| Batallia Downs (105) -> Jugner Forest (104) | 105->104 | WORKS | Zoneline 813183610 |
| Jugner Forest (104) -> Davoi (149) | 104->149 | WORKS | Zoneline 913781370 |
| Davoi (149) -> Jugner Forest (104) | 149->104 | WORKS | Zoneline 808793210 |
| Jugner Forest (104) -> King Ranperre's Tomb (190) | 104->190 | WORKS | Zoneline 880226938 |
| Batallia Downs (105) -> Beaucedine Glacier (111) | 105->111 | WORKS | Zoneline 913846906 |
| Batallia Downs (105) -> Eldieme Necropolis (195) | 105->195 | WORKS | 8 zonelines (multiple entrances) |
| Eldieme Necropolis (195) -> Batallia Downs (105) | 195->105 | WORKS | 8 zonelines (multiple exits) |
| Batallia Downs (105) -> Upper Jeuno (244) | 105->244 | WORKS | Zoneline 880292474 |

### San d'Oria Special Access

| Feature | Status | Notes |
|---------|--------|-------|
| Chateau d'Oraguille entry | WORKS | Requires Rank 2 (Sandy) or Rank 3 (others), scripted in N. Sandy Zone.lua |
| Davoi entry from Jugner | WORKS | Open zoneline, no key required to enter |
| Davoi Wall of Dark Arts | WORKS | Requires Crest of Davoi KI (quest scripted in `scripts/quests/jeuno/Crest_of_Davoi.lua`) |
| Davoi Wall of Banishing | WORKS | Requires Crimson Orb KI (quest scripted in `scripts/quests/hiddenQuests/Crimson_Orb.lua`) |
| Davoi Elevator | WORKS | Lever scripts `_451.lua`, `_452.lua` operate elevator via `_454.lua` |
| Davoi -> Monastic Cavern (150) | WORKS | Zonelines 842347642, 875902074, 909456506, 943010938, 1630876794 |

---

## Bastok Chain

| Transition | Zoneline | Status | Notes |
|-----------|----------|--------|-------|
| Bastok Mines (234) <-> Bastok Markets (235) | 234->235, 235->234 | WORKS | Zonelines exist |
| Bastok Markets (235) <-> Port Bastok (236) | 235->236, 236->235 | WORKS | Zonelines exist |
| Bastok Markets (235) <-> Metalworks (237) | 235->237, 237->235 | WORKS | Zonelines exist |
| Bastok Markets (235) -> S. Gustaberg (107) | 235->107 | WORKS | Zoneline 879375994 |
| Bastok Mines (234) -> S. Gustaberg (107) | 234->107 | WORKS | Zoneline 812201594 |
| Bastok Mines (234) -> Zeruhn Mines (172) | 234->172 | WORKS | Zoneline 879310458 |
| Port Bastok (236) -> N. Gustaberg (106) | 236->106 | WORKS | Zoneline 812332666 |
| S. Gustaberg (107) <-> N. Gustaberg (106) | 107->106, 106->107 | WORKS | Zonelines exist both ways |
| N. Gustaberg (106) -> Palborough Mines (143) | 106->143 | WORKS | Zoneline 947466874 |
| Palborough Mines (143) -> N. Gustaberg (106) | 143->106 | WORKS | Zoneline 813314938 |
| S. Gustaberg (107) -> Dangruf Wadi (191) | 107->191 | WORKS | Zoneline 947532410 |
| N. Gustaberg (106) -> Dangruf Wadi (191) | 106->191 | WORKS | Zoneline 1635332730 |
| Dangruf Wadi (191) -> N./S. Gustaberg | 191->106, 191->107 | WORKS | Zonelines exist |
| N. Gustaberg (106) -> Konschtat (108) | 106->108 | WORKS | Zoneline 913912442 |
| Konschtat (108) -> N. Gustaberg (106) | 108->106 | WORKS | Zoneline 808465274 |
| Konschtat (108) -> Pashhow (109) | 108->109 | WORKS | Zoneline 842019706 |
| Konschtat (108) -> Gusgen Mines (196) | 108->196 | WORKS | Zoneline 909128570 |
| Gusgen Mines (196) -> Konschtat (108) | 196->108 | WORKS | Zoneline 812070266 |
| Konschtat (108) -> Valkurm Dunes (103) | 108->103 | WORKS | Zoneline 875574138 |
| Pashhow (109) <-> Konschtat (108) | 109->108 | WORKS | Zoneline 808530810 |
| Pashhow (109) -> Rolanberry (110) | 109->110 | WORKS | Zoneline 842085242 |
| Pashhow (109) -> Beadeaux (147) | 109->147 | WORKS | Zoneline 875639674 |
| Beadeaux (147) -> Pashhow (109) | 147->109 | WORKS | Zoneline 808662138 |
| Rolanberry (110) <-> Pashhow (109) | 110->109 | WORKS | Zoneline 808596346 |
| Rolanberry (110) -> Batallia Downs (105) | 110->105 | WORKS | Zoneline 842150778 |
| Rolanberry (110) -> Crawlers' Nest (197) | 110->197 | WORKS | Zonelines 942814074, 1630679930 |
| Crawlers' Nest (197) -> Rolanberry (110) | 197->110 | WORKS | Zonelines 812135802, 845690234 |
| Rolanberry (110) -> Lower Jeuno (245) | 110->245 | WORKS | Zoneline 909259642 |
| Zeruhn Mines (172) -> Bastok Mines (234) | 172->234 | WORKS | Zoneline 812856442 |
| Zeruhn Mines (172) -> Korroloka Tunnel (173) | 172->173 | WORKS | Zoneline 846410874 |

### Bastok Special Access

| Feature | Status | Notes |
|---------|--------|-------|
| Beadeaux entry from Pashhow | WORKS | Open zoneline, no key required |
| Beadeaux "The Mute" | WORKS | NPC applies Silence debuff (retail mechanic), not a blocking gate |
| Beadeaux -> Qulun Dome (148) | WORKS | Zonelines 842216570, 875771002, 909325434 |
| Qulun Dome -> Beadeaux | WORKS | Zonelines 808727674, 842282106, 875836538 |
| N. Gustaberg -> Oldton Movalpolos (11) | WORKS | Zonelines 811741306, 845295738 |
| Gusgen Mines -> Oldton Movalpolos (11) | WORKS | Zoneline (196->11) 845624698 |
| Palborough Mines -> Waughroon Shrine (144) | WORKS | Zonelines 846869370, 880423802 |

---

## Windurst Chain

| Transition | Zoneline | Status | Notes |
|-----------|----------|--------|-------|
| Windurst Waters (238) <-> W. Sarutabaruta (115) | 238->115, 115->238 | WORKS | Zonelines exist |
| Windurst Waters (238) <-> Windurst Walls (239) | 238->239, 239->238 | WORKS | Zonelines exist |
| Windurst Waters (238) <-> Port Windurst (240) | 238->240, 240->238 | WORKS | Zonelines exist |
| Windurst Walls (239) <-> Windurst Woods (241) | 239->241, 241->239 | WORKS | Zonelines exist |
| Port Windurst (240) <-> Windurst Woods (241) | 240->241, 241->240 | WORKS | Zonelines exist |
| Port Windurst (240) -> W. Sarutabaruta (115) | 240->115 | WORKS | Zoneline 812594810 |
| Windurst Woods (241) -> E. Sarutabaruta (116) | 241->116 | WORKS | Zoneline 812660346 |
| Windurst Walls (239) -> Heavens Tower (242) | Event in Zone.lua | WORKS | Event 86, no rank/nation requirement to enter tower area |
| Heavens Tower Starway Stairway | NPC _6q1.lua | WORKS | Requires Windurst citizenship + Starway Stairway Bauble KI to go upstairs |
| W. Sarutabaruta (115) <-> E. Sarutabaruta (116) | 115->116, 116->115 | WORKS | Zonelines exist both ways |
| W. Sarutabaruta (115) -> Giddeus (145) | 115->145 | WORKS | Zoneline 943141754 |
| Giddeus (145) -> W. Sarutabaruta (115) | 145->115 | WORKS | Zoneline 808531066 |
| W. Sarutabaruta (115) -> Inner Horutoto (192) | 115->192 | WORKS | Zoneline 1698116474 |
| W. Sarutabaruta (115) -> Outer Horutoto (194) | 115->194 | WORKS | Zonelines 1631007610, 1664562042 |
| E. Sarutabaruta (116) -> Inner Horutoto (192) | 116->192 | WORKS | Zoneline 1631073146 |
| E. Sarutabaruta (116) -> Outer Horutoto (194) | 116->194 | WORKS | Zonelines 943207290, 1664627578 |
| E. Sarutabaruta (116) -> Tahrongi Canyon (117) | 116->117 | WORKS | Zoneline 909652858 |
| Tahrongi (117) -> E. Sarutabaruta (116) | 117->116 | WORKS | Zoneline 809055098 |
| Tahrongi (117) -> Buburimu (118) | 117->118 | WORKS | Zoneline 909718394 |
| Tahrongi (117) -> Meriphataud (119) | 117->119 | WORKS | Zoneline 842609530 |
| Tahrongi (117) -> Maze of Shakhrami (198) | 117->198 | WORKS | Zoneline 876163962 |
| Maze of Shakhrami (198) -> Tahrongi (117) | 198->117 | WORKS | Zoneline 812201338 |
| Buburimu (118) -> Tahrongi (117) | 118->117 | WORKS | Zoneline 811676538 |
| Buburimu (118) -> Maze of Shakhrami (198) | 118->198 | WORKS | Zoneline 878785402 |
| Buburimu (118) -> Mhaura (249) | 118->249 | WORKS | Zoneline 845230970 |
| Buburimu (118) -> Labyrinth of Onzozo (213) | 118->213 | WORKS | Zoneline 912339834 |
| Meriphataud (119) -> Tahrongi (117) | 119->117 | WORKS | Zoneline 811742074 |
| Meriphataud (119) -> Sauromugue (120) | 119->120 | WORKS | Zoneline 845296506 |
| Meriphataud (119) -> Sanctuary of Zi'Tah (121) | 119->121 | WORKS | Zoneline 912405370 |
| Meriphataud (119) -> Castle Oztroja (151) | 119->151 | WORKS | Zoneline 878850938 |
| Castle Oztroja (151) -> Meriphataud (119) | 151->119 | WORKS | Zoneline 808924282 |
| Sauromugue (120) -> Meriphataud (119) | 120->119 | WORKS | Zoneline 811807610 |
| Sauromugue (120) -> Rolanberry (110) | 120->110 | WORKS | Zoneline 845362042 |
| Sauromugue (120) -> Port Jeuno (246) | 120->246 | WORKS | Zoneline 878916474 |
| Sauromugue (120) -> Garlaige Citadel (200) | 120->200 | WORKS | Zonelines 912470906, 946025338 |
| Garlaige Citadel (200) -> Sauromugue (120) | 200->120 | WORKS | Zonelines 812332410, 845886842 |
| Inner Horutoto (192) -> Toraimarai Canal (169) | 192->169 | WORKS | Zoneline 1667446138 |
| Toraimarai Canal (169) -> Inner Horutoto (192) | 169->192 | WORKS | Zoneline 812659834 |
| Windurst Walls (239) -> Toraimarai Canal (169) | 239->169 | WORKS | Zoneline 913192570 |
| Toraimarai Canal (169) -> Windurst Walls (239) | 169->239 | WORKS | Zoneline 846214266 |

### Windurst Special Access

| Feature | Status | Notes |
|---------|--------|-------|
| Castle Oztroja entry from Meriphataud | WORKS | Open zoneline |
| Castle Oztroja passwords (floor 4) | WORKS | `Brass_Statue.lua` + `globals.lua`: 3-word password from statues, trap door opens |
| Castle Oztroja lever combo (floor 2) | WORKS | `globals.lua` pickNewCombo: 4 levers, hint levers show correct state |
| Castle Oztroja torch doors | WORKS | `_47j.lua` etc: Requires Yagudo Torch KI (obtainable via Magicite mission) |
| Oztroja -> Altar Room (152) | WORKS | Zonelines 842478714, 876033146 |
| Altar Room -> Oztroja | WORKS | Zonelines 808989818, 842544250 |
| Giddeus -> Balga's Dais (146) | WORKS | Zoneline 842085498 |
| Heavens Tower upper floors | WORKS | Requires Starway Stairway Bauble (Windurst citizens) |

---

## Jeuno Chain

| Transition | Zoneline | Status | Notes |
|-----------|----------|--------|-------|
| Port Jeuno (246) <-> Lower Jeuno (245) | 246->245, 245->246 | WORKS | Zonelines exist |
| Lower Jeuno (245) <-> Upper Jeuno (244) | 245->244, 244->245 | WORKS | Zonelines exist |
| Upper Jeuno (244) <-> Ru'Lude Gardens (243) | 244->243, 243->244 | WORKS | Zonelines exist |
| Lower Jeuno (245) -> Rolanberry (110) | 245->110 | WORKS | Zoneline 812922490 |
| Port Jeuno (246) -> Sauromugue (120) | 246->120 | WORKS | Zoneline 812988026 |
| Port Jeuno (246) -> Qufim Island (126) | 246->126 | WORKS | Zoneline 880096890 |
| Qufim Island (126) -> Port Jeuno (246) | 126->246 | WORKS | Zoneline 812200826 |
| Qufim Island (126) -> Behemoth's Dominion (127) | 126->127 | WORKS | Zoneline 845755258 |
| Qufim Island (126) -> Lower Delkfutt's (184) | 126->184 | WORKS | Zoneline 879309690 |
| Upper Jeuno (244) -> Batallia Downs (105) | 244->105 | WORKS | Zoneline 812856954 |

---

## Key Dungeon Access (Special Mechanics)

### Garlaige Citadel Banishing Gates
| Item | Status | Notes |
|------|--------|-------|
| Gate #1 (`_5k0.lua`) | WORKS | Requires Pouch of Weighted Stones KI |
| Gate #2 (`_5k9.lua`) | WORKS | Requires Pouch of Weighted Stones KI |
| Gate #3 (`_5ki.lua`) | WORKS | Requires Pouch of Weighted Stones KI |
| Pouch of Weighted Stones | WORKS | Obtainable from `qm17.lua` at !pos -354 0 262 200 in Garlaige itself |
| Crematory Hatch (`_5kr.lua`) | WORKS | Requires Garlaige Key (item trade) |

**Important note:** On retail, banishing gates require 4 players to stand on pressure plates simultaneously. This server uses the Pouch of Weighted Stones KI instead, making gates solo-friendly. This is a deliberate design choice for a small-population server.

### Eldieme Necropolis Gates
| Item | Status | Notes |
|------|--------|-------|
| Intersection gates (20 gates) | WORKS | Requires Magicked Astrolabe KI OR use switch plates |
| Magicked Astrolabe | WORKS | Buy from Churano-Shurano in Windurst Waters for 10,000 gil |
| Switch plates | WORKS | Toggle groups of 5 gates, scripted in `globals.lua` |
| Brazier/Skull system | WORKS | Trade Flint Stone to unlit braziers, spawn NMs |

### Castle Oztroja Access
| Item | Status | Notes |
|------|--------|-------|
| Floor 2 lever combo door | WORKS | 4 levers, hint levers show correct combination, `globals.lua` |
| Floor 4 password trapdoor | WORKS | 3 Brass Statues give words, enter at 4th statue, `Brass_Statue.lua` |
| Torch doors (floor 3/4) | WORKS | Requires Yagudo Torch KI, scripted in `_47j.lua` through `_47z.lua` |
| Judgment Key door (`_479.lua`) | WORKS | Requires Judgment Key item + Balga Champion Certificate KI |

### Fei'Yin Access
| Item | Status | Notes |
|------|--------|-------|
| Beaucedine Glacier (111) -> Fei'Yin (204) | WORKS | Zoneline 909325178 |
| Fei'Yin (204) -> Beaucedine (111) | WORKS | Zoneline 812594554 |
| Ranguemont Pass (166) -> Beaucedine (111) | WORKS | Zoneline 846017658 |
| Beaucedine via Batallia | WORKS | Zoneline 105->111 (913846906) |

Path: E. Ronfaure -> Ranguemont Pass -> Beaucedine Glacier -> Fei'Yin. All zonelines present.

### Castle Zvahl Access
| Item | Status | Notes |
|------|--------|-------|
| Xarcabard (112) -> Castle Zvahl Baileys (161) | WORKS | Zoneline 842281850 |
| Baileys (161) -> Xarcabard (112) | WORKS | Zoneline 812135546 |
| Baileys (161) -> Castle Zvahl Keep (162) | WORKS | Zoneline 845689978 |
| Keep (162) -> Baileys (161) | WORKS | Zoneline 812201082 |
| Keep (162) -> Throne Room (165) | WORKS | Zoneline 845755514 |
| Throne Room (165) -> Keep (162) | WORKS | Zoneline 812397690 |
| Beaucedine (111) -> Xarcabard (112) | WORKS | Zoneline 842216314 |
| Xarcabard (112) -> Beaucedine (111) | WORKS | Zoneline 808727418 |

No special gate scripts found for Zvahl Baileys/Keep -- all transitions are standard zonelines. No door keys required.

### Quicksand Caves Weight System
| Item | Status | Notes |
|------|--------|-------|
| Weight-based ornate doors | WORKS | 13 doors with pressure plates, weight system in Zone.lua |
| Weight calculation | WORKS | Galka/Loadstone=3, Tarutaru=1, others=2. Need weight>=3 to open |
| Loadstone KI | WORKS | Grants weight 3 to any race (defined in `scripts/enum/key_item.lua`) |
| Holes in the Sand (drop-downs) | WORKS | 5 trigger areas that teleport player down |
| Quicksand Caves (208) <-> E. Altepa (114) | WORKS | Multiple zonelines both ways |
| Quicksand Caves (208) <-> W. Altepa (125) | WORKS | Multiple zonelines both ways |
| Chamber of Oracles (168) access | WORKS | Zonelines 208->168 exist |

**Solo concern:** A solo non-Galka player without Loadstone has weight 2, which is insufficient (need 3). Must obtain Loadstone KI or be Galka to open doors solo. With trusts, this may not work as trusts likely don't add weight. This is a potential issue for small-server play.

### Sea Serpent Grotto -> Norg Path
| Item | Status | Notes |
|------|--------|-------|
| Yuhtunga Jungle (123) -> SSG (176) | WORKS | Zoneline 845558650 |
| SSG (176) -> Yuhtunga (123) | WORKS | Zoneline 813118586 |
| SSG (176) -> Norg (252) | WORKS | Zoneline 846673018 |
| Norg (252) -> SSG (176) | WORKS | Zoneline 808466298 |
| Silver Beastcoin Door (`_4w5.lua`) | WORKS | Check door 7 times then trade Silver Beastcoin (not consumed) |
| Gold Beastcoin Door (`_4w4.lua`) | WORKS | Check door 7 times then trade Gold Beastcoin (not consumed) |
| Mythril Beastcoin Door (`_4w3.lua`) | WORKS | Check door 7 times then trade Mythril Beastcoin (not consumed) |
| Sahagin Key Door (`_4wa.lua`) | WORKS | Trade Sahagin Key (consumed). One-way from Norg side without key. |

**Note on first-time Norg access:** The standard path involves a one-way fall from Yuhtunga into SSG. The beastcoin doors allow deeper access but the basic Norg zoneline is reachable without going through locked doors. The Sahagin Key door blocks return from a specific area but the main SSG->Norg zoneline does not require it.

### Davoi Special Access
| Item | Status | Notes |
|------|--------|-------|
| Wall of Dark Arts (`_459.lua`) | WORKS | Requires Crest of Davoi KI (Jeuno quest scripted) |
| Wall of Banishing (`_45d.lua`) | WORKS | Requires Crimson Orb KI (hidden quest scripted) |
| Elevator (`_451.lua`, `_452.lua`, `_454.lua`) | WORKS | Lever-operated, fully scripted |

### Other Notable Connections
| Transition | Status | Notes |
|-----------|--------|-------|
| Sanctuary of Zi'Tah (121) -> Boyahda Tree (153) | WORKS | Zonelines 845427578, 878982010 |
| Boyahda Tree (153) -> Dragon's Aery (154) | WORKS | Zoneline 876164218 |
| Romaeve (122) -> Hall of the Gods (251) | WORKS | Zoneline 845493114 |
| Hall of the Gods (251) -> Ru'Aun Gardens (130) | WORKS | Zoneline 846870138 |
| Ru'Aun Gardens (130) -> various Sky zones | WORKS | Multiple zonelines to 177, 178, 180 |
| Korroloka Tunnel (173) -> E./W. Altepa | WORKS | Zonelines 173->114, 173->125 |
| Gustav Tunnel (212) -> Valkurm/Cape Teriggan | WORKS | Zonelines 212->103, 212->113 |
| Ifrit's Cauldron (205) -> Yuhtunga/Yhoator | WORKS | Zonelines exist both ways |

---

## Blockers
- **Quicksand Caves weight doors** may be problematic for solo non-Galka players without the Loadstone KI. Trusts likely do not contribute weight to pressure plates. Players would need to obtain the Loadstone or use a Galka character.
- **Castle Oztroja Yagudo Torch** KI is primarily obtained through the Magicite (Rank 4) mission line -- players who have not progressed missions may not have access to deeper Oztroja areas that require torches.
- **Sahagin Key** in SSG is consumed on use, requiring farming or purchasing additional keys for repeated access to that specific door.

## Fix Difficulty
- N/A -- All zone paths are functional. The weight system limitation is by design (retail behavior).

## Overall Assessment
**WORKS** -- Every base game zone is reachable via walking/zoning without GM commands. All special dungeon mechanics (gates, passwords, levers, weight system, beastcoin doors) are fully scripted and functional. The Garlaige banishing gates have been modified to be solo-friendly via the Pouch of Weighted Stones KI.
