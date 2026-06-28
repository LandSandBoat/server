-- Single-use, short-TTL game-launch tokens.
--
-- Minted by the Phoenix auth service for an already-authenticated session
-- (Discord or email/password) and consumed once by xi_connect's LOGIN_ATTEMPT
-- (see src/login/otp_helpers.h validateAndConsumeLaunchToken). Unlike a trust
-- token (OTP-bypass only), a launch token stands in for BOTH password and OTP at
-- boot — justified because the Phoenix session already enforced auth (incl. 2FA)
-- before minting.
--
-- Same shape as accounts_trust_tokens; "single use" and the short (~5 min) TTL
-- are enforced in code (the row is DELETEd on consume; the mint sets `expires`),
-- not by the schema. Only the SHA-256 hash of the token is stored.
CREATE TABLE IF NOT EXISTS `accounts_login_tokens` (
  `token` CHAR(64) NOT NULL,
  `accid` INT UNSIGNED NOT NULL,
  `expires` DATETIME NOT NULL,
  PRIMARY KEY (`token`),
  INDEX `idx_accid` (`accid`),
  INDEX `idx_expires` (`expires`),
  CONSTRAINT `fk_login_accid` FOREIGN KEY (`accid`) REFERENCES `accounts`(`id`) ON DELETE CASCADE
);
