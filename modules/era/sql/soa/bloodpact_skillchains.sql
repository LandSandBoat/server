------------------------------------
-- Seekers of Adoulin Bloodpact Skillchain Properties SQL Adjustments
-- This module reverts skillchain properties of certain bloodpacts.
-- These skills did not gain skillchain properties until the November 10th 2014 update.
-- https://wiki.ffo.jp/html/32087.html
------------------------------------

UPDATE pet_skills SET `primary_sc` = 0 WHERE `pet_skill_name` IN (
    'chaotic_strike',
    'eclipse_bite',
    'flaming_crush',
    'mountain_buster',
    'predator_claws',
    'rush',
    'spinning_dive'
);

UPDATE pet_skills SET `secondary_sc` = 0 WHERE `pet_skill_name` IN (
    'chaotic_strike',
    'eclipse_bite',
    'flaming_crush',
    'mountain_buster',
    'predator_claws',
    'rush',
    'spinning_dive'
);

UPDATE pet_skills SET `tertiary_sc` = 0 WHERE `pet_skill_name` IN (
    'chaotic_strike',
    'eclipse_bite',
    'flaming_crush',
    'mountain_buster',
    'predator_claws',
    'rush',
    'spinning_dive'
);
