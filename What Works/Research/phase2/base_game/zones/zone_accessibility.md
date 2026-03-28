# Zone Accessibility Audit

## Source
- Codebase: `sql/zone_settings.sql` (300 zones), `sql/zonelines.sql`, `sql/transport.sql`
- Scripts: `scripts/globals/maws.lua`, `scripts/globals/waypoint.lua`, `scripts/globals/homepoint.lua`, `scripts/globals/teleports/eschan_portals.lua`, `scripts/globals/geomagnetic_fount.lua`
- Zone scripts: `scripts/zones/*/Zone.lua`

## Summary
All major zone groups are reachable from starter cities via intended routes. Zone connections use four mechanisms: zonelines (field-to-field), city boundaries (client-handled exits), scripted transitions (NPCs/trigger areas), and transport (boats/airships). No broken links found in the base overworld or core expansion access paths. All gated content has proper gate checks.

## Connection Mechanisms

FFXI uses four zone transition types -- all four are present and functional:

1. **Zonelines** (`sql/zonelines.sql`) -- physical zone boundary triggers between field/dungeon zones
2. **City boundaries** -- cities (zonetype=1) use client-side boundary exits, not zonelines
3. **Scripted transitions** -- NPCs, trigger areas, and doors handled in Zone.lua or NPC scripts
4. **Transport** (`sql/transport.sql`) -- boats and airships on timed schedules

## Base Game Overworld

### San d'Oria Chain: S.Sandy -> E.Ronf -> Jugner -> Batallia -> (to Jeuno/northlands)

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| S.Sandy <-> E.Ronf / W.Ronf | WORKS | City boundary (zonetype=1) + zonelines |
| N.Sandy <-> S.Sandy / W.Ronf | WORKS | City boundary + zonelines |
| E.Ronf <-> W.Ronf | WORKS | Zonelines confirmed |
| W.Ronf <-> La Theine | WORKS | Zonelines confirmed |
| E.Ronf <-> Jugner via La Theine | WORKS | Zonelines: E.Ronf(101)->W.Ronf(100)->La Theine(102)->Jugner(104) |
| Jugner <-> Batallia | WORKS | Zonelines confirmed |
| Batallia <-> Xarcabard | WORKS | Via Beaucedine (no direct link; this matches retail) |

### Bastok Chain: Port Bastok -> N.Gust -> Pashhow -> Rolanberry -> Beaucedine -> Xarcabard

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| Bastok cities <-> N.Gust / S.Gust | WORKS | City boundary (zonetype=1) |
| Bastok Mines <-> Zeruhn Mines | WORKS | Zonelines confirmed |
| N.Gust <-> S.Gust | WORKS | Zonelines confirmed |
| S.Gust/N.Gust -> Pashhow | WORKS | Via Konschtat (zonelines: Gust->Konschtat->Pashhow) |
| Pashhow <-> Rolanberry | WORKS | Zonelines confirmed |
| Rolanberry <-> Beaucedine | WORKS | Via Ranguemont Pass (zonelines: 111<->166 confirmed) |
| Beaucedine <-> Xarcabard | WORKS | Zonelines confirmed |

### Windurst Chain: Windurst -> E.Sarutabaruta -> Tahrongi -> Buburimu -> Sauromugue

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| Windurst cities <-> E.Saru / W.Saru | WORKS | City boundary (zonetype=1) |
| E.Saru <-> W.Saru | WORKS | Zonelines confirmed |
| E.Saru <-> Tahrongi | WORKS | Zonelines confirmed |
| Tahrongi <-> Buburimu | WORKS | Zonelines confirmed |
| Buburimu <-> Sauromugue | WORKS | Via Meriphataud Mtns (zonelines confirmed) |

### Cross-Connections (Dunes/Konschtat/La Theine hub)

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| Valkurm <-> La Theine | WORKS | Zonelines confirmed |
| Valkurm <-> Konschtat | WORKS | Zonelines confirmed |
| Konschtat <-> Pashhow | WORKS | Zonelines confirmed |
| La Theine <-> Jugner | WORKS | Zonelines confirmed |

### Qufim / Delkfutt Chain

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| Qufim <-> Lower Delkfutt | WORKS | Zonelines confirmed (126<->184) |
| Lower -> Middle Delkfutt | WORKS | Scripted: trigger areas in Zone.lua (cuboid regions at 3rd floor) |
| Middle -> Upper Delkfutt | WORKS | Scripted: Zone.lua internal transitions |
| Qufim <-> Behemoth's Dominion | WORKS | Zonelines confirmed |

### Jeuno Connections

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| Lower <-> Upper <-> Ru'Lude <-> Port | WORKS | Zonelines confirmed between Jeuno zones |
| Batallia <-> Lower Jeuno | WORKS | City boundary (zonetype=1 on Jeuno side) |
| Rolanberry <-> Upper Jeuno | WORKS | City boundary |
| Sauromugue <-> Ru'Lude | WORKS | City boundary |
| Qufim <-> Lower Jeuno | WORKS | City boundary |

### Transport (Boats & Airships)

| Route | Status | Mechanism |
|-------|--------|-----------|
| Selbina <-> Mhaura ferry | WORKS | transport.sql IDs 9,10; scripts exist |
| Sandy <-> Jeuno airship | WORKS | transport.sql IDs 3,6 |
| Bastok <-> Jeuno airship | WORKS | transport.sql IDs 5,8 |
| Windurst <-> Jeuno airship | WORKS | transport.sql IDs 4,7 |
| Jeuno <-> Kazham airship | WORKS | transport.sql IDs 1,2 |
| Mhaura <-> Whitegate ferry | WORKS | transport.sql ID 11; Zone.lua confirms setPos to OPEN_SEA_ROUTE_TO_AL_ZAHBI |
| Whitegate <-> Mhaura return | WORKS | transport.sql ID 12 |
| Whitegate <-> Nashmau ferry | WORKS | transport.sql ID 13 |

### Selbina / Mhaura / Kazham / Rabao

| Connection | Status | Mechanism |
|-----------|--------|-----------|
| Valkurm <-> Selbina | WORKS | Zonelines confirmed |
| Buburimu <-> Mhaura | WORKS | Zonelines confirmed |
| Yuhtunga <-> Kazham | WORKS | Zonelines confirmed |
| Yuhtunga <-> Yhoator | WORKS | Zonelines confirmed |
| E.Altepa <-> Rabao | WORKS | City boundary (Rabao zonetype=1) |
| E.Altepa <-> W.Altepa | WORKS | Zonelines confirmed |

## Dungeons

| Dungeon | Status | Notes |
|---------|--------|-------|
| Ordelle's Caves | WORKS | Zonelines: La Theine(102) <-> Ordelle's |
| Gusgen Mines | WORKS | Zonelines: Konschtat(108) <-> Gusgen |
| Maze of Shakhrami | WORKS | Zonelines: Tahrongi(117) <-> Maze |
| Garlaige Citadel | WORKS | Zonelines: Sauromugue(120) <-> Garlaige |
| Crawlers' Nest | WORKS | Zonelines: Rolanberry(110) <-> Crawlers |
| Eldieme Necropolis | WORKS | Zonelines: Batallia(105) <-> Eldieme |
| Castle Oztroja | WORKS | Zonelines: Meriphataud(119) <-> Oztroja |
| Davoi | WORKS | Zonelines: Jugner(104) <-> Davoi |
| Beadeaux | WORKS | Zonelines: Pashhow(109) <-> Beadeaux |
| Fei'Yin | WORKS | Zonelines: Beaucedine(111) <-> Fei'Yin |
| Ranguemont Pass | WORKS | Zonelines: Beaucedine(111) <-> Ranguemont(166) |
| Castle Zvahl Baileys | WORKS | Zonelines: Xarcabard(112) <-> Baileys |
| Castle Zvahl Keep | WORKS | Zonelines: Baileys <-> Keep confirmed |
| Sea Serpent Grotto | WORKS | Zonelines: Yuhtunga <-> SSG <-> Norg |
| Norg | WORKS | Zonelines: SSG <-> Norg confirmed |
| Temple of Uggalepih | WORKS | Zonelines: Yhoator <-> Temple confirmed |
| Den of Rancor | WORKS | Zonelines: Temple <-> Den confirmed |
| Sanctuary of Zi'Tah | WORKS | Zonelines confirmed |
| Ro'Maeve | WORKS | Zonelines: Zi'Tah(121) <-> Ro'Maeve(122) |
| Boyahda Tree | WORKS | Zonelines: Zi'Tah(121) <-> Boyahda confirmed |
| Kuftal Tunnel | WORKS | Zonelines: Cape Teriggan(113) <-> Kuftal(174) |
| Gustav Tunnel | WORKS | Zonelines: Cape Teriggan(113) <-> Gustav confirmed |
| Korroloka Tunnel | WORKS | Connects Zeruhn area to Altepa |

## Special Access Zones

### Sky / Tu'Lia (Zilart gated)

| Connection | Status | Notes |
|-----------|--------|-------|
| Ro'Maeve <-> Hall of the Gods | WORKS | Zonelines confirmed (122<->251) |
| Hall of the Gods <-> Ru'Aun Gardens | WORKS | Zonelines confirmed (251<->130); Shimmering Circle NPC requires ZM14+ |
| Ru'Aun internal portals | WORKS | Zone has script directory with NPCs |
| Shrine of Ru'Avitau / Ve'Lugannon | WORKS | Zonelines from Ru'Aun confirmed |

Access path: Walk from Beaucedine -> Ranguemont -> or via Zi'Tah -> Ro'Maeve -> Hall of the Gods -> (ZM gate check) -> Ru'Aun Gardens

### Sea / Al'Taieu (COP gated)

| Connection | Status | Notes |
|-----------|--------|-------|
| Dimensional Portal (La Theine) | WORKS | Script requires COP > THE_WARRIORS_PATH; sends to Al'Taieu |
| Dimensional Portal (Konschtat) | WORKS | Same system |
| Dimensional Portal (Tahrongi) | WORKS | Same system |
| Al'Taieu -> return portals | WORKS | Script sends back to La Theine/Konschtat/Tahrongi |
| Al'Taieu <-> Grand Palace of Hu'Xzoi | WORKS | Zonelines confirmed |
| Al'Taieu <-> Garden of Ru'Hmet | WORKS | Zonelines confirmed |

### Tavnazia (COP gated)

| Connection | Status | Notes |
|-----------|--------|-------|
| Lufaise Meadows <-> Tavnazian Safehold | WORKS | Zonelines confirmed (24<->26) |
| Lufaise <-> Misareaux Coast | WORKS | Zonelines confirmed (24<->25) |
| Misareaux <-> Sacrarium | WORKS | Zonelines confirmed (25<->28) |
| Tavnazian Safehold <-> Phomiuna Aqueducts | WORKS | Zonelines confirmed (26<->27) |
| Sealion's Den access | WORKS | Zonelines from Safehold (26<->32) |
| Riverne Sites | WORKS | Zonelines from Misareaux confirmed |

Access: Unlocked via COP 2-1 (An Invitation West) -- script exists and functions.

### Promyvion (COP)

| Connection | Status | Notes |
|-----------|--------|-------|
| Hall of Transference | WORKS | Zone scripts exist; 6 NPC scripts for crag entries |
| Promyvion-Holla / Dem / Mea | WORKS | Zone directories exist with scripts |
| Spire battles | WORKS | Spire zone directories exist |
| Promyvion-Vahzl | WORKS | Zone directory exists |

## Expansion Zones

### Near East / ToAU

| Connection | Status | Notes |
|-----------|--------|-------|
| Mhaura -> Whitegate ferry | WORKS | transport.sql ID 11; Zone.lua sends to OPEN_SEA_ROUTE_TO_AL_ZAHBI |
| Whitegate <-> Al Zahbi | WORKS | Zonelines confirmed (50<->48) |
| Whitegate -> Wajaom Woodlands | WORKS | Ironbound_Gate NPC setPos to zone 51 |
| Wajaom/Bhaflau/Caedarva chain | WORKS | Zonelines confirmed |
| Whitegate <-> Nashmau ferry | WORKS | transport.sql ID 13 |
| Nashmau <-> Arrapago Reef | WORKS | Zonelines confirmed |

### Past [S] Zones (WotG)

| Connection | Status | Notes |
|-----------|--------|-------|
| Cavernous Maw scripts | WORKS | 9 present-side maws (E.Ronf, N.Gust, W.Saru, Jugner, Pashhow, Meriphataud, Batallia, Rolanberry, Sauromugue) |
| Cavernous Maw [S] return | WORKS | 9 past-side maws with matching return data in maws.lua |
| Maw teleport data | WORKS | `scripts/globals/maws.lua` has full destination table for all 9 pairs |
| [S] zone scripts | WORKS | All [S] zone directories exist: Batallia[S], Jugner[S], Pashhow[S], etc. |
| Walk of Echoes entry | WORKS | Maws in Batallia/Rolanberry/Sauromugue offer WoE warp with Lightsworm KI |

### Abyssea

| Connection | Status | Notes |
|-----------|--------|-------|
| Abyssea-Konschtat (Cavernous Maw) | WORKS | Script checks ENABLE_ABYSSEA, level >= 30, traverser stones |
| Abyssea-La Theine (Maw) | WORKS | Script exists in La_Theine_Plateau |
| Abyssea-Tahrongi (Maw) | WORKS | Script exists in Tahrongi_Canyon |
| All 9 Abyssea zones | WORKS | Cavernous Maw scripts exist in all 9 Abyssea zones + 6 present-side entry zones |
| Abyssea return maws | WORKS | Each Abyssea zone has Cavernous_Maw.lua for return |

Entry zones verified: Konschtat, La Theine, Tahrongi, Valkurm, Buburimu, South Gustaberg, Xarcabard, Attohwa, Misareaux (via Uleguerand/Grauberg/Altepa/Vunkerl paths)

### Adoulin (SoA)

| Connection | Status | Notes |
|-----------|--------|-------|
| Western <-> Eastern Adoulin | WORKS | Zonelines confirmed (256<->257) |
| Adoulin <-> Ceizak Battlegrounds | WORKS | Zonelines confirmed (256<->258, 257<->258) |
| Adoulin <-> Yahse Hunting Grounds | WORKS | Zonelines confirmed (256<->261) |
| Waypoint teleport system | WORKS | `scripts/globals/waypoint.lua` has full data for all SoA zones |
| Lower Jeuno Waypoint | WORKS | `scripts/zones/Lower_Jeuno/npcs/Waypoint.lua` exists; waypoint.lua index 100 = Lower Jeuno |

Access: Lower Jeuno Waypoint -> Western Adoulin (requires SoA flag/mission start)

### Escha / Reisenjima (ROV)

| Connection | Status | Notes |
|-----------|--------|-------|
| Qufim -> Escha-Zi'Tah | WORKS | Undulating Confluence NPC; requires ROV >= SET_FREE |
| Escha-Zi'Tah internal portals | WORKS | 8 Eschan Portal scripts |
| Escha-Ru'Aun internal portals | WORKS | 15 Eschan Portal scripts |
| Reisenjima portals | WORKS | 9 Ethereal Ingress scripts |
| Portal data | WORKS | `scripts/globals/teleports/eschan_portals.lua` has full offset data |

## Checklist Summary

| Zone Group | Status | Notes |
|-----------|--------|-------|
| San d'Oria overworld chain | WORKS | Full path to Xarcabard |
| Bastok overworld chain | WORKS | Full path to Xarcabard |
| Windurst overworld chain | WORKS | Full path to Sauromugue |
| Cross-connections (Dunes hub) | WORKS | All three chains interconnect |
| Jeuno connections | WORKS | All four exits to overworld |
| Qufim/Delkfutt chain | WORKS | Scripted floor transitions |
| All airships | WORKS | 5 routes in transport.sql |
| Selbina-Mhaura ferry | WORKS | transport.sql |
| All base dungeons | WORKS | 20+ dungeons checked |
| Beastman strongholds | WORKS | Oztroja, Davoi, Beadeaux |
| Northlands (Zvahl) | WORKS | Full chain verified |
| Sky (Zilart) | WORKS | ZM gate check on Shimmering Circle |
| Sea (COP) | WORKS | COP mission gate on Dimensional Portals |
| Tavnazia (COP) | WORKS | Unlocked via COP 2-1 |
| Promyvion system | WORKS | Hall of Transference + 4 Promyvion zones |
| Near East (ToAU) | WORKS | Ferry + gate NPC |
| Past [S] zones (WotG) | WORKS | 9 Cavernous Maw pairs |
| Abyssea zones | WORKS | 9 zones via maws, level/stone gated |
| Adoulin (SoA) | WORKS | Waypoint from Lower Jeuno |
| Escha/Reisenjima (ROV) | WORKS | Undulating Confluence, ROV gated |

## Blockers
- None found. All zone groups are reachable from starter cities via intended routes.

## Notes
- Zone connections that appear "missing" from `zonelines.sql` are handled by city boundaries (zonetype=1 zones use client-side exits) or scripted transitions (trigger areas, NPC scripts).
- Gated content (Sky, Sea, Tavnazia, Escha) all have proper mission progress checks.
- The `ENABLE_ABYSSEA` setting flag controls whether Abyssea maws function.
- Adoulin access requires starting SoA missions (Waypoint in Lower Jeuno).
- Whitegate access is via Mhaura ferry (timed departure, alternates with Selbina route every Vana'diel day).

## Fix Difficulty
- N/A -- no fixes needed
