CREATE TABLE IF NOT EXISTS `accounts_trust_tokens` (
  `token` CHAR(64) NOT NULL,
  `accid` INT UNSIGNED NOT NULL,
  `expires` DATETIME NOT NULL,
  PRIMARY KEY (`token`),
  INDEX `idx_accid` (`accid`),
  CONSTRAINT `fk_trust_accid` FOREIGN KEY (`accid`) REFERENCES `accounts`(`id`) ON DELETE CASCADE
);
