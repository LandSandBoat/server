DROP TABLE IF EXISTS `monstrosity_instinct_mods`;
CREATE TABLE `monstrosity_instinct_mods` (
  `monstrosity_instinct_id` smallint(5) unsigned NOT NULL,
  `modId` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`monstrosity_instinct_id`,`modId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Rabbit instinct I
INSERT INTO `monstrosity_instinct_mods` VALUES (3,3,2);   -- HPP: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (3,11,5);  -- AGI: 5
INSERT INTO `monstrosity_instinct_mods` VALUES (3,23,10); -- ATT: 10

-- Rabbit instinct II
INSERT INTO `monstrosity_instinct_mods` VALUES (4,3,3);   -- HPP: 3
INSERT INTO `monstrosity_instinct_mods` VALUES (4,9,5);   -- DEX: 5
INSERT INTO `monstrosity_instinct_mods` VALUES (4,68,10); -- EVA: 15

-- Rabbit instinct III
INSERT INTO `monstrosity_instinct_mods` VALUES (5,9,5);   -- DEX: 5
INSERT INTO `monstrosity_instinct_mods` VALUES (5,11,5);  -- AGI: 5
INSERT INTO `monstrosity_instinct_mods` VALUES (5,1,20);  -- DEF: 20
INSERT INTO `monstrosity_instinct_mods` VALUES (5,1,288); -- DOUBLE_ATTACK: 2
