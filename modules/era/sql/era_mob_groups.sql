-- ---------------------------------------------------------------------------
--  Notes: Reverts mob levels to original 75 cap levels
-- Format: (groupid,poolid,zoneid,name,respawntime,spawntype,dropid,HP,MP,minLevel,maxLevel,allegiance)
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------
-- Add content_tag to zones
-- ------------------------------------------------------------

LOCK TABLE `mob_groups` WRITE;

ALTER TABLE `mob_groups`
    ADD COLUMN IF NOT EXISTS `content_tag` varchar(14) DEFAULT NULL AFTER `allegiance`;

UPDATE mob_groups SET content_tag='COP' WHERE zoneid='1' OR zoneid='2' OR zoneid='3' OR zoneid='4' OR zoneid='5'
                  OR zoneid='6' OR zoneid='7' OR zoneid='8' OR zoneid='7' OR zoneid='8' OR zoneid='9' OR zoneid='10'
                  OR zoneid='11' OR zoneid='12' OR zoneid='13' OR zoneid='16' OR zoneid='17' OR zoneid='18' OR zoneid='19'
                  OR zoneid='20' OR zoneid='21' OR zoneid='22' OR zoneid='23' OR zoneid='24' OR zoneid='25' OR zoneid='26'
                  OR zoneid='27' OR zoneid='28' OR zoneid='29' OR zoneid='30' OR zoneid='31' OR zoneid='32' OR zoneid='33'
                  OR zoneid='34' OR zoneid='35' OR zoneid='36' OR zoneid='37' OR zoneid='38';

UPDATE mob_groups SET content_tag='TOAU' WHERE zoneid='46' OR zoneid='47' OR zoneid='48' OR zoneid='49' OR zoneid='50' OR zoneid='51'
                  OR zoneid='52' OR zoneid='53' OR zoneid='54' OR zoneid='55' OR zoneid='56' OR zoneid='57' OR zoneid='58' OR zoneid='59'
                  OR zoneid='60' OR zoneid='61' OR zoneid='62' OR zoneid='63' OR zoneid='64' OR zoneid='65' OR zoneid='66' OR zoneid='67'
                  OR zoneid='68' OR zoneid='69' OR zoneid='70' OR zoneid='71' OR zoneid='72' OR zoneid='73' OR zoneid='74' OR zoneid='75'
                  OR zoneid='76' OR zoneid='77' OR zoneid='78' OR zoneid='79';

UPDATE mob_groups SET content_tag='WOTG' WHERE zoneid='80' OR zoneid='81' OR zoneid='82' OR zoneid='83' OR zoneid='84' OR zoneid='85'
                  OR zoneid='86' OR zoneid='87' OR zoneid='88' OR zoneid='89' OR zoneid='90' OR zoneid='91' OR zoneid='92' OR zoneid='93'
                  OR zoneid='94' OR zoneid='95' OR zoneid='96' OR zoneid='97' OR zoneid='98' OR zoneid='99' OR zoneid='136' OR zoneid='137'
                  OR zoneid='138' OR zoneid='155' OR zoneid='156' OR zoneid='164' OR zoneid='171' OR zoneid='175' OR zoneid='182';

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE zoneid='15' OR zoneid='45' OR zoneid='132' OR zoneid='215' OR zoneid='216'
                  OR zoneid='217' OR zoneid='218' OR zoneid='253' OR zoneid='254' OR zoneid='255' OR zoneid='44'
                  OR zoneid='183' OR zoneid='287';

UPDATE mob_groups SET content_tag='SOA' WHERE zoneid='258' OR zoneid='259' OR zoneid='260' OR zoneid='261' OR zoneid='262' OR zoneid='263'
                  OR zoneid='262' OR zoneid='263' OR zoneid='264' OR zoneid='265' OR zoneid='266' OR zoneid='267' OR zoneid='268' OR zoneid='269'
                  OR zoneid='270' OR zoneid='271' OR zoneid='272' OR zoneid='273' OR zoneid='274' OR zoneid='275' OR zoneid='276' OR zoneid='277'
                  OR zoneid='278' OR zoneid='279' OR zoneid='280' OR zoneid='281' OR zoneid='282' OR zoneid='283' OR zoneid='284' OR zoneid='285'
                  OR zoneid='286' OR zoneid='287';

UPDATE mob_groups SET content_tag='ROV' WHERE zoneid='288' OR zoneid='289' OR zoneid='290' OR zoneid='291' OR zoneid='292' OR zoneid='293'
                  OR zoneid='294' OR zoneid='295' OR zoneid='296' OR zoneid='297' OR zoneid='298';

UPDATE mob_groups SET content_tag='NEODYNA' WHERE zoneid='39' OR zoneid='40' OR zoneid='41' OR zoneid='42' OR zoneid='134' OR zoneid='135'
                  OR zoneid='185' OR zoneid='186' OR zoneid='187' OR zoneid='188';

-- ------------------------------------------------------------
-- Carpenters_Landing (Zone 2)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Tempest_Tigon' AND groupid='31' AND zoneid='2';
UPDATE mob_groups set minLevel = 21 WHERE name = "Marsh_Funguar" and zoneid =2;
UPDATE mob_groups set minLevel = 24, maxLevel = 38 WHERE name = "Thunder_Elemental" and zoneid =2;
UPDATE mob_groups set minLevel = 24, maxLevel = 38 WHERE name = "Water_Elemental" and zoneid =2;

-- ------------------------------------------------------------
-- Bibiki_Bay (Zone 4)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Camelopard' AND groupid='41' AND zoneid='4';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Bight_Rarab' AND groupid='40' AND zoneid='4';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Hypnos_Eft' AND groupid='44' AND zoneid='4';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Shankha' AND groupid='17' AND zoneid='4';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Splacknuck' AND groupid='37' AND zoneid='4';
UPDATE mob_groups set maxLevel = 35 WHERE name = "Eft" and zoneid = 4;
UPDATE mob_groups set minLevel = 34 WHERE name = "Goblin_Shaman" and zoneid = 4;
UPDATE mob_groups set minLevel = 34 WHERE name = "Goblin_Pathfinder" and zoneid = 4;
UPDATE mob_groups set maxLevel = 38 WHERE name = "Island_Rarab" and zoneid = 4;
UPDATE mob_groups set minLevel = 36 WHERE name = "Jagil" and zoneid = 4;
UPDATE mob_groups set maxLevel = 40 WHERE name = "Kraken" and zoneid = 4;
UPDATE mob_groups set minLevel = 40, maxLevel = 42 WHERE name = "Lancet_Jagil" and zoneid = 4;
UPDATE mob_groups set minLevel = 67 WHERE name = "Goblins_Rarab" and zoneid =4 and groupid = 29;
UPDATE mob_groups set maxLevel = 78 WHERE name = "Teine_Sith" and zoneid = 4;
UPDATE mob_groups set maxLevel = 79 WHERE name = "Tartarus_Eft" and zoneid = 4;
UPDATE mob_groups set minLevel = 77, maxLevel = 79 WHERE name = "Hobgoblin_Blagger" and zoneid = 4;
UPDATE mob_groups set minLevel = 77, maxLevel = 79 WHERE name = "Hobgoblin_Toreador" and zoneid = 4;
UPDATE mob_groups set minLevel = 77, maxLevel = 79 WHERE name = "Hobgoblin_Physician" and zoneid = 4;
UPDATE mob_groups set minLevel = 77, maxLevel = 79 WHERE name = "Hobgoblin_Alastor" and zoneid = 4;
UPDATE mob_groups set minLevel = 80, maxLevel = 80 WHERE name = "Hobgoblin_Angler" and zoneid = 4;

-- Locus Mobs
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Bight_Rarab' AND groupid='53' AND zoneid='4';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Camelopard' AND groupid='54' AND zoneid='4';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Hypnos_Eft' AND groupid='55' AND zoneid='4';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Ghost_Crab' AND groupid='56' AND zoneid='4';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Fiddler_Crab' AND groupid='57' AND zoneid='4';

-- ------------------------------------------------------------
-- Uleguerand_Range (Zone 5)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Magnotaur' AND groupid='39' AND zoneid='5';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Skvader' AND groupid='11' AND zoneid='5';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Frost_Flambeau' AND groupid='49' AND zoneid='5';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Scowlenkos' AND groupid='38' AND zoneid='5';

UPDATE mob_groups set minLevel = 61 WHERE name = "Uleguerand_Tiger" and zoneid = 5;
UPDATE mob_groups set maxLevel = 68 WHERE name = "Demons_Elemental" and zoneid = 5;
UPDATE mob_groups set minLevel = 75, maxLevel = 77 WHERE name = "Dead_Demon" and zoneid = 5;
UPDATE mob_groups set minLevel = 75, maxLevel = 77 WHERE name = "Judicator_Demon" and zoneid = 5;
UPDATE mob_groups set minLevel = 75, maxLevel = 77 WHERE name = "Gore_Demon" and zoneid = 5;
UPDATE mob_groups set minLevel = 75, maxLevel = 77 WHERE name = "Stygian_Demon" and zoneid = 5;
UPDATE mob_groups set minLevel = 74 WHERE name = "Doom_Mage" and zoneid = 5;

-- ------------------------------------------------------------
-- Attohwa_Chasm (Zone 7)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sekhmet' AND groupid='12' AND zoneid='7';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Sargas' AND groupid='32' AND zoneid='7';
UPDATE mob_groups set minLevel = 36, maxLevel = 39 WHERE name = "Goblin_Shaman" and zoneid = 7;
UPDATE mob_groups set minLevel = 41 WHERE name = "Air_Elemental" and zoneid =7 and groupid = 28;
UPDATE mob_groups set minLevel = 55, maxLevel = 55 WHERE name = "Lioumere" and zoneid = 7;

-- ------------------------------------------------------------
-- PsoXja (Zone 9)
-- ------------------------------------------------------------
UPDATE mob_groups set minLevel = 42, maxLevel = 46 WHERE name = "Gazer" and zoneid = 9;
UPDATE mob_groups set minLevel = 42, maxLevel = 48 WHERE name = "Diremite" and zoneid = 9;
UPDATE mob_groups set minLevel = 43, maxLevel = 50 WHERE name = "Snowball" and zoneid = 9;
UPDATE mob_groups set minLevel = 46, maxLevel = 50 WHERE name = "Vampire_Bat" and zoneid = 9;
UPDATE mob_groups set minLevel = 43, maxLevel = 47 WHERE name = "Maze_Lizard" and zoneid = 9;
UPDATE mob_groups set minLevel = 48, maxLevel = 55 WHERE name = "Tonberrys_Elemental" and zoneid = 9;
UPDATE mob_groups set minLevel = 53 WHERE name = "Labyrinth_Lizard" and zoneid = 9;
UPDATE mob_groups set minLevel = 53, maxLevel = 60 WHERE name = "Cryptonberry_Plaguer" and zoneid = 9;
UPDATE mob_groups set minLevel = 53, maxLevel = 60 WHERE name = "Cryptonberry_Cutter" and zoneid = 9;
UPDATE mob_groups set minLevel = 53, maxLevel = 60 WHERE name = "Cryptonberry_Harrier" and zoneid = 9;
UPDATE mob_groups set minLevel = 53, maxLevel = 60 WHERE name = "Cryptonberry_Stalker" and zoneid = 9;
UPDATE mob_groups set minLevel = 53, maxLevel = 58 WHERE name = "Blubber_Eyes" and zoneid = 9;
UPDATE mob_groups set minLevel = 56, maxLevel = 59 WHERE name = "Snoll" and zoneid = 9;
UPDATE mob_groups set maxLevel = 63 WHERE name = "Goblins_Bat" and zoneid = 9;
UPDATE mob_groups set maxLevel = 68 WHERE name = "Dire_Bat" and zoneid = 9;
UPDATE mob_groups set minLevel = 63, maxLevel = 68 WHERE name = "Snow_Lizard" and zoneid = 9;
UPDATE mob_groups set minLevel = 56, maxLevel = 59 WHERE name = "Snoll" and zoneid = 9;
UPDATE mob_groups set minLevel = 56, maxLevel = 59 WHERE name = "Snoll" and zoneid = 9;
UPDATE mob_groups set minLevel = 56, maxLevel = 59 WHERE name = "Snoll" and zoneid = 9;

-- ------------------------------------------------------------
-- Oldton_Movalpolos (Zone 11)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bugbear_Muscleman' AND groupid='18' AND zoneid='11';
UPDATE mob_groups set minLevel = 28, maxLevel = 31 WHERE name = "Goblins_Bat" and zoneid = 11 and groupid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Goblin_Doorman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Goblin_Oilman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Goblin_Shovelman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Goblin_Tollman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Moblin_Coalman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Moblin_Gasman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Moblin_Pikeman" and zoneid = 11;
UPDATE mob_groups set minLevel = 41, maxLevel = 42 WHERE name = "Moblin_Repairman" and zoneid = 11;
UPDATE mob_groups set minLevel = 42, maxLevel = 45 WHERE name = "Bugbear_Bondman" and zoneid = 11;
UPDATE mob_groups set minLevel = 46 WHERE name = "Goblin_Freelance" and zoneid = 11;

-- ------------------------------------------------------------
-- Newton_Movalpolos (Zone 12)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Sword_Sorcerer_Solisoq' AND groupid='36' AND zoneid='12';
UPDATE mob_groups set minLevel = 70, maxLevel = 80 WHERE name = "Earth_Elemental" and zoneid = 12;
UPDATE mob_groups set minLevel = 76, maxLevel = 78 WHERE name = "Goblin_Headman" and zoneid = 12;
UPDATE mob_groups set minLevel = 76, maxLevel = 78 WHERE name = "Goblin_Marksman" and zoneid = 12;
UPDATE mob_groups set minLevel = 76, maxLevel = 79 WHERE name = "Moblin_Engineman" and zoneid = 12;
UPDATE mob_groups set minLevel = 76, maxLevel = 79 WHERE name = "Moblin_Topsman" and zoneid = 12;

-- ------------------------------------------------------------
-- Mine_Shaft_2716 (Zone 13)
-- ------------------------------------------------------------

UPDATE mob_groups SET minlevel='45',maxlevel='45', HP='5800' WHERE name='Twilotak' AND groupid='6' AND zoneid='13';
UPDATE mob_groups SET minlevel='39',maxlevel='41' WHERE name='Moblin_Wisewoman' AND groupid='7' AND zoneid='13';
UPDATE mob_groups SET minlevel='39',maxlevel='41' WHERE name='Moblin_Clergyman' AND groupid='8' AND zoneid='13';

-- ------------------------------------------------------------
-- Promyvion-Holla (Zone 16)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='16';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='16';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='16';
UPDATE mob_groups set minLevel = 20, maxLevel = 22 WHERE name = "Stray" and zoneid = 16 and groupid = 6;  -- Was 21-21
UPDATE mob_groups set minLevel = 23, maxLevel = 25 WHERE name = "Stray" and zoneid = 16 and groupid = 11; -- Was 23-24
UPDATE mob_groups set minLevel = 26, maxLevel = 27 WHERE name = "Stray" and zoneid = 16 and groupid = 16; -- Was 26-27
UPDATE mob_groups set minLevel = 22, maxLevel = 24 WHERE name = "Wanderer" and zoneid = 16 and groupid = 1;  -- Was 22-24
UPDATE mob_groups set minLevel = 26, maxLevel = 28 WHERE name = "Wanderer" and zoneid = 16 and groupid = 7;  -- Was 26-28
UPDATE mob_groups set minLevel = 29, maxLevel = 31 WHERE name = "Wanderer" and zoneid = 16 and groupid = 12; -- Was 29-31
UPDATE mob_groups set minLevel = 32, maxLevel = 34 WHERE name = "Wanderer" and zoneid = 16 and groupid = 19; -- Was 32-33
UPDATE mob_groups set minLevel = 24, maxLevel = 26 WHERE name = "Weeper" and zoneid = 16 and groupid = 2;  -- Was 24-26
UPDATE mob_groups set minLevel = 27, maxLevel = 30 WHERE name = "Weeper" and zoneid = 16 and groupid = 8;  -- Was 28-30
UPDATE mob_groups set minLevel = 31, maxLevel = 33 WHERE name = "Weeper" and zoneid = 16 and groupid = 13; -- Was 31-33
UPDATE mob_groups set minLevel = 34, maxLevel = 36 WHERE name = "Weeper" and zoneid = 16 and groupid = 17; -- Was 33-35
UPDATE mob_groups set minLevel = 31, maxLevel = 33 WHERE name = "Seether" and zoneid = 16 and groupid = 10; -- Was 30-32
UPDATE mob_groups set minLevel = 34, maxLevel = 36 WHERE name = "Seether" and zoneid = 16 and groupid = 14; -- Was 33-35
UPDATE mob_groups set minLevel = 37, maxLevel = 38 WHERE name = "Seether" and zoneid = 16 and groupid = 18; -- Was 35-37
UPDATE mob_groups set minLevel = 29, maxLevel = 32 WHERE name = "Thinker" and zoneid = 16 and groupid = 4;  -- Was 28-28
UPDATE mob_groups set minLevel = 33, maxLevel = 34 WHERE name = "Thinker" and zoneid = 16 and groupid = 9;  -- Was 33-34
UPDATE mob_groups set minLevel = 35, maxLevel = 37 WHERE name = "Thinker" and zoneid = 16 and groupid = 15; -- Was 35-37
UPDATE mob_groups set minLevel = 38, maxLevel = 40 WHERE name = "Thinker" and zoneid = 16 and groupid = 20; -- Was 37-39

-- ------------------------------------------------------------
-- Promyvion-Dem (Zone 18)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='18';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='18';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='18';
UPDATE mob_groups set minLevel = 20, maxLevel = 22 WHERE name = "Stray" and zoneid = 18 and groupid = 6;  -- Was 20-21
UPDATE mob_groups set minLevel = 23, maxLevel = 25 WHERE name = "Stray" and zoneid = 18 and groupid = 11; -- Was 23-24
UPDATE mob_groups set minLevel = 26, maxLevel = 27 WHERE name = "Stray" and zoneid = 18 and groupid = 16; -- Was 26-28
UPDATE mob_groups set minLevel = 22, maxLevel = 24 WHERE name = "Wanderer" and zoneid = 18 and groupid = 1;  -- Was 22-24
UPDATE mob_groups set minLevel = 26, maxLevel = 28 WHERE name = "Wanderer" and zoneid = 18 and groupid = 8;  -- Was 26-28
UPDATE mob_groups set minLevel = 29, maxLevel = 31 WHERE name = "Wanderer" and zoneid = 18 and groupid = 12; -- Was 29-31
UPDATE mob_groups set minLevel = 32, maxLevel = 34 WHERE name = "Wanderer" and zoneid = 18 and groupid = 19; -- Was 31-33
UPDATE mob_groups set minLevel = 24, maxLevel = 26 WHERE name = "Weeper" and zoneid = 18 and groupid = 3;  -- Was 24-26
UPDATE mob_groups set minLevel = 27, maxLevel = 30 WHERE name = "Weeper" and zoneid = 18 and groupid = 7;  -- Was 28-30
UPDATE mob_groups set minLevel = 31, maxLevel = 33 WHERE name = "Weeper" and zoneid = 18 and groupid = 13; -- Was 31-33
UPDATE mob_groups set minLevel = 34, maxLevel = 36 WHERE name = "Weeper" and zoneid = 18 and groupid = 18; -- Was 33-35
UPDATE mob_groups set minLevel = 31, maxLevel = 33 WHERE name = "Seether" and zoneid = 18 and groupid = 9;  -- Was 30-32
UPDATE mob_groups set minLevel = 34, maxLevel = 36 WHERE name = "Seether" and zoneid = 18 and groupid = 14; -- Was 33-35
UPDATE mob_groups set minLevel = 37, maxLevel = 38 WHERE name = "Seether" and zoneid = 18 and groupid = 17; -- Was 35-37
UPDATE mob_groups set minLevel = 29, maxLevel = 32 WHERE name = "Gorger" and zoneid = 18 and groupid = 4;  -- Was 29-31
UPDATE mob_groups set minLevel = 33, maxLevel = 34 WHERE name = "Gorger" and zoneid = 18 and groupid = 10; -- Was 32-34
UPDATE mob_groups set minLevel = 35, maxLevel = 37 WHERE name = "Gorger" and zoneid = 18 and groupid = 15; -- Was 35-37
UPDATE mob_groups set minLevel = 38, maxLevel = 40 WHERE name = "Gorger" and zoneid = 18 and groupid = 20; -- Was 37-39

-- ------------------------------------------------------------
-- Promyvion-Mea (Zone 20)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='20';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='20';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='20';
UPDATE mob_groups set minLevel = 20, maxLevel = 22 WHERE name = "Stray" and zoneid = 20 and groupid = 6;  -- Was 21-21
UPDATE mob_groups set minLevel = 23, maxLevel = 25 WHERE name = "Stray" and zoneid = 20 and groupid = 11; -- Was 23-24
UPDATE mob_groups set minLevel = 26, maxLevel = 27 WHERE name = "Stray" and zoneid = 20 and groupid = 16; -- Was 26-27
UPDATE mob_groups set minLevel = 22, maxLevel = 24 WHERE name = "Wanderer" and zoneid = 20 and groupid = 1;  -- Was 22-28
UPDATE mob_groups set minLevel = 26, maxLevel = 28 WHERE name = "Wanderer" and zoneid = 20 and groupid = 7;  -- Was 26-28
UPDATE mob_groups set minLevel = 29, maxLevel = 31 WHERE name = "Wanderer" and zoneid = 20 and groupid = 12; -- Was 29-31
UPDATE mob_groups set minLevel = 32, maxLevel = 34 WHERE name = "Wanderer" and zoneid = 20 and groupid = 19; -- Was 31-33
UPDATE mob_groups set minLevel = 24, maxLevel = 26 WHERE name = "Weeper" and zoneid = 20 and groupid = 2;  -- Was 25-30
UPDATE mob_groups set minLevel = 27, maxLevel = 30 WHERE name = "Weeper" and zoneid = 20 and groupid = 8;  -- Was 28-30
UPDATE mob_groups set minLevel = 31, maxLevel = 33 WHERE name = "Weeper" and zoneid = 20 and groupid = 13; -- Was 31-33
UPDATE mob_groups set minLevel = 34, maxLevel = 36 WHERE name = "Weeper" and zoneid = 20 and groupid = 18; -- Was 33-35
UPDATE mob_groups set minLevel = 31, maxLevel = 33 WHERE name = "Seether" and zoneid = 20 and groupid = 9;  -- Was 30-32
UPDATE mob_groups set minLevel = 34, maxLevel = 36 WHERE name = "Seether" and zoneid = 20 and groupid = 14; -- Was 33-35
UPDATE mob_groups set minLevel = 37, maxLevel = 38 WHERE name = "Seether" and zoneid = 20 and groupid = 17; -- Was 35-37
UPDATE mob_groups set minLevel = 29, maxLevel = 32 WHERE name = "Craver" and zoneid = 20 and groupid = 4;  -- Was 29-31
UPDATE mob_groups set minLevel = 33, maxLevel = 34 WHERE name = "Craver" and zoneid = 20 and groupid = 10; -- Was 32-34
UPDATE mob_groups set minLevel = 35, maxLevel = 37 WHERE name = "Craver" and zoneid = 20 and groupid = 15; -- Was 35-36
UPDATE mob_groups set minLevel = 38, maxLevel = 40 WHERE name = "Craver" and zoneid = 20 and groupid = 20; -- Was 36-40

-- ------------------------------------------------------------
-- Promyvion-Vahzl (Zone 22)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Idle_Wanderer' AND groupid='7' AND zoneid='22';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Livid_Seether' AND groupid='37' AND zoneid='22';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Woeful_Weeper' AND groupid='38' AND zoneid='22';

UPDATE mob_groups SET minLevel = 46, maxLevel = 47 WHERE name = "Wanderer" and zoneid = 22 and groupid = 5;  -- Was 46-48
UPDATE mob_groups SET minLevel = 48, maxLevel = 49 WHERE name = "Wanderer" and zoneid = 22 and groupid = 14; -- Was 46-48
UPDATE mob_groups SET minLevel = 50, maxLevel = 51 WHERE name = "Wanderer" and zoneid = 22 and groupid = 20; -- Was 50-52
UPDATE mob_groups SET minLevel = 52, maxLevel = 53 WHERE name = "Wanderer" and zoneid = 22 and groupid = 28; -- Was 50-52

UPDATE mob_groups SET minLevel = 48, maxLevel = 49 WHERE name = "Weeper" and zoneid = 22 and groupid = 6;  -- Was 46-48
UPDATE mob_groups SET minLevel = 50, maxLevel = 51 WHERE name = "Weeper" and zoneid = 22 and groupid = 13; -- Was 46-48
UPDATE mob_groups SET minLevel = 52, maxLevel = 53 WHERE name = "Weeper" and zoneid = 22 and groupid = 21; -- Was 50-52
UPDATE mob_groups SET minLevel = 54, maxLevel = 55 WHERE name = "Weeper" and zoneid = 22 and groupid = 29; -- Was 50-52

UPDATE mob_groups SET minLevel = 54, maxLevel = 55 WHERE name = "Thinker" and zoneid = 22 and groupid = 8;  -- Was 52-54
UPDATE mob_groups SET minLevel = 56, maxLevel = 57 WHERE name = "Thinker" and zoneid = 22 and groupid = 16; -- Was 54-56
UPDATE mob_groups SET minLevel = 58, maxLevel = 59 WHERE name = "Thinker" and zoneid = 22 and groupid = 24; -- Was 56-58
UPDATE mob_groups SET minLevel = 60, maxLevel = 60 WHERE name = "Thinker" and zoneid = 22 and groupid = 32; -- Was 56-58

UPDATE mob_groups SET minLevel = 54, maxLevel = 55 WHERE name = "Gorger" and zoneid = 22 and groupid = 9 ; -- Was 52-54
UPDATE mob_groups SET minLevel = 56, maxLevel = 57 WHERE name = "Gorger" and zoneid = 22 and groupid = 17; -- Was 54-56
UPDATE mob_groups SET minLevel = 58, maxLevel = 59 WHERE name = "Gorger" and zoneid = 22 and groupid = 25; -- Was 56-58
UPDATE mob_groups SET minLevel = 60, maxLevel = 60 WHERE name = "Gorger" and zoneid = 22 and groupid = 33; -- Was 56-58

UPDATE mob_groups SET minLevel = 54, maxLevel = 55 WHERE name = "Craver" and zoneid = 22 and groupid = 10; -- Was 52-54
UPDATE mob_groups SET minLevel = 56, maxLevel = 57 WHERE name = "Craver" and zoneid = 22 and groupid = 18; -- Was 52-54
UPDATE mob_groups SET minLevel = 58, maxLevel = 59 WHERE name = "Craver" and zoneid = 22 and groupid = 26; -- Was 56-58
UPDATE mob_groups SET minLevel = 60, maxLevel = 60 WHERE name = "Craver" and zoneid = 22 and groupid = 34; -- Was 56-58

UPDATE mob_groups SET minLevel = 50, maxLevel = 52 WHERE name = "Seether" and zoneid = 22 and groupid = 15; -- Was 52-52
UPDATE mob_groups SET minLevel = 53, maxLevel = 55 WHERE name = "Seether" and zoneid = 22 and groupid = 22; -- Was 54-56
UPDATE mob_groups SET minLevel = 56, maxLevel = 57 WHERE name = "Seether" and zoneid = 22 and groupid = 30; -- Was 54-56
-- ------------------------------------------------------------
-- Lufaise_Meadows (Zone 24)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Flockbock' AND groupid='32' AND zoneid='24';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sengann' AND groupid='79' AND zoneid='24';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Yal-un_Eke' AND groupid='82' AND zoneid='24';

UPDATE mob_groups SET minLevel = 80, maxLevel = 83 WHERE name = "Abraxas" and zoneid = 24;
    -- 79-82
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Ninja"       and zoneid = 24 and groupid = 33;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Monk"        and zoneid = 24 and groupid = 34;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Bard"        and zoneid = 24 and groupid = 36;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Red_Mage"    and zoneid = 24 and groupid = 37;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Samurai"     and zoneid = 24 and groupid = 38;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Warrior"     and zoneid = 24 and groupid = 39;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Paladin"     and zoneid = 24 and groupid = 41;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Dragoon"     and zoneid = 24 and groupid = 42;
UPDATE mob_groups SET minLevel = 72, maxLevel = 74 WHERE name = "Fomors_Wyvern"     and zoneid = 24 and groupid = 43;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Dark_Knight" and zoneid = 24 and groupid = 44;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Black_Mage"  and zoneid = 24 and groupid = 45;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Ranger"      and zoneid = 24 and groupid = 46;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Summoner"    and zoneid = 24 and groupid = 47;
UPDATE mob_groups SET minLevel = 72, maxLevel = 74 WHERE name = "Fomors_Elemental"  and zoneid = 24 and groupid = 48;
UPDATE mob_groups SET minLevel = 79, maxLevel = 82 WHERE name = "Fomor_Beastmaster" and zoneid = 24 and groupid = 49;
UPDATE mob_groups SET minLevel = 72, maxLevel = 74 WHERE name = "Fomors_Bat"        and zoneid = 24 and groupid = 50;
    -- 52-54
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Thief" and zoneid = 24 and groupid = 61;
INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
-- 52-54
(90,1386,24,'Fomor_Ninja',330,1,867,0,0,52,54,0),       -- These are in prep for complete zone revamps
(91,6522,24,'Fomor_Monk',330,1,867,0,0,52,54,0),        -- These are in prep for complete zone revamps
(92,1390,24,'Fomor_Samurai',330,1,877,0,0,52,54,0),     -- These are in prep for complete zone revamps
    -- 42-44
(93,1397,24,'Fomor_Thief',330,1,885,0,0,42,44,0),       -- These are in prep for complete zone revamps
(94,1388,24,'Fomor_Ranger',330,1,0,0,0,42,44,0),        -- These are in prep for complete zone revamps
(95,1398,24,'Fomor_Warrior',330,1,888,0,0,42,44,0),     -- These are in prep for complete zone revamps
(96,1391,24,'Fomor_Summoner',330,1,880,0,0,42,44,0),    -- These are in prep for complete zone revamps
(97,1395,24,'Fomors_Elemental',0,128,0,0,0,34,36,0),    -- These are in prep for complete zone revamps
(98,6517,24,'Fomor_Beastmaster',330,1,858,0,0,42,44,0), -- These are in prep for complete zone revamps
(99,1393,24,'Fomors_Bat',0,128,0,0,0,34,36,0);          -- These are in prep for complete zone revamps

-- ------------------------------------------------------------
-- Misareaux_Coast (Zone 25)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Goaftrap' AND groupid='9' AND zoneid='25';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Okyupete' AND groupid='47' AND zoneid='25';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Seaboard_Vulture' AND groupid='26' AND zoneid='25';

UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Monk"        and zoneid = 25 and groupid = 10;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Samurai"     and zoneid = 25 and groupid = 11;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Warrior"     and zoneid = 25 and groupid = 12;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Thief"       and zoneid = 24 and groupid = 13;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Black_Mage"  and zoneid = 25 and groupid = 17;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Ranger"      and zoneid = 25 and groupid = 18;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Dark_Knight" and zoneid = 25 and groupid = 19;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Ninja"       and zoneid = 25 and groupid = 20;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Paladin"     and zoneid = 25 and groupid = 21;
UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Fomor_Bard"        and zoneid = 25 and groupid = 22;
    -- 49-51
INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(71,1388,25,'Fomor_Ranger',330,1,0,0,0,49,51,0),        -- These are in prep for complete zone revamps
(72,1387,25,'Fomor_Paladin',330,1,855,0,0,49,51,0),     -- These are in prep for complete zone revamps
(73,1383,25,'Fomor_Dark_Knight',330,1,0,0,0,49,51,0),   -- These are in prep for complete zone revamps
(74,1397,25,'Fomor_Thief',330,1,0,0,0,49,51,0),         -- These are in prep for complete zone revamps
(75,1385,25,'Fomor_Monk',330,1,0,0,0,49,51,0),          -- These are in prep for complete zone revamps
(76,1386,25,'Fomor_Ninja',330,1,0,0,0,49,51,0),         -- These are in prep for complete zone revamps
(77,1380,25,'Fomor_Bard',330,1,855,0,0,35,37,0);        -- These are in prep for complete zone revamps
UPDATE mob_groups SET minLevel = 49, maxLevel = 51 WHERE name = "Fomor_Red_Mage"    and zoneid = 25 and groupid = 43;
UPDATE mob_groups SET minLevel = 49, maxLevel = 51 WHERE name = "Fomor_Dragoon"     and zoneid = 25 and groupid = 50;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomors_Wyvern"     and zoneid = 25 and groupid = 51;
UPDATE mob_groups SET minLevel = 49, maxLevel = 51 WHERE name = "Fomor_Summoner"    and zoneid = 25 and groupid = 44;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomors_Elemental"  and zoneid = 25 and groupid = 45;

-- ------------------------------------------------------------
-- Phomiuna_Aqueducts (Zone 27)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Aqueduct_Spider' AND groupid='44' AND zoneid='27';
UPDATE mob_groups SET minLevel = 41, maxLevel = 46 WHERE name = "Fomor_Ninja"       and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Monk"        and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Bard"        and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Red_Mage"    and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Samurai"     and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Warrior"     and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Paladin"     and zoneid = 27;
UPDATE mob_groups SET minLevel = 42, maxLevel = 46 WHERE name = "Fomor_Dragoon"     and zoneid = 27;
UPDATE mob_groups SET minLevel = 41, maxLevel = 46 WHERE name = "Fomors_Wyvern"     and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 46 WHERE name = "Fomor_Dark_Knight" and zoneid = 27;
UPDATE mob_groups SET minLevel = 45, maxLevel = 48 WHERE name = "Fomor_Black_Mage"  and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Ranger"      and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Summoner"    and zoneid = 27;
UPDATE mob_groups SET minLevel = 41, maxLevel = 46 WHERE name = "Fomors_Elemental"  and zoneid = 27;
UPDATE mob_groups SET minLevel = 41, maxLevel = 46 WHERE name = "Fomor_Beastmaster" and zoneid = 27;
UPDATE mob_groups SET minLevel = 41, maxLevel = 46 WHERE name = "Fomors_Bat"        and zoneid = 27;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Fomor_Thief"       and zoneid = 27;
UPDATE mob_groups SET minLevel = 50, maxLevel = 50 WHERE name = "Air_Elemental"     and zoneid = 27;

-- ------------------------------------------------------------
-- Sacrarium (Zone 28)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Aqueduct_Spider' AND groupid='41' AND zoneid='28';

-- ------------------------------------------------------------
-- Riverne-Site_B01 (Zone 29)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Blazedrake' AND groupid='9' AND zoneid='29';

UPDATE mob_groups SET minLevel = 50, maxLevel = 53 WHERE name = "Pyrodrake" and zoneid = 29;
UPDATE mob_groups SET minLevel = 55, maxLevel = 57 WHERE name = "Strato_Hippogryph" and zoneid = 29;

-- ------------------------------------------------------------
-- Riverne-Site_A01 (Zone 30)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Darner' AND groupid='13' AND zoneid='30';

-- ------------------------------------------------------------
-- AlTaieu (Zone 33)
-- ------------------------------------------------------------
UPDATE mob_groups SET minLevel = 70, maxLevel = 71 WHERE name = "Ulxzomit" and zoneid = 33 and groupid = 7; -- Mother is higher level
UPDATE mob_groups SET minLevel = 69, maxLevel = 71 WHERE name = "Aerns_Wynav" and zoneid = 33;
UPDATE mob_groups SET minLevel = 69, maxLevel = 71 WHERE name = "Aerns_Xzomit" and zoneid = 33;
UPDATE mob_groups SET minLevel = 69, maxLevel = 71 WHERE name = "Aerns_Elemental" and zoneid = 33;
UPDATE mob_groups SET minLevel = 75, maxLevel = 77 WHERE name = "Ulphuabo" and zoneid = 33;

-- ------------------------------------------------------------
-- Grand_Palace_of_HuXzoi (Zone 34)
-- ------------------------------------------------------------
UPDATE mob_groups SET minLevel = 74, maxLevel = 76 WHERE name = "Aerns_Elemental" and zoneid = 34;
UPDATE mob_groups SET minLevel = 74, maxLevel = 76 WHERE name = "Aerns_Wynav" and zoneid = 34;
UPDATE mob_groups SET minLevel = 74, maxLevel = 76 WHERE name = "Aerns_Euvhi" and zoneid = 34;

-- ------------------------------------------------------------
-- The_Garden_of_RuHmet (Zone 35)
-- ------------------------------------------------------------
UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Aerns_Elemental" and zoneid = 35;
UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Aerns_Wynav" and zoneid = 35;
UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Aerns_Euvhi" and zoneid = 35;

-- ------------------------------------------------------------
-- Dynamis-Tavnazia (Zone 42)
-- ------------------------------------------------------------
UPDATE mob_groups SET HP = 6000 WHERE name = "Nightmare_Hornet" and zoneid = 42;
UPDATE mob_groups SET HP = 14000 WHERE name = "Nightmare_Bugard" and zoneid = 42;
UPDATE mob_groups SET HP = 7000 WHERE name = "Nightmare_Taurus" and zoneid = 42;
UPDATE mob_groups SET HP = 6000 WHERE name = "Nightmare_Makara" and zoneid = 42;
UPDATE mob_groups SET HP = 12000 WHERE name = "Nightmare_Worm" and zoneid = 42;
UPDATE mob_groups SET HP = 14000 WHERE name = "Nightmare_Antlion" and zoneid = 42;
UPDATE mob_groups SET HP = 6000 WHERE name = "Nightmare_Leech" and zoneid = 42;
UPDATE mob_groups SET HP = 6000 WHERE name = "Nightmare_Cluster" and zoneid = 42;

-- ------------------------------------------------------------
-- Bhaflau_Thickets (Zone 52)
-- ------------------------------------------------------------

-- Locus Mobs
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Colibri' AND groupid='52' AND zoneid='52';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Wivre' AND groupid='53' AND zoneid='52';

-- ------------------------------------------------------------
-- Arrapago_Reef (Zone 54)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ROV' WHERE name='Nirgali' AND groupid='40' AND zoneid='54';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Nostokulshedra' AND groupid='52' AND zoneid='54';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Dweomershell' AND groupid='65' AND zoneid='54';

-- ------------------------------------------------------------
-- Mount_Zhayolm (Zone 61)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Sulphuric_Jagil' AND groupid='9' AND zoneid='61';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Orichalcumshell' AND groupid='33' AND zoneid='61';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Scoriaceous_Eruca' AND groupid='35' AND zoneid='61';

-- ------------------------------------------------------------
-- Mamool_Ja_Training_Grounds (Zone 66)
-- ------------------------------------------------------------

UPDATE mob_groups SET HP='3000', minLevel='70', maxLevel='70' WHERE name='Mamool_Ja_Recruit' AND groupid='14' AND zoneid='66';
UPDATE mob_groups SET HP='3500', minLevel='77', maxLevel='78' WHERE name='Mamool_Ja_Trainer' AND groupid='15' AND zoneid='66';

-- ------------------------------------------------------------
-- Aydeewa_Subterrane (Zone 68)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Mycohopper' AND groupid='16' AND zoneid='68';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Slime_Eater' AND groupid='24' AND zoneid='68';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Deforester' AND groupid='18' AND zoneid='68';

-- ------------------------------------------------------------
-- Alzadaal_Undersea_Ruins (Zone 72)
-- ------------------------------------------------------------

-- Apex mobs for this zone are not captured yet, treat this as a placeholder
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Archaic_Cog' AND groupid='??' AND zoneid='72';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Archaic_Cogs' AND groupid='??' AND zoneid='72';

-- ------------------------------------------------------------
-- Caedarva_Mire (Zone 79)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Slough_Skua' AND groupid='28' AND zoneid='79';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Vauxia_Fly' AND groupid='45' AND zoneid='79';

-- ASB Section (Offset by 100 to avoid merge conflicts)
INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(100,714,79,'Peallaidh_Chigoe',0,0,466,350,0,70,71,0),
(101,714,79,'Karakul_Chigoe',0,0,466,50,0,62,66,0);

-- ------------------------------------------------------------
-- Jugner_Forest_[S] (Zone 82)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Gnoletrap' AND groupid='31' AND zoneid='82';

-- ------------------------------------------------------------
-- Vunkerl_Inlet_[S] (Zone 83)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Duriumshell' AND groupid='5' AND zoneid='83';

-- ------------------------------------------------------------
-- Batallia_Downs_[S] (Zone 84)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Tsetse_Fly' AND groupid='24' AND zoneid='84';

-- ------------------------------------------------------------
-- North_Gustaberg_[S] (Zone 88)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Drachenlizard' AND groupid='44' AND zoneid='88';

-- ------------------------------------------------------------
-- Grauberg_[S] (Zone 89)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Feyweald_Sapling' AND groupid='16' AND zoneid='89';

-- ------------------------------------------------------------
-- Rolanberry_Fields_[S] (Zone 91)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Champion_Crawler' AND groupid='29' AND zoneid='91';

-- ------------------------------------------------------------
-- West_Sarutabaruta_[S] (Zone 95)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Hispid_Rarab' AND groupid='21' AND zoneid='95';

-- ------------------------------------------------------------
-- Meriphataud_Mountains_[S] (Zone 97)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Condor' AND groupid='34' AND zoneid='97';

-- ------------------------------------------------------------
-- Sauromugue_Champaign_[S] (Zone 98)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Gouger_Beetle' AND groupid='8' AND zoneid='98';

-- ------------------------------------------------------------
-- West_Ronfaure (Zone 100)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Amanita' AND groupid='16' AND zoneid='100';

UPDATE mob_groups SET minLevel = 1, maxLevel = 5 WHERE name = "Carrion_Worm"   and zoneid = 100;
UPDATE mob_groups SET minLevel = 1, maxLevel = 5 WHERE name = "Forest_Hare"   and zoneid = 100;
UPDATE mob_groups SET minLevel = 3, maxLevel = 6 WHERE name = "Scarab_Beetle"   and zoneid = 100;

-- ------------------------------------------------------------
-- East_Ronfaure (Zone 101)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Rambukk' AND groupid='20' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='45' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Krabkatoa' AND groupid='46' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yacumama' AND groupid='47' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Capricornus' AND groupid='48' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Quagmire_Pugil' AND groupid='49' AND zoneid='101';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Sunderclaw' AND groupid='50' AND zoneid='101';

UPDATE mob_groups SET minLevel = 1, maxLevel = 5 WHERE name = "Carrion_Worm"   and zoneid = 101;
UPDATE mob_groups SET minLevel = 1, maxLevel = 5 WHERE name = "Forest_Hare"   and zoneid = 101;
UPDATE mob_groups SET minLevel = 3, maxLevel = 6 WHERE name = "Scarab_Beetle"   and zoneid = 101;

-- ------------------------------------------------------------
-- La_Theine_Plateau (Zone 102)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Slumbering_Samwell' AND groupid='37' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='49' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Dawon' AND groupid='50' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Tammuz' AND groupid='51' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Chesma' AND groupid='52' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Void_Hare' AND groupid='53' AND zoneid='102';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Prickly_Sheep' AND groupid='54' AND zoneid='102';

-- ------------------------------------------------------------
-- Valkurm_Dunes (Zone 103)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Metal_Shears' AND groupid='17' AND zoneid='103';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hippomaritimus' AND groupid='29' AND zoneid='103';

UPDATE mob_groups SET minLevel = 15, maxLevel = 18 WHERE name = "Hill_Lizard"   and zoneid = 103;

-- ------------------------------------------------------------
-- Jugner_Forest (Zone 104)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Supplespine_Mujwuj' AND groupid='41' AND zoneid='104';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sappy_Sycamore' AND groupid='43' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='73' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Krabkatoa' AND groupid='74' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yacumama' AND groupid='75' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Capricornus' AND groupid='76' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Quagmire_Pugil' AND groupid='77' AND zoneid='104';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Sunderclaw' AND groupid='78' AND zoneid='104';

-- ------------------------------------------------------------
-- Batallia_Downs (Zone 105)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Skirling_Liger' AND groupid='25' AND zoneid='105';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Eyegouger' AND groupid='38' AND zoneid='105';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Prankster_Maverix' AND groupid='40' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='50' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Verthandi' AND groupid='51' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Urd' AND groupid='52' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Skuld' AND groupid='53' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Aither' AND groupid='54' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Deorc' AND groupid='55' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Eorthe' AND groupid='56' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Puretos' AND groupid='57' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Pruina' AND groupid='58' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Beorht' AND groupid='59' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Thunor' AND groupid='60' AND zoneid='105';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lacus' AND groupid='61' AND zoneid='105';

UPDATE mob_groups SET minLevel = 30, maxLevel = 36 WHERE name = "Goblin_Furrier" and zoneid = 105;
UPDATE mob_groups SET minLevel = 30, maxLevel = 36 WHERE name = "Goblin_Pathfinder" and zoneid = 105;
UPDATE mob_groups SET minLevel = 30, maxLevel = 36 WHERE name = "Goblin_Shaman" and zoneid = 105;
UPDATE mob_groups SET minLevel = 30, maxLevel = 36 WHERE name = "Goblin_Smithy" and zoneid = 105;
UPDATE mob_groups SET minLevel = 28, maxLevel = 30 WHERE name = "Greater_Pugil_fished" and zoneid = 105;
UPDATE mob_groups SET minLevel = 33, maxLevel = 35 WHERE name = "Kraken_fished" and zoneid = 105;

-- ------------------------------------------------------------
-- North_Gustaberg (Zone 106)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bedrock_Barry' AND groupid='26' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='42' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Blobdingnag' AND groupid='43' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Septic_Boil' AND groupid='44' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Shoggoth' AND groupid='45' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lamprey_Lord' AND groupid='46' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Ground_Guzzler' AND groupid='47' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Globster' AND groupid='48' AND zoneid='106';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='42' AND zoneid='106';

UPDATE mob_groups SET minLevel = 2, maxLevel = 5 WHERE name = "Maneating_Hornet"     and zoneid = 106;
UPDATE mob_groups SET minLevel = 2, maxLevel = 5 WHERE name = "Stone_Eater"     and zoneid = 106;
UPDATE mob_groups SET minLevel = 2, maxLevel = 6 WHERE name = "Vulture"     and zoneid = 106;
UPDATE mob_groups SET minLevel = 2, maxLevel = 4 WHERE name = "Sand_Crab"     and zoneid = 106;

-- ------------------------------------------------------------
-- South_Gustaberg (Zone 107)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Tococo' AND groupid='28' AND zoneid='107';

UPDATE mob_groups SET minLevel = 2, maxLevel = 6 WHERE name = "Vulture"     and zoneid = 107;
UPDATE mob_groups SET minLevel = 5, maxLevel = 6 WHERE name = "Land_Crab"   and zoneid = 107;
UPDATE mob_groups SET minLevel = 2, maxLevel = 4 WHERE name = "Sand_Crab"   and zoneid = 107;

-- ------------------------------------------------------------
-- Konschtat_Highlands (Zone 108)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ghillie_Dhu' AND groupid='8' AND zoneid='108';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Highlander_lizard' AND groupid='26' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='38' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Dawon' AND groupid='39' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Tammuz' AND groupid='40' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Chesma' AND groupid='41' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Void_Hare' AND groupid='42' AND zoneid='108';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Prickly_Sheep' AND groupid='43' AND zoneid='108';

UPDATE mob_groups SET minLevel = 7, maxLevel = 10 WHERE name = "Huge_Wasp"   and zoneid = 107;
UPDATE mob_groups SET minLevel = 7, maxLevel = 10 WHERE name = "Strolling_Sapling"   and zoneid = 107;
UPDATE mob_groups SET minLevel = 11, maxLevel = 13 WHERE name = "Mad_Sheep"   and zoneid = 107;

-- ------------------------------------------------------------
-- Pashhow_Marshlands (Zone 109)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='NiZho_Bladebender' AND groupid='28' AND zoneid='109';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Toxic_Tamlyn' AND groupid='38' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='65' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Blobdingnag' AND groupid='66' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Septic_Boil' AND groupid='67' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Shoggoth' AND groupid='68' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lamprey_Lord' AND groupid='69' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Ground_Guzzler' AND groupid='70' AND zoneid='109';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Globster' AND groupid='71' AND zoneid='109';

UPDATE mob_groups SET minLevel = 19, maxLevel = 22 WHERE name = "Thread_Leech"   and zoneid = 109;
UPDATE mob_groups SET minLevel = 16, maxLevel = 26 WHERE name = "Ghoul_war"   and zoneid = 109;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Snipper"   and zoneid = 109;

-- ------------------------------------------------------------
-- Rolanberry_Fields (Zone 110)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ravenous_Crawler' AND groupid='36' AND zoneid='110';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Eldritch_Edge' AND groupid='38' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='45' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Verthandi' AND groupid='46' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Urd' AND groupid='47' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Skuld' AND groupid='48' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Aither' AND groupid='49' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Deorc' AND groupid='50' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Eorthe' AND groupid='51' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Puretos' AND groupid='52' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Pruina' AND groupid='53' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Beorht' AND groupid='54' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Thunor' AND groupid='55' AND zoneid='110';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lacus' AND groupid='56' AND zoneid='110';

UPDATE mob_groups SET minLevel = 28, maxLevel = 30 WHERE name = "Greater_Pugil_fished"   and zoneid = 110;
UPDATE mob_groups SET minLevel = 31, maxLevel = 33 WHERE name = "Big_Leech"   and zoneid = 110;

-- ------------------------------------------------------------
-- Beaucedine_Glacier (Zone 111)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Humbaba' AND groupid='32' AND zoneid='111';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Calcabrina' AND groupid='33' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='52' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lord_Ruthven' AND groupid='53' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Feuerunke' AND groupid='54' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Erebus' AND groupid='55' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Gjenganger' AND groupid='56' AND zoneid='111';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Gorehound' AND groupid='57' AND zoneid='111';

UPDATE mob_groups SET minLevel = 35, maxLevel = 40 WHERE name = "Ghast_war"  and zoneid = 111;
UPDATE mob_groups SET minLevel = 35, maxLevel = 40 WHERE name = "Ghast_blm"  and zoneid = 111;
UPDATE mob_groups SET minLevel = 38, maxLevel = 40 WHERE name = "Apsaras"  and zoneid = 111;
UPDATE mob_groups SET minLevel = 41, maxLevel = 42 WHERE name = "Morgawr"  and zoneid = 111;

-- ------------------------------------------------------------
-- Xarcabard (Zone 112)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Barbaric_Weapon' AND groupid='11' AND zoneid='112';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Duke_Focalor' AND groupid='21' AND zoneid='112';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Timeworn_Warrior' AND groupid='12' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='48' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lord_Ruthven' AND groupid='49' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Feuerunke' AND groupid='50' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Erebus' AND groupid='51' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Gjenganger' AND groupid='52' AND zoneid='112';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Gorehound' AND groupid='53' AND zoneid='112';

UPDATE mob_groups SET minLevel = 38, maxLevel = 40 WHERE name = "Gigass_Tiger"  and zoneid = 112 and groupid = 17;

-- ------------------------------------------------------------
-- Cape_Teriggan (Zone 113)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Killer_Jonny' AND groupid='20' AND zoneid='113';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Tegmine' AND groupid='23' AND zoneid='113';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Zmey_Gorynych' AND groupid='24' AND zoneid='113';

-- ------------------------------------------------------------
-- Eastern_Altepa_Desert (Zone 114)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Donnergugi' AND groupid='16' AND zoneid='114';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Nandi' AND groupid='34' AND zoneid='114';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Sabotender_Corrido' AND groupid='25' AND zoneid='114';

UPDATE mob_groups SET minLevel = 40, maxLevel = 41 WHERE name = "Makara_fished"  and zoneid = 114;
UPDATE mob_groups SET minLevel = 42, maxLevel = 45 WHERE name = "Bigclaw_fished" and zoneid = 114;

-- ------------------------------------------------------------
-- West_Sarutabaruta (Zone 115)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Numbing_Norman' AND groupid='27' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='36' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Orcus' AND groupid='37' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Farruca_Fly' AND groupid='38' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Jyeshtha' AND groupid='39' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Rummager_Beetle' AND groupid='40' AND zoneid='115';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Raker_Bee' AND groupid='41' AND zoneid='115';

UPDATE mob_groups SET minLevel = 4, maxLevel = 8 WHERE name = "Yagudo_Initiate" and zoneid = 115;
UPDATE mob_groups SET minLevel = 4, maxLevel = 8 WHERE name = "Yagudo_Acolyte" and zoneid = 115;
UPDATE mob_groups SET minLevel = 4, maxLevel = 8 WHERE name = "Yagudo_Scribe" and zoneid = 115;
UPDATE mob_groups SET minLevel = 6, maxLevel = 8 WHERE name = "Crawler" and zoneid = 115 and groupid = 22;

-- ------------------------------------------------------------
-- East_Sarutabaruta (Zone 116)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Duke_Decapod' AND groupid='25' AND zoneid='116';

UPDATE mob_groups SET minLevel = 1, maxLevel = 5 WHERE name = "Savanna_Rarab" and zoneid = 116;
UPDATE mob_groups SET minLevel = 3, maxLevel = 8 WHERE name = "Yagudo_Initiate" and zoneid = 116;
UPDATE mob_groups SET minLevel = 3, maxLevel = 8 WHERE name = "Yagudo_Acolyte" and zoneid = 116;
UPDATE mob_groups SET minLevel = 3, maxLevel = 8 WHERE name = "Yagudo_Scribe" and zoneid = 116;
UPDATE mob_groups SET minLevel = 7, maxLevel = 8 WHERE name = "Pug_Pugil_fished" and zoneid = 116;

-- ------------------------------------------------------------
-- Tahrongi_Canyon (Zone 117)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Habrok' AND groupid='8' AND zoneid='117';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Herbage_Hunter' AND groupid='30' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='36' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Dawon' AND groupid='37' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Tammuz' AND groupid='38' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Chesma' AND groupid='39' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Void_Hare' AND groupid='40' AND zoneid='117';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Prickly_Sheep' AND groupid='41' AND zoneid='117';

UPDATE mob_groups SET minLevel = 5, maxLevel = 7  WHERE name = "Yagudos_Elemental"  and zoneid = 117;
UPDATE mob_groups SET minLevel = 7, maxLevel = 10 WHERE name = "Canyon_Rarab"       and zoneid = 117;
UPDATE mob_groups SET minLevel = 7, maxLevel = 10 WHERE name = "Strolling_Sapling"  and zoneid = 117;
UPDATE mob_groups SET minLevel = 8, maxLevel = 10 WHERE name = "Killer_Bee"         and zoneid = 117;
UPDATE mob_groups SET minLevel = 8, maxLevel = 10 WHERE name = "Barghest"           and zoneid = 117;

-- ------------------------------------------------------------
-- Buburimu_Peninsula (Zone 118)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Wake_Warder_Wanda' AND groupid='22' AND zoneid='118';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Backoo' AND groupid='55' AND zoneid='118';

UPDATE mob_groups SET minLevel = 15, maxLevel = 18 WHERE name = "Sylvestre"       and zoneid = 118;
UPDATE mob_groups SET minLevel = 20, maxLevel = 10 WHERE name = "Snipper"         and zoneid = 118;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Snipper_fished"  and zoneid = 118;
UPDATE mob_groups SET minLevel = 24, maxLevel = 26 WHERE name = "Clipper_fished"  and zoneid = 118;
UPDATE mob_groups SET minLevel = 24, maxLevel = 26 WHERE name = "Shoal_Pugil_fished"  and zoneid = 118;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Zu"  and zoneid = 118;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Bull_Dhalmel"  and zoneid = 118;

-- ------------------------------------------------------------
-- Meriphataud_Mountains (Zone 119)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Chonchon' AND groupid='19' AND zoneid='119';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Naa_Zeku_the_Unwaiting' AND groupid='29' AND zoneid='119';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Patripatan' AND groupid='37' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='64' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Orcus' AND groupid='65' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Farruca_Fly' AND groupid='66' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Jyeshtha' AND groupid='67' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Rummager_Beetle' AND groupid='68' AND zoneid='119';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Raker_Bee' AND groupid='69' AND zoneid='119';

UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Yagudos_Elemental"  and zoneid = 119 and groupid = 23;
UPDATE mob_groups SET minLevel = 22, maxLevel = 25 WHERE name = "Coeurl"  and zoneid = 119;

-- ------------------------------------------------------------
-- Sauromugue_Champaign (Zone 120)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bashe' AND groupid='68' AND zoneid='120';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Thunderclaw_Thuban' AND groupid='33' AND zoneid='120';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Blighting_Brand' AND groupid='38' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Yilbegan' AND groupid='46' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Verthandi' AND groupid='47' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Urd' AND groupid='48' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Skuld' AND groupid='49' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Aither' AND groupid='50' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Deorc' AND groupid='51' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Eorthe' AND groupid='52' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Puretos' AND groupid='53' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Pruina' AND groupid='54' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Beorht' AND groupid='55' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Thunor' AND groupid='56' AND zoneid='120';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Lacus' AND groupid='57' AND zoneid='120';

UPDATE mob_groups SET minLevel = 23, maxLevel = 25 WHERE name = "Goblins_Beetle"  and zoneid = 120;
UPDATE mob_groups SET minLevel = 23, maxLevel = 25 WHERE name = "Yagudos_Elemental"  and zoneid = 120;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Midnight_Wings"  and zoneid = 120;
UPDATE mob_groups SET minLevel = 30, maxLevel = 34 WHERE name = "Cutter_fished"  and zoneid = 120;
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Kraken_fished"  and zoneid = 120;

-- ------------------------------------------------------------
-- The_Sanctuary_of_ZiTah (Zone 121)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Elusive_Edwin' AND groupid='15' AND zoneid='121';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Huwasi' AND groupid='20' AND zoneid='121';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bastet' AND groupid='34' AND zoneid='121';
UPDATE mob_groups SET content_tag='VOIDWATCH' WHERE name='Grwnan' AND groupid='58' AND zoneid='121';

UPDATE mob_groups SET minLevel = 38, maxLevel = 41 WHERE name = "Bigclaw_fished"  and zoneid = 121;
UPDATE mob_groups SET minLevel = 42, maxLevel = 45 WHERE name = "Apsaras"  and zoneid = 121;

-- ------------------------------------------------------------
-- RoMaeve (Zone 122)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Rogue_Receptacle' AND groupid='15' AND zoneid='122';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Martinet' AND groupid='12' AND zoneid='122';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Nargun' AND groupid='16' AND zoneid='122';

-- ------------------------------------------------------------
-- Yuhtunga_Jungle (Zone 123)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Koropokkur' AND groupid='9' AND zoneid='123';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Pyuu_the_Spatemaker' AND groupid='25' AND zoneid='123';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bayawak' AND groupid='30' AND zoneid='123';

UPDATE mob_groups SET minLevel = 30, maxLevel = 33 WHERE name = "Yuhtunga_Mandragora"  and zoneid = 123;
UPDATE mob_groups SET minLevel = 47, maxLevel = 49 WHERE name = "Bloodsucker_fished"  and zoneid = 123;

-- ------------------------------------------------------------
-- Yhoator_Jungle (Zone 124)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Powderer_Penny' AND groupid='25' AND zoneid='124';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Acolnahuacatl' AND groupid='27' AND zoneid='124';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hoar-knuckled_Rimberry' AND groupid='32' AND zoneid='124';

UPDATE mob_groups SET minLevel = 36, maxLevel = 38 WHERE name = "Vepar"  and zoneid = 124;
UPDATE mob_groups SET minLevel = 39, maxLevel = 41 WHERE name = "Makara_fished"  and zoneid = 124;

-- ------------------------------------------------------------
-- Western_Altepa_Desert (Zone 125)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Calchas' AND groupid='23' AND zoneid='125';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Dahu' AND groupid='37' AND zoneid='125';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Picolaton' AND groupid='38' AND zoneid='125';

UPDATE mob_groups SET minLevel = 45, maxLevel = 47 WHERE name = "Bigclaw_fished"  and zoneid = 125;
UPDATE mob_groups SET minLevel = 50, maxLevel = 52 WHERE name = "Razorjaw_Pugil_fished"  and zoneid = 125;

-- ------------------------------------------------------------
-- Qufim_Island (Zone 126)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Slippery_Sucker' AND groupid='23' AND zoneid='126';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Qoofim' AND groupid='28' AND zoneid='126';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Atkorkamuy' AND groupid='25' AND zoneid='126';

UPDATE mob_groups SET minLevel = 21, maxLevel = 23 WHERE name = "Gigass_Leech"  and zoneid = 126 and groupid = 15;
UPDATE mob_groups SET minLevel = 28, maxLevel = 30 WHERE name = "Giant_Ranger"  and zoneid = 126;
UPDATE mob_groups SET minLevel = 28, maxLevel = 30 WHERE name = "Giant_Ascetic"  and zoneid = 126;
UPDATE mob_groups SET minLevel = 28, maxLevel = 30 WHERE name = "Giant_Trapper"  and zoneid = 126;
UPDATE mob_groups SET minLevel = 28, maxLevel = 30 WHERE name = "Giant_Hunter"  and zoneid = 126;

-- ------------------------------------------------------------
-- Castle_Zvahl_Baileys_[S] (Zone 138)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Soulsearer_Demon' AND groupid='37' AND zoneid='138';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Woebringer_Demon' AND groupid='39' AND zoneid='138';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Foredoomer_Demon' AND groupid='40' AND zoneid='138';

-- ------------------------------------------------------------
-- Fort_Ghelsba (Zone 141)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Kegpaunch_Doshgnosh' AND groupid='20' AND zoneid='141';

UPDATE mob_groups SET minLevel = 21, maxLevel = 21 WHERE name = "Orcish_Cursemaker"  and zoneid = 141;
UPDATE mob_groups SET minLevel = 21, maxLevel = 21 WHERE name = "Orcish_Fighter"  and zoneid = 141;
UPDATE mob_groups SET minLevel = 21, maxLevel = 21 WHERE name = "Orcish_Serjeant"  and zoneid = 141;

-- ------------------------------------------------------------
-- Palborough_Mines (Zone 143)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='QuVho_Deathhurler' AND groupid='10' AND zoneid='143';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='BeHya_Hundredwall' AND groupid='22' AND zoneid='143';

-- ------------------------------------------------------------
-- Giddeus (Zone 145)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Quu_Xijo_the_Illusory' AND groupid='20' AND zoneid='145';

-- ------------------------------------------------------------
-- Castle_Oztroja (Zone 151)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Saa_Doyi_the_Fervid' AND groupid='5' AND zoneid='151';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Lii_Jixa_the_Somnolist' AND groupid='21' AND zoneid='151';

UPDATE mob_groups SET minLevel = 23, maxLevel = 27 WHERE name = "Yagudo_Theologist"  and zoneid = 151;
UPDATE mob_groups SET minLevel = 22, maxLevel = 28 WHERE name = "Yagudo_Priest"  and zoneid = 151;
UPDATE mob_groups SET minLevel = 44, maxLevel = 48 WHERE name = "Yagudo_Lutenist"  and zoneid = 151;
UPDATE mob_groups SET minLevel = 52, maxLevel = 56 WHERE name = "Yagudo_Sentinel"  and zoneid = 151;
UPDATE mob_groups SET minLevel = 55, maxLevel = 59 WHERE name = "Yagudo_Abbot"  and zoneid = 151;
UPDATE mob_groups SET minLevel = 70, maxLevel = 72 WHERE name = "Yagudo_Flagellant"  and zoneid = 151 and groupid = 44;
UPDATE mob_groups SET minLevel = 70, maxLevel = 72 WHERE name = "Yagudo_Prelate"  and zoneid = 151 and groupid = 45;
UPDATE mob_groups SET minLevel = 70, maxLevel = 72 WHERE name = "Yagudo_Conductor"  and zoneid = 151 and groupid = 46;

-- ------------------------------------------------------------
-- The_Boyahda_Tree (Zone 153)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Mourning_Crawler' AND groupid='25' AND zoneid='153';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Snaggletooth_Peapuk' AND groupid='26' AND zoneid='153';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Viseclaw' AND groupid='27' AND zoneid='153';

UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Bark_Tarantula"  and zoneid = 153;

-- ------------------------------------------------------------
-- Dragons_Aery (Zone 154)
-- ------------------------------------------------------------
UPDATE mob_groups SET minLevel = 76, maxLevel = 79 WHERE name = "Demonic_Rose"  and zoneid = 151;

-- ------------------------------------------------------------
-- Upper_Delkfutts_Tower (Zone 158)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Autarch' AND groupid='25' AND zoneid='158';

-- ------------------------------------------------------------
-- Temple_of_Uggalepih (Zone 159)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel = 61, maxLevel = 67 WHERE name = "Tonberry_Dismayer"  and zoneid = 159;
UPDATE mob_groups SET minLevel = 61, maxLevel = 67 WHERE name = "Tonberry_Maledictor"  and zoneid = 159;
UPDATE mob_groups SET minLevel = 61, maxLevel = 67 WHERE name = "Tonberry_Pursuer"  and zoneid = 159;
UPDATE mob_groups SET minLevel = 61, maxLevel = 67 WHERE name = "Tonberry_Stabber"  and zoneid = 159;

-- ------------------------------------------------------------
-- Den_of_Rancor (Zone 160)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel = 53, maxLevel = 55 WHERE name = "Tonberrys_Elemental"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 62, maxLevel = 72 WHERE name = "Tonberry_Imprecator"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 62, maxLevel = 72 WHERE name = "Tonberry_Trailer"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 66, maxLevel = 72 WHERE name = "Tonberry_Beleaguerer"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Doom_Toad"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Tormentor"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 64, maxLevel = 67 WHERE name = "Mousse"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 63, maxLevel = 70 WHERE name = "Mousse_fished"  and zoneid = 160;
UPDATE mob_groups SET minLevel = 65, maxLevel = 68 WHERE name = "Succubus_Bats"  and zoneid = 160;

-- ------------------------------------------------------------
-- Castle_Zvahl_Baileys (Zone 161)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Likho' AND groupid='7' AND zoneid='161';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Marquis_Naberius' AND groupid='36' AND zoneid='161';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Marquis_Sabnock' AND groupid='37' AND zoneid='161';

UPDATE mob_groups SET minLevel = 48, maxLevel = 50 WHERE name = "Demons_Elemental"  and zoneid = 161 and groupid = 18;
UPDATE mob_groups SET minLevel = 59, maxLevel = 61 WHERE name = "Demons_Elemental"  and zoneid = 161 and groupid = 54;

-- ------------------------------------------------------------
-- Castle_Zvahl_Keep (Zone 162)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel = 45, maxLevel = 47 WHERE name = "Demons_Elemental"  and zoneid = 162;

-- ------------------------------------------------------------
-- Ranguemont_Pass (Zone 166)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Hovering_Oculus' AND groupid='20' AND zoneid='166';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Bilesucker' AND groupid='21' AND zoneid='166';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Hoodoo' AND groupid='22' AND zoneid='166';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Artificer' AND groupid='23' AND zoneid='166';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Tanner' AND groupid='24' AND zoneid='166';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Chaser' AND groupid='25' AND zoneid='166';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblins_Bats' AND groupid='26' AND zoneid='166';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Gloom_Eye' AND groupid='13' AND zoneid='166';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Mucoid_Mass' AND groupid='19' AND zoneid='166';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hyakume' AND groupid='31' AND zoneid='166';

UPDATE mob_groups SET minLevel = 25, maxLevel = 27 WHERE name = "Goblins_Bats"  and zoneid = 166;
INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(41,1665,166,'Goblin_Furrier',960,0,1071,0,0,32,36,0),      -- These are in prep for complete zone revamps
(42,1694,166,'Goblin_Pathfinder',960,0,1131,0,0,32,36,0),   -- These are in prep for complete zone revamps
(43,1710,166,'Goblin_Shaman',960,0,1152,0,0,32,36,0),       -- These are in prep for complete zone revamps
(44,1715,166,'Goblin_Smithy',960,0,1163,0,0,32,36,0),       -- These are in prep for complete zone revamps
(45,6606,166,'Floating_Eye',960,0,850,0,0,34,36,0);         -- These are in prep for complete zone revamps

-- ------------------------------------------------------------
-- Bostaunieux_Oubliette (Zone 167)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Blind_Bat' AND groupid='15' AND zoneid='167';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Panna_Cotta' AND groupid='16' AND zoneid='167';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Nachtmahr' AND groupid='17' AND zoneid='167';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Dabilla' AND groupid='18' AND zoneid='167';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Wurdalak' AND groupid='19' AND zoneid='167';

UPDATE mob_groups SET minLevel = 52, maxLevel = 58 WHERE name = "Bloodsucker_fished"  and zoneid = 167;

-- ------------------------------------------------------------
-- Toraimarai_Canal (Zone 169)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Brazen_Bones' AND groupid='40' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Blackwater_Pugil' AND groupid='24' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Plunderer_Crab' AND groupid='25' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Deviling_Bats' AND groupid='28' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Sodden_Bones' AND groupid='29' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Drowned_Bones' AND groupid='30' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Starborer' AND groupid='31' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Rapier_Scorpion' AND groupid='32' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Poroggo_Excavator' AND groupid='35' AND zoneid='169';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Flume_Toad' AND groupid='36' AND zoneid='169';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Canal_Moocher' AND groupid='21' AND zoneid='169';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Konjac' AND groupid='27' AND zoneid='169';

INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (50,871,169,'Cutlass_Scorpion',960,0,551,0,0,64,66,0); -- These are in prep for complete zone revamps
INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (51,3803,169,'Canal_Pugil',960,0,2033,0,0,57,59,0); -- These are in prep for complete zone revamps
UPDATE mob_groups SET minLevel = 45, maxLevel = 47 WHERE name = "Bigclaw_fished"  and zoneid = 169;
UPDATE mob_groups SET minLevel = 59, maxLevel = 61 WHERE name = "Bloodsucker_fished"  and zoneid = 169;
UPDATE mob_groups SET minLevel = 65, maxLevel = 67 WHERE name = "Mousse_fished"  and zoneid = 169;

-- ------------------------------------------------------------
-- Crawlers_Nest_[S] (Zone 171)
-- ------------------------------------------------------------

-- The below should be treated as placeholders until the zones are captured
-- Apex Mobs
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Nest_Elytra' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Blazer_Elytra' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Helm_Elytra' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Doom_Scorpion' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Lugcrawler_Hunter' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Hornfly' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Dragonfly' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Worker_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Soldier_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Rumble_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Knight_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Mycelar' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Fire_Elemental' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Apex_Water_Elemental' AND groupid='??' AND zoneid='171';

-- Locus Mobs
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Nest_Elytra' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Blazer_Elytra' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Hornfly' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Dragonfly' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Worker_Lugcrawler' AND groupid='??' AND zoneid='171';
-- UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Soldier_Lugcrawler' AND groupid='??' AND zoneid='171';

-- ------------------------------------------------------------
-- Zeruhn_Mines (Zone 172)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Burrower_Worm' AND groupid='2' AND zoneid='172';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Colliery_Bat' AND groupid='3' AND zoneid='172';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Soot_Crab' AND groupid='4' AND zoneid='172';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Veindigger_Leech' AND groupid='6' AND zoneid='172';

INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(20,4053,172,'Tunnel_Worm',330,0,2501,0,0,1,3,0), -- These are in prep for complete zone revamps
(21,2763,172, 'Mouse_Bat',330,0,1747,0,0,2,4,0),  -- These are in prep for complete zone revamps
(22,2385,172,'Leech',330,0,963,0,0,3,5,0);        -- These are in prep for complete zone revamps

-- ------------------------------------------------------------
-- Korroloka_Tunnel (Zone 173)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Lacerator' AND groupid='18' AND zoneid='173';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Spool_Leech' AND groupid='19' AND zoneid='173';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Thoon' AND groupid='27' AND zoneid='173';
UPDATE mob_groups SET dropid = 567 WHERE name='Jelly' AND zoneid = 173;

UPDATE mob_groups SET minLevel = 30, maxLevel = 33 WHERE name = "Greater_Pugil"  and zoneid = 173;
INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (40,3500,173,'Scimitar_Scorpion',480,0,6040,0,0,34,37,0); -- These are in prep for complete zone revamps

-- ------------------------------------------------------------
-- Kuftal_Tunnel (Zone 174)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Kuftal_Delver' AND groupid='22' AND zoneid='174';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Machairodus' AND groupid='19' AND zoneid='174';

UPDATE mob_groups SET minLevel = 68, maxLevel = 70 WHERE name = "Fire_Elemental"  and zoneid = 174;

-- ------------------------------------------------------------
-- The_Shrine_of_RuAvitau (Zone 178)
-- ------------------------------------------------------------
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Baelfyr' AND groupid='19' AND zoneid='178';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Gefyrst' AND groupid='20' AND zoneid='178';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Ungeweder' AND groupid='21' AND zoneid='178';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Byrgen' AND groupid='22' AND zoneid='178';

UPDATE mob_groups SET minLevel = 72, maxLevel = 73 WHERE name = "Water_Elemental"  and zoneid = 178;

-- ------------------------------------------------------------
-- Lower_Delkfutts_Tower (Zone 184)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='WOTG' WHERE name='Tyrant' AND groupid='14' AND zoneid='184';

-- ------------------------------------------------------------
-- King_Ranperres_Tomb (Zone 190)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Ogre_Bat' AND groupid='27' AND zoneid='190';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Bonnet_Beetle' AND groupid='36' AND zoneid='190';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Gwyllgi' AND groupid='17' AND zoneid='190';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ankou' AND groupid='21' AND zoneid='190';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Barbastelle' AND groupid='22' AND zoneid='190';

UPDATE mob_groups SET spawntype = 0 WHERE name = "Nachzehrer_war"  and zoneid = 190;
UPDATE mob_groups SET spawntype = 0 WHERE name = "Nachzehrer_blm"  and zoneid = 190;

INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(60,3946,190,'Tomb_Worm',660,0,429,0,0,60,62,0),        -- These are in prep for complete zone revamps
(61,6456,190,'Dire_Bat',660,0,6041,0, 0,62,64,0),       -- These are in prep for complete zone revamps
(62,871,190,'Cutlass_Scorpion',660,0,6042,0,0,63,65,0), -- These are in prep for complete zone revamps
(63,244,190,'Armet_Beetle',660,0,169,0,0,64,66,0),      -- These are in prep for complete zone revamps
(64,20015,190,'Thousand_Eyes',960,0,2402,0,0,60,62,0),  -- These are in prep for complete zone revamps
(65,1898,190,'Hati',960,0,1278,0,0,77,79,0),            -- These are in prep for complete zone revamps
(66,20014,190,'Lemures',960,0,1506,0,0,80,80,0);        -- These are in prep for complete zone revamps

-- Locus Mobs
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Tomb_Worm' AND groupid='26' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Dire_Bat' AND groupid='27' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Cutlass_Scorpion' AND groupid='28' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Thousand_Eyes' AND groupid='29' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Lemures' AND groupid='33' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Armet_Beetle' AND groupid='36' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Hati' AND groupid='48' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Spartoi_Sorcerer' AND groupid='50' AND zoneid='190';
UPDATE mob_groups SET content_tag='ROV' WHERE name='Locus_Spartoi_Warrior' AND groupid='49' AND zoneid='190';

-- ------------------------------------------------------------
-- Dangruf_Wadi (Zone 191)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Brigand' AND groupid='19' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Headsman' AND groupid='20' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Healer' AND groupid='21' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Witchetty_Grub' AND groupid='22' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Couloir_Leech' AND groupid='23' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Prim_Pika' AND groupid='24' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Natty_Gibbon' AND groupid='25' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Trimmer' AND groupid='26' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Fume_Lizard' AND groupid='27' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Conjurer' AND groupid='28' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Bladesmith' AND groupid='29' AND zoneid='191';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Bushwhacker' AND groupid='30' AND zoneid='191';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Teporingo' AND groupid='10' AND zoneid='191';

INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(40,3772,191,'Stickpin',330,0,6043,0,0,7,9,0),           -- These are in prep for complete zone revamps
(41,1527,191,'Giant_Grub',330,0,2341,0,0,9,12,0),       -- These are in prep for complete zone revamps
(42,1666,191,'Goblin_Gambler',330,0,1119,0,0,21,23,0),  -- These are in prep for complete zone revamps
(43,1683,191,'Goblin_Leecher',330,0,1107,0,0,21,23,0),  -- These are in prep for complete zone revamps
(44,1690,191,'Goblin_Mugger',330,0,1117,0,0,21,23,0),   -- These are in prep for complete zone revamps
(45,5733,191,'Snipper',330,0,2283,0,0,16,20,0);         -- These are in prep for complete zone revamps
UPDATE mob_groups SET minLevel = 15, maxLevel = 17 WHERE name = "Wadi_Leech_fished"  and zoneid = 191;
UPDATE mob_groups SET minLevel = 80, maxLevel = 80 WHERE name = "Lemures"  and zoneid = 190;

-- ------------------------------------------------------------
-- Inner_Horutoto_Ruins (Zone 192)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Troika_Bats' AND groupid='6' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Deathwatch_Beetle' AND groupid='7' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Flesher' AND groupid='8' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Metallurgist' AND groupid='9' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Lurcher' AND groupid='10' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Skinnymalinks' AND groupid='11' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Skinnymajinx' AND groupid='12' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Covin_Bat' AND groupid='13' AND zoneid='192';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Goblin_Trailblazer' AND groupid='14' AND zoneid='192';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Nocuous_Weapon' AND groupid='25' AND zoneid='192';

INSERT INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES
(42,1635,192,'Goblin_Ambusher',330,0,1018,0,0,14,18,0),  -- These are in prep for complete zone revamps
(43,1643,192,'Goblin_Butcher',330,0,1035,0,0,14,18,0),   -- These are in prep for complete zone revamps
(44,1738,192,'Goblin_Tinkerer',330,0,1035,0,0,14,18,0),  -- These are in prep for complete zone revamps
(45,382,192,'Beady_Beetle',330,0,250,0,0,11,16,0),       -- These are in prep for complete zone revamps
(46,373,192,'Bat_Battalion',330,0,241,0,0,12,15,0);      -- These are in prep for complete zone revamps

-- ------------------------------------------------------------
-- Ordelles_Caves (Zone 193)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Buds_Bunny' AND groupid='18' AND zoneid='193';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Bilis_Leech' AND groupid='19' AND zoneid='193';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Swagger_Spruce' AND groupid='24' AND zoneid='193';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Targe_Beetle' AND groupid='25' AND zoneid='193';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Donggu' AND groupid='14' AND zoneid='193';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Agar_Agar' AND groupid='23' AND zoneid='193';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Bombast' AND groupid='44' AND zoneid='193';

UPDATE mob_groups SET minLevel = 21, maxLevel = 22 WHERE name = "Thread_Leech_fished"  and zoneid = 193;
UPDATE mob_groups SET minLevel = 27, maxLevel = 29 WHERE name = "Poison_Leech_fished"  and zoneid = 193;

-- ------------------------------------------------------------
-- Outer_Horutoto_Ruins (Zone 194)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Fetor_Bats' AND groupid='8' AND zoneid='194';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Fuligo' AND groupid='9' AND zoneid='194';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Thorn_Bat' AND groupid='14' AND zoneid='194';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Desmodont' AND groupid='5' AND zoneid='194';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Legalox_Heftyhind' AND groupid='7' AND zoneid='194';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Ah_Puch' AND groupid='13' AND zoneid='194';

-- ------------------------------------------------------------
-- The_Eldieme_Necropolis (Zone 195)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Hellbound_Warrior' AND groupid='15' AND zoneid='195';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Hellbound_Warlock' AND groupid='16' AND zoneid='195';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Nekros_Hound' AND groupid='32' AND zoneid='195';
UPDATE mob_groups SET content_tag='COP' WHERE name='Namorodo' AND groupid='56' AND zoneid='195';

-- ------------------------------------------------------------
-- Gusgen_Mines (Zone 196)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Accursed_Soldier' AND groupid='23' AND zoneid='196';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Accursed_Sorcerer' AND groupid='24' AND zoneid='196';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Madfly' AND groupid='25' AND zoneid='196';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Rockmill' AND groupid='26' AND zoneid='196';

UPDATE mob_groups SET minLevel = 25, maxLevel = 27 WHERE name = "Greater_Pugil_fished"  and zoneid = 196;
UPDATE mob_groups SET minLevel = 20, maxLevel = 24 WHERE name = "Ghoul_war"  and zoneid = 196;
UPDATE mob_groups SET minLevel = 23, maxLevel = 27 WHERE name = "Ghoul_blm"  and zoneid = 196;

-- ------------------------------------------------------------
-- Crawlers_Nest (Zone 197)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='47',maxLevel='49' WHERE name='King_Crawler' AND groupid='16' AND zoneid='197'; -- Renamer: Soldier Crawler
UPDATE mob_groups SET minLevel='55',maxLevel='57',content_tag='ABYSSEA' WHERE name='Vespo' AND groupid='17' AND zoneid='197';
UPDATE mob_groups SET minLevel='50',maxLevel='53' WHERE name='Dancing_Jewel' AND groupid='18' AND zoneid='197';-- Renamer: Hornfly
UPDATE mob_groups SET minLevel='51',maxLevel='54',content_tag='ABYSSEA' WHERE name='Olid_Funguar' AND groupid='19' AND zoneid='197';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Dynast_Beetle' AND groupid='23' AND zoneid='197';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Aqrabuamelu' AND groupid='36' AND zoneid='197';

-- ------------------------------------------------------------
-- Maze_of_Shakhrami (Zone 198)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Bleeder_Leech' AND groupid='18' AND zoneid='198';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Chaser_Bats' AND groupid='21' AND zoneid='198';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Crypterpillar' AND groupid='22' AND zoneid='198';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Warren_Bat' AND groupid='23' AND zoneid='198';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Trembler_Tabitha' AND groupid='9' AND zoneid='198';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Gloombound_Lurker' AND groupid='26' AND zoneid='198';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Lesath' AND groupid='31' AND zoneid='198';

UPDATE mob_groups SET minLevel = 31, maxLevel = 34 WHERE name = "Goblin_Shaman"  and zoneid = 198;

-- ------------------------------------------------------------
-- Garlaige_Citadel (Zone 200)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Fortalice_Bats' AND groupid='15' AND zoneid='200';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Kaboom' AND groupid='29' AND zoneid='200';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Warden_Beetle' AND groupid='35' AND zoneid='200';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Donjon_Bat' AND groupid='40' AND zoneid='200';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hazmat' AND groupid='17' AND zoneid='200';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Hovering_Hotpot' AND groupid='34' AND zoneid='200';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Frogamander' AND groupid='39' AND zoneid='200';

-- ------------------------------------------------------------
-- FeiYin (Zone 204)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Wekufe' AND groupid='16' AND zoneid='204';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Sentient_Carafe' AND groupid='17' AND zoneid='204';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Balayang' AND groupid='18' AND zoneid='204';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Mind_Hoarder' AND groupid='11' AND zoneid='204';
UPDATE mob_groups SET content_tag='WOTG' WHERE name='Sluagh' AND groupid='5' AND zoneid='204';
UPDATE mob_groups SET content_tag='SYNERGY' WHERE name='Jenglot' AND groupid='7' AND zoneid='204';

UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Camazotz"  and zoneid = 204;

-- ------------------------------------------------------------
-- Ifrits_Cauldron (Zone 205)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel = 60, maxLevel = 63 WHERE name = "Dire_Bat"  and zoneid = 205;

-- ------------------------------------------------------------
-- Quicksand_Caves (Zone 208)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel = 65, maxLevel = 68 WHERE name = "Sand_Tarantula"  and zoneid = 208;

-- ------------------------------------------------------------
-- Gustav_Tunnel (Zone 212)
-- ------------------------------------------------------------

UPDATE mob_groups SET spawntype='128',content_tag='ABYSSEA' WHERE name='Boulder_Eater' AND groupid='31' AND zoneid='212';
UPDATE mob_groups SET spawntype='128',content_tag='ABYSSEA' WHERE name='Pygmytoise' AND groupid='32' AND zoneid='212';

-- ------------------------------------------------------------
-- Labyrinth_of_Onzozo (Zone 213)
-- ------------------------------------------------------------

UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Babaulas' AND groupid='31' AND zoneid='213';
UPDATE mob_groups SET content_tag='ABYSSEA' WHERE name='Boribaba' AND groupid='32' AND zoneid='213';

UNLOCK TABLES;
