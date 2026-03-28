# Abyssea System - Access and Content

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Abyssea
- Codebase: `scripts/globals/abyssea.lua`, `scripts/globals/abyssea/` (atma.lua, lights.lua, dominion.lua, conflux.lua, conflux_surveyor.lua, atma_fabricant.lua, sturdypyxis/), `scripts/quests/abyssea/`, `scripts/zones/Abyssea-*/`

## Summary
Abyssea is extensively implemented. All 9 zones (+Empyreal Paradox) exist in zone_settings.sql. The access quest chain, traverser stone system, visitant time, light system, weakness proc system, NM pop system, atma system, conflux teleportation, Cruor Prospectors, Dominion Ops, and Sturdy Pyxis chests are all coded. 172 NMs are defined in the global mob data table with atma/KI drop assignments. However, only 28 have dedicated mob scripts (custom AI/abilities) in the zone mob directories; the rest rely on mob_pools.sql defaults.

---

## 1. Abyssea Access

| Item | Status | Notes |
|------|--------|-------|
| A Journey Begins quest | WORKS | `scripts/quests/abyssea/A_Journey_Begins.lua` -- Joachim in Port Jeuno, requires lv30+, grants first Traverser Stone and starts epoch |
| The Truth Beckons quest | WORKS | `scripts/quests/abyssea/The_Truth_Beckons.lua` -- auto-flagged on completion of A Journey Begins, triggers on entering any Visions zone |
| Cavernous Maw entry NPCs | PARTIAL | Cavernous Maws are WotG mission NPCs (`scripts/missions/wotg/01_Cavernous_Maws.lua`), NOT used for Abyssea entry. Abyssea entry is handled via the quest system (Joachim -> zone-in). Entry NPCs exist but are separate from WotG maws |
| Exit positions | WORKS | All 9 zones have defined exit coordinates back to the overworld in `xi.abyssea.exitPositions` |

## 2. All 9 Abyssea Zones

| Zone | Zone ID | Status | Notes |
|------|---------|--------|-------|
| Abyssea-Konschtat | 15 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs |
| Abyssea-Tahrongi | 45 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs |
| Abyssea-La Theine | 132 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs |
| Abyssea-Attohwa | 215 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs, Conflux #00 |
| Abyssea-Misareaux | 216 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs, Conflux #00 |
| Abyssea-Vunkerl | 217 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs, Conflux #00 |
| Abyssea-Altepa | 218 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs, Dominion Sgts |
| Abyssea-Uleguerand | 253 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs, Dominion Sgts |
| Abyssea-Grauberg | 254 | WORKS | In zone_settings.sql, has NPCs, mobs, QMs, Dominion Sgts, Dominion Tactician |
| Abyssea-Empyreal Paradox | 255 | PARTIAL | In zone_settings.sql but only has IDs.lua and Zone.lua -- minimal implementation |

## 3. Time System (Traverser Stones / Visitant Status)

| Item | Status | Notes |
|------|--------|-------|
| Traverser stone accumulation | WORKS | Epoch set on quest completion via `player:setTraverserEpoch()`. Cap starts at 3, up to 6 with Abyssites of Avarice |
| Conflux Surveyor (time exchange) | WORKS | `scripts/globals/abyssea/conflux_surveyor.lua` -- exchanges stones for visitant time. Base 1800s/stone (30 min), or 3600s with Rhapsody in Mauve. Sojourn abyssites add +180s per stone per abyssite held |
| Visitant status effect | WORKS | Uses `xi.effect.VISITANT`, capped at 7200s (2 hours). Stored/restored between zone-ins via `abysseaTimeStored` charVar |
| Abyssites of Avarice (cap increase) | WORKS | KIs from `xi.ki.VIRIDIAN_ABYSSITE_OF_AVARICE` to `xi.ki.VERMILLION_ABYSSITE_OF_AVARICE`, each adds +1 stone capacity |
| Abyssites of Sojourn (time bonus) | WORKS | Tracked via `getAbyssiteTotal()`, adds bonus time per stone |

## 4. Light System

| Item | Status | Notes |
|------|--------|-------|
| Pearl light | WORKS | Cap 230, max tier 2. Affects time extensions from chests |
| Azure light | WORKS | Cap 255, max tier 4. Affects blue chest (KI) spawns |
| Ruby light | WORKS | Cap 255, max tier 4. Affects red chest (item) spawns |
| Amber light | WORKS | Cap 255, max tier 4. Affects gold chest (augmented item) spawns |
| Golden light | WORKS | Cap 200, max tier 2. Affects gold chest quality |
| Silvery light | WORKS | Cap 200, max tier 2. Affects temp item chest quality |
| Ebon light | WORKS | Cap 200, max tier 2. Affects XP chest bonus |
| Light values per mob | WORKS | `scripts/globals/abyssea/lights.lua` defines light values for every mob type in all 9 zones, including NMs |
| Display lights to player | WORKS | `xi.abyssea.displayAbysseaLights()` function exists |

## 5. NM System

| Item | Status | Notes |
|------|--------|-------|
| NM definitions (global table) | WORKS | **172 NMs** defined in `xi.abyssea.mob` table across all 9 zones, each with Atma and Normal (KI) drop assignments |
| QM pop system (KI/trade) | WORKS | `xi.abyssea.qmOnTrade()` and `xi.abyssea.qmOnTrigger()` handle both KI-pop and trade-pop NMs. Validates items/KIs, spawns mob at player location |
| KI drop system | WORKS | `xi.abyssea.giveNMDrops()` -- 20% base chance for normal KIs, 10% for Atma (alliance-wide). Red proc guarantees normal KI drops |
| Weakness/Proc system | WORKS | Red (WS), Yellow (magic), Blue (job ability) weaknesses fully implemented. Procs cause 30s Terror and flag increased drops. Weaknesses rotate based on day/time |
| Dedicated mob scripts | PARTIAL | Only **28 of 172 NMs** have custom mob scripts in `scripts/zones/Abyssea-*/mobs/`. Rest use default AI from mob_pools |
| QM NPC scripts | WORKS | Extensive QM scripts exist across all zones for NM popping |

### NMs with Dedicated Mob Scripts (28 total)
- **Konschtat (9):** Bakka, Balaur, Dapifer_Imp, Eccentric_Eve, Fistule, Hadal_Satiator, Kukulkan, Lachrymater, Turul
- **Tahrongi (3):** Bog_Body, Iratham, Manananggal
- **La Theine (4):** Briareus, Crepuscule_Puk, Luison, Piasa
- **Attohwa (3):** Funnel_Antlion, Murrain_Chigoe, Tunga
- **Misareaux (1):** Athamas
- **Vunkerl (4):** Clammy_Imp, Div-e_Sepid, Peapuk, Sippoy
- **Altepa (2):** Desert_Puk, Rani
- **Uleguerand (2):** Chillwing_Hwitti, Ermit_Imp
- **Grauberg (0):** None

## 6. Atma System

| Item | Status | Notes |
|------|--------|-------|
| Atma definitions | WORKS | **149 Atma** defined in `scripts/globals/abyssea/atma.lua` with full mod assignments (stats, attack, defense, haste, regain, refresh, etc.) |
| Atma Infusionist NPC | WORKS | Present in all 9 Abyssea zones. Calls `xi.atma.onTrigger()` etc. Handles equipping/removing atma |
| Atma Fabricant NPC | PARTIAL | Script exists in all zones but `onTrigger` only starts event 2182. `onTrade` and `onEventUpdate/Finish` are empty stubs -- the atma creation/exchange may not be fully functional |
| Atma mods applied in combat | WORKS | The 149 entries include both NM-dropped atma (with full stat definitions) and quest/special atma (many have empty mod tables `{ }`, meaning those specific atma grant no stat bonuses) |

### Atma Categories
- NM-dropped Atma: ~80 with full stat definitions (STR, ATT, Double Attack, Regain, etc.)
- Quest/Special Atma: ~69 defined with empty mod tables (Einherjar, Illuminator, Bushin, Ace Angler, etc.) -- these grant no bonuses

## 7. Cruor Prospector

| Item | Status | Notes |
|------|--------|-------|
| Cruor Prospector NPC | WORKS | Present in all 9 zones (`scripts/zones/Abyssea-*/npcs/Cruor_Prospector.lua`) |
| Visions items (Perle/Aurore/Teal gear) | WORKS | 18 items defined in `visionsCruorProspectorItems` including Forbidden Key, Cipher of Joachim, Shadow Throne |
| Temp items | WORKS | 17 temp items defined including Lucid Potions/Ethers, Catholicon, Primeval Brew |
| Enhancement buffs | WORKS | HP/MP/STR/DEX/VIT/AGI/INT/CHR/MND boosts available with cruor cost. Enhanced by Abyssites of Merit and Furtherance |
| Cruor currency | WORKS | Earned from Dominion Ops and NM kills. Used for conflux transport, items, buffs |

## 8. Empyrean Armor/Weapons

| Item | Status | Notes |
|------|--------|-------|
| Magian Trial system | WORKS | `scripts/globals/magian_data.lua` exists with extensive trial definitions |
| Empyrean weapon path (Verethragna example) | WORKS | Full upgrade chain found: base -> 85 -> 90 -> 95 -> 99 -> 99 II via magian trials |
| Empyrean weapon items | WORKS | All empyrean weapon stages defined as item references (VERETHRAGNA, VERETHRAGNA_85, VERETHRAGNA_90, VERETHRAGNA_95, VERETHRAGNA_99, VERETHRAGNA_99_II) |
| Empyrean armor (base Perle/Aurore/Teal) | WORKS | Available from Cruor Prospector. Base stats in item_mods.sql (458 matching mod entries for these sets) |
| Empyrean AF+1/+2 (Ravager, Orison, etc.) | PARTIAL | Item mods exist in sql but upgrade NPC paths not verified in this audit |

## 9. Dominion Ops

| Item | Status | Notes |
|------|--------|-------|
| Dominion Sergeant NPCs | WORKS | 9 sergeants defined across 3 Heroes zones (Altepa: Excenmille/Nanaa/Volker, Uleguerand: Maat/Romaa/Zazarg, Grauberg: Wolfgang/Cornelia/Tosuka) |
| Dominion Ops quests | WORKS | 42 ops total (14 per Heroes zone) in `scripts/quests/abyssea/` with full quest scripts |
| Op rewards (XP/Cruor/Notes) | WORKS | Base 1000 XP (scaled by level), 200 Cruor, 100 Dominion Notes per op |
| Dominion Tactician | WORKS | NPC script exists in Abyssea-Grauberg |
| Influence system | PARTIAL | Server variables track influence per zone/op, but TODO comment notes research needed on influence vs. reward bonus calculations |
| Op accept/cancel/complete | WORKS | Full flow implemented: sign on, track kills (5 per op), report completion |

## 10. Additional Systems

| Item | Status | Notes |
|------|--------|-------|
| Veridical Conflux teleportation | WORKS | 8 confluxes per zone (+ Conflux #00 in Scars zones). Cruor costs scale by expansion tier. Discount with Confluence abyssites (up to -80%) |
| Sturdy Pyxis (treasure chests) | WORKS | Full system in `scripts/globals/abyssea/sturdypyxis/` with 14 handler files covering augmented items, blue/red/gold chests, cruor, XP, KIs, pop items, temp items, time extensions, restores |
| Abyssite system | WORKS | 20 abyssite types tracked (Sojourn, Celerity, Avarice, Confluence, Expertise, Fortune, etc.) plus 11 Demilune abyssites |
| Weakness trigger system | WORKS | Red/Yellow/Blue weaknesses rotate. Red = specific weapon skills, Yellow = elemental magic (based on day), Blue = job abilities (based on time of day) |

## Blockers
- **Atma Fabricant appears stubbed** -- onTrade/onEventUpdate/onEventFinish are empty, so players may not be able to create/exchange atma at this NPC
- **144 of 172 NMs lack custom mob scripts** -- they rely on mob_pools.sql defaults, which means custom AI, special abilities, and phase transitions may be missing for many NMs
- **Abyssea-Empyreal Paradox is minimal** -- only Zone.lua and IDs.lua exist; no mob/NPC scripts for the final Abyssea battle content
- **Atma with empty mod tables** -- ~69 of 149 atma grant no stat bonuses (empty `{ }` tables), though some may be intentionally effect-only
- **Dominion influence bonus calculations are TODO** -- reward scaling with influence is not finalized
- **Cavernous Maw access for Abyssea not verified** -- the Cavernous Maws in overworld zones are WotG-specific; Abyssea zone entry mechanism via these NPCs is separate and was not traced end-to-end in this audit

## Fix Difficulty
- Atma Fabricant stub: **Easy** (if it just needs CS wiring)
- Missing mob scripts for 144 NMs: **Massive** (each NM needs custom abilities, phases, spawn conditions)
- Empyreal Paradox content: **Hard** (final battle content for all 3 Abyssea storylines)
- Empty atma mod tables: **Medium** (need to research and add correct stat bonuses for each)
- Dominion influence: **Easy** (formula research + implementation)

## NM Count Summary
| Zone | NMs in Global Table | Dedicated Mob Scripts | QM Pop Scripts |
|------|--------------------|-----------------------|----------------|
| Konschtat | 18 | 9 | 14 |
| Tahrongi | 19 | 3 | varies |
| La Theine | 19 | 4 | 14 |
| Attohwa | 24 | 3 | 24 |
| Misareaux | 24 | 1 | varies |
| Vunkerl | 24 | 4 | varies |
| Altepa | 17 | 2 | 22 |
| Uleguerand | 17 | 2 | varies |
| Grauberg | 17 | 0 | 18 |
| **Total** | **172** | **28** | **100+** |
