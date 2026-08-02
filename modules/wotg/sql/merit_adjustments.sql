-----------------------------------
-- WotG merit adjustments.
-- Reverts merits to their pre-WotG values.
-----------------------------------

-- Reverts total maximum group 2 job merits from 6 to 3
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(06/09/2008)

-- WAR Group 2 (catagoryid 31)
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'warriors_charge';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'tomahawk';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'savagery';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'aggressive_aim';

-- MNK Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'mantra';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'formless_strikes';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'invigorate';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'penance';

-- WHM Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'martyr';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'devotion';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'protectra_v';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'shellra_v';

-- BLM Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'flare_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'freeze_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'tornado_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'quake_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'burst_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'flood_ii';

-- RDM Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'dia_iii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'slow_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'paralyze_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'phalanx_ii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'bio_iii';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'blind_ii';

-- THF Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'assassins_charge';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'feint';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'aura_steal';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'ambush';

-- PLD Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'fealty';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'chivalry';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'iron_will';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'guardian';

-- DRK Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'dark_seal';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'diabolic_eye';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'muted_soul';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'desperate_blows_effect';

-- BST Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'feral_howl';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'killer_instinct';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'beast_affinity';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'beast_healer';

-- BRD Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'nightingale';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'troubadour';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'foe_sirvente';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'adventurers_dirge';

-- RNG Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'stealth_shot';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'flashy_shot';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'snapshot';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'recycle';

-- SAM Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'shikikoyo';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'blade_bash';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'ikishoten';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'overwhelm';

-- NIN Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'sange';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'ninja_tool_expertise';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'katon_san';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'hyoton_san';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'huton_san';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'doton_san';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'raiton_san';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'suiton_san';

-- DRG Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'deep_breathing';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'angon';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'empathy';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'strafe_effect';

-- SMN Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'meteor_strike';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'heavenly_strike';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'wind_blade';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'geocrush';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'thunderstorm';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'grandfall';

-- BLU Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'convergence';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'diffusion';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'enchainment';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'assimilation';

-- COR Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'snake_eye';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'fold';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'winning_streak';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'loaded_deck';

-- PUP Group 2
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'role_reversal';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'ventriloquy';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'fine_tuning';
UPDATE `merits` SET `upgrade` = 3 WHERE `name` = 'optimization';

-----------------------------------
-- Job ability merit value reverts
-----------------------------------

-----------------------------------
-- Beastmaster
-----------------------------------

-- Reward merit: Revert value to 6 seconds per level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/11/2008)
UPDATE `merits` SET `value` = 6 WHERE `name` = 'reward';
