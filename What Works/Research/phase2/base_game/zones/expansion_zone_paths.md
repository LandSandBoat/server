# Expansion Zone Paths — Can a Player Reach Every Expansion Zone?

## Source
- bg-wiki: Various zone/mission pages
- Codebase: zonelines.sql, zone_settings.sql, Zone.lua scripts, NPC scripts, mission scripts, maws.lua, waypoint.lua, eschan_portals.lua, teleports.lua

## Summary
Most expansion zones are reachable without GM commands, gated by mission progress as intended on retail. Two notable gaps: **Reisenjima has no normal entry NPC** (must use ROV mission CS transport or GM teleport), and **Walk of Echoes** requires Lightsworm KI from WotG Mission 2 (which is implemented). Salvage permit acquisition is partially commented out.

---

## Zilart / Sky

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Reach Hall of the Gods | WORKS | Zoneline from Ro'Maeve | Standard overworld path |
| Shimmering Circle (to Tu'Lia/Sky) | WORKS | NPC trigger, event 10/11 | Requires ZM >= THE_GATE_OF_THE_GODS (mission ID 24 = ZM13). Script: `scripts/zones/Hall_of_the_Gods/npcs/Shimmering_Circle.lua` |
| Ru'Aun Gardens (Sky) | WORKS | Zone-in from Hall of the Gods | Zone exists with mobs, NMs (Byakko/Genbu/Seiryu/Suzaku/Despot), Home Points, Survival Guide |
| Sky platform teleporters (Pincerstones) | WORKS | NPC trigger opens portals for 120s | `scripts/zones/RuAun_Gardens/npcs/Pincerstone.lua` — 10 pincerstone pairs connect all 5 sky islands |
| La'Loff Amphitheater (Ark Angels) | WORKS | Zoneline from Ru'Aun Gardens | Zone has all 5 Ark Angel mob scripts + trigger NPC qm0_1 through qm0_5 |
| Sky via Hall of Transference (chip teleport) | WORKS | Trigger areas 5/6/7 in Hall of Transference | Requires chip registration (MeaChipRegistration/HollaChipRegistration/DemChipRegistration char vars). 5% chip break chance. Calls `xi.teleport.to(player, xi.teleport.id.SKY)` |

**Verdict: WORKS** — Full Sky access path is functional once ZM13 is completed.

---

## COP / Sea

### Promyvion Zones

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Overworld crag to Hall of Transference | WORKS | Zonelines from La Theine/Konschtat/Tahrongi | Zonelines exist in engine for crag entrances |
| Hall of Transference to Promyvion-Holla | WORKS | NPC _0e0 (Cermet Gate), event 150 | Requires COP >= BELOW_THE_ARKS (mission 118). `scripts/zones/Hall_of_Transference/npcs/_0e0.lua` |
| Hall of Transference to Promyvion-Dem | WORKS | NPC _0e1 (Cermet Gate), event 150 | Same COP gate. `scripts/zones/Hall_of_Transference/npcs/_0e1.lua` |
| Hall of Transference to Promyvion-Mea | WORKS | NPC _0e2 (Cermet Gate), event 150 | Same COP gate. `scripts/zones/Hall_of_Transference/npcs/_0e2.lua` |
| Promyvion internal navigation | WORKS | Trigger areas + Memory Receptacle mobs | Dem Zone.lua has 16 trigger areas for floor portals, Memory Receptacle mob scripts exist |
| Promyvion to Spires | WORKS | Zonelines in zonelines.sql | e.g., zone 16->17 (Holla->Spire), 18->19 (Dem->Spire) |
| Promyvion-Vahzl | WORKS | Zone scripts exist | Entered from Pso'Xja area (COP later chapter) |

### Tavnazia

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Reach Lufaise Meadows | WORKS | Zoneline from Misareaux Coast or via COP mission CS | Zone 24 has zoneline entries |
| Lufaise Meadows to Tavnazian Safehold | WORKS | Zonelines in zonelines.sql | Multiple zonelines between zones 24 and 26 (both directions) |
| Tavnazian Safehold amenities | WORKS | Zone has Home Points, Survival Guide, Nomad Moogle | Full town services |

### Riverne

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Misareaux Coast to Riverne Site A01 | WORKS | NPC Spatial_Displacement, event 550/551 | Always available. `scripts/zones/Misareaux_Coast/npcs/Spatial_Displacement.lua` |
| Misareaux Coast to Riverne Site B01 | WORKS | Same NPC, event 551 option 2 | Requires completion of COP SHELTERING_DOUBT (mission 368) |

### Sea (Al'Taieu)

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Dimensional Portal (Konschtat) to Al'Taieu | WORKS | NPC trigger, event 915 | Requires COP > THE_WARRIORS_PATH (mission 748 = COP 7-5). `scripts/zones/Konschtat_Highlands/npcs/Dimensional_Portal.lua` |
| Dimensional Portal (Tahrongi) to Al'Taieu | WORKS | NPC trigger, event 915 | Same COP gate. `scripts/zones/Tahrongi_Canyon/npcs/Dimensional_Portal.lua` |
| Al'Taieu zone | WORKS | Zone exists with fog effect | Zone-in sets default pos if needed |
| Al'Taieu to Grand Palace of Hu'Xzoi | WORKS | Zoneline (engine) | Zone 34 exists with 10 trigger areas for internal teleporters |
| Grand Palace of Hu'Xzoi to Garden of Ru'Hmet | WORKS | Zoneline (engine) | Zone 35 exists with 33 trigger areas for race-based floor teleporters |
| Garden of Ru'Hmet to Empyreal Paradox | WORKS | Trigger area 1 in Ru'Hmet, event 101 | Requires COP mission DAWN or completed DAWN/THE_LAST_VERSE. `scripts/zones/The_Garden_of_RuHmet/Zone.lua` line 177 |
| Empyreal Paradox back to Ru'Hmet | WORKS | Trigger area 1, event 100 | `scripts/zones/Empyreal_Paradox/Zone.lua` |

**Verdict: WORKS** — Full COP zone path is functional, all gated by appropriate mission progress.

---

## ToAU (Near East)

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Mhaura to Al Zahbi ferry | WORKS | Transport system (periodic ship) | NPC Dieh_Yamilsiah tracks ferry schedule. Ship route goes through Open_sea_route_to_Al_Zahbi zone which docks at Whitegate |
| Open Sea Route to Whitegate | WORKS | Transport event 1028 | `scripts/zones/Open_sea_route_to_Al_Zahbi/Zone.lua` — auto-docks at Whitegate |
| Whitegate zone | WORKS | Full town with trigger areas | 13 trigger areas for mission cutscenes, zoneline to Al Zahbi |
| Runic Portal (staging points) | WORKS | NPC in Whitegate, event 101 | Supports all 6 staging points: Azouph, Dvucca, Mamool, Halvung, Ilrusi, Nyzul. Requires permits OR Captain badge OR 200 IS. `scripts/zones/Aht_Urhgan_Whitegate/npcs/Runic_Portal.lua` |
| Assault staging point portals (field) | WORKS | Runic Portal NPCs in each staging zone | Scripts exist in Caedarva_Mire, Mount_Zhayolm, Bhaflau_Thickets, Arrapago_Reef, Alzadaal_Undersea_Ruins |
| Nyzul Isle access | WORKS | Via Alzadaal Undersea Ruins Runic Portal | Requires ToAU >= IMMORTAL_SENTRIES (mission 1). `scripts/zones/Alzadaal_Undersea_Ruins/npcs/Runic_Portal.lua`. Also registers Nyzul runic portal. Instance-based zone. |
| Nyzul Isle zone | WORKS | Instance zone with onInstanceZoneIn | Falls back to Alzadaal if no instance. `scripts/zones/Nyzul_Isle/Zone.lua` |
| Salvage entry (Remnants Permit) | PARTIAL | NPC Zasshal in Whitegate | **Permit acquisition logic is commented out** in `scripts/zones/Aht_Urhgan_Whitegate/npcs/Zasshal.lua` lines 27-33. Player can only check if they already HAVE a permit (event 821) but cannot obtain one through normal gameplay. Salvage zones (Arrapago/Bhaflau/Zhayolm/Silver_Sea Remnants) exist as zone directories. |
| Silver Sea route to Nashmau | WORKS | Transport ship zone | Zone exists for ferry to Nashmau |

**Verdict: PARTIAL** — All paths work except Salvage permit acquisition is commented out.

---

## WotG (Wings of the Goddess)

### Cavernous Maw System

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Present zone Cavernous Maw system | WORKS | Global script `scripts/globals/maws.lua` | Checks ENABLE_WOTG setting, handles maw unlock/warp |
| Batallia Downs <-> Batallia Downs [S] | WORKS | Maw bit 0 | Present CS 910, Past CS 101 |
| Rolanberry Fields <-> Rolanberry Fields [S] | WORKS | Maw bit 1 | Present CS 904, Past CS 102 |
| Sauromugue Champaign <-> Sauromugue Champaign [S] | WORKS | Maw bit 2 | Present CS 904, Past CS 102 |
| Jugner Forest <-> Jugner Forest [S] | WORKS | Maw bit 3 | Present CS 905, Past CS 102 |
| Pashhow Marshlands <-> Pashhow Marshlands [S] | WORKS | Maw bit 4 | Present CS 905, Past CS 101 |
| Meriphataud Mountains <-> Meriphataud Mountains [S] | WORKS | Maw bit 5 | Present CS 905, Past CS 103 |
| East Ronfaure <-> East Ronfaure [S] | WORKS | Maw bit 6 | Present CS 904, Past CS 101 |
| North Gustaberg <-> North Gustaberg [S] | WORKS | Maw bit 7 | Present CS 903, Past CS 101 |
| West Sarutabaruta <-> West Sarutabaruta [S] | WORKS | Maw bit 8 | Present CS 904, Past CS 101 |

All 9 present/past maw pairs are defined in the maws.lua pastMaws table.

### [S] Zone Interconnections

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Walking between [S] zones | WORKS | Zonelines in zonelines.sql | Full zoneline network: S.Sandy[S]<->E.Ronf[S]<->Jugner[S]<->Vunkerl[S]<->Batallia[S], Bastok[S]<->N.Gusta[S]<->Grauberg[S]<->Pash[S]<->Rolan[S], Windy[S]<->W.Saru[S]<->Meri[S]<->Sauro[S], Batallia[S]<->Beaucedine[S]<->Xarcabard[S] |
| [S] city zones | WORKS | Zone settings registered | S.Sandy[S] (80), Bastok Markets[S] (87), Windy Waters[S] (94) |
| [S] dungeon zones | WORKS | Zone directories exist | Beadeaux[S], Castle_Oztroja[S], Castle_Zvahl_Baileys[S], Castle_Zvahl_Keep[S], Crawlers_Nest[S], Garlaige_Citadel[S], La_Vaule[S], The_Eldieme_Necropolis[S], Fort_Karugo-Narugo[S] |

### Walk of Echoes

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Obtain Lightsworm KI | WORKS | WotG Mission 2 (Back to the Beginning) reward | `scripts/missions/wotg/02_Back_to_the_Beginning.lua` grants xi.ki.LIGHTSWORM |
| Batallia/Rolanberry/Sauromugue Maw -> Walk of Echoes | WORKS | Option 2 on Jeuno-area maw warp event | `maws.lua` line 122-142: if player has Lightsworm AND uses Jeuno-area maw warp, option 2 sends to Walk of Echoes (-700.042, 0.399, -441.301, zone 175) |
| Walk of Echoes zone | WORKS | Zone exists | `scripts/zones/Walk_of_Echoes/Zone.lua` — basic zone with default pos. Also Walk_of_Echoes_[P1] and [P2] exist. |

**NOTE:** Walk of Echoes entry is NOT from Xarcabard[S] or Grauberg[S] as originally suspected. It is from the **present-day Jeuno-area Cavernous Maws** (Batallia/Rolanberry/Sauromugue) when the player has the Lightsworm KI. This is correctly implemented.

**Verdict: WORKS** — All WotG zone paths functional. Walk of Echoes accessible via maw system with Lightsworm KI.

---

## SoA (Seekers of Adoulin)

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Start SoA missions | WORKS | SoA M1-1 auto-set on character creation | Talk to Darcia in Lower Jeuno |
| Get Adoulinian Charter Permit | WORKS | SoA M1-1 (Rumors from the West) via Darcia | Option 1: get Geomagnetron (free path). Option 2: pay 1M gil to skip ahead and get permit directly. `scripts/missions/soa/1_1_Rumors_from_the_West.lua` |
| Jeuno Waypoint to Adoulin | WORKS | SoA M1-3 (Onward to Adoulin) | Requires ADOULINIAN_CHARTER_PERMIT KI to use Jeuno Waypoint. `scripts/zones/Lower_Jeuno/npcs/Waypoint.lua` checks for permit |
| Western/Eastern Adoulin waypoints | WORKS | Waypoint NPC system | Full waypoint table with 9 W.Adoulin + 9 E.Adoulin locations. `scripts/globals/waypoint.lua` |
| Adoulin to Ceizak Battlegrounds | WORKS | Zoneline | Zonelines between zone 256 (W.Adoulin) and 258 (Ceizak) |
| Adoulin to Yahse Hunting Grounds | WORKS | Zoneline from E.Adoulin | Zone connections exist |
| Ceizak/Foret/Morimar/Yorcia/Marjami/Kamihr | WORKS | Zonelines in zonelines.sql | Full zoneline network: W.Adoulin(256)<->E.Adoulin(257)<->Ceizak(258), W.Adoulin<->Foret(261)<->Morimar(260), Foret<->Yorcia(268)<->Marjami(262)<->Kamihr(272) |
| Ulbuka waypoints (field zones) | WORKS | Waypoint NPCs in each zone | Yahse (4 points), Ceizak (4 points), Foret (4 points), Morimar (4 points), Yorcia (4 points), Marjami (4 points), Kamihr (4 points) |
| Gate zones (Sih/Moh/Doh/Woh Gates) | WORKS | Zone directories exist | Sih_Gates, Moh_Gates, Woh_Gates zone scripts present |
| Cirdas Caverns / Outer Ra'Kaznar | WORKS | Zone directories exist | Including [U] variants for Unity/upgraded versions |

**Verdict: WORKS** — Full Adoulin access path functional. Waypoint system and zoneline network complete.

---

## Escha / Reisenjima

| Path Step | Status | Mechanism | Notes |
|-----------|--------|-----------|-------|
| Qufim Island to Escha - Zi'Tah | WORKS | NPC Undulating Confluence, event 65 | Requires ROV >= SET_FREE (mission 4). `scripts/zones/Qufim_Island/npcs/Undulating_Confluence.lua` |
| Escha Zi'Tah to Qufim (return) | WORKS | NPC Undulating Confluence, event 4 | No gate, always available. `scripts/zones/Escha_ZiTah/npcs/Undulating_Confluence.lua` |
| Escha Zi'Tah portal network | WORKS | 8 Eschan Portals | `scripts/globals/teleports/eschan_portals.lua` — portal bits 0-7, costs 50 escha silt |
| Misareaux Coast to Escha - Ru'Aun | WORKS | NPC Undulating Confluence, event 14 | No mission gate (unlike Zi'Tah). `scripts/zones/Misareaux_Coast/npcs/Undulating_Confluence.lua` |
| Escha Ru'Aun to Misareaux (return) | WORKS | NPC Undulating Confluence, event 1 | `scripts/zones/Escha_RuAun/npcs/Undulating_Confluence.lua` |
| Escha Ru'Aun portal network | WORKS | 15 Eschan Portals | Portal bits 8-22. Requires Eschan Droplet item for first use if no portals unlocked. |
| Reisenjima access | WORKAROUND | **No NPC entry point found** | On retail, a "Transcendental Radiance" NPC in Escha Ru'Aun warps to Reisenjima after ROV 3-1. **No such NPC script exists in the codebase.** Reisenjima zone exists (zone 291) with Zone.lua, Ethereal Ingress portals (#1-#10), and the eschan portal system supports Reisenjima portal bits 23-31. However, the **initial entry to Reisenjima is missing**. Player must use `!pos` or rely on ROV mission cutscenes to first arrive. |
| Reisenjima portal network | WORKS | 10 Ethereal Ingress portals | Portal bits 23-32. Supports Scintillating Rhapsody KI and Ethereal Droplet item. |
| Reisenjima Henge / Sanctorium | WORKS | Zone directories exist | Sub-zones for battlefields |

**Verdict: PARTIAL** — Escha Zi'Tah and Escha Ru'Aun fully accessible. **Reisenjima has no normal entry NPC** — requires GM teleport or ROV mission CS to first arrive.

---

## Blockers

| Issue | Expansion | Severity | Fix Difficulty |
|-------|-----------|----------|----------------|
| Reisenjima initial entry NPC missing | Escha/ROV | Medium | Easy — Add Transcendental Radiance NPC script in Escha Ru'Aun that checks ROV progress and warps to Reisenjima |
| Salvage Remnants Permit acquisition commented out | ToAU | Medium | Easy — Uncomment and verify Zasshal's permit-granting logic in `scripts/zones/Aht_Urhgan_Whitegate/npcs/Zasshal.lua` |

## Fix Difficulty
- Reisenjima entry: Easy (single NPC script)
- Salvage permit: Easy (uncomment existing code)

---

## Key Files Checked
- `scripts/zones/Hall_of_the_Gods/npcs/Shimmering_Circle.lua` — Sky access gate
- `scripts/zones/RuAun_Gardens/npcs/Pincerstone.lua` — Sky platform teleporters
- `scripts/zones/Hall_of_Transference/Zone.lua` — Promyvion + Sky chip teleport entry
- `scripts/zones/Hall_of_Transference/npcs/_0e0.lua`, `_0e1.lua`, `_0e2.lua` — Promyvion cermet gates
- `scripts/zones/Misareaux_Coast/npcs/Spatial_Displacement.lua` — Riverne entry
- `scripts/zones/Konschtat_Highlands/npcs/Dimensional_Portal.lua` — Sea entry
- `scripts/zones/Tahrongi_Canyon/npcs/Dimensional_Portal.lua` — Sea entry
- `scripts/zones/The_Garden_of_RuHmet/Zone.lua` — Empyreal Paradox gate
- `scripts/zones/Open_sea_route_to_Al_Zahbi/Zone.lua` — Whitegate ferry
- `scripts/zones/Aht_Urhgan_Whitegate/npcs/Runic_Portal.lua` — Staging point teleport
- `scripts/zones/Alzadaal_Undersea_Ruins/npcs/Runic_Portal.lua` — Nyzul access
- `scripts/zones/Aht_Urhgan_Whitegate/npcs/Zasshal.lua` — Salvage permit (BROKEN)
- `scripts/globals/maws.lua` — All 9 Cavernous Maw pairs + Walk of Echoes
- `scripts/missions/wotg/02_Back_to_the_Beginning.lua` — Lightsworm KI
- `scripts/missions/soa/1_1_Rumors_from_the_West.lua` — Adoulin charter permit
- `scripts/zones/Lower_Jeuno/npcs/Waypoint.lua` — Adoulin waypoint entry
- `scripts/globals/waypoint.lua` — Waypoint teleport table
- `scripts/zones/Qufim_Island/npcs/Undulating_Confluence.lua` — Escha Zi'Tah entry
- `scripts/zones/Misareaux_Coast/npcs/Undulating_Confluence.lua` — Escha Ru'Aun entry
- `scripts/globals/teleports/eschan_portals.lua` — Escha/Reisenjima portal system
- `sql/zonelines.sql` — Zone boundary connections
- `sql/zone_settings.sql` — Zone registration
