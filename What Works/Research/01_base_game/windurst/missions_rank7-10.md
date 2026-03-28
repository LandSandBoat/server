# Windurst Missions Rank 7-10

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Windurst_Missions
- Codebase:
  - `scripts/missions/windurst/7_1_The_Sixth_Ministry.lua`
  - `scripts/missions/windurst/7_2_Awakening_of_the_Gods.lua`
  - `scripts/missions/windurst/8_1_Vain.lua`
  - `scripts/missions/windurst/8_2_The_Jester_Whod_be_King.lua`
  - `scripts/missions/windurst/9_1_Doll_of_the_Dead.lua`
  - `scripts/missions/windurst/9_2_Moon_Reading.lua`
  - `scripts/battlefields/Full_Moon_Fountain/moon_reading.lua`

## Summary
All six Rank 7-10 missions have full script implementations with proper NPC interactions, cutscene progression, mob spawns, and battlefield logic. No stubs or auto-completes. Two minor TODO notes exist for optional NPC dialogue but these do not block mission completion. Moon Reading (9-2) has a full two-phase BCNM with Ajido-Marujido ally support.

## Checklist

### Rank 7

| Item | Status | Notes |
|------|--------|-------|
| **7-1 The Sixth Ministry** | WORKS | Full implementation |
| Accept from gate guards | WORKS | All 4 Windurst gate guard zones handle option 18 |
| Tosuka-Porika (Windurst Waters) | WORKS | Gives Optistery Ring, tracks status 0/1/2 |
| Toraimarai Canal - Hinge Oils | WORKS | 4 Hinge Oil mobs in `mob_spawn_points` (IDs 17469666-69), lv65, 900s repop in `mob_groups` |
| Toraimarai Canal - Marble Door (_4pc) | WORKS | Checks all 4 Hinge Oils dead before allowing passage |
| Tome of Magic (5th tome, offset 4) | WORKS | NPC exists in `npc_list` (5 Tomes at 17469829-33), script checks correct offset |
| Reward: Blank Book of the Gods KI + 700 rank points | WORKS | Correctly awarded on completion |
| | | |
| **7-2 Awakening of the Gods** | WORKS | Full implementation |
| Accept from gate guards | WORKS | All 4 zones handle option 19 |
| Leepe-Hoppe / Kerutoto (Windurst Waters) | WORKS | Multi-step dialogue (status 0->1->2, and 5 for completion) |
| Romaa Mihgo / Vanono (Kazham) | WORKS | Proper progression through status 2->3->4 |
| Bonze Marberry (Temple of Uggalepih) | WORKS | NM in `mob_spawn_points` (17428486), lv66, 900s repop, drops 2x Cursed Key (100% each) |
| Granite Door - Trade Cursed Key | WORKS | Script trades key, deletes Blank Book of the Gods, gives Book of the Gods |
| Return to Leepe-Hoppe | WORKS | Completes mission at status 5 with Book of the Gods |
| Reward: Rank 8 + 60,000 gil | WORKS | Correctly set in mission.reward |

### Rank 8

| Item | Status | Notes |
|------|--------|-------|
| **8-1 Vain** | WORKS | Full implementation with extensive zone-entry cutscenes |
| Accept from gate guards | WORKS | All 4 zones handle option 20 |
| Moreno-Toeno (Windurst Waters) | WORKS | Gives Star Seeker KI, sets title "Fugitive Minister Bounty Hunter" |
| Star Seeker tracking cutscenes | WORKS | 16 overworld zones have onZoneIn events with directional hints (Batallia, Beaucedine, Buburimu, Davoi, E/W Ronfaure, E/W Sarutabaruta, Konschtat, La Theine, Meriphataud, N/S Gustaberg, Pashhow, Rolanberry, Ro'Maeve, Sauromugue, Sanctuary of Zi'Tah, Tahrongi, Valkurm, Xarcabard) |
| Qu'Hau Spring (Ro'Maeve) | WORKS | Advances status to 2 |
| Sedal-Godjal (Davoi) | WORKS | Exchanges Star Seeker for Magic-drained Star Seeker at status 2, accepts Curse Wand trade at status 3 |
| Dirtyhanded Gochakzuk (Davoi) | WORKS | NM in `mob_spawn_points` (17387945), lv71, 300s repop, drops 2x Curse Wand (100% each) |
| Reward: 750 rank points | WORKS | Correctly set |
| | | |
| **8-2 The Jester Who'd Be King** | WORKS | Full implementation, complex multi-zone quest |
| Accept from gate guards | WORKS | All 4 zones handle option 21 |
| Apururu (Windurst Woods) | WORKS | Primary quest driver, handles status 0/2/6/7/8/10 with appropriate events |
| Collect 3 Ministry Rings | WORKS | Tosuka-Porika (Optistery), Sedal-Godjal in Davoi (Aurastery via Fei'Yin door), Rukususu in Fei'Yin (Rhinostery) - all advance to status 2 when all 3 collected |
| Kupipi (Heaven's Tower) | WORKS | Status 3 -> 4 cutscene |
| Queen of Swords + Queen of Coins | WORKS | Spawned by Cracked Wall (_5e5) in Outer Horutoto Ruins. Mobs in `mob_spawn_points` (17572201-02), lv72. Both must die to advance status 4->5 |
| Orastery Ring from Cracked Wall | WORKS | Given at status 5, event 71 |
| Shantotto (Windurst Walls) | WORKS | Gives Glove of Perpetual Twilight at status 7 |
| Gate of Darkness (Inner Horutoto) | WORKS | Status 9 -> 10, advances mission |
| Optional Shantotto CS after completion | WORKS | Tracked via mission var 'Option' |
| Reward: Rank 9 + 80,000 gil | WORKS | Correctly set |

### Rank 9

| Item | Status | Notes |
|------|--------|-------|
| **9-1 Doll of the Dead** | WORKS | Full implementation |
| Accept from gate guards | WORKS | All 4 zones handle option 22 |
| Apururu (Windurst Woods) | WORKS | Handles status 0/3/6, primary quest driver |
| Heaven's Tower cutscenes | PARTIAL | Zone-in CS at status 1 works; Door: Vestal Chamber (_6q2) at status 2 works. **TODO in code: Kupipi, Zubaba, and other guards missing dialogue** - cosmetic only, does not block progression |
| Yoran-Oran (Windurst Walls) | WORKS | Status 4 -> 5, hints about Goobbue Humus |
| Goobbue Humus item | WORKS | Drops from mobs (5% rare drop, droplist 1201 and 3228). Also purchasable on AH if stocked |
| Mandragora Warden (Boyahda Tree) | WORKS | NPC exists in `npc_list` (17404382). Trade Goobbue Humus -> Letter from Zonpa-Zippa KI |
| Full Moon Fountain finale | WORKS | Zone-in event at status 7 completes mission |
| Reward: Title "Guiding Star" + 800 rank points | WORKS | Correctly set |
| | | |
| **9-2 Moon Reading** | WORKS | Full implementation with BCNM |
| Accept from gate guards | WORKS | All 4 zones handle option 23 |
| Heaven's Tower - Star Sibyl (_6q2) | WORKS | Multi-step: status 0->1 (sends to collect verses), 1->2 (all 3 verses), 3->4, 4->completion |
| Ancient Verse of Ro'Maeve | WORKS | Qu'Hau Spring interaction, KI granted |
| Ancient Verse of Altepa | WORKS | Chamber of Oracles zone-in from Quicksand Caves, KI granted |
| Ancient Verse of Uggalepih | WORKS | qm_windy_9_2 (???) NPC exists in `npc_list` (17428921), KI granted. Requires Uggalepih Key to access area (10% drop from Tonberry Cutters) |
| Full Moon Fountain BCNM | WORKS | Battlefield ID 225, 30min timer, lv75 cap, 6 players max, trusts allowed |
| BCNM Phase 1: 4 Ace Cardians | WORKS | Ace of Cups + 3 others, superlinked, all must die to trigger phase 2 transition CS |
| BCNM Phase 2: Wyvern + Manticore | WORKS | Spawned after phase 1 allDeath, Ajido-Marujido spawns as ally (entity 33) |
| Post-battle progression | WORKS | battlefieldWin -> status 3, then Heaven's Tower and Windurst Walls CS to complete |
| Kupipi optional dialogue | WORKS | Available at status >= 3 |
| Optional NPC dialogue (18 NPCs) | WORKS | Extensive post-completion dialogue in Heaven's Tower for Aeshushu, Boycoco, Churara, etc. |
| Reward: Rank 10 + 100,000 gil + Windurstian Flag + Title "Vestal Chamberlain" | WORKS | All rewards correctly defined |
| **TODO in code**: Gate guard post-completion events | PARTIAL | Comment notes missing capture for some gate guard events - cosmetic only |

## Blockers
- None that prevent mission completion. All six missions are fully playable end-to-end.
- Goobbue Humus (9-1) has a 5% drop rate which could be tedious for solo players, but this matches retail behavior.
- Uggalepih Key (9-2) has a 10% drop rate, also matching retail.

## Known Minor Issues
- 9-1: TODO comment notes Kupipi/Zubaba/guards missing some dialogue lines in Heaven's Tower (cosmetic)
- 9-2: TODO comment notes some gate guard post-completion events not yet captured (cosmetic)
- These are flavor dialogue and do not affect mission progression

## Fix Difficulty
- Easy (only cosmetic dialogue missing, all gameplay paths complete)
