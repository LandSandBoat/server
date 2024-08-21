SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `exp_chain_values`;
CREATE TABLE IF NOT EXISTS `exp_chain_values` (
  `upper_level` TINYINT NOT NULL DEFAULT '0',
  `chain_number` TINYINT NOT NULL DEFAULT '0',
  `exp_multiplier` FLOAT NOT NULL DEFAULT '0',
  `chain_time` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`upper_level`, `chain_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb4;

INSERT INTO `exp_chain_values` VALUES(10, 0, 1.00, 50000);
INSERT INTO `exp_chain_values` VALUES(10, 1, 1.20, 40000);
INSERT INTO `exp_chain_values` VALUES(10, 2, 1.25, 30000);
INSERT INTO `exp_chain_values` VALUES(10, 3, 1.30, 20000);
INSERT INTO `exp_chain_values` VALUES(10, 4, 1.40, 10000);
INSERT INTO `exp_chain_values` VALUES(10, 5, 1.50, 6000);
INSERT INTO `exp_chain_values` VALUES(10, 6, 1.55, 2000);

INSERT INTO `exp_chain_values` VALUES(20, 0, 1.00, 100000);
INSERT INTO `exp_chain_values` VALUES(20, 1, 1.20, 80000);
INSERT INTO `exp_chain_values` VALUES(20, 2, 1.25, 60000);
INSERT INTO `exp_chain_values` VALUES(20, 3, 1.30, 40000);
INSERT INTO `exp_chain_values` VALUES(20, 4, 1.40, 20000);
INSERT INTO `exp_chain_values` VALUES(20, 5, 1.50, 8000);
INSERT INTO `exp_chain_values` VALUES(20, 6, 1.55, 4000);

INSERT INTO `exp_chain_values` VALUES(30, 0, 1.00, 150000);
INSERT INTO `exp_chain_values` VALUES(30, 1, 1.20, 120000);
INSERT INTO `exp_chain_values` VALUES(30, 2, 1.25, 90000);
INSERT INTO `exp_chain_values` VALUES(30, 3, 1.30, 60000);
INSERT INTO `exp_chain_values` VALUES(30, 4, 1.40, 30000);
INSERT INTO `exp_chain_values` VALUES(30, 5, 1.50, 10000);
INSERT INTO `exp_chain_values` VALUES(30, 6, 1.55, 5000);

INSERT INTO `exp_chain_values` VALUES(40, 0, 1.00, 200000);
INSERT INTO `exp_chain_values` VALUES(40, 1, 1.20, 160000);
INSERT INTO `exp_chain_values` VALUES(40, 2, 1.25, 120000);
INSERT INTO `exp_chain_values` VALUES(40, 3, 1.30, 80000);
INSERT INTO `exp_chain_values` VALUES(40, 4, 1.40, 40000);
INSERT INTO `exp_chain_values` VALUES(40, 5, 1.50, 40000);
INSERT INTO `exp_chain_values` VALUES(40, 6, 1.55, 30000);

INSERT INTO `exp_chain_values` VALUES(50, 0, 1.00, 250000);
INSERT INTO `exp_chain_values` VALUES(50, 1, 1.20, 200000);
INSERT INTO `exp_chain_values` VALUES(50, 2, 1.25, 150000);
INSERT INTO `exp_chain_values` VALUES(50, 3, 1.30, 100000);
INSERT INTO `exp_chain_values` VALUES(50, 4, 1.40, 50000);
INSERT INTO `exp_chain_values` VALUES(50, 5, 1.50, 50000);
INSERT INTO `exp_chain_values` VALUES(50, 6, 1.55, 50000);

INSERT INTO `exp_chain_values` VALUES(60, 0, 1.00, 300000);
INSERT INTO `exp_chain_values` VALUES(60, 1, 1.20, 240000);
INSERT INTO `exp_chain_values` VALUES(60, 2, 1.25, 180000);
INSERT INTO `exp_chain_values` VALUES(60, 3, 1.30, 120000);
INSERT INTO `exp_chain_values` VALUES(60, 4, 1.40, 90000);
INSERT INTO `exp_chain_values` VALUES(60, 5, 1.50, 60000);
INSERT INTO `exp_chain_values` VALUES(60, 6, 1.55, 60000);

-- Else, fall through to this:
INSERT INTO `exp_chain_values` VALUES(99, 0, 1.00, 360000);
INSERT INTO `exp_chain_values` VALUES(99, 1, 1.20, 300000);
INSERT INTO `exp_chain_values` VALUES(99, 2, 1.25, 240000);
INSERT INTO `exp_chain_values` VALUES(99, 3, 1.30, 165000);
INSERT INTO `exp_chain_values` VALUES(99, 4, 1.40, 105000);
INSERT INTO `exp_chain_values` VALUES(99, 5, 1.50, 60000);
INSERT INTO `exp_chain_values` VALUES(99, 6, 1.55, 60000);
