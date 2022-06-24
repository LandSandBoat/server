-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- --------------------------------------------------------
-- Ref: https://ffxiclopedia.fandom.com/wiki/Category:Merit_Points?oldid=1088116
-- --------------------------------------------------------


REPLACE INTO `merits` (`meritid`, `name`, `upgrade`, `value`, `jobs`, `upgradeid`, `catagoryid`) VALUES
    -- General Merit Point Categories
    (64, 'max_hp', 8, 10, 1048575, 0, 0),
    (66, 'max_mp', 8, 10, 1048575, 0, 0),
    (68, 'max_merits', 0, 0, 1048575, 9, 0), -- Not available in era
    
    -- Attributes (Max combo 5, per item 5)
    (128, 'str', 5, 1, 1048575, 1, 1),
    (130, 'dex', 5, 1, 1048575, 1, 1),
    (132, 'vit', 5, 1, 1048575, 1, 1),
    (134, 'agi', 5, 1, 1048575, 1, 1),
    (136, 'int', 5, 1, 1048575, 1, 1),
    (138, 'mnd', 5, 1, 1048575, 1, 1),
    (140, 'chr', 5, 1, 1048575, 1, 1),

    -- Combat Skills: Defensive (Max combo 20, per item 4)
    (222, 'guarding_skill', 4, 2, 131074, 3, 2),
    (224, 'evasion_skill', 4, 2, 1048575, 3, 2),
    (226, 'shield_skill', 4, 2, 373, 3, 2),
    (228, 'parrying_skill', 4, 2, 1031155, 3, 2),

    -- Other Skills (Max combo 8, per item 4)
    (320, 'enmity_increase', 4, 1, 1048575, 5, 4),
    (322, 'enmity_decrease', 4, 1, 1048575, 5, 4),
    (324, 'crit_hit_rate', 4, 1, 1048575, 5, 4),
    (326, 'enemy_crit_rate', 4, 1, 1048575, 5, 4),
    (328, 'spell_interuption_rate', 4, 2, 1048575, 5, 4),

    -- -------------------
    -- JOB SPECIFIC MERITS
    -- -------------------

    -- WAR Group 2
    (2048, 'warriors_charge', 5, 150, 1, 7, 31),
    (2052, 'savagery', 5, 100, 1, 7, 31),        -- Originally '10' - maybe handled by code?

    -- WHM Group 2
    (2176, 'martyr', 5, 150, 4, 7, 33),
    (2178, 'devotion', 5, 150, 4, 7, 33),
    (2180, 'protectra_v', 5, 2, 4, 7, 33),
    (2182, 'shellra_v', 5, 1, 4, 7, 33),
    (2184, 'animus_solace', 5, 0, 4, 7, 33),    -- Out of era - Zeroing for now
    (2186, 'animus_misery', 5, 0, 4, 7, 33),    -- Out of era - Zeroing for now

    -- BLM Group 2
    (2252, 'anc_magic_attack_bonus', 5, 5, 8, 7, 34),
    (2254, 'anc_magic_burst_dmg', 5, 3, 8, 7, 34),
    (2256, 'ele_magic_acc', 5, 5, 8, 7, 34),
    (2258, 'ele_magic_debuff_duration', 5, 12, 8, 7, 34),
    (2260, 'ele_magic_debuff_effect', 5, 2, 8, 7, 34),
    (2262, 'aspir_absorption_amount', 5, 0, 8, 7, 34),      -- ???

    -- RDM Group 1: +3 MAcc in era (+2 retail) per merit
    (642, 'fire_magic_accuracy', 5, 3, 16, 6, 9),
    (644, 'ice_magic_accuracy', 5, 3, 16, 6, 9),
    (646, 'wind_magic_accuracy', 5, 3, 16, 6, 9),
    (648, 'earth_magic_accuracy', 5, 3, 16, 6, 9),
    (650, 'lightning_magic_accuracy', 5, 3, 16, 6, 9),
    (652, 'water_magic_accuracy', 5, 3, 16, 6, 9),
    -- RDM Group 2
    (2304, 'dia_iii', 5, 30, 16, 7, 35),
    (2306, 'slow_ii', 5, 1, 16, 7, 35),
    (2308, 'paralyze_ii', 5, 1, 16, 7, 35),
    (2310, 'phalanx_ii', 5, 3, 16, 7, 35),
    (2312, 'bio_iii', 5, 30, 16, 7, 35),
    (2314, 'blind_ii', 5, 1, 16, 7, 35),

    -- THF Group 2
    (2368, 'assassins_charge', 5, 150, 32, 7, 36),
    (2370, 'feint', 5, 120, 32, 7, 36),

    -- PLD Group 1: Bash/Circle Recast Times set to era values
    (768, 'shield_bash_recast', 5, 10, 64, 6, 11),
    (770, 'holy_circle_recast', 5, 20, 64, 6, 11),
    -- PLD Group 2
    (2432, 'fealty', 5, 150, 64, 7, 37),
    (2434, 'chivalry', 5, 150, 64, 7, 37),

    -- DRK Group 1: Bash/Circle Recast Times set to era values
    (834, 'arcane_circle_recast', 5, 20, 128, 6, 12),
    (840, 'weapon_bash_recast', 5, 10, 128, 6, 12),
    -- DRK Group 2
    (2496, 'dark_seal', 5, 150, 128, 7, 38),
    (2498, 'diabolic_eye', 5, 150, 128, 7, 38),
    (2502, 'desperate_blows_effect', 5, 5, 128, 7, 38), -- Showing as '500' originally, for -5% (Code?)

    -- BST Group 1: Sic Recast times set to era values
    (902, 'sic_recast', 5, 4, 256, 6, 13),
    -- BST Group 2
    (2560, 'feral_howl', 5, 150, 256, 7, 39),
    (2562, 'killer_instinct', 5, 150, 256, 7, 39),

    -- BRD Group 1: Minne effect +1 per upgrade in era
    (964, 'minne_effect', 5, 1, 512, 6, 14),
    -- BRD Group 2
    (2624, 'nightingale', 5, 150, 512, 7, 40),
    (2626, 'troubadour', 5, 150, 512, 7, 40),
    (2630, 'adventurers_dirge', 5, 3, 512, 7, 40),
    (2632, 'con_anima', 5, 0, 512, 7, 40),      -- Out of Era.  Zeroized for now.
    (2634, 'con_brio', 5, 0, 512, 7, 40),       -- Out of Era.  Zeroized for now.

    -- RNG Group 1: Scavenge recast updated for era values
    (1024, 'scavenge_effect', 5, 10, 1024, 6, 15),
    -- RNG Group 2
    (2690, 'flashy_shot', 5, 150, 1024, 7, 41),

    -- SAM Group 1: Warding Circle recast timer updated for era values
    (1090, 'warding_circle_recast', 5, 20, 2048, 6, 16),
    -- SAM Group 2
    (2752, 'shikikoyo', 5, 150, 2048, 7, 42),
    (2754, 'blade_bash', 5, 150, 2048, 7, 42),

    -- NIN Group 2
    (2816, 'sange', 5, 150, 4096, 7, 43),
    (2832, 'yonin_effect', 5, 50, 4096, 7, 43),     -- Out of Era.  Zeroized for now 
    (2834, 'innin_effect', 5, 1, 4096, 7, 43),      -- Out of Era.  Zeroized for now 
    (2836, 'nin_magic_accuracy', 5, 5, 4096, 7, 43),
    (2838, 'nin_magic_attack', 5, 5, 4096, 7, 43),

    -- DRG Group 1: Updated multiple values for era
    (1216, 'ancient_circle_recast', 5, 20, 8192, 6, 18),
    (1218, 'jump_recast', 5, 3, 8192, 6, 18),
    (1220, 'high_jump_recast', 5, 6, 8192, 6, 18),
    (1224, 'spirit_link_recast', 5, 6, 8192, 6, 18),
    -- DRG Group 2
    (2880, 'deep_breathing', 5, 150, 8192, 7, 44),
    (2886, 'strafe_effect', 5, 5, 8192, 7, 44),

    -- SMN Group 1: Elemental MP Perpetuation Cost
    (1288, 'summoning_magic_cast_time', 5, 1, 16384, 6, 19), -- Elemental MP Cost, in era
    -- SMN Group 2
    (2944, 'meteor_strike', 5, 400, 16384, 7, 45),
    (2946, 'heavenly_strike', 5, 400, 16384, 7, 45),
    (2948, 'wind_blade', 5, 400, 16384, 7, 45),
    (2950, 'geocrush', 5, 400, 16384, 7, 45),
    (2952, 'thunderstorm', 5, 400, 16384, 7, 45),
    (2954, 'grandfall', 5, 400, 16384, 7, 45),

    -- BLU Group 1: Updated correlation for era
    (1348, 'monster_correlation', 5, 1, 32768, 6, 20),
    -- BLU Group 2
    (3010, 'diffusion', 5, 150, 32768, 7, 46),

    -- PUP Group 1: Completely different merit required for era, may not be possible
    (1472, 'automaton_skills', 5, 2, 131072, 6, 22),    -- Re-using as 'automaton melee skill'
    (1474, 'maintenance_recast', 5, 2, 131072, 6, 22),  -- Re-using as 'Automaton Ranged Skill'
    (1476, 'repair_effect', 5, 2, 131072, 6, 22),       -- Re-using as 'Automaton Magic Skill'
    -- PUP Group 2
    (3136, 'role_reversal', 5, 30, 131072, 7, 48),
    (3138, 'ventriloquy', 5, 15, 131072, 7, 48),

    -- COR Group 2
    (3072, 'snake_eye', 5, 150, 65536, 7, 47),
    (3074, 'fold', 5, 150, 65536, 7, 47),

    -- DNC Group 2
    (3200, 'saber_dance', 5, 30, 262144, 7, 49),
    (3202, 'fan_dance', 5, 30, 262144, 7, 49),

    -- SCH Group 1
    (1602, 'modus_veritas_duration', 5, 10, 524288, 6, 24), -- Originally 1 ... multiplied in code?
    (1604, 'helix_magic_acc_att', 5, 1, 524288, 6, 24),  -- 3 MAcc / 2 MAtt : Show as 1?
    -- SCH Group 2
    (3270, 'equanimity', 5, 10, 524288, 7, 50),
    (3272, 'enlightenment', 5, 75, 524288, 7, 50),
    (3274, 'stormsurge', 5, 3, 524288, 7, 50),
    
    -- Zeroed out "max upgrades" value to ensure they cannot be used in era
    (1664, 'shijin_spiral', 0, 3, 131074, 0, 25),
    (1666, 'exenterator', 0, 3, 333617, 0, 25),
    (1668, 'requiescat', 0, 3, 113361, 0, 25),
    (1670, 'resolution', 0, 3, 193, 0, 25),
    (1672, 'ruinator', 0, 3, 1409, 0, 25),
    (1674, 'upheaval', 0, 3, 129, 0, 25),
    (1676, 'entropy', 0, 3, 385, 0, 25),
    (1678, 'stardiver', 0, 3, 10241, 0, 25),
    (1680, 'blade_shun', 0, 3, 4096, 0, 25),
    (1682, 'tachi_shoha', 0, 3, 2048, 0, 25),
    (1684, 'realmrazor', 0, 3, 573519, 0, 25),
    (1686, 'shattersoul', 0, 3, 549455, 0, 25),
    (1688, 'apex_arrow', 0, 3, 3072, 0, 25),
    (1690, 'last_stand', 0, 3, 66592, 0, 25);
