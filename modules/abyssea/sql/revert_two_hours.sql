-- --------------------------------------------------------
-- Revert Two-Hour Ability Recast Change
-- --------------------------------------------------------
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(12/12/2012)
-- --------------------------------------------------------

UPDATE `abilities`
SET `recastTime` = 7200
WHERE `name` IN (
    'mighty_strikes',
    'hundred_fists',
    'benediction',
    'manafont',
    'chainspell',
    'perfect_dodge',
    'invincible',
    'blood_weapon',
    'familiar',
    'soul_voice',
    'eagle_eye_shot',
    'meikyo_shisui',
    'mijin_gakure',
    'spirit_surge',
    'astral_flow',
    'azure_lore',
    'wild_card',
    'overdrive',
    'trance',
    'tabula_rasa'
);
