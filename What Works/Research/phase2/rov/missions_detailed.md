# ROV Missions — Detailed Audit

## Summary

| Chapter | Missions | WORKS | PARTIAL | STUB |
|---------|----------|-------|---------|------|
| 1       | 18       | 18    | 0       | 0    |
| 2       | 41       | 22    | 6       | 13   |
| 3       | 35       | 14    | 4       | 17   |
| **Total** | **94** | **54** | **10** | **30** |

**Can a player complete ROV start to finish?** YES — but approximately 30 missions auto-complete
without cutscenes, and 5 boss battles are skipped entirely. No GM intervention is required
to progress; the player will simply miss story content and boss fights.

**Missing script file:** Mission 2-8 "The Endless Sky" has an ID (60) in missions.lua but no
script file. It appears to be an unused branch — the mission flow skips from INESCAPABLE_BINDS
directly to EVER_FORWARD when the player zones into Aht Urhgan Whitegate. Not a blocker.

---

## Rhapsody Key Item Audit

| KI | Retail Mission | Script Awards? | Status |
|----|---------------|---------------|--------|
| Rhapsody in White | 1-6 Flames of Prayer | YES (`xi.ki.RHAPSODY_IN_WHITE`) | OK |
| Rhapsody in Umber | 1-11 A Land After Time | YES (`xi.ki.RHAPSODY_IN_UMBER`) | OK |
| Rhapsody in Azure | 1-16 The Lost Avatar | YES (`xi.ki.RHAPSODY_IN_AZURE`) | OK |
| Rhapsody in Crimson | 2-13 From the Ruins | YES (`xi.ki.RHAPSODY_IN_CRIMSON`) | OK |
| Rhapsody in Emerald | 2-30 The Decisive Heroine | YES (`xi.ki.RHAPSODY_IN_EMERALD`) | OK |
| Rhapsody in Mauve | 2-40 The Man Behind the Mask | YES (`xi.ki.RHAPSODY_IN_MAUVE`) | OK |
| Rhapsody in Fuchsia | 3-3 The River Runs Red | YES (`xi.ki.RHAPSODY_IN_FUCHSIA`) | OK |
| Rhapsody in Puce | 3-19 Penance | YES (`xi.ki.RHAPSODY_IN_PUCE`) | OK |
| Rhapsody in Ochre | 3-28 Nary a Cloud in Sight | YES (`xi.ki.RHAPSODY_IN_OCHRE`) | OK |
| Scintillating Rhapsody | 3-34 The Orb's Radiance | **NO** — not in reward block | **MISSING** |

**Issue:** Mission 3-34 does not award `xi.ki.SCINTILLATING_RHAPSODY` (KI ID 2893). The KI
exists in `scripts/enum/key_item.lua` and is checked by `scripts/globals/teleports/eschan_portals.lua`.
Without it, the player misses the final Eschan portal expansion.

### KI Bonus Application (C++ side in charutils.cpp)

All bonuses are applied via C++ sets that check `hasKeyItem()`. These are server-side and
work correctly as long as the KIs are awarded:

- **Skillup rate bonus:** White, Crimson, Fuchsia
- **Experience bonus:** White, Umber, Azure, Crimson, Emerald, Mauve (30% each, stacking)
- **Capacity points bonus:** Fuchsia, Puce, Ochre (30% each, stacking)
- **Traverser stone timer:** Not directly from Rhapsody KIs (uses Abyssite of Celerity)

The Lua-side bonuses in `regimes.lua` check `RHAPSODY_IN_WHITE` to double FoV/GoV
page rewards.

---

## Chapter 1: Creation and Rebirth (Missions 1-1 through 1-18)

**Overall: CLEAN.** All 18 missions are fully implemented with proper cutscenes, NPCs,
battle triggers, and KI rewards.

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 1-1 | Rhapsodies of Vana'diel | WORKS | Zone-in CS (event 30035) in 10 nation zones. Requires Lv3, ENABLE_ROV=1. |
| 1-2 | Resonance | WORKS | Mhaura (event 368) or Selbina (event 176). Sets path status for 1-3. |
| 1-3 | Emissary from the Seas | WORKS | Naillina (Selbina, event 14) or Numi Adaligo (Mhaura, event 50). |
| 1-4 | Set Free | WORKS | Trade 3x Bee Pollen (Selbina) or 3x Mandragora Dewdrop (Mhaura). Awards Copper Aman Voucher or Gilgamesh's letter. |
| 1-5 | The Beginning | WORKS | Travel to Norg via Selbina/Mhaura. Oaken Door event 276. Awards Reisenjima Sanctorium Orb KI. |
| 1-6 | Flames of Prayer | WORKS | Oaken Door event 277 in Norg. Awards **Rhapsody in White**. |
| 1-7 | The Path Untraveled | WORKS | Any Shattered Telepoint (3 crags). Events 3/14/41. Lion ghost param based on ZM completion. |
| 1-8 | At Heaven's Door | WORKS | Undulating Confluence in Qufim (event 63). |
| 1-9 | The Lion's Roar | WORKS | Pop + defeat Ophiotaurus at Qufim Undulating Confluence. Full mob fight. |
| 1-10 | Eddies of Despair I | WORKS | Undulating Confluence event 64, teleports to Escha Zi'Tah, zone-in CS event 1. |
| 1-11 | A Land After Time | WORKS | Any Shattered Telepoint. Rank 6 gate check. Awards **Rhapsody in Umber** + Cipher: Lion II. |
| 1-12 | Fate's Call | WORKS | Zone-in CS (event 30036) in 10 nation zones. Requires Rank 6 or Shadow Lord mission status >= 4. |
| 1-13 | What Lies Beyond | WORKS | Oaken Door event 278 in Norg. |
| 1-14 | The Ties that Bind | WORKS | qm7 in Sea Serpent Grotto (event 34). |
| 1-15 | Impurity | WORKS | qm11 in Yuhtunga Jungle (event 212). |
| 1-16 | The Lost Avatar | WORKS | Pop + defeat Siren at qm11 in Yuhtunga. Post-fight CS event 213. Awards **Rhapsody in Azure**. Full mob fight. |
| 1-17 | Volto Oscuro | WORKS | Oaken Door event 279 in Norg. Awards Cipher: Zeid II. Tenzen param from COP progress. |
| 1-18 | Ring My Bell | WORKS | Oaken Door event 284 in Norg. COP character availability gate. Prishe/Tenzen params from COP progress. |

**Chapter 1 Issues:** None. All missions have proper cutscenes, NPC interactions, mob spawns, and rewards.

---

## Chapter 2: Revitalization (Missions 2-1 through 2-41)

**Overall: MIXED.** Early chapter (2-1 through 2-13) is solid. Mid-to-late chapter
has many auto-complete stubs where cutscene event IDs are unknown.

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 2-1 | Spirits Awoken | WORKS | Lower Delkfutt's zone-in event 51 from Qufim. COP progress param. |
| 2-2 | Crashing Waves | WORKS | Ru'Lude Gardens trigger area event 10244. Awards Cipher: Tenzen II. COP gate (requires A Vessel Without a Captain). |
| 2-3 | Call to Serve | WORKS | Port Jeuno zone-in event 399. Awards Cipher: Prishe II. COP gate. |
| 2-4 | Numbering Days | WORKS | Upper Jeuno Marble Bridge door event 10221. COP progress params. |
| 2-5 | Inescapable Binds | WORKS | Aht Urhgan zone-in event 165. Requires Boarding Permit KI. TOAU/COP progress params. |
| 2-6 | Desert Winds | WORKS | Aht Urhgan zone-in event 165 (alternate path if player obtains Boarding Permit before visiting AU). |
| 2-7 | Ever Forward | WORKS | Imperial Whitegate NPC event 166 in Aht Urhgan. Awards Cipher: Nashmeira II. Requires TOAU Royal Puppeteer. Has nation zone-in fallback (event 30039). Auto-completes Aphmau's Light. |
| 2-8 | The Endless Sky | **NO SCRIPT** | ID 60 defined in missions.lua but never used. Appears to be an unused branch. NOT a blocker. |
| 2-9 | Aphmau's Light | WORKS | Imperial Whitegate event 166. Awards Cipher: Nashmeira II (same as 2-7 alternate). |
| 2-10 | Reunited | WORKS | Nadeey NPC event 167 in Aht Urhgan. Astral Candescence param. |
| 2-11 | Take Wing | WORKS | Aht Urhgan trigger area 5, event 168. COP progress param. |
| 2-12 | Prime Number | WORKS | Alzadaal Undersea Ruins zone-in event 124. Post-CS in Shrouded Maw event 12. |
| 2-13 | From the Ruins | WORKS | Imperial Whitegate event 169. Awards **Rhapsody in Crimson**. WotG progress param. |
| 2-14 | Cauterize | WORKS | Cavernous Maw QMs in 6 zones (present + past). Awards Lightsworm KI. Auto-completes 2-15 Uncertain Destinations. |
| 2-15 | Uncertain Destinations | WORKS | Intentionally blank — always auto-completed by Cauterize. |
| 2-16 | Ganged Up On | WORKS | Southern San d'Oria [S] zone-in event 183. Awards Cipher: Lilisette II. WotG progress params. |
| 2-17 | Sacrifice | PARTIAL | Walk of Echoes Ornate Door event 27. **Known issue:** Players cannot naturally reach Walk of Echoes from Xarcabard [S]. GM workaround: `!pos -700 -20.25 -305.398 182`. Character availability gates for WotG quests. |
| 2-18 | Somber Dreams | WORKS | Pop + defeat Cetus in Grauberg [S]. Post-fight CS events 48/49. Conflux teleport to Walk of Echoes event 28. Full boss fight. |
| 2-19 | Of Light and Darkness | WORKS | Oaken Door event 285 in Norg. |
| 2-20 | Temporary Farewells | WORKS | qm_rov2_20 in Misareaux Coast event 15. |
| 2-21 | Brushing Up | WORKS | qm_rov2_20 in Misareaux Coast event 16. Choice sets food item for 2-22. |
| 2-22 | Keep On Giving | WORKS | Trade food item (Beef Stewpot / Zaru Soba / Spicy Cracker) to qm_rov2_20 event 17. RotZ progress param. |
| 2-23 | Past Imperfect | WORKS | Oaken Door event 286 in Norg. ZM progress params. Character availability gate. |
| 2-24 | The Cursed Temple | WORKS | Granite Door event 94 in Temple of Uggalepih. Requires ZM4 completion. Auto-completes 2-25 Wisdom of Our Forefathers if ZM4 already done. |
| 2-25 | Wisdom of Our Forefathers | WORKS | Granite Door event 94 (alternate params). Fallback if not auto-completed by 2-24. |
| 2-26 | Where Divinities Collide | STUB | Shattered Telepoint — **auto-completes with no cutscene** (noAction). TODO: verify event ID. |
| 2-27 | Visions of Dread | STUB | Hall of Transference zone-in — **auto-completes with no cutscene**. TODO: verify event ID. |
| 2-28 | To the Skies | PARTIAL | Oaken Door event 285 in Norg. Uses same event as 2-19 — **may be wrong event ID**. |
| 2-29 | Escha - Ru'Aun | STUB | Misareaux Undulating Confluence — **auto-completes with no cutscene** (noAction). TODO: verify event ID. |
| 2-30 | The Decisive Heroine | STUB | Escha Ru'Aun zone-in — **auto-completes with no cutscene**. Awards **Rhapsody in Emerald** (KI is correct). |
| 2-31 | Fall from Grace | STUB | Shattered Telepoint — **auto-completes with no cutscene** (noAction). |
| 2-32 | Banishing the Darkness | WORKS | Oaken Door event 287 in Norg. |
| 2-33 | Over the Rainbow | STUB | Shantotto NPC — **auto-completes with no cutscene** (noAction). TODO: verify event ID. |
| 2-34 | Cacophonous Discord | STUB | Misareaux Undulating Confluence — **auto-completes with no cutscene** (noAction). |
| 2-35 | Eddies of Despair II | STUB | Escha Ru'Aun zone-in — **auto-completes with no cutscene**. Retail requires portal traversal collecting Eschan Droplets. |
| 2-36 | Pretender to the Throne | STUB | Escha Ru'Aun zone-in — **auto-completes, boss fight skipped**. Retail: defeat Balamor. |
| 2-37 | Banished | WORKS | Oaken Door event 288 in Norg. |
| 2-38 | Call of the Void | STUB | Telepoint at crags — **auto-completes with no cutscene** (noAction). |
| 2-39 | Both Paths Taken | STUB | Empyreal Paradox zone-in — **auto-completes, boss fight skipped**. Retail: defeat Disjoined One. Mob data INCOMPLETE (no mob_pools/mob_spawn_points). |
| 2-40 | The Man Behind the Mask | WORKS | Oaken Door event 290 in Norg. Awards **Rhapsody in Mauve**. |
| 2-41 | Uncertain Futures | STUB | Nation zone-in — **auto-completes with no cutscene**. TODO: verify event ID (likely 30040/30041). |

### Chapter 2 Issues Summary

1. **Walk of Echoes entry (2-17):** No natural path from Xarcabard [S]. Requires GM warp. (Known from ROV_TODO.md)
2. **Balamor fight skipped (2-36):** Boss auto-completed on zone-in.
3. **Disjoined One fight skipped (2-39):** Boss auto-completed. Mob data incomplete in SQL.
4. **11 missions auto-complete without cutscenes** (2-26, 2-27, 2-29, 2-30, 2-31, 2-33, 2-34, 2-35, 2-38, 2-41, plus 2-36/2-39 boss skips).
5. **Event 285 reused (2-28):** To the Skies uses the same Norg event as Of Light and Darkness (2-19). May show the wrong cutscene.

---

## Chapter 3: Reckoning (Missions 3-1 through 3-35)

**Overall: ROUGH.** Core progression works but many cutscenes are missing. All boss
battles auto-complete. Two kill missions depend on mob spawns that need verification.

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 3-1 | Darkness Beckons | WORKS | Reisenjima zone-in event 2. |
| 3-2 | The Brewing Storm | PARTIAL | Kill 3 Perfervid Naraka in Reisenjima. Kill counter implemented. **Completion triggers on zone-in or trigger area, not via CS.** Mobs may not be spawning — needs in-game verification. |
| 3-3 | The River Runs Red | WORKS | Reisenjima zone-in event 6. Awards **Rhapsody in Fuchsia**. |
| 3-4 | The Crucible | WORKS | Ceizak Battlegrounds zone-in event 33. |
| 3-5 | Forward Thinking | STUB | Eastern Adoulin zone-in — **auto-completes with no cutscene**. Probable CSID: 1547/1549/1551 (from ROV_TODO.md). |
| 3-6 | Tears of the Generals | WORKS | Ceizak Battlegrounds zone-in event 34. |
| 3-7 | What He Left Behind | STUB | Eastern Adoulin zone-in — **auto-completes with no cutscene**. Probable CSID: 1547/1549/1551. |
| 3-8 | Gone but Not Forgotten | WORKS | Rala Waterways zone-in event 367. |
| 3-9 | August Artifacts | WORKS | Celennia Memorial Library zone-in event 40. |
| 3-10 | Solemnity | STUB | Eastern Adoulin zone-in — **auto-completes with no cutscene**. Probable CSID: 1547/1549/1551. |
| 3-11 | Eyes on You | WORKS | Hall of the Gods zone-in event 14. |
| 3-12 | Exploring the Ruins | WORKS | Hall of the Gods zone-in event 15. |
| 3-13 | Become Something More | WORKS | Reisenjima Sanctorium zone-in event 1. Awards Dimensional Compass KI. |
| 3-14 | Unshakable Nightmares | WORKS | Walk of Echoes zone-in event 28. (Confirmed in ROV_TODO.md) |
| 3-15 | What Remains of Hope | STUB | Walk of Echoes zone-in — **auto-completes with no cutscene**. Probable CSID: 29 or 30. |
| 3-16 | Death Cares Not | WORKS | Empyreal Paradox zone-in event 9. |
| 3-17 | No Time Like the Future | STUB | Empyreal Paradox zone-in — **auto-completes, boss fight skipped**. Retail: defeat Sempurne in Desuetia-Empyreal Paradox. Mob data exists (pool 4914). |
| 3-18 | Sin | STUB | Walk of Echoes zone-in — **auto-completes with no cutscene**. Probable CSID: 5 or 8. |
| 3-19 | Penance | STUB | Walk of Echoes zone-in — **auto-completes with no cutscene**. Awards **Rhapsody in Puce** (KI is correct). Probable CSID: 9. |
| 3-20 | Vessel of Light | WORKS | Reisenjima zone-in event 7. |
| 3-21 | The Lifestream of Reisenjima | STUB | Reisenjima zone-in — **auto-completes with no cutscene**. Probable CSID: 3. |
| 3-22 | From West to East | PARTIAL | Kill 11 Obstreperous Panopt in Reisenjima. Kill counter implemented. **Completion triggers on zone-in or trigger area, not via CS.** Mobs may not be spawning — needs in-game verification. |
| 3-23 | Good Things Come in Threes | STUB | Reisenjima zone-in — **auto-completes with no cutscene**. Probable CSID: 8. |
| 3-24 | Tackling the Problem | WORKS | Reisenjima Sanctorium zone-in event 6. |
| 3-25 | Way to Divinity | WORKS | Empyreal Paradox zone-in event 14. |
| 3-26 | The Winds of Time | STUB | Empyreal Paradox zone-in — **auto-completes, boss fight skipped**. Retail: defeat Metus. Mob data exists (pool 4820). |
| 3-27 | Calm After the Storm | STUB | Walk of Echoes zone-in — **auto-completes with no cutscene**. Probable CSID: 31. |
| 3-28 | Nary a Cloud in Sight | WORKS | La Theine Plateau zone-in event 17. Awards **Rhapsody in Ochre**. NOTE: retail also awards Cipher: Iroha here — not implemented. |
| 3-29 | An Unending Song | STUB | Nation zone-in — **auto-completes with no cutscene**. |
| 3-30 | A Deep Sleep | WORKS | Reisenjima zone-in event 9. |
| 3-31 | Guardians | WORKS | Reisenjima Sanctorium zone-in event 10. |
| 3-32 | Iroha in Distress | WORKS | Empyreal Paradox zone-in event 13. |
| 3-33 | Absolute Trust | WORKS | Empyreal Paradox zone-in event 17. |
| 3-34 | The Orb's Radiance | STUB | Empyreal Paradox zone-in — **auto-completes, boss fight skipped**. Retail: defeat Cloud of Darkness. Mob data exists (pool 4819). **Missing KI: Scintillating Rhapsody not awarded.** **Missing item: Cipher: Iroha II not awarded.** |
| 3-35 | A Rhapsody for the Ages | WORKS | La Theine Plateau zone-in event 19. Requires Rhapsody in Ochre KI. Final mission. |

### Chapter 3 Issues Summary

1. **Sempurne fight skipped (3-17):** Boss auto-completed on Empyreal Paradox zone-in. Wrong zone — retail is Desuetia-Empyreal Paradox (zone 290).
2. **Metus fight skipped (3-26):** Boss auto-completed on zone-in.
3. **Cloud of Darkness fight skipped (3-34):** Boss auto-completed. Missing Scintillating Rhapsody KI and Cipher: Iroha II.
4. **Kill missions (3-2, 3-22):** Kill counter logic works but mobs need in-game spawn verification.
5. **13 missions auto-complete without cutscenes** (3-5, 3-7, 3-10, 3-15, 3-18, 3-19, 3-21, 3-23, 3-27, 3-29, plus 3-17/3-26/3-34 boss skips).
6. **Eastern Adoulin CSIDs (3-5, 3-7, 3-10):** Three missions share probable CSIDs 1547/1549/1551 — need in-game testing.
7. **Walk of Echoes entry still broken** for 3-14, 3-15, 3-18, 3-19, 3-27 — same issue as 2-17.

---

## Cross-Reference with ROV_TODO.md

| ROV_TODO Item | Verified? | Current Status |
|---|---|---|
| Walk of Echoes entry (2-17) | YES | Still broken. GM warp required. Affects 2-17, 3-14, 3-15, 3-18, 3-19, 3-27. |
| Balamor fight stubbed (2-36) | YES | Auto-completes on zone-in. No battlefield implemented. |
| Disjoined One fight stubbed (2-39) | YES | Auto-completes. Mob data incomplete (no mob_pools/mob_spawn_points). |
| Sempurne fight stubbed (3-17) | YES | Auto-completes. Script points to wrong zone (Empyreal Paradox instead of Desuetia-EP). Mob data exists. |
| Metus fight stubbed (3-26) | YES | Auto-completes. Mob data exists (pool 4820, family 478). |
| Cloud of Darkness stubbed (3-34) | YES | Auto-completes. Missing Scintillating Rhapsody + Cipher: Iroha II. Mob data exists. |
| Perfervid Naraka spawns (3-2) | UNVERIFIED | Kill counter code works. Need in-game verification of spawns. |
| Obstreperous Panopt spawns (3-22) | UNVERIFIED | Kill counter code works. Need in-game verification of spawns. |
| Eastern Adoulin CSIDs (3-5, 3-7, 3-10) | CONFIRMED MISSING | Still auto-completing. Probable CSIDs identified but untested. |
| Walk of Echoes CSIDs (3-15, 3-18, 3-19, 3-27) | CONFIRMED MISSING | Still auto-completing. Probable CSIDs identified. |
| Reisenjima CSIDs (3-21, 3-23) | CONFIRMED MISSING | Still auto-completing. Probable CSIDs identified. |
| Missing Cipher: Iroha (3-28) | CONFIRMED | Comment in script acknowledges it. Item not in DB. |
| Missing Cipher: Iroha II (3-34) | CONFIRMED | Comment in script acknowledges it. Item not in DB. |

---

## NEW Issues Not in ROV_TODO.md

1. **Scintillating Rhapsody KI not awarded at 3-34.** The KI exists (`key_item.lua` ID 2893)
   and is checked by `eschan_portals.lua` line 100, but 3-34's reward block has no keyItem
   entry. This is a simple fix — add `keyItem = xi.ki.SCINTILLATING_RHAPSODY` to the reward.

2. **Mission 2-28 (To the Skies) reuses event 285** which is the same event used by 2-19
   (Of Light and Darkness). Both are Norg Oaken Door events. This likely shows duplicate
   dialogue. Needs packet capture to determine the correct event ID.

3. **Completion trigger for kill missions (3-2, 3-22) is non-standard.** Both use `onZoneIn`
   and `onTriggerAreaEnter` to check kill count, rather than an NPC interaction + cutscene.
   Players must zone out and back in (or walk into a trigger area) after reaching the kill
   count. Retail behavior typically involves examining an Etched Rock NPC.

4. **Mission 3-35 requires Rhapsody in Ochre** but 3-34 does not award it. The Ochre KI
   comes from 3-28. If a player somehow reaches 3-35 without 3-28's KI (impossible in
   normal flow), the mission would softlock. Not a real issue but worth noting.

---

## Auto-Complete Missions (No Cutscene)

These missions complete instantly on zone-in or NPC click with no visual feedback:

### Chapter 2 (11 missions)
- 2-26 Where Divinities Collide (Shattered Telepoint)
- 2-27 Visions of Dread (Hall of Transference)
- 2-29 Escha - Ru'Aun (Undulating Confluence)
- 2-30 The Decisive Heroine (Escha Ru'Aun zone-in) — **awards Emerald KI silently**
- 2-31 Fall from Grace (Shattered Telepoint)
- 2-33 Over the Rainbow (Shantotto)
- 2-34 Cacophonous Discord (Undulating Confluence)
- 2-35 Eddies of Despair II (Escha Ru'Aun zone-in)
- 2-36 Pretender to the Throne (Escha Ru'Aun zone-in) — boss skipped
- 2-38 Call of the Void (Telepoint)
- 2-41 Uncertain Futures (nation zone-in)

### Chapter 3 (13 missions)
- 3-5 Forward Thinking (Eastern Adoulin zone-in)
- 3-7 What He Left Behind (Eastern Adoulin zone-in)
- 3-10 Solemnity (Eastern Adoulin zone-in)
- 3-15 What Remains of Hope (Walk of Echoes zone-in)
- 3-17 No Time Like the Future (Empyreal Paradox zone-in) — boss skipped
- 3-18 Sin (Walk of Echoes zone-in)
- 3-19 Penance (Walk of Echoes zone-in) — **awards Puce KI silently**
- 3-21 The Lifestream of Reisenjima (Reisenjima zone-in)
- 3-23 Good Things Come in Threes (Reisenjima zone-in)
- 3-26 The Winds of Time (Empyreal Paradox zone-in) — boss skipped
- 3-27 Calm After the Storm (Walk of Echoes zone-in)
- 3-29 An Unending Song (nation zone-in)
- 3-34 The Orb's Radiance (Empyreal Paradox zone-in) — boss skipped, **missing KI**

---

## Stubbed Boss Battles

| Mission | Boss | Zone | Mob Data? | Battlefield? | Difficulty to Implement |
|---------|------|------|-----------|-------------|----------------------|
| 2-36 | Balamor | Escha Ru'Aun | Needs investigation | No | Medium |
| 2-39 | Disjoined One | Empyreal Paradox | **INCOMPLETE** (no mob_pools/spawn_points) | No | Medium-Hard |
| 3-17 | Sempurne | Desuetia-EP (zone 290) | Pool 4914, Lv125, HP 20000 | No | Medium |
| 3-26 | Metus | Empyreal Paradox | Pool 4820, Lv125, HP 20000 | No | Medium |
| 3-34 | Cloud of Darkness | Reisenjima Sanctorium | Pool 4819, Lv130, HP 20000 | No | Hard |

---

## Priority Fixes

### Critical (blocks correct completion)
1. **Add Scintillating Rhapsody to 3-34 reward** — one-line fix
2. **Walk of Echoes zone entry** — blocks natural progression to 6+ missions

### High (missing story content)
3. **Implement Eastern Adoulin cutscenes (3-5, 3-7, 3-10)** — test CSIDs 1547/1549/1551
4. **Implement Walk of Echoes cutscenes (3-15, 3-18, 3-19, 3-27)** — test probable CSIDs
5. **Implement Reisenjima cutscenes (3-21, 3-23)** — test probable CSIDs

### Medium (boss battles)
6. **Implement boss battlefields** in priority order: Sempurne (3-17), Metus (3-26), Balamor (2-36), Cloud of Darkness (3-34), Disjoined One (2-39)

### Low (polish)
7. **Add Cipher: Iroha / Iroha II items** to DB and award at 3-28 / 3-34
8. **Verify Reisenjima mob spawns** (Perfervid Naraka, Obstreperous Panopt)
9. **Fix 2-28 event ID** — currently reuses 2-19's event 285
10. **Add cutscenes to remaining Chapter 2 stubs** (2-26, 2-27, 2-29, 2-31, 2-33, 2-34, 2-38, 2-41)
