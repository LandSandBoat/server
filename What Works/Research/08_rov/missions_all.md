# Rhapsodies of Vana'diel — Full Mission Audit

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Rhapsodies_of_Vana%27diel_Missions
- Codebase: `scripts/missions/rov/` (93 scripts), `sql/mob_spawn_points.sql`, `src/map/utils/charutils.cpp`
- Cross-ref: `/ROV_TODO.md` (existing known issues document)

## Summary
93 mission scripts exist covering all 3 chapters (18 + 40 + 35). The mission chain is completable end-to-end but with 5 stubbed boss battles (auto-complete on zone-in), 1 stubbed exploration mission, 2 kill missions that need in-game mob verification, and ~15 missions with unverified or missing cutscene event IDs. Rhapsody KI bonuses (XP, capacity points, skillups) are fully implemented in C++.

---

## Chapter 1 — The Rift Dimensional (18 missions)

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 1-1 | Rhapsodies of Vana'diel | WORKS | Starter mission, self-completing |
| 1-2 | Resonance | WORKS | |
| 1-3 | Emissary from the Seas | WORKS | Multi-zone (Selbina/Mhaura/Norg) |
| 1-4 | Set Free | WORKS | |
| 1-5 | The Beginning | WORKS | |
| 1-6 | Flames of Prayer | WORKS | Awards Rhapsody in White |
| 1-7 | The Path Untraveled | WORKS | |
| 1-8 | At Heaven's Door | WORKS | |
| 1-9 | The Lion's Roar | WORKS | |
| 1-10 | Eddies of Despair I | WORKS | |
| 1-11 | A Land After Time | PARTIAL | Uses noAction for 3 nation paths — completes but no cutscene |
| 1-12 | Fate's Call | WORKS | |
| 1-13 | What Lies Beyond | WORKS | |
| 1-14 | The Ties that Bind | WORKS | |
| 1-15 | Impurity | WORKS | |
| 1-16 | The Lost Avatar | WORKS | Awards Rhapsody in Azure |
| 1-17 | Volto Oscuro | PARTIAL | Uses noAction fallback — completes but may skip cutscene in some paths |
| 1-18 | Ring My Bell | WORKS | Awards Rhapsody in Umber (via 1-11) |

**Chapter 1 verdict**: 16 WORKS, 2 PARTIAL (noAction cutscene skips). Fully playable.

---

## Chapter 2 — Winds of Fate (40 missions, note: 2-8 does not exist in numbering)

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 2-1 | Spirits Awoken | WORKS | |
| 2-2 | Crashing Waves | WORKS | |
| 2-3 | Call to Serve | WORKS | Multi-path (nation-based) |
| 2-4 | Numbering Days | WORKS | |
| 2-5 | Inescapable Binds | WORKS | |
| 2-6 | Desert Winds | WORKS | |
| 2-7 | Ever Forward | WORKS | |
| 2-9 | Aphmau's Light | WORKS | |
| 2-10 | Reunited | WORKS | |
| 2-11 | Take Wing | WORKS | |
| 2-12 | Prime Number | WORKS | |
| 2-13 | From the Ruins | WORKS | Awards Rhapsody in Crimson |
| 2-14 | Cauterize | WORKS | |
| 2-15 | Uncertain Destinations | WORKS | |
| 2-16 | Ganged Up On | PARTIAL | Uses noAction fallback for some paths |
| 2-17 | Sacrifice | PARTIAL | Walk of Echoes entry broken — no zone entry from Xarcabard [S]. GM workaround: `!pos -700 -20.25 -305.398 182` |
| 2-18 | Somber Dreams | WORKS | |
| 2-19 | Of Light and Darkness | WORKS | |
| 2-20 | Temporary Farewells | WORKS | |
| 2-21 | Brushing Up | WORKS | |
| 2-22 | Keep On Giving | WORKS | |
| 2-23 | Past Imperfect | WORKS | |
| 2-24 | The Cursed Temple | WORKS | |
| 2-25 | Wisdom of Our Forefathers | WORKS | |
| 2-26 | Where Divinities Collide | PARTIAL | Completes on trigger but noAction — no cutscene at Shattered Telepoints |
| 2-27 | Visions of Dread | PARTIAL | TODO: Verify event ID |
| 2-28 | To the Skies | WORKS | |
| 2-29 | Escha Ru'Aun | PARTIAL | Completes on trigger but noAction — no cutscene |
| 2-30 | The Decisive Heroine | PARTIAL | TODO: Verify event ID. Awards Rhapsody in Emerald |
| 2-31 | Fall from Grace | PARTIAL | noAction at 3 Shattered Telepoints — completes but no cutscene |
| 2-32 | Banishing the Darkness | WORKS | |
| 2-33 | Over the Rainbow | PARTIAL | noAction — no cutscene (Windurst Walls/Shantotto) |
| 2-34 | Cacophonous Discord | PARTIAL | noAction — no cutscene (Misareaux Coast) |
| 2-35 | Eddies of Despair II | STUB | Auto-completes on zone-in. Retail requires portal traversal collecting Eschan Droplets |
| 2-36 | Pretender to the Throne | STUB | Boss fight vs Balamor auto-completes on zone-in |
| 2-37 | Banished | WORKS | |
| 2-38 | Call of the Void | PARTIAL | noAction at 3 Crag Telepoints — completes but no cutscene |
| 2-39 | Both Paths Taken | STUB | Boss fight vs Disjoined One auto-completes. Mob data INCOMPLETE (no mob_pools/mob_spawn_points) |
| 2-40 | The Man Behind the Mask | WORKS | Awards Rhapsody in Mauve |
| 2-41 | Uncertain Futures | PARTIAL | TODO: Verify event ID for nation zone-in |

**Chapter 2 verdict**: 24 WORKS, 11 PARTIAL (missing cutscenes/unverified events), 3 STUB. Progression possible but multiple cutscenes missing.

---

## Chapter 3 — Echoes of Time (35 missions)

| # | Mission | Status | Notes |
|---|---------|--------|-------|
| 3-1 | Darkness Beckons | WORKS | |
| 3-2 | The Brewing Storm | PARTIAL | Kill counter implemented for 3 Perfervid Naraka. Mobs in SQL but no mob scripts in zone dir — need in-game verification |
| 3-3 | The River Runs Red | WORKS | Awards Rhapsody in Fuchsia |
| 3-4 | The Crucible | WORKS | |
| 3-5 | Forward Thinking | PARTIAL | TODO: Verify event ID (Eastern Adoulin) |
| 3-6 | Tears of the Generals | WORKS | |
| 3-7 | What He Left Behind | PARTIAL | TODO: Verify event ID |
| 3-8 | Gone But Not Forgotten | WORKS | |
| 3-9 | August Artifacts | WORKS | |
| 3-10 | Solemnity | PARTIAL | TODO: Verify event ID |
| 3-11 | Eyes on You | WORKS | |
| 3-12 | Exploring the Ruins | WORKS | |
| 3-13 | Become Something More | WORKS | |
| 3-14 | Unshakable Nightmares | WORKS | Event 28 confirmed |
| 3-15 | What Remains of Hope | PARTIAL | TODO: Verify event ID (Walk of Echoes, probable CSID 29 or 30) |
| 3-16 | Death Cares Not | WORKS | |
| 3-17 | No Time Like the Future | STUB | Boss fight vs Sempurne auto-completes. Mob data exists (Pool 4914) |
| 3-18 | Sin | PARTIAL | TODO: Verify event ID (Walk of Echoes) |
| 3-19 | Penance | PARTIAL | TODO: Verify event ID. Awards Rhapsody in Puce |
| 3-20 | Vessel of Light | WORKS | |
| 3-21 | The Lifestream of Reisenjima | PARTIAL | TODO: Verify event ID (probable CSID 3) |
| 3-22 | From West to East | PARTIAL | Kill counter for 11 Obstreperous Panopt. Mobs in SQL but no mob scripts — need in-game verification |
| 3-23 | Good Things Come in Threes | PARTIAL | TODO: Verify event ID |
| 3-24 | Tackling the Problem | WORKS | |
| 3-25 | Way to Divinity | WORKS | |
| 3-26 | The Winds of Time | STUB | Boss fight vs Metus auto-completes. Mob data exists (Pool 4820) |
| 3-27 | Calm After the Storm | PARTIAL | TODO: Verify event ID (Walk of Echoes) |
| 3-28 | Nary a Cloud in Sight | PARTIAL | Awards Rhapsody in Ochre but missing Cipher: Iroha reward |
| 3-29 | An Unending Song | PARTIAL | TODO: Verify event ID for nation zone-in |
| 3-30 | A Deep Sleep | WORKS | |
| 3-31 | Guardians | WORKS | |
| 3-32 | Iroha in Distress | WORKS | |
| 3-33 | Absolute Trust | WORKS | |
| 3-34 | The Orb's Radiance | STUB | Boss fight vs Cloud of Darkness auto-completes. Missing Cipher: Iroha II reward |
| 3-35 | A Rhapsody for the Ages | WORKS | Final mission, La Theine cutscene (event 19). Requires Rhapsody in Ochre |

**Chapter 3 verdict**: 16 WORKS, 14 PARTIAL (unverified events/missing mob scripts), 3 STUB. Progression possible but many cutscenes unverified.

---

## Stubbed Boss Battles (confirmed, matches ROV_TODO.md)

| Mission | Boss | Zone | Mob Data |
|---------|------|------|----------|
| 2-36 Pretender to the Throne | Balamor | Escha Ru'Aun | Needs investigation |
| 2-39 Both Paths Taken | Disjoined One | Empyreal Paradox | INCOMPLETE — no mob_pools/spawn_points |
| 3-17 No Time Like the Future | Sempurne | Desuetia-Empyreal Paradox (zone 290) | Pool 4914, exists |
| 3-26 The Winds of Time | Metus | Empyreal Paradox (zone 36) | Pool 4820, exists |
| 3-34 The Orb's Radiance | Cloud of Darkness | Reisenjima Sanctorium (zone 293) | Pool 4819, exists |

All 5 auto-complete on zone-in with `mission:complete(player)`. No battlefield logic.

---

## Escha Zones — Mob Population

| Zone | Mob Spawn Entries | Mob Script Dir | NMs in SQL | Status |
|------|-------------------|----------------|------------|--------|
| Escha Zi'Tah (288) | ~545 | MISSING (no mobs/ dir) | Yes (Blazewing, Bucca, Puca, Pazuzu, Azi Dahaka, Mireu, etc.) | PARTIAL — SQL data exists, no Lua mob scripts |
| Escha Ru'Aun (289) | ~693 | 2 scripts only (Gargouille, Ilaern) | Yes (in SQL) | PARTIAL — minimal mob scripts |
| Reisenjima (291) | ~561 | MISSING (no mobs/ dir) | Yes (in SQL) | PARTIAL — SQL data exists, no Lua mob scripts |

**Key finding**: All three Escha zones have extensive mob spawn data in SQL (including NMs for Geas Fete), but almost no Lua mob scripts exist. Mobs likely spawn but with only default behavior. The Geas Fete NM pop system is not implemented (no `geas_fete` global script).

---

## Rhapsody KI Effects — Bonus Implementation

| KI | Awarded At | XP Bonus | CP Bonus | Skillup Bonus |
|----|-----------|----------|----------|---------------|
| Rhapsody in White | 1-6 Flames of Prayer | +30% | — | +1 tier |
| Rhapsody in Umber | 1-11 A Land After Time | +30% | — | — |
| Rhapsody in Azure | 1-16 The Lost Avatar | +30% | — | — |
| Rhapsody in Crimson | 2-13 From the Ruins | +30% | — | +1 tier |
| Rhapsody in Emerald | 2-30 The Decisive Heroine | +30% | — | — |
| Rhapsody in Mauve | 2-40 The Man Behind the Mask | +30% | — | — |
| Rhapsody in Fuchsia | 3-3 The River Runs Red | — | +30% | +1 tier |
| Rhapsody in Puce | 3-19 Penance | — | +30% | — |
| Rhapsody in Ochre | 3-28 Nary a Cloud in Sight | — | +30% | — |
| Scintillating Rhapsody | (not awarded by missions) | — | — | — |

**Status**: WORKS. All bonuses implemented in `src/map/utils/charutils.cpp`:
- XP: +30% per KI (White through Mauve = up to +180%)
- Capacity Points: +30% per KI (Fuchsia, Puce, Ochre = up to +90%)
- Skillups: +1 tier per KI (White, Crimson, Fuchsia = up to +3)

**Note**: Scintillating Rhapsody (awarded on retail for completing the full storyline) is defined in enums but NOT awarded by any mission script. It is referenced only in `scripts/globals/teleports/eschan_portals.lua` for portal access.

---

## Missing Cipher Rewards (confirmed, matches ROV_TODO.md)

| Item | Retail Award Point | Status |
|------|-------------------|--------|
| Cipher: Iroha | 3-28 Nary a Cloud in Sight | MISSING — item not in DB |
| Cipher: Iroha II | 3-34 The Orb's Radiance | MISSING — item not in DB |

---

## New Findings (not in ROV_TODO.md)

1. **Scintillating Rhapsody KI never awarded**: Defined in enums (KI 2893) and checked by eschan_portals.lua, but no mission script awards it. On retail, this is given upon completing the entire storyline.

2. **Escha Zi'Tah and Reisenjima have zero mob Lua scripts**: While mob spawn data exists in SQL, there is no `mobs/` directory for either zone. Mobs will spawn with default behavior only.

3. **2-35 Eddies of Despair II is a non-boss stub**: This exploration mission (collecting Eschan Droplets through Escha Ru'Aun portals) is also auto-completing on zone-in, separate from the boss battle stubs.

4. **Kill missions (3-2, 3-22) have no mob Lua scripts**: The mission scripts reference `Perfervid_Naraka` and `Obstreperous_Panopt` by name, and SQL spawn data exists, but no corresponding Lua files exist in `scripts/zones/Reisenjima/mobs/`. The `onMobDeath` handler may not fire without a mob script.

---

## Blockers
- 5 boss battles require battlefield implementation (see ROV_TODO.md for full details)
- Walk of Echoes entry from Xarcabard [S] not implemented (blocks 2-17 without GM warp)
- Geas Fete system not implemented (blocks Escha NM content, not mission-blocking)
- ~15 cutscene event IDs unverified (missions complete but may show wrong/no cutscene)
- Cipher: Iroha / Iroha II items not in database
- Scintillating Rhapsody KI not awarded on completion

## Fix Difficulty
- Boss battles: Medium-Hard each (5 total)
- Missing cutscene verification: Easy (in-game testing with `!addmission`)
- Walk of Echoes entry: Medium
- Escha mob scripts: Easy (bulk-generate from SQL data)
- Cipher items: Medium (need item DB entries + trust implementation)
- Scintillating Rhapsody: Easy (add to 3-35 reward)
