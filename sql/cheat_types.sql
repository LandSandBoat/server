SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for table `cheat_types`
--

DROP TABLE IF EXISTS `cheat_types`;
CREATE TABLE IF NOT EXISTS `cheat_types` (
  `cheatid` int(10) unsigned NOT NULL,
  `name` varchar(15) NOT NULL,
  `description` varchar(128) NOT NULL,
  `argument` int(10) unsigned NOT NULL,
  `action_bitmask` int(10) unsigned NOT NULL,
  `warning_message` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cheat_types`
--

INSERT INTO `cheat_types` (`cheatid`, `name`, `description`, `argument`, `action_bitmask`, `warning_message`) VALUES
(1, 'FASTSYNTH', 'Player injects a synth done (0x59) packet to perform synth and craft skillups faster than the game allows.', 0, 1, 'A fast craft cheating attempt has been attempted. Successful craft has been blocked and the incident will be reported.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cheat_types`
--
ALTER TABLE `cheat_types`
  ADD PRIMARY KEY (`cheatid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
