# Leveling 10-30 Experience — Phase 2 Audit

Audited: 2026-03-28

## Summary

The level 10-30 experience is **largely functional** with a few notable issues. Sub-job unlock, Fields/Grounds of Valor, chocobo license, trust expansion, and supply quests all have working scripts. The main concern is a missing mob droplist for Snippers in most zones (but the Valkurm Dunes Snipper droplist is correct).

---

## 1. Sub-Job Unlock (Level 18)

### bg-wiki Reference
- **Elder Memories** (Selbina): Talk to Isacio, trade Magicked Skull, Damselfly Worm, Crab Apron
- **The Old Lady** (Mhaura): Talk to Vera, trade Wild Rabbit Tail, Cup of Dhalmel Saliva, Bloody Robe
- Both quests unlock support jobs. Player only needs to complete ONE.
- Both accept Gilgamesh's Introductory Letter (from RoV) as a shortcut.

### Code Verification

**Scripts:**
- `scripts/zones/Selbina/npcs/Isacio.lua` — FULLY IMPLEMENTED
- `scripts/zones/Mhaura/npcs/Vera.lua` — FULLY IMPLEMENTED

**Quest Flow (Elder Memories / Isacio):**
1. Player must be >= `SUBJOB_QUEST_LEVEL` (default 18, configurable in `settings/default/main.lua:120`)
2. Player must NOT have started The Old Lady (mutual exclusion check, line 40)
3. Accept quest -> `IsacioElderMemVar = 1` -> trade Magicked Skull
4. `IsacioElderMemVar = 2` -> trade Damselfly Worm
5. `IsacioElderMemVar = 3` -> trade Crab Apron
6. Completion: `player:unlockJob(0)` + quest complete + SUBJOB_UNLOCKED message
7. Gilgamesh's Letter shortcut: checked at line 47, skips to completion event

**Quest Flow (The Old Lady / Vera):**
1. Same level check and mutual exclusion (line 43)
2. Accept quest -> `VeraOldLadyVar = 1` -> trade Wild Rabbit Tail
3. `VeraOldLadyVar = 2` -> trade Cup of Dhalmel Saliva
4. `VeraOldLadyVar = 3` -> trade Bloody Robe
5. Completion: `player:unlockJob(0)` + quest complete + SUBJOB_UNLOCKED message
6. Gilgamesh's Letter shortcut: checked at line 50

**Minor difference:** Isacio uses `player:confirmTrade()` while Vera uses `player:tradeComplete()`. Both should work (they are aliases), but worth noting for consistency.

### Item Drop Verification

| Item | Item ID | Mob Source (bg-wiki) | Mob in Server | Zone | Droplist ID | Has Item? | Drop Rate |
|------|---------|---------------------|---------------|------|-------------|-----------|-----------|
| Magicked Skull | 538 | Ghouls (various) | Ghoul_war/Ghoul_blm | Valkurm (103), Jugner (104), Pashhow (109), Buburimu (118) | 960 | YES | Common 15% |
| Magicked Skull | 538 | Ghouls | Ghoul_war/Ghoul_blm | Gusgen (196) | 962 | YES | Rare 5% |
| Magicked Skull | 538 | Ghouls | Ghoul_war | Maze of Shakhrami (198) | 959 | YES | Rare 5% |
| Magicked Skull | 538 | Ghouls | Ghoul_war | Gusgen_GM (82/90) | 953/958 | NO | Missing from these droplists |
| Damselfly Worm | 537 | Damselfly | Damselfly | Valkurm (103) | 562 | YES | Uncommon 10% |
| Crab Apron | 539 | Snipper | Snipper | Valkurm (103) | 2281 | YES | Uncommon 10% |
| Wild Rabbit Tail | 542 | Mighty Rarab | Mighty_Rarab | Buburimu (118) | 1670 | YES | Uncommon 10% |
| Cup of Dhalmel Saliva | 541 | Bull Dhalmel | Bull_Dhalmel | Buburimu (118) | 385 | YES | Uncommon 10% |
| Bloody Robe | 540 | Bogy (various) | Bogy | Valkurm (103) | 321 | YES | Very Common 24% |
| Bloody Robe | 540 | Bogy | Bogy | Jugner (104), Pashhow (109), Buburimu (118), Gusgen (119) | 322 | YES | Very Common 24% |
| Bloody Robe | 540 | Bogy | Bogy | Gusgen Mines (90/past) | 320 | NO | Missing from this droplist |

### Verdict: WORKS
All required quest items drop from the correct mobs in the primary zones (Valkurm Dunes for Elder Memories, Buburimu Peninsula for The Old Lady). Some past/campaign zone droplists are missing items, but these are not the intended farming zones.

### Access to Selbina/Mhaura
- Players reach Selbina by walking through Valkurm Dunes (from La Theine Plateau, accessible from San d'Oria) or via ferry from Mhaura.
- Players reach Mhaura by walking through Buburimu Peninsula (from Tahrongi Canyon, accessible from Windurst) or via ferry from Selbina.
- Ferry system is implemented: `scripts/globals/transport.lua` defines Selbina<->Mhaura ferry with 480-second intervals.
- Bastok players go through Konschtat Highlands -> Valkurm Dunes -> Selbina.

---

## 2. Fields of Valor (Primary Leveling Method)

### bg-wiki Reference
- Field Manuals exist in 30 outdoor zones
- Players select a training page, kill required mobs, get EXP + Gil + Tabs
- Tabs can buy buffs (Regen, Refresh, Protect, Shell), food effects, Reraise, Repatriation, and trust ciphers

### Code Verification

**Core system:** `scripts/globals/regimes.lua` — FULLY IMPLEMENTED for both FoV and GoV

**Key zones for lv10-30:**

| Zone | Script Exists | Pages | Level Range | Reward Range |
|------|--------------|-------|-------------|--------------|
| Valkurm Dunes | `scripts/zones/Valkurm_Dunes/npcs/Field_Manual.lua` | 5 pages | lv15-25 | 475-575 gil |
| Jugner Forest | Regime data exists (zone 104) | 5 pages | lv15-25 | 480-630 gil |
| Pashhow Marshlands | Regime data exists (zone 109) | 5 pages | lv20-24 | 540-600 gil |
| Qufim Island | `scripts/zones/Qufim_Island/npcs/Field_Manual.lua` | 5 pages | lv26-34 | 630-770 gil |

**Reward mechanism (regimes.lua lines 1478-1496):**
1. Gil reward: `player:addGil(reward)` -- direct gil grant
2. Tabs reward: `math.floor(reward / 10) * TABS_RATE`, capped at 50,000 total
3. Tabs only awarded once per game day (controlled by `[regime]lastReward` var)
4. EXP reward: `player:addExp(reward * BOOK_EXP_RATE)` -- always awarded if player is within level range
5. Level threshold: player must be within `REGIME_REWARD_THRESHOLD` (default 15) levels of the page minimum

**Tab spending options (regimes.lua lines 57-69):**
- Repatriation (50 tabs), Reraise (10), Regen (20), Refresh (20), Protect (15), Shell (15)
- Food effects: Dried Meat, Salted Fish, Hard Cookie, Instant Noodles (50 tabs each)
- Trust ciphers: Cipher_Koru (300 tabs), Cipher_Sakura (300 tabs)

**Settings (settings/default/main.lua):**
- `BOOK_EXP_RATE = 1.000` (line 131)
- `TABS_RATE = 1.000` (line 132)
- `REGIME_WAIT = 1` (line 44) -- retail-accurate once-per-game-day tab limit
- `REGIME_REWARD_THRESHOLD = 15` (line 332)

### Verdict: WORKS
FoV is fully implemented with correct reward structure. All key leveling zones have Field Manual scripts and regime data.

---

## 3. Grounds of Valor (Dungeon Leveling)

### bg-wiki Reference
- Grounds Tomes exist in 30 dungeon zones
- Similar to FoV but with additional Prowess buffs that stack with completions
- Rewards scale: start at minimum, increase 4% per repeat, max 200% after 25 regimes

### Code Verification

**Key dungeons for lv10-30:**

| Dungeon | Script Exists | Pages | Level Range |
|---------|--------------|-------|-------------|
| Maze of Shakhrami | `scripts/zones/Maze_of_Shakhrami/npcs/Grounds_Tome.lua` | Yes | lv15-31 (page 1: lv15-18) |
| Ordelle's Caves | `scripts/zones/Ordelles_Caves/npcs/Grounds_Tome.lua` | Yes | lv18-34 (page 1: lv18-21) |
| Gusgen Mines | `scripts/zones/Gusgen_Mines/npcs/Grounds_Tome.lua` | Yes | lv20-36 (page 1: lv20-27) |

All three Grounds Tome scripts use the same pattern as Field Manuals:
```lua
entity.onTrigger -> xi.regime.bookOnTrigger(player, xi.regime.type.GROUNDS)
entity.onEventUpdate -> xi.regime.bookOnEventUpdate(player, option, xi.regime.type.GROUNDS)
entity.onEventFinish -> xi.regime.bookOnEventFinish(player, option, xi.regime.type.GROUNDS)
```

The same `regimes.lua` core handles both FoV and GoV. GoV regime data is defined in the `[xi.regime.type.GROUNDS]` section.

### Verdict: WORKS
GoV is fully implemented. All three key dungeons have Grounds Tome scripts and regime data.

---

## 4. Key Zone Progression

### Valkurm Dunes (lv10-20)
- **Access:** From La Theine Plateau (San d'Oria), Konschtat Highlands (Bastok), or Buburimu Peninsula (Windurst via Tahrongi)
- **Mobs:** Damselflies, Snippers, Ghouls (night), Hill Lizards, Crabs
- **FoV:** 5 pages covering lv15-25
- **Survival Guide:** `scripts/zones/Valkurm_Dunes/npcs/Survival_Guide.lua` exists

### Qufim Island (lv20-30)
- **Access:** Through Lower Jeuno (which requires reaching Jeuno first)
- **Mobs:** Clippers, Greater Pugils, Land Worms, Gigas
- **FoV:** 5 pages covering lv26-34
- **Survival Guide:** `scripts/zones/Qufim_Island/npcs/Survival_Guide.lua` exists

### Jeuno Access (typically lv25-30)
- Players reach Jeuno by traveling through dangerous zones:
  - San d'Oria path: La Theine -> Jugner Forest -> Batallia Downs -> Jeuno
  - Bastok path: Konschtat -> Pashhow Marshlands -> Rolanberry Fields -> Jeuno
  - Windurst path: Tahrongi -> Meriphataud -> Sauromugue -> Jeuno
- All connecting zones exist in the server
- With trusts available from level 5 (via ROE/ROV), Jeuno access is achievable earlier than retail

### Verdict: WORKS
Zone accessibility is fine. All connecting zones and survival guides exist.

---

## 5. Trust Expansion

### bg-wiki Reference
- Players get their first trust via Records of Eminence tutorial
- Nation trust quests (Trust: San d'Oria, Trust: Bastok, Trust: Windurst) grant additional trusts
- Trust ciphers from ROE rewards and FoV tabs provide more options

### Code Verification

**Nation Trust Quests:**
| Quest | Quest ID | NPC | Script |
|-------|----------|-----|--------|
| Trust: San d'Oria | sandoria.TRUST_SANDORIA (119) | Excenmille, N. San d'Oria | `scripts/zones/Northern_San_dOria/npcs/Excenmille.lua` |
| Trust: Bastok | bastok.TRUST_BASTOK (92) | Naji/Clarion Star, Metalworks | `scripts/quests/bastok/Trust_Bastok.lua` |
| Trust: Windurst | windurst.TRUST_WINDURST (96) | Kupipi, Heaven's Tower / Wetata, Windurst Woods | `scripts/zones/Heavens_Tower/npcs/Kupipi.lua` |

**Key observations:**
- All three nation trust quests are implemented
- San d'Oria and Windurst trust handling is in NPC scripts (not quest framework)
- Bastok trust uses the Quest framework (`Quest:new()`)
- Nation trust quests check if you have Rank 3 in your nation (`player:getRank(player:getNation()) >= 3`)
- Cross-nation trust quests require completing your home nation trust first

**Trust Cipher Trade System:**
- `scripts/globals/trust.lua` line 233: `xi.trust.onTradeCipher()` handles cipher trading
- Requires a trust permit (any nation's)
- Validates cipher item range (10112-10193)
- Extracts spell ID from item subId
- FoV tab ciphers: Cipher_Koru (300 tabs) and Cipher_Sakura (300 tabs) available from Field Manuals

### Verdict: WORKS
Trust system is fully functional. Players can get trusts from ROE, nation quests, cipher items, and FoV tabs.

---

## 6. Rank 1-2 Missions

Already audited in Phase 1. All three nation Rank 1-2 mission chains are implemented and functional.

---

## 7. Chocobo License (Level 20)

### bg-wiki Reference
- Quest: **Chocobo's Wounds** — Brutus in Upper Jeuno (G-7)
- Requires: Level 20, Jeuno Fame 1
- Steps: Talk to Brutus, feed injured Chocobo 4x Gausebit Grass (6 feeding stages, first 2 fail automatically, 1-minute cooldown between feeds)
- Reward: Chocobo License key item + Chocobo Trainer title

### Code Verification

**Script:** `scripts/quests/jeuno/Chocobos_Wounds.lua` — FULLY IMPLEMENTED

**Quest flow:**
1. Section 1 (QUEST_AVAILABLE + lv20): Brutus in Upper Jeuno triggers event 71
2. Accept quest -> `Prog = 1`; also flags Chocobo on the Loose if ToAU enabled
3. Section 2 (QUEST_ACCEPTED): Chocobo trade handler
   - Rejects Gysahl Greens (event 76 — correct, bg-wiki warns about this)
   - Accepts Gausebit Wildgrass (item 534)
   - Timer check: 45-second cooldown between feeds (note: bg-wiki says 1 minute, server uses 45s — slightly more generous)
   - 6 feeding stages via `chocoboFeedTrades` table: events 57, 58, 59, 60, 63, 64
   - Stages 1-2 (events 57, 58): auto-fail, don't consume grass
   - Stages 3-6 (events 59, 60, 63, 64): consume grass via `player:confirmTrade()`
   - Stage 6 (event 64): `quest:complete(player)` grants reward
4. Reward: Chocobo License KI + Chocobo Trainer title + 30 Jeuno fame

**Gausebit Wildgrass sources:**
- Item ID 534 (`CLUMP_OF_GAUSEBIT_WILDGRASS`)
- Available from Auction House or mob drops (Crane Flies, Wadi Hares per bg-wiki)

**Post-quest chocobo rental:**
- `scripts/globals/chocobo.lua` defines rental points in 22 zones
- Level requirement: 15 for nation cities, 20 for field/Jeuno locations
- Requires Chocobo License KI (checked in rental NPC scripts)
- Rental NPCs exist in all major cities and field areas

### Verdict: WORKS
Chocobo license quest is fully functional. Minor difference: 45-second feed timer vs retail 1-minute, but this is more player-friendly.

---

## 8. Supply Quests / Outpost Warps

### bg-wiki Reference
- Players talk to gate guards in home nation to accept supply runs to outposts
- Completing supply runs unlocks outpost warps for those regions
- Alternatively, `UNLOCK_OUTPOST_WARPS` setting can grant all warps at start

### Code Verification

**Supply Quest System:** `scripts/globals/conquest.lua`
- Lines 1186+: Supply run logic is implemented
- Accept: Sets `supplyQuest_started`, `supplyQuest_region`, `supplyQuest_fresh` variables (line 1374-1376)
- Complete: Clears variables and grants outpost warp access (line 1391-1393)
- Time limit: Must complete before next conquest tally

**Outpost Warp Setting:** `settings/default/main.lua:123`
- `UNLOCK_OUTPOST_WARPS = 0` (default — must earn via supply runs)
- Set to 1 for all standard warps, 2 to also include Tu'Lia and Tavnazia

**Conquest system checks (lines 85-132):**
- If `UNLOCK_OUTPOST_WARPS == 2`: all warps available
- If `UNLOCK_OUTPOST_WARPS == 1`: standard warps available
- If `UNLOCK_OUTPOST_WARPS == 0`: must complete supply runs (retail behavior)

### Verdict: WORKS
Supply quests are implemented in the conquest system. Server default requires earning outpost warps through supply runs (retail-accurate).

---

## Issues Found

### Issue 1: Snipper Droplist 3913 Does Not Exist (Low Severity)
**What:** Snipper mob pools reference droplist 3913, but this droplist has NO entries in `sql/mob_droplist.sql`. This affects Snippers in zones:
- Jugner Forest [S] (82), Pashhow [S] (90), Jugner Forest (104), Pashhow Marshlands (109), Buburimu Peninsula (118), Qufim Island (126)

**Impact:** Snippers in these zones drop nothing at all — no Rock Salt, no Crab Shell, no Crab Meat.

**Not affected:** Valkurm Dunes (103) Snippers use droplist 2281, which DOES exist and includes Crab Apron. Since Valkurm is the relevant zone for the subjob quest, the quest itself is unaffected.

**Files:**
- `sql/mob_groups.sql` — Snipper entries referencing droplist 3913
- `sql/mob_droplist.sql` — missing droplist 3913 entries

### Issue 2: Bogy in Gusgen Mines Past (zone 90) Missing Bloody Robe (Very Low Severity)
**What:** Bogy in zone 90 (Pashhow Marshlands [S]) uses droplist 320, which does not include Bloody Robe. All present-day Bogys (droplists 321, 322) do have Bloody Robe.

**Impact:** Negligible. No player would farm Bloody Robe in a past zone.

### Issue 3: Ghouls in Past Zones Missing Magicked Skull (Very Low Severity)
**What:** Ghoul_war/Ghoul_blm in zones 82/90 (Jugner/Pashhow [S]) use droplists 953/958, which do NOT contain Magicked Skull. Present-day zone droplists (960, 962, 959) all have it.

**Impact:** Negligible. Past zones are not accessible at level 18.

---

## Overall Verdict: WORKS

The level 10-30 experience is functional. All critical systems are implemented:
- Sub-job quest: Both paths work, all items are obtainable from correct mobs in correct zones
- Fields of Valor: Fully implemented in all key leveling zones with correct rewards
- Grounds of Valor: Fully implemented in key dungeons
- Zone progression: All zones accessible, Survival Guides present
- Trust expansion: Nation trust quests work, cipher trading works, FoV tab ciphers available
- Chocobo license: Quest fully scripted with correct NPC interactions and reward
- Supply quests: Conquest system handles outpost warp unlocks
- Settings are all at retail-default values

The only notable issue is the missing Snipper droplist 3913, which causes Snippers in most zones to drop nothing. This does not affect the subjob quest (Valkurm Snippers have correct drops) but is a data integrity issue worth tracking.
