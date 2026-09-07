------------------------------------
-- Era Abilities Enmity Overrides
-- CE = minimal (1), VE = era-accurate spike
------------------------------------
-- Source : https://kanican.livejournal.com/tag/enmity%20table%21/
------------------------------------

UPDATE `abilities` SET CE = 1, VE = 900  WHERE `name` = 'shield_bash';
UPDATE `abilities` SET CE = 1, VE = 1800 WHERE `name` = 'sentinel';
UPDATE `abilities` SET CE = 1, VE = 80   WHERE `name` = 'divine_seal';
UPDATE `abilities` SET CE = 1, VE = 80   WHERE `name` = 'elemental_seal';
UPDATE `abilities` SET CE = 1, VE = 0    WHERE `name` = 'cover';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'rampart';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'modus_veritas';
UPDATE `abilities` SET CE = 1, VE = 80   WHERE `name` = 'pianissimo';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'divine_emblem';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'nether_void';
