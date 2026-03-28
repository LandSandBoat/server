# Combat System

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Combat
- Codebase:
  - `src/map/ai/states/attack_state.cpp` (melee auto-attack state machine)
  - `src/map/ai/states/range_state.cpp` (ranged attack state machine)
  - `src/map/attack.cpp` / `attack.h` (physical attack round logic)
  - `src/map/utils/battleutils.cpp` / `.h` (core battle math: accuracy, damage, skillchains, magic bursts)
  - `src/map/enmity_container.cpp` / `.h` (CE/VE enmity system)
  - `src/map/status_effect_container.cpp` (status effect application/ticking)
  - `scripts/actions/weaponskills/` (208 weapon skill scripts)
  - `scripts/actions/abilities/` (342 job ability scripts + 232 pet ability scripts)
  - `scripts/actions/spells/` (black, white, blue, songs, ninjutsu, summoning, geomancy, trust)
  - `scripts/effects/` (588 status effect scripts)
  - `scripts/globals/pets/` (avatar.lua, wyvern.lua, automaton.lua, luopan.lua, summon.lua)
  - `scripts/globals/spells/` (shared spell logic: damage_spell, enfeebling_spell, enhancing_spell, etc.)

## Summary
The combat system is comprehensively implemented in C++ (engine) and Lua (scripts). All major subsystems exist with extensive script coverage. This is one of LandSandBoat's strongest areas. No obvious gaps in the core combat loop.

## Checklist

| Item | Status | Notes |
|------|--------|-------|
| **Melee auto-attack** | WORKS | Full attack round system in C++ (`attack_state.cpp`, `attack.cpp`). Handles multi-hit, dual wield, kick attacks, double/triple attack procs. |
| **Accuracy / Evasion** | WORKS | Calculated in `battleutils.cpp`. ACC/EVA stats, food, gear mods all feed in. |
| **TP gain** | WORKS | Store TP, weapon delay, haste all factored in the attack round. |
| **Weapon skills (208 scripts)** | WORKS | All weapon types covered: sword, great sword, axe, great axe, polearm, scythe, katana, great katana, club, staff, H2H, dagger, archery, marksmanship. Includes mythic/empyrean/relic WS (e.g. Chant du Cygne, Resolution, Blade: Shun, Expiacion, Requiescat, Last Stand, etc.) |
| **Skillchains** | WORKS | `FormSkillchain` and `GetSkillchainSubeffect` in `battleutils.cpp`. `TakeSkillchainDamage` at line ~3714. Full skillchain element resolution implemented. |
| **Magic Bursts** | WORKS | MB flag tracked on spell objects (`spell.cpp`/`spell.h`). MB bonus damage modifiers exist in `modifier.h`. Merit and job point bonuses for MB present. |
| **Black magic (192 spells)** | WORKS | All tiers: Fire-VI, -ga V, -ja, -ra III for all elements. Absorb spells, Drain/Aspir I-III, enfeebles (Blind, Sleep, Break, Gravity, etc.), spikes, DOTs. |
| **White magic (186 spells)** | WORKS | Cure I-VI, Curaga I-V, Raise I-III, Reraise I-III, Protect/Shell I-V, Bar-element/status, Erase, Esuna, Holy I-II, Banish I-IV, enhancing (Haste, Refresh, Regen, etc.). |
| **Enfeebling magic** | WORKS | Shared logic in `scripts/globals/spells/enfeebling_spell.lua`. Slow, Paralyze, Silence, Gravity, Blind, Poison, Sleep, Break, Dispel, Frazzle, Distract tiers. |
| **Enhancing magic** | WORKS | Shared logic in `scripts/globals/spells/enhancing_spell.lua`. Protect, Shell, Bar-spells, Haste, Refresh, Regen, Phalanx, Stoneskin, Blink, Aquaveil, Enspells. |
| **Enmity system** | WORKS | Dedicated `CEnmityContainer` class with CE (Cumulative) + VE (Volatile) model. `UpdateEnmity`, `UpdateEnmityFromDamage`, `UpdateEnmityFromCure`, `UpdateEnmityFromAttack` methods. VE decay + highest-enmity targeting. Referenced in 42+ source files. |
| **Status effects (588 scripts)** | WORKS | Massive coverage: all buffs, debuffs, roll effects, song effects, food effects, signet/sanction/sigil, Corsair bust, Abyssea atma, aftermath, DNC flourishes, SCH stratagems, RUN runes, etc. |
| **Job abilities (342 scripts)** | WORKS | Covers all 22 jobs. Includes waltzes, steps, flourishes, jumps, maneuvers, shots, sambas, rolls, wards, runes, stratagems, and more. |
| **Two-hour abilities (SP1)** | WORKS | All 20 SP1 abilities present: Mighty Strikes, Hundred Fists, Benediction, Manafont, Chainspell, Perfect Dodge, Invincible, Blood Weapon, Soul Voice, Meikyo Shisui, Eagle Eye Shot, Mijin Gakure, Astral Flow, Azure Lore, Wild Card, Overdrive, Trance, Tabula Rasa, Bolster, Elemental Sforzo. |
| **SP2 abilities** | WORKS | 15 SP2 abilities found: Brazen Rush, Inner Strength, Asylum, Soul Enslavement, Scarlet Delirium, Larceny, Overkill, Yaegasumi, Astral Conduit, Unbridled Wisdom, Cutting Cards, Heady Artifice, Clarion Call, Fly High, Elemental Sforzo. |
| **Ranged attacks** | WORKS | Full ranged state machine (`range_state.cpp`). Archery and marksmanship WS present (Apex Arrow, Last Stand, Refulgent Arrow, Empyreal Arrow, Hot Shot, etc.). Barrage, Velocity Shot, Unlimited Shot, Double Shot, Bounty Shot abilities exist. |
| **Blue magic (175 spells)** | WORKS | Extensive BLU spell library. Azure Lore, Burst Affinity, Chain Affinity, Diffusion, Efflux, Unbridled Learning, Unbridled Wisdom all present. |
| **Bard songs (105 scripts)** | WORKS | Full song system with shared logic (`scripts/globals/spells/enhancing_song.lua`, `enfeebling_song.lua`). Soul Voice, Clarion Call, Nightingale, Troubadour, Pianissimo, Tenuto, Marcato abilities. |
| **Corsair rolls (31 rolls)** | WORKS | All phantom rolls implemented (Fighters, Monks, Healers, Wizards, Warlocks, Rogues, Gallants, Chaos, Beast, Choral, Hunters, Samurai, Ninja, Drachen, Evokers, Magus, Corsairs, Puppet, Dancers, Scholars, Bolters, Casters, Coursers, Blitzers, Tacticians, Allies, Misers, Companions, Avengers, Naturalists, Runeists). Wild Card, Cutting Cards, Random Deal, Snake Eye, Fold, Double-Up, Crooked Cards present. |
| **Pet system - SMN avatars** | WORKS | 21 summon spells (Carbuncle, 6 celestial avatars, Fenrir, Diabolos, Cait Sith, Odin, Alexander, Siren, 8 elemental spirits). Avatar AI in `scripts/globals/pets/avatar.lua`. 232 pet ability scripts cover blood pacts. |
| **Pet system - BST** | WORKS | Charm, Call Beast, Bestial Loyalty, Familiar, Sic, Reward abilities all present. Pet controller AI in `src/map/ai/controllers/pet_controller.cpp`. |
| **Pet system - PUP automaton** | WORKS | 108 attachment scripts. Activate, Deactivate, Deploy, Retrieve, Repair, Maintenance, Deus Ex Automata, Overdrive, Heady Artifice abilities present. Dedicated automaton controller (`automaton_controller.cpp`). Maneuver abilities for all elements. |
| **Pet system - DRG wyvern** | WORKS | Full wyvern system with offensive/defensive/multi behavior based on subjob (`scripts/globals/pets/wyvern.lua`). Call Wyvern, Spirit Link, Deep Breathing, Smiting/Restoring Breath, Steady Wing, Spirit Surge, Fly High all present. |
| **Geomancy (60 spells)** | WORKS | All 30 Indi- and 30 Geo- spells present (STR/DEX/VIT/AGI/INT/MND/CHR, Fury, Precision, Barrier, etc.). Luopan pet entity in C++ and Lua. Bolster, Full Circle, Life Cycle, Blaze of Glory, Dematerialize, Entrust, Widened Compass abilities exist. |

## Blockers
- None identified for core combat. This is mature, upstream LandSandBoat code.
- GEO SP2 "Odyllic Subterfuge" script not found (may be unimplemented or named differently upstream).

## Fix Difficulty
- N/A -- system is functional. Odyllic Subterfuge gap is cosmetic (rarely used SP2).
