# Base 6 Jobs (WAR, MNK, WHM, BLM, RDM, THF)

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Jobs
- Codebase:
  - `scripts/actions/abilities/` (job ability scripts)
  - `scripts/actions/weaponskills/` (weapon skill scripts)
  - `sql/traits.sql` (job traits, keyed by numeric job ID)
  - `scripts/enum/merit.lua` (merit categories per job)
  - `sql/merits.sql` (merit data)
  - `sql/job_points.sql` (job point upgrades per job)
  - `sql/job_point_gifts.sql` (job point gift rewards)
  - `settings/default/main.lua` line 120 (SUBJOB_QUEST_LEVEL = 18)
  - `scripts/zones/Selbina/npcs/Isacio.lua` (Elder Memories quest)
  - `scripts/zones/Mhaura/npcs/Vera.lua` (The Old Lady quest)

## Summary
All 6 base jobs have comprehensive framework support. Character creation makes them available from level 1. Job abilities, SP1, SP2, traits, merits (group 1 and group 2), job points, job point gifts, and weapon skills all exist. The sub-job unlock quests in both Selbina and Mhaura are fully scripted. No obvious gaps found.

## Checklist

### Character Creation & Availability

| Item | Status | Notes |
|------|--------|-------|
| WAR available at creation | WORKS | Job ID 1, standard starting job |
| MNK available at creation | WORKS | Job ID 2, standard starting job |
| WHM available at creation | WORKS | Job ID 3, standard starting job |
| BLM available at creation | WORKS | Job ID 4, standard starting job |
| RDM available at creation | WORKS | Job ID 5, standard starting job |
| THF available at creation | WORKS | Job ID 6, standard starting job |

### Sub-Job Unlock

| Item | Status | Notes |
|------|--------|-------|
| Elder Memories (Selbina) | WORKS | Isacio NPC fully scripted; 3-trade quest chain, calls `player:unlockJob(0)` and `SUBJOB_UNLOCKED` message |
| The Old Lady (Mhaura) | WORKS | Vera NPC fully scripted; 3-trade quest chain, calls `player:unlockJob(0)` and `SUBJOB_UNLOCKED` message |
| Level requirement | WORKS | `SUBJOB_QUEST_LEVEL = 18` in `settings/default/main.lua`; can be set to 0 to auto-unlock |

### WAR (Warrior) - Job ID 1

| Item | Status | Notes |
|------|--------|-------|
| SP1 (Mighty Strikes) | WORKS | `abilities/mighty_strikes.lua` exists |
| SP2 (Brazen Rush) | WORKS | `abilities/brazen_rush.lua` exists |
| Job abilities | WORKS | 12 ability scripts: mighty_strikes, berserk, defender, warcry, aggressor, provoke, warriors_charge, tomahawk, retaliation, restraint, blood_rage, brazen_rush |
| Traits | WORKS | 48 trait entries for job 1 in traits.sql |
| Merits (Group 1) | WORKS | 5 merits: Berserk Recast, Defender Recast, Warcry Recast, Aggressor Recast, Double Attack Rate |
| Merits (Group 2) | WORKS | 4 merits: Warrior's Charge, Tomahawk, Savagery, Aggressive Aim |
| Job Points | WORKS | 10 JP categories in job_points.sql (job 1) |
| Job Point Gifts | WORKS | 69 gift entries for job 1 in job_point_gifts.sql |
| Weapon Skills (Sword) | WORKS | All sword WS present: Fast Blade through Resolution, Chant du Cygne, etc. (18 files) |
| Weapon Skills (Axe) | WORKS | All axe WS present: Raging Axe through Cloudsplitter (12 files) |
| Weapon Skills (Great Axe) | WORKS | All great axe WS present: Heavy Swing through Ukko's Fury (11 files) |

### MNK (Monk) - Job ID 2

| Item | Status | Notes |
|------|--------|-------|
| SP1 (Hundred Fists) | WORKS | `abilities/hundred_fists.lua` exists |
| SP2 (Inner Strength) | WORKS | `abilities/inner_strength.lua` exists |
| Job abilities | WORKS | 13 ability scripts: hundred_fists, boost, dodge, focus, chakra, counterstance, chi_blast, footwork, perfect_counter, impetus, mantra, formless_strikes, inner_strength |
| Traits | WORKS | 38 trait entries for job 2 in traits.sql |
| Merits (Group 1) | WORKS | 5 merits: Focus Recast, Dodge Recast, Chakra Recast, Counter Rate, Kick Attack Rate |
| Merits (Group 2) | WORKS | 4 merits: Mantra, Formless Strikes, Invigorate, Penance |
| Job Points | WORKS | 10 JP categories in job_points.sql (job 2) |
| Job Point Gifts | WORKS | 69 gift entries for job 2 in job_point_gifts.sql |
| Weapon Skills (H2H) | WORKS | All H2H WS present: Combo through Victory Smite (15 files) |

### WHM (White Mage) - Job ID 3

| Item | Status | Notes |
|------|--------|-------|
| SP1 (Benediction) | WORKS | `abilities/benediction.lua` exists |
| SP2 (Asylum) | WORKS | `abilities/asylum.lua` exists |
| Job abilities | WORKS | 9 ability scripts: benediction, divine_seal, afflatus_solace, afflatus_misery, divine_caress, sacrosanctity, devotion, martyr, asylum |
| Traits | WORKS | 27 trait entries for job 3 in traits.sql |
| Merits (Group 1) | WORKS | 5 merits: Divine Seal Recast, Cure Cast Time, Bar Spell Effect, Banish Effect, Regen Effect |
| Merits (Group 2) | WORKS | 6 merits: Martyr, Devotion, Protectra V, Shellra V, Animus Solace, Animus Misery |
| Job Points | WORKS | 10 JP categories in job_points.sql (job 3) |
| Job Point Gifts | WORKS | 63 gift entries for job 3 in job_point_gifts.sql |
| Weapon Skills (Club) | WORKS | All club WS present: Shining Strike through Randgrith (12 files) |
| Weapon Skills (Staff) | WORKS | All staff WS present: Heavy Swing through Gate of Tartarus (16 files) |

### BLM (Black Mage) - Job ID 4

| Item | Status | Notes |
|------|--------|-------|
| SP1 (Manafont) | WORKS | `abilities/manafont.lua` exists |
| SP2 (Subtle Sorcery) | WORKS | `abilities/subtle_sorcery.lua` exists |
| Job abilities | WORKS | 6 ability scripts: manafont, elemental_seal, mana_wall, enmity_douse, manawell, subtle_sorcery |
| Traits | WORKS | 31 trait entries for job 4 in traits.sql |
| Merits (Group 1) | WORKS | 7 merits: Elemental Seal Recast + 6 elemental potency merits |
| Merits (Group 2) | WORKS | 12 merits: Flare II, Freeze II, Tornado II, Quake II, Burst II, Flood II, Ancient Magic ATK Bonus, Ancient Magic Burst DMG, Elemental Magic Accuracy, Elemental Debuff Duration/Effect, Aspir Absorption |
| Job Points | WORKS | 10 JP categories in job_points.sql (job 4) |
| Job Point Gifts | WORKS | 58 gift entries for job 4 in job_point_gifts.sql |
| Weapon Skills (Staff) | WORKS | All staff WS present (shared with WHM, 16 files) |
| Weapon Skills (Club) | WORKS | All club WS present (shared with WHM, 12 files) |

### RDM (Red Mage) - Job ID 5

| Item | Status | Notes |
|------|--------|-------|
| SP1 (Chainspell) | WORKS | `abilities/chainspell.lua` exists |
| SP2 (Stymie) | WORKS | `abilities/stymie.lua` exists |
| Job abilities | WORKS | 6 ability scripts: chainspell, convert, composure, saboteur, stymie, embolden |
| Traits | WORKS | 28 trait entries for job 5 in traits.sql |
| Merits (Group 1) | WORKS | 7 merits: Convert Recast + 6 elemental magic accuracy merits |
| Merits (Group 2) | WORKS | 12 merits: Dia III, Slow II, Paralyze II, Phalanx II, Bio III, Blind II, Enfeebling/Enhancing Duration, Magic Accuracy, Immunobreak, Enspell Damage, Accuracy |
| Job Points | WORKS | 10 JP categories in job_points.sql (job 5) |
| Job Point Gifts | WORKS | 62 gift entries for job 5 in job_point_gifts.sql |
| Weapon Skills (Sword) | WORKS | All sword WS present (shared with WAR, 18 files) |
| Weapon Skills (Dagger) | WORKS | All dagger WS present: Wasp Sting through Aeolian Edge (14 files) |

### THF (Thief) - Job ID 6

| Item | Status | Notes |
|------|--------|-------|
| SP1 (Perfect Dodge) | WORKS | `abilities/perfect_dodge.lua` exists |
| SP2 (Larceny) | WORKS | `abilities/larceny.lua` exists |
| Job abilities | WORKS | 13 ability scripts: perfect_dodge, sneak_attack, trick_attack, steal, flee, hide, mug, despoil, conspirator, bully, assassins_charge, feint, larceny |
| Traits | WORKS | 29 trait entries for job 6 in traits.sql |
| Merits (Group 1) | WORKS | 5 merits: Flee Recast, Hide Recast, Sneak Attack Recast, Trick Attack Recast, Triple Attack Rate |
| Merits (Group 2) | WORKS | 4 merits: Assassin's Charge, Feint, Aura Steal, Ambush |
| Job Points | WORKS | 10 JP categories in job_points.sql (job 6) |
| Job Point Gifts | WORKS | 69 gift entries for job 6 in job_point_gifts.sql |
| Weapon Skills (Dagger) | WORKS | All dagger WS present (shared with RDM, 14 files) |
| Weapon Skills (Sword) | WORKS | All sword WS present (shared with WAR/RDM, 18 files) |

## Blockers
- None identified. All base job frameworks are complete.

## Fix Difficulty
- N/A -- no fixes needed at the framework level.

## Notes
- Trait system uses numeric job IDs in `sql/traits.sql` (WAR=1, MNK=2, WHM=3, BLM=4, RDM=5, THF=6).
- Job point focus_effect (ID 67) is listed under job 1 (WAR) in job_points.sql rather than job 2 (MNK). This may be intentional (WAR also has Focus via sub-job) or a minor data issue worth verifying.
- Total weapon skill scripts in the codebase: 208 files (plus README).
- The `SUBJOB_QUEST_LEVEL` setting allows server operators to bypass the quest entirely by setting it to 0.
- This audit confirms the framework/scripts exist. Runtime behavior (ability damage formulas, trait application, JP spending UI) would require in-game testing to fully validate.
