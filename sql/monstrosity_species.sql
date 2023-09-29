
DROP TABLE IF EXISTS `monstrosity_species`;

CREATE TABLE `monstrosity_species` (
  `monstrosity_id` smallint(30) DEFAULT NULL, -- Used as the shift offset into the monstrosity.levels array
  `species_id` smallint(5) unsigned NOT NULL, -- Species ID sent from the client
  `name_id` smallint(3) unsigned NOT NULL,    -- Name ID sent from the client (re-used for variants)
  `look` smallint(3) unsigned NOT NULL,       -- Look data sent from the client
  `name` -- Human-readable name. Only used for this file and logging.
  Stats, etc. -- Lv1 stats for the mob
  PRIMARY KEY (`monstrosity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

INSERT INTO `monstrosity_species` VALUES (1, 0x0001, 0x010C, "Rabbit", );

