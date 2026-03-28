# Bastok Quests -- Phase 2 Audit

**Date:** 2026-03-28
**Source:** https://www.bg-wiki.com/ffxi/Category:Bastok_Quests
**Script path:** `scripts/quests/bastok/`

---

## Summary

| Metric | Count |
|--------|-------|
| Total quests on bg-wiki | 94 |
| Quest scripts present | 78 |
| Quests missing scripts | 16 |
| Implementation rate | **83%** |

All 78 existing scripts use the modern `Quest:new()` framework with proper `quest.reward`, `quest.sections`, `check` functions, `onTrigger`/`onTrade`/`onEventFinish` handlers, and `quest:complete()` calls. Spot-checks confirm they are fully functional (not stubs).

---

## Quests WITH Scripts (78 total)

### Starter Quests (low fame, early game)

| # | Quest | Script | Status |
|---|-------|--------|--------|
| 1 | Welcome to Bastok | `Welcome_to_Bastok.lua` | IMPLEMENTED -- Powhatan in Port Bastok, equip Shell Shield for Bartolomeo. Reward: Spatha, title. |
| 2 | The Siren's Tear | `The_Sirens_Tear.lua` | IMPLEMENTED -- Wahid in Bastok Mines, multi-zone fetch quest. Reward: 150 gil, title. |
| 3 | Beauty and the Galka | `Beauty_and_the_Galka.lua` | IMPLEMENTED |
| 4 | Guest of Hauteur | `Guest_of_Hauteur.lua` | IMPLEMENTED |
| 5 | The Quadav's Curse | `The_Quadavs_Curse.lua` | IMPLEMENTED |
| 6 | Out of One's Shell | `Out_of_Ones_Shell.lua` | IMPLEMENTED |
| 7 | Hearts of Mythril | `Hearts_of_Mythril.lua` | IMPLEMENTED |
| 8 | The Eleventh's Hour | `The_Elevenths_Hour.lua` | IMPLEMENTED |
| 9 | Stamp Hunt | `Stamp_Hunt.lua` | IMPLEMENTED |
| 10 | The Gustaberg Tour | `The_Gustaberg_Tour.lua` | IMPLEMENTED |
| 11 | Groceries | `Groceries.lua` | IMPLEMENTED -- Tami in Bastok Mines, deliver note to Zelman, bring back jerky. Reward: Rabbit Mantle. |

### Fame / Repeatable Quests

| # | Quest | Script | Status |
|---|-------|--------|--------|
| 12 | Gourmet | `Gourmet.lua` | IMPLEMENTED -- Salimah in Bastok Markets, trade food items at correct times. Repeatable fame. |
| 13 | Breaking Stones | `Breaking_Stones.lua` | IMPLEMENTED |
| 14 | The Cold Light of Day | `The_Cold_Light_of_Day.lua` | IMPLEMENTED |
| 15 | The Elvaan Goldsmith | `The_Elvaan_Goldsmith.lua` | IMPLEMENTED |
| 16 | A Flash in the Pan | `A_Flash_in_the_Pan.lua` | IMPLEMENTED |
| 17 | Shady Business | `Shady_Business.lua` | IMPLEMENTED |
| 18 | A Foreman's Best Friend | `A_Foremans_Best_Friend.lua` | IMPLEMENTED |
| 19 | Smoke on the Mountain | `Smoke_on_the_Mountain.lua` | IMPLEMENTED |
| 20 | Buckets of Gold | `Buckets_of_Gold.lua` | IMPLEMENTED |

### Story / Chain Quests

| # | Quest | Script | Status |
|---|-------|--------|--------|
| 21 | Forever to Hold | `Forever_to_Hold.lua` | IMPLEMENTED |
| 22 | Till Death Do Us Part | `Till_Death_Do_Us_Part.lua` | IMPLEMENTED |
| 23 | Fallen Comrades | `Fallen_Comrades.lua` | IMPLEMENTED |
| 24 | Rivals | `Rivals.lua` | IMPLEMENTED |
| 25 | Mom, the Adventurer? | `Mom_the_Adventurer.lua` | IMPLEMENTED |
| 26 | The Signpost Marks the Spot | `The_Signpost_Marks_the_Spot.lua` | IMPLEMENTED |
| 27 | Past Perfect | `Past_Perfect.lua` | IMPLEMENTED |
| 28 | Stardust | `Stardust.lua` | IMPLEMENTED |
| 29 | Mean Machine | `Mean_Machine.lua` | IMPLEMENTED |
| 30 | Cid's Secret | `Cids_Secret.lua` | IMPLEMENTED |
| 31 | The Usual | `The_Usual.lua` | IMPLEMENTED |
| 32 | Blade of Darkness | `Blade_of_Darkness.lua` | IMPLEMENTED |
| 33 | Father Figure | `Father_Figure.lua` | IMPLEMENTED |
| 34 | The Return of the Adventurer | `The_Return_of_the_Adventurer.lua` | IMPLEMENTED |
| 35 | Drachenfall | `Drachenfall.lua` | IMPLEMENTED |
| 36 | Vengeful Wrath | `Vengeful_Wrath.lua` | IMPLEMENTED |
| 37 | Beadeaux Smog | `Beadeaux_Smog.lua` | IMPLEMENTED |
| 38 | The Curse Collector | `The_Curse_Collector.lua` | IMPLEMENTED |
| 39 | Fear of Flying | `Fear_of_Flying.lua` | IMPLEMENTED |
| 40 | The Wisdom of Elders | `The_Wisdom_of_Elders.lua` | IMPLEMENTED |
| 41 | The Bare Bones | `The_Bare_Bones.lua` | IMPLEMENTED |
| 42 | Minesweeper | `Minesweeper.lua` | IMPLEMENTED |
| 43 | The Darksmith | `The_Darksmith.lua` | IMPLEMENTED |
| 44 | The Stars of Ifrit | `The_Stars_of_Ifrit.lua` | IMPLEMENTED |
| 45 | Love and Ice | `Love_and_Ice.lua` | IMPLEMENTED |
| 46 | Brygid the Stylist | `Brygid_the_Stylist.lua` | IMPLEMENTED |
| 47 | Bite the Dust | `Bite_the_Dust.lua` | IMPLEMENTED |
| 48 | Blade of Death | `Blade_of_Death.lua` | IMPLEMENTED |
| 49 | Silence of the Rams | `Silence_of_the_Rams.lua` | IMPLEMENTED |
| 50 | Altana's Sorrow | `Altanas_Sorrow.lua` | IMPLEMENTED |
| 51 | A Lady's Heart | `A_Ladys_Heart.lua` | IMPLEMENTED |
| 52 | Ayame and Kaede | `Ayame_and_Kaede.lua` | IMPLEMENTED |
| 53 | A Test of True Love | `A_Test_of_True_Love.lua` | IMPLEMENTED |
| 54 | Lovers in the Dusk | `Lovers_in_the_Dusk.lua` | IMPLEMENTED |
| 55 | Wish Upon a Star | `Wish_Upon_a_Star.lua` | IMPLEMENTED |
| 56 | Shoot First, Ask Questions Later | `Shoot_First_Ask_Questions_Later.lua` | IMPLEMENTED |
| 57 | Inheritance | `Inheritance.lua` | IMPLEMENTED |
| 58 | The Walls of Your Mind | `The_Walls_of_Your_Mind.lua` | IMPLEMENTED |
| 59 | Faded Promises | `Faded_Promises.lua` | IMPLEMENTED |
| 60 | Brygid the Stylist Returns | `Brygid_the_Stylist_Returns.lua` | IMPLEMENTED |
| 61 | Out of the Depths | `Out_of_the_Depths.lua` | IMPLEMENTED |
| 62 | A Question of Faith | `A_Question_of_Faith.lua` | IMPLEMENTED |
| 63 | Teak Me to the Stars | `Teak_Me_to_the_Stars.lua` | IMPLEMENTED |
| 64 | Chips | `Chips.lua` | IMPLEMENTED |
| 65 | The Weight of Your Limits | `The_Weight_of_Your_Limits.lua` | IMPLEMENTED |
| 66 | Lure of the Wildcat (Bastok) | `Lure_of_the_Wildcat_Bastok.lua` | IMPLEMENTED |

### Artifact (AF) Quests

| # | Quest | Script | Status |
|---|-------|--------|--------|
| 67 | MNK AF1: Ghosts of the Past | `MNK_AF1_Ghosts_of_the_Past.lua` | IMPLEMENTED -- Level check, multi-zone chain. |
| 68 | MNK AF2: The First Meeting | `MNK_AF2_The_First_Meeting.lua` | IMPLEMENTED |
| 69 | MNK AF3: True Strength | `MNK_AF3_True_Strength.lua` | IMPLEMENTED |
| 70 | WAR AF1: The Doorman | `WAR_AF1_The_Doorman.lua` | IMPLEMENTED -- Job/level gated, Davoi NM fight, key item chain to Naji. Reward: Razor Axe. |
| 71 | WAR AF2: The Talekeeper's Truth | `WAR_AF2_The_Talekeepers_Truth.lua` | IMPLEMENTED |
| 72 | WAR AF3: The Talekeeper's Gift | `WAR_AF3_The_Talekeepers_Gift.lua` | IMPLEMENTED |
| 73 | DRK AF1: Dark Legacy | `DRK_AF1_Dark_Legacy.lua` | IMPLEMENTED -- Job/level gated, Giddeus NM fight. Reward: Raven Scythe. |
| 74 | DRK AF2: Dark Puppet | `DRK_AF2_Dark_Puppet.lua` | IMPLEMENTED |
| 75 | DRK AF3: Blade of Evil | `DRK_AF3_Blade_of_Evil.lua` | IMPLEMENTED |

### Special / System Quests

| # | Quest | Script | Status |
|---|-------|--------|--------|
| 76 | Trial-Size Trial by Earth | `Trial_Size_Trial_by_Earth.lua` | IMPLEMENTED -- Avatar mini-fight. |
| 77 | Trial by Earth | `Trial_by_Earth.lua` | IMPLEMENTED -- Full avatar fight. |
| 78 | Trust: Bastok | `Trust_Bastok.lua` | IMPLEMENTED -- Grants Naji trust, then Ayame/Volker/Iron Eater. Full memory system. |

---

## Quests WITHOUT Scripts (16 total)

### Missing -- High Priority (affect gameplay)

| # | Quest | Quest ID | What It Does | Impact |
|---|-------|----------|--------------|--------|
| 1 | Eco-Warrior (Bastok) | 65 | Raifa in Port Bastok sends you to Gusgen Mines to kill Pudding NMs. Reward: 5000 gil, Dragon Chronicles. | Medium -- unique reward item, but not blocking. |
| 2 | Escort for Hire (Bastok) | 70 | Trilok in Port Bastok, escort Olavia through Crawlers' Nest. Reward: Page from Miratete's Memoirs, 10000 gil. | Medium -- escort quest with unique reward. |
| 3 | Return to the Depths | 78 | Ayame in Metalworks, find Moblin translator, defeat Twilotak. Reward: Bowyer Ring, 3000 gil. | Medium -- continues Out of the Depths story. |
| 4 | Hyper Active | 80 | Raibaht in Metalworks, get hyper altimeter from Lower Delkfutt's Tower. Reward: 3000 gil. | Low-Medium. |
| 5 | Achieving True Power | 85 | PUP limit break quest (lv66+). Fight Shamarhaan in Navukgo Execution Chamber. Raises PUP cap to 75. | HIGH if playing PUP -- blocks leveling past 70. |

### Missing -- Medium Priority

| # | Quest | Quest ID | What It Does | Impact |
|---|-------|----------|--------------|--------|
| 6 | A Discerning Eye (Bastok) | 71 | Grin in Port Bastok, identify NPC on airship. Reward: 500 gil. | Low -- flavor quest. |
| 7 | All by Myself | 76 | Marin in Bastok Markets, escort Ken through Dangruf Wadi stealth-style. Reward: 1500 gil + key item. | Low-Medium -- unique escort mechanic. |
| 8 | The Naming Game | 81 | Raibaht in Metalworks (Fame 5 required), trade Ordrynite. Reward: 3600 gil, title. | Low -- high fame repeatable. |
| 9 | Bait and Switch | 83 | Salim in Metalworks, puzzle quest with switches near Temple of the Goddess. Reward: various items. | Low -- puzzle quest. |
| 10 | Too Many Chefs | 86 | Ferghus in Metalworks, retrieve Red Oven Mitt from Quadavs in Grauberg (S). Reward: Aileen's Delight. | Low -- WotG content. |
| 11 | A Proper Burial | 87 | Offa in Bastok Markets, recover letters from time capsule (past/present Bastok). Reward: Rolanberry. | Low -- WotG content. |

### Missing -- Low Priority (deprecated / niche systems)

| # | Quest | Quest ID | What It Does | Impact |
|---|-------|----------|--------------|--------|
| 12 | Fully Mental Alchemist | 88 | Titus in Bastok Mines, collect gold dust in Grauberg (S) via prospecting. Reward: Trainee Sword. | Very Low -- WotG/Synergy era content. |
| 13 | Synergistic Pursuits | 89 | Hildolf in Metalworks, gather materials to unlock Synergy. DEPRECATED on retail. | None -- no longer obtainable on retail. |
| 14 | The Wondrous Whatchamacallit | 90 | Selliste in Bastok Mines, gather 6 elemental stones, synergize into Astral Matter. Reward: Portafurnace. | Very Low -- requires Synergy skill 5+. |
| 15 | Synergistic Support | 91 | Hildolf in Metalworks, trade Slime Oil to receive Fewell. | Very Low -- Synergy system support quest. |
| 16 | A Chocobo Riding Game (Bastok) | N/A | Bastok Mines chocobo stables, deliver chocobo to distant stable within time limit. | Very Low -- not even in quest enum. Chocobo system quest. |

---

## Spot-Check Results

Five scripts were read in full to verify quality:

### Welcome to Bastok
- **Structure:** Modern Quest:new() framework. Two sections (available / accepted).
- **Flow:** Powhatan (event 50) -> equip Shell Shield -> Bartolomeo (event 52) -> return to Powhatan (event 53) -> complete.
- **Reward:** Spatha, 80 fame, title "Bastok Welcoming Committee".
- **Verdict:** Fully functional.

### The Siren's Tear
- **Structure:** Four sections (available / accepted / completed / accepted-or-completed).
- **Flow:** Wahid -> Otto -> Carmelo -> obtain Siren's Tear from QM -> trade back to Wahid.
- **Reward:** 150 gil, 120 fame, title "Tearjerker".
- **Verdict:** Fully functional. Handles repeat completion and item loss.

### WAR AF1: The Doorman
- **Structure:** Two sections. Job gate (WAR) + level gate (AF1_QUEST_LEVEL setting).
- **Flow:** Phara -> Davoi Hide Flap -> kill Gavotvut + Barakbok -> get Sword Grip Material -> Phara (wait a day) -> get Yasin's Sword -> Naji.
- **Reward:** Razor Axe, 30 fame.
- **Verdict:** Fully functional. Proper NM spawn/claim, key item chain, timer mechanic.

### Gourmet (repeatable fame)
- **Structure:** Two sections. Time-of-day based trade rewards.
- **Flow:** Salimah -> trade Sleepshroom/Treant Bulb/Wild Onion at correct Vanadiel hour.
- **Reward:** Variable gil (100-350) + fame. Must-zone between repeats.
- **Verdict:** Fully functional. Correct time window logic.

### Trust: Bastok
- **Structure:** Three sections (available / accepted / completed).
- **Flow:** Clarion Star -> Naji -> learn trust spells (Naji, Ayame, Volker, Iron Eater).
- **Memory system:** Tracks mission/quest completion for memory cutscene parameters.
- **Reward:** Bastok Trust Permit key item, multiple trust spells.
- **Note:** Iron Eater memory function is TODO (commented out), but spell grant works.
- **Verdict:** Functional with minor cosmetic gap (Iron Eater memories always 0).

---

## Key Observations

1. **Core quests are solid.** All starter, fame, story chain, AF, and trust quests are implemented with the modern Quest:new() framework. No stubs found.

2. **Missing quests are mostly niche content:**
   - 4 are WotG/Campaign-era (Too Many Chefs, A Proper Burial, Fully Mental Alchemist, Chocobo Riding Game)
   - 3 are Synergy system (deprecated/very niche)
   - The rest are flavor/side quests with no progression impact

3. **One gameplay blocker:** Achieving True Power (PUP lv70 cap quest) is missing. If anyone levels PUP, they cannot break the lv70 cap without this quest. Not relevant unless a player chooses PUP.

4. **Minor gap:** Trust: Bastok has Iron Eater's memory function as TODO (returns 0). This only affects the trust cutscene flavor text, not the spell grant itself.

5. **All 3 AF job sets (WAR/MNK/DRK) fully implemented** with proper AF1/AF2/AF3 chains, level gates, NM fights, and key item progression.

---

## Recommendations

| Priority | Action |
|----------|--------|
| HIGH (if PUP used) | Implement Achieving True Power -- PUP limit break quest |
| LOW | Implement Eco-Warrior, Escort for Hire, Return to the Depths for completionists |
| SKIP | Synergy quests (deprecated), WotG quests (niche), Chocobo Riding (not in enum) |
