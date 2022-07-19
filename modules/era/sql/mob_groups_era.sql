-- ---------------------------------------------------------------------------
--  Notes: Reverts mob levels to original 75 cap levels
-- Format: (groupid,poolid,zoneid,name,respawntime,spawntype,dropid,HP,MP,minLevel,maxLevel,allegiance)
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------
-- Add content_tag to zones
-- ------------------------------------------------------------

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
                  OR zoneid='217' OR zoneid='218' OR zoneid='253' OR zoneid='254' OR zoneid='255' OR zoneid='13' OR zoneid='44'
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
-- Promyvion-Holla (Zone 16)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='22',maxLevel='33' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='16';
UPDATE mob_groups SET minLevel='24',maxLevel='35' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='16';
UPDATE mob_groups SET minLevel='30',maxLevel='37' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='16';

-- ------------------------------------------------------------
-- Promyvion-Dem (Zone 18)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='22',maxLevel='33' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='18';
UPDATE mob_groups SET minLevel='24',maxLevel='35' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='18';
UPDATE mob_groups SET minLevel='30',maxLevel='37' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='18';

-- ------------------------------------------------------------
-- Promyvion-Mea (Zone 20)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='22',maxLevel='33' WHERE name='Idle_Wanderer' AND groupid='3' AND zoneid='20';
UPDATE mob_groups SET minLevel='24',maxLevel='35' WHERE name='Livid_Seether' AND groupid='22' AND zoneid='20';
UPDATE mob_groups SET minLevel='30',maxLevel='37' WHERE name='Woeful_Weeper' AND groupid='23' AND zoneid='20';

-- ------------------------------------------------------------
-- Promyvion-Vahzl (Zone 22)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='46',maxLevel='52' WHERE name='Idle_Wanderer' AND groupid='7' AND zoneid='22';
UPDATE mob_groups SET minLevel='52',maxLevel='56' WHERE name='Livid_Seether' AND groupid='37' AND zoneid='22';
UPDATE mob_groups SET minLevel='48',maxLevel='54' WHERE name='Woeful_Weeper' AND groupid='38' AND zoneid='22';

-- ------------------------------------------------------------
-- Lufaise_Meadows (Zone 24)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Misareaux_Coast (Zone 25)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Phomiuna_Aqueducts (Zone 27)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='40',maxLevel='44' WHERE name='Aqueduct_Spider' AND groupid='44' AND zoneid='27';

-- ------------------------------------------------------------
-- Sacrarium (Zone 28)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='52',maxLevel='56' WHERE name='Aqueduct_Spider' AND groupid='41' AND zoneid='28';

-- ------------------------------------------------------------
-- The_Boyahda_Tree (Zone 153)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='72',maxLevel='75' WHERE name='Mourning_Crawler' AND groupid='25' AND zoneid='153';
UPDATE mob_groups SET minLevel='72',maxLevel='75' WHERE name='Snaggletooth_Peapuk' AND groupid='26' AND zoneid='153';
UPDATE mob_groups SET minLevel='72',maxLevel='74' WHERE name='Viseclaw' AND groupid='27' AND zoneid='153';

-- ------------------------------------------------------------
-- Ranguemont_Pass (Zone 166)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='42',maxLevel='44' WHERE name='Hovering_Oculus' AND groupid='20' AND zoneid='166';
UPDATE mob_groups SET minLevel='25',maxLevel='28' WHERE name='Bilesucker' AND groupid='21' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Hoodoo' AND groupid='22' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Artificer' AND groupid='23' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Tanner' AND groupid='24' AND zoneid='166';
UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Goblin_Chaser' AND groupid='25' AND zoneid='166';
UPDATE mob_groups SET minLevel='24',maxLevel='26' WHERE name='Goblins_Bats' AND groupid='26' AND zoneid='166';

-- ------------------------------------------------------------
-- Bostaunieux_Oubliette (Zone 167)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='55',maxLevel='59' WHERE name='Blind_Bat' AND groupid='14' AND zoneid='167';
UPDATE mob_groups SET minLevel='60',maxLevel='68' WHERE name='Panna_Cotta' AND groupid='15' AND zoneid='167';
UPDATE mob_groups SET minLevel='68',maxLevel='70' WHERE name='Nachtmahr' AND groupid='16' AND zoneid='167';
UPDATE mob_groups SET minLevel='64',maxLevel='66' WHERE name='Dabilla' AND groupid='17' AND zoneid='167';
UPDATE mob_groups SET minLevel='69',maxLevel='74' WHERE name='Wurdalak' AND groupid='18' AND zoneid='167';

-- ------------------------------------------------------------
-- Toraimarai_Canal (Zone 169)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='57',maxLevel='59' WHERE name='Blackwater_Pugil' AND groupid='21' AND zoneid='169';
UPDATE mob_groups SET minLevel='60',maxLevel='62' WHERE name='Plunderer_Crab' AND groupid='22' AND zoneid='169';
UPDATE mob_groups SET minLevel='58',maxLevel='60' WHERE name='Deviling_Bats' AND groupid='25' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Sodden_Bones' AND groupid='26' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Drowned_Bones' AND groupid='27' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Starborer' AND groupid='28' AND zoneid='169';
UPDATE mob_groups SET minLevel='65',maxLevel='67' WHERE name='Rapier_Scorpion' AND groupid='29' AND zoneid='169';
UPDATE mob_groups SET minLevel='66',maxLevel='69' WHERE name='Poroggo_Excavator' AND groupid='32' AND zoneid='169';
UPDATE mob_groups SET minLevel='64',maxLevel='67' WHERE name='Flume_Toad' AND groupid='33' AND zoneid='169';

-- ------------------------------------------------------------
-- Zeruhn_Mines (Zone 172)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='2',maxLevel='4' WHERE name='Burrower_Worm' AND groupid='2' AND zoneid='172';
UPDATE mob_groups SET minLevel='2',maxLevel='4' WHERE name='Colliery_Bat' AND groupid='3' AND zoneid='172';
UPDATE mob_groups SET minLevel='3',maxLevel='5' WHERE name='Soot_Crab' AND groupid='4' AND zoneid='172';
UPDATE mob_groups SET minLevel='3',maxLevel='6' WHERE name='Veindigger_Leech' AND groupid='6' AND zoneid='172';

-- ------------------------------------------------------------
-- Korroloka_Tunnel (Zone 173)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='29',maxLevel='32' WHERE name='Lacerator' AND groupid='18' AND zoneid='173';
UPDATE mob_groups SET minLevel='28',maxLevel='31' WHERE name='Spool_Leech' AND groupid='19' AND zoneid='173';

-- ------------------------------------------------------------
-- King_Ranperres_Tomb (Zone 190)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='58',maxLevel='60' WHERE name='Tomb_Worm' AND groupid='26' AND zoneid='190';
UPDATE mob_groups SET minLevel='62',maxLevel='64' WHERE name='Ogre_Bat' AND groupid='27' AND zoneid='190';
UPDATE mob_groups SET minLevel='63',maxLevel='65' WHERE name='Cutlass_Scorpion' AND groupid='28' AND zoneid='190';
UPDATE mob_groups SET minLevel='64',maxLevel='66' WHERE name='Bonnet_Beetle' AND groupid='36' AND zoneid='190';

-- ------------------------------------------------------------
-- Dangruf_Wadi (Zone 191)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Brigand' AND groupid='19' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Headsman' AND groupid='20' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Healer' AND groupid='21' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Witchetty_Grub' AND groupid='22' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Couloir_Leech' AND groupid='23' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Prim_Pika' AND groupid='24' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Natty_Gibbon' AND groupid='25' AND zoneid='191';
UPDATE mob_groups SET minLevel='16',maxLevel='20' WHERE name='Trimmer' AND groupid='26' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Fume_Lizard' AND groupid='27' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Conjurer' AND groupid='28' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Bladesmith' AND groupid='29' AND zoneid='191';
UPDATE mob_groups SET minLevel='21',maxLevel='23' WHERE name='Goblin_Bushwhacker' AND groupid='30' AND zoneid='191';

-- ------------------------------------------------------------
-- Inner_Horutoto_Ruins (Zone 192)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='12',maxLevel='15' WHERE name='Troika_Bats' AND groupid='6' AND zoneid='192';
UPDATE mob_groups SET minLevel='11',maxLevel='16' WHERE name='Deathwatch_Beetle' AND groupid='7' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Flesher' AND groupid='8' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Metallurgist' AND groupid='9' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Lurcher' AND groupid='10' AND zoneid='192';
UPDATE mob_groups SET minLevel='25',maxLevel='28' WHERE name='Skinnymalinks' AND groupid='11' AND zoneid='192';
UPDATE mob_groups SET minLevel='25',maxLevel='28' WHERE name='Skinnymajinx' AND groupid='12' AND zoneid='192';
UPDATE mob_groups SET minLevel='17',maxLevel='20' WHERE name='Covin_Bat' AND groupid='13' AND zoneid='192';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Goblin_Trailblazer' AND groupid='14' AND zoneid='192';

-- ------------------------------------------------------------
-- Ordelles_Caves (Zone 193)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='23',maxLevel='26' WHERE name='Buds_Bunny' AND groupid='18' AND zoneid='193';
UPDATE mob_groups SET minLevel='25',maxLevel='27' WHERE name='Bilis_Leech' AND groupid='19' AND zoneid='193';
UPDATE mob_groups SET minLevel='27',maxLevel='29' WHERE name='Swagger_Spruce' AND groupid='24' AND zoneid='193';
UPDATE mob_groups SET minLevel='29',maxLevel='31' WHERE name='Targe_Beetle' AND groupid='25' AND zoneid='193';

-- ------------------------------------------------------------
-- Outer_Horutoto_Ruins (Zone 194)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='15',maxLevel='18' WHERE name='Fetor_Bats' AND groupid='8' AND zoneid='194';
UPDATE mob_groups SET minLevel='23',maxLevel='25' WHERE name='Fuligo' AND groupid='9' AND zoneid='194';
UPDATE mob_groups SET minLevel='20',maxLevel='23' WHERE name='Thorn_Bat' AND groupid='14' AND zoneid='194';

-- ------------------------------------------------------------
-- The_Eldieme_Necropolis (Zone 195)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='60',maxLevel='63' WHERE name='Hellbound_Warrior' AND groupid='15' AND zoneid='195';
UPDATE mob_groups SET minLevel='60',maxLevel='63' WHERE name='Hellbound_Warlock' AND groupid='16' AND zoneid='195';
UPDATE mob_groups SET minLevel='53',maxLevel='55' WHERE name='Nekros_Hound' AND groupid='32' AND zoneid='195';

-- ------------------------------------------------------------
-- Gusgen_Mines (Zone 196)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='26',maxLevel='30' WHERE name='Accursed_Soldier' AND groupid='23' AND zoneid='196';
UPDATE mob_groups SET minLevel='23',maxLevel='27' WHERE name='Accursed_Sorcerer' AND groupid='24' AND zoneid='196';
UPDATE mob_groups SET minLevel='27',maxLevel='30' WHERE name='Madfly' AND groupid='25' AND zoneid='196';
UPDATE mob_groups SET minLevel='23',maxLevel='26' WHERE name='Rockmill' AND groupid='26' AND zoneid='196';

-- ------------------------------------------------------------
-- Crawlers_Nest (Zone 197)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='47',maxLevel='49' WHERE name='King_Crawler' AND groupid='16' AND zoneid='197';
UPDATE mob_groups SET minLevel='55',maxLevel='57' WHERE name='Vespo' AND groupid='17' AND zoneid='197';
UPDATE mob_groups SET minLevel='50',maxLevel='53' WHERE name='Dancing_Jewel' AND groupid='18' AND zoneid='197';
UPDATE mob_groups SET minLevel='51',maxLevel='54' WHERE name='Olid_Funguar' AND groupid='19' AND zoneid='197';

-- ------------------------------------------------------------
-- Maze_of_Shakhrami (Zone 198)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='24',maxLevel='28' WHERE name='Bleeder_Leech' AND groupid='18' AND zoneid='198';
UPDATE mob_groups SET minLevel='23',maxLevel='26' WHERE name='Chaser_Bats' AND groupid='21' AND zoneid='198';
UPDATE mob_groups SET minLevel='29',maxLevel='31' WHERE name='Crypterpillar' AND groupid='22' AND zoneid='198';
UPDATE mob_groups SET minLevel='26',maxLevel='29' WHERE name='Warren_Bat' AND groupid='23' AND zoneid='198';

-- ------------------------------------------------------------
-- Garlaige_Citadel (Zone 200)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='53',maxLevel='55' WHERE name='Fortalice_Bats' AND groupid='15' AND zoneid='200';
UPDATE mob_groups SET minLevel='52',maxLevel='53' WHERE name='Kaboom' AND groupid='29' AND zoneid='200';
UPDATE mob_groups SET minLevel='56',maxLevel='58' WHERE name='Warden_Beetle' AND groupid='35' AND zoneid='200';
UPDATE mob_groups SET minLevel='53',maxLevel='55' WHERE name='Donjon_Bat' AND groupid='40' AND zoneid='200';

-- ------------------------------------------------------------
-- FeiYin (Zone 204)
-- ------------------------------------------------------------

UPDATE mob_groups SET minLevel='55',maxLevel='57' WHERE name='Wekufe' AND groupid='16' AND zoneid='204';
UPDATE mob_groups SET minLevel='56',maxLevel='58' WHERE name='Sentient_Carafe' AND groupid='17' AND zoneid='204';
UPDATE mob_groups SET minLevel='51',maxLevel='54' WHERE name='Balayang' AND groupid='18' AND zoneid='204';
