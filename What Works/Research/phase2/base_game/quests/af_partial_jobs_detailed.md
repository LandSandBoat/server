# AF Armor Quests -- 8 Partial Jobs (Detailed Audit)

Audited: 2026-03-28
Server: xiserver (LandSandBoat fork), branch `develop`

---

## Summary

| Job | AF1 | AF2 | AF3 | Borghertz | All 5 Pieces Obtainable? |
|-----|-----|-----|-----|-----------|--------------------------|
| BLM | PASS | PASS | PASS | PASS | YES |
| PLD | PASS | PASS | PASS | PASS | YES |
| RNG | PASS | PASS | PASS | PASS | YES |
| DRG | PASS | PASS | PASS | PASS | YES |
| BRD | PASS | PASS | PASS | PASS | YES |
| SMN | PASS | PASS | PASS | PASS | YES |
| COR | PASS | PASS | PASS | N/A | YES |
| SCH | PASS | PASS | PARTIAL | N/A | NO -- Mortarboard (head) unobtainable |

---

## BLM -- Black Mage Artifact Armor

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Wizard's Petasos | AF3 quest reward (The Root of the Problem) |
| Body | Wizard's Coat | Borghertz coffer (Monastic Cavern) |
| Hands | Wizard's Gloves | Borghertz quest reward (Borghertz's Sorcerous Hands) |
| Legs | Wizard's Tonban | Borghertz coffer (The Eldieme Necropolis) |
| Feet | Wizard's Sabots | AF2 quest reward (Recollections) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| AF1 | The Three Magi | Windurst | 66 | NPC: `scripts/zones/Heavens_Tower/npcs/Chumimi.lua` | PASS -- Starts/finishes at Chumimi. Reward: Casting Wand (weapon). |
| AF2 | Recollections | Windurst | 67 | NPC: `scripts/zones/Heavens_Tower/npcs/Chumimi.lua` | PASS -- Reward: Wizard's Sabots (feet). Requires AF1 complete + BLM Lv50+. |
| AF3 | The Root of the Problem | Windurst | 68 | NPC: `scripts/zones/Heavens_Tower/npcs/Chumimi.lua`, `scripts/zones/Windurst_Walls/npcs/Koru-Moru.lua` | PASS -- Reward: Wizard's Petasos (head). |
| Borghertz | Borghertz's Sorcerous Hands | Jeuno | 47 | `scripts/quests/jeuno/Borghertzs_Sorcerous_Hands.lua` | PASS -- Hands from quest. Body coffer: Monastic Cavern. Legs coffer: Eldieme Necropolis. Requires AF2 started. |

### Verdict: PASS -- All 5 pieces obtainable.

---

## PLD -- Paladin Artifact Armor

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Gallant Coronet | Borghertz coffer (Garlaige Citadel) |
| Body | Gallant Surcoat | AF3 quest reward (Under Oath) |
| Hands | Gallant Gauntlets | Borghertz quest reward (Borghertz's Stalwart Hands) |
| Legs | Gallant Breeches | Borghertz coffer (Beadeaux) |
| Feet | Gallant Leggings | AF2 quest reward (A Boy's Dream) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| Prereq | Father and Son | San d'Oria | 4 | `scripts/quests/sandoria/Father_and_Son.lua` | PASS -- Required for FAMILY_COUNSELOR title, which gates AF1. |
| AF1 | Sharpening the Sword | San d'Oria | 90 | `scripts/quests/sandoria/Sharpening_the_Sword.lua` | PASS -- Converted quest framework. Reward: Honor Sword (weapon). Requires FAMILY_COUNSELOR title + PLD Lv40+. |
| AF2 | A Boy's Dream | San d'Oria | 28 | NPCs: `scripts/zones/Northern_San_dOria/npcs/Ailbeche.lua`, `scripts/zones/Chateau_dOraguille/npcs/_6h0.lua` | PASS -- Reward: Gallant Leggings (feet). Requires AF1 complete + PLD Lv50. |
| AF3 | Under Oath | San d'Oria | 95 | NPCs: `scripts/zones/Chateau_dOraguille/npcs/_6h0.lua`, `scripts/zones/Southern_San_dOria/npcs/Vemalpeau.lua`, `scripts/zones/Northern_San_dOria/npcs/Ailbeche.lua` | PASS -- Reward: Gallant Surcoat (body). Auto-starts on AF2 completion if PLD Lv50+. |
| Borghertz | Borghertz's Stalwart Hands | Jeuno | 50 | `scripts/quests/jeuno/Borghertzs_Stalwart_Hands.lua` | PASS -- Hands from quest. Legs coffer: Beadeaux. Head coffer: Garlaige Citadel. Requires AF2 started. |

### Verdict: PASS -- All 5 pieces obtainable.

---

## RNG -- Ranger Artifact Armor

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Hunter's Beret | AF2 quest reward (Fire and Brimstone) |
| Body | Hunter's Jerkin | Borghertz coffer (Monastic Cavern) |
| Hands | Hunter's Bracers | Borghertz quest reward (Borghertz's Chasing Hands) |
| Legs | Hunter's Braccae | Borghertz coffer (Crawlers' Nest) |
| Feet | Hunter's Socks | AF3 quest reward (Unbridled Passion) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| AF1 | Sin Hunting | Windurst | 72 | NPC: `scripts/zones/Windurst_Woods/npcs/Perih_Vashai.lua` | PASS -- Reward: Sniping Bow (weapon). RNG Lv40+. |
| AF2 | Fire and Brimstone | Windurst | 73 | NPC: `scripts/zones/Windurst_Woods/npcs/Perih_Vashai.lua` | PASS -- Reward: Hunter's Beret (head). Requires AF1 complete + RNG Lv50+. |
| AF3 | Unbridled Passion | Windurst | 74 | NPC: `scripts/zones/Windurst_Woods/npcs/Perih_Vashai.lua` | PASS -- Reward: Hunter's Socks (feet). Requires AF2 complete + RNG Lv50+. |
| Borghertz | Borghertz's Chasing Hands | Jeuno | 54 | `scripts/quests/jeuno/Borghertzs_Chasing_Hands.lua` | PASS -- Hands from quest. Legs coffer: Crawlers' Nest. Body coffer: Monastic Cavern. Requires AF2 started. |

### Verdict: PASS -- All 5 pieces obtainable.

---

## DRG -- Dragoon Artifact Armor

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Drachen Armet | AF3 quest reward (Knight Stalker) |
| Body | Drachen Mail | Borghertz coffer (Ifrit's Cauldron) |
| Hands | Drachen Finger Gauntlets | Borghertz quest reward (Borghertz's Dragon Hands) |
| Legs | Drachen Brais | AF2 quest reward (Chasing Quotas) |
| Feet | Drachen Greaves | Borghertz coffer (Quicksand Caves) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| Prereq | The Holy Crest (DRG unlock) | San d'Oria | 93 | NPCs: `scripts/zones/Port_San_dOria/npcs/Ceraulian.lua`, `scripts/zones/Chateau_dOraguille/npcs/Rahal.lua` | PASS -- DRG job unlock quest. |
| Prereq | Drachenfall (DRG flag quest) | Bastok | 31 | `scripts/quests/bastok/Drachenfall.lua` | PASS |
| AF1 | A Craftsman's Work | San d'Oria | 91 | NPC: `scripts/zones/Northern_San_dOria/npcs/Miaux.lua` | PASS -- Reward: Peregrine (weapon). DRG Lv40+. |
| AF2 | Chasing Quotas | San d'Oria | 92 | NPC: `scripts/zones/Port_San_dOria/npcs/Ceraulian.lua` | PASS -- Reward: Drachen Brais (legs). Requires AF1 complete + DRG Lv50+. |
| AF3 | Knight Stalker | San d'Oria | 96 | NPCs: `scripts/zones/Chateau_dOraguille/npcs/Rahal.lua`, `scripts/zones/Port_San_dOria/npcs/Ceraulian.lua`, `scripts/zones/Southern_San_dOria/npcs/Balasiel.lua`, `scripts/zones/Temple_of_Uggalepih/npcs/qm15.lua` | PASS -- Reward: Drachen Armet (head). Requires AF2 complete. |
| Borghertz | Borghertz's Dragon Hands | Jeuno | 57 | `scripts/quests/jeuno/Borghertzs_Dragon_Hands.lua` | PASS -- Hands from quest. Body coffer: Ifrit's Cauldron. Feet coffer: Quicksand Caves. Requires AF2 started. |

### Verdict: PASS -- All 5 pieces obtainable.

---

## BRD -- Bard Artifact Armor

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Choral Roundlet | Borghertz coffer (Crawlers' Nest) |
| Body | Choral Justaucorps | AF3 quest reward (The Circle of Time) |
| Hands | Choral Cuffs | Borghertz quest reward (Borghertz's Harmonious Hands) |
| Legs | Choral Cannions | Borghertz coffer (Castle Oztroja) |
| Feet | Choral Slippers | AF2 quest reward (The Requiem) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| Prereq | Path of the Bard (BRD unlock) | Jeuno | -- | `scripts/quests/jeuno/Path_of_the_Bard.lua` | PASS |
| AF1 | Painful Memory | Jeuno | 63 | `scripts/quests/jeuno/Painful_Memory.lua` | PASS -- Converted quest framework. Reward: Paper Knife (weapon). Requires BRD unlock complete + BRD Lv40+. |
| AF2 | The Requiem | Jeuno | 64 | NPC: `scripts/zones/Lower_Jeuno/npcs/Bki_Tbujhja.lua` | PASS -- Reward: Choral Slippers (feet). Requires AF1 complete + BRD Lv50+. |
| AF3 | The Circle of Time | Jeuno | 65 | NPCs: `scripts/zones/Lower_Jeuno/npcs/Mertaire.lua`, `scripts/zones/Xarcabard/npcs/Perennial_Snow.lua`, `scripts/zones/Chateau_dOraguille/npcs/Chalvatot.lua`, `scripts/zones/Monastic_Cavern/npcs/Altar.lua` | PASS -- Reward: Choral Justaucorps (body). Requires AF2 complete + BRD Lv50+. |
| Borghertz | Borghertz's Harmonious Hands | Jeuno | 53 | `scripts/quests/jeuno/Borghertzs_Harmonious_Hands.lua` | PASS -- Hands from quest. Legs coffer: Castle Oztroja. Head coffer: Crawlers' Nest. Requires AF2 started. |

### Verdict: PASS -- All 5 pieces obtainable.

---

## SMN -- Summoner Artifact Armor

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Evoker's Horn | AF3 quest reward (Carbuncle Debacle) |
| Body | Evoker's Doublet | Borghertz coffer (Temple of Uggalepih) |
| Hands | Evoker's Bracers | Borghertz quest reward (Borghertz's Calling Hands) |
| Legs | Evoker's Spats | AF2 quest reward (Class Reunion) |
| Feet | Evoker's Pigaches | Borghertz coffer (Toraimarai Canal) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| Prereq | I Can Hear a Rainbow (SMN unlock) | Windurst | 75 | `scripts/quests/windurst/SMN_I_Can_Hear_a_Rainbow.lua` | PASS |
| AF1 | The Puppet Master | Windurst | 81 | `scripts/quests/windurst/SMN_AF1_The_Puppet_Master.lua` | PASS -- Converted quest framework. Reward: Kukulcan's Staff (weapon). SMN Lv40+. |
| AF2 | Class Reunion | Windurst | 82 | NPCs: `scripts/zones/Windurst_Walls/npcs/Koru-Moru.lua`, `scripts/zones/Windurst_Waters/npcs/Fuepepe.lua`, `scripts/zones/Windurst_Waters/npcs/Furakku-Norakku.lua` | PASS -- Reward: Evoker's Spats (legs). Requires AF1 complete + SMN Lv50+. |
| AF3 | Carbuncle Debacle | Windurst | 83 | NPCs: `scripts/zones/Windurst_Walls/npcs/Koru-Moru.lua`, `scripts/zones/Rabao/npcs/Agado-Pugado.lua`, `scripts/zones/Mhaura/npcs/Ripapa.lua`, battlefield scripts in Cloisters | PASS -- Reward: Evoker's Horn (head). Requires AF2 complete. |
| Borghertz | Borghertz's Calling Hands | Jeuno | 58 | `scripts/quests/jeuno/Borghertzs_Calling_Hands.lua` | PASS -- Hands from quest. Body coffer: Temple of Uggalepih. Feet coffer: Toraimarai Canal. Requires AF2 started. |

### Verdict: PASS -- All 5 pieces obtainable.

---

## COR -- Corsair Artifact Armor

COR/BLU/PUP/DNC/SCH AF works differently from base jobs: no Borghertz quests. Instead, AF pieces come from the main quest chain and sub-quests within AF3.

### AF Set Pieces
| Slot | Item | Source |
|------|------|--------|
| Head | Corsair's Tricorne | AF3 quest reward (Against All Odds -- final completion) |
| Body | Corsair's Frac | AF3 sub-quest (Leleroon's Letter Red -- Raqtibahl in Port San d'Oria) |
| Hands | Corsair's Gants | AF3 sub-quest (Leleroon's Letter Green -- Door House in Windurst Waters) |
| Legs | Corsair's Culottes | AF2 quest reward (Navigating the Unfriendly Seas) |
| Feet | Corsair's Bottes | AF3 sub-quest (Leleroon's Letter Blue -- Door House in Bastok Mines) |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| AF1 | Equipped for All Occasions | Aht Urhgan | 24 | `scripts/quests/ahtUrhgan/COR_AF1_Equipped_for_All_Occasions.lua` | PASS -- Converted quest framework. Reward: Trump Gun (weapon). COR Lv40+. |
| AF2 | Navigating the Unfriendly Seas | Aht Urhgan | 25 | NPCs: `scripts/zones/Arrapago_Reef/npcs/qm6.lua`, `scripts/zones/Nashmau/npcs/Leleroon.lua`, `scripts/zones/Wajaom_Woodlands/npcs/Leypoint.lua` | PASS -- Reward: Corsair's Culottes (legs). Requires AF1 complete + COR Lv50+. |
| AF3 | Against All Odds | Aht Urhgan | 26 | NPCs: `scripts/zones/Aht_Urhgan_Whitegate/Zone.lua`, `scripts/zones/Arrapago_Reef/Zone.lua`, `scripts/zones/Nashmau/npcs/Leleroon.lua` | PASS -- Starts in Whitegate. Contains 3 letter sub-routes via Leleroon for body/hands/feet. Final reward: Corsair's Tricorne (head). |
| AF3-Red | Leleroon's Letter Red | -- | -- | `scripts/zones/Port_San_dOria/npcs/Raqtibahl.lua` | PASS -- Reward: Corsair's Frac (body). |
| AF3-Green | Leleroon's Letter Green | -- | -- | `scripts/zones/Windurst_Waters/npcs/Door_House.lua` | PASS -- Reward: Corsair's Gants (hands). |
| AF3-Blue | Leleroon's Letter Blue | -- | -- | `scripts/zones/Bastok_Mines/npcs/Door_House.lua` | PASS -- Reward: Corsair's Bottes (feet). |

### Verdict: PASS -- All 5 pieces obtainable.

---

## SCH -- Scholar Artifact Armor

SCH AF uses a unique system: AF1 gives a scroll (not armor), AF2 gives bracers, and AF3 ("Seeing Blood Red") is supposed to give the mortarboard (head). Body/pants/loafers come from a separate NPC (Loussaire) after completing AF2.

### AF Set Pieces
| Slot | Item | Source | Status |
|------|------|--------|--------|
| Head | Scholar's Mortarboard | AF3 quest (Seeing Blood Red) | **MISSING -- quest unimplemented** |
| Body | Scholar's Gown | Loussaire sub-quest (Bastok Markets [S]) | PASS |
| Hands | Scholar's Bracers | AF2 quest reward (Downward Helix) | PASS |
| Legs | Scholar's Pants | Loussaire sub-quest (Bastok Markets [S]) | PASS |
| Feet | Scholar's Loafers | Loussaire sub-quest (Bastok Markets [S]) | PASS |

### Quest Chain
| # | Quest | Log | ID | Script Location | Status |
|---|-------|-----|----|-----------------|--------|
| AF1 | On Sabbatical | Crystal War | 32 | `scripts/quests/crystalWar/SCH_AF1_On_Sabbatical.lua` | PASS -- Converted quest framework. Reward: Klimaform Schema (scroll, not armor). SCH Lv40+. |
| AF2 | Downward Helix | Crystal War | 33 | `scripts/quests/crystalWar/SCH_AF2_Downward_Helix.lua` | PASS -- Converted quest framework. Reward: Scholar's Bracers (hands). Requires AF1 complete + SCH Lv50+. |
| AF3 | Seeing Blood Red | Crystal War | 34 | **NO SCRIPT EXISTS** | **FAIL -- Quest ID defined in `scripts/globals/quests.lua` line 743 but has zero implementation in any NPC or zone script. Only referenced in Vingijard (AF reset) and RoE records.** |
| Sub-quests | Loussaire's Requests | -- | -- | `scripts/zones/Bastok_Markets_[S]/npcs/Loussaire.lua` | PASS -- Gives body/pants/loafers via KI fetch sub-quests. Requires AF2 complete + SCH Lv50+. |

### Verdict: PARTIAL -- 4 of 5 pieces obtainable. Scholar's Mortarboard (head) is **unobtainable** because "Seeing Blood Red" has no implementation.

---

## Issues Found

### Critical
| Job | Issue | Impact |
|-----|-------|--------|
| SCH | AF3 quest "Seeing Blood Red" (Crystal War quest ID 34) has no implementation | Scholar's Mortarboard (head) cannot be obtained by any player |

### Notes
- All 7 other "partial" jobs (BLM, PLD, RNG, DRG, BRD, SMN, COR) are actually **fully functional** -- all 5 AF armor pieces are obtainable through their respective quest chains and Borghertz/coffer systems.
- The "partial" classification for those 7 jobs was likely due to incomplete audit coverage, not actual missing functionality.
- SCH is the only genuinely partial job. The Loussaire system for body/pants/loafers works, but the head piece has no quest to award it.
- COR AF3 uses a unique 3-letter sub-route system through Leleroon that spans multiple cities. All 3 routes are implemented.
- SCH AF uses Wings of the Goddess (Crystal War) zones, which may have additional accessibility concerns.

### Potential Fix for SCH
The "Seeing Blood Red" quest would need to be implemented from scratch. It should:
1. Be added to `scripts/quests/crystalWar/` as `SCH_AF3_Seeing_Blood_Red.lua`
2. Reward: `xi.item.SCHOLARS_MORTARBOARD` (item ID 16140)
3. Require completion of "Downward Helix" (AF2) + SCH main job
4. Involve Crystal War era zones (consistent with AF1/AF2 pattern)
