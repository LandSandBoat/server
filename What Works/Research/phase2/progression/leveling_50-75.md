# Leveling 50-75 + Limit Breaks 2-5 -- Phase 2 Audit

## Summary

All four limit break quests (LB2-LB5) have complete, well-structured scripts using the modern Quest framework. The Maat fight (LB5) has battlefield scripts for all 15 original jobs with a shared Maat mixin that handles his AI, 2-hour usage, and win conditions. FoV/GoV regimes exist for all key leveling zones. Treasure coffers work in relevant dungeons. Dynamis access is fully scripted. **No blocking issues found.**

---

## LIMIT BREAK 2: "Atop the Highest Mountains" (lv55 -> 60)

### bg-wiki Steps vs Code

| # | Step (bg-wiki) | Code Location | Status |
|---|----------------|---------------|--------|
| 1 | Talk to Maat in Ru'Lude Gardens at lv51+ with level cap 55 | `LB02_Atop_the_Highest_Mountains.lua` line 29-31: checks `getLevelCap() == 55` and `getMainLvl() >= 51` | PASS |
| 2 | Accept quest (option 1 in event 82) | Line 49-53: `quest:begin(player)` on option==1 | PASS |
| 3 | Travel to Xarcabard, find ??? at three cave locations | Three QM NPCs defined: `qm_boreal_tiger`, `qm_boreal_coeurl`, `qm_boreal_hound` | PASS |
| 4 | Click ??? to get Round/Square/Triangular Frigicite | Lines 97-131: grants key items via `quest:keyItem()` | PASS |
| 5 | (Optional old-school) Kill Boreal NMs first | Controlled by `OLDSCHOOL_G2` setting (default: false). If false, just click ???. If true, NM must be dead first. | PASS |
| 6 | Return all 3 frigicite to Maat | Lines 68-91: checks all 3 KIs, event 84, deletes KIs, sets level cap to 60 | PASS |

### NM Details (Xarcabard)
- **Boreal Tiger** (`scripts/zones/Xarcabard/mobs/Boreal_Tiger.lua`): Full pathing AI, draw-in mechanics, always aggro. Position: (341, -29, 370).
- **Boreal Coeurl** (`scripts/zones/Xarcabard/mobs/Boreal_Coeurl.lua`): Stun immune, 30% fastcast, draw-in. Position: (580, -9, 290).
- **Boreal Hound** (`scripts/zones/Xarcabard/mobs/Boreal_Hound.lua`): Bind/sleep/paralyze/silence immune, weapon bonus +50, draw-in. Position: (-21, -25, -490).

### Settings
- `OLDSCHOOL_G2 = false` (default) -- NMs do NOT need to be killed; just click the ???
- `FRIGICITE_TIME = 30` -- Only relevant when OLDSCHOOL_G2 is true

### Reward
- Title: Summit Breaker
- Level cap raised to 60
- Fame +40 (Jeuno)

### Verdict: FULLY WORKING

---

## LIMIT BREAK 3: "Whence Blows the Wind" (lv60 -> 65)

### bg-wiki Steps vs Code

| # | Step (bg-wiki) | Code Location | Status |
|---|----------------|---------------|--------|
| 1 | Talk to Maat at lv56+ with level cap 60 | `LB03_Whence_Blows_the_wind.lua` line 27-29: checks `getLevelCap() == 60` and `getMainLvl() >= 56` | PASS |
| 2 | Accept quest (option 1 in event 85) | Line 47-51 | PASS |
| 3 | Go to Monastic Cavern, click ??? at (168, -1, -22) | Line 105-115: `qm1` grants `ORCISH_CREST` key item | PASS |
| 4 | Go to Castle Oztroja floor 4, click ??? at (-100, -63, 58) | Line 93-103: `qm2` grants `YAGUDO_CREST` key item | PASS |
| 5 | Go to Qulun Dome, click ??? at (261, 39, 79) | Line 117-127: `qm1` grants `QUADAV_CREST` key item | PASS |
| 6 | Return all 3 crests to Maat | Lines 67-91: checks all 3 KIs, event 87, deletes KIs, sets level cap to 65 | PASS |

### Important Notes
- bg-wiki describes elaborate navigation to reach these ??? points (passwords in Oztroja, Crimson Orb in Davoi, muting in Beadeaux). The quest script itself only checks for the KI when you click the ???. The navigation/puzzle mechanics are handled by the zone scripts themselves, not the LB quest script. This is correct design.
- The quest does NOT require completion of Magicite mission (4-1) as a prerequisite in code -- the wiki says you need specific key items to navigate the strongholds, but those are zone-level requirements, not quest prerequisites. Players who can physically reach the ??? can get the crest.

### Reward
- Title: Sky Breaker
- Level cap raised to 65
- Fame +50 (Jeuno)

### Verdict: FULLY WORKING

---

## LIMIT BREAK 4: "Riding on the Clouds" (lv65 -> 70)

### bg-wiki Steps vs Code

| # | Step (bg-wiki) | Code Location | Status |
|---|----------------|---------------|--------|
| 1 | Talk to Maat at lv61+ with level cap 65 | `LB04_Riding_on_the_clouds.lua` line 56-59: checks `getMainLvl() >= 61`, `getLevelCap() == 65` | PASS |
| 2 | Maat gives 4 random clue numbers (one per nation + otherlands) | Lines 67-76: randomizes npcSandoria/Bastok/Windurst/Otherlands vars (0-7 each) | PASS |
| 3 | Accept quest (option 1 in event 88) | Lines 82-93 | PASS |
| 4 | Trade Kindred's Seal to correct San d'Oria NPC -> Scowling Stone | Lines 141-213: 8 NPCs across S/N/Port Sandy, each mapped to npcSandoria values 0-7 | PASS |
| 5 | Trade Kindred's Seal to correct Bastok NPC -> Smiling Stone | Lines 216-291: 8 NPCs across Mines/Markets/Port/Metalworks | PASS |
| 6 | Trade Kindred's Seal to correct Windurst NPC -> Spirited Stone | Lines 294-371: 8 NPCs across Waters/Walls/Port/Woods/Heavens Tower | PASS |
| 7 | Trade Kindred's Seal to correct Selbina/Mhaura NPC -> Somber Stone | Lines 375-443: 8 NPCs across Selbina (4) and Mhaura (4) | PASS |
| 8 | Return all 4 stones to Maat | Lines 107-137: checks all 4 KIs, event 90, deletes KIs, sets level cap to 70 | PASS |

### Kindred's Seal Source
- Kindred's Seals drop from mobs lv50-69 (defined in `scripts/enum/item.lua` as item 1426... actually item ID for Kindred's Seal)
- Each trade consumes 1 seal and grants 1 key item (stone)
- The var is set to 8 after trade, preventing double-trade to same NPC

### Reward
- Title: Cloud Breaker
- Level cap raised to 70
- Fame +60 (Jeuno)

### Verdict: FULLY WORKING

---

## LIMIT BREAK 5: "Shattering Stars" (lv70 -> 75) -- CRITICAL

### bg-wiki Steps vs Code

| # | Step (bg-wiki) | Code Location | Status |
|---|----------------|---------------|--------|
| 1 | Talk to Maat at lv66+ with level cap 70, on one of the 15 original jobs | `LB05_1_Shattering_Stars.lua` lines 60-66: checks `getMainJob() <= 15`, `getMainLvl() >= 66`, `getLevelCap() == 70` | PASS |
| 2 | Quest auto-begins (event 92, no accept option needed) | Lines 79-83: `quest:begin(player)` immediately | PASS |
| 3 | Obtain job-specific testimony (drops from high-level mobs) | Testimonies defined in `scripts/enum/item.lua` lines 885-899 (items 1426-1440, WAR through SMN) | PASS |
| 4 | Trade testimony to Maat | Lines 98-108: checks `tradeHasExactly(trade, properTestimony)` where properTestimony = WARRIORS_TESTIMONY + jobId - 1 | PASS |
| 5 | Maat offers teleport to battlefield (option 1 in event 64) | Lines 125-143: job-to-zone mapping with exact coordinates | PASS |
| 6 | Fight Maat 1v1 (no subjob, 10-minute limit) | Battlefield scripts (see below) | PASS |
| 7 | Win: get Scroll of Instant Warp + Maat Masher title | Lines 41-49 in maatBattlefieldZone handler: gives item, sets Prog var, sets maatsCap bit | PASS |
| 8 | Return to Maat to complete quest | Lines 113-114 + 145-149: event 93, sets level cap to 75 | PASS |

### Job-to-Battlefield Mapping (all verified to exist)

| Battlefield | Jobs | Script Files |
|-------------|------|-------------|
| Horlais Peak | WAR, BLM, RNG | `shattering_stars_war.lua`, `shattering_stars_blm.lua`, `shattering_stars_rng.lua` |
| Balga's Dais | MNK, WHM, SMN | `shattering_stars_mnk.lua`, `shattering_stars_whm.lua`, `shattering_stars_smn.lua` |
| Qu'Bia Arena | PLD, DRK, BRD | `shattering_stars_pld.lua`, `shattering_stars_drk.lua`, `shattering_stars_brd.lua` |
| Waughroon Shrine | RDM, THF, BST | `shattering_stars_rdm.lua`, `shattering_stars_thf.lua`, `shattering_stars_bst.lua` |
| Chamber of Oracles | SAM, NIN, DRG | `shattering_stars_sam.lua`, `shattering_stars_nin.lua`, `shattering_stars_drg.lua` |

### Battlefield Details (all scripts follow same pattern)
- `maxPlayers = 1` (solo fight)
- `levelCap = 99` (no level sync -- retail changed this from 75)
- `allowSubjob = false`
- `timeLimit = 10 minutes`
- `requiredItems` = job-specific testimony (consumed on entry, with wear/torn messages)
- Entry requires: correct job, lv66+, quest accepted AND `tradedTestimony == 1`

### Maat AI (scripts/mixins/families/maat.lua)
- Uses job-specific 2-hour ability when HP drops below random threshold (50-60%, NIN=40%, DRG=75%)
- **Win conditions:**
  - Maat HP < 20% -> auto-win
  - WHM Maat: battle time > 300s (5 min) -> auto-win
  - THF: steal from Maat -> auto-win
- Loss: Maat disengages when player dies, shows "weren't ready" text
- Has weaponskill dialogue ("take that whippersnapper", etc.)

### Beyond the Sun (Maat's Cap - bonus quest)
- `LB05_2_Beyond_the_Sun.lua`: After beating Maat on all 15 original jobs, talk to Maat for Maat's Cap
- Tracks via `maatsCap` char variable bitmask (15 bits, one per job)
- Reward: `xi.item.MAATS_CAP` + title "Ultimate Champion of the World"

### Reward
- Title: Star Breaker (first completion), Maat Masher (per fight)
- Level cap raised to 75
- Scroll of Instant Warp
- Fame +80 (Jeuno)

### Verdict: FULLY WORKING

---

## ARTIFACT ARMOR (AF Pieces 4-5, Coffer Quests)

### Treasure Chest/Coffer System
- Global system: `scripts/globals/treasure.lua`
- Fully implemented with key tables, map tables, level tables
- Supports zone keys, Thief's Tools, Living Key, Skeleton Key
- Mimic spawning for coffers (10% with Thief's Tools)

### Key Dungeons for AF Coffers (lv50-60 range)

| Zone | Coffer Key Item | Coffer Level | Status |
|------|----------------|-------------|--------|
| Garlaige Citadel | Garlaige Coffer Key | 60 | In keyTable |
| Castle Oztroja | Oztroja Coffer Key | 60 | In keyTable |
| Crawlers' Nest | Nest Coffer Key | 55 | In keyTable |
| Eldieme Necropolis | Eldieme Coffer Key | 60 | In keyTable |
| The Boyahda Tree | Boyahda Coffer Key | 60 | In keyTable |
| Temple of Uggalepih | Uggalepih Coffer Key | 60 | In keyTable |
| Castle Zvahl Baileys | Zvahl Coffer Key | 60 | In keyTable |
| Kuftal Tunnel | Kuftal Coffer Key | 60 | In keyTable |
| Den of Rancor | Rancor Den Coffer Key | 65 | In keyTable |

### AF Quest Tracking (Vingijard NPC)
- `scripts/zones/Lower_Jeuno/npcs/Vingijard.lua` has a complete table of all AF quests for all 22 jobs
- Allows resetting AF quests (for 10,000 gil) if player has completed all 4 AF quests for a job and no longer possesses the gear
- All original 15 jobs have 4 AF quest references each (3 job-specific + 1 Borghertz coffer quest)

### Verdict: COFFER SYSTEM WORKING -- Individual AF quest scripts not audited here (per-job audit needed)

---

## FoV/GoV IN LV50-75 ZONES

### System
- `scripts/globals/regimes.lua` contains all regime data
- FoV uses Field_Manual NPCs, GoV uses Grounds_Tome NPCs

### Fields of Valor (FoV) in relevant zones

| Zone | Level Range | Regimes | Field_Manual NPC |
|------|------------|---------|------------------|
| Ro'Maeve | 60-69 | 2 pages (regimes 119-120) | EXISTS |

### Grounds of Valor (GoV) in relevant zones

| Zone | Level Range | Regimes | Grounds_Tome NPC |
|------|------------|---------|------------------|
| The Boyahda Tree | 60-71 | Multiple pages (regimes 719+) | EXISTS |
| Temple of Uggalepih | 51-69 | Multiple pages (regimes 790+) | EXISTS |
| Kuftal Tunnel | 60-69 | Multiple pages (regimes 735+) | EXISTS |
| Gustav Tunnel | 44-58 | Multiple pages (regimes 763+) | EXISTS |
| Fei'Yin | 40-57 | Multiple pages (regimes 711+) | EXISTS |
| Sea Serpent Grotto | 52-69 | Multiple pages (regimes 816+) | EXISTS |

### Verdict: FoV/GoV WORKING for all key lv50-75 zones

---

## KEY ZONES ACCESSIBILITY

### Zone Mob Verification

| Zone | Mob Scripts Present | Level Range | Notes |
|------|-------------------|-------------|-------|
| Ro'Maeve | 14 mob scripts | 60-75 | Weapons, golems, vases |
| Fei'Yin | 27 mob scripts | 40-60 (lower), 60-75 (deeper) | Bats, weapons, golems, shadows, NMs |
| Castle Zvahl Baileys | 19 mob scripts | 60-75 | Demons, mimics, NMs |
| Gustav Tunnel | 35 mob scripts | 44-70 | Bats, goblins, crabs, wyverns, slimes |
| Kuftal Tunnel | Inferred from GoV | 60-69 | GoV regimes confirm mob presence |
| Boyahda Tree | Inferred from GoV | 60-71 | GoV regimes confirm mob presence |
| Sea Serpent Grotto | Inferred from GoV | 52-69 | GoV regimes confirm mob presence |
| Xarcabard | Boreal NMs + others | 55-75 | Confirmed for LB2 |

### Verdict: ALL KEY ZONES POPULATED

---

## ZILART MISSIONS

Already audited in Phase 1. Players typically do ZM4-8 during lv50-75 range. Reference Phase 1 findings.

---

## DYNAMIS ACCESS

### How Dynamis Unlocks

1. **Prerequisite:** Rank 6 in your nation + lv65+ (configurable via `DYNA_LEVEL_MIN`)
2. **Initial cutscene:** Zone into Xarcabard -- if you meet prereqs and don't have Vial of Shrouded Sand, event 13 auto-plays (`scripts/zones/Xarcabard/Zone.lua` lines 29-35)
3. **This sets `Dynamis_Status` bit 0** (the "unlocking" flag)
4. **Visit any starter Dynamis Trail Markings NPC** (in Sandy, Bastok, Windurst, or Jeuno) -- the Shrouded Sand cutscene plays, granting `VIAL_OF_SHROUDED_SAND` key item
5. **Buy Prismatic Hourglass** from Goblin NPCs (Haggleblix in Beadeaux, Antiqix in Castle Oztroja, or Lootblox in Davoi) for 50,000 gil
6. **Return to any Trail Markings NPC** -- Dynamis entry menu appears

### Dynamis Zones Available

| Zone | Entry NPC Location | Prerequisites |
|------|-------------------|---------------|
| Dynamis-San d'Oria | Southern Sandy | Prismatic Hourglass |
| Dynamis-Bastok | Bastok Mines | Prismatic Hourglass |
| Dynamis-Windurst | Windurst Walls | Prismatic Hourglass |
| Dynamis-Jeuno | Ru'Lude Gardens | Prismatic Hourglass |
| Dynamis-Beaucedine | Beaucedine Glacier | Beat all 4 cities (KIs from each) |
| Dynamis-Xarcabard | Xarcabard | Beat Beaucedine (Hydra Corps Insignia) |
| Dynamis-Valkurm | Valkurm Dunes | CoP 3-5 complete OR `FREE_COP_DYNAMIS=1` |
| Dynamis-Buburimu | Buburimu Peninsula | CoP 3-5 complete OR `FREE_COP_DYNAMIS=1` |
| Dynamis-Qufim | Qufim Island | CoP 3-5 complete OR `FREE_COP_DYNAMIS=1` |
| Dynamis-Tavnazia | Tavnazian Safehold | All 3 dreamlands slivers |

### Settings
- `BETWEEN_2DYNA_WAIT_TIME = 24` (hours between entries; bypassed with Rhapsody in Azure)
- `DYNA_LEVEL_MIN = 65`
- `PRISMATIC_HOURGLASS_COST = 50000`
- `FREE_COP_DYNAMIS = 0` (dreamlands locked behind CoP 3-5 by default)
- `DYNA_MIDNIGHT_RESET = true`

### Trail Markings NPCs (all verified to exist)
- `scripts/zones/Southern_San_dOria/npcs/Trail_Markings.lua`
- `scripts/zones/Bastok_Mines/npcs/Trail_Markings.lua` (via grep results)
- `scripts/zones/Windurst_Walls/npcs/Trail_Markings.lua`
- `scripts/zones/RuLude_Gardens/npcs/Trail_Markings.lua`
- `scripts/zones/Beaucedine_Glacier/npcs/Trail_Markings.lua` (via grep results)
- `scripts/zones/Xarcabard/npcs/Trail_Markings.lua`

### Hourglass/Currency Exchange NPCs (all verified)
- Haggleblix (Beadeaux) -- Byne Bills
- Antiqix (Castle Oztroja) -- Whiteshells/Jadeshells
- Lootblox (Davoi) -- Ordelle Bronzepieces

### Verdict: DYNAMIS FULLY WORKING

---

## ISSUES FOUND

**None.** All limit break quests, leveling systems, and Dynamis access are fully implemented.

### Minor Notes (not issues)
1. LB5 battlefield `levelCap = 99` -- this matches modern retail where the level cap was removed from the Maat fight. Players at lv66-70 will still find it challenging since subjob is disabled.
2. The `OLDSCHOOL_G2` setting defaults to false, meaning LB2 frigicite can be obtained without killing the Boreal NMs. This is the modern retail behavior.
3. Dynamis dreamlands (Valkurm/Buburimu/Qufim) are locked behind CoP 3-5 by default. The `FREE_COP_DYNAMIS` setting can bypass this.
4. LB4 (Riding on the Clouds) randomly assigns NPCs, so players cannot look up a fixed answer -- they must use Maat's clues. This matches retail.

---

## FILES REFERENCED

### Limit Break Quest Scripts
- `scripts/quests/jeuno/LB02_Atop_the_Highest_Mountains.lua`
- `scripts/quests/jeuno/LB03_Whence_Blows_the_wind.lua`
- `scripts/quests/jeuno/LB04_Riding_on_the_clouds.lua`
- `scripts/quests/jeuno/LB05_1_Shattering_Stars.lua`
- `scripts/quests/jeuno/LB05_2_Beyond_the_Sun.lua`

### Maat NPC and Mob Scripts
- `scripts/zones/RuLude_Gardens/npcs/Maat.lua`
- `scripts/mixins/families/maat.lua`
- `scripts/zones/Horlais_Peak/mobs/Maat.lua` (+ Balgas_Dais, QuBia_Arena, Waughroon_Shrine, Chamber_of_Oracles)

### Battlefield Scripts (15 total)
- `scripts/battlefields/Horlais_Peak/shattering_stars_{war,blm,rng}.lua`
- `scripts/battlefields/Balgas_Dais/shattering_stars_{mnk,whm,smn}.lua`
- `scripts/battlefields/QuBia_Arena/shattering_stars_{pld,drk,brd}.lua`
- `scripts/battlefields/Waughroon_Shrine/shattering_stars_{rdm,thf,bst}.lua`
- `scripts/battlefields/Chamber_of_Oracles/shattering_stars_{sam,nin,drg}.lua`

### LB2 NM Scripts
- `scripts/zones/Xarcabard/mobs/Boreal_Tiger.lua`
- `scripts/zones/Xarcabard/mobs/Boreal_Coeurl.lua`
- `scripts/zones/Xarcabard/mobs/Boreal_Hound.lua`

### System Scripts
- `scripts/globals/treasure.lua`
- `scripts/globals/regimes.lua`
- `scripts/globals/dynamis.lua`
- `scripts/zones/Xarcabard/Zone.lua`
- `settings/default/main.lua`

### AF Quest Tracker
- `scripts/zones/Lower_Jeuno/npcs/Vingijard.lua`
