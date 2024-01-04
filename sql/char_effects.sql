
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure de la table `char_effects`
--

DROP TABLE IF EXISTS `char_effects`;
CREATE TABLE IF NOT EXISTS `char_effects` (
  `charid` int(10) unsigned NOT NULL,
  `effectid` smallint(5) unsigned NOT NULL,
  `icon` smallint(5) unsigned NOT NULL DEFAULT '0',
  `power` smallint(5) unsigned NOT NULL DEFAULT '0',
  `tick` int(10) unsigned NOT NULL DEFAULT '0',
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `subid` int(10) unsigned NOT NULL DEFAULT '0',
  `subpower` smallint(5) NOT NULL DEFAULT '0',
  `tier` smallint(5) unsigned NOT NULL DEFAULT '0',
  `flags` int(8) unsigned NOT NULL DEFAULT '0',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
