-----------------------------------
-- Module: RoV Zone Settings Adjustments
-- This module reverts relevant zone_settings rows to their pre-RoV values
-----------------------------------

-- Revert mount riding in the zones opened to chocobos and other mounts in June 2016
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
SET @MISC_MOUNT = 4;

UPDATE `zone_settings`
SET `misc` = `misc` & ~@MISC_MOUNT
WHERE `name` IN (
    'Beaucedine_Glacier',
    'Xarcabard',
    'Cape_Teriggan',
    'RoMaeve',
    'Qufim_Island',
    'Behemoths_Dominion',
    'Valley_of_Sorrows',
    'Mount_Zhayolm',
    'Caedarva_Mire'
);
