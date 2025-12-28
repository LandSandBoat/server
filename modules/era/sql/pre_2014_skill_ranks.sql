-- https://forum.square-enix.com/ffxi/threads/44592?p=527238#post527239
-- search for "The following jobs have undergone adjustments."

UPDATE `skill_ranks` SET `thf` = 2 WHERE `name` = 'dagger'; -- Down to A(2) from A+(1)
UPDATE `skill_ranks` SET `bst` = 2 WHERE `name` = 'axe'; -- Down to A(2) from A+(1)
UPDATE `skill_ranks` SET `nin` = 2 WHERE `name` = 'katana'; -- Down to A(2) from A+(1)
UPDATE `skill_ranks` SET `nin` = 2 WHERE `name` = 'throwing'; -- Down to A(2) from A+(1)
UPDATE `skill_ranks` SET `blu` = 2 WHERE `name` = 'sword'; -- Down to A(2) from A+(1)
UPDATE `skill_ranks` SET `pup` = 3 WHERE `name` = 'hand2hand'; -- Down to B+(3) from A+(1)
UPDATE `skill_ranks` SET `dnc` = 3 WHERE `name` = 'dagger'; -- Down to B+(3) from A+(1)
