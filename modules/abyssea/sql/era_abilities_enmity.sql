------------------------------------
-- Era Abilities Enmity Overrides
-- CE = minimal (1), VE = era-accurate spike
------------------------------------
-- Source : https://kanican.livejournal.com/tag/enmity%20table%21/
------------------------------------

UPDATE `abilities` SET CE = 1, VE = 900  WHERE `name` = 'Shield Bash';
UPDATE `abilities` SET CE = 1, VE = 1800 WHERE `name` = 'Sentinel';
UPDATE `abilities` SET CE = 1, VE = 80   WHERE `name` = 'Divine Seal';
UPDATE `abilities` SET CE = 1, VE = 80   WHERE `name` = 'Elemental Seal';
UPDATE `abilities` SET CE = 1, VE = 0    WHERE `name` = 'Cover';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'Rampart';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'Modus Veritas';
UPDATE `abilities` SET CE = 1, VE = 80   WHERE `name` = 'Pianissimo';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'Divine Emblem';
UPDATE `abilities` SET CE = 1, VE = 300  WHERE `name` = 'Nether Void';
