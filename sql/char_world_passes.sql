SET FOREIGN_KEY_CHECKS=0;
-- --------------------------------------
-- Table structure for char_world_passes
-- --------------------------------------
DROP TABLE IF EXISTS `char_world_passes`;
CREATE TABLE `char_world_passes` (
  `code` int(10) unsigned NOT NULL,                          -- the ten digit pass number
  `inviter` int(10) unsigned NOT NULL,                       -- charid that bought the pass
  `expiry` int(10) unsigned NOT NULL,                        -- unix time the pass can no longer be used
  `invitee` int(10) unsigned DEFAULT NULL,                   -- charid created with the pass
  `joined` int(10) unsigned NOT NULL DEFAULT '0',            -- unix time the invitee was created
  `invitee_claims` tinyint(3) unsigned NOT NULL DEFAULT '0', -- bit per anniversary the invitee received an item for
  `inviter_claims` tinyint(3) unsigned NOT NULL DEFAULT '0', -- bit per anniversary the inviter received an item for
  PRIMARY KEY (`code`),
  KEY `inviter` (`inviter`),
  UNIQUE KEY `invitee` (`invitee`),
  CONSTRAINT `fk_char_world_passes_inviter` FOREIGN KEY (`inviter`) REFERENCES `chars` (`charid`) ON DELETE CASCADE,
  CONSTRAINT `fk_char_world_passes_invitee` FOREIGN KEY (`invitee`) REFERENCES `chars` (`charid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
