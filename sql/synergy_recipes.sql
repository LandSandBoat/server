DROP TABLE IF EXISTS `synergy_recipes`;
CREATE TABLE `synergy_recipes` (
  `id` mediumint(5) unsigned NOT NULL AUTO_INCREMENT,
  `primary_skill` tinyint(2) unsigned NOT NULL,
  `primary_rank` tinyint(2) unsigned NOT NULL,
  `secondary_skill` tinyint(2) unsigned NOT NULL,
  `secondary_rank` tinyint(2) unsigned NOT NULL,
  `tertiary_skill` tinyint(2) unsigned NOT NULL,
  `tertiary_rank` tinyint(2) unsigned NOT NULL,
  `cost_fire_fewell` smallint(5) unsigned NOT NULL,
  `cost_ice_fewell` smallint(5) unsigned NOT NULL,
  `cost_wind_fewell` smallint(5) unsigned NOT NULL,
  `cost_earth_fewell` smallint(5) unsigned NOT NULL,
  `cost_lightning_fewell` smallint(5) unsigned NOT NULL,
  `cost_water_fewell` smallint(5) unsigned NOT NULL,
  `cost_light_fewell` smallint(5) unsigned NOT NULL,
  `cost_dark_fewell` smallint(5) unsigned NOT NULL,
  `ingredient1` smallint(5) unsigned NOT NULL,
  `ingredient2` smallint(5) unsigned NOT NULL,
  `ingredient3` smallint(5) unsigned NOT NULL,
  `ingredient4` smallint(5) unsigned NOT NULL,
  `ingredient5` smallint(5) unsigned NOT NULL,
  `ingredient6` smallint(5) unsigned NOT NULL,
  `ingredient7` smallint(5) unsigned NOT NULL,
  `ingredient8` smallint(5) unsigned NOT NULL,
  `result` smallint(5) unsigned NOT NULL,
  `resultHQ1` smallint(5) unsigned NOT NULL,
  `resultHQ2` smallint(5) unsigned NOT NULL,
  `resultHQ3` smallint(5) unsigned NOT NULL,
  `resultQty` tinyint(2) unsigned NOT NULL,
  `resultHQ1Qty` tinyint(2) unsigned NOT NULL,
  `resultHQ2Qty` tinyint(2) unsigned NOT NULL,
  `resultHQ3Qty` tinyint(2) unsigned NOT NULL,
  `resultName` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Aria TRANSACTIONAL=0 AUTO_INCREMENT=3500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Variables
SET @SKILL_SYNERGY      = 0;
SET @SKILL_FISHING      = 1;
SET @SKILL_WOODWORKING  = 2;
SET @SKILL_SMITHING     = 3;
SET @SKILL_GOLDSMITHING = 4;
SET @SKILL_CLOTHCRAFT   = 5;
SET @SKILL_LEATHERCRAFT = 6;
SET @SKILL_BONECRAFT    = 7;
SET @SKILL_ALCHEMY      = 8;
SET @SKILL_COOKING      = 9;

SET @RANK_AMATEUR     = 0;
SET @RANK_RECRUIT     = 1;
SET @RANK_INITIATE    = 2;
SET @RANK_NOVICE      = 3;
SET @RANK_APPRENTICE  = 4;
SET @RANK_JOURNEYMAN  = 5;
SET @RANK_CRAFTSMAN   = 6;
SET @RANK_ARTISAN     = 7;
SET @RANK_ADEPT       = 8;
SET @RANK_VETERAN     = 9;
SET @RANK_EXPERT      = 10;
SET @RANK_AUTHORITY   = 11;
SET @RANK_LUMINARY    = 12;
SET @RANK_MASTER      = 13;
SET @RANK_GRANDMASTER = 14;
SET @RANK_LEGEND      = 15;

DELIMITER $$
DROP TRIGGER IF EXISTS ensure_synergy_ingredients_are_ordered;
CREATE TRIGGER ensure_synergy_ingredients_are_ordered
     BEFORE INSERT ON synergy_recipes FOR EACH ROW BEGIN
          IF NEW.ingredient2 > 0 AND NEW.ingredient1 > NEW.ingredient2
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient1` is larger than ingredient2';
          END IF;

          IF NEW.ingredient3 > 0 AND NEW.ingredient2 > NEW.ingredient3
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient2` is larger than ingredient3';
          END IF;

          IF NEW.ingredient4 > 0 AND NEW.ingredient3 > NEW.ingredient4
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient3` is larger than ingredient4';
          END IF;

          IF NEW.ingredient5 > 0 AND NEW.ingredient4 > NEW.ingredient5
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient4` is larger than ingredient5';
          END IF;

          IF NEW.ingredient6 > 0 AND NEW.ingredient5 > NEW.ingredient6
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient5` is larger than ingredient6';
          END IF;

          IF NEW.ingredient7 > 0 AND NEW.ingredient6 > NEW.ingredient7
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient6` is larger than ingredient7';
          END IF;

          IF NEW.ingredient8 > 0 AND NEW.ingredient7 > NEW.ingredient8
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synergy_recipes] - `ingredient7` is larger than ingredient8';
          END IF;
END$$

DELIMITER ;

LOCK TABLES `synergy_recipes` WRITE;

-- RECIPES START
-- -------------

-- Rank: Amateur
INSERT INTO `synergy_recipes` VALUES (1, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 0, 0, 0, 5, 0, 0, 0, 0, 27899, 27899, 0, 0, 0, 0, 0, 0, 27898, 27898, 27898, 27898, 1, 1, 1, 1, 'Alliance Shirt +1');
INSERT INTO `synergy_recipes` VALUES (2, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 0, 0, 0, 0, 0, 0, 5, 5, 20713, 20713, 0, 0, 0, 0, 0, 0, 20714, 20714, 20714, 20714, 1, 1, 1, 1, 'Excalipoor II');
INSERT INTO `synergy_recipes` VALUES (3, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 5, 0, 0, 5, 0, 0, 0, 0, 9079, 9080, 9081, 0, 0, 0, 0, 0, 3585, 3585, 3585, 3585, 1, 1, 1, 1, 'Galley Kitchen');
INSERT INTO `synergy_recipes` VALUES (4, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 0, 0, 0, 0, 0, 10, 0, 0, 26956, 26956, 0, 0, 0, 0, 0, 0, 26957, 26957, 26957, 26957, 1, 1, 1, 1, 'Poroggo Coat +1');
INSERT INTO `synergy_recipes` VALUES (5, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 0, 0, 0, 0, 0, 10, 0, 0, 26514, 26514, 0, 0, 0, 0, 0, 0, 26515, 26515, 26515, 26515, 1, 1, 1, 1, 'Poroggo Fleece +1');
INSERT INTO `synergy_recipes` VALUES (6, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 0, 0, 0, 0, 0, 10, 0, 0, 23803, 23803, 0, 0, 0, 0, 0, 0, 23804, 23804, 23804, 23804, 1, 1, 1, 1, 'Poroggo Cassock +1');
INSERT INTO `synergy_recipes` VALUES (7, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, @SKILL_SYNERGY, @RANK_AMATEUR, 0, 10, 0, 0, 0, 0, 0, 0, 25675, 25675, 0, 0, 0, 0, 0, 0, 25679, 25679, 25679, 25679, 1, 1, 1, 1, 'White Rarab Cap +1');

-- -----------
-- RECIPES END

UNLOCK TABLES;
