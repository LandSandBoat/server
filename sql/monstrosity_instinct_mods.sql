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
INSERT INTO `monstrosity_instinct_mods` VALUES (5,1,20);  -- DEF: 20
INSERT INTO `monstrosity_instinct_mods` VALUES (5,9,5);   -- DEX: 5
INSERT INTO `monstrosity_instinct_mods` VALUES (5,11,5);  -- AGI: 5
INSERT INTO `monstrosity_instinct_mods` VALUES (5,288,2); -- DOUBLE_ATTACK: 2

-- Hume's instinct I
INSERT INTO `monstrosity_instinct_mods` VALUES (768,8,2);  -- STR: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (768,9,2);  -- DEX: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (768,10,2); -- VIT: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (768,11,2); -- AGI: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (768,12,2); -- INT: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (768,13,2); -- MND: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (768,14,2); -- CHR: 2

-- Elvaan's instinct I
INSERT INTO `monstrosity_instinct_mods` VALUES (769,8,3);  -- STR: 3
INSERT INTO `monstrosity_instinct_mods` VALUES (769,13,3); -- MND: 3

-- Tarutaru's instinct I
INSERT INTO `monstrosity_instinct_mods` VALUES (770,6,2);  -- MPP: 3
INSERT INTO `monstrosity_instinct_mods` VALUES (770,12,3); -- INT: 3

-- Mithra's instinct I
INSERT INTO `monstrosity_instinct_mods` VALUES (771,9,3);  -- DEX: 3
INSERT INTO `monstrosity_instinct_mods` VALUES (771,11,3); -- AGI: 3

-- Galka's instinct I
INSERT INTO `monstrosity_instinct_mods` VALUES (772,3,2);  -- HPP: 2
INSERT INTO `monstrosity_instinct_mods` VALUES (772,10,3); -- VIT: 3
