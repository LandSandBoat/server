# Crystal War (WotG) Side Quests -- Deep Audit

Audit Date: 2026-03-28
Auditor: Claude Opus 4.6
Source: `scripts/quests/crystalWar/` and `scripts/globals/quests.lua`

---

## Summary

- **Total Crystal War quest IDs defined:** 73 (IDs 0-98, with gaps)
- **Scripts that exist (converted):** 30 files in `scripts/quests/crystalWar/`
- **Quests marked `+ Converted`:** 26
- **Quests marked `+` (partially done / NPC-only):** 4 (Snake on the Plains, The Tigress Stirs, Beans Ahoy, Say It With a Handbag)
- **Quests with NO script at all:** ~43

---

## 1. All Scripts That Exist

| # | File | Quest ID | Quest Name | Chain |
|---|------|----------|------------|-------|
| 1 | `A_Little_Knowledge.lua` | 6 | A Little Knowledge | SCH Unlock |
| 2 | `Blood_of_Heroes.lua` | 52 | Blood of Heroes | Sandy [S] Griffon #8 |
| 3 | `Bonds_That_Never_Die.lua` | 45 | Bonds That Never Die | Sandy [S] Griffon #7 |
| 4 | `Boy_and_the_Beast.lua` | 24 | Boy and the Beast | Sandy [S] Griffon #4 |
| 5 | `Chasing_Shadows.lua` | 60 | Chasing Shadows | Sandy [S] Griffon #9 |
| 6 | `Claws_of_the_Griffon.lua` | 16 | Claws of the Griffon | Sandy [S] Griffon #3 |
| 7 | `Face_of_the_Future.lua` | 61 | Face of the Future | Sandy [S] Griffon #10 (finale) |
| 8 | `Gifts_of_the_Griffon.lua` | 15 | Gifts of the Griffon | Sandy [S] Griffon #2 |
| 9 | `Hammering_Hearts.lua` | 14 | Hammering Hearts | Bastok [S] standalone |
| 10 | `Her_Memories_Carnelian_Footfalls.lua` | 69 | Her Memories: Carnelian Footfalls | Her Memories (Sandy [S]) |
| 11 | `Her_Memories_Homecoming_Queen.lua` | 64 | Her Memories: Homecoming Queen | Her Memories (present Sandy) |
| 12 | `Her_Memories_Of_Malign_Maladies.lua` | 72 | Her Memories: Of Malign Maladies | Her Memories (multi-zone) |
| 13 | `Her_Memories_Operation_Cupid.lua` | 68 | Her Memories: Operation Cupid | Her Memories (Bastok/Windy [S]) |
| 14 | `In_a_Haze_of_Glory.lua` | 38 | In a Haze of Glory | Sandy [S] Griffon #6 |
| 15 | `Light_in_the_Darkness.lua` | 19 | Light in the Darkness | Bastok [S] nation #2 |
| 16 | `Lost_in_Translocation.lua` | 0 | Lost in Translocation | Standalone (map quest) |
| 17 | `Message_on_the_Winds.lua` | 1 | Message on the Winds | Standalone |
| 18 | `Perils_of_the_Griffon.lua` | 37 | Perils of the Griffon | Sandy [S] Griffon #5 |
| 19 | `SCH_AF1_On_Sabbatical.lua` | 32 | On Sabbatical | SCH AF1 |
| 20 | `SCH_AF2_Downward_Helix.lua` | 33 | Downward Helix | SCH AF2 |
| 21 | `Seeing_Spots.lua` | 10 | Seeing Spots | Standalone |
| 22 | `Songbirds_in_a_Snowstorm.lua` | 51 | Songbirds in a Snowstorm | Sandy [S] Griffon #8b |
| 23 | `Steamed_Rams.lua` | 9 | Steamed Rams | Sandy [S] allegiance signup |
| 24 | `The_Dawn_of_Delectability.lua` | 5 | The Dawn of Delectability | Standalone (Windy [S]) |
| 25 | `The_Flipside_of_Things.lua` | 11 | The Flipside of Things | Standalone (map quest) |
| 26 | `The_Lost_Book.lua` | 26 | The Lost Book | Standalone (Windy [S]) |
| 27 | `The_Price_of_Valor.lua` | 44 | The Price of Valor | Sandy [S] Griffon #6b |
| 28 | `The_Weekly_Adventurer.lua` | 2 | The Weekly Adventurer | Standalone (map quest) |
| 29 | `WOTG_BAS_0_The_Fighting_Fourth.lua` | 7 | The Fighting Fourth | Bastok [S] allegiance signup |
| 30 | `Wrath_of_the_Griffon.lua` | 25 | Wrath of the Griffon | Sandy [S] Griffon #4b |

---

## 2. Per-Script Deep Audit

### Standalone / Map Quests

| Quest | Accept | Logic | Reward | Completable? | Issues |
|-------|--------|-------|--------|-------------|--------|
| Lost in Translocation | Talk Thorben in Batallia [S] | Collect 3 map pieces from Eldieme [S] | 2000 gil, 2000 exp, Map of Grauberg | YES | None |
| Message on the Winds | Lv20+, talk Romualdo in Metalworks | Multi-zone chain: Metalworks -> Batallia [S] -> Grauberg [S] | Smart Grenade + Windtalker title (post-CS) | YES | None |
| The Weekly Adventurer | Talk Naiko-Paneiko in Crawlers' Nest [S] | Quiz in Rolanberry [S], answers 4-4-5 | 2000 gil, 2000 exp, Map of Fort Karugo-Narugo | YES | None |
| Seeing Spots | Talk Wyatt in Sandy [S] | Trade 4 Ladybug Wings | 3000 gil, Lady Killer title | YES (repeatable) | None |
| The Flipside of Things | Talk Rarcasmeault in Garlaige [S] | Find Firepower Case from ??? | 2000 exp, 2000 gil, Map of Vunkerl Inlet | YES | None |
| Hammering Hearts | Talk Scarred Shark in Bastok Markets [S] | Trade Heavy Quadav Chestplate + Backplate | Trainee Hammer | YES | None |
| The Dawn of Delectability | Talk Ranpi-Monpi in Windy Waters [S] | Multi-zone: past/present Windy, trade ingredients | Trainee Knife | YES | None |
| The Lost Book | Lv30+, has Bronze Ribbon, Rhinostery door in Windy [S] | Multi-zone: Giddeus, Castle Oztroja [S], Windy [S] | Scroll of Retrace | YES | None |

### Allegiance Signup Quests

| Quest | Accept | Logic | Reward | Completable? | Issues |
|-------|--------|-------|--------|-------------|--------|
| Steamed Rams (Sandy [S]) | Talk Randecque in Garlaige [S] or Mainchelite in Sandy [S] | Collect 3 KIs from E. Ronfaure [S] ??? points | Iron Ram allegiance, Bronze Ribbon of Service, Sprinter's Shoes, Knight of the Iron Ram title | YES | None |
| The Fighting Fourth (Bastok [S]) | Talk Turbulent Storm in Eldieme [S] or Adelbrecht in Bastok Markets [S] | Deliver rations, multi-NPC chain in N. Gustaberg [S] | Sprinter's Shoes, Bronze Ribbon of Service, Fourth Division Soldier title | YES | TODO: Sprinter's Shoes given on re-signup too |
| Snake on the Plains (Windy [S]) | ID 8, marked `+` | **NO SCRIPT EXISTS** in crystalWar/ | N/A | **NO** | Quest NPC logic may exist in zone scripts but no centralized quest script |

### SCH Job Unlock + AF Chain

| Quest | Accept | Logic | Reward | Completable? | Issues |
|-------|--------|-------|--------|-------------|--------|
| A Little Knowledge (SCH unlock) | Lv30+, talk Erlene in Eldieme [S] | Trade Rolanberries for Vellum at Crawlers' Nest [S], trade 12 Vellum to Erlene, use 2hr ability | SCH job unlock, Grimoire, Job Gesture | YES | Post-completion: grants Embrava+Kaustra spells to SCH Lv5+ |
| On Sabbatical (SCH AF1) | SCH main, Lv AF1_QUEST_LEVEL, talk Erlene | Bastok Markets [S] -> Pashhow [S] -> back to Erlene | Klimaform Schema | YES | None |
| Downward Helix (SCH AF2) | Completed On Sabbatical, SCH main, Lv AF2_QUEST_LEVEL, 1-day wait | Sandy [S] CS, Erlene, Sauromugue [S] markings | Scholar's Bracers | YES | None |
| Seeing Blood Red (SCH AF3) | ID 34 | **NO SCRIPT** | Scholar's Loafers | **NO** | Not implemented |
| Storm on the Horizon (SCH AF body) | ID 35 | **NO SCRIPT** | Scholar's Gown | **NO** | Not implemented |
| Fire in the Hole (SCH AF pants) | ID 36 | **NO SCRIPT** | Scholar's Pants | **NO** | Not implemented |

### San d'Oria [S] Griffon Chain (COMPLETE)

This is the only full nation quest chain that is fully scripted start-to-finish.

| # | Quest | Prereqs | Reward | Completable? | Issues |
|---|-------|---------|--------|-------------|--------|
| 1 | Steamed Rams | None (allegiance signup) | Sandy allegiance | YES | None |
| 2 | Gifts of the Griffon | `hasCompletedFirstQuest()` | Deathstone | YES | None |
| 3 | Claws of the Griffon | Completed Gifts of the Griffon + 1-day wait | Angelstone | YES | None |
| 4 | Boy and the Beast | Completed Claws + WotG Mission "Back to the Beginning" | Carbon Fishing Rod | YES | None |
| 5 | Wrath of the Griffon | Completed Boy and the Beast | Military Scrip KI | YES | File header says "Boy and the Beast" (misleading comment only) |
| 6 | Perils of the Griffon | Completed Wrath + WotG Mission "Purple the New Black" + 1-day wait | Elixir, Knight of the Swiftwing Griffin title | YES | None |
| 7 | In a Haze of Glory | Completed Perils | Fullmetal Bullet | YES | Instance (Ghoyus Reverie) uses Event 10000 -- TODO in script says needs verification |
| 8a | The Price of Valor | Completed In a Haze + 1-day wait | Peiste Skin | YES | None |
| 8b | Bonds That Never Die | Completed Price of Valor | Behemoth Horn | YES | Instance (Everbloom Hollow) uses Event 10000 -- needs verification |
| 8c | Songbirds in a Snowstorm | Completed Bonds + WotG Mission "The Will of the World" + 1-day wait | Icarus Wing | YES | Orcish Bloodletter set to very high level (TODO); fishing mechanic for KIs |
| 9 | Blood of Heroes | Completed Songbirds | Ram Staff, House Aurchiat Retainer title | YES | **Instance (Ghoyus Reverie) NOT IMPLEMENTED** -- script has TODO for instance entry at Prog 3. Prog 3->4 path is broken without instance. |
| 10 | Chasing Shadows | Completed Blood of Heroes + 1-day wait | Darksteel Sheet | YES (with caveat) | Menechme NM set to **Level 150** (placeholder). Excenmille ally NPC not spawned. |
| 11 | Face of the Future (finale) | Auto-added on Chasing Shadows completion | Griffon Ring, Fangmonger Forestaller title | YES (with caveat) | Instance (Everbloom Hollow) event 10000 needed. Several position TODOs. |

### Bastok [S] Nation Chain

| # | Quest | Status | Notes |
|---|-------|--------|-------|
| 1 | The Fighting Fourth | IMPLEMENTED | Allegiance signup, works |
| 2 | Fires of Discontent (ID 13) | **NOT IMPLEMENTED** | No script. NPC interactions may exist in zone files (Gentle_Tiger, Pagdako, Engelhart have references). |
| 3 | Light in the Darkness (ID 19) | IMPLEMENTED | Requires completed Fires of Discontent. **BLOCKED** because Fires of Discontent has no script. Instance (Ruhotz Silvermines) IS implemented. |
| 4+ | The Tigress Stirs/Strikes (ID 17/18), Burden of Suspicion (20), etc. | **NOT IMPLEMENTED** | No scripts at all |

### Windurst [S] Nation Chain

| # | Quest | Status | Notes |
|---|-------|--------|-------|
| 1 | Snake on the Plains (ID 8) | **NOT IMPLEMENTED** | Marked `+` in quests.lua but no script in crystalWar/ |
| 2+ | Evil at the Inlet (21), Fumbling Friar (22), Requiem (23), Knot Quite There (27), A Manifest Problem (28), Beans Ahoy (29), etc. | **NOT IMPLEMENTED** | No scripts |

### DNC AF Chain

DNC AF quests are NOT in the Crystal War quest log. They are Jeuno quests (The Unfinished Waltz, etc.) and are handled separately. Not audited here as they are not in `scripts/quests/crystalWar/`.

DNC job unlock ("Lakeside Minuet" / quest ID jeuno.95) is a Jeuno quest, not Crystal War.

### Her Memories Sub-Quest Chain (WotG Mission Support)

These quests support WotG mission "Her Memories" and are required for mission progression.

| Quest | Accept Condition | Completable? | Issues |
|-------|-----------------|-------------|--------|
| Her Memories: Homecoming Queen | On WotG mission "Her Memories" | YES | Contains 3 sub-quests (Old Bean, The Faux Pas, The Grave Resolve). All embedded in same script. |
| Her Memories: Of Malign Maladies | On WotG mission "Her Memories" | YES | Requires Philosopher's Stone trade + 1-day wait. |
| Her Memories: Operation Cupid | On WotG mission "Her Memories" | YES | Requires trade of Rice Vinegar + Ground Wasabi + Holy Basil to Leadavox. |
| Her Memories: Carnelian Footfalls | On WotG mission "Her Memories" + Sandy allegiance | YES | 3 ??? points in E. Ronfaure [S]. |
| Her Memories: Azure Footfalls (ID 70) | On WotG mission "Her Memories" + Bastok allegiance | **NOT IMPLEMENTED** | No script |
| Her Memories: Verdure Footfalls (ID 71) | On WotG mission "Her Memories" + Windy allegiance | **NOT IMPLEMENTED** | No script |

---

## 3. Quest Chain Completability Summary

### Can a player complete each chain start to finish?

| Chain | Verdict | Blocking Issue |
|-------|---------|---------------|
| **Sandy [S] Griffon (full 11-quest chain)** | MOSTLY YES | Blood of Heroes instance not implemented (Prog 3->4 stuck). Menechme in Chasing Shadows at Lv150 placeholder. Workaround: GM set vars to skip. |
| **Bastok [S] nation chain** | **NO** | Fires of Discontent (quest #2) has no script. Light in the Darkness exists but requires Fires. Chain dead at step 2. |
| **Windurst [S] nation chain** | **NO** | Snake on the Plains (quest #1) has no script. Entire chain unplayable. |
| **SCH AF chain** | PARTIAL (2 of 5) | AF1 + AF2 work. AF3/body/pants (IDs 34-36) not implemented. Player gets Klimaform Schema + Scholar's Bracers only. |
| **DNC AF chain** | N/A | Not in Crystal War quest log. Handled as Jeuno quests. |
| **Her Memories chain** | PARTIAL | Sandy allegiance path works. Bastok (Azure Footfalls) and Windy (Verdure Footfalls) paths not implemented. |

---

## 4. Mission Gating Analysis

Crystal War side quests gate WotG mission progression at these checkpoints:

| WotG Mission | Gate Function | Required Quest (any 1 of 3) | Sandy Path? | Bastok Path? | Windy Path? |
|-------------|--------------|---------------------------|-------------|-------------|-------------|
| Mission 2 (Back to the Beginning) | `hasCompletedFirstQuest()` | Steamed Rams / Fighting Fourth / Snake on Plains | YES | YES | **NO** (no script) |
| Mission 3 (Cait Sith) | `meetsMission3Reqs()` | Claws of Griffon / Tigress Strikes / Fires of Discontent | YES | **NO** (no script) | **NO** (no script) |
| Mission 4 (Queen of the Dance) | `meetsMission4Reqs()` | Wrath of Griffon / Burden of Suspicion / A Manifest Problem | YES | **NO** | **NO** |
| Mission 8 (In the Name of the Father) | `meetsMission8Reqs()` | In a Haze of Glory / Fire in the Hole / A Feast for Gnats | YES | **NO** | **NO** |
| Mission 15 (Crossroads of Time) | `meetsMission15Reqs()` | Bonds That Never Die / Honor Under Fire / The Forbidden Path | YES | **NO** | **NO** |
| Mission 26 (Fate in Haze) | `meetsMission26Reqs()` | Blood of Heroes / What Price Loyalty / Howl from the Heavens | YES (with instance caveat) | **NO** | **NO** |
| Mission 38 (Adieu, Lilisette) | `meetsMission38Reqs()` | Face of the Future / Bonds of Mythril / At Journey's End | YES (with caveats) | **NO** | **NO** |

**Bottom line:** Only the San d'Oria [S] allegiance path can progress through WotG missions. Bastok and Windurst paths are completely blocked due to missing quest scripts.

---

## 5. Broken/Flagged Scripts

| Quest | Issue | Severity |
|-------|-------|----------|
| Blood of Heroes | Instance entry at Forbidding Portal (Prog 3) requires Ghoyus Reverie instance that is not implemented. Script has TODO comments. Prog 3->4 transition relies on instance event 10000. | **HIGH** -- blocks chain |
| Chasing Shadows | Menechme NM is set to Level 150 (placeholder). Excenmille ally NPC is "currently set to level 0 and not spawned." | **MEDIUM** -- quest technically completable but fight is unreasonable |
| Face of the Future | Multiple TODO comments about assumed positions. Instance (Everbloom Hollow) event 10000 flow untested. | **MEDIUM** |
| In a Haze of Glory | Instance (Ghoyus Reverie) event 10000 assumption needs verification per TODO. | **LOW** -- probably works |
| Bonds That Never Die | Instance (Everbloom Hollow) event 10000 assumption needs verification. | **LOW** -- probably works |
| Songbirds in a Snowstorm | Orcish Bloodletter "needs verification and implementation to ensure accuracy. Currently is set to a very high level." | **MEDIUM** |
| Wrath_of_the_Griffon.lua | File header comment says "Boy and the Beast" but quest ID is correctly WRATH_OF_THE_GRIFFON. Cosmetic only. | **LOW** |
| The Fighting Fourth | TODO: Sprinter's Shoes rewarded even on allegiance re-signup (minor). | **LOW** |
| Light in the Darkness | Script works and instance (Ruhotz Silvermines) is implemented. However, quest requires FIRES_OF_DISCONTENT which has no script. Effectively unreachable. | **HIGH** -- blocked by prereq |

---

## 6. Missing Quests (No Script At All)

### Critical for Mission Gating (Bastok/Windy paths)

| ID | Quest Name | Chain | Impact |
|----|-----------|-------|--------|
| 8 | Snake on the Plains | Windy [S] allegiance | Blocks Windy path from mission 2 onward |
| 13 | Fires of Discontent | Bastok [S] nation #2 | Blocks Bastok path from mission 3 onward |
| 18 | The Tigress Strikes | Bastok [S] nation #3 | Would gate mission 3 |
| 20 | Burden of Suspicion | Bastok [S] nation | Would gate mission 4 |
| 28 | A Manifest Problem | Windy [S] nation | Would gate mission 4 |

### SCH AF (Missing)

| ID | Quest Name | Reward |
|----|-----------|--------|
| 34 | Seeing Blood Red | Scholar's Loafers |
| 35 | Storm on the Horizon | Scholar's Gown |
| 36 | Fire in the Hole | Scholar's Pants |

### Her Memories (Missing allegiance variants)

| ID | Quest Name | Allegiance |
|----|-----------|-----------|
| 70 | Her Memories: Azure Footfalls | Bastok |
| 71 | Her Memories: Verdure Footfalls | Windurst |

### Other Missing Quests (complete list)

IDs 3, 4, 8, 12, 13, 17, 18, 20, 21, 22, 23, 27, 28, 29, 30, 31, 34, 35, 36, 39, 40, 41, 42, 43, 46, 47, 48, 49, 50, 53, 54, 55, 56, 57, 58, 59, 62, 63, 70, 71, 73, 74, 75

Plus Voidwatch/Cait Sith side quests (IDs 80-98) which are a separate system.

---

## 7. Recommendations for a 4-Player Server

1. **Sandy [S] allegiance is the only viable path.** All players should pledge to San d'Oria. This is already the implicit requirement since only the Griffon chain is implemented.

2. **Blood of Heroes instance** is the single biggest blocker in the Sandy chain. GM can work around with `!setvar Quest[7][52]Prog 4` then zone into Xarcabard [S] to trigger the post-instance cutscene.

3. **Chasing Shadows / Songbirds** NM levels need adjustment. Menechme at Lv150 and Orcish Bloodletter at "very high level" will be extremely difficult for a small group.

4. **SCH AF3-5** are missing. SCH players will only get Klimaform Schema and Scholar's Bracers. The remaining 3 pieces (Loafers, Gown, Pants) would need to be obtained through other means (e.g., GM commands or Sparks).

5. **Her Memories** works for Sandy allegiance only. Bastok/Windy variants (Azure/Verdure Footfalls) are not implemented. Since recommendation #1 already forces Sandy, this is not an additional limitation.
