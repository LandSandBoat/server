# Wings of the Goddess -- Missions and Content

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Wings_of_the_Goddess_Missions
- bg-wiki: https://www.bg-wiki.com/ffxi/Campaign
- Codebase:
  - `scripts/missions/wotg/` (54 mission scripts + helpers.lua)
  - `scripts/globals/campaign.lua`
  - `scripts/globals/maws.lua`
  - `scripts/quests/crystalWar/` (30 quest scripts)
  - `src/map/campaign_system.cpp`, `src/map/campaign_handler.cpp`
  - `sql/campaign_map.sql`, `sql/campaign_nation.sql`
  - `scripts/zones/Walk_of_Echoes/`

## Summary
WotG missions are extensively scripted (all 54 missions present), but several later missions have TODO comments around battlefield/instance completion. Campaign zone control and Sigil/Allied Notes vendor systems exist in C++ and Lua. Campaign Battles (the actual dynamic combat events in [S] zones) are NOT implemented. Campaign Ops are NOT implemented. Walk of Echoes zone exists as a shell only -- no battle content.

---

## Checklist

### 1. WotG Missions

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 1 | Cavernous Maws | WORKS | Maw interaction, transport to [S] zone, grants Pure White Feather KI |
| 2 | Back to the Beginning | WORKS | Full cutscene scripting |
| 3 | Cait Sith | WORKS | Requires completion of nation-path Crystal War quest (helpers.lua gate) |
| 4 | The Queen of the Dance | WORKS | Nation-path gate via helpers |
| 5 | While the Cat is Away | WORKS | |
| 6 | A Timeswept Butterfly | WORKS | Simple CS-based mission |
| 7 | Purple The New Black | PARTIAL | Has battlefield check (`battlefieldWin == xi.battlefield.id.PURPLE_THE_NEW_BLACK`) -- depends on battlefield being implemented |
| 8 | In the Name of the Father | WORKS | Nation-path gate |
| 9-14 | Dancers in Distress through A Nation on the Brink | WORKS | Full scripting with cutscenes |
| 15 | Crossroads of Time | WORKS | Nation-path gate via helpers |
| 16-22 | Sandswept Memories through A Sanguinary Prelude | WORKS | Cutscene-based missions |
| 23 | Dungeons and Dancers | PARTIAL | TODO: instance implementation not complete; script has placeholder for battlefield completion |
| 24 | Distorter of Time | PARTIAL | TODO: instance implementation not complete |
| 25-29 | The Will of the World through A Hawk in Repose | WORKS | Cutscene missions |
| 30 | The Battle of Xarcabard | WORKS | CS-based, TODO note about allegiance parameter |
| 31 | Prelude to a Storm | PARTIAL | Instance/battlefield not verified as complete |
| 32 | Storms Crescendo | PARTIAL | Instance entry scripted but battlefield completion unverified |
| 33 | Into the Beasts Maw | PARTIAL | TODO: Instance entry requires Distress Signal Flare; battlefield completion unverified |
| 34-36 | The Hunter Ensnared, Flight of the Lion, Fall of the Hawk | WORKS | Short cutscene missions |
| 37 | Darkness Descends | PARTIAL | Battlefield win check present but TODO about verification |
| 38 | Adieu, Lilisette | WORKS | Nation-path gate, cutscene mission |
| 39-40 | By the Fading Light, Edge of Existence | WORKS | Cutscene missions |
| 41 | Her Memories | WORKS | Intentionally blank -- logic handled by 4 subquests (Her_Memories_*.lua) |
| 42-50 | Forget Me Not through Fork in the Road | WORKS | Cutscene missions |
| 46 | When Wills Collide | PARTIAL | TODO: battlefieldWin check not yet wired up |
| 51 | Maiden of the Dusk | PARTIAL | TODO: BCNM entry requires Primal Glow KI; battlefieldWin not wired |
| 52-53 | Where It All Began, Token of Troth | WORKS | Cutscene missions |
| 54 | Lest We Forget | WORKS | Final mission with augmented reward item selection |

**Mission Totals:** 54 scripts. ~40 WORKS (cutscene-only missions), ~8 PARTIAL (missions requiring battlefield/instance wins that have TODOs). No stubs or auto-completes found -- all scripts contain real event logic.

**helpers.lua TODOs:** Six "Add one day wait" TODOs for nation-path progression gates (missions 3, 4, 8, 15, 26, 38). On retail, players must wait one game day between completing a nation sub-quest and progressing the main mission. This wait is currently not enforced.

### 2. Past Zone Access (Cavernous Maws)

| Item | Status | Notes |
|------|--------|-------|
| Maw system (globals/maws.lua) | WORKS | Full implementation for 9 maw pairs (present<->past) |
| Batallia Downs maw | WORKS | Also WotG mission 1 trigger point |
| Rolanberry Fields maw | WORKS | |
| Sauromugue Champaign maw | WORKS | |
| Jugner Forest maw | WORKS | |
| Pashhow Marshlands maw | WORKS | |
| Meriphataud Mountains maw | WORKS | |
| East Ronfaure maw | WORKS | |
| North Gustaberg maw | WORKS | |
| West Sarutabaruta maw | WORKS | |
| Maw unlock persistence | WORKS | Uses `xi.teleport.type.PAST_MAW` bit flags |
| [S] zone scripts | WORKS | All 26 [S] zones have zone scripts, NPCs, and mobs |
| Walk of Echoes entry via maw | WORKS | Batallia/Rolanberry/Sauromugue maws offer WoE warp with Lightsworm KI |

### 3. Campaign Battles

| Item | Status | Notes |
|------|--------|-------|
| Campaign zone control system (C++) | PARTIAL | `campaign_handler.cpp` tracks nation control, influence, fortifications, heroism, resources per zone. DB tables exist (`campaign_map`, `campaign_nation`). |
| Campaign battle spawning | MISSING | No mob spawning logic for campaign battles found. No `onCampaignBattle` or equivalent handler. The `isbattle` flag exists in DB but nothing triggers it dynamically. |
| Campaign battle participation | MISSING | No tag system, no union joining, no XP/AN rewards from battles |
| Campaign NPCs (allied forces) | MISSING | No allied NPC army spawning during battles |
| Campaign map packet (0x071) | WORKS | Influence/control data sent to client for campaign map display |
| Sigil effect | WORKS | Sigil NPC grants Sigil status effect with regen/refresh/meal duration/XP loss options |

### 4. Campaign Ops

| Item | Status | Notes |
|------|--------|-------|
| Campaign Ops system | MISSING | No campaign ops quest framework found. On retail there are ~100+ campaign ops per nation. |
| Campaign Ops NPCs | PARTIAL | Fiaudie (S. San d'Oria [S]) exists and shows allegiance/rank info, but no ops menu or quest logic |
| Crystal War quests (sub-missions) | WORKS | 30 quests in `scripts/quests/crystalWar/` -- these are the nation-path side quests required for WotG mission progression (Steamed Rams, Claws of the Griffon, etc.), NOT campaign ops |
| Freelance system | MISSING | TODO in campaign.lua: freelanceMask not implemented |

### 5. Walk of Echoes

| Item | Status | Notes |
|------|--------|-------|
| Walk of Echoes zone | PARTIAL | Zone exists, player can enter via Cavernous Maw (with Lightsworm KI) or Veridical Conflux in Grauberg [S] |
| Veridical Conflux (lobby) | WORKS | Teleports to Xarcabard [S] (zone 137) |
| Veridical Conflux G | WORKS | Returns to Grauberg [S] |
| Walk of Echoes battles | MISSING | No battle content. WoE [P1] and [P2] instance zones exist as empty shells (Zone.lua only, no mobs/NPCs) |
| Kupofried's rewards | MISSING | No reward NPC scripted |

### 6. Allied Notes

| Item | Status | Notes |
|------|--------|-------|
| Allied Notes currency | WORKS | Stored via `getCurrency('allied_notes')` / `delCurrency('allied_notes')` |
| Sigil NPC vendor (Allied Notes shop) | WORKS | Full vendor implementation in `campaign.lua` with tiered reward tables for all 3 nations (San d'Oria, Bastok, Windurst). Includes campaign gear, recall rings, trust ciphers, Sprinter's Shoes. |
| Allied Notes earning (Campaign Battles) | MISSING | Since campaign battles don't exist, there's no way to earn Allied Notes through normal gameplay |
| Allied Notes earning (Campaign Ops) | MISSING | Campaign ops not implemented |
| Medal rank system | PARTIAL | `getMedalRank()` function works, checks KIs from Bronze Ribbon to Medal of Altana. But no way to earn medals without campaign participation. |
| Chocobo rental with Allied Notes | WORKS | `scripts/globals/chocobo.lua` supports Allied Notes payment in [S] zones |
| Extravaganza vendor (Allied Notes) | WORKS | Shixo/Shenni/Shuvo NPCs use Allied Notes during campaigns |

---

## Blockers
- **Campaign Battles not implemented** -- This is the core WotG gameplay loop. Without it, players cannot earn Allied Notes or campaign medals through normal play. Requires GM commands (`!addcurrency allied_notes <amount>`) to give players notes.
- **Several missions require battlefield/instance wins** -- Missions 7, 23, 24, 31, 32, 33, 37, 46, 51 have TODO comments about battlefield completion not being wired up. Players may get stuck at these points.
- **Campaign Ops completely absent** -- Over 100 ops per nation on retail; zero implemented here.
- **Walk of Echoes battles not implemented** -- Zone is just a lobby with no content.
- **One-day wait not enforced** -- Nation-path gates skip the Vana'diel day wait between sub-quest completion and main mission progression (minor).

## Workarounds
- **Allied Notes:** `!addcurrency allied_notes <amount>` to give players notes for vendor purchases
- **Mission progression past battlefield missions:** `!addmission 5 <next_mission_index>` to skip stuck missions (e.g., `!addmission 5 7` to skip Purple The New Black)
- **Campaign medals:** `!addkeyitem <medal_ki_id>` to grant medal rank for Sigil duration bonuses and vendor access tiers

## Fix Difficulty
- **WotG Missions (cutscene-only):** Already done -- no fix needed
- **WotG Missions (battlefield):** Medium -- need to verify/create battlefield entries and wire up completion vars
- **Campaign Battles:** Massive -- requires full mob spawn system, allied NPC armies, union/tag system, reward distribution, dynamic zone control
- **Campaign Ops:** Massive -- 100+ quests per nation, none started
- **Walk of Echoes:** Hard -- need full battle instance system with mob waves and rewards
- **One-day wait enforcement:** Easy -- add timer check in helpers.lua functions
