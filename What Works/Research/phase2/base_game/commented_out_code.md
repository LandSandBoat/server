# Commented-Out Code Audit

Sweep of entire codebase for commented-out code that disables gameplay functionality.

## CRITICAL — Gameplay broken by commented-out code

| File | What's Disabled | Impact |
|------|----------------|--------|
| `zones/AlTaieu/npcs/Swirling_Vortex.lua` | Entire Limbus entry system | **Cannot enter Limbus at all** |
| `zones/Aht_Urhgan_Whitegate/npcs/Sorrowful_Sage.lua` | Ilrusi Atoll assault mission giver | Cannot accept Ilrusi assaults if rank > 0 (falls through to "no rank" dialogue) |
| `zones/RuLude_Gardens/npcs/Magian_Moogle_Green.lua` | Job emote trial trade handler | Cannot do Magian emote trials |
| `zones/QuBia_Arena/npcs/Burning_Circle.lua` | ACP mission "Those Who Lurk in Shadows II" BCNM entry | Cannot progress ACP add-on missions |
| `zones/Ifrits_Cauldron/npcs/Flame_Spout.lua` | Flame spout interaction during DRK AF quest | Players can't use flame spouts (workaround was removed but code stayed commented) |

## MODERATE — Functionality reduced

| File | What's Disabled | Impact |
|------|----------------|--------|
| `zones/Aht_Urhgan_Whitegate/npcs/_1ee.lua` | Kokba Hostel door event | Door does nothing when triggered |
| `zones/FeiYin/npcs/Underground_Pool.lua` | BST AF quest interaction | Pool does nothing (quest may use alternate path) |
| `zones/Phomiuna_Aqueducts/npcs/_0r9.lua` | Ornate Gate | Gate does nothing when triggered |

## INTENTIONAL — Commented out for good reason

| File | What's Disabled | Reason |
|------|----------------|--------|
| `zones/Port_San_dOria/npcs/Ambleon.lua` | World Pass dealer | "Selecting option 1 hard locks the client" |
| `zones/Port_Bastok/npcs/Kachada.lua` | World Pass dealer | Same hard lock issue |
| `zones/Heavens_Tower/npcs/Gamimi.lua` | Gold World Pass | Same hard lock issue |

## DATA TABLES — Previously commented out (FIXED)

| File | What Was Disabled | Status |
|------|------------------|--------|
| `zones/Dynamis-Valkurm/IDs.lua` | All QM trade data (4 NM spawns) | **FIXED this session** |
| `zones/Dynamis-Buburimu/IDs.lua` | All QM trade data (5 NM spawns) | **FIXED this session** |
| `zones/Dynamis-Qufim/IDs.lua` | All QM trade data (4 NM spawns) | **FIXED this session** |

## EMPTY NPC TRIGGERS — ??? points that do nothing

| Zone | Count | Impact |
|------|-------|--------|
| Abyssea-Misareaux | 24 empty QMs | NM pop points don't respond |
| Abyssea-Vunkerl | 24 empty QMs | NM pop points don't respond |
| Abyssea-Uleguerand | 22 empty QMs | NM pop points don't respond |
| Valkurm Dunes | 1 empty QM | Minor |

Note: Abyssea-Konschtat, Tahrongi, La Theine, Attohwa, Grauberg QMs DO work (they use the qmOnTrade/qmOnTrigger mixin pattern). The Scars/Heroes zones (Misareaux, Vunkerl, Uleguerand) have empty stubs.

## Apollyon/Temenos (Limbus zones)

Both IDs.lua files have commented-out mob linkage tables. This is part of the broader Limbus-not-implemented issue — the zone infrastructure exists but the entry and mob systems are disabled.
