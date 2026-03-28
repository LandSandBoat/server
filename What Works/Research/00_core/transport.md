# Transport Systems

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Transportation
- Codebase: scripts/globals/teleports.lua, scripts/globals/chocobo.lua, scripts/globals/homepoint.lua, scripts/globals/teleports/survival_guide.lua, scripts/globals/unity.lua, scripts/globals/waypoint.lua, scripts/globals/maws.lua, scripts/globals/abyssea.lua, scripts/globals/teleports/eschan_portals.lua, scripts/globals/conquest.lua, scripts/quests/full_speed_ahead.lua

## Summary
Most transport systems are fully implemented. Airships, ferries, chocobo rentals, survival guides, home points, unity warps, outpost warps, teleport spells, cavernous maws, waypoints, runic portals, Escha portals, and Abyssea entry all have complete scripts. Mounts and chocobo raising are also implemented. The server covers essentially every retail transport method.

## Checklist

### Airships (San d'Oria / Bastok / Windurst / Kazham to Jeuno)

| Item | Status | Notes |
|------|--------|-------|
| San d'Oria-Jeuno Airship | WORKS | Zone scripts exist (scripts/zones/San_dOria-Jeuno_Airship/), NPCs Nigel and Ricaldo present. Port San d'Oria and Port Jeuno Zone.lua handle onTransportEvent properly. Requires Airship Pass key item. |
| Bastok-Jeuno Airship | WORKS | Zone scripts exist (scripts/zones/Bastok-Jeuno_Airship/), NPCs Dereck and Michele. Port Bastok and Port Jeuno handle transport events. |
| Windurst-Jeuno Airship | WORKS | Zone scripts exist (scripts/zones/Windurst-Jeuno_Airship/), NPCs Gabriele and Mauricio. Port Windurst and Port Jeuno handle transport events. |
| Kazham-Jeuno Airship | WORKS | Zone scripts exist (scripts/zones/Kazham-Jeuno_Airship/), NPCs Joosef and Oslam. Requires Airship Pass for Kazham key item. |
| Boarding NPCs (ticket counters) | WORKS | Counter NPCs exist in all port zones (e.g. Port_Jeuno npcs: _6u4, _6u8, _6ua, _6ue, Zedduva, Purequane, Gavin, Guddal). 200 gil per trip. |

### Ferries

| Item | Status | Notes |
|------|--------|-------|
| Selbina-Mhaura Ferry | WORKS | Full implementation: Ship_bound_for_Selbina/, Ship_bound_for_Mhaura/ zones with mobs (Sea Horror, Sea Monk, Enagakure) and NPCs. Pirate variant zones also exist. Mhaura Zone.lua has pirate random chance (10%). 100 gil ticket. |
| Nashmau-Al Zahbi (Silver Sea) | WORKS | Silver_Sea_route_to_Nashmau/ and Silver_Sea_route_to_Al_Zahbi/ zones implemented with NPCs and mobs. Nashmau Zone.lua checks for SILVER_SEA_FERRY_TICKET key item. |
| Mhaura-Al Zahbi (Open Sea) | WORKS | Open_sea_route_to_Al_Zahbi/ and Open_sea_route_to_Mhaura/ zones implemented with mobs (Gugru Orobon, Piranu) and NPCs. Requires boarding permit from ToAU mission 1. |
| Manaclipper (Bibiki Bay) | WORKS | scripts/zones/Manaclipper/ exists with mobs and NPCs. Bibiki Bay Zone.lua has trigger areas for dock boarding. |
| Phanauet Channel | WORKS | scripts/zones/Phanauet_Channel/ exists with mobs and NPCs. Carpenters Landing Zone.lua handles transport events. |

### Chocobo Rentals

| Item | Status | Notes |
|------|--------|-------|
| Chocobo rental system | WORKS | scripts/globals/chocobo.lua implements full rental system. Requires Chocobo License key item. Level 15 in nations, level 20 elsewhere. Gil cost with dynamic pricing. Chocopass/Chocobo Ticket items supported. |
| San d'Oria renter (Camereine) | WORKS | scripts/zones/Southern_San_dOria/npcs/Camereine.lua calls xi.chocobo.renterOnTrigger. |
| Bastok renter | WORKS | Bastok Mines chocobo zone entry in xi.chocobo.chocoboInfo table. |
| Windurst renter | WORKS | Windurst Woods chocobo zone entry in xi.chocobo.chocoboInfo table. |
| Jeuno renters | WORKS | Upper Jeuno, Lower Jeuno, and Port Jeuno all have entries in chocoboInfo. |
| Field renters (various) | WORKS | chocoboInfo covers 22 zones including La Theine, Konschtat, Tahrongi, E. Altepa, Yhoator, Kazham, Norg, Rabao, Al Zahbi, Wajaom. |
| Past zone renters (WotG) | WORKS | Past zones (S. San d'Oria [S], Bastok Markets [S], Windurst Waters [S], and past field zones) included. Requires WotG mission completion. Uses Allied Notes currency. |

### Chocobo Raising

| Item | Status | Notes |
|------|--------|-------|
| Chocobo raising system | WORKS | scripts/globals/chocobo_raising.lua is a substantial implementation. Includes egg hatching, growth stages (chick at day 4, adolescent at day 19), care plans, walking, feeding. VCS trainers in all 3 nations. |
| Chocobo names | WORKS | scripts/globals/chocobo_names.lua provides naming system. |
| Chocobo racing | WORKS | scripts/globals/chocobo_racing.lua and scripts/globals/chocobo_riding_game.lua exist. |

### Outpost Warps

| Item | Status | Notes |
|------|--------|-------|
| Outpost warp system | WORKS | scripts/globals/conquest.lua has full outpost teleport logic. Checks region ownership, supply quest completion, level requirements. |
| Supply run quests | WORKS | Supply run bitmask system implemented in conquest.lua. One supply run per Vana'diel day. |
| UNLOCK_OUTPOST_WARPS setting | WORKS | Default is 0 (retail behavior). Set to 1 for all base outposts unlocked, 2 for all including Tu'Lia/Tavnazia. Currently 0 in settings/default/main.lua. |
| Region coverage | WORKS | All 16 conquest regions from Ronfaure through Tavnazian Archipelago defined in conquest data table with zone, KI, CP cost, level req, and fee. |

### Survival Guides

| Item | Status | Notes |
|------|--------|-------|
| Survival Guide system | WORKS | scripts/globals/teleports/survival_guide.lua and survival_guide_map.lua implement full system. Registration on first touch, teleport menu with favorites, expansion-aware (COP/TOAU/WOTG/SOA flags). |
| NPC placement | WORKS | 95+ Survival_Guide.lua NPC files across zones. Covers cities, dungeons, field zones, past zones, ToAU zones, and Adoulin. |
| Cost | WORKS | 1000 gil or 50 Valor Points (reduced with Rhapsody in White). |

### Home Points

| Item | Status | Notes |
|------|--------|-------|
| Home Point system | WORKS | scripts/globals/homepoint.lua implements full warp system with group-based fee structure. Extensive destination table covering all cities, Jeuno, Kazham, Mhaura, Norg, Selbina, Rabao, Tavnazia, Whitegate, Nashmau, Adoulin, and more. |
| NPC placement | WORKS | HomePoint#N.lua NPC files exist in zone directories (e.g. Southern San d'Oria has HomePoint#1 through #4). |
| Fee structure | WORKS | Free within same group (city), fee multiplier for cross-city warps. |

### Unity Warps

| Item | Status | Notes |
|------|--------|-------|
| Unity Concord system | WORKS | scripts/globals/unity.lua implements full warp system. 30 warp destinations across all major field zones. NPCs in San d'Oria, Bastok, Windurst, and Adoulin. |
| Unity join/registration | WORKS | Event IDs for all 4 cities defined. Requires 10 RoE objectives and All for One flag. |
| Warp destinations | WORKS | 30 destinations from E. Ronfaure through Reisenjima, covering base game, CoP, ToAU, WotG, SoA, and RoV zones. Costs 100 Unity Accolades. |
| Forced rank fix | WORKS | Per project memory: rank forced to 1 in packet 0x061 so all warps available regardless of ranking. Custom server fix. |

### Teleport Spells

| Item | Status | Notes |
|------|--------|-------|
| Spell framework | WORKS | scripts/globals/spells/enhancing_teleport.lua handles all teleport/warp/recall spells via a unified pTable lookup. |
| Teleport-Dem | WORKS | Requires Dem Gate Crystal key item. 4 second cast. |
| Teleport-Holla | WORKS | Requires Holla Gate Crystal key item. |
| Teleport-Mea | WORKS | Requires Mea Gate Crystal key item. |
| Teleport-Vahzl | WORKS | Requires Vahzl Gate Crystal key item. |
| Teleport-Yhoat | WORKS | Requires Yhoator Gate Crystal key item. |
| Teleport-Altep | WORKS | Requires Altepa Gate Crystal key item. |
| Warp / Warp II | WORKS | Returns to home point. No key item required. 3 second cast. |
| Escape | WORKS | Exits dungeon. No key item required. 4 second cast. |
| Recall-Jugner | WORKS | Requires Jugner Gate Crystal key item. |
| Recall-Pashh | WORKS | Requires Pashhow Gate Crystal key item. |
| Recall-Meriph | WORKS | Requires Meriphataud Gate Crystal key item. |
| Retrace | WORKS | Returns to past nation city. Requires campaign allegiance. 3 second cast. |

### Dimensional Portals (Sea Access)

| Item | Status | Notes |
|------|--------|-------|
| Konschtat Highlands portal | WORKS | scripts/zones/Konschtat_Highlands/npcs/Dimensional_Portal.lua teleports to Al'Taieu. Requires COP mission progress past The Warrior's Path. |
| Tahrongi Canyon portal | WORKS | scripts/zones/Tahrongi_Canyon/npcs/Dimensional_Portal.lua. Same COP mission requirement. |
| Al'Taieu portal (return) | WORKS | scripts/zones/AlTaieu/npcs/Dimensional_Portal.lua exists. |

### Undulating Confluences / Escha Zone Access

| Item | Status | Notes |
|------|--------|-------|
| Qufim Island confluence (to Escha Zi'Tah) | WORKS | scripts/zones/Qufim_Island/npcs/Undulating_Confluence.lua. Requires RoV mission "Set Free" or later. |
| Misareaux Coast confluence (to Escha Ru'Aun) | WORKS | scripts/zones/Misareaux_Coast/npcs/Undulating_Confluence.lua. No explicit mission gate in script (may be handled elsewhere). |
| Escha Zi'Tah return confluence | WORKS | scripts/zones/Escha_ZiTah/npcs/Undulating_Confluence.lua returns to Qufim. |
| Escha Ru'Aun return confluence | WORKS | scripts/zones/Escha_RuAun/npcs/Undulating_Confluence.lua exists. |
| Eschan Portals (intra-zone) | WORKS | scripts/globals/teleports/eschan_portals.lua defines portals for Escha Zi'Tah (8), Escha Ru'Aun (15), and Reisenjima (9 Ethereal Ingress). |

### Waypoints (Adoulin / SoA)

| Item | Status | Notes |
|------|--------|-------|
| Waypoint system | WORKS | scripts/globals/waypoint.lua has full implementation. 80+ waypoint entries covering Western Adoulin, Eastern Adoulin, Yahse, Ceizak, Foret de Hennetiel, Morimar, Yorcia, Marjami, Kamihr, and Lower Jeuno. |
| Adoulin city waypoints | WORKS | 9 in Western Adoulin, 9 in Eastern Adoulin. Includes coalitions, AH, docks, rent-a-room. |
| Field waypoints | WORKS | Frontier Stations and Bivouacs in each SoA field zone. |
| Lower Jeuno waypoint | WORKS | Cross-expansion link from Jeuno to Adoulin. |
| Cost (Kinetic Units) | WORKS | Currency system for inter-zone travel. |

### Mountable Chocobos / Mounts

| Item | Status | Notes |
|------|--------|-------|
| Mount enum | WORKS | scripts/enum/mount.lua defines 38 mount types including Chocobo, Raptor, Tiger, Crab, Fenrir, Hippogryph, etc. |
| Full Speed Ahead quest (Raptor mount) | WORKS | scripts/quests/full_speed_ahead.lua implements the racing minigame in Batallia Downs. Awards Raptor mount. |
| Chocobo mount | WORKS | Available through chocobo raising system. Trade Chocobo Whistle to Mapitoto. |
| Mount system (general) | WORKS | Uses /mount command or Abilities menu. Requires level 20+, Chocobo License, Jeuno map. |

### Cavernous Maws (WotG Past Zone Access)

| Item | Status | Notes |
|------|--------|-------|
| Maw global system | WORKS | scripts/globals/maws.lua defines all 9 present/past zone pairs with coordinates and cutscene IDs. Handles teleport registration, bidirectional travel. |
| Present-day maws | WORKS | NPC scripts in Batallia Downs, Rolanberry Fields, Sauromugue Champaign, Jugner Forest, Pashhow Marshlands, Meriphataud Mountains, East Ronfaure, North Gustaberg, West Sarutabaruta. All call xi.maws.onTrigger. |
| Past-era maws (return) | WORKS | Matching Cavernous_Maw.lua in all [S] zones (e.g. Batallia_Downs_[S], Rolanberry_Fields_[S], etc.). |
| Walk of Echoes entry | WORKS | Jeuno-area maws (Batallia, Rolanberry, Sauromugue) offer Walk of Echoes warp when player has Lightsworm KI. |

### Runic Portals (ToAU Assault Zones)

| Item | Status | Notes |
|------|--------|-------|
| Whitegate Runic Portal | WORKS | scripts/zones/Aht_Urhgan_Whitegate/npcs/Runic_Portal.lua is a full implementation. Handles assault orders (6 destinations), permit-based travel, Imperial Standing payment (200 IS), and Captain badge free travel. |
| Field Runic Portals | WORKS | Individual portal scripts in Mount Zhayolm, Caedarva Mire (Azouph + Dvucca), Bhaflau Thickets, Arrapago Reef, Alzadaal Undersea Ruins. |
| Assault staging points | WORKS | 6 assault destinations: Leujaoam, Mamool Ja, Lebros, Periqia, Ilrusi, Nyzul Isle. Each has KI-gated and IS-payment paths. |

### Abyssea Cavernous Maws

| Item | Status | Notes |
|------|--------|-------|
| Abyssea entry system | WORKS | Requires ENABLE_ABYSSEA=1 (default), level 30+, Traverser Stones, and "A Journey Begins" quest completion. Conflux Surveyor (scripts/globals/abyssea/conflux_surveyor.lua) manages Visitant time. |
| Visions maws (3 zones) | WORKS | Konschtat Highlands -> Abyssea-Konschtat, Tahrongi Canyon -> Abyssea-Tahrongi (via Buburimu), La Theine Plateau -> Abyssea-La Theine. |
| Scars maws (3 zones) | WORKS | Valkurm Dunes -> Abyssea-Misareaux, South Gustaberg -> Abyssea-Attohwa (via Buburimu), Jugner Forest -> Abyssea-Vunkerl. |
| Heroes maws (3 zones) | WORKS | Eastern Altepa (via Tahrongi) -> Abyssea-Altepa, Xarcabard -> Abyssea-Uleguerand, Grauberg [S] (via North Gustaberg) -> Abyssea-Grauberg. |
| Abyssea exit maws | WORKS | Cavernous_Maw.lua in each Abyssea zone for return to overworld. Exit positions defined in scripts/globals/abyssea.lua. |
| Traverser Stone system | WORKS | Stone epoch set on quest completion. Stones accumulate over time. Abyssites of Sojourn extend time. Rhapsody in Mauve doubles stone value. |
| Conflux system (intra-zone) | WORKS | scripts/globals/abyssea/conflux.lua handles intra-zone teleportation between confluxes. |

## Blockers
- None identified. All major transport systems have implementations.
- Outpost warps default to retail behavior (UNLOCK_OUTPOST_WARPS=0), meaning supply runs are required. For a small private server, consider setting to 1 or 2 for convenience.

## Fix Difficulty
- N/A -- no fixes needed. All systems are implemented.

## Notes for Small Server
- With only ~4 players, some time-gated transport (airship/ferry schedules) may feel slow. Players will likely rely heavily on Survival Guides, Home Points, and Unity Warps for daily travel.
- Setting UNLOCK_OUTPOST_WARPS=1 or 2 in settings would skip the supply run grind.
- The Unity warp rank fix (forced to 1) already ensures all unity warp destinations are available.
- Rhapsody in White key item (from RoV missions) significantly reduces Survival Guide and Home Point teleport costs.
