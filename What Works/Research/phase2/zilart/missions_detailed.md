# Zilart Missions (ZM1-ZM17) -- Step-by-Step Audit

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Rise_of_the_Zilart_Missions
- Codebase: `scripts/missions/rotz/*.lua`, `scripts/battlefields/` (various)

## Summary
All 17 Zilart mission scripts exist and are fully implemented with proper NPC interactions, battlefield configurations, key item grants, cutscenes, and mission progression. All 4 BCNMs (ZM4, ZM6, ZM8, ZM16) plus the 5 Ark Angel fights (ZM14) have battlefield scripts. One minor TODO noted (ZM5 distance check on headstones). Overall status: **WORKS**.

---

## ZM1: The New Frontier
- bg-wiki: https://www.bg-wiki.com/ffxi/The_New_Frontier
- Script: `scripts/missions/rotz/01_The_New_Frontier.lua`

| Step | Status | Notes |
|------|--------|-------|
| Prerequisite: Rank 6 in home nation | WORKS | Script checks `player:getRank(player:getNation()) >= 6` |
| Zone into Norg for cutscene | WORKS | `onZoneIn` returns event 1 |
| Receive Map of Norg | WORKS | `mission.reward` grants `xi.ki.MAP_OF_NORG` |
| Advance to ZM2 | WORKS | `nextMission` set to `WELCOME_TNORG` |
| Post-completion: replay NPC dialogue | WORKS | `_700` and `Comitiolus` have replaceDefault events |

**Verdict: WORKS** -- Simple zone-in cutscene mission, fully implemented.

---

## ZM2: Welcome t'Norg
- bg-wiki: https://www.bg-wiki.com/ffxi/Welcome_t%27Norg
- Script: `scripts/missions/rotz/02_Welcome_to_Norg.lua`

| Step | Status | Notes |
|------|--------|-------|
| Click Oaken Door (`_700`) in Norg | WORKS | `onTrigger` fires `progressEvent(2)` |
| Cutscene with Gilgamesh | WORKS | Event 2 with updateEvent params for CS data |
| Advance to ZM3 | WORKS | `nextMission` set to `KAZHAMS_CHIEFTAINESS` |

**Verdict: WORKS** -- Single cutscene mission, fully implemented.

---

## ZM3: Kazham's Chieftainness
- bg-wiki: https://www.bg-wiki.com/ffxi/Kazham%27s_Chieftainness
- Script: `scripts/missions/rotz/03_Kazhams_Chieftainess.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(7)` |
| Talk to Jakoh Wahcondalo in Kazham | WORKS | `mission:progressEvent(114)` completes mission |
| Receive Sacrificial Chamber Key | WORKS | `mission.reward` grants `xi.ki.SACRIFICIAL_CHAMBER_KEY` |
| Advance to ZM4 | WORKS | `nextMission` set to `THE_TEMPLE_OF_UGGALEPIH` |

**Verdict: WORKS** -- Simple talk-to-NPC mission, fully implemented.

---

## ZM4: The Temple of Uggalepih
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Temple_of_Uggalepih
- Script: `scripts/missions/rotz/04_The_Temple_of_Uggalepih.lua`
- Battlefield: `scripts/battlefields/Sacrificial_Chamber/temple_of_uggalepih.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(8)` |
| Talk to Jakoh Wahcondalo in Kazham (optional) | WORKS | `mission:event(115)` (note: blocked if Evisceration quest active) |
| Navigate to Sacrificial Chamber | N/A | Zone navigation, not script-controlled |
| BCNM: 3 Tonberries (Grav'iton, Molyb'iton, Tungs'iton) | WORKS | Battlefield has 3 mob groups (main tonberries + elemental + avatar), level cap 75, 30 min, trusts allowed |
| Post-BCNM cutscene (event 7) | WORKS | `missionStatus` set to 1 after win, then event 7 on next zone-in |
| Second cutscene (event 8) | WORKS | Sets `missionStatus` to 2, then completes mission |
| Receive Dark Fragment | WORKS | `mission.reward` grants `xi.ki.DARK_FRAGMENT` |
| Receive title | WORKS | `BEARER_OF_THE_WISEWOMANS_HOPE` |
| Sacrificial Chamber Key consumed | WORKS | `player:delKeyItem(xi.ki.SACRIFICIAL_CHAMBER_KEY)` on completion |
| RoV mission transition | WORKS | Handles `THE_CURSED_TEMPLE` -> `WISDOM_OF_OUR_FOREFATHERS` if applicable |
| Advance to ZM5 | WORKS | `nextMission` set to `HEADSTONE_PILGRIMAGE` |

**Verdict: WORKS** -- Full BCNM implementation with proper multi-phase cutscenes.

---

## ZM5: Headstone Pilgrimage
- bg-wiki: https://www.bg-wiki.com/ffxi/Headstone_Pilgrimage
- Script: `scripts/missions/rotz/05_Headstone_Pilgrimage.lua`

| Step | Status | Notes |
|------|--------|-------|
| Dark Fragment (from ZM4) | WORKS | Already in inventory from ZM4 completion |
| Lightning Fragment - Behemoth's Dominion | WORKS | Headstone spawns Ancient Weapon + Legendary Weapon NMs; grants KI after defeat + cooldown |
| Wind Fragment - Cape Teriggan | WORKS | Spawns Axesarion the Wanderer NM; grants KI + starts Wandering Souls quest |
| Ice Fragment - Cloister of Frost | WORKS | No NM, just click headstone for KI |
| Water Fragment - La Theine Plateau | WORKS | No NM, just click headstone for KI |
| Earth Fragment - Western Altepa Desert | WORKS | No NM, just click headstone for KI |
| Fire Fragment - Yuhtunga Jungle | WORKS | Spawns Tipha + Carthi NMs; grants KI + starts Wrath of the Opo-opos quest |
| Light Fragment - Sanctuary of Zi'Tah | WORKS | Spawns Doomed Pilgrims NM; grants KI + starts Soul Searching quest |
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(9)` |
| All 7 fragments collected -> mission complete | WORKS | `hasAllFragments()` checks all 7 KIs, completes mission at any headstone |
| Receive title | WORKS | `BEARER_OF_THE_EIGHT_PRAYERS` |
| Post-completion headstone messages | WORKS | All 7 zones have `ZILART_MONUMENT` replaceDefault messages |
| Advance to ZM6 | WORKS | `nextMission` set to `THROUGH_THE_QUICKSAND_CAVES` |
| TODO: Distance check on headstones | PARTIAL | Line 26: `-- TODO: Cerment headstones have a distance check` -- minor, does not block completion |

**Verdict: WORKS** -- All 7 headstones implemented with correct NM spawns and KI grants. The missing distance check is cosmetic (on retail you must be close to headstone to interact, but the NPC trigger handles this implicitly).

---

## ZM6: Through the Quicksand Caves
- bg-wiki: https://www.bg-wiki.com/ffxi/Through_the_Quicksand_Caves
- Script: `scripts/missions/rotz/06_Through_the_Quicksand_Caves.lua`
- Battlefield: `scripts/battlefields/Chamber_of_Oracles/through_the_quicksand_caves.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(12)` |
| Navigate to Chamber of Oracles via Quicksand Caves | N/A | Zone navigation |
| BCNM: 3 Antica (Centurio V-III, Triarius V-VIII, Princeps V-XI) | WORKS | Battlefield: 3 mob groups, level cap 75, 30 min, trusts allowed |
| Win BCNM -> mission complete | WORKS | `battlefieldWin == THROUGH_THE_QUICKSAND_CAVES` triggers `mission:complete()` |
| Advance to ZM7 | WORKS | `nextMission` set to `THE_CHAMBER_OF_ORACLES` |

**Verdict: WORKS** -- BCNM fully implemented. bg-wiki confirms 3 Antica enemies matching the mob config.

---

## ZM7: The Chamber of Oracles
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Chamber_of_Oracles
- Script: `scripts/missions/rotz/07_The_Chamber_of_Oracles.lua`

| Step | Status | Notes |
|------|--------|-------|
| Place 8 fragments on 8 pedestals | WORKS | All 8 pedestals scripted: Fire(+1), Dark(+2), Earth(+4), Ice(+8), Light(+16), Lightning(+32), Water(+64), Wind(+128). Bitmask totals to 255. |
| Each pedestal consumes its fragment KI | WORKS | `player:delKeyItem(keyItemId)` on each placement |
| All 8 placed -> cutscene (event 1) | WORKS | When `missionStatus == 255`, event 1 fires |
| Interrupted players can resume | WORKS | `missionStatus == 255` check allows re-triggering event 1 |
| Receive Prismatic Fragment | WORKS | `mission.reward` grants `xi.ki.PRISMATIC_FRAGMENT` |
| Receive title Lightweaver | WORKS | `xi.title.LIGHTWEAVER` in reward |
| Pre-mission pedestal messages | WORKS | `PLACED_INTO_THE_PEDESTAL` for non-active players |
| Post-mission pedestal messages | WORKS | `HAS_LOST_ITS_POWER` for completed players |
| Advance to ZM8 | WORKS | `nextMission` set to `RETURN_TO_DELKFUTTS_TOWER` |

**Verdict: WORKS** -- Elegant bitmask implementation for all 8 fragment placements.

---

## ZM8: Return to Delkfutt's Tower
- bg-wiki: https://www.bg-wiki.com/ffxi/Return_to_Delkfutt%27s_Tower
- Script: `scripts/missions/rotz/08_Return_to_Delkfutts_Tower.lua`
- Battlefield: `scripts/battlefields/Stellar_Fulcrum/return_to_delkfutts_tower.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Aldo in Lower Jeuno (optional) | WORKS | Event 104 (first time) / event 68 (repeat), tracked via `Option` bit 0 |
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(13)` |
| Zone into Lower Delkfutt's Tower from Qufim | WORKS | Optional CS (event 15) tracked via `Option` bit 1 |
| Zone into Stellar Fulcrum | WORKS | Pre-battle event 0, sets `missionStatus` to 1 |
| BCNM: Kam'lanaut | WORKS | Battlefield has Kam'lanaut mob, level cap 75, 30 min, trusts allowed |
| Win BCNM -> missionStatus 2, repositioned | WORKS | Sets status to 2, moves player to post-battle position |
| Post-battle CS (event 17) on next zone-in | WORKS | Completes mission |
| Receive title Destroyer of Antiquity | WORKS | Title in battlefield config |
| Advance to ZM9 | WORKS | `nextMission` set to `ROMAEVE` |

**Verdict: WORKS** -- Full BCNM with pre/post cutscenes properly chained.

---

## ZM9: Ro'Maeve
- bg-wiki: https://www.bg-wiki.com/ffxi/Ro%27Maeve_(Mission)
- Script: `scripts/missions/rotz/09_RoMaeve.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Aldo in Lower Jeuno (optional) | WORKS | Event 84 (first time) / event 24 (repeat), tracked via `Option` var |
| Go to Norg, click Oaken Door | WORKS | `_700` triggers `progressEvent(3)` |
| Choose "Open the door" (option 0) | WORKS | `option == 0` completes mission |
| Advance to ZM10 | WORKS | `nextMission` set to `THE_TEMPLE_OF_DESOLATION` |

**Verdict: WORKS** -- Simple cutscene mission, fully implemented.

---

## ZM10: The Temple of Desolation
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Temple_of_Desolation
- Script: `scripts/missions/rotz/10_The_Temple_of_Desolation.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(10)` |
| Talk to Kamui in Norg (optional) | WORKS | `mission:event(11)` |
| Travel to Ro'Maeve -> Hall of the Gods | N/A | Zone navigation |
| Examine Cermet Grate (`_6z0`) in Hall of the Gods | WORKS | `mission:progressEvent(1)` |
| Cutscene completes mission | WORKS | Event 1 finish -> `mission:complete(player)` |
| Receive title | WORKS | `SEALER_OF_THE_PORTAL_OF_THE_GODS` |
| Advance to ZM11 | WORKS | `nextMission` set to `THE_HALL_OF_THE_GODS` |

**Verdict: WORKS** -- Simple interaction mission, fully implemented.

---

## ZM11: The Hall of the Gods
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Hall_of_the_Gods
- Script: `scripts/missions/rotz/11_The_Hall_of_the_Gods.lua`

| Step | Status | Notes |
|------|--------|-------|
| Examine depression in gate (`_6z0`) in Hall of the Gods | WORKS | `messageSpecial(hallID.text.DEPRESSION_A_CLUE)` |
| Return to Norg, click Oaken Door | WORKS | `_700` triggers `progressEvent(169)` |
| Choose to open door (option 0) | WORKS | `option == 0` completes mission |
| Advance to ZM12 | WORKS | `nextMission` set to `THE_MITHRA_AND_THE_CRYSTAL` |

**Verdict: WORKS** -- Two-step mission (examine gate, return to Norg), fully implemented.

---

## ZM12: The Mithra and the Crystal
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Mithra_and_the_Crystal
- Script: `scripts/missions/rotz/12_The_Mithra_and_the_Crystal.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(170)` |
| Talk to Maryoh Comyujah in Rabao | WORKS | Event 81 with dialog options; accept (option 1) sets `missionStatus` to 1 |
| Decline tracking | WORKS | `Option` var tracks if player declined first time |
| Navigate to Quicksand Caves, find `qm7` | WORKS | Two states: NM not defeated (event 12) vs defeated (event 13) |
| Spawn and defeat Ancient Vessel NM | WORKS | `SpawnMob(ANCIENT_VESSEL)` on event 12 option 1; `nmDefeated` local var set on death |
| Examine `qm7` again for Scrap of Papyrus | WORKS | Event 13 grants `xi.ki.SCRAP_OF_PAPYRUS` |
| Return to Maryoh Comyujah with papyrus | WORKS | Event 83: deletes papyrus, grants `xi.ki.CERULEAN_CRYSTAL`, sets status to 2 |
| Talk to Maryoh again (optional) | WORKS | Event 84 after receiving crystal |
| Go to Hall of the Gods, examine gate (`_6z0`) | WORKS | Event 4 |
| Examine Shimmering Circle | WORKS | Event 3 completes mission |
| Post-completion: qm7 shows nothing | WORKS | `YOU_FIND_NOTHING` message |
| Post-completion: Maryoh dialogue | WORKS | Event 85 |
| Advance to ZM13 | WORKS | `nextMission` set to `THE_GATE_OF_THE_GODS` |

**Verdict: WORKS** -- Multi-step mission with NM fight, KI trading chain, fully implemented with all edge cases.

---

## ZM13: The Gate of the Gods
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Gate_of_the_Gods
- Script: `scripts/missions/rotz/13_The_Gate_of_the_Gods.lua`

| Step | Status | Notes |
|------|--------|-------|
| Zone into Ru'Aun Gardens | WORKS | `onZoneIn` returns event 51 |
| Cutscene grants Tu'Lia access | WORKS | Event 51 finish completes mission |
| Advance to ZM14 | WORKS | `nextMission` set to `ARK_ANGELS` |

**Note:** bg-wiki says the Cerulean Crystal from ZM12 is used at the Shimmering Circle (handled in ZM12's completion), and this mission auto-triggers on zone-in. The script does not explicitly check for Cerulean Crystal here because it was already consumed in ZM12. This matches retail behavior.

**Verdict: WORKS** -- Zone-in cutscene mission, fully implemented.

---

## ZM14: Ark Angels
- bg-wiki: https://www.bg-wiki.com/ffxi/Ark_Angels
- Script: `scripts/missions/rotz/14_Ark_Angels.lua`
- Battlefields: `scripts/battlefields/LaLoff_Amphitheater/ark_angels_1-5.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(171)` |
| Cutscene at blank_divine_might in Shrine of Ru'Avitau | WORKS | Event 53 sets `missionStatus` to 1 |
| BCNM 1: Ark Angel HM (Hume) | WORKS | `ark_angels_1.lua`: mob `ARK_ANGEL_HM`, entry `qm1_1`, checks `!hasKI(SHARD_OF_APATHY)` |
| BCNM 2: Ark Angel TT (Tarutaru) | WORKS | `ark_angels_2.lua`: entry `qm1_2` |
| BCNM 3: Ark Angel MR (Mithra) | WORKS | `ark_angels_3.lua`: entry `qm1_3` |
| BCNM 4: Ark Angel EV (Elvaan) | WORKS | `ark_angels_4.lua`: entry `qm1_4` |
| BCNM 5: Ark Angel GK (Galka) | WORKS | `ark_angels_5.lua`: entry `qm1_5` |
| All 5 BCNMs: level cap 75, 30 min, trusts allowed | WORKS | Consistent across all 5 battlefield scripts |
| Shard KI granted per win | WORKS | Battlefield IDs offset from 288: Apathy(0), Cowardice(1), Envy(2), Arrogance(3), Rage(4) |
| Divine Might (all 5 at once) handles all shards | WORKS | `keyItemIndex == 5` grants all 5 shards + sets DivineMight quest var |
| All 5 shards -> mission complete | WORKS | Checks all 5 KIs present, then `mission:complete()` |
| Advance to ZM15 | WORKS | `nextMission` set to `THE_SEALED_SHRINE` |

**Verdict: WORKS** -- All 5 individual Ark Angel fights + Divine Might variant fully implemented with correct shard distribution.

---

## ZM15: The Sealed Shrine
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Sealed_Shrine
- Script: `scripts/missions/rotz/15_The_Sealed_Shrine.lua`

| Step | Status | Notes |
|------|--------|-------|
| Click Oaken Door in Norg | WORKS | Event 172 when `missionStatus == 0`; sets status to 1 on option 0 |
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(173)` |
| Talk to Aldo in Lower Jeuno (optional) | WORKS | Event 111 (first time) / event 69 (repeat), tracked via `Option` var |
| Zone into Shrine of Ru'Avitau with missionStatus 1 | WORKS | `onZoneIn` returns event 51 |
| Cutscene completes mission | WORKS | Event 51 finish -> `mission:complete()` |
| Advance to ZM16 | WORKS | `nextMission` set to `THE_CELESTIAL_NEXUS` |

**Verdict: WORKS** -- Two-phase cutscene mission (Norg door, then Ru'Avitau zone-in), fully implemented.

---

## ZM16: The Celestial Nexus
- bg-wiki: https://www.bg-wiki.com/ffxi/The_Celestial_Nexus
- Script: `scripts/missions/rotz/16_The_Celestial_Nexus.lua`
- Battlefield: `scripts/battlefields/The_Celestial_Nexus/celestial_nexus.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(173)` |
| Navigate to Celestial Nexus via Shrine of Ru'Avitau | N/A | Zone navigation |
| BCNM: Eald'narche (two-phase fight) | WORKS | Phase 1: Eald'narche + Exoplates + 2 Orbitals. Phase 2: Eald'narche solo. Event 32004 triggers phase transition. |
| Phase 1 -> Phase 2 transition | WORKS | On Phase 1 Eald'narche death: despawn orbitals, start event 32004, despawn P1 mob, spawn P2 mob with 30s engage timer |
| Phase 2 defeat -> battlefield won | WORKS | `battlefield:setStatus(xi.battlefield.status.WON)` |
| Win -> mission complete | WORKS | `battlefieldWin == CELESTIAL_NEXUS` triggers `mission:complete()` |
| Teleport to Hall of the Gods | WORKS | `player:setPos(...)` to Hall of the Gods after completion |
| Receive title | WORKS | `BURIER_OF_THE_ILLUSION` |
| Level cap 75, 30 min, trusts allowed | WORKS | Battlefield config correct |
| Advance to ZM17 | WORKS | `nextMission` set to `AWAKENING` |

**Verdict: WORKS** -- Complex two-phase boss fight fully implemented with proper phase transition mechanics.

---

## ZM17: Awakening
- bg-wiki: https://www.bg-wiki.com/ffxi/Awakening
- Script: `scripts/missions/rotz/17_Awakening.lua`

| Step | Status | Notes |
|------|--------|-------|
| Talk to Gilgamesh in Norg (optional) | WORKS | `mission:event(177)` |
| Zone into Norg for cutscene (event 176) | WORKS | Sets bit 0 of missionStatus (status += 1). Only triggers once. |
| Click `_6tc` (Neptune's Spire door) in Lower Jeuno | WORKS | Event 20 sets bit 1 of missionStatus (status += 2). Only triggers once. |
| Both cutscenes seen (missionStatus == 3) | WORKS | Bitmask: bit 0 (Norg) + bit 1 (Jeuno) = 3 |
| Final event in Norg (event 232 or 234) | WORKS | `missionOnEventFinish` checks `missionStatus == 3` and option 1-4, then completes mission |
| Advance to epilogue | WORKS | `nextMission` set to `THE_LAST_VERSE` |

**Note:** The wiki mentions "Shadows of the Departed" as the next step -- in the code this is `THE_LAST_VERSE` which is the proper mission ID. The quest `scripts/quests/jeuno/Shadows_of_the_Departed.lua` exists in the codebase.

**Verdict: WORKS** -- Bitmask-based multi-cutscene mission, fully implemented. Both required cutscenes tracked independently.

---

## Blockers
None. All 17 Zilart missions are fully implemented and should be completable end-to-end.

## Known Minor Issues
1. **ZM5 (Headstone Pilgrimage):** Line 26 has `-- TODO: Cerment headstones have a distance check` -- on retail, players must be within a certain distance of the headstone to interact. This is a cosmetic/convenience issue only; the NPC trigger system inherently requires proximity, so this should not block gameplay.

## Fix Difficulty
- N/A -- No fixes needed for mission completion.
- The ZM5 distance check TODO is Easy difficulty if desired.

## Battlefield Summary

| Mission | Zone | Mobs | Cap | Time | Trusts |
|---------|------|------|-----|------|--------|
| ZM4 | Sacrificial Chamber | 3 Tonberries + Elemental + Avatar | Lv75 | 30min | Yes |
| ZM6 | Chamber of Oracles | 3 Antica | Lv75 | 30min | Yes |
| ZM8 | Stellar Fulcrum | Kam'lanaut | Lv75 | 30min | Yes |
| ZM14 | La'Loff Amphitheater | 5 separate Ark Angel fights | Lv75 | 30min each | Yes |
| ZM16 | The Celestial Nexus | Eald'narche (2 phases) | Lv75 | 30min | Yes |

## Key Item Chain
```
ZM3:  Receive Sacrificial Chamber Key
ZM4:  Use Sacrificial Chamber Key (consumed) -> Receive Dark Fragment
ZM5:  Receive Fire/Ice/Wind/Earth/Lightning/Water/Light Fragments (7 headstones)
ZM7:  Place all 8 fragments on pedestals (consumed) -> Receive Prismatic Fragment
ZM12: Receive Scrap of Papyrus (from NM) -> Trade for Cerulean Crystal
ZM13: Cerulean Crystal used (in ZM12 completion) -> Tu'Lia access
ZM14: Receive 5 Shards (Apathy/Arrogance/Cowardice/Envy/Rage)
```

## Title Chain
```
ZM4:  Bearer of the Wisewoman's Hope
ZM5:  Bearer of the Eight Prayers
ZM7:  Lightweaver
ZM8:  Destroyer of Antiquity
ZM10: Sealer of the Portal of the Gods
ZM16: Burier of the Illusion
```
