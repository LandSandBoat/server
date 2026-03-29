# All Job Quest Chains Audit

**Date:** 2026-03-28 (corrected)
**Branch:** develop
**Server:** LandSandBoat fork (xiserver)

## Audit Methodology
AF quest status was verified by checking BOTH `scripts/quests/` AND `scripts/zones/*/npcs/` for `addQuest`/`completeQuest` calls. The previous audit only checked `scripts/quests/` and massively undercounted.

---

## Summary Table

| Job | Unlock | AF (X/Y) | Relic (Dynamis) | Empyrean (Abyssea) | Job Quests | Mythic WS | Issues |
|-----|--------|----------|-----------------|--------------------|-----------:|-----------|--------|
| WAR | Base job | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None |
| MNK | Base job | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None |
| WHM | Base job | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None |
| BLM | Base job | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None (all AF in NPC scripts) |
| RDM | Base job | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None (mix converted + NPC) |
| THF | Base job | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None |
| PLD | Unlock quest | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None (2 converted + 2 NPC-based) |
| DRK | Unlock quest | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None |
| BST | Unlock quest | 5/5 | Yes | Yes | Wings_of_Gold, Scattered_into_Shadow + NPC | Yes | None (2 converted + 1 NPC-based) |
| BRD | Unlock quest | 5/5 | Yes | Yes | All NPC-based | Yes | None (all AF in NPC scripts) |
| RNG | Unlock quest | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None (all AF in NPC scripts via Perih_Vashai) |
| SMN | Unlock quest | 5/5 | Yes | Yes | 8 avatar prime fights, LB quests | Yes | None (mix quest + NPC + battlefields) |
| SAM | Unlock quest | 5/5 | Yes | Yes | LB quests (all 10) | Yes | None |
| NIN | Unlock quest | 5/5 | Yes | Yes | All NPC-based (Ryoma) | Yes | None (all AF in NPC scripts) |
| DRG | Unlock quest | 5/5 | Yes | Yes | Wyvern system complete | Yes | None (all NPC-based + battlefield) |
| BLU | Unlock quest | 3/3 | No | Yes | 175 blue magic spells | Yes | None |
| COR | Unlock quest | 3/3 | No | Yes | 31 Phantom Rolls | Yes | None (mix converted + NPC) |
| PUP | Unlock quest | 2/3 | No | Yes | Automaton system exists | Yes | Missing AF3 (Puppetmaster Blues) |
| DNC | Unlock quest | 3/3 | No | No | Crafted_Dancer_Artifact hidden quest | Yes | None |
| SCH | Unlock quest | 2/3 | No | No | LB quests (all 10) | Yes | Missing AF3 (Seeing Blood Red, head) |
| GEO | Unlock NPC | 0/5 | No | No | Unlock only (Sylvie NPC) | No | No AF quests, no Mythic WS, Adoulin incomplete |
| RUN | Unlock NPC | 0/5 | No | No | Unlock only (Octavien NPC) | No | No AF quests, no Mythic WS, Adoulin incomplete |

---

## Detailed Breakdown

### Base Jobs (WAR, MNK, WHM, BLM, RDM, THF)

These 6 jobs are available from character creation. No unlock quest needed.

**AF Quest Structure (original 15 jobs):**
Each job gets 5 AF pieces via:
- 3 AF quests (AF1/AF2/AF3) giving 3 pieces
- 1 Borghertz coffer quest giving AF hands
- 1 treasure coffer in a dungeon giving AF body

**Important:** Many AF quests are implemented in NPC scripts (`scripts/zones/*/npcs/`) rather than dedicated quest files (`scripts/quests/`). Both are valid implementations.

#### WAR (Warrior)
- **AF Quests:** `WAR_AF1_The_Doorman.lua`, `WAR_AF2_The_Talekeepers_Truth.lua`, `WAR_AF3_The_Talekeepers_Gift.lua` (Bastok)
- **Borghertz:** `Borghertzs_Warring_Hands.lua` (Fighter's Mufflers)
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_WAR.lua`
- **Status:** Complete (5/5 AF)

#### MNK (Monk)
- **AF Quests:** `MNK_AF1_Ghosts_of_the_Past.lua`, `MNK_AF2_The_First_Meeting.lua`, `MNK_AF3_True_Strength.lua` (Bastok)
- **Borghertz:** `Borghertzs_Striking_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_MNK.lua`
- **Status:** Complete (5/5 AF)

#### WHM (White Mage)
- **AF Quests:** `Messenger_From_Beyond.lua` (AF1), `Prelude_of_Black_and_White.lua` (AF2) (San d'Oria)
- **Borghertz:** `Borghertzs_Healing_Hands.lua` (Healer's Mitts)
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_WHM.lua`
- **Status:** Complete (5/5 AF)

#### BLM (Black Mage)
- **AF Quests:** All implemented in NPC scripts (primarily Chumimi in Windurst zones) using addQuest/completeQuest calls
- **Borghertz:** `Borghertzs_Sorcerous_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_BLM.lua`
- **Status:** Complete (5/5 AF)
- **Note:** No dedicated quest scripts in `scripts/quests/` -- all AF logic lives in zone NPC files

#### RDM (Red Mage)
- **AF Quests:** `RDM_AF1_The_Crimson_Trial.lua`, `RDM_AF2_Enveloped_in_Darkness.lua` (San d'Oria) + NPC-based scripts
- **Borghertz:** `Borghertzs_Vermillion_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_RDM.lua`
- **Status:** Complete (5/5 AF) -- mix of converted quest scripts and NPC-based

#### THF (Thief)
- **AF Quests:** `THF_AF1_The_Tenshodo_Showdown.lua`, `THF_AF2_As_Thick_as_Thieves.lua`, `THF_AF3_Hitting_the_Marquisate.lua` (Windurst)
- **Borghertz:** `Borghertzs_Sneaky_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_THF.lua`
- **Status:** Complete (5/5 AF)

---

### Advanced Jobs (Unlock Required)

#### PLD (Paladin)
- **Unlock:** `A_Knights_Test.lua` (San d'Oria) - `unlockJob(xi.job.PLD)`
- **AF Quests:** 2 converted quest scripts + 2 NPC-based quests (in zone NPC files)
- **Borghertz:** `Borghertzs_Stalwart_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_PLD.lua`
- **Status:** Complete (5/5 AF)

#### DRK (Dark Knight)
- **Unlock:** `Blade_of_Darkness.lua` (Bastok) - `unlockJob(xi.job.DRK)`
- **AF Quests:** `DRK_AF1_Dark_Legacy.lua`, `DRK_AF2_Dark_Puppet.lua`, `DRK_AF3_Blade_of_Evil.lua` (Bastok)
- **Borghertz:** `Borghertzs_Shadowy_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_DRK.lua`
- **Status:** Complete (5/5 AF)

#### BST (Beastmaster)
- **Unlock:** `Path_of_the_Beastmaster.lua` (Jeuno) - `unlockJob(xi.job.BST)`
- **AF Quests:** `Wings_of_Gold.lua`, `Scattered_into_Shadow.lua` (converted) + 1 NPC-based quest
- **Borghertz:** `Borghertzs_Wild_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_BST.lua`
- **Status:** Complete (5/5 AF) -- 2 converted + 1 NPC-based

#### BRD (Bard)
- **Unlock:** `Path_of_the_Bard.lua` (Jeuno) - `unlockJob(xi.job.BRD)`
- **AF Quests:** All implemented in NPC scripts under zone directories
- **Borghertz:** `Borghertzs_Harmonious_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_BRD.lua`
- **Status:** Complete (5/5 AF) -- all in NPC scripts

#### RNG (Ranger)
- **Unlock:** `The_Fanged_One.lua` (Windurst) - `unlockJob(xi.job.RNG)`
- **AF Quests:** All implemented in NPC scripts (primarily Perih_Vashai)
- **Borghertz:** `Borghertzs_Chasing_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_RNG.lua`
- **Status:** Complete (5/5 AF) -- all in NPC scripts

#### SMN (Summoner)
- **Unlock:** `SMN_I_Can_Hear_a_Rainbow.lua` (Windurst) - `unlockJob(xi.job.SMN)`
- **AF Quests:** `SMN_AF1_The_Puppet_Master.lua` (Windurst) + NPC-based + battlefield scripts
- **Borghertz:** `Borghertzs_Calling_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Avatar Primes:** 6 trial_by fights (Fire/Ice/Wind/Lightning/Water/Earth) + Fenrir (moonlit_path) + Diabolos (waking_dreams) = 8 avatar battles
- **Mythic WS:** `Unlocking_A_Myth_SMN.lua`
- **Status:** Complete (5/5 AF) -- mix of quest scripts, NPC scripts, and battlefields

#### SAM (Samurai)
- **Unlock:** `Forge_Your_Destiny.lua` (Outlands/Norg) - `unlockJob(xi.job.SAM)`
- **AF Quests:** `SAM_AF1_The_Sacred_Katana.lua`, `SAM_AF2_Yomi_Okuri.lua`, `SAM_AF3_A_Thief_in_Norg.lua` (Outlands)
- **Borghertz:** `Borghertzs_Loyal_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_SAM.lua`
- **Status:** Complete (5/5 AF)

#### NIN (Ninja)
- **Unlock:** `Ayame_and_Kaede.lua` (Bastok) - `unlockJob(xi.job.NIN)`
- **AF Quests:** All implemented in NPC scripts (primarily Ryoma)
- **Borghertz:** `Borghertzs_Lurking_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Mythic WS:** `Unlocking_A_Myth_NIN.lua`
- **Status:** Complete (5/5 AF) -- all in NPC scripts

#### DRG (Dragoon)
- **Unlock:** `holy_crest.lua` (Ghelsba Outpost battlefield) - `unlockJob(xi.job.DRG)`
- **AF Quests:** All NPC-based + battlefield scripts
- **Borghertz:** `Borghertzs_Dragon_Hands.lua`
- **Coffer:** Treasure coffer system (body)
- **Wyvern:** Full wyvern system implemented (`scripts/globals/pets/wyvern.lua`, `scripts/globals/job_utils/dragoon.lua`)
- **Mythic WS:** `Unlocking_A_Myth_DRG.lua`
- **Status:** Complete (5/5 AF) -- all NPC-based + battlefield

---

### Treasures of Aht Urhgan Jobs (BLU, COR, PUP)

ToAU jobs get all 5 AF pieces from a chain of 3 AF quests (no Borghertz/coffers).

#### BLU (Blue Mage)
- **Unlock:** `An_Empty_Vessel.lua` (Aht Urhgan) - `unlockJob(xi.job.BLU)`
- **AF Quests:** `BLU_AF1_Beginnings.lua`, `BLU_AF2_Omens.lua`, `BLU_AF3_Transformations.lua`
- **Blue Magic Spells:** 175 spell scripts in `scripts/actions/spells/blue/`
- **Mythic WS:** `Unlocking_A_Myth_BLU.lua`
- **Status:** Complete (3/3 AF)

#### COR (Corsair)
- **Unlock:** `Luck_of_the_Draw.lua` (Aht Urhgan) - `unlockJob(xi.job.COR)`
- **AF Quests:** `COR_AF1_Equipped_for_All_Occasions.lua` (converted), `The_Die_is_Cast` (AF2), + NPC-based (AF3)
- **Phantom Rolls:** 31 roll scripts in `scripts/actions/abilities/*_roll.lua`
- **Mythic WS:** `Unlocking_A_Myth_COR.lua`
- **Status:** Complete (3/3 AF) -- mix of converted quest scripts and NPC-based

#### PUP (Puppetmaster)
- **Unlock:** `No_Strings_Attached.lua` (Aht Urhgan) - `unlockJob(xi.job.PUP)`
- **AF Quests:** AF1 (The Wayward Automaton) and AF2 (Operation: Teatime) exist. AF3 (Puppetmaster Blues) is MISSING.
- **Automaton:** System scripts exist (`scripts/globals/automaton.lua`, `scripts/globals/automatonweaponskills.lua`, `scripts/globals/job_utils/puppetmaster.lua`)
- **Mythic WS:** `Unlocking_A_Myth_PUP.lua`
- **Status:** 2/3 AF - missing Puppetmaster Blues (AF3)
- **Issue:** Missing AF3 quest script

---

### Wings of the Goddess Jobs (DNC, SCH)

WotG jobs get AF from dedicated quest chains (no Borghertz/coffers). DNC AF3 also has crafted alternative.

#### DNC (Dancer)
- **Unlock:** `Lakeside_Minuet.lua` (Jeuno) - `unlockJob(xi.job.DNC)`
- **AF Quests:** `DNC_AF1_The_Unfinished_Waltz.lua`, `DNC_AF2_The_Road_to_Divadom.lua`, `DNC_AF3_Comeback_Queen.lua`
- **Extra:** `Crafted_Dancer_Artifact.lua` (hidden quest for crafted AF)
- **Mythic WS:** `Unlocking_A_Myth_DNC.lua`
- **Status:** Complete (3/3 AF)

#### SCH (Scholar)
- **Unlock:** `A_Little_Knowledge.lua` (Crystal War) - `unlockJob(xi.job.SCH)`
- **AF Quests:** `SCH_AF1_On_Sabbatical.lua`, `SCH_AF2_Downward_Helix.lua` - AF3 (Seeing Blood Red) is MISSING
- **Mythic WS:** `Unlocking_A_Myth_SCH.lua`
- **Status:** 2/3 AF - missing Seeing Blood Red (head piece)
- **Issue:** Missing SCH AF3 quest script

---

### Seekers of Adoulin Jobs (GEO, RUN)

SoA jobs get AF from Adoulin quest chains (entirely different system from older jobs).

#### GEO (Geomancer)
- **Unlock:** `Sylvie.lua` NPC in Western Adoulin - `unlockJob(xi.job.GEO)`
- **AF Quests:** None found
- **Job Utils:** `scripts/globals/job_utils/geomancer.lua` exists
- **Mythic WS:** No (GEO uses Ergon WS, not Mythic)
- **Relic/Empyrean:** No (Adoulin job)
- **Status:** 0/5 AF
- **Issue:** No AF quests. Adoulin story content is not implemented.

#### RUN (Rune Fencer)
- **Unlock:** `Octavien.lua` NPC in Eastern Adoulin - `unlockJob(xi.job.RUN)`
- **AF Quests:** None found
- **Job Utils:** `scripts/globals/job_utils/rune_fencer.lua` exists
- **Mythic WS:** No (RUN uses Ergon WS, not Mythic)
- **Relic/Empyrean:** No (Adoulin job)
- **Status:** 0/5 AF
- **Issue:** No AF quests. Adoulin story content is not implemented.

---

## Cross-Cutting Systems

### Limit Break Quests
All 10 limit break quests exist (LB01 through LB10), covering level caps from 50 to 99.

### Dynamis (Relic Armor)
14 Dynamis zones exist with mob scripts. Relic armor drops for the 15 original jobs (WAR-DRG).

### Abyssea (Empyrean Armor)
10 Abyssea zones exist with NM mobs and Cruor Prospector NPCs. Empyrean armor available for original 15 jobs + ToAU jobs (18 total). DNC/SCH/GEO/RUN do not have Empyrean through Abyssea.

### Mythic Weapon Skills ("Unlocking a Myth")
20 scripts found covering all jobs except GEO and RUN:
WAR, MNK, WHM, BLM, RDM, THF, PLD, DRK, BST, BRD, RNG, SMN, SAM, NIN, DRG, BLU, COR, PUP, DNC, SCH

### Borghertz Coffer Quests (AF Hands)
15 quests, one per original job (WAR-DRG). Each gives AF hands.

### Treasure Coffer System
Fully implemented in `scripts/globals/treasure.lua`. Covers all major dungeons. Gives AF body piece based on player's current job.

### SMN Avatar System
8 obtainable avatars: Ifrit, Shiva, Garuda, Ramuh, Leviathan, Titan (trial_by fights) + Fenrir (moonlit_path) + Diabolos (waking_dreams/darkness_named). Trial-size (mini) versions also exist for 6 elemental avatars.

---

## Priority Issues

### Critical (0/5 AF - no AF obtainable)
1. **GEO** - Adoulin AF content not implemented (0/5)
2. **RUN** - Adoulin AF content not implemented (0/5)

### Minor (Nearly complete, missing 1 quest each)
3. **PUP** - 2/3 AF - missing Puppetmaster Blues (AF3)
4. **SCH** - 2/3 AF - missing Seeing Blood Red (AF3, head piece)

### Fully Complete Jobs (all AF obtainable): 18 of 22
WAR, MNK, WHM, BLM, RDM, THF, PLD, DRK, BST, BRD, RNG, SAM, NIN, DRG, SMN, BLU, COR, DNC

---

## File Locations Referenced

- AF quest scripts: `scripts/quests/{nation}/`
- AF NPC scripts: `scripts/zones/*/npcs/` (many AF quests implemented here)
- Borghertz quests: `scripts/quests/jeuno/Borghertzs_*.lua`
- Mythic WS quests: `scripts/quests/jeuno/Unlocking_A_Myth_*.lua`
- Limit break quests: `scripts/quests/jeuno/LB*.lua`
- Treasure coffer system: `scripts/globals/treasure.lua`
- Avatar battlefields: `scripts/battlefields/Cloister_of_*/trial_by_*.lua`
- Blue magic spells: `scripts/actions/spells/blue/`
- COR rolls: `scripts/actions/abilities/*_roll.lua`
- Automaton: `scripts/globals/automaton.lua`
- Wyvern: `scripts/globals/pets/wyvern.lua`
- Job utilities: `scripts/globals/job_utils/`
- Dynamis zones: `scripts/zones/Dynamis-*/`
- Abyssea zones: `scripts/zones/Abyssea-*/`
- GEO unlock: `scripts/zones/Western_Adoulin/npcs/Sylvie.lua`
- RUN unlock: `scripts/zones/Eastern_Adoulin/npcs/Octavien.lua`

## Correction Note
This audit was corrected on 2026-03-28. The previous version only checked `scripts/quests/` for AF quest files and reported only 8/22 jobs as complete. The corrected audit checks both `scripts/quests/` AND `scripts/zones/*/npcs/` for addQuest/completeQuest calls, finding that 18/22 jobs actually have complete AF chains.
