-----------------------------------
-- Attachment equip cost adjustments for the WoTG Era.
-- https://wiki.ffo.jp/html/25853.html
-- https://wiki.ffo.jp/html/37589.html
-----------------------------------
UPDATE `item_puppet` SET `element` =      2 WHERE `name` = 'tension_spring';     -- 2 Fire
UPDATE `item_puppet` SET `element` =      3 WHERE `name` = 'tension_spring_ii';  -- 3 Fire
UPDATE `item_puppet` SET `element` =      2 WHERE `name` = 'reactive_shield';    -- 2 Fire
UPDATE `item_puppet` SET `element` =     32 WHERE `name` = 'loudspeaker';        -- 2 Ice
UPDATE `item_puppet` SET `element` =     48 WHERE `name` = 'loudspeaker_ii';     -- 3 Ice
UPDATE `item_puppet` SET `element` =     32 WHERE `name` = 'tactical_processor'; -- 2 Ice
UPDATE `item_puppet` SET `element` =     32 WHERE `name` = 'tranquilizer';       -- 2 Ice
UPDATE `item_puppet` SET `element` =     48 WHERE `name` = 'tranquilizer_ii';    -- 3 Ice
UPDATE `item_puppet` SET `element` =    512 WHERE `name` = 'scope';              -- 2 Wind
UPDATE `item_puppet` SET `element` =   8192 WHERE `name` = 'schurzen';           -- 2 Earth
UPDATE `item_puppet` SET `element` = 131072 WHERE `name` = 'volt_gun';           -- 2 Thunder
UPDATE `item_puppet` SET `element` = 131072 WHERE `name` = 'stabilizer';         -- 2 Thunder
UPDATE `item_puppet` SET `element` = 196608 WHERE `name` = 'stabilizer_ii';      -- 3 Thunder
