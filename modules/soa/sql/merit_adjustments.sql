-----------------------------------
-- Seekers of Adoulin merit adjustments.
-- Reverts merits to their pre-SoA values.
-----------------------------------

-----------------------------------
-- Beastmaster
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
-----------------------------------

-- Sic merit: Revert value from 2 to 4 seconds per level
UPDATE `merits` SET `value` = 4 WHERE `name` = 'sic_recast';

-----------------------------------
-- Ranger
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
-----------------------------------

-- Scavenge merit: Revert value from increase effect per level to 10 seconds per level
UPDATE `merits` SET `value` = 10 WHERE `name` = 'scavenge';

-----------------------------------
-- Ninja
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
-----------------------------------

-- Sange merit: Revert value from 25 ranged accuracy to 150 seconds recast reduction
UPDATE `merits` SET `value` = 150 WHERE `name` = 'sange';

-----------------------------------
-- Dragoon
-- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-%28JST%29-Version-Update
-----------------------------------

-- Strafe merit: Revert value from 10 to 5 per upgrade
UPDATE `merits` SET `value` = 5 WHERE `name` = 'strafe_effect';
