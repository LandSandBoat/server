# Artifact Armor Quests - All 22 Jobs

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Artifact_Armor
- Codebase: `scripts/quests/`, `sql/item_basic.sql`, `sql/item_mods.sql`

## Summary
Of 22 jobs, 11 have complete or near-complete AF quest chains. 11 jobs have partially or fully missing AF quest scripts. All 22 jobs have AF armor items defined in `item_basic.sql`. All jobs except RUN have AF armor mods in `item_mods.sql`. The Borghertz coffer quests (AF3 hands for original 15 jobs) are all implemented.

## How AF Works
Each original job (WAR-SMN) typically has:
- **AF1 quest** (body piece + weapon/item, requires lv40+)
- **AF2 quest** (legs piece, requires lv50+)
- **AF3/Borghertz coffer quest** (head, hands, feet from coffers in dungeons)

ToAU jobs (BLU/COR/PUP) have 3 AF quests giving all 5 pieces.
WotG jobs (DNC/SCH) get 2 AF quests + crafted pieces.
SoA jobs (RUN/GEO) get AF from SoA-era quests.

---

## Checklist - Original 15 Jobs

| Job | AF Set Name | AF1 Quest | AF2 Quest | Borghertz Coffer | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|------------------|-------------|------|--------|
| WAR | Fighter's | WAR_AF1_The_Doorman (bastok) | WAR_AF2_The_Talekeepers_Truth (bastok) | Borghertzs_Warring_Hands | Y | Y | WORKS |
| MNK | Temple | MNK_AF1_Ghosts_of_the_Past (bastok) | MNK_AF2_The_First_Meeting (bastok) | Borghertzs_Striking_Hands | Y | Y | WORKS |
| WHM | Healer's | Messenger_From_Beyond (sandoria) | Prelude_of_Black_and_White (sandoria) | Borghertzs_Healing_Hands | Y | Y | WORKS |
| BLM | Wizard's | MISSING | MISSING | Borghertzs_Sorcerous_Hands | Y | Y | PARTIAL |
| RDM | Warlock's | RDM_AF1_The_Crimson_Trial (sandoria) | RDM_AF2_Enveloped_in_Darkness (sandoria) | Borghertzs_Vermillion_Hands | Y | Y | WORKS |
| THF | Rogue's | THF_AF1_The_Tenshodo_Showdown (windurst) | THF_AF2_As_Thick_as_Thieves (windurst) | Borghertzs_Sneaky_Hands | Y | Y | WORKS |
| PLD | Gallant | MISSING | MISSING | Borghertzs_Stalwart_Hands | Y | Y | PARTIAL |
| DRK | Chaos | DRK_AF1_Dark_Legacy (bastok) | DRK_AF2_Dark_Puppet (bastok) | Borghertzs_Shadowy_Hands | Y | Y | WORKS |
| BST | Beast | Wings_of_Gold (jeuno) | Scattered_into_Shadow (jeuno) | Borghertzs_Wild_Hands | Y | Y | WORKS |
| BRD | Choral | Painful_Memory (jeuno) | MISSING | Borghertzs_Harmonious_Hands | Y | Y | PARTIAL |
| RNG | Scout's | MISSING | MISSING | Borghertzs_Chasing_Hands | Y | Y | PARTIAL |
| SAM | Myochin | SAM_AF1_The_Sacred_Katana (outlands) | SAM_AF2_Yomi_Okuri (outlands) | Borghertzs_Loyal_Hands | Y | Y | WORKS |
| NIN | Ninja | Ayame_and_Kaede (bastok) | Faded_Promises (bastok) | Borghertzs_Lurking_Hands | Y | Y | WORKS |
| DRG | Drachen | MISSING | MISSING | Borghertzs_Dragon_Hands | Y | Y | PARTIAL |
| SMN | Evoker's | SMN_AF1_The_Puppet_Master (windurst) | MISSING | Borghertzs_Calling_Hands | Y | Y | PARTIAL |

### Notes on Original 15
- **WAR** also has WAR_AF3_The_Talekeepers_Gift (bastok) for the full chain
- **MNK** also has MNK_AF3_True_Strength (bastok)
- **THF** also has THF_AF3_Hitting_the_Marquisate (windurst)
- **DRK** also has DRK_AF3_Blade_of_Evil (bastok)
- **SAM** also has SAM_AF3_A_Thief_in_Norg (outlands)
- **SMN** has SMN_I_Can_Hear_a_Rainbow (windurst) as a prerequisite/related quest
- **BLM** AF1 "The Three Magi" and AF2 "The Paper Trial"/"Recollections" are MISSING. Only coffer quest exists.
- **PLD** AF1 "A Boy's Dream" and AF2 "Under Oath" are MISSING. Only coffer quest exists.
- **BRD** AF1 exists (Painful Memory), AF2 "The Requiem" is MISSING.
- **RNG** AF1 "Fire and Brimstone" and AF2 "Unbridled Passion" are MISSING. Only coffer quest exists.
- **DRG** AF1 "The Holy Crest" and AF2 "Chasing Quotas" are MISSING. Only coffer quest exists.
- **SMN** AF1 exists, AF2 "Carbuncle Debacle" is MISSING.

---

## Checklist - ToAU Jobs (BLU/COR/PUP)

| Job | AF Set Name | AF1 Quest | AF2 Quest | AF3 Quest | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|-----------|-------------|------|--------|
| BLU | Magus | BLU_AF1_Beginnings | BLU_AF2_Omens | BLU_AF3_Transformations | Y | Y | WORKS |
| COR | Corsair's | COR_AF1_Equipped_for_All_Occasions | The_Die_is_Cast (AF2) | MISSING | Y | Y | PARTIAL |
| PUP | Puppetry | MISSING | MISSING | MISSING | Y | Y | MISSING |

### Notes on ToAU Jobs
- **BLU**: All 3 AF quests present in `scripts/quests/ahtUrhgan/`. Complete chain.
- **COR**: AF1 exists (Equipped_for_All_Occasions, gives Trump Gun). AF2 exists (The_Die_is_Cast, gives Random Ring). AF3 giving remaining armor pieces is MISSING.
- **PUP**: All AF quests MISSING. "No Strings Attached" is the job unlock, not AF. Retail quests "The Wayward Automaton", "Operation: Teatime", "Puppetmaster Blues" do not exist.

---

## Checklist - WotG Jobs (DNC/SCH)

| Job | AF Set Name | AF1 Quest | AF2 Quest | AF3/Crafted | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|-------------|-------------|------|--------|
| DNC | Dancer's | DNC_AF1_The_Unfinished_Waltz | DNC_AF2_The_Road_to_Divadom | DNC_AF3_Comeback_Queen + Crafted_Dancer_Artifact | Y | Y | WORKS |
| SCH | Scholar's | SCH_AF1_On_Sabbatical | SCH_AF2_Downward_Helix | MISSING | Y | Y | PARTIAL |

### Notes on WotG Jobs
- **DNC**: All AF quests present in `scripts/quests/jeuno/`. Also has crafted artifact hidden quest for remaining pieces (tiara, bangles, toe shoes). Complete chain.
- **SCH**: AF1 (On Sabbatical, gives Klimaform Schema) and AF2 (Downward Helix, gives Scholar's Bracers) exist in `scripts/quests/crystalWar/`. AF3 quest for remaining pieces (head, body, feet) is MISSING. No crafted artifact hidden quest exists for SCH either.

---

## Checklist - SoA Jobs (RUN/GEO)

| Job | AF Set Name | AF1 Quest | AF2 Quest | AF3 Quest | Items in DB | Mods | Status |
|-----|-------------|-----------|-----------|-----------|-------------|------|--------|
| RUN | Futhark | MISSING | MISSING | MISSING | Y | **NO MODS** | MISSING |
| GEO | Geomancy | MISSING | MISSING | MISSING | Y | Y | MISSING |

### Notes on SoA Jobs
- **RUN**: Zero AF quest scripts found. No quest in `scripts/quests/adoulin/` references `xi.job.RUN`. Base AF armor items exist in `item_basic.sql` (IDs 26666-27370 range) but have **ZERO mods in item_mods.sql**. The +1 versions also have no mods. Only +2 and +3 reforged versions have mods.
- **GEO**: Zero AF quest scripts found. No quest in `scripts/quests/adoulin/` references `xi.job.GEO`. Base AF armor items exist in `item_basic.sql` and DO have mods in `item_mods.sql`.

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

### WORKS (11 jobs - full AF quest chain present)
WAR, MNK, WHM, RDM, THF, DRK, BST, SAM, NIN, BLU, DNC

### PARTIAL (7 jobs - some AF quests missing)
- **BLM**: AF1+AF2 missing, coffer only
- **PLD**: AF1+AF2 missing, coffer only
- **BRD**: AF2 missing
- **RNG**: AF1+AF2 missing, coffer only
- **DRG**: AF1+AF2 missing, coffer only
- **SMN**: AF2 missing
- **COR**: AF3 missing
- **SCH**: AF3 missing

### MISSING (3 jobs - no AF quests at all)
- **PUP**: All 3 AF quests missing
- **RUN**: All AF quests missing + base armor has no mods
- **GEO**: All AF quests missing (but armor has mods)

---

## Blockers
- 7 jobs cannot obtain AF body and/or legs through quests (BLM, PLD, BRD, RNG, DRG, SMN, COR)
- PUP has zero AF quest implementation
- RUN/GEO have zero AF quest implementation; RUN base AF also has no item mods
- Players on affected jobs would need GM item grants as a WORKAROUND

## Fix Difficulty
- **Missing AF1/AF2 quests (BLM, PLD, BRD, RNG, DRG, SMN)**: Medium-Hard per quest. These are complex multi-step quests with NPCs, battlefields, and cutscenes. Likely waiting on upstream LandSandBoat implementation.
- **COR AF3**: Medium. Single quest to implement.
- **PUP AF1-3**: Hard. Three full quests to implement.
- **SCH AF3**: Medium. One quest + possibly crafting system.
- **RUN/GEO AF**: Hard. Requires SoA quest framework which may not be fully implemented.
- **RUN item mods**: Easy. Just needs SQL entries in `item_mods.sql`.
