-- ---------------------------------------------------------------------------
--  Notes: Reduces the respawn cooldown for LB2 NMs
-- ---------------------------------------------------------------------------

UPDATE `mob_groups` SET `respawntime` = 15 WHERE `zoneid` = 112 AND `groupid` = 26; -- Boreal Hound
UPDATE `mob_groups` SET `respawntime` = 15 WHERE `zoneid` = 112 AND `groupid` = 27; -- Boreal Coeurl
UPDATE `mob_groups` SET `respawntime` = 15 WHERE `zoneid` = 112 AND `groupid` = 28; -- Boreal Tiger
