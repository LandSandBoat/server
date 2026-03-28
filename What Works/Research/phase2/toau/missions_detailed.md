# ToAU Missions -- Detailed Step-by-Step Audit

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Treasures_of_Aht_Urhgan_Missions
- Codebase: `scripts/missions/toau/` (48 files), battlefield scripts, instance scripts

## Summary
All 48 ToAU missions have scripts. The full chain from Mission 1 through Mission 48 is implemented with proper progression (each mission sets `nextMission`). Battlefields for missions 15, 22, 29, 35, 42, and 44 all have working instance/battlefield scripts with mob spawns and win conditions. No missions are stubs or auto-completes. A few minor TODOs exist but nothing blocks progression.

**Scripts: 48/48 (100%)**

---

## Mission-by-Mission Checklist

| # | Mission | Status | Type | Key Details |
|---|---------|--------|------|-------------|
| 1 | Land of Sacred Serpents | WORKS | CS (trigger area) | Grants Supplies Package KI. Requires BOARDING_PERMIT and ENABLE_TOAU=1. Trigger area 3 in Whitegate fires CS 3000. |
| 2 | Immortal Sentries | WORKS | Quest (deliver package) | Deliver Supplies Package to any Immortal NPC in 5 zones (Arrapago, Bhaflau, Caedarva, Mt. Zhayolm) OR return to Naja. Grants PSC Wildcat Badge, 150 IS, Mog Locker access. All 5 NPCs scripted. |
| 3 | President Salaheem | WORKS | CS (2-part) | Talk Naja -> Mog Locker scam CS -> zone -> return for CS 3020. Unlocks Assault content access. |
| 4 | Knight of Gold | WORKS | Quest (multi-step) | Naja -> Cacaroon (pay 1000 gil or 1 Imperial Bronze Piece) -> trigger areas -> Nadeey -> CS. Grants Raillefal's Letter KI. |
| 5 | Confessions of Royalty | WORKS | CS (Halver) | Take Raillefal's Letter to Halver in Chateau d'Oraguille. Letter consumed on completion. |
| 6 | Easterly Winds | WORKS | CS + reward | Ru'Lude Gardens trigger area CS. Rewards 10 Imperial Bronze Pieces. Optional Halver dialog. |
| 7 | Westerly Winds | WORKS | CS (2-part) | Whitegate trigger area -> Raillefal's Note KI + 1 Imperial Silver Piece -> talk Naja to complete. Grants Agent of the Allied Forces title. |
| 8 | A Mercenary Life | WORKS | CS (2-part, zone required) | Talk Naja (alternating dialog) -> zone -> trigger area 3 -> interactive CS 3050 with dialog choices. |
| 9 | Undersea Scouting | WORKS | Quest (travel) | Talk Naja -> go to Alzadaal Undersea Ruins trigger area 23 -> CS. Grants Astral Compass KI. |
| 10 | Astral Waves | WORKS | CS + timer | Talk Naja for CS 3052 -> completes -> sets Vanadiel day timer for next mission. |
| 11 | Imperial Schemes | WORKS | CS + timer | Must wait for timer from M10. Trigger area 6 in Whitegate -> CS 3070 -> sets new timer. Alternating Naja dialog. |
| 12 | Royal Puppeteer | WORKS | Quest (trade) | Must wait for timer from M11. Go to Nashmau, talk Pyopyoroon -> trade Vial of Jody's Acid -> grants Vial of Spectral Scent KI. |
| 13 | Lost Kingdom | WORKS | Quest (NM fight) | Use Spectral Scent at Jazaraat's Headstone in Caedarva Mire -> spawn + kill Jazaraat NM -> examine headstone again. Grants Ephramadian Gold Coin KI. Post-completion: can re-obtain coin from headstone. |
| 14 | The Dolphin Crest | WORKS | CS | Talk Naja -> CS 3072 -> complete. Simple cutscene mission. |
| 15 | The Black Coffin | WORKS | Instance (The Ashu Talif) | Requires Ephramadian Gold Coin KI. Enter via Arrapago Reef trigger area. Instance spawns Gessho ally + 2 waves of Ashu Talif Crew (5 per wave, wave 2 includes Captain). Coin consumed on entry. Victory -> zone to Nashmau for completion CS. Full instance script with fail/win handlers. |
| 16 | Ghosts of the Past | WORKS | CS (dress-up) | Talk Naja -> elaborate dress-up CS with 8 outfit choices (bitmask tracking). Royal Palace armor check. |
| 17 | Guests of the Empire | WORKS | Quest (dress-up + palace) | Talk Naja -> dress-up again -> go to Imperial Whitegate NPC with proper attire (no weapons equipped, correct armor). Rewards Imperial Mythril Piece + title. Timer set for next mission. |
| 18 | Passing Glory | WORKS | CS + timer | Must wait for timer from M17. Trigger area 3 -> CS 3090 with event update. |
| 19 | Sweets for the Soul | WORKS | CS | Trigger area 5 in Whitegate -> CS 3092. Grants Karababa's Tour Guide title. |
| 20 | Teahouse Tumult | WORKS | Quest (zone + NPC) | Zone into Aydeewa Subterrane for CS -> examine blank_toau20 NPC for second CS. |
| 21 | Finders Keepers | WORKS | CS | Trigger area 3 in Whitegate -> CS 3093 -> complete. |
| 22 | Shield of Diplomacy | WORKS | Battlefield (Khimaira 13) | Zone into Navukgo Execution Chamber for CS -> examine gate -> enter battlefield. Fight Khimaira 13 with Karababa ally. BattlefieldMission with 30min timer, trusts allowed, 6 players max. Karababa spawns as ally (NOTE: missing spell lists, standback behavior only). Grants Karababa's Bodyguard title. |
| 23 | Social Graces | WORKS | CS + timer | Trigger area 3 -> CS 3095 with event update -> timer set. |
| 24 | Foiled Ambition | WORKS | CS + timer | Must wait for timer from M23. Trigger area 3 -> CS 3097 -> rewards 5 Imperial Gold Pieces + title. Sets new timer. |
| 25 | Playing the Part | WORKS | CS + timer | Must wait for timer from M24. Talk Naja when timer expired -> CS 3110. Alternating dialog while waiting. |
| 26 | Seal of the Serpent | WORKS | CS (palace) | Talk Imperial Whitegate NPC with no weapons equipped -> CS 3111. |
| 27 | Misplaced Nobility | WORKS | CS | Go to Aydeewa Subterrane, examine blank_toau20 -> CS 12. |
| 28 | Bastion of Knowledge | WORKS | CS | Trigger area 4 in Whitegate -> CS 3112. Grants Aphmau's Mercenary title. |
| 29 | Puppet in Peril | WORKS | Battlefield (Jade Sepulcher) | Examine door in Jade Sepulcher -> enter battlefield. Fight Lancelord Gaheel Ja. BattlefieldMission, 30min, trusts allowed. TODO: Gaheel Ja missing fight text and may have incomplete mob mechanics. |
| 30 | Prevalence of Pirates | WORKS | CS (zone + area) | Zone into Arrapago Reef for CS -> trigger area 1 for second CS. Grants Periqia Assault Area Entry Permit KI. |
| 31 | Shades of Vengeance | WORKS | CS (zone) | Zone into Caedarva Mire for CS -> complete. Can re-obtain Periqia entry permit from Nashib NPC (timer gated). Grants Nashmeira's Mercenary title. |
| 32 | In the Blood | WORKS | CS + timer | Talk Naja -> CS 3113 -> complete -> sets timer. Rewards Imperial Gold Piece. |
| 33 | Sentinel's Honor | WORKS | CS + timer | Must wait for timer from M32. Talk Naja -> if timer up, CS 3130. Otherwise cycling dialog. |
| 34 | Testing the Waters | WORKS | Quest (travel + choice) | Go to Arrapago Reef trigger area 1 with Ephramadian Gold Coin -> answer question (wrong = must zone and retry) -> teleported to Talacca Cove for completion CS. Coin consumed. Grants Percipient Eye KI + title. |
| 35 | Legacy of the Lost | WORKS | Battlefield (Talacca Cove) | Fight Gessho in Talacca Cove. BattlefieldMission, 30min, trusts allowed. TODO: Gessho missing fight text and may have incomplete clone spawning mechanics. Grants Gessho's Mercy title. |
| 36 | Gaze of the Saboteur | WORKS | Quest (zone + NPC) | Zone into Hazhalm Testing Grounds for CS -> examine Entry Gate -> second CS. Percipient Eye KI consumed. Grants Luminian Dagger KI + Emissary of the Empress title. |
| 37 | Path of Blood | WORKS | CS (2-part, force zone) | Trigger area 3 -> CS 3131 -> force zone to Whitegate -> CS 3220 on re-entry. Timer set. |
| 38 | Stirrings of War | WORKS | CS + timer | Must wait for timer from M37. Trigger area 5 -> CS 3136. Grants Allied Council Summons KI. |
| 39 | Allied Rumblings | WORKS | CS (Ru'Lude) | Go to Ru'Lude Gardens trigger area 1 -> CS 10097. Sets timer for next mission. |
| 40 | Unraveling Reason | WORKS | Quest (multi-zone) | Must wait for timer from M39. Talk Pherimociel in Ru'Lude Gardens -> teleported to Wajaom Woodlands -> 3 sequential zone-in cutscenes (status 1->2->3->complete). Grants Endymion Paratrooper title. |
| 41 | Light of Judgement | WORKS | CS | Talk Rodin-Comidin in Whitegate -> CS 3137. Grants Nyzul Isle Route KI. |
| 42 | Path of Darkness | WORKS | Instance (Nyzul Isle) | Requires Nyzul Isle Route KI. Instance 7700. 3-phase fight: (1) Amnaf BLU + Gears, (2) Amnaf BLU again, (3) Amnaf Psycheflayer. Naja Salaheem ally must survive. Full instance script with phase transitions (progress 10->24->30->48->50). Nyzul Isle Route consumed. TODO: Workaround for Runic Seal NPC onEventFinish not firing during event 116. Grants Naja's Comrade in Arms title. |
| 43 | Fangs of the Lion | WORKS | CS | Trigger area 3 -> CS 3138 with event update. Grants Mythril Mirror KI + Nashmeira's Loyalist title. |
| 44 | Nashmeira's Plea | WORKS | Instance (Nyzul Isle) | Requires Mythril Mirror KI. Instance 7701. 3-phase fight: Raubahn -> Razfahd -> Alexander. On progress 4, first two despawn and Alexander spawns. Mirror consumed. TODO: Same Runic Seal workaround as M42. Grants Preventer of Ragnarok title. |
| 45 | Ragnarok | WORKS | CS | Trigger area 3 -> CS 3139 -> complete. Story resolution cutscene. |
| 46 | Imperial Coronation | WORKS | CS + reward choice | Talk Imperial Whitegate NPC (no weapons, proper attire) -> choose ring reward (Balrahn's/Ulthalam's/Jalzahn's Ring) + Imperial Standard. Post-completion: can get replacement rings/standard. TODO: Nadeey NPC ring-recovery event not implemented. |
| 47 | The Empress Crowned | WORKS | CS + reward | Trigger area 3 -> CS 3144. Rewards Glory Crown + Eternal Mercenary title. |
| 48 | Eternal Mercenary | WORKS | CS (final) | Talk Naja for final dialog CS 3151. No further progression. Replaces default dialog. |

---

## Key Findings

### Access Path (Mission 1)
- Players need the BOARDING_PERMIT key item (from quest "The Road to Aht Urhgan" in Mhaura)
- `ENABLE_TOAU` setting must be 1 (checked in mission 1's check function)
- Mission 1 is set on character creation (noted in script comment)
- Trigger area 3 in Aht Urhgan Whitegate fires the opening cutscene

### Assault Relationship
- **No assault completion is required for any ToAU mission**
- Mission 30 (Prevalence of Pirates) GRANTS the Periqia Assault Area Entry Permit as a reward
- Mission 31 (Shades of Vengeance) allows re-obtaining the permit from Nashib NPC
- Mercenary rank is read for dialog but never gates mission progression

### Mercenary Rank System
- Rank is determined by Wildcat Badge key items (PSC through Captain)
- `xi.besieged.getMercenaryRank()` checks badges in reverse order
- Rank is displayed in many cutscenes but does NOT gate any mission
- PSC Wildcat Badge granted in Mission 2 as part of the storyline
- Rank progression is handled separately through assault/besieged systems

### Battlefield Summary
| Mission | Zone | Fight | Instance ID | Notes |
|---------|------|-------|-------------|-------|
| 15 | The Ashu Talif | Ashu Talif Crew (2 waves) + Captain | 6000 | Gessho ally, coin consumed |
| 22 | Navukgo Execution Chamber | Khimaira 13 | Battlefield | Karababa ally (missing spell lists) |
| 29 | Jade Sepulcher | Lancelord Gaheel Ja | Battlefield | Missing fight text/mechanics TODO |
| 35 | Talacca Cove | Gessho | Battlefield | Missing fight text/clone mechanics TODO |
| 42 | Nyzul Isle | Amnaf (3 phases) + Naja ally | 7700 | Runic Seal workaround needed |
| 44 | Nyzul Isle | Raubahn -> Razfahd -> Alexander | 7701 | Runic Seal workaround needed |

### Timer-Gated Missions
Missions 10, 11, 12, 17, 18, 23, 24, 25, 32, 33, 37, 38, 39, 40 use Vanadiel day timers (zone + wait). This is retail-accurate behavior.

---

## TODOs Found in Code
1. **Mission 2**: `npcUtil.completeMission should support granting IS` -- minor, IS is granted via separate call
2. **Mission 3**: `Maybe it's used?` -- about a flashback CS variant, cosmetic only
3. **Mission 22**: Karababa ally missing spell lists, only has standback + melee behavior
4. **Mission 29**: Lancelord Gaheel Ja missing fight text and possibly incomplete mob mechanics
5. **Mission 35**: Gessho missing fight text and improper clone spawning
6. **Mission 42**: Workaround for Runic Seal NPC onEventFinish not firing during event 116
7. **Mission 44**: Same Runic Seal workaround as Mission 42
8. **Mission 46**: Nadeey NPC ring-recovery event not implemented; full-inventory handling incomplete

---

## Blockers
- **None that prevent completion.** All 48 missions can be progressed from start to finish.
- Battlefield ally AI (Karababa M22, Gessho M35) may behave sub-optimally but fights are winnable.
- Runic Seal workaround for M42/M44 is in place and functional.

## Fix Difficulty
- Karababa spell lists (M22): **Medium** -- needs spell list data and AI behavior
- Gaheel Ja fight text (M29): **Easy** -- cosmetic text additions
- Gessho clone spawning (M35): **Medium** -- needs mechanic research
- Nadeey ring recovery (M46): **Easy** -- single NPC event
- Runic Seal workaround cleanup (M42/M44): **Medium** -- engine-level NPC event issue
