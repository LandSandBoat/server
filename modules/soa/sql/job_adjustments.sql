------------------------------------
-- Seekers of Adoulin Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-SoA values
------------------------------------

------------------------------------
-- Thief
-- Source : https://forum.square-enix.com/ffxi/threads/43706-Aug-12-2014-%28JST%29-Version-Update
------------------------------------

-- Mug: Revert cooldown from 5 minutes to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'mug';

------------------------------------
-- Dark Knight
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
------------------------------------

-- Desperate Blows: Revert job trait to be merit unlocked
UPDATE traits SET meritid = 2502, level = 75 WHERE name = 'desperate blows';

------------------------------------
-- Beastmaster
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
------------------------------------

-- Sic: Revert recast from 1 1/2 min to 2 min
UPDATE abilities SET recastTime = 120 WHERE name = 'sic';

-- Ready: Revert charge recast from 30 to 60 seconds
UPDATE abilities SET recastTime = 60 WHERE name = 'ready';

-- Sic merit: Revert value from 2 to 4 seconds per level
UPDATE merits SET value = 4 WHERE name = 'sic_recast';

------------------------------------
-- Ranger
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
------------------------------------

-- Scavenge: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'scavenge';

-- Scavenge merit: Revert value from increase effect per level to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'scavenge';

-----------------------------------
-- Ninja
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
-----------------------------------

-- Sange: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'sange';

-- Sange merit: Revert value from 25 ranged accuracy to 150 seconds recast reduction
UPDATE merits SET value = 150 WHERE name = 'sange';
