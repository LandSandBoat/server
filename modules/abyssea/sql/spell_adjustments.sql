------------------------------------
-- Abyssea Spell SQL Adjustments
-- This module reverts relevant spells to their pre-Abyssea values
------------------------------------

------------------------------------
-- Healing Magic
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Esuna: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'esuna';

-- Sacrifice: Revert cast time from 1 to 1.5 seconds
UPDATE spell_list SET castTime = 1500 WHERE name = 'sacrifice';

-- Blindna: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'blindna';

-- Cursna: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'cursna';

------------------------------------
-- Enhancing Magic
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(12/14/2011)
------------------------------------

-- Regen: Revert cast time from 1.5 to 4 seconds
UPDATE spell_list SET castTime = 4000 WHERE name = 'regen';

-- Regen II: Revert cast time from 1.75 to 4.5 seconds
UPDATE spell_list SET castTime = 4500 WHERE name = 'regen_ii';

-- Regen III: Revert cast time from 2 to 5 seconds
UPDATE spell_list SET castTime = 5000 WHERE name = 'regen_iii';

------------------------------------
-- Singing
-- Source: https://forum.square-enix.com/ffxi/threads/29150-December-13-2012-%28JST%29-Version-Update
-- Source: https://forum.square-enix.com/ffxi/threads/27883-dev1138-Bard-Job-Adjustments
------------------------------------

-- Etudes / Prelude / Sirvente / Dirge: Revert from AoE to single target and cast time to 4 seconds
UPDATE spell_list SET validTargets = 3, AOE = 0, castTime = 4000 WHERE name IN (
    'foe_sirvente',
    'adventurers_dirge',
    'hunters_prelude',
    'archers_prelude',
    'sinewy_etude',
    'dextrous_etude',
    'vivacious_etude',
    'quick_etude',
    'learned_etude',
    'spirited_etude',
    'enchanting_etude',
    'herculean_etude',
    'uncanny_etude',
    'vital_etude',
    'swift_etude',
    'sage_etude',
    'logical_etude',
    'bewitching_etude'
);

------------------------------------
-- Ninjutsu
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Tonko: Ichi: Revert cast time from 1.5 to 4 seconds
UPDATE spell_list SET castTime = 4000 WHERE name = 'tonko_ichi';

-- Monomi: Ichi: Revert cast time from 1.5 to 4 seconds
UPDATE spell_list SET castTime = 4000 WHERE name = 'monomi_ichi';
