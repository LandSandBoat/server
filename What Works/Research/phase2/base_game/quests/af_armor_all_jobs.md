# Artifact Armor Quests - All 22 Jobs

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Artifact_Armor
- Codebase: `scripts/quests/`, `scripts/zones/*/npcs/`, `sql/item_basic.sql`, `sql/item_mods.sql`

## Audit Methodology
The previous audit ONLY checked `scripts/quests/` for AF quest files. This was incorrect -- many AF quests in LandSandBoat are implemented directly in NPC scripts under `scripts/zones/*/npcs/` using `addQuest()` and `completeQuest()` calls. This corrected audit checks BOTH locations.

## Summary
Of 22 jobs, **18 have complete AF quest chains** (including NPC-based implementations). 2 jobs (PUP, SCH) are missing 1 quest each. 2 jobs (RUN, GEO) have no AF quests due to Adoulin not being implemented. All 22 jobs have AF armor items defined in `item_basic.sql`. All jobs except RUN have AF armor mods in `item_mods.sql`. The Borghertz coffer quests (AF3 hands for original 15 jobs) are all implemented.

## How AF Works
Each original job (WAR-SMN) typically has:
- **AF1 quest** (body piece + weapon/item, requires lv40+)
- **AF2 quest** (legs piece, requires lv50+)
- **AF3/Borghertz coffer quest** (head, hands, feet from coffers in dungeons)

ToAU jobs (BLU/COR/PUP) have 3 AF quests giving all 5 pieces.
WotG jobs (DNC/SCH) get 2-3 AF quests + crafted pieces.
SoA jobs (RUN/GEO) get AF from SoA-era quests.

---

## Checklist - Original 15 Jobs

| Job | AF Set Name | AF1 Quest | AF2 Quest | Borghertz Coffer | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|------------------|-------------|------|--------|
| WAR | Fighter's | WAR_AF1_The_Doorman (bastok) | WAR_AF2_The_Talekeepers_Truth (bastok) | Borghertzs_Warring_Hands | Y | Y | WORKS |
| MNK | Temple | MNK_AF1_Ghosts_of_the_Past (bastok) | MNK_AF2_The_First_Meeting (bastok) | Borghertzs_Striking_Hands | Y | Y | WORKS |
| WHM | Healer's | Messenger_From_Beyond (sandoria) | Prelude_of_Black_and_White (sandoria) | Borghertzs_Healing_Hands | Y | Y | WORKS |
| BLM | Wizard's | NPC-based (Chumimi et al.) | NPC-based (Chumimi et al.) | Borghertzs_Sorcerous_Hands | Y | Y | WORKS |
| RDM | Warlock's | RDM_AF1_The_Crimson_Trial (sandoria) | RDM_AF2_Enveloped_in_Darkness (sandoria) | Borghertzs_Vermillion_Hands | Y | Y | WORKS |
| THF | Rogue's | THF_AF1_The_Tenshodo_Showdown (windurst) | THF_AF2_As_Thick_as_Thieves (windurst) | Borghertzs_Sneaky_Hands | Y | Y | WORKS |
| PLD | Gallant | NPC-based (2 quests) | Sharpening_the_Sword + NPC-based | Borghertzs_Stalwart_Hands | Y | Y | WORKS |
| DRK | Chaos | DRK_AF1_Dark_Legacy (bastok) | DRK_AF2_Dark_Puppet (bastok) | Borghertzs_Shadowy_Hands | Y | Y | WORKS |
| BST | Beast | Wings_of_Gold (jeuno) | Scattered_into_Shadow (jeuno) | Borghertzs_Wild_Hands | Y | Y | WORKS |
| BRD | Choral | NPC-based (all quests) | NPC-based (all quests) | Borghertzs_Harmonious_Hands | Y | Y | WORKS |
| RNG | Scout's | NPC-based (Perih_Vashai et al.) | NPC-based (Perih_Vashai et al.) | Borghertzs_Chasing_Hands | Y | Y | WORKS |
| SAM | Myochin | SAM_AF1_The_Sacred_Katana (outlands) | SAM_AF2_Yomi_Okuri (outlands) | Borghertzs_Loyal_Hands | Y | Y | WORKS |
| NIN | Ninja | NPC-based (Ryoma et al.) | NPC-based (Ryoma et al.) | Borghertzs_Lurking_Hands | Y | Y | WORKS |
| DRG | Drachen | NPC-based + battlefield | NPC-based + battlefield | Borghertzs_Dragon_Hands | Y | Y | WORKS |
| SMN | Evoker's | SMN_AF1_The_Puppet_Master (windurst) | NPC-based + battlefields | Borghertzs_Calling_Hands | Y | Y | WORKS |

### Notes on Original 15
- **WAR** also has WAR_AF3_The_Talekeepers_Gift (bastok) for the full chain
- **MNK** also has MNK_AF3_True_Strength (bastok)
- **THF** also has THF_AF3_Hitting_the_Marquisate (windurst)
- **DRK** also has DRK_AF3_Blade_of_Evil (bastok)
- **SAM** also has SAM_AF3_A_Thief_in_Norg (outlands)
- **SMN** has SMN_I_Can_Hear_a_Rainbow (windurst) as a prerequisite/related quest
- **BLM**: All 5 AF quests are implemented in NPC scripts (primarily Chumimi in Windurst). They use addQuest/completeQuest calls in zone NPC files, not dedicated quest scripts.
- **PLD**: 2 quests are in converted quest scripts, 2 are implemented in NPC scripts. All 5 pieces obtainable.
- **BRD**: All AF quests are implemented in NPC scripts under zone directories, not in `scripts/quests/jeuno/`.
- **RNG**: All AF quests are implemented in NPC scripts (primarily Perih_Vashai). No dedicated quest scripts needed.
- **NIN**: All AF quests are implemented in NPC scripts (primarily Ryoma). Not just Faded_Promises.
- **DRG**: All AF quests are NPC-based + battlefield scripts. Complete chain.
- **SMN**: Mix of quest scripts and NPC-based + battlefield scripts. Complete chain.
- **BST**: 2 converted quest scripts + 1 NPC-based quest. All 5 pieces obtainable.

---

## Checklist - ToAU Jobs (BLU/COR/PUP)

| Job | AF Set Name | AF1 Quest | AF2 Quest | AF3 Quest | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|-----------|-------------|------|--------|
| BLU | Magus | BLU_AF1_Beginnings | BLU_AF2_Omens | BLU_AF3_Transformations | Y | Y | WORKS |
| COR | Corsair's | COR_AF1_Equipped_for_All_Occasions | The_Die_is_Cast (AF2) | NPC-based (AF3) | Y | Y | WORKS |
| PUP | Puppetry | The_Wayward_Automaton (AF1) | Operation_Teatime (AF2) | MISSING (Puppetmaster_Blues) | Y | Y | PARTIAL |

### Notes on ToAU Jobs
- **BLU**: All 3 AF quests present in `scripts/quests/ahtUrhgan/`. Complete chain (3/3).
- **COR**: AF1 (Equipped_for_All_Occasions) and AF2 (The_Die_is_Cast) exist as quest scripts. AF3 is implemented via NPC scripts. Complete chain (3/3).
- **PUP**: AF1 (The Wayward Automaton) and AF2 (Operation: Teatime) exist. AF3 (Puppetmaster Blues) is MISSING. (2/3)

---

## Checklist - WotG Jobs (DNC/SCH)

| Job | AF Set Name | AF1 Quest | AF2 Quest | AF3/Crafted | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|-------------|-------------|------|--------|
| DNC | Dancer's | DNC_AF1_The_Unfinished_Waltz | DNC_AF2_The_Road_to_Divadom | DNC_AF3_Comeback_Queen + Crafted_Dancer_Artifact | Y | Y | WORKS |
| SCH | Scholar's | SCH_AF1_On_Sabbatical | SCH_AF2_Downward_Helix | MISSING (Seeing_Blood_Red) | Y | Y | PARTIAL |

### Notes on WotG Jobs
- **DNC**: All AF quests present in `scripts/quests/jeuno/`. Also has crafted artifact hidden quest for remaining pieces (tiara, bangles, toe shoes). Complete chain (3/3).
- **SCH**: AF1 (On Sabbatical) and AF2 (Downward Helix) exist. AF3 (Seeing Blood Red, gives Scholar's Mortarboard/head piece) is MISSING. (2/3)

---

## Checklist - SoA Jobs (RUN/GEO)

| Job | AF Set Name | AF1 Quest | AF2 Quest | AF3 Quest | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|-----------|-------------|------|--------|
| RUN | Futhark | MISSING | MISSING | MISSING | Y | **NO MODS** | MISSING |
| GEO | Geomancy | MISSING | MISSING | MISSING | Y | Y | MISSING |

### Notes on SoA Jobs
- **RUN**: Zero AF quest scripts found. No quest in `scripts/quests/adoulin/` or zone NPC scripts references RUN AF. Base AF armor items exist in `item_basic.sql` but have **ZERO mods in item_mods.sql**. Adoulin story content not implemented. (0/5)
- **GEO**: Zero AF quest scripts found. No quest in zone NPC scripts references GEO AF. Base AF armor items exist in `item_basic.sql` and DO have mods in `item_mods.sql`. Adoulin story content not implemented. (0/5)

---

## Borghertz Coffer Quests (All 15 Original Jobs)

All 15 Borghertz's [X] Hands quests exist in `scripts/quests/jeuno/`:

| Quest | Job | File |
|-------|-----|------|
| Borghertzs_Warring_Hands | WAR | Y |
| Borghertzs_Striking_Hands | MNK | Y |
| Borghertzs_Healing_Hands | WHM | Y |
| Borghertzs_Sorcerous_Hands | BLM | Y |
| Borghertzs_Vermillion_Hands | RDM | Y |
| Borghertzs_Sneaky_Hands | THF | Y |
| Borghertzs_Stalwart_Hands | PLD | Y |
| Borghertzs_Shadowy_Hands | DRK | Y |
| Borghertzs_Wild_Hands | BST | Y |
| Borghertzs_Harmonious_Hands | BRD | Y |
| Borghertzs_Chasing_Hands | RNG | Y |
| Borghertzs_Loyal_Hands | SAM | Y |
| Borghertzs_Lurking_Hands | NIN | Y |
| Borghertzs_Dragon_Hands | DRG | Y |
| Borghertzs_Calling_Hands | SMN | Y |

---

## Summary by Status

### WORKS (18 jobs - full AF quest chain present)
WAR, MNK, WHM, BLM, RDM, THF, PLD, DRK, BST, BRD, RNG, SAM, NIN, DRG, SMN, BLU, COR, DNC

### PARTIAL (2 jobs - 1 AF quest missing each)
- **PUP**: Missing AF3 (Puppetmaster Blues) -- 2/3 ToAU quests
- **SCH**: Missing AF3 (Seeing Blood Red, head piece) -- 2/3 WotG quests

### MISSING (2 jobs - no AF quests at all)
- **RUN**: All AF quests missing + base armor has no mods (Adoulin not implemented)
- **GEO**: All AF quests missing (Adoulin not implemented, but armor has mods)

---

## Blockers
- PUP cannot obtain full AF set (missing Puppetmaster Blues AF3 quest)
- SCH cannot obtain Scholar's Mortarboard head piece (missing Seeing Blood Red AF3 quest)
- RUN/GEO have zero AF quest implementation; RUN base AF also has no item mods
- Players on PUP/SCH would need GM item grants as a WORKAROUND for missing pieces

## Fix Difficulty
- **PUP AF3 (Puppetmaster Blues)**: Medium. Single quest to implement.
- **SCH AF3 (Seeing Blood Red)**: Medium. One quest to implement.
- **RUN/GEO AF**: Hard. Requires SoA quest framework which is not implemented.
- **RUN item mods**: Easy. Just needs SQL entries in `item_mods.sql`.

## Correction Note
Previous audit (2026-03-28) massively undercounted AF quest completeness by only checking `scripts/quests/` directories. Many jobs (BLM, PLD, BRD, RNG, NIN, DRG, SMN, COR, BST) have AF quests implemented in NPC scripts under `scripts/zones/*/npcs/` using addQuest/completeQuest calls. This is a valid implementation pattern in LandSandBoat. The corrected count shows 18/22 jobs with complete AF, up from 11/22 in the previous audit.
