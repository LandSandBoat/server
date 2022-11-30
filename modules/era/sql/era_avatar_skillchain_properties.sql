-- Era Accuracy
-- Remove skillchain properties from avatar bloodpacts
SET autocommit = 0;

LOCK TABLES
    `mob_skills` AS s WRITE,
	`abilities` AS a READ;

UPDATE
	`mob_skills` s
LEFT JOIN 
	`abilities` a 
	ON s.mob_skill_name = a.name
SET
	s.primary_sc = 0,
	s.secondary_sc = 0,
	s.tertiary_sc = 0
WHERE 
	(`mob_skill_flag` & 64 = 64 OR `mob_skill_flag` & 128 = 128)
	AND a.level > 50;

COMMIT;
UNLOCK TABLES;
