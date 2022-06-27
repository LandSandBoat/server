##Update CE and VE values for spells and abilities
#USE xidb; #For default installs
USE tpzdb; #Or change to your database name
##Abilities
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 35 AND `name` = 'provoke';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 46 AND `name` = 'shield_bash';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 48 AND `name` = 'sentinel';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 204 AND `name` = 'animated_flourish';

##Spells
UPDATE `spell_list` SET  `CE` = 250, `VE` = 2500 WHERE spellId = 112 AND `name` = 'flash';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 341 AND `name` = 'jubaku_ichi';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 342 AND `name` = 'jubaku_ni';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 343 AND `name` = 'jubaku_san';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 344 AND `name` = 'hojo_ichi';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 345 AND `name` = 'hojo_ni';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 346 AND `name` = 'hojo_san';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 347 AND `name` = 'kurayami_ichi';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 348 AND `name` = 'kurayami_ni';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 349 AND `name` = 'kurayami_san';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 350 AND `name` = 'dokumori_ichi';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 351 AND `name` = 'dokumori_ni';
UPDATE `spell_list` SET  `CE` = 30, `VE` = 150 WHERE spellId = 352 AND `name` = 'dokumori_san';