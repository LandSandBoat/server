# Leveling 75-99: Deep Audit

## Overview

The 75-99 range is the post-Abyssea era where leveling changes fundamentally. Players must complete a chain of limit break quests to raise their cap from 75 through 80, 85, 90, 95, and finally 99. The primary leveling method shifts from traditional XP parties to Abyssea farming with light-based XP bonuses.

---

## Limit Break Quest Chain (75-99)

All LB quests 6-10 share the same NPC: **Nomad Moogle** in Ru'Lude Gardens (H-5), and use the shared event 10045. The quest scripts form a sequential chain -- each requires the previous to be completed.

### Prerequisite: LIMIT_BREAKER Key Item

Before any post-75 LB quest can begin, the player needs the `xi.ki.LIMIT_BREAKER` key item. This is obtained by talking to the Nomad Moogle at level 75 (event 10045, option 4). The LB06 script handles granting this KI.

**Script:** `scripts/quests/jeuno/LB06_New_Worlds_Await.lua` (lines 57-73)

**Status: WORKS** -- KI grant is coded correctly.

---

### LB6: New Worlds Await (75->80)

**bg-wiki:** Talk to Nomad Moogle, trade 5 Kindred's Seals + have 3 Merit Points.

**Script:** `scripts/quests/jeuno/LB06_New_Worlds_Await.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisites | Level 75, have Limit Breaker KI | Checks `player:getLevelCap() == 75`, `LIMIT_BREAKER` KI, `MAX_LEVEL > 75` | OK |
| Accept quest | Talk to Nomad Moogle | Event 10045, option 5 -> `quest:begin(player)` | OK |
| Trade | 5 Kindred's Seals + 3 Merit Points | `tradeHasExactly(trade, { { xi.item.KINDREDS_SEAL, 5 } })` + `getMeritCount() > 2` | OK |
| Reward | Level cap 80 | `setLevelCap(80)`, consumes 3 merits, consumes seals via `tradeComplete()` | OK |

**Note:** bg-wiki says "Kindred's Seals" and script uses `xi.item.KINDREDS_SEAL` (5). Merit check is `> 2` meaning need at least 3. Both match.

**Verdict: FULLY FUNCTIONAL**

---

### LB7: Expanding Horizons (80->85)

**bg-wiki:** Trade 5 Kindred's Crests + have 4 Merit Points.

**Script:** `scripts/quests/jeuno/LB07_Expanding_Horizons.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisites | Completed New Worlds Await, level cap 80 | Checks `hasCompletedQuest(NEW_WORLDS_AWAIT)` + `getLevelCap() == 80` | OK |
| Accept quest | Talk to Nomad Moogle | Event 10045, option 7 -> `quest:begin(player)` | OK |
| Trade | 5 Kindred's Crests + 4 Merit Points | `tradeHasExactly(trade, { { xi.item.KINDREDS_CREST, 5 } })` + `getMeritCount() > 3` | OK |
| Reward | Level cap 85 | `setLevelCap(85)`, consumes 4 merits, `confirmTrade()` | OK |

**Note:** Crests (not Seals) this time. Merit check `> 3` = need 4+. Matches wiki.

**Verdict: FULLY FUNCTIONAL**

---

### LB8: Beyond the Stars (85->90)

**bg-wiki:** Trade 10 Kindred's Crests + 5 Merit Points, then win a Rock-Paper-Scissors minigame.

**Script:** `scripts/quests/jeuno/LB08_Beyond_the_Stars.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisites | Completed Expanding Horizons, level cap 85 | Checks `hasCompletedQuest(EXPANDING_HORIZONS)` + `getLevelCap() == 85` | OK |
| Accept quest | Talk to Nomad Moogle | Event 10045, option 9 -> `quest:begin(player)` | OK |
| Trade | 10 Kindred's Crests + 5 Merit Points | `tradeHasExactly(trade, { { xi.item.KINDREDS_CREST, 10 } })` + `getMeritCount() > 4` | OK |
| Minigame | Rock-Paper-Scissors with Degenhard | Event 10161, Degenhard's moves random (0-2), RPS logic coded | OK |
| Reward | Level cap 90 | `setLevelCap(90)` on event finish option 254 | OK |

**Script Notes:**
- TODO comment: "Properly code the rock, paper, scissors minigame. Awaiting for a capture." However, the minigame IS coded -- event 10161 handles it with onEventUpdate choosing moves.
- Degenhard's move is `math.random(0, 2)`, RPS logic is: Red beats Blue, Blue beats Green, Green beats Red.
- The event itself likely tracks HP; the script just feeds move outcomes back.

**Verdict: FUNCTIONAL** (minigame works but may not be 100% retail-accurate per the TODO)

---

### LB9 Part 1: Dormant Powers Dislodged (90->95)

**bg-wiki:** Trade 1 Kindred's Crest + 1 random item + have 10 Merit Points, then win a timing minigame.

**Script:** `scripts/quests/jeuno/LB09_1_Dormant_Powers_Dislodged.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisites | Completed Beyond the Stars, level cap 90 | Checks `hasCompletedQuest(BEYOND_THE_STARS)` + `getLevelCap() == 90` | OK |
| Random item | One of: Sunsand, Faded Crystal, Orcish Plate Armor, Magicked Skull, Dhalmel Saliva, Yagudo Caulk, Siren's Tear, Dangruf Stone, Orcish Axe, Quadav Backscale | 10 items in `itemWantedTable[0-9]`, randomly selected and persisted via `quest:setVar('itemWanted')` | OK |
| Trade | 1 Kindred's Crest + random item + 10 merits | `tradeHasExactly(trade, { { KINDREDS_CREST, 1 }, { itemToTrade, 1 } })` + `getMeritCount() > 9` | OK |
| Timing minigame | Press at ~10 seconds | Event 10192, win window is 540-659 frames (~9-11 seconds) | OK |
| Reward | Soul Gem KI + level cap 95 | `quest.reward.keyItem = xi.ki.SOUL_GEM`, `setLevelCap(95)` | OK |

**Script Notes:**
- TODO: "Timing minigame was guesstimated! No capture available." The timing window (frames 540-659) is a best guess.
- bg-wiki mentions "Bloody Robe", "Damselfly Worm", "Wild Rabbit Tail", "Crab Apron" which are NOT in the script's 10-item table. The script has Orcish Plate Armor and Quadav Backscale instead. **Minor mismatch with retail item pool** but functionally works since only one random item is requested.

**Verdict: FUNCTIONAL** (timing minigame is approximate, item pool slightly differs from wiki)

---

### LB9 Part 2: Prelude to Puissance (95 -> unlocks Beyond Infinity)

**bg-wiki:** Trade a Seasoning Stone to Nomad Moogle. Receive Soul Gem Clasp KI.

**Script:** `scripts/quests/jeuno/LB09_2_Prelude_to_Puissance.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisites | Completed Dormant Powers Dislodged, level cap 95 | Checks both conditions | OK |
| Trade | Seasoning Stone | `tradeHasExactly(trade, xi.item.SEASONING_STONE)` | OK |
| Reward | Soul Gem Clasp KI | `quest.reward.keyItem = xi.ki.SOUL_GEM_CLASP` | OK |
| Transition | Completes quest and can immediately start Beyond Infinity | Options 13/14/19/20/21 complete quest AND start next quest + warp to BCNM | OK |

**Script Notes:**
- This quest seamlessly transitions into Beyond Infinity. Most options both complete Prelude and begin Beyond Infinity in the same event.
- Option 15 = rejected starting LB10 (but still completes Prelude).
- Warp destinations: Horlais Peak, Waughroon Shrine, Balga's Dais, Qu'Bia Arena.

**Verdict: FULLY FUNCTIONAL**

---

### LB10: Beyond Infinity (95->99)

**bg-wiki:** Fight Atori-Tutori in a BCNM. Requires Soul Gem + Soul Gem Clasp KIs. Trusts allowed. 6 players max. Then return to Nomad Moogle.

**Script:** `scripts/quests/jeuno/LB10_Beyond_Infinity.lua`

**Battlefield scripts exist in 4 zones:**
- `scripts/battlefields/Horlais_Peak/beyond_infinity.lua`
- `scripts/battlefields/Waughroon_Shrine/beyond_infinity.lua`
- `scripts/battlefields/Balgas_Dais/beyond_infinity.lua`
- `scripts/battlefields/QuBia_Arena/beyond_infinity.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisites | Completed Prelude to Puissance, level cap 95 | Checks completion + cap | OK |
| Entry | Choose a BCNM zone | Warps to one of 4 zones | OK |
| BCNM | Fight Atori-Tutori, 6-player, trusts allowed, 10-min limit | `maxPlayers = 6`, `allowTrusts = true`, `timeLimit = 10 min`, `levelCap = 99` | OK |
| Required KIs | Soul Gem Clasp (consumed on entry) | `requiredKeyItems = { xi.ki.SOUL_GEM_CLASP }` | OK |
| Mob | Atori-Tutori (3 mob entries) | `horlaisID.mob.ATORI_TUTORI` + 2 adds | OK |
| Win reward | Scroll of Instant Warp | `giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)` | OK |
| Return | Talk to Nomad Moogle | Event 10139 -> `setLevelCap(99)` | OK |
| Failure | Re-entry costs 1 Merit Point or 5 High Kindred's Crests | Both paths coded: merit deduction via onEventUpdate, or trade 5 High Kindred's Crests | OK |

**bg-wiki mentions optional Olde Rarab Tail (from Degenhard):** The script for Degenhard exists at `scripts/zones/Bastok_Markets/npcs/Degenhard.lua`. This is the item that removes Atori-Tutori's damage cap.

**Script Notes:**
- After completing Beyond Infinity, the script also handles granting `xi.ki.JOB_BREAKER` for lv99 players (event 10240, option 28). This is the "Martial Mastery" questline transition.
- TODO comment: "Move all of this to martial mastery quest" -- the Job Breaker KI grant is currently bundled here.

**Verdict: FULLY FUNCTIONAL**

---

### LB Quest Summary (75->99 Cap Raises)

| Quest | Cap | Script Exists | Functional | Issues |
|-------|-----|--------------|------------|--------|
| New Worlds Await | 75->80 | Yes | Yes | None |
| Expanding Horizons | 80->85 | Yes | Yes | None |
| Beyond the Stars | 85->90 | Yes | Yes | Minigame TODO (works but may not be perfectly retail) |
| Dormant Powers Dislodged | 90->95 | Yes | Yes | Timing minigame approximate; item pool slightly differs from wiki |
| Prelude to Puissance | Grants Soul Gem Clasp | Yes | Yes | None |
| Beyond Infinity | 95->99 | Yes + 4 battlefields | Yes | None |

---

## Maiden of the Dusk (WotG Mission 51) -- NOT a Limit Break

This is a **Wings of the Goddess mission**, not a traditional LB quest. It does NOT raise the level cap. It is mission 51 in the WotG chain (out of 54 total).

**Script:** `scripts/missions/wotg/51_Maiden_of_the_Dusk.lua`

| Step | bg-wiki | Script | Status |
|------|---------|--------|--------|
| Prerequisite | Complete "Fork in the Road" (WotG Mission 50) | Mission chain handles this automatically | OK |
| Start | Veridical Conflux in Grauberg (S) at F-5 | `xi.zone.GRAUBERG_S`, `Veridical_Conflux` trigger, event 38 | OK |
| Warp to Walk of Echoes | Accept and teleport | `player:setPos` to Walk of Echoes | OK |
| Cutscene | Arrive in Walk of Echoes | onZoneIn returns event 4 when Status == 1 | OK |
| Ornate Door | Examine to enter battlefield | `_521` NPC, event 5 when Status == 2 | OK |
| BCNM: Lilith fight | Two-phase boss fight | **Battlefield ID 385 exists** in battlefield.lua, but **NO battlefield script exists** in `scripts/battlefields/Walk_of_Echoes/` | **BROKEN** |
| Post-victory | Multiple cutscenes in Walk of Echoes | Events 6, 7, 8, 9 coded with status progression | OK (if BCNM worked) |
| Reward | Moonshade Earring KI | `mission.reward.keyItem = xi.ki.MOONSHADE_EARRING` | OK |

**CRITICAL ISSUE:** The battlefield for Maiden of the Dusk (Lilith fight) has no script in `scripts/battlefields/Walk_of_Echoes/`. The directory `scripts/battlefields/Walk_of_Echoes/` does not exist at all. The mission script references battlefield event 32001 in the Walk of Echoes zone but there is no corresponding battlefield script to handle mob spawning, AI, or win conditions.

The TODO comments in the mission script confirm this:
- Line 71-73: "TODO: BCNM entry requires Primal Glow KI and Status variable set to 3."

**This means the Lilith fight cannot be entered or completed.** Players will get stuck at the Ornate Door in Walk of Echoes. However, this is a WotG endgame mission (mission 51 of 54), not a level cap quest. Level caps are handled entirely by the LB6-10 chain above.

**Verdict: BROKEN** (Lilith battlefield not implemented, but this does NOT block leveling to 99)

---

## Leveling Methods (75-99)

### 1. Abyssea Leveling (Primary Method)

**Entry Requirements:**
- Level 30+ (checked in Cavernous Maw script: `player:getMainLvl() >= 30`)
- Abyssea enabled (`xi.settings.main.ENABLE_ABYSSEA == 1`)
- Complete "A Journey Begins" quest (talk to Joachim in Port Jeuno, get Traverser Stone KI)
- Have at least 1 Traverser Stone to enter

**Script: Entry via Cavernous Maws**
- Example: `scripts/zones/Konschtat_Highlands/npcs/Cavernous_Maw.lua`
- Checks: `canEnterAbyssea(player)` and `getHeldTraverserStones(player) >= 1`
- Entry scripted for all 9 Abyssea zones (3 Visions, 3 Scars, 3 Heroes)

**Traverser Stones:**
- `scripts/quests/abyssea/A_Journey_Begins.lua` -- grants first stone and starts epoch timer
- `setTraverserEpoch()` begins the accumulation timer
- Stones accrue over real time; checked via `getHeldTraverserStones(player)`

**Light System:**
- `scripts/globals/abyssea/lights.lua` -- every mob in every Abyssea zone has defined light values (azure, pearl, ruby, amber)
- Pearl light = XP bonus (confirmed: `PEARL` type mapped to physical kills, line 520 of abyssea.lua)
- Azure/Ruby/Amber lights affect treasure chest quality
- Light values are extensively defined for all 9 zones

**XP from Abyssea:**
- Mobs in Abyssea give normal XP based on level difference
- Pearl light accumulation increases XP bonus (handled C++-side in charutils.cpp)
- Sturdy Pyxis (treasure chests) can give XP: `scripts/globals/abyssea/sturdypyxis/experience.lua` -- `member:addExp(exp)` to all alliance members in zone
- Dominion Ops (kill quests) give 1000 base XP * multiplier: `scripts/globals/abyssea/dominion.lua` line 148

**Abyssea Zone Infrastructure:**
- All 9 zone scripts exist with proper `onZoneIn`, `afterZoneIn`, trigger areas for wards
- Conflux teleport system: `scripts/globals/abyssea/conflux.lua`
- Cruor Prospector vendors: Perle/Aurore/Teal gear available (lines 82-103 of abyssea.lua)
- Dominion Ops: 42 total ops across 3 zones (Altepa, Uleguerand, Grauberg)

**Verdict: FUNCTIONAL** -- Abyssea entry, light system, XP, Dominion Ops, and Cruor vendors all scripted.

---

### 2. Fields of Valor / Grounds of Valor

**Settings:** Both enabled by default (`ENABLE_FIELD_MANUALS = 1`, `ENABLE_GROUNDS_TOMES = 1`)

**Script:** `scripts/globals/regimes.lua`

**FoV (outdoor zones):** Available in many zones, but pages cap out around level 78 range. Examples:
- Boyahda Tree: pages go up to lv75-78 range (reward ~1770-1900 gil/tabs)
- Some pages reach lv102-105 (Boyahda Tree page 8: `{ 2, 2, 2, 0, 102, 105, 2040, 726 }`)

**GoV (dungeon zones):** Also available with pages for higher levels:
- GoV has up to 10 pages per zone
- Supports: Repatriation, Circumspection, Homing Instinct, Reraise I/II/III, Regen, Refresh, Protect, Shell, Haste, plus food buffs
- Includes Trust ciphers (Sakura, Koru-Moru) for 300 tabs each

**GoV zones with 75+ pages exist** in zones like:
- Boyahda Tree (up to lv105)
- Upper Delkfutt's Tower (lv62-69)
- Cape Teriggan (has GoV pages reaching into 75+ territory)
- Various other zones

**Verdict: FUNCTIONAL** -- Both FoV and GoV work. GoV zones cover the 75-99 range.

---

### 3. Merit Points

**Earned at:** Level 75 (when XP bar is "capped" at max level)

**C++ Implementation:** `src/map/merit.cpp`
- Categories: HP/MP, Attributes, Combat Skills, Defensive Skills, Magic Skills, Others, Job-specific (Group 1 & 2), Weapon Skills
- `MAX_LIMIT_POINTS = 10000` (10,000 limit points = 1 merit point)
- Upgrade costs scale per category (e.g., HP/MP: 1,2,3,4,5... merits per rank)
- Cap array defines max merits per level range

**Lua bindings exist:** `getMeritCount()`, `setMerits()`, used extensively in LB quest scripts

**Merit spending:** Required for limit break quests:
- LB6: 3 merits
- LB7: 4 merits
- LB8: 5 merits
- LB9: 10 merits
- LB10: 1 merit (for BCNM re-entry on failure)

**Job-specific merits:** Handled per-job in `src/map/merit.cpp` with categories for each job group.

**Verdict: FUNCTIONAL** -- Merit point earning and spending works. Categories and upgrade costs are defined.

---

### 4. Equipment at 75-99

#### Sparks Vendor Gear (Lv.71-98)

**Script:** `scripts/globals/sparkshop.lua`, section [9]

Available weapons (43 items), including:
- Manoples (H2H, 1033 sparks)
- Various daggers, swords, axes, scythes, polearms, katanas, clubs, staves, bows, guns, crossbows
- Shields (Ritter, Ice, Koenig, Acheron, Gleaming)
- Prices: 300-2755 sparks

**No armor in the 71-98 range** from sparks. Armor jumps from lower tiers directly to Lv.99 sets (Outrider/Espial/Wayfarer).

#### Perle/Aurore/Teal Sets (from Abyssea Cruor Vendor)

**Script:** `scripts/globals/abyssea.lua`, lines 82-103

All 15 pieces available for Cruor:
- Perle set (Salade, Hauberk, Moufles, Brayettes, Sollerets): 3000-5000 Cruor
- Aurore set (Beret, Doublet, Gloves, Brais, Gaiters): 3000-5000 Cruor
- Teal set (Chapeau, Saio, Cuffs, Slops, Pigaches): 3000-5000 Cruor

These are level 78 base sets. +1 versions (lv90) were previously audited (see MEMORY.md -- 9 missing +1 items were identified for head/body/hands).

#### AF+1 Upgrades via Sagheera

**Script:** `scripts/zones/Port_Jeuno/npcs/Sagheera.lua`

Trade formula: AF base piece + Temenos item + Apollyon item + Crafted item + Ancient Beastcoins (ABC)
- 75 combinations defined (15 jobs x 5 armor slots)
- ABC costs range from 15-40 per piece
- Materials come from Limbus (Temenos/Apollyon drops)

**Verdict: FUNCTIONAL** -- Sagheera AF+1 upgrade system is fully scripted with all 75 combinations.

---

## Summary of Issues

### Blocking Issues
None for the 75-99 leveling path itself.

### Non-Blocking Issues
1. **Maiden of the Dusk (WotG 51):** Lilith battlefield not implemented. Does NOT affect level caps but blocks WotG storyline completion. Players who want to complete WotG will be stuck here.

2. **Beyond the Stars minigame:** Rock-Paper-Scissors has a TODO about not being perfectly retail-accurate, but it functions.

3. **Dormant Powers Dislodged:** Timing minigame is "guesstimated" and item pool has minor differences from retail. Functions but may feel slightly off.

4. **Sparks gear gap:** No Sparks armor in 71-98 range. Players go from lower-level sparks armor straight to lv99 sets, creating a gear gap. This matches retail behavior -- Perle/Aurore/Teal (from Abyssea Cruor) or AF/AF+1 fill this gap instead.

### File Paths Referenced
- `/scripts/quests/jeuno/LB06_New_Worlds_Await.lua`
- `/scripts/quests/jeuno/LB07_Expanding_Horizons.lua`
- `/scripts/quests/jeuno/LB08_Beyond_the_Stars.lua`
- `/scripts/quests/jeuno/LB09_1_Dormant_Powers_Dislodged.lua`
- `/scripts/quests/jeuno/LB09_2_Prelude_to_Puissance.lua`
- `/scripts/quests/jeuno/LB10_Beyond_Infinity.lua`
- `/scripts/missions/wotg/51_Maiden_of_the_Dusk.lua`
- `/scripts/battlefields/Horlais_Peak/beyond_infinity.lua` (+ 3 other zones)
- `/scripts/globals/abyssea.lua`
- `/scripts/globals/abyssea/lights.lua`
- `/scripts/globals/abyssea/dominion.lua`
- `/scripts/globals/abyssea/sturdypyxis/experience.lua`
- `/scripts/globals/regimes.lua`
- `/scripts/globals/sparkshop.lua`
- `/scripts/zones/Port_Jeuno/npcs/Sagheera.lua`
- `/scripts/quests/abyssea/A_Journey_Begins.lua`
- `/scripts/zones/Konschtat_Highlands/npcs/Cavernous_Maw.lua`
- `/src/map/merit.cpp`
- `/settings/default/main.lua` (MAX_LEVEL = 99, EXP_RATE, FoV/GoV settings)
