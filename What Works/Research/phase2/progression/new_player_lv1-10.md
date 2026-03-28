# New Player Experience (Level 1-10)

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Quickstart_Guide
- Codebase: See individual sections below

## Summary
The new player experience is **largely functional**. Character creation, intro cutscenes, first missions, signet, Fields of Valor, Records of Eminence, trusts, shops, Mog House, Home Points, and Auction House all have working scripts. The main gap is the **Curio Vendor Moogle** being gated behind Rhapsody in White (an ROV key item), making it unavailable until much later. Survival Guides exist in some but not all starter zones/cities.

---

## 1. Character Creation and First Zone-In

### Intro Cutscene
| Item | Status | Notes |
|------|--------|-------|
| Opening cutscene setting | WORKS | `settings/default/main.lua:119` — `NEW_CHARACTER_CUTSCENE = 1` (enabled by default) |
| charCreate function | WORKS | `scripts/globals/player.lua:130-148` — Sets START_GIL (default 10), gives Adventurer Coupon (if cutscene disabled), sets HomePoint, adds New Adventurer title, sets TutorialProgress=1 |
| Zone-in handler (all 3 nations) | WORKS | All use `xi.moghouse.onMoghouseZoneEvent(player, prevZone)` — handles Mog House exit routing and normal zone-in |

### Key Files
- `scripts/globals/player.lua` (charCreate, onGameIn)
- `settings/default/main.lua` (START_GIL=10, NEW_CHARACTER_CUTSCENE=1)

---

## 2. San d'Oria — First Steps

### First Mission: Smash the Orcish Scouts (M1-1)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `scripts/missions/sandoria/1_1_Smash_the_Orcish_Scouts.lua` |
| Accept from gate guards (Ambrotien, Endracion, Grilau) | WORKS | Events 2000/1000 in S.Sandy, 1000 in N.Sandy; `handleAcceptMission` calls `mission:begin(player)` |
| Trade Orcish Axe to complete | WORKS | `npcUtil.tradeHasExactly(trade, xi.item.ORCISH_AXE)` — handles first-time and repeat |
| Reward: 150 rank points | WORKS | `mission.reward = { rankPoints = 150 }` |
| Repeat support | WORKS | Separate section for repeated completions with different event IDs |

### Gate Guards / Signet
| Item | Status | Notes |
|------|--------|-------|
| Arpevion (S.Sandy gate guard) | WORKS | `scripts/zones/Southern_San_dOria/npcs/Arpevion_TK.lua` — calls `xi.conquest.overseerOnTrigger` |
| Aravoge (S.Sandy gate guard) | WORKS | `scripts/zones/Southern_San_dOria/npcs/Aravoge_TK.lua` — same pattern |
| Signet function | WORKS | `scripts/globals/conquest.lua:654` — signet logic integrated into guard trigger |

### Tutorial NPC (Alaune)
| Item | Status | Notes |
|------|--------|-------|
| Tutorial NPC script | WORKS | `scripts/zones/Southern_San_dOria/npcs/Alaune.lua` — calls `xi.tutorial.onTrigger(player, npc, 916, 0)` |
| Stage progression | WORKS | `scripts/quests/tutorial.lua` — 11 stages: get signet, eat food, skill up, visit AH, get Conquest Voucher, get Raising Earring, earn EXP, get gil, get gate crystal + chocopasses |
| Rewards given correctly | WORKS | Meat Jerky x6, Fire Crystal + Rock Salt + Hare Meat (Sandy), Conquest Voucher, Raising Earring, 800 EXP, 1000 Gil, Free Chocopass x3 |

### Trust NPC (Gondebaud)
| Item | Status | Notes |
|------|--------|-------|
| Trust quest NPC | WORKS | `scripts/zones/Southern_San_dOria/npcs/Gondebaud.lua` — requires level 5+, ENABLE_TRUST_QUESTS=1 |
| Accept trust quest | WORKS | Gives Key Item: Red Institute Card |
| Trade cipher to learn trust | WORKS | `xi.trust.onTradeCipher(player, trade, 3503, 3552, 3553)` — adds spell, consumes cipher |
| ENABLE_TRUST_QUESTS default | WORKS | `settings/default/main.lua:170` — set to 1 |

### Records of Eminence NPC (Rolandienne)
| Item | Status | Notes |
|------|--------|-------|
| ROE NPC script | WORKS | `scripts/zones/Southern_San_dOria/npcs/Rolandienne.lua` |
| First Step Forward (ROE #1) | WORKS | `scripts/globals/roe_records.lua:33-36` — reward: Meat Jerky x6, Memorandoll KI, 100 sparks, 300 exp |
| Sparks shop | WORKS | `xi.sparkshop.onTrigger` opens shop after Memorandoll obtained |
| ENABLE_ROE default | WORKS | `settings/default/main.lua:60` — set to 1 |

### ROE Trust Rewards (Records 932-937)
| Item | Status | Notes |
|------|--------|-------|
| ROE #932: Cipher of Valaineral | WORKS | Reward: Cipher of Valaineral's Alter Ego, 100 sparks, 300 exp |
| ROE #933: Cipher of Mihli | WORKS | Reward: Cipher of Mihli's Alter Ego |
| ROE #934: Cipher of Tenzen | WORKS | Reward: Cipher of Tenzen's Alter Ego |
| ROE #935: Cipher of Adelheid | WORKS | Reward: Cipher of Adelheid's Alter Ego |
| ROE #936: Cipher of Joachim | WORKS | Reward: Cipher of Joachim's Alter Ego |

### Shops
| Item | Status | Notes |
|------|--------|-------|
| Ostalie (general goods) | WORKS | Sells Circlet, Robe, Cuffs, Slops, Eye Drops, Antidote, Potions, Ethers, tools |
| Aveline (weapons/armor) | WORKS | `xi.shop.nation` pattern |
| Ashene (weapons/armor) | WORKS | `xi.shop.nation` pattern |
| Ferdoulemiont (weapons) | WORKS | `xi.shop.nation` pattern |
| Lusiane (armor) | WORKS | `xi.shop.nation` pattern |
| Shilah (magic scrolls) | WORKS | `xi.shop.nation` pattern |
| Multiple other shop NPCs | WORKS | 10+ shop NPCs in Southern San d'Oria |

### Home Points
| Item | Status | Notes |
|------|--------|-------|
| HomePoint#1 through #4 | WORKS | `scripts/zones/Southern_San_dOria/npcs/HomePoint#1-4.lua` — all call `xi.homepoint.onTrigger` |
| HomePoint system | WORKS | `scripts/globals/homepoint.lua` — full data for all cities, teleport between registered points |

### Survival Guide
| Item | Status | Notes |
|------|--------|-------|
| S.Sandy Survival Guide | MISSING | No `Survival_Guide.lua` in Southern_San_dOria/npcs/ |
| N.Sandy Survival Guide | WORKS | `scripts/zones/Northern_San_dOria/npcs/Survival_Guide.lua` exists |
| Note | PARTIAL | Setting comment says "Not Implemented" (`settings/default/main.lua:43`) but scripts exist and call `xi.survivalGuide.onTrigger` |

### Auction House
| Item | Status | Notes |
|------|--------|-------|
| AH Counter script | WORKS | `scripts/zones/Southern_San_dOria/npcs/Auction_Counter.lua` — calls `player:sendMenu(xi.menuType.AUCTION)` |
| Tutorial integration | WORKS | Also calls `xi.tutorial.onAuctionTrigger(player)` to advance tutorial stage |

### Mog House (Moogle NPC)
| Item | Status | Notes |
|------|--------|-------|
| Moogle NPC | WORKS | `scripts/zones/Southern_San_dOria/npcs/Moogle.lua` — calls `xi.moghouse.moogleTrigger/Trade/EventUpdate/EventFinish` |
| Moghouse entry/exit | WORKS | `scripts/globals/moghouse.lua` — handles zone-in/out of Mog House via `onMoghouseZoneEvent` |

### Starter Zone: East/West Ronfaure
| Item | Status | Notes |
|------|--------|-------|
| Mobs exist (E.Ronfaure) | WORKS | Forest Hare, Orcish Fodder, Scarab Beetle, Tunnel Worm, etc. — appropriate lv1-8 mobs |
| Mobs exist (W.Ronfaure) | WORKS | Forest Hare, Wild Sheep, Orcish Fodder, Goblin Thug, etc. — appropriate lv1-10 mobs |
| Field Manual (E.Ronfaure) | WORKS | `scripts/zones/East_Ronfaure/npcs/Field_Manual.lua` — calls `xi.regime.bookOnTrigger` |
| Field Manual (W.Ronfaure) | WORKS | `scripts/zones/West_Ronfaure/npcs/Field_Manual.lua` exists |
| FoV regime data (E.Ronfaure) | WORKS | `scripts/globals/regimes.lua:95-105` — 5 pages, levels 1-8, rewards 270-330 tabs |
| FoV regime data (W.Ronfaure) | WORKS | `scripts/globals/regimes.lua:83-93` — 5 pages, levels 1-8, rewards 270-330 tabs |
| ENABLE_FIELD_MANUALS default | WORKS | `settings/default/main.lua:41` — set to 1 |
| Survival Guide (W.Ronfaure) | WORKS | `scripts/zones/West_Ronfaure/npcs/Survival_Guide.lua` |
| Survival Guide (E.Ronfaure) | MISSING | No Survival_Guide.lua in East_Ronfaure — retail does not have one here either |

---

## 3. Bastok — First Steps

### First Mission: The Zeruhn Report (M1-1)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `scripts/missions/bastok/1_1_The_Zeruhn_Report.lua` |
| Accept from guards (Cleades, Rashid, Malduc, Argus) | WORKS | All 4 zones have accept handlers |
| Go to Zeruhn Mines, talk to Makarim | WORKS | Gives Zeruhn Report key item |
| Return to Naji in Metalworks | WORKS | `mission:complete(player)` + deletes KI |

### Gate Guards / Signet
| Item | Status | Notes |
|------|--------|-------|
| Rabid Wolf (Bastok Markets) | WORKS | `scripts/zones/Bastok_Markets/npcs/Rabid_Wolf_IM.lua` — conquest guard, CITY type |

### Tutorial NPC (Gulldago)
| Item | Status | Notes |
|------|--------|-------|
| Tutorial NPC script | WORKS | `scripts/zones/Bastok_Markets/npcs/Gulldago.lua` — calls `xi.tutorial.onTrigger(player, npc, 518, 1)` |
| Rewards adjusted for Bastok | WORKS | Gives Fire Crystal + Lizard Tail + Honey (nation_offset=1) |

### Trust NPC (Clarion Star)
| Item | Status | Notes |
|------|--------|-------|
| Trust quest NPC | WORKS | `scripts/zones/Port_Bastok/npcs/Clarion_Star.lua` — cipher trade handler with events 437/457/458 |

### Records of Eminence NPC (Isakoth)
| Item | Status | Notes |
|------|--------|-------|
| ROE NPC script | WORKS | `scripts/zones/Bastok_Markets/npcs/Isakoth.lua` — sparkshop + ROE triggers |

### Shops
| Item | Status | Notes |
|------|--------|-------|
| Harmodios, Ciqala, Balthilda, Carmelide, Zhikkom | WORKS | Multiple shop NPCs with `xi.shop.nation` pattern |

### Home Points & Mog House
| Item | Status | Notes |
|------|--------|-------|
| HomePoint#1-3 (Bastok Mines) | WORKS | Scripts exist |
| Moogle (Bastok Mines) | WORKS | Script exists |
| Auction Counter (Bastok Mines + Markets) | WORKS | Both zones have AH scripts |
| Survival Guide (Bastok Mines) | WORKS | `scripts/zones/Bastok_Mines/npcs/Survival_Guide.lua` |

### Starter Zone: North/South Gustaberg
| Item | Status | Notes |
|------|--------|-------|
| Mobs exist (N.Gustaberg) | WORKS | Rock Lizard, Stone Eater, Tunnel Worm, Vulture, Ornery Sheep, Quadavs — lv1-10 range |
| Mobs exist (S.Gustaberg) | WORKS | Huge Hornet, Rock Lizard, Sand/Land/Mole Crab, Ornery Sheep — lv1-8 range |
| Field Manual (N.Gustaberg) | WORKS | Script exists, regime data at `regimes.lua:155-165` — 5 pages, levels 1-8 |
| Field Manual (S.Gustaberg) | WORKS | Script exists, regime data at `regimes.lua:167-176` — levels 1-6 |
| Survival Guide (N.Gustaberg) | WORKS | `scripts/zones/North_Gustaberg/npcs/Survival_Guide.lua` |

---

## 4. Windurst — First Steps

### First Mission: The Horutoto Ruins Experiment (M1-1)
| Item | Status | Notes |
|------|--------|-------|
| Mission script exists | WORKS | `scripts/missions/windurst/1_1_The_Horutoto_Ruins_Experiment.lua` |
| Accept from 4 gate guards | WORKS | Windurst Waters, Walls, Port, Woods all have handlers |
| Unique titles per guard | WORKS | Each zone gives a different recruit title |
| Gizmo puzzle in Inner Horutoto | WORKS | Random gizmo selection, examine handlers, success/fail events |
| Reward: 250 rank points | WORKS | `mission.reward = { rankPoints = 250 }` |

### Gate Guards / Signet
| Item | Status | Notes |
|------|--------|-------|
| Harara (Windurst Woods) | WORKS | `scripts/zones/Windurst_Woods/npcs/Harara_WW.lua` — CITY guard type |
| Panoquieur (Windurst Woods) | WORKS | Another guard option |

### Tutorial NPC (Selele)
| Item | Status | Notes |
|------|--------|-------|
| Tutorial NPC script | WORKS | `scripts/zones/Windurst_Woods/npcs/Selele.lua` — calls `xi.tutorial.onTrigger(player, npc, 813, 2)` |
| Rewards adjusted for Windurst | WORKS | Gives Water Crystal + Bird Egg + Honey (nation_offset=2) |

### Trust NPC (Wetata)
| Item | Status | Notes |
|------|--------|-------|
| Trust quest NPC | WORKS | `scripts/zones/Windurst_Woods/npcs/Wetata.lua` — cipher trade handler with events 862/901/902 |

### Records of Eminence NPC (Fhelm Jobeizat)
| Item | Status | Notes |
|------|--------|-------|
| ROE NPC script | WORKS | `scripts/zones/Windurst_Woods/npcs/Fhelm_Jobeizat.lua` — sparkshop + ROE triggers |

### Shops
| Item | Status | Notes |
|------|--------|-------|
| Wije Tiren, Quesse, Mono Nchaa, Manyny | WORKS | Multiple shop NPCs with `xi.shop.general`/`xi.shop.nation` patterns |

### Home Points & Mog House
| Item | Status | Notes |
|------|--------|-------|
| HomePoint#1-5 (Windurst Woods) | WORKS | Scripts exist |
| HomePoint#1-4 (Windurst Waters) | WORKS | Scripts exist |
| Moogle (Windurst Woods) | WORKS | Script exists |
| Auction Counter (Windurst Woods + Walls) | WORKS | Both zones have AH scripts |
| Survival Guide in city | WORKS | `scripts/zones/Port_Windurst/npcs/Survival_Guide.lua` |

### Starter Zone: East/West Sarutabaruta
| Item | Status | Notes |
|------|--------|-------|
| Mobs exist (E.Sarutabaruta) | WORKS | Mandragora, Savanna Rarab, Giant Bee, Crawler, River Crab — lv1-8 range |
| Mobs exist (W.Sarutabaruta) | WORKS | Tiny Mandragora, Savanna Rarab, Giant Bee, Yagudo, Crawler — lv1-10 range |
| Field Manual (E.Sarutabaruta) | WORKS | Script exists, regime data at `regimes.lua:275-283` — levels 1-6 |
| Field Manual (W.Sarutabaruta) | WORKS | Script exists, regime data at `regimes.lua:263-273` — 5 pages, levels 1-8 |
| Survival Guide (W.Sarutabaruta) | WORKS | `scripts/zones/West_Sarutabaruta/npcs/Survival_Guide.lua` |

---

## 5. Universal Systems

### Curio Vendor Moogle
| Item | Status | Notes |
|------|--------|-------|
| NPC exists (all 3 ports) | WORKS | Port San d'Oria, Port Bastok, Port Windurst all have scripts |
| Gated behind Rhapsody in White | PARTIAL | `scripts/zones/Port_San_dOria/npcs/Curio_Vendor_Moogle.lua:10` — event 9600 plays if player lacks KI, event 9601 (shop) only with KI |
| Stock gated by Rhapsody KIs | PARTIAL | `scripts/globals/shop.lua:426+` — every item requires at minimum `xi.ki.RHAPSODY_IN_WHITE` (ROV Chapter 1 completion) |
| Impact on new players | **BLOCKED** | A brand new player CANNOT use the Curio Vendor at all until completing ROV missions. This matches retail behavior. |

### Records of Eminence — Tutorial Records
| Item | Status | Notes |
|------|--------|-------|
| ROE #1: First Step Forward | WORKS | Reward: Meat Jerky x6 + Memorandoll + 100 sparks + 300 exp |
| ROE #2: Vanquish 1 Enemy | WORKS | Trigger: DEFEAT_MOB, reward: 100 sparks + 500 exp |
| ROE #3: Undertake FoV Regime | WORKS | Reward: 100 sparks + 500 exp |
| ROE #4: Heal without magic | WORKS | Reward: 100 sparks + 500 exp |
| ROE #5: All for One | WORKS | Reward: 100 sparks + 300 exp + 1000 accolades + Concordoll KI |

### Sparks Gear (from ROE NPCs)
| Item | Status | Notes |
|------|--------|-------|
| Sparks shop system | WORKS | `scripts/globals/sparkshop.lua` — full stock of items, skill-up tomes, gear |
| Buy gear with sparks | WORKS | Available immediately after completing First Step Forward and obtaining Memorandoll |

### Trust System
| Item | Status | Notes |
|------|--------|-------|
| Trust casting enabled | WORKS | `settings/default/main.lua:169` — `ENABLE_TRUST_CASTING = 1` |
| Trust quests enabled | WORKS | `settings/default/main.lua:170` — `ENABLE_TRUST_QUESTS = 1` |
| Level 5 requirement | WORKS | All trust quest NPCs check `player:getMainLvl() >= 5` |
| Cipher trade/learn | WORKS | `scripts/globals/trust.lua` — `onTradeCipher` adds spell, consumes item |

### Fields of Valor
| Item | Status | Notes |
|------|--------|-------|
| System enabled | WORKS | `settings/default/main.lua:41` — `ENABLE_FIELD_MANUALS = 1` |
| Regime system | WORKS | `scripts/globals/regimes.lua` — full data for all starter zones |
| FoV buffs (Regen, Refresh, etc.) | WORKS | Purchasable with tabs via finish options in regimes.lua |
| FoV food (Dried Meat, etc.) | WORKS | Available via tabs |

---

## Blockers

1. **Curio Vendor Moogle** requires Rhapsody in White (ROV key item) — a new player cannot use it. This is retail-accurate behavior but worth noting for a small private server where ROV may not be immediately accessible.

2. **Survival Guide "Not Implemented" comment** in `settings/default/main.lua:43` says `ENABLE_SURVIVAL_GUIDE = 1, -- Enables Survival Guides (Not Implemented)`. However, Survival Guide NPC scripts DO exist and call `xi.survivalGuide.onTrigger`. The comment may be outdated. Needs in-game verification.

3. **Southern San d'Oria lacks a Survival Guide** — only Northern San d'Oria has one. This appears to match retail (S.Sandy doesn't have one on retail either).

4. **East Ronfaure and South Gustaberg lack Survival Guides** — only West Ronfaure and North Gustaberg have them. This matches retail placement.

---

## Fix Difficulty
- Overall: **No fixes needed** — the new player experience appears fully functional
- Curio Vendor gating: Retail-accurate, but if desired for a small server, could be made accessible without Rhapsody KI (Easy fix — remove the KI check in the NPC script)
- Survival Guide comment: Cosmetic only (Easy — update the comment in settings)
