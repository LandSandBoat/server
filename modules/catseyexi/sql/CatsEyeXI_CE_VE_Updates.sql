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

## Runefencer
UPDATE `spell_list` SET `castTime` = 2000, `CE` = 1000, `VE` = 2500 WHERE spellId = 840 AND `name` = 'foil';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 367 AND `name` = 'swordplay';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 366 AND `name` = 'vallation';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 371 AND `name` = 'valiance';
UPDATE `abilities` SET  `CE` = 500, `VE` = 2500 WHERE abilityId = 369 AND `name` = 'pflug';