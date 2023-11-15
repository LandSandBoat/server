LOCK TABLE `status_effects` WRITE;

-- add EFFECTFLAG_DETECTABLE so player using JAs and Spells on mobs removes mazurka
UPDATE `status_effects` SET flags = 67893 WHERE `name` = "mazurka";

UNLOCK TABLES;
