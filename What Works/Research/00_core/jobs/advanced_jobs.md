# Advanced Unlock Jobs (Base Game + Zilart Era)

## Source
- bg-wiki: See per-job entries below
- Codebase: `scripts/quests/`, `scripts/actions/abilities/`, `scripts/actions/spells/`, `scripts/globals/pets/`, `scripts/battlefields/`

## Summary
All 9 advanced job unlock quests have scripted implementations. PLD, DRK, BST, BRD, RNG, DRG, and SMN quests are base-game accessible. SAM and NIN require Zilart access (Norg). All SP1 abilities exist; all SP2 abilities exist except PLD (Guardian is missing). Pet systems for BST, DRG, and SMN are fully scripted.

---

## PLD -- Paladin

### Unlock Quest
- **Quest:** A Knight's Test
- **bg-wiki:** https://www.bg-wiki.com/ffxi/A_Knight%27s_Test
- **Script:** `scripts/quests/sandoria/A_Knights_Test.lua`
- **Start NPC:** Balasiel, Southern San d'Oria
- **Prereqs:** A Squire's Test II completed, Lv30+
- **Zones:** Southern San d'Oria, Davoi (Disused Well at E-10)
- **Prereq scripts exist:** `A_Squires_Test.lua`, `A_Squires_Test_II.lua` in `scripts/quests/sandoria/`

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | WORKS | Full quest framework implementation |
| NPC accessible | WORKS | Southern San d'Oria and Davoi are base-game zones |
| Prereq quests | WORKS | Both Squire's Test quests scripted |
| SP1 (Invincible) | WORKS | `scripts/actions/abilities/invincible.lua` |
| SP2 (Guardian) | MISSING | No ability script found |
| Job abilities (12) | WORKS | shield_bash, holy_circle, sentinel, rampart, cover, divine_emblem, majesty, palisade, chivalry, intervene, fealty, invincible |

---

## DRK -- Dark Knight

### Unlock Quest
- **Quest:** Blade of Darkness
- **bg-wiki:** https://www.bg-wiki.com/ffxi/Blade_of_Darkness
- **Script:** `scripts/quests/bastok/Blade_of_Darkness.lua`
- **Start NPC:** Gumbah, Bastok Mines (J-7)
- **Prereqs:** Lv30+
- **Zones:** Bastok Mines, Palborough Mines (boat dock H-8), Beadeaux
- **Note:** Script has a TODO comment: "This quest needs verification!"

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | PARTIAL | Script exists but marked "needs verification" |
| NPC accessible | WORKS | All zones are base-game |
| SP1 (Blood Weapon) | WORKS | `scripts/actions/abilities/blood_weapon.lua` |
| SP2 (Soul Enslavement) | WORKS | `scripts/actions/abilities/soul_enslavement.lua` |
| Job abilities (10) | WORKS | arcane_circle, arcane_crest, blood_weapon, consume_mana, dark_seal, diabolic_eye, last_resort, nether_void, souleater, weapon_bash |
| Absorb spells (10) | WORKS | 10 absorb spell scripts in `scripts/actions/spells/black/` |

---

## BST -- Beastmaster

### Unlock Quest
- **Quest:** Path of the Beastmaster
- **bg-wiki:** https://www.bg-wiki.com/ffxi/Path_of_the_Beastmaster
- **Script:** `scripts/quests/jeuno/Path_of_the_Beastmaster.lua`
- **Start NPC:** Brutus, Upper Jeuno (G-7)
- **Prereqs:** Chocobo's Wounds + Save My Son completed, Lv30+
- **Zones:** Upper Jeuno only

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | WORKS | Full quest framework implementation |
| NPC accessible | WORKS | Upper Jeuno is base-game |
| Prereq quests | WORKS | `Chocobos_Wounds.lua` and `Save_My_Son.lua` both exist in `scripts/quests/jeuno/` |
| SP1 (Familiar) | WORKS | `scripts/actions/abilities/familiar.lua` |
| SP2 (Unleash) | WORKS | `scripts/actions/abilities/unleash.lua` |
| Job abilities (10) | WORKS | charm, call_beast, reward, snarl, sic, bestial_loyalty, familiar, feral_howl, killer_instinct, run_wild |
| Pet system | WORKS | 207 pet ability scripts in `scripts/actions/abilities/pets/` (shared with SMN/DRG/PUP); jug pet globals in `scripts/globals/pets/` |

---

## BRD -- Bard

### Unlock Quest
- **Quest chain:** The Old Monument -> A Minstrel in Despair -> Path of the Bard
- **bg-wiki:** https://www.bg-wiki.com/ffxi/The_Old_Monument
- **Scripts:**
  - `scripts/quests/jeuno/The_Old_Monument.lua`
  - `scripts/quests/jeuno/A_Minstrel_In_Despair.lua`
  - `scripts/quests/jeuno/Path_of_the_Bard.lua` (this one calls `unlockJob`)
- **Start NPC:** Mertaire, Lower Jeuno (I-8)
- **Prereqs:** Lv30+, Parchment item
- **Zones:** Lower Jeuno, Buburimu Peninsula (Song Runes G-9), Valkurm Dunes (Song Runes for final quest)

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest chain (3 quests) | WORKS | All three quest scripts exist |
| NPC accessible | WORKS | All zones are base-game |
| SP1 (Soul Voice) | WORKS | `scripts/actions/abilities/soul_voice.lua` |
| SP2 (Clarion Call) | WORKS | `scripts/actions/abilities/clarion_call.lua` |
| Job abilities (7) | WORKS | soul_voice, nightingale, troubadour, pianissimo, tenuto, clarion_call, marcato |
| Songs (105) | WORKS | 105 song scripts in `scripts/actions/spells/songs/` -- full set including carols, etudes, minne, minuet, marches, threnodies, lullabies, requiems, ballads, madrigals, mazurkas, elegy, finale, paeon, mambo, operetta, prelude |

---

## RNG -- Ranger

### Unlock Quest
- **Quest:** The Fanged One
- **bg-wiki:** https://www.bg-wiki.com/ffxi/The_Fanged_One
- **Script:** `scripts/quests/windurst/The_Fanged_One.lua`
- **Start NPC:** Perih Vashai, Windurst Woods (K-7)
- **Prereqs:** Lv30+
- **Zones:** Windurst Woods, Sauromugue Champaign (Tiger Bones at L-10)
- **Mechanic:** Spawn Old Sabertooth, let it die naturally (~3 min), examine bones for key item

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | WORKS | Full quest framework implementation |
| NPC accessible | WORKS | Both zones are base-game |
| SP1 (Eagle Eye Shot) | WORKS | `scripts/actions/abilities/eagle_eye_shot.lua` |
| SP2 (Overkill) | WORKS | `scripts/actions/abilities/overkill.lua` |
| Job abilities (10) | WORKS | sharpshot, camouflage, barrage, shadowbind, velocity_shot, unlimited_shot, bounty_shot, decoy_shot, eagle_eye_shot, overkill |

---

## SAM -- Samurai

### Unlock Quest
- **Quest:** Forge Your Destiny
- **bg-wiki:** https://www.bg-wiki.com/ffxi/Forge_Your_Destiny
- **Script:** `scripts/quests/outlands/Forge_Your_Destiny.lua`
- **Start NPC:** Jaucribaix, Norg (K-8)
- **Prereqs:** Lv30+, Zilart access (Norg)
- **Zones:** Norg, Konschtat Highlands (spawn Forger bomb NM), The Sanctuary of Zi'Tah (spawn Guardian Treant NM)
- **Reward:** Mumeito + SAM job unlock

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | WORKS | Full quest framework implementation |
| NPC accessible | WORKS | Norg exists in zone_settings (zone 252); requires Zilart access via Sea Serpent Grotto |
| SP1 (Meikyo Shisui) | WORKS | `scripts/actions/abilities/meikyo_shisui.lua` |
| SP2 (Yaegasumi) | WORKS | `scripts/actions/abilities/yaegasumi.lua` |
| Job abilities (12) | WORKS | third_eye, warding_circle, meditate, seigan, hasso, sekkanoki, konzen-ittai, hamanoha, hagakure, blade_bash, meikyo_shisui, yaegasumi |

### Blockers
- Requires Zilart expansion access to reach Norg (through Sea Serpent Grotto or airship to Kazham)

---

## NIN -- Ninja

### Unlock Quest
- **Quest:** Ayame and Kaede
- **bg-wiki:** https://www.bg-wiki.com/ffxi/Ayame_and_Kaede
- **Script:** `scripts/quests/bastok/Ayame_and_Kaede.lua`
- **Start NPC:** Kaede, Port Bastok (J-5)
- **Prereqs:** Lv30+
- **Zones:** Port Bastok, Korroloka Tunnel (defeat 3 Korroloka Leeches), Norg (Ryoma for Sealed Dagger)
- **Note:** Quest starts in Bastok but requires Norg access mid-quest

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | WORKS | Full quest framework implementation |
| NPC accessible | WORKS | Port Bastok is base-game; Norg requires Zilart |
| SP1 (Mijin Gakure) | WORKS | `scripts/actions/abilities/mijin_gakure.lua` |
| SP2 (Mikage) | WORKS | `scripts/actions/abilities/mikage.lua` |
| Job abilities (7) | WORKS | yonin, innin, issekigan, futae, sange, mijin_gakure, mikage |
| Ninjutsu (43) | WORKS | 43 ninjutsu scripts in `scripts/actions/spells/ninjutsu/` -- full set including Utsusemi (Ichi/Ni/San), elemental wheels (Katon/Hyoton/Huton/Doton/Suiton/Raiton Ichi-San), enfeebles (Kurayami/Hojo/Jubaku/Dokumori Ichi-San), Tonko, Monomi, Migawari, Kakka, Myoshu, Yurin, Gekka, Yain, Aisha |

### Blockers
- Mid-quest step requires Norg access (Zilart expansion)

---

## DRG -- Dragoon

### Unlock Quest
- **Quest:** The Holy Crest
- **bg-wiki:** https://www.bg-wiki.com/ffxi/The_Holy_Crest
- **Scripts:** No standalone quest file -- implemented via NPC scripts + battlefield:
  - `scripts/zones/Northern_San_dOria/npcs/Morjean.lua`
  - `scripts/zones/Port_San_dOria/npcs/Ceraulian.lua`
  - `scripts/zones/Port_San_dOria/npcs/Arminibit.lua`
  - `scripts/zones/Southern_San_dOria/npcs/Moozo-Koozo.lua`
  - `scripts/battlefields/Ghelsba_Outpost/holy_crest.lua`
- **Start NPC:** Ceraulian, Port San d'Oria (I-9)
- **Prereqs:** Lv30+
- **Zones:** Port San d'Oria, Bostaunieux Oubliette, Northern San d'Oria, Maze of Shakhrami (excavation for Wyvern Egg), Meriphataud Mountains, Ghelsba Outpost (battlefield)
- **Key items:** Pickaxe, Wyvern Egg, Dragon Curse Remedy
- **Battlefield:** 6-player, 30-min limit, no trusts

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest | WORKS | Implemented across NPC scripts + battlefield (older style, not Quest:new framework) |
| NPC accessible | WORKS | All zones are base-game |
| Battlefield | WORKS | `scripts/battlefields/Ghelsba_Outpost/holy_crest.lua` with full win/loss logic |
| SP1 (Spirit Surge) | WORKS | `scripts/actions/abilities/spirit_surge.lua` |
| SP2 (Fly High) | WORKS | `scripts/actions/abilities/fly_high.lua` |
| Job abilities (14) | WORKS | ancient_circle, jump, high_jump, super_jump, spirit_link, call_wyvern, deep_breathing, angon, dragon_breaker, fly_high, spirit_bond, soul_jump, spirit_jump, steady_wing |
| Wyvern pet | WORKS | `scripts/globals/pets/wyvern.lua` + pet abilities: healing_breath (I-IV), flame_breath, frost_breath, super_climb, smiting_breath, restoring_breath |

---

## SMN -- Summoner

### Unlock Quest
- **Quest:** I Can Hear a Rainbow
- **bg-wiki:** https://www.bg-wiki.com/ffxi/I_Can_Hear_a_Rainbow
- **Script:** `scripts/quests/windurst/SMN_I_Can_Hear_a_Rainbow.lua`
- **Start NPC:** House of the Hero, Windurst Walls (G-3)
- **Prereqs:** Lv30+, Carbuncle's Ruby (drop from Leeches)
- **Zones:** Windurst Walls, various outdoor base-game zones (experience 7 weather types), La Theine Plateau (trade ruby at G-6)
- **Mechanic:** Must zone into areas during 7 different weather types, then trade ruby

| Item | Status | Notes |
|------|--------|-------|
| Unlock quest script | WORKS | Full quest framework implementation with weather tracking |
| NPC accessible | WORKS | All zones are base-game |
| SP1 (Astral Flow) | WORKS | `scripts/actions/abilities/astral_flow.lua` |
| SP2 (Astral Conduit) | WORKS | `scripts/actions/abilities/astral_conduit.lua` |
| Job abilities (9) | WORKS | assault, retreat, release, avatars_favor, elemental_siphon, mana_cede, apogee, astral_flow, astral_conduit |
| Summoning spells (21) | WORKS | All in `scripts/actions/spells/summoning/` |

### Avatar Checklist
| Avatar | Spell Script | Notes |
|--------|-------------|-------|
| Carbuncle | WORKS | Unlocked by quest |
| Ifrit | WORKS | Requires trial quest |
| Shiva | WORKS | Requires trial quest |
| Garuda | WORKS | Requires trial quest |
| Titan | WORKS | Requires trial quest |
| Ramuh | WORKS | Requires trial quest |
| Leviathan | WORKS | Requires trial quest |
| Fenrir | WORKS | Requires Full Moon Fountain quest |
| Diabolos | WORKS | Requires CoP mission |
| Cait Sith | WORKS | Requires WotG content |
| Siren | WORKS | Requires SoA content |
| Alexander | WORKS | Requires Aht Urhgan content |
| Odin | WORKS | Requires Aht Urhgan content |
| Spirits (8) | WORKS | fire/ice/air/earth/thunder/water/light/dark_spirit |

### Blood Pact Coverage
23 major blood pact damage/ward scripts found including: aerial_blast, diamond_dust, earthen_fury, inferno, judgment_bolt, tidal_wave, howling_moon, searing_light, zantetsuken, perfect_defense, nether_blast, eclipse_bite, burning_strike, spinning_dive, predator_claws, thunderspark, geocrush, grand_fall, meteor_strike, heavenly_strike, sonic_buffet, hysteric_assault, wind_blade. Total pet ability scripts (shared across BST/SMN/DRG/PUP): 207.

---

## Overall Summary

| Job | Unlock Quest | Accessible | SP1 | SP2 | Abilities | Special Systems |
|-----|-------------|------------|-----|-----|-----------|-----------------|
| PLD | WORKS | WORKS | WORKS | MISSING | 12 | -- |
| DRK | PARTIAL | WORKS | WORKS | WORKS | 10 | 10 absorb spells |
| BST | WORKS | WORKS | WORKS | WORKS | 10 | Pet system (207 shared scripts) |
| BRD | WORKS | WORKS | WORKS | WORKS | 7 | 105 songs |
| RNG | WORKS | WORKS | WORKS | WORKS | 10 | -- |
| SAM | WORKS | WORKS (Zilart) | WORKS | WORKS | 12 | -- |
| NIN | WORKS | WORKS (Zilart) | WORKS | WORKS | 7 | 43 ninjutsu |
| DRG | WORKS | WORKS | WORKS | WORKS | 14 | Wyvern pet (9 breath abilities) |
| SMN | WORKS | WORKS | WORKS | WORKS | 9 | 21 summons, 23+ blood pacts |

## Blockers
- **PLD SP2 (Guardian):** No ability script exists. Players cannot use this ability.
- **DRK unlock quest:** Script has a "needs verification" TODO -- may have bugs.
- **SAM/NIN:** Require Zilart expansion access to reach Norg. If Zilart missions are not progressed far enough, players cannot reach the quest NPCs.
- **BRD:** Requires completing a 3-quest chain (The Old Monument -> A Minstrel in Despair -> Path of the Bard), not just one quest.
- **BST:** Requires completing 2 prerequisite quests (Chocobo's Wounds + Save My Son) before the unlock quest becomes available.
- **PLD:** Requires completing A Squire's Test II before the unlock quest becomes available.

## Fix Difficulty
- PLD Guardian SP2: Medium (C++ ability handler likely needed)
- DRK quest verification: Easy (playtest to confirm)
- Everything else: No fixes needed
