# Abyssea Content Systems -- Deep Audit

Audited: 2026-03-28
Base path: `scripts/quests/abyssea/`, `scripts/globals/abyssea.lua`, `scripts/globals/abyssea/`, `scripts/zones/Abyssea-*/`

---

## 1. Abyssea Entry Quests

### A Journey Begins (`scripts/quests/abyssea/A_Journey_Begins.lua`)

| Step | Expected (bg-wiki) | Implemented | Status |
|------|-------------------|-------------|--------|
| Quest auto-flags when Abyssea enabled + lv30 | Flagged in onGameIn if ENABLE_ABYSSEA | Yes -- check requires QUEST_ACCEPTED + lv30 | OK |
| CS 324 plays on zone-in to Port Jeuno | `onZoneIn` returns 324 when Prog==0 | Yes | OK |
| Talk to Joachim for CS 325 | `onTrigger` checks Prog==1, returns 325 | Yes | OK |
| Reward: Traverser Stone | `quest.reward = { keyItem = xi.ki.TRAVERSER_STONE1 }` | Yes -- grants TRAVERSER_STONE1 KI | OK |
| Traverser epoch begins | `player:setTraverserEpoch()` called on event 325 finish | Yes -- C++ writes UNIX timestamp to DB | OK |
| The Truth Beckons auto-flags | `player:addQuest()` called after complete | Yes | OK |

**Verdict: FULLY IMPLEMENTED.** Quest flow matches retail.

### The Truth Beckens (`scripts/quests/abyssea/The_Truth_Beckons.lua`)

| Step | Expected (bg-wiki) | Implemented | Status |
|------|-------------------|-------------|--------|
| Auto-flagged on A Journey Begins completion | Flagged via addQuest in A_Journey_Begins | Yes | OK |
| Zone into any Abyssea zone to set Prog=1 | handleOnZoneIn sets Prog=1 for all 9 zones | Yes | OK |
| Return to Joachim | CS 326 (no prog), CS 327 (prog=1) | Yes | OK |
| Reward: traverser cap info displayed | getTraverserCap passed to event 327 | Yes | OK |
| Dawn of Death auto-flags | addQuest called on complete | Yes | OK |

**Verdict: FULLY IMPLEMENTED.**

### Dawn of Death (quest ID 162)

- No dedicated script file -- flagged automatically by The Truth Beckons completion.
- Acts as a prerequisite gate for Cavernous Maw quests. This is correct behavior; Dawn of Death is a "persistent" quest on retail.

**Verdict: OK -- works as prerequisite flag.**

---

## 2. Cavernous Maw Zone Quests (9 total)

These quests are started at Cavernous Maw NPCs in overworld zones, not in `scripts/quests/abyssea/`.

| Quest | Script Location | Zone Entry | NM Title Check | KI Reward | Status |
|-------|----------------|------------|----------------|-----------|--------|
| A Goldstruck Gigas | `scripts/quests/abyssea/A_Goldstruck_Gigas.lua` | La Theine -> Abyssea-La Theine | BRIAREUS_FELLER | getZoneKIReward | OK |
| To Paste a Peiste | `scripts/quests/abyssea/To_Paste_a_Peiste.lua` | Konschtat -> Abyssea-Konschtat | KUKULKAN_DEFANGER | getZoneKIReward | OK |
| Megadrile Menace | `scripts/quests/abyssea/Megadrile_Menace.lua` | La Theine (grants 50 cruor) | GLAVOID_STAMPEDER | getZoneKIReward | OK |
| The Beast of Bastore | `Jugner_Forest/npcs/Cavernous_Maw_2.lua` | Jugner -> Abyssea-Vunkerl | NO SCRIPT | MISSING COMPLETION | PARTIAL |
| A Delectable Demon | NOT FOUND | Buburimu -> Abyssea-Misareaux | NO SCRIPT | MISSING | PARTIAL |
| A Fluttery Fiend | NOT FOUND | Tahrongi -> Abyssea-Attohwa | NO SCRIPT | MISSING | PARTIAL |
| A Beaked Blusterer | `scripts/quests/abyssea/A_Beaked_Blusterer.lua` | S. Gustaberg -> Abyssea-Altepa | BENNU_DEPLUMER | getZoneKIReward | OK |
| A Man Eating Mite | `Xarcabard/npcs/Cavernous_Maw.lua` | Xarcabard -> Abyssea-Uleguerand | NO SCRIPT | MISSING COMPLETION | PARTIAL |
| An Ulcerous Uragnite | `N_Gustaberg/npcs/Cavernous_Maw_2.lua` | N. Gustaberg -> Abyssea-Grauberg | NO SCRIPT | MISSING COMPLETION | PARTIAL |

### Issue Found: 5 of 9 Maw Quests Lack Completion Scripts

The quests THE_BEAST_OF_BASTORE, A_DELECTABLE_DEMON, A_FLUTTERY_FIEND, A_MAN_EATING_MITE, and AN_ULCEROUS_URAGNITE can be **started** (flagged via Cavernous Maw NPC scripts) but have **no completion logic** -- no script checks for the NM title and no script grants the zone KI reward. The Cavernous Maw scripts have placeholder comments like `-- Killed Sedna` with no actual reward logic.

The `getZoneKIReward()` function grants progressive abyssites based on total completed maw quests. Without completion scripts, players cannot earn:
- Lunar Abyssite 2/3
- Ivory Abyssites of Fortune, Acumen, The Reaper, Perspicacity, Guerdon, Prosperity, Destiny

**Impact: HIGH** -- These abyssites are important for Abyssea gameplay. Only 4 of 9 maw quests can be completed.

---

## 3. Scars of Abyssea (`scripts/quests/abyssea/Scars_of_Abyssea.lua`)

| Step | Implemented | Status |
|------|-------------|--------|
| Requires completing THE_BEAST_OF_BASTORE, A_DELECTABLE_DEMON, A_FLUTTERY_FIEND | Checks all three via hasCompletedQuest | OK (logic) |
| Talks to Joachim to begin | CS 337 | OK |
| Completion after all three done | CS 338 | OK |

**Note:** Since the 3 prerequisite quests lack completion scripts, Scars of Abyssea is effectively **BLOCKED**.

---

## 4. Dominion Ops

### Structure

- **42 Dominion Ops total**: 14 per zone x 3 zones (Altepa, Uleguerand, Grauberg)
- Scripts: `scripts/quests/abyssea/{Zone}_Dominion_Op_{01-14}.lua`
- Global logic: `scripts/globals/abyssea/dominion.lua`
- NPC scripts: 3 DSgt NPCs per zone (9 total), each with an OpMask controlling which ops they offer

| Zone | Ops | DSgt NPCs | Quest Script Files | Status |
|------|-----|-----------|-------------------|--------|
| Abyssea-Altepa | 14 | DSgt_Excenmille, DSgt_Nanaa, DSgt_Volker | 14 files present | OK |
| Abyssea-Uleguerand | 14 | DSgt_Maat, DSgt_Romaa, DSgt_Zazarg | 14 files present | OK |
| Abyssea-Grauberg | 14 | DSgt_Wolfgang, DSgt_Cornelia, DSgt_Tosuka | 14 files present | OK |

**Note:** Dominion Ops only exist for Scars of Abyssea zones. Visions zones (Konschtat, La Theine, Tahrongi) and Heroes zones (Attohwa, Misareaux, Vunkerl) do NOT have Dominion Ops -- this is correct per retail (those zones had different NPC systems on retail).

### Rewards Per Op

| Reward | Amount | Implementation |
|--------|--------|----------------|
| XP | 1000 base (scaled by level, 2% penalty per level below 75) | `player:addExp()` | OK |
| Cruor | 200 (baseRewardValue / 5) | `player:addCurrency('cruor', ...)` | OK |
| Dominion Notes | 100 (baseRewardValue / 10) | `player:addCurrency('dominion_note', ...)` | OK |
| Kill requirement | 5 mobs per op | All ops set to 5 | OK |

### Sample Op Verification

| Op | Target Mob | Zone | Kill Count | Status |
|----|-----------|------|-----------|--------|
| Altepa Op 01 | Sand_Sweeper | Abyssea-Altepa | 5 | OK |
| Altepa Op 07 | Desert_Puk | Abyssea-Altepa | 5 | OK |

### Dominion Tactician (Grauberg)

`scripts/zones/Abyssea-Grauberg/npcs/Dominion_Tactician.lua` -- Sells AF3+1 bodies (Unkai, Iga, Lancer's, etc.), temp items, and augmented weapons for Dominion Notes. Fully scripted.

**Verdict: DOMINION OPS FULLY IMPLEMENTED for SoA zones.**

---

## 5. Traverser Stone System

### Epoch/Timer (`src/map/utils/charutils.cpp` lines 7525-7559)

| Feature | Implementation | Status |
|---------|----------------|--------|
| Epoch set on A Journey Begins completion | `setTraverserEpoch()` writes UNIX_TIMESTAMP to `char_unlocks.traverser_start` | OK |
| Stone generation rate | Base 20h per stone, reduced by 4h per Celerity abyssite | OK -- `stoneWaitHours = 20h` then `stoneWaitHours -= 4h` per KI |
| Available stones calculation | `stonesGenerated = elapsedSinceEpoch / stoneWaitHours - traverserClaimed` | OK |
| Cap: 3 base + Avarice abyssites | `getTraverserCap()` -- base 3, +1 per KI from VIRIDIAN to VERMILLION_ABYSSITE_OF_AVARICE | OK |
| Stone KIs: TRAVERSER_STONE1 through TRAVERSER_STONE6 | `getHeldTraverserStones()` iterates KI range | OK |
| Claiming stones from NPC | `traverserNPCOnEventFinish()` adds KIs and calls `addClaimedTraverserStones()` | OK |
| Recharge timer display | `traverserNPCOnUpdate()` calculates remaining minutes | OK |

### Spending Stones (Conflux Surveyor)

| Feature | Implementation | Status |
|---------|----------------|--------|
| Spend stones for Visitant time | `surveyorOnEventFinish()` removes stones, adds time | OK |
| Time per stone: 1800s (30 min), or 3600s with Rhapsody in Mauve | `timePerStone = hasRhapsody and 3600 or 1800` | OK |
| Sojourn bonus: +180s per stone per sojourn abyssite | `additionalStones * (numSojourn * 180)` | OK |
| Max duration: 7200s (2 hours) | `math.min(visitantTime * 1000 + 4, 7200 * 1000)` | OK |
| Stored time on zone-out | `player:getCharVar('abysseaTimeStored')` | OK |

**Verdict: TRAVERSER STONE SYSTEM FULLY IMPLEMENTED.** C++ backend handles epoch, stone generation, and claiming. Lua handles spending and time calculations.

---

## 6. Conflux System (Veridical Confluxes)

### Global Logic: `scripts/globals/abyssea/conflux.lua`

| Feature | Implementation | Status |
|---------|----------------|--------|
| Unlock conflux by interacting | `addTeleport(ABYSSEA_CONFLUX, bit, maskOffset)` | OK |
| Teleport between unlocked confluxes | Cost-based system with cruor | OK |
| Confluence abyssite discount | 20% discount per Confluence abyssite (up to 5) | OK |
| Conflux #00 always active (Heroes zones) | `maskOffset >= 3 and <= 5` sets bit 8 | OK |
| Per-zone mask stored in char_unlocks blob | `zoneMaskID` maps each zone to offset 0-8 | OK |

### Conflux Counts Per Zone

| Zone | Confluxes | Cruor Cost Range | Status |
|------|-----------|-----------------|--------|
| Abyssea-Konschtat | #01-#08 (8) | 50-400 | OK |
| Abyssea-Tahrongi | #01-#08 (8) | 50-400 | OK |
| Abyssea-La Theine | #01-#08 (8) | 50-400 | OK |
| Abyssea-Attohwa | #00-#08 (9) | 200-1600 | OK |
| Abyssea-Misareaux | #00-#08 (9) | 200-1600 | OK |
| Abyssea-Vunkerl | #00-#08 (9) | 200-1600 | OK |
| Abyssea-Altepa | #01-#08 (8) | 600-2000 | OK |
| Abyssea-Uleguerand | #01-#08 (8) | 600-2000 | BUG |
| Abyssea-Grauberg | #01-#08 (8) | 600-2000 | OK |

### Bug Found: Abyssea-Uleguerand Conflux #08 CSID

In `scripts/globals/abyssea/conflux.lua` line 131:
```lua
['Veridical_Conflux_#08'] = { 7, 2138, { ... } },  -- Should be 2139, not 2138
```
Conflux #07 and #08 both use CSID **2138**. All other zones use 2139 for #08. This is likely a copy-paste bug that would cause Conflux #08 in Uleguerand to show the wrong event or malfunction.

**Verdict: CONFLUX SYSTEM FUNCTIONAL with one CSID bug in Uleguerand.**

---

## 7. Empyrean Weapon Trials

Empyrean weapons are handled through the **Magian Trial system**, NOT Abyssea quest scripts.

| Component | Location | Status |
|-----------|----------|--------|
| Magian trial data | `scripts/globals/magian_data.lua` | Present |
| Trial progression (Verethragna example) | Trials found for Verethragna 75->85->90->95->99->99_II | OK |
| Murgleis trials | Multiple trial entries found | OK |
| Abyssea NM kills for trials | Handled by Magian system listeners, not Abyssea quest scripts | Separate system |

The Magian trial system is a separate audit scope. Empyrean weapons do NOT use `scripts/quests/abyssea/` at all.

---

## 8. Additional Abyssea Systems

### Atma System (`scripts/globals/abyssea/atma.lua`)

| Feature | Status |
|---------|--------|
| Atma mods defined for 50+ atmas | OK -- full mod tables |
| Atma Fabricant NPC scripted per zone | Present but `onEventUpdate`/`onEventFinish` are empty stubs | PARTIAL |
| Atma Infusionist NPC scripted per zone | NPC files exist | OK |

### Atma Fabricant Issue

The Atma Fabricant global (`scripts/globals/abyssea/atma_fabricant.lua`) has **empty stubs** for `onEventUpdate` and `onEventFinish`. The fabricant opens the menu (event 2182) but does nothing with the player's selection. This means players cannot **infuse or manage atma** through this NPC.

**Impact: MEDIUM** -- Atma infusion may be handled client-side or by another mechanism, but the empty handlers suggest this is incomplete.

### Lights System (`scripts/globals/abyssea/lights.lua`)

Comprehensive light values defined for all mobs in all 9 Abyssea zones. Pearl, azure, ruby, amber lights all assigned. This system appears complete.

### NM Pop System (qm_ scripts)

All Abyssea zones contain `qm_` (question mark) NPC scripts for NM pops. These handle trade-to-pop mechanics for Abyssea NMs. Present across all zones.

### Sturdy Pyxis

`Sturdy_Pyxis.lua` present in all Abyssea zones for treasure chest drops.

### Cruor Prospector

Cruor Prospector NPCs present in all zones. Global logic in `scripts/globals/abyssea.lua` handles item/temp/buff purchases with cruor.

---

## Summary Table

| System | Files | Status | Issues |
|--------|-------|--------|--------|
| A Journey Begins | 1 quest script | WORKING | None |
| The Truth Beckons | 1 quest script | WORKING | None |
| Dawn of Death | Prereq flag only | WORKING | None |
| Maw Quests (Visions: 3) | 3 quest scripts | WORKING | None |
| Maw Quests (Heroes: 3) | Cavernous Maw NPCs only | INCOMPLETE | No completion scripts for 3 quests |
| Maw Quests (Scars: 3) | Cavernous Maw NPCs only | INCOMPLETE | No completion scripts for 2 quests + A_Beaked_Blusterer OK |
| Scars of Abyssea | 1 quest script | BLOCKED | Prereqs cannot be completed |
| Dominion Ops (42 total) | 42 quest scripts + global | WORKING | None |
| Dominion Tactician | 1 NPC script | WORKING | Sells AF3+1, temps, augmented weapons |
| Traverser Stones | C++ backend + Lua | WORKING | None |
| Conflux Surveyor (time) | Global script | WORKING | None |
| Veridical Confluxes (travel) | 74 NPC scripts + global | WORKING | Uleguerand #08 CSID bug |
| Atma mods | Global script | WORKING | None |
| Atma Fabricant | Global script + per-zone NPCs | INCOMPLETE | Empty event handlers |
| Lights | Global script | WORKING | None |
| NM Pop (qm_ scripts) | Many per zone | PRESENT | Not individually audited |
| Empyrean Weapons | Magian system (separate) | SEPARATE SCOPE | Not in Abyssea quest scripts |

## Critical Issues

1. **5 Maw Quests Cannot Be Completed** -- THE_BEAST_OF_BASTORE, A_DELECTABLE_DEMON, A_FLUTTERY_FIEND, A_MAN_EATING_MITE, AN_ULCEROUS_URAGNITE lack completion logic. Players can start them but never finish them, blocking progressive abyssite rewards (Lunar Abyssite 2/3, various Ivory Abyssites).

2. **Uleguerand Conflux #08 CSID Bug** -- `conflux.lua` line 131 assigns CSID 2138 instead of 2139 for Veridical Conflux #08 in Abyssea-Uleguerand. Duplicate with Conflux #07.

3. **Atma Fabricant Stubs** -- `onEventUpdate` and `onEventFinish` are empty. Atma management through this NPC is non-functional.

4. **Scars of Abyssea Quest Blocked** -- Requires 3 incomplete maw quests to complete.
