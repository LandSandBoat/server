SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure de la table `item_mods_pet`
--

DROP TABLE IF EXISTS `item_mods_pet`;
CREATE TABLE IF NOT EXISTS `item_mods_pet` (
 `itemId` smallint(5) unsigned NOT NULL,
 `modId` smallint(5) unsigned NOT NULL,
 `value` smallint(5) NOT NULL DEFAULT '0',
 `petType` tinyint(3) unsigned NOT NULL DEFAULT '0',
 PRIMARY KEY (`itemId`,`modId`,`petType`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=13 PACK_KEYS=1;

-- (Please keep item ID sequential)
-- Charivari Earring
INSERT INTO `item_mods_pet` VALUES (10296,25,3,3); -- Automaton - ACC: 3
INSERT INTO `item_mods_pet` VALUES (10296,26,3,3); -- Automaton - RACC: 3
INSERT INTO `item_mods_pet` VALUES (10296,30,3,3); -- Automaton - MACC: 3

-- Sabong Earring
INSERT INTO `item_mods_pet` VALUES (10299,288,2,0); -- All Pets - DOUBLE_ATTACK: 2

-- Shedir Crackows
INSERT INTO `item_mods_pet` VALUES (10370,28,3,1);  -- Avatar - MATT: 3
INSERT INTO `item_mods_pet` VALUES (10370,30,3,1);  -- Avatar - MACC: 3
INSERT INTO `item_mods_pet` VALUES (10370,126,3,1); -- Avatar - BP_DAMAGE: 3

-- Murzim Zucchetto
INSERT INTO `item_mods_pet` VALUES (10440,384,600,3); -- Automaton - HASTE_GEAR: 600

-- Tethyan Cuffs +1
INSERT INTO `item_mods_pet` VALUES (10530,28,5,1); -- Avatar - MATT: 5

-- Tethyan Cuffs +2
INSERT INTO `item_mods_pet` VALUES (10531,28,5,1); -- Avatar - MATT: 5

-- Tethyan Cuffs +3
INSERT INTO `item_mods_pet` VALUES (10532,28,5,1); -- Avatar - MATT: 5

-- Auspex Gages
INSERT INTO `item_mods_pet` VALUES (10537,23,9,1);  -- Avatar - ATT: 9
INSERT INTO `item_mods_pet` VALUES (10537,126,4,1); -- Avatar - BP_DAMAGE: 4

-- Spurrina Gages
INSERT INTO `item_mods_pet` VALUES (10542,23,12,1); -- Avatar - ATT: 12
INSERT INTO `item_mods_pet` VALUES (10542,126,5,1); -- Avatar - BP_DAMAGE: 5

-- Summoners Horn +2
INSERT INTO `item_mods_pet` VALUES (10664,28,4,1);  -- Avatar - MATT: 4
INSERT INTO `item_mods_pet` VALUES (10664,346,3,1); -- Avatar - PERPETUATION_REDUCTION: 3

-- Summoners Doublet +2
INSERT INTO `item_mods_pet` VALUES (10684,165,6,1); -- Avatar - CRITHITRATE: 6
INSERT INTO `item_mods_pet` VALUES (10684,346,3,1); -- Avatar - PERPETUATION_REDUCTION: 3

-- Summoners Spats +2
INSERT INTO `item_mods_pet` VALUES (10724,30,5,1); -- Avatar - MACC: 5

-- Summoners Pigaches +2
INSERT INTO `item_mods_pet` VALUES (10744,562,5,1); -- Avatar - MAGIC_CRITHITRATE: 5

-- Moepapa Stone
INSERT INTO `item_mods_pet` VALUES (10817,384,500,0); -- All Pets - HASTE_GEAR: 500

-- Muzzling Collar
INSERT INTO `item_mods_pet` VALUES (10914,27,-2,0); -- All Pets - ENMITY: -2

-- Muzzling Collar +1
INSERT INTO `item_mods_pet` VALUES (10915,27,-3,0); -- All Pets - ENMITY: -3

-- Oneiros Cappa
INSERT INTO `item_mods_pet` VALUES (10972,161,-300,0); -- All Pets - DMGPHYS: -300

-- Esper Earring
INSERT INTO `item_mods_pet` VALUES (11052,126,3,1); -- Avatar - BP_DAMAGE: 3

-- Callers Doublet +2
INSERT INTO `item_mods_pet` VALUES (11098,126,10,1); -- Avatar - BP_DAMAGE: 10

-- Callers Bracers +2
INSERT INTO `item_mods_pet` VALUES (11118,25,15,1); -- Avatar - ACC: 15

-- Callers Spats +2
INSERT INTO `item_mods_pet` VALUES (11138,345,500,1); -- Avatar - TP_BONUS: 500

-- Callers Pigaches +2
INSERT INTO `item_mods_pet` VALUES (11158,30,5,1); -- Avatar - MACC: 5

-- Callers Doublet +1
INSERT INTO `item_mods_pet` VALUES (11198,126,5,1); -- Avatar - BP_DAMAGE: 5

-- Callers Bracers +1
INSERT INTO `item_mods_pet` VALUES (11218,25,10,1); -- Avatar - ACC: 10

-- Callers Spats +1
INSERT INTO `item_mods_pet` VALUES (11238,345,250,1); -- Avatar - TP_BONUS: 250

-- Callers Pigaches +1
INSERT INTO `item_mods_pet` VALUES (11258,30,5,1); -- Avatar - MACC: 5

-- Cirque Scarpe +1
INSERT INTO `item_mods_pet` VALUES (11261,12,10,3); -- Automaton - INT: 10
INSERT INTO `item_mods_pet` VALUES (11261,13,10,3); -- Automaton - MND: 10

-- Puppetry Tobe +1
INSERT INTO `item_mods_pet` VALUES (11297,2,20,4); -- Harlequin - HP: 20
INSERT INTO `item_mods_pet` VALUES (11297,2,24,5); -- Valoredge - HP: 24
INSERT INTO `item_mods_pet` VALUES (11297,2,18,6); -- Sharpshot - HP: 18
INSERT INTO `item_mods_pet` VALUES (11297,2,16,7); -- Stormwaker - HP: 16
INSERT INTO `item_mods_pet` VALUES (11297,5,20,4); -- Harlequin - MP: 20
INSERT INTO `item_mods_pet` VALUES (11297,5,24,7); -- Stormwaker - MP: 24

-- Pantin Tobe
INSERT INTO `item_mods_pet` VALUES (11298,25,10,3); -- Automaton - ACC: 10

-- Pantin Tobe +1
INSERT INTO `item_mods_pet` VALUES (11299,25,10,3); -- Automaton - ACC: 10

-- Aegas Doublet
INSERT INTO `item_mods_pet` VALUES (11338,25,3,0);  -- All Pets - ACC: 3
INSERT INTO `item_mods_pet` VALUES (11338,289,3,0); -- All Pets - SUBTLE_BLOW: 3

-- Pantin Babouches
INSERT INTO `item_mods_pet` VALUES (11388,28,5,3); -- Automaton - MATT: 5

-- Pantin Babouches +1
INSERT INTO `item_mods_pet` VALUES (11389,28,5,3); -- Automaton - MATT: 5

-- Puppetry Taj +1
INSERT INTO `item_mods_pet` VALUES (11470,71,3,3); -- Automaton - MPHEAL: 3
INSERT INTO `item_mods_pet` VALUES (11470,72,3,3); -- Automaton - HPHEAL: 3

-- Pantin Taj
INSERT INTO `item_mods_pet` VALUES (11471,370,1,3); -- Automaton - REGEN: 1

-- Pantin Taj +1
INSERT INTO `item_mods_pet` VALUES (11472,370,1,3); -- Automaton - REGEN: 1

-- Spurrer Beret
INSERT INTO `item_mods_pet` VALUES (11497,384,500,0); -- All Pets - HASTE_GEAR: 500

-- Fidelity Mantle
INSERT INTO `item_mods_pet` VALUES (11531,73,3,0); -- All Pets - STORETP: 3

-- Ferine Mantle
INSERT INTO `item_mods_pet` VALUES (11555,25,10,0); -- All Pets - ACC: 10

-- Tiresias Cape
INSERT INTO `item_mods_pet` VALUES (11564,28,1,1); -- Avatar - MATT: 1

-- Karagoz Mantle
INSERT INTO `item_mods_pet` VALUES (11571,25,12,3); -- Automaton - ACC: 12

-- Eidolon Pendant
INSERT INTO `item_mods_pet` VALUES (11612,28,2,1); -- Avatar - MATT: 2

-- Ferine Necklace
INSERT INTO `item_mods_pet` VALUES (11617,288,2,0); -- All Pets - DOUBLE_ATTACK: 2

-- Callers Pendant
INSERT INTO `item_mods_pet` VALUES (11619,368,25,1); -- Avatar - REGAIN: 25

-- Ferine Earring
INSERT INTO `item_mods_pet` VALUES (11711,25,3,0); -- All Pets - ACC: 3

-- Mujin Obi
INSERT INTO `item_mods_pet` VALUES (11776,23,10,1); -- Avatar - ATT: 10

-- Cirque Earring
INSERT INTO `item_mods_pet` VALUES (11720,23,2,3); -- Automaton - ATT: 2
INSERT INTO `item_mods_pet` VALUES (11720,24,3,3); -- Automaton - RATT: 3
INSERT INTO `item_mods_pet` VALUES (11720,28,3,3); -- Automaton - MATT: 3

-- Callers Sash
INSERT INTO `item_mods_pet` VALUES (11739,27,2,1); -- Avatar - ENMITY: 2
INSERT INTO `item_mods_pet` VALUES (11739,28,2,1); -- Avatar - MATT: 2

-- Ngen Seraweels
INSERT INTO `item_mods_pet` VALUES (11987,126,5,1); -- Avatar - BP_DAMAGE: 5
INSERT INTO `item_mods_pet` VALUES (11987,370,1,1); -- Avatar - REGEN: 1

-- Evokers Horn
INSERT INTO `item_mods_pet` VALUES (12520,27,-3,1); -- Avatar - ENMITY: -3

-- Drachen Mail
INSERT INTO `item_mods_pet` VALUES (12649,370,1,2); -- Wyvern - REGEN: 1

-- Evokers Doublet
INSERT INTO `item_mods_pet` VALUES (12650,27,-2,1); -- Avatar - ENMITY: -2

-- Drachen Finger Gauntlets
INSERT INTO `item_mods_pet` VALUES (13974,25,5,2); -- Wyvern - ACC: 5

-- Evokers Bracers
INSERT INTO `item_mods_pet` VALUES (13975,27,-2,1); -- Avatar - ENMITY: -2

-- Evokers Pigaches
INSERT INTO `item_mods_pet` VALUES (14103,27,-2,1); -- Avatar - ENMITY: -2
INSERT INTO `item_mods_pet` VALUES (14103,68,5,1);  -- Avatar - EVA: 5

-- Drachen Brais
INSERT INTO `item_mods_pet` VALUES (14227,3,10,2); -- Wyvern - HPP: 10

-- Evokers Spats
INSERT INTO `item_mods_pet` VALUES (14228,25,10,1); -- Avatar - ACC: 10
INSERT INTO `item_mods_pet` VALUES (14228,27,-2,1); -- Avatar - ENMITY: -2

-- Wyvern Mail
INSERT INTO `item_mods_pet` VALUES (14405,2,65,2);  -- Wyvern - HP: 65
INSERT INTO `item_mods_pet` VALUES (14405,72,65,2); -- Wyvern - HPHEAL: 65

-- Yinyang Robe
INSERT INTO `item_mods_pet` VALUES (14468,27,5,1); -- Avatar - ENMITY: 5

-- Drachen Mail +1
INSERT INTO `item_mods_pet` VALUES (14486,370,1,2); -- Wyvern - REGEN: 1

-- Summoners Doublet +1
INSERT INTO `item_mods_pet` VALUES (14514,165,4,1); -- Avatar - CRITHITRATE: 4

-- Puppetry Tobe
INSERT INTO `item_mods_pet` VALUES (14523,2,20,4); -- Harlequin - HP: 20
INSERT INTO `item_mods_pet` VALUES (14523,2,24,5); -- Valoredge - HP: 24
INSERT INTO `item_mods_pet` VALUES (14523,2,18,6); -- Sharpshot - HP: 18
INSERT INTO `item_mods_pet` VALUES (14523,2,16,7); -- Stormwaker - HP: 16
INSERT INTO `item_mods_pet` VALUES (14523,5,20,4); -- Harlequin - MP: 20
INSERT INTO `item_mods_pet` VALUES (14523,5,24,7); -- Stormwaker - MP: 24

-- Ostreger Mitts
INSERT INTO `item_mods_pet` VALUES (14872,2,10,2); -- Wyvern - HP: 10

-- Drachen Finger Gauntlets +1
INSERT INTO `item_mods_pet` VALUES (14903,25,5,2); -- Wyvern - ACC: 5

-- Evokers Bracers +1
INSERT INTO `item_mods_pet` VALUES (14904,27,-2,1); -- Avatar - ENMITY: -2

-- Summoners Bracers +1
INSERT INTO `item_mods_pet` VALUES (14923,25,14,1); -- Avatar - ACC: 14

-- Beast Bazubands
INSERT INTO `item_mods_pet` VALUES (14958,63,5,0); -- All Pets - DEFP: 5

-- Pantin Dastanas
INSERT INTO `item_mods_pet` VALUES (15031,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Pantin Dastanas +1
INSERT INTO `item_mods_pet` VALUES (15032,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Summoners Doublet
INSERT INTO `item_mods_pet` VALUES (15101,165,3,1); -- Avatar - CRITHITRATE: 3

-- Summoners Bracers
INSERT INTO `item_mods_pet` VALUES (15116,25,7,1); -- Avatar - ACC: 7

-- Summoners Pigaches
INSERT INTO `item_mods_pet` VALUES (15146,23,7,1);   -- Avatar - ATT: 7
INSERT INTO `item_mods_pet` VALUES (15146,357,-2,1); -- Avatar - BP_DELAY: -2

-- Evokers Horn +1
INSERT INTO `item_mods_pet` VALUES (15239,27,-3,1); -- Avatar - ENMITY: -3

-- Puppetry Taj
INSERT INTO `item_mods_pet` VALUES (15267,71,3,3); -- Automaton - MPHEAL: 3
INSERT INTO `item_mods_pet` VALUES (15267,72,3,3); -- Automaton - HPHEAL: 3

-- Evokers Pigaches +1
INSERT INTO `item_mods_pet` VALUES (15366,27,-4,1); -- Avatar - ENMITY: -4
INSERT INTO `item_mods_pet` VALUES (15366,68,5,1);  -- Avatar - EVA: 5

-- Falconers Hose
INSERT INTO `item_mods_pet` VALUES (15367,2,30,2); -- Wyvern - HP: 30

-- Drachen Brais +1
INSERT INTO `item_mods_pet` VALUES (15574,3,15,2); -- Wyvern - HPP: 15

-- Evokers Spats +1
INSERT INTO `item_mods_pet` VALUES (15575,25,14,1); -- Avatar - ACC: 14
INSERT INTO `item_mods_pet` VALUES (15575,27,-2,1); -- Avatar - ENMITY: -2

-- Summoners Spats +1
INSERT INTO `item_mods_pet` VALUES (15594,27,2,1); -- Avatar - ENMITY: 2

-- Puppetry Churidars
INSERT INTO `item_mods_pet` VALUES (15602,168,10,3); -- Automaton - SPELLINTERRUPT: 10
INSERT INTO `item_mods_pet` VALUES (15602,374,5,3);  -- Automaton - CURE_POTENCY: 5

-- Askar Dirs
INSERT INTO `item_mods_pet` VALUES (15647,1,10,0); -- All Pets - DEF: 10

-- Goliard Trews
INSERT INTO `item_mods_pet` VALUES (15649,1,10,0); -- All Pets - DEF: 10

-- Homam Gambieras
INSERT INTO `item_mods_pet` VALUES (15661,2,50,2); -- Wyvern - HP: 50

-- Summoners Pigaches +1
INSERT INTO `item_mods_pet` VALUES (15679,23,10,1);  -- Avatar - ATT: 10
INSERT INTO `item_mods_pet` VALUES (15679,27,2,1);   -- Avatar - ENMITY: 2
INSERT INTO `item_mods_pet` VALUES (15679,357,-2,1); -- Avatar - BP_DELAY: -2

-- Primal Belt
INSERT INTO `item_mods_pet` VALUES (15910,1,5,0);  -- All Pets - DEF: 5
INSERT INTO `item_mods_pet` VALUES (15910,27,3,0); -- All Pets - ENMITY: 3

-- Selemnus Belt
INSERT INTO `item_mods_pet` VALUES (15944,163,-700,0); -- All Pets - DMGMAGIC: -700

-- Pallass Shield
INSERT INTO `item_mods_pet` VALUES (16173,1,10,0); -- All Pets - DEF: 10

-- Pantin Cape
INSERT INTO `item_mods_pet` VALUES (16245,23,15,3); -- Automaton - ATT: 15

-- Chanoixs Gorget
INSERT INTO `item_mods_pet` VALUES (16270,2,50,2); -- Wyvern - HP: 50

-- Shepherds Chain
INSERT INTO `item_mods_pet` VALUES (16297,161,-200,0); -- All Pets - DMGPHYS: -200

-- Puppetry Churidars +1
INSERT INTO `item_mods_pet` VALUES (16351,168,10,3); -- Automaton - SPELLINTERRUPT: 10
INSERT INTO `item_mods_pet` VALUES (16351,374,5,3);  -- Automaton - CURE_POTENCY: 5

-- Pantin Churidars
INSERT INTO `item_mods_pet` VALUES (16352,30,5,3); -- Automaton - MACC: 5

-- Pantin Churidars +1
INSERT INTO `item_mods_pet` VALUES (16353,30,7,3); -- Automaton - MACC: 7

-- Herders Subligar
INSERT INTO `item_mods_pet` VALUES (16368,25,10,0); -- All Pets - ACC: 10

-- Glyph Axe
INSERT INTO `item_mods_pet` VALUES (16654,368,10,0); -- All Pets - REGAIN: 10

-- Draconis Lance
INSERT INTO `item_mods_pet` VALUES (16843,23,10,2); -- Wyvern - ATT: 10
INSERT INTO `item_mods_pet` VALUES (16843,25,10,2); -- Wyvern - ACC: 10

-- Wyvern Perch
INSERT INTO `item_mods_pet` VALUES (17579,2,50,2); -- Wyvern - HP: 50

-- Animator +1
INSERT INTO `item_mods_pet` VALUES (17857,2,50,4); -- Harlequin - HP: 50
INSERT INTO `item_mods_pet` VALUES (17857,2,60,5); -- Valoredge - HP: 60
INSERT INTO `item_mods_pet` VALUES (17857,2,45,6); -- Sharpshot - HP: 45
INSERT INTO `item_mods_pet` VALUES (17857,2,40,7); -- Stormwaker - HP: 40
INSERT INTO `item_mods_pet` VALUES (17857,5,50,4); -- Harlequin - MP: 50
INSERT INTO `item_mods_pet` VALUES (17857,5,60,7); -- Stormwaker - MP: 60

-- Lion Tamer
INSERT INTO `item_mods_pet` VALUES (17961,1,10,0); -- All Pets - DEF: 10

-- Ravanas Axe
INSERT INTO `item_mods_pet` VALUES (18547,370,3,0); -- All Pets - REGEN: 3

-- Adaman Sainti
INSERT INTO `item_mods_pet` VALUES (18745,3,1,3); -- Automaton - HPP: 1

-- Gem Sainti
INSERT INTO `item_mods_pet` VALUES (18746,3,2,3); -- Automaton - HPP: 2

-- Marotte Claws
INSERT INTO `item_mods_pet` VALUES (18778,369,1,3); -- Automaton - REFRESH: 1
INSERT INTO `item_mods_pet` VALUES (18778,370,1,3); -- Automaton - REGEN: 1

-- Burattinaios
INSERT INTO `item_mods_pet` VALUES (18780,368,10,3); -- Automaton - REGAIN: 10

-- Buzbaz Sainti
INSERT INTO `item_mods_pet` VALUES (18791,2,30,3); -- Automaton - HP: 30
INSERT INTO `item_mods_pet` VALUES (18791,23,9,3); -- Automaton - ATT: 9
INSERT INTO `item_mods_pet` VALUES (18791,24,9,3); -- Automaton - RATT: 9

-- Buzbaz Sainti +1
INSERT INTO `item_mods_pet` VALUES (18792,2,40,3);  -- Automaton - HP: 40
INSERT INTO `item_mods_pet` VALUES (18792,23,10,3); -- Automaton - ATT: 10
INSERT INTO `item_mods_pet` VALUES (18792,24,10,3); -- Automaton - RATT: 10

-- Aymur
INSERT INTO `item_mods_pet` VALUES (18999,23,40,0); -- All Pets - ATT: 40

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19005,28,20,1); -- Avatar - MATT: 20

-- Aymur
INSERT INTO `item_mods_pet` VALUES (19068,23,50,0); -- All Pets - ATT: 50

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19074,28,25,1); -- Avatar - MATT: 25

-- Aymur
INSERT INTO `item_mods_pet` VALUES (19088,23,60,0); -- All Pets - ATT: 60

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19094,28,30,1); -- Avatar - MATT: 30

-- Aymur
INSERT INTO `item_mods_pet` VALUES (19620,23,70,0); -- All Pets - ATT: 70

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19626,28,35,1); -- Avatar - MATT: 35

-- Aymur
INSERT INTO `item_mods_pet` VALUES (19718,23,70,0); -- All Pets - ATT: 70

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19724,28,35,1); -- Avatar - MATT: 35

-- Esper Stone
INSERT INTO `item_mods_pet` VALUES (19772,28,1,1); -- Avatar - MATT: 1

-- Aymur
INSERT INTO `item_mods_pet` VALUES (19827,23,80,0); -- All Pets - ATT: 80

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19833,28,40,1); -- Avatar - MATT: 40

-- Aymur
INSERT INTO `item_mods_pet` VALUES (19956,23,80,0); -- All Pets - ATT: 80

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (19962,28,40,1); -- Avatar - MATT: 40

-- Denouements
INSERT INTO `item_mods_pet` VALUES (20516,369,4,3); -- Automaton - REFRESH: 4
INSERT INTO `item_mods_pet` VALUES (20516,370,4,3); -- Automaton - REGEN: 4

-- Ohtas
INSERT INTO `item_mods_pet` VALUES (20535,368,10,3); -- Automaton - REGAIN: 10
INSERT INTO `item_mods_pet` VALUES (20535,369,1,3);  -- Automaton - REFRESH: 1

-- Tinhaspa
INSERT INTO `item_mods_pet` VALUES (20536,23,15,3); -- Automaton - ATT: 15
INSERT INTO `item_mods_pet` VALUES (20536,24,15,3); -- Automaton - RATT: 15
INSERT INTO `item_mods_pet` VALUES (20536,28,15,3); -- Automaton - MATT: 15

-- Rigor Baghnakhs
INSERT INTO `item_mods_pet` VALUES (20549,25,20,3); -- Automaton - ACC: 20
INSERT INTO `item_mods_pet` VALUES (20549,26,20,3); -- Automaton - RACC: 20
INSERT INTO `item_mods_pet` VALUES (20549,30,20,3); -- Automaton - MACC: 20

-- Aymur
INSERT INTO `item_mods_pet` VALUES (20792,23,80,0); -- All Pets - ATT: 80

-- Aymur
INSERT INTO `item_mods_pet` VALUES (20793,23,80,0); -- All Pets - ATT: 80

-- Anahera Tabar
INSERT INTO `item_mods_pet` VALUES (20822,27,6,0);  -- All Pets - ENMITY: 6
INSERT INTO `item_mods_pet` VALUES (20822,68,40,0); -- All Pets - EVA: 40

-- Aalak Axe
INSERT INTO `item_mods_pet` VALUES (20831,288,2,0); -- All Pets - DOUBLE_ATTACK: 2

-- Aalak Axe +1
INSERT INTO `item_mods_pet` VALUES (20832,288,3,0); -- All Pets - DOUBLE_ATTACK: 3

-- Pelagos Lance
INSERT INTO `item_mods_pet` VALUES (20944,161,300,2); -- Wyvern - DMGPHYS: 300
INSERT INTO `item_mods_pet` VALUES (20944,370,2,2);   -- Wyvern - REGEN: 2

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (21141,126,40,1); -- Avatar - BP_DAMAGE: 40

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (21142,126,40,1); -- Avatar - BP_DAMAGE: 40

-- Marquetry Staff
INSERT INTO `item_mods_pet` VALUES (21155,28,110,1); -- Avatar - MATT: 110
INSERT INTO `item_mods_pet` VALUES (21155,30,35,1);  -- Avatar - MACC: 35
INSERT INTO `item_mods_pet` VALUES (21155,126,3,1);  -- Avatar - BP_DAMAGE: 3

-- Frazil Staff
INSERT INTO `item_mods_pet` VALUES (21167,27,10,1);  -- Avatar - ENMITY: 10
INSERT INTO `item_mods_pet` VALUES (21167,28,120,1); -- Avatar - MATT: 120
INSERT INTO `item_mods_pet` VALUES (21167,30,20,1);  -- Avatar - MACC: 20

-- Eminent Pole
INSERT INTO `item_mods_pet` VALUES (21183,28,108,1); -- Avatar - MATT: 108

-- Esper Stone +1
INSERT INTO `item_mods_pet` VALUES (21361,28,6,0); -- All Pets - MATT: 6

-- Dunna
INSERT INTO `item_mods_pet` VALUES (21372,160,-500,8); -- Luopan - DMG: -500

-- Magneto
-- TODO: Retail testing needed to confirm the hidden automaton stat bonuses (if any)
-- INSERT INTO `item_mods_pet` VALUES (21375,8,77,3);  -- Automaton - STR: 77
-- INSERT INTO `item_mods_pet` VALUES (21375,9,77,3);  -- Automaton - DEX: 77
-- INSERT INTO `item_mods_pet` VALUES (21375,10,77,3); -- Automaton - VIT: 77
-- INSERT INTO `item_mods_pet` VALUES (21375,11,77,3); -- Automaton - AGI: 77
-- INSERT INTO `item_mods_pet` VALUES (21375,12,77,3); -- Automaton - INT: 77
-- INSERT INTO `item_mods_pet` VALUES (21375,13,77,3); -- Automaton - MND: 77
-- INSERT INTO `item_mods_pet` VALUES (21375,14,77,3); -- Automaton - CHR: 77

-- Animator Z
-- TODO: Retail testing needed to confirm the hidden automaton stat bonuses (if any)
-- INSERT INTO `item_mods_pet` VALUES (21392,8,89,3);  -- Automaton - STR: 89
-- INSERT INTO `item_mods_pet` VALUES (21392,9,89,3);  -- Automaton - DEX: 89
-- INSERT INTO `item_mods_pet` VALUES (21392,10,89,3); -- Automaton - VIT: 89
-- INSERT INTO `item_mods_pet` VALUES (21392,11,89,3); -- Automaton - AGI: 89
-- INSERT INTO `item_mods_pet` VALUES (21392,12,89,3); -- Automaton - INT: 89
-- INSERT INTO `item_mods_pet` VALUES (21392,13,89,3); -- Automaton - MND: 89
-- INSERT INTO `item_mods_pet` VALUES (21392,14,89,3); -- Automaton - CHR: 89

-- Hesperiidae
INSERT INTO `item_mods_pet` VALUES (21430,25,10,0); -- All Pets - ACC: 10
INSERT INTO `item_mods_pet` VALUES (21430,26,10,0); -- All Pets - RACC: 10
INSERT INTO `item_mods_pet` VALUES (21430,30,10,0); -- All Pets - MACC: 10

-- Epitaph
INSERT INTO `item_mods_pet` VALUES (21432,126,16,1); -- Avatar - BP_DAMAGE: 16

-- Neo Animator
-- TODO: Retail testing needed to confirm the hidden automaton stat bonuses (if any)
-- INSERT INTO `item_mods_pet` VALUES (21433,8,89,3);   -- Automaton - STR: 89
-- INSERT INTO `item_mods_pet` VALUES (21433,9,89,3);   -- Automaton - DEX: 89
-- INSERT INTO `item_mods_pet` VALUES (21433,10,89,3);  -- Automaton - VIT: 89
-- INSERT INTO `item_mods_pet` VALUES (21433,11,89,3);  -- Automaton - AGI: 89
-- INSERT INTO `item_mods_pet` VALUES (21433,12,89,3);  -- Automaton - INT: 89
-- INSERT INTO `item_mods_pet` VALUES (21433,13,89,3);  -- Automaton - MND: 89
-- INSERT INTO `item_mods_pet` VALUES (21433,14,89,3);  -- Automaton - CHR: 89
INSERT INTO `item_mods_pet` VALUES (21433,366,10,3); -- Automaton - MAIN_DMG_RATING: 10

-- Divinator
INSERT INTO `item_mods_pet` VALUES (21452,8,89,3);   -- Automaton - STR: 89
INSERT INTO `item_mods_pet` VALUES (21452,9,89,3);   -- Automaton - DEX: 89
INSERT INTO `item_mods_pet` VALUES (21452,10,89,3);  -- Automaton - VIT: 89
INSERT INTO `item_mods_pet` VALUES (21452,11,89,3);  -- Automaton - AGI: 89
INSERT INTO `item_mods_pet` VALUES (21452,12,89,3);  -- Automaton - INT: 89
INSERT INTO `item_mods_pet` VALUES (21452,13,89,3);  -- Automaton - MND: 89
INSERT INTO `item_mods_pet` VALUES (21452,14,89,3);  -- Automaton - CHR: 89

-- Eminent Animator
INSERT INTO `item_mods_pet` VALUES (21453,8,77,3);   -- Automaton - STR: 77
INSERT INTO `item_mods_pet` VALUES (21453,9,77,3);   -- Automaton - DEX: 77
INSERT INTO `item_mods_pet` VALUES (21453,10,77,3);  -- Automaton - VIT: 77
INSERT INTO `item_mods_pet` VALUES (21453,11,77,3);  -- Automaton - AGI: 77
INSERT INTO `item_mods_pet` VALUES (21453,12,77,3);  -- Automaton - INT: 77
INSERT INTO `item_mods_pet` VALUES (21453,13,77,3);  -- Automaton - MND: 77
INSERT INTO `item_mods_pet` VALUES (21453,14,77,3);  -- Automaton - CHR: 77

-- Forefront Animator
INSERT INTO `item_mods_pet` VALUES (21454,8,46,3);   -- Automaton - STR: 46
INSERT INTO `item_mods_pet` VALUES (21454,9,46,3);   -- Automaton - DEX: 46
INSERT INTO `item_mods_pet` VALUES (21454,10,46,3);  -- Automaton - VIT: 46
INSERT INTO `item_mods_pet` VALUES (21454,11,46,3);  -- Automaton - AGI: 46
INSERT INTO `item_mods_pet` VALUES (21454,12,46,3);  -- Automaton - INT: 46
INSERT INTO `item_mods_pet` VALUES (21454,13,46,3);  -- Automaton - MND: 46
INSERT INTO `item_mods_pet` VALUES (21454,14,46,3);  -- Automaton - CHR: 46

-- Alternator
INSERT INTO `item_mods_pet` VALUES (21455,8,70,3);   -- Automaton - STR: 70
INSERT INTO `item_mods_pet` VALUES (21455,9,70,3);   -- Automaton - DEX: 70
INSERT INTO `item_mods_pet` VALUES (21455,10,70,3);  -- Automaton - VIT: 70
INSERT INTO `item_mods_pet` VALUES (21455,11,70,3);  -- Automaton - AGI: 70
INSERT INTO `item_mods_pet` VALUES (21455,12,70,3);  -- Automaton - INT: 70
INSERT INTO `item_mods_pet` VALUES (21455,13,70,3);  -- Automaton - MND: 70
INSERT INTO `item_mods_pet` VALUES (21455,14,70,3);  -- Automaton - CHR: 70

-- Animator P
INSERT INTO `item_mods_pet` VALUES (21456,8,104,3);   -- Automaton - STR: 104
INSERT INTO `item_mods_pet` VALUES (21456,9,104,3);   -- Automaton - DEX: 104
INSERT INTO `item_mods_pet` VALUES (21456,10,104,3);  -- Automaton - VIT: 104
INSERT INTO `item_mods_pet` VALUES (21456,11,104,3);  -- Automaton - AGI: 104
INSERT INTO `item_mods_pet` VALUES (21456,12,104,3);  -- Automaton - INT: 104
INSERT INTO `item_mods_pet` VALUES (21456,13,104,3);  -- Automaton - MND: 104
INSERT INTO `item_mods_pet` VALUES (21456,14,104,3);  -- Automaton - CHR: 104

-- Animator P +1
INSERT INTO `item_mods_pet` VALUES (21457,8,109,3);   -- Automaton - STR: 109
INSERT INTO `item_mods_pet` VALUES (21457,9,109,3);   -- Automaton - DEX: 109
INSERT INTO `item_mods_pet` VALUES (21457,10,109,3);  -- Automaton - VIT: 109
INSERT INTO `item_mods_pet` VALUES (21457,11,109,3);  -- Automaton - AGI: 109
INSERT INTO `item_mods_pet` VALUES (21457,12,109,3);  -- Automaton - INT: 109
INSERT INTO `item_mods_pet` VALUES (21457,13,109,3);  -- Automaton - MND: 109
INSERT INTO `item_mods_pet` VALUES (21457,14,109,3);  -- Automaton - CHR: 109

-- Animator P II
INSERT INTO `item_mods_pet` VALUES (21458,8,104,3);   -- Automaton - STR: 104
INSERT INTO `item_mods_pet` VALUES (21458,9,104,3);   -- Automaton - DEX: 104
INSERT INTO `item_mods_pet` VALUES (21458,10,104,3);  -- Automaton - VIT: 104
INSERT INTO `item_mods_pet` VALUES (21458,11,104,3);  -- Automaton - AGI: 104
INSERT INTO `item_mods_pet` VALUES (21458,12,104,3);  -- Automaton - INT: 104
INSERT INTO `item_mods_pet` VALUES (21458,13,104,3);  -- Automaton - MND: 104
INSERT INTO `item_mods_pet` VALUES (21458,14,104,3);  -- Automaton - CHR: 104

-- Animator P II +1
INSERT INTO `item_mods_pet` VALUES (21459,8,109,3);   -- Automaton - STR: 109
INSERT INTO `item_mods_pet` VALUES (21459,9,109,3);   -- Automaton - DEX: 109
INSERT INTO `item_mods_pet` VALUES (21459,10,109,3);  -- Automaton - VIT: 109
INSERT INTO `item_mods_pet` VALUES (21459,11,109,3);  -- Automaton - AGI: 109
INSERT INTO `item_mods_pet` VALUES (21459,12,109,3);  -- Automaton - INT: 109
INSERT INTO `item_mods_pet` VALUES (21459,13,109,3);  -- Automaton - MND: 109
INSERT INTO `item_mods_pet` VALUES (21459,14,109,3);  -- Automaton - CHR: 109

-- Arasy Sainti
INSERT INTO `item_mods_pet` VALUES (21504,25,10,3); -- Automaton - ACC: 10
INSERT INTO `item_mods_pet` VALUES (21504,30,10,3); -- Automaton - MACC: 10

-- Arasy Sainti +1
INSERT INTO `item_mods_pet` VALUES (21505,25,15,3); -- Automaton - ACC: 15
INSERT INTO `item_mods_pet` VALUES (21505,30,15,3); -- Automaton - MACC: 15

-- Xiucoatl
INSERT INTO `item_mods_pet` VALUES (21526,25,50,3); -- Automaton - ACC: 50
INSERT INTO `item_mods_pet` VALUES (21526,26,50,3); -- Automaton - RACC: 50
INSERT INTO `item_mods_pet` VALUES (21526,30,50,3); -- Automaton - MACC: 50

-- Sakpatas Fists
INSERT INTO `item_mods_pet` VALUES (21527,8,20,3);  -- Automaton - STR: 20
INSERT INTO `item_mods_pet` VALUES (21527,9,20,3);  -- Automaton - DEX: 20
INSERT INTO `item_mods_pet` VALUES (21527,10,20,3); -- Automaton - VIT: 20
INSERT INTO `item_mods_pet` VALUES (21527,11,20,3); -- Automaton - AGI: 20
INSERT INTO `item_mods_pet` VALUES (21527,12,20,3); -- Automaton - INT: 20
INSERT INTO `item_mods_pet` VALUES (21527,13,20,3); -- Automaton - MND: 20
INSERT INTO `item_mods_pet` VALUES (21527,14,20,3); -- Automaton - CHR: 20
INSERT INTO `item_mods_pet` VALUES (21527,25,50,3); -- Automaton - ACC: 50
INSERT INTO `item_mods_pet` VALUES (21527,26,50,3); -- Automaton - RACC: 50
INSERT INTO `item_mods_pet` VALUES (21527,30,50,3); -- Automaton - MACC: 50

-- Dragon Fangs
INSERT INTO `item_mods_pet` VALUES (21528,25,40,0); -- All Pets - ACC: 40
INSERT INTO `item_mods_pet` VALUES (21528,26,40,0); -- All Pets - RACC: 40
INSERT INTO `item_mods_pet` VALUES (21528,30,40,0); -- All Pets - MACC: 40

-- Premium Heart
INSERT INTO `item_mods_pet` VALUES (21529,25,40,0); -- All Pets - ACC: 40
INSERT INTO `item_mods_pet` VALUES (21529,26,40,0); -- All Pets - RACC: 40
INSERT INTO `item_mods_pet` VALUES (21529,30,40,0); -- All Pets - MACC: 40

-- Arasy Tabar
INSERT INTO `item_mods_pet` VALUES (21704,25,10,0); -- All Pets - ACC: 10

-- Arasy Tabar +1
INSERT INTO `item_mods_pet` VALUES (21705,25,15,0); -- All Pets - ACC: 15

-- Monster Axe
INSERT INTO `item_mods_pet` VALUES (21715,25,30,0); -- All Pets - ACC: 30
INSERT INTO `item_mods_pet` VALUES (21715,26,30,0); -- All Pets - RACC: 30
INSERT INTO `item_mods_pet` VALUES (21715,30,30,0); -- All Pets - MACC: 30

-- Ankusa Axe
INSERT INTO `item_mods_pet` VALUES (21716,25,40,0); -- All Pets - ACC: 40
INSERT INTO `item_mods_pet` VALUES (21716,26,40,0); -- All Pets - RACC: 40
INSERT INTO `item_mods_pet` VALUES (21716,30,40,0); -- All Pets - MACC: 40

-- Pangu
INSERT INTO `item_mods_pet` VALUES (21717,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (21717,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (21717,30,50,0); -- All Pets - MACC: 50

-- Aymur
INSERT INTO `item_mods_pet` VALUES (21751,23,80,0); -- All Pets - ATT: 80

-- Arasy Lance
INSERT INTO `item_mods_pet` VALUES (21865,370,5,2); -- Wyvern - REGEN: 5

-- Arasy Lance +1
INSERT INTO `item_mods_pet` VALUES (21866,370,8,2); -- Wyvern - REGEN: 8

-- Arasy Rod
INSERT INTO `item_mods_pet` VALUES (22015,30,10,1); -- Avatar - MACC: 10

-- Arasy Rod +1
INSERT INTO `item_mods_pet` VALUES (22016,30,15,1); -- Avatar - MACC: 15

-- Grioavolr
INSERT INTO `item_mods_pet` VALUES (22054,28,115,1); -- Avatar - MATT: 115
INSERT INTO `item_mods_pet` VALUES (22054,30,35,1);  -- Avatar - MACC: 35

-- Nirvana
INSERT INTO `item_mods_pet` VALUES (22063,126,40,1); -- Avatar - BP_DAMAGE: 40

-- Arasy Staff
INSERT INTO `item_mods_pet` VALUES (22074,126,3,1); -- Avatar - BP_DAMAGE: 3

-- Arasy Staff +1
INSERT INTO `item_mods_pet` VALUES (22075,126,5,1); -- Avatar - BP_DAMAGE: 5

-- Draumstafir
INSERT INTO `item_mods_pet` VALUES (22096,25,50,1); -- Avatar - ACC: 50
INSERT INTO `item_mods_pet` VALUES (22096,26,50,1); -- Avatar - RACC: 50
INSERT INTO `item_mods_pet` VALUES (22096,30,50,1); -- Avatar - MACC: 50

-- Elan Strap
INSERT INTO `item_mods_pet` VALUES (22210,126,3,1); -- Avatar - BP_DAMAGE: 3

-- Elan Strap +1
INSERT INTO `item_mods_pet` VALUES (22211,126,5,1); -- Avatar - BP_DAMAGE: 5

-- Eminent Animator II
INSERT INTO `item_mods_pet` VALUES (22260,8,46,3);   -- Automaton - STR: 46
INSERT INTO `item_mods_pet` VALUES (22260,9,46,3);   -- Automaton - DEX: 46
INSERT INTO `item_mods_pet` VALUES (22260,10,46,3);  -- Automaton - VIT: 46
INSERT INTO `item_mods_pet` VALUES (22260,11,46,3);  -- Automaton - AGI: 46
INSERT INTO `item_mods_pet` VALUES (22260,12,46,3);  -- Automaton - INT: 46
INSERT INTO `item_mods_pet` VALUES (22260,13,46,3);  -- Automaton - MND: 46
INSERT INTO `item_mods_pet` VALUES (22260,14,46,3);  -- Automaton - CHR: 46

-- Divinator II
INSERT INTO `item_mods_pet` VALUES (22261,8,89,3);   -- Automaton - STR: 89
INSERT INTO `item_mods_pet` VALUES (22261,9,89,3);   -- Automaton - DEX: 89
INSERT INTO `item_mods_pet` VALUES (22261,10,89,3);  -- Automaton - VIT: 89
INSERT INTO `item_mods_pet` VALUES (22261,11,89,3);  -- Automaton - AGI: 89
INSERT INTO `item_mods_pet` VALUES (22261,12,89,3);  -- Automaton - INT: 89
INSERT INTO `item_mods_pet` VALUES (22261,13,89,3);  -- Automaton - MND: 89
INSERT INTO `item_mods_pet` VALUES (22261,14,89,3);  -- Automaton - CHR: 89

-- Totemic Helm +2
INSERT INTO `item_mods_pet` VALUES (23048,25,30,0); -- Pet: ACC: 30

-- Foire Taj +2
INSERT INTO `item_mods_pet` VALUES (23057,25,31,3);   -- Automaton - ACC: 31
INSERT INTO `item_mods_pet` VALUES (23057,369,1,3);   -- Automaton - REFRESH: 1
INSERT INTO `item_mods_pet` VALUES (23057,370,3,3);   -- Automaton - REGEN: 3
INSERT INTO `item_mods_pet` VALUES (23057,384,600,3); -- Automaton - HASTE_GEAR: 600

-- Ankusa Helm +2
INSERT INTO `item_mods_pet` VALUES (23071,384,500,0); -- All Pets - HASTE_GEAR: 5%

-- Glyphic Horn +2
INSERT INTO `item_mods_pet` VALUES (23077,23,47,1); -- Avatar: ATT: 47
INSERT INTO `item_mods_pet` VALUES (23077,28,53,1); -- Avatar: MATT: 53

-- Pitre Taj +2
INSERT INTO `item_mods_pet` VALUES (23080,23,47,3); -- Automaton: ATT: 47
INSERT INTO `item_mods_pet` VALUES (23080,24,47,3); -- Automaton: RATT: 47
INSERT INTO `item_mods_pet` VALUES (23080,25,27,3); -- Automaton: ACC: 27
INSERT INTO `item_mods_pet` VALUES (23080,26,27,3); -- Automaton: RACC: 27
INSERT INTO `item_mods_pet` VALUES (23080,369,4,3); -- Automaton: REFRESH: 4
INSERT INTO `item_mods_pet` VALUES (23080,370,4,3); -- Automaton: REGEN: 4

-- Bagua Galero +2
INSERT INTO `item_mods_pet` VALUES (23083,2,500,8); -- Luopan - HP: 500

-- Nukumi Cabasset +2
INSERT INTO `item_mods_pet` VALUES (23093,25,51,0); -- Pet: ACC: 51
INSERT INTO `item_mods_pet` VALUES (23093,26,51,0); -- Pet: RACC: 51
INSERT INTO `item_mods_pet` VALUES (23093,30,51,0); -- Pet: MACC: 51
-- TODO: Monster correlation effects +26

-- Peltast's Mezail +2
INSERT INTO `item_mods_pet` VALUES (23098,25,51,2);  -- Wyvern - ACC: 51
INSERT INTO `item_mods_pet` VALUES (23098,30,51,2);  -- Wyvern - MACC: 51
INSERT INTO `item_mods_pet` VALUES (23098,480,16,2); -- Wyvern - ABSORB_DMG_CHANCE: 16

-- Beckoner's Horn +2
INSERT INTO `item_mods_pet` VALUES (23099,25,51,1); -- Avatar - ACC: 51
INSERT INTO `item_mods_pet` VALUES (23099,26,51,1); -- Avatar - RACC: 51
INSERT INTO `item_mods_pet` VALUES (23099,30,51,1); -- Avatar - MACC: 51

-- Karagoz cappello +2
INSERT INTO `item_mods_pet` VALUES (23102,25,51,3);   -- Automaton: ACC: 51
INSERT INTO `item_mods_pet` VALUES (23102,26,51,3);   -- Automaton: RACC: 51
INSERT INTO `item_mods_pet` VALUES (23102,30,51,3);   -- Automaton: MACC: 51
INSERT INTO `item_mods_pet` VALUES (23102,995,575,3); -- Automaton: PET_TP_BONUS: 575

-- Azimuth Hood +2
INSERT INTO `item_mods_pet` VALUES (23105,370,4,8); -- Luopan: REGEN: 4

-- Vishap Mail +2
INSERT INTO `item_mods_pet` VALUES (23120,370,10,2); -- Wyvern - REGEN: 10

-- Convokers Doublet +2
INSERT INTO `item_mods_pet` VALUES (23121,25,35,1);  -- Avatar - ACC: 35
INSERT INTO `item_mods_pet` VALUES (23121,30,35,1);  -- Avatar - MACC: 35
INSERT INTO `item_mods_pet` VALUES (23121,126,14,1); -- Avatar - BP_DAMAGE: 14

-- Foire Tobe +2
INSERT INTO `item_mods_pet` VALUES (23124,2,165,3);   -- Automaton - HP: 165
INSERT INTO `item_mods_pet` VALUES (23124,5,165,3);   -- Automaton - MP: 165
INSERT INTO `item_mods_pet` VALUES (23124,384,400,3); -- Automaton - HASTE_GEAR: 400

-- Ankusa jackcoat +2
INSERT INTO `item_mods_pet` VALUES (23138,288,3,0);   -- Pet: DOUBLE_ATTACK: 3
INSERT INTO `item_mods_pet` VALUES (23138,384,600,0); -- Pet: HASTE_GEAR: 6%

-- Glyphic Doublet +2
INSERT INTO `item_mods_pet` VALUES (23144,165,16,1); -- Avatar: CRITHITRATE: 16
INSERT INTO `item_mods_pet` VALUES (23144,288,10,1); -- Avatar: DOUBLE_ATTACK: 10

-- Pitre Tobe +2
INSERT INTO `item_mods_pet` VALUES (23147,23,50,3); -- Automaton: ATT: 50
INSERT INTO `item_mods_pet` VALUES (23147,24,50,3); -- Automaton: RATT: 50
INSERT INTO `item_mods_pet` VALUES (23147,25,40,3); -- Automaton: ACC: 40
INSERT INTO `item_mods_pet` VALUES (23147,26,40,3); -- Automaton: RACC: 40
INSERT INTO `item_mods_pet` VALUES (23147,73,14,3); -- Automaton: STORETP: 14

-- Nukumi Gausape +2
INSERT INTO `item_mods_pet` VALUES (23160,25,54,0); -- Pet: ACC: 54
INSERT INTO `item_mods_pet` VALUES (23160,26,54,0); -- Pet: RACC: 54
INSERT INTO `item_mods_pet` VALUES (23160,30,54,0); -- Pet: MACC: 54

-- Peltast's plackart +2
INSERT INTO `item_mods_pet` VALUES (23165,25,54,2); -- Wyvern: ACC: 54
INSERT INTO `item_mods_pet` VALUES (23165,30,54,2); -- Wyvern: MACC: 54
-- TODO: Wyvern: Grants food effect

-- Beckoner's Doublet +2
INSERT INTO `item_mods_pet` VALUES (23166,25,54,1);  -- Avatar: ACC: 54
INSERT INTO `item_mods_pet` VALUES (23166,26,54,1);  -- Avatar: RACC: 54
INSERT INTO `item_mods_pet` VALUES (23166,30,54,1);  -- Avatar: MACC: 54
INSERT INTO `item_mods_pet` VALUES (23166,126,12,1); -- Avatar: BP_DAMAGE: 12

-- Karagoz Farsetto +2
INSERT INTO `item_mods_pet` VALUES (23169,25,54,3);   -- Automaton: ACC: 54
INSERT INTO `item_mods_pet` VALUES (23169,26,54,3);   -- Automaton: RACC: 54
INSERT INTO `item_mods_pet` VALUES (23169,30,54,3);   -- Automaton: MACC: 54

-- Foire Dastanas +2
INSERT INTO `item_mods_pet` VALUES (23191,25,32,3);   -- Automaton - ACC: 32
INSERT INTO `item_mods_pet` VALUES (23191,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Geomancy Mitaines +2
INSERT INTO `item_mods_pet` VALUES (23195,160,-1200,8); -- Luopan - DMG: -1200

-- Ankusa Gloves +2
INSERT INTO `item_mods_pet` VALUES (23205,161,-500,0); -- Pet: DMGPHYS: -5%

-- Pteroslaver finger gauntlets +2
INSERT INTO `item_mods_pet` VALUES (23210,163,-1000,2); -- Wyvern: DMGMAGIC: -10%

-- Glyphic Bracers +2
INSERT INTO `item_mods_pet` VALUES (23211,25,42,1);   -- Avatar: ACC: 42
INSERT INTO `item_mods_pet` VALUES (23211,384,600,1); -- Avatar: HASTE_GEAR: 6%

-- Pitre Dastanas +2
INSERT INTO `item_mods_pet` VALUES (23214,289,10,3);  -- Automaton: SUBTLE_BLOW: 10
INSERT INTO `item_mods_pet` VALUES (23214,384,600,3); -- Automaton: HASTE_GEAR: 6%

-- Beckoner's Bracers +2
INSERT INTO `item_mods_pet` VALUES (23227,25,52,0); -- Pet: ACC: 52
INSERT INTO `item_mods_pet` VALUES (23227,26,52,0); -- Pet: RACC: 52
INSERT INTO `item_mods_pet` VALUES (23227,30,52,0); -- Pet: MACC: 52

-- Peltast's vambraces +2
INSERT INTO `item_mods_pet` VALUES (23232,25,52,2); -- Wyvern: ACC: 52
INSERT INTO `item_mods_pet` VALUES (23232,30,52,2); -- Wyvern: MACC: 52

-- Beckoner's Bracers +2
INSERT INTO `item_mods_pet` VALUES (23233,25,52,1); -- Avatar: ACC: 52
INSERT INTO `item_mods_pet` VALUES (23233,26,52,1); -- Avatar: RACC: 52
INSERT INTO `item_mods_pet` VALUES (23233,30,52,1); -- Avatar: MACC: 52
INSERT INTO `item_mods_pet` VALUES (23233,126,8,1); -- Avatar: BP_DAMAGE: 8

-- Karagoz Guanti +2
INSERT INTO `item_mods_pet` VALUES (23236,8,21,3);  -- Automaton: STR: 21
INSERT INTO `item_mods_pet` VALUES (23236,9,21,3);  -- Automaton: DEX: 21
INSERT INTO `item_mods_pet` VALUES (23236,10,21,3); -- Automaton: AGI: 21
INSERT INTO `item_mods_pet` VALUES (23236,25,52,3); -- Automaton: ACC: 52
INSERT INTO `item_mods_pet` VALUES (23236,26,52,3); -- Automaton: RACC: 52
INSERT INTO `item_mods_pet` VALUES (23236,30,52,3); -- Automaton: MACC: 52

-- Totemic Trousers +2
INSERT INTO `item_mods_pet` VALUES (23249,23,30,0); -- Pet: ATT: 30

-- Vishap Brais +2
INSERT INTO `item_mods_pet` VALUES (23254,3,25,2); -- Wyvern - HPP: 25

-- Foire Churidars +2
INSERT INTO `item_mods_pet` VALUES (23258,5,75,3);     -- Automaton - MP: 75
INSERT INTO `item_mods_pet` VALUES (23258,160,-300,3); -- Automaton - DMG: -300
INSERT INTO `item_mods_pet` VALUES (23258,374,14,3);   -- Automaton - CURE_POTENCY: 14
INSERT INTO `item_mods_pet` VALUES (23258,384,400,3);  -- Automaton - HASTE_GEAR: 400

-- Ankusa Trousers +2
INSERT INTO `item_mods_pet` VALUES (23272,73,4,0);    -- Pet: STORETP: 4
INSERT INTO `item_mods_pet` VALUES (23272,384,500,0); -- Pet: HASTE_GEAR: 5%

-- Pteroslaver brais +2
INSERT INTO `item_mods_pet` VALUES (23277,161,-1000,2); -- Wyvern: DMGPHYS: -10%

-- Pteroslaver brais +2
INSERT INTO `item_mods_pet` VALUES (23278,28,44,1); -- Avatar: MATT: 44
INSERT INTO `item_mods_pet` VALUES (23278,30,35,1); -- Avatar: MACC: 35

-- Pitre Churidars +2
INSERT INTO `item_mods_pet` VALUES (23281,28,44,3); -- Automaton: MATT: 44
INSERT INTO `item_mods_pet` VALUES (23281,30,38,3); -- Automaton: MACC: 38
INSERT INTO `item_mods_pet` VALUES (23281,170,9,3); -- Automaton: FASTCAST: 9

-- Nukumi Quijotes +2
INSERT INTO `item_mods_pet` VALUES (23294,25,53,0); -- Pet: ACC: 53
INSERT INTO `item_mods_pet` VALUES (23294,26,53,0); -- Pet: RACC: 53
INSERT INTO `item_mods_pet` VALUES (23294,30,53,0); -- Pet: MACC: 53

-- Peltast's cuissots +2
INSERT INTO `item_mods_pet` VALUES (23299,25,53,2); -- Wyvern: ACC: 53
INSERT INTO `item_mods_pet` VALUES (23299,30,53,2); -- Wyvern: MACC: 53

-- Beckoner's spats +2
INSERT INTO `item_mods_pet` VALUES (23300,25,53,1); -- Avatar: ACC: 53
INSERT INTO `item_mods_pet` VALUES (23300,26,53,1); -- Avatar: RACC: 53
INSERT INTO `item_mods_pet` VALUES (23300,30,53,1); -- Avatar: MACC: 53

-- Karagoz pantaloni +2
INSERT INTO `item_mods_pet` VALUES (23303,25,53,3); -- Automaton: ACC: 53
INSERT INTO `item_mods_pet` VALUES (23303,26,53,3); -- Automaton: RACC: 53
INSERT INTO `item_mods_pet` VALUES (23303,30,53,3); -- Automaton: MACC: 53

-- Totemic Gaiters +2
INSERT INTO `item_mods_pet` VALUES (23316,23,20,0); -- Pet: ATT: 20
INSERT INTO `item_mods_pet` VALUES (23316,25,20,0); -- Pet: ACC: 20

-- Convokers Pigaches +2
INSERT INTO `item_mods_pet` VALUES (23322,23,30,1); -- Avatar: ACC: 30 
INSERT INTO `item_mods_pet` VALUES (23322,30,30,1); -- Avatar: MACC: 30
INSERT INTO `item_mods_pet` VALUES (23322,68,30,1); -- Avatar: EVA: 30
INSERT INTO `item_mods_pet` VALUES (23322,126,8,1); -- Avatar: BP_DAMAGE: 8 

-- Foire Babouches +2
INSERT INTO `item_mods_pet` VALUES (23325,28,20,3);   -- Automaton - MATT: 20
INSERT INTO `item_mods_pet` VALUES (23325,30,40,3);   -- Automaton - MACC: 40
INSERT INTO `item_mods_pet` VALUES (23325,384,400,3); -- Automaton - HASTE_GEAR: 400

-- Ankusa Gaiters +2
INSERT INTO `item_mods_pet` VALUES (23339,68,28,0);    -- Pet: EVA: 28
INSERT INTO `item_mods_pet` VALUES (23339,161,-400,0); -- Pet: DMGPHYS: -4%

-- Pteroslaver greaves +2
INSERT INTO `item_mods_pet` VALUES (23344,2,260,2); -- Wyvern: HP: 260
INSERT INTO `item_mods_pet` VALUES (23344,370,7,2); -- Wyvern: REGEN: 7

-- Glyphic pigaches +2
INSERT INTO `item_mods_pet` VALUES (23345,23,74,1);  -- Avatar: ATT: 74
INSERT INTO `item_mods_pet` VALUES (23345,25,26,1);  -- Avatar: ACC: 26
INSERT INTO `item_mods_pet` VALUES (23345,562,11,1); -- Avatar: MAGIC_CRITHITRATE: 11

-- Pitre Babouches +2
INSERT INTO `item_mods_pet` VALUES (23348,28,50,3); -- Automaton: MATT: 50
INSERT INTO `item_mods_pet` VALUES (23348,30,33,3); -- Automaton: MACC: 33

-- Bagua Sandals +2
INSERT INTO `item_mods_pet` VALUES (23351,370,4,8); -- Luopan - REGEN: 4

-- Nukumi Ocreae +2
INSERT INTO `item_mods_pet` VALUES (23361,25,50,0); -- Pet: ACC: 50
INSERT INTO `item_mods_pet` VALUES (23361,26,50,0); -- Pet: RACC: 50
INSERT INTO `item_mods_pet` VALUES (23361,30,50,0); -- Pet: MACC: 50

-- Peltast's schynbalds +2
INSERT INTO `item_mods_pet` VALUES (23366,25,50,2); -- Wyvern: ACC:  50
INSERT INTO `item_mods_pet` VALUES (23366,30,50,2); -- Wyvern: MACC: 50

-- Beckoner's pigaches +2
INSERT INTO `item_mods_pet` VALUES (23367,25,50,1); -- Avatar: ACC:  50
INSERT INTO `item_mods_pet` VALUES (23367,26,50,1); -- Avatar: RACC: 50
INSERT INTO `item_mods_pet` VALUES (23367,30,50,1); -- Avatar: MACC: 50
INSERT INTO `item_mods_pet` VALUES (23367,126,8,1); -- Avatar: BP_DAMAGE: 8

-- Karagoz Scarpe +2
INSERT INTO `item_mods_pet` VALUES (23370,12,25,3); -- Automaton: INT:  25
INSERT INTO `item_mods_pet` VALUES (23370,13,25,3); -- Automaton: MND:  25
INSERT INTO `item_mods_pet` VALUES (23370,25,50,3); -- Automaton: ACC:  50
INSERT INTO `item_mods_pet` VALUES (23370,26,50,3); -- Automaton: RACC: 50
INSERT INTO `item_mods_pet` VALUES (23370,30,50,3); -- Automaton: MACC: 50

-- Totemic Helm +3
INSERT INTO `item_mods_pet` VALUES (23383,25,40,0); -- Pet: ACC: 40

-- Foire Taj +3
INSERT INTO `item_mods_pet` VALUES (23392,25,41,3);   -- Automaton - ACC: 41
INSERT INTO `item_mods_pet` VALUES (23392,369,2,3);   -- Automaton - REFRESH: 2
INSERT INTO `item_mods_pet` VALUES (23392,370,6,3);   -- Automaton - REGEN: 6
INSERT INTO `item_mods_pet` VALUES (23392,384,700,3); -- Automaton - HASTE_GEAR: 700

-- Bagua Galero +3
INSERT INTO `item_mods_pet` VALUES (23418,2,600,8); -- Luopan - HP: 600

-- Vishap Mail +3
INSERT INTO `item_mods_pet` VALUES (23455,370,15,2); -- Wyvern - REGEN: 15

-- Convokers Doublet +3
INSERT INTO `item_mods_pet` VALUES (23456,25,45,1);  -- Avatar - ACC: 45
INSERT INTO `item_mods_pet` VALUES (23456,30,45,1);  -- Avatar - MACC: 45
INSERT INTO `item_mods_pet` VALUES (23456,126,16,1); -- Avatar - BP_DAMAGE: 16

-- Foire Tobe +3
INSERT INTO `item_mods_pet` VALUES (23459,2,220,3);   -- Automaton - HP: 220
INSERT INTO `item_mods_pet` VALUES (23459,5,220,3);   -- Automaton - MP: 220
INSERT INTO `item_mods_pet` VALUES (23459,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Foire Dastanas +3
INSERT INTO `item_mods_pet` VALUES (23526,25,42,3);   -- Automaton - ACC: 42
INSERT INTO `item_mods_pet` VALUES (23526,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Geomancy Mitaines +3
INSERT INTO `item_mods_pet` VALUES (23530,160,-1300,8); -- Luopan - DMG: -1300

-- Totemic Trousers +3
INSERT INTO `item_mods_pet` VALUES (23584,23,40,0); -- Pet: ATT: 40

-- Vishap Brais +3
INSERT INTO `item_mods_pet` VALUES (23589,3,27,2); -- Wyvern - HPP: 27

-- Foire Churidars +3
INSERT INTO `item_mods_pet` VALUES (23593,5,75,3);     -- Automaton - MP: 75
INSERT INTO `item_mods_pet` VALUES (23593,160,-600,3); -- Automaton - DMG: -600
INSERT INTO `item_mods_pet` VALUES (23593,374,14,3);   -- Automaton - CURE_POTENCY: 14
INSERT INTO `item_mods_pet` VALUES (23593,384,600,3);  -- Automaton - HASTE_GEAR: 600

-- Foire Babouches +3
INSERT INTO `item_mods_pet` VALUES (23660,28,25,3);   -- Automaton - MATT: 25
INSERT INTO `item_mods_pet` VALUES (23660,30,50,3);   -- Automaton - MACC: 50
INSERT INTO `item_mods_pet` VALUES (23660,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Ankusa Gaiters +3
INSERT INTO `item_mods_pet` VALUES (23674,68,38,0);    -- All Pets - EVA: 38
INSERT INTO `item_mods_pet` VALUES (23674,161,-500,0); -- All Pets - DMGPHYS: -500

-- Pteroslaver Greaves +3
INSERT INTO `item_mods_pet` VALUES (23679,2,290,2);  -- Wyvern - HP: 290
INSERT INTO `item_mods_pet` VALUES (23679,370,10,2); -- Wyvern - REGEN: 10

-- Glyphic Pigaches +3
INSERT INTO `item_mods_pet` VALUES (23680,23,89,1);  -- Avatar - ATT: 89
INSERT INTO `item_mods_pet` VALUES (23680,25,36,1);  -- Avatar - ACC: 36
INSERT INTO `item_mods_pet` VALUES (23680,562,13,1); -- Avatar - MAGIC_CRITHITRATE: 13

-- Pitre Babouches +3
INSERT INTO `item_mods_pet` VALUES (23683,28,57,3); -- Automaton - MATT: 57
INSERT INTO `item_mods_pet` VALUES (23683,30,43,3); -- Automaton - MACC: 43

-- Bagua Sandals +3
INSERT INTO `item_mods_pet` VALUES (23686,370,5,8); -- Luopan - REGEN: 5

-- Gletis Mask (Checked)
INSERT INTO `item_mods_pet` VALUES (23756,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23756,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23756,30,50,0); -- All Pets - MACC: 50

-- Mpacas Cap (Checked)
INSERT INTO `item_mods_pet` VALUES (23758,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23758,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23758,30,50,0); -- All Pets - MACC: 50

-- Bunzis Hat (Checked)
INSERT INTO `item_mods_pet` VALUES (23760,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23760,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23760,30,50,0); -- All Pets - MACC: 50

-- Nyame Helm (Checked)
INSERT INTO `item_mods_pet` VALUES (23761,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23761,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23761,30,50,0); -- All Pets - MACC: 50

-- Gletis Cuirass (Checked)
INSERT INTO `item_mods_pet` VALUES (23763,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23763,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23763,30,50,0); -- All Pets - MACC: 50

-- Mpacas Doublet (Checked)
INSERT INTO `item_mods_pet` VALUES (23765,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23765,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23765,30,50,0); -- All Pets - MACC: 50

-- Bunzis Robe (Checked)
INSERT INTO `item_mods_pet` VALUES (23767,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23767,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23767,30,50,0); -- All Pets - MACC: 50

-- Nyame Mail (Checked)
INSERT INTO `item_mods_pet` VALUES (23768,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23768,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23768,30,50,0); -- All Pets - MACC: 50

-- Gletis Gauntlets (Checked)
INSERT INTO `item_mods_pet` VALUES (23770,25,50,0);    -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23770,26,50,0);    -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23770,30,50,0);    -- All Pets - MACC: 50
INSERT INTO `item_mods_pet` VALUES (23770,160,-800,0); -- All Pets - DMG: -800

-- Mpacas Gloves (Checked)
INSERT INTO `item_mods_pet` VALUES (23772,25,50,0);  -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23772,26,50,0);  -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23772,30,50,0);  -- All Pets - MACC: 50
INSERT INTO `item_mods_pet` VALUES (23772,840,10,3); -- Automaton - ALL_WSDMG_ALL_HITS: 10

-- Bunzis Gloves (Checked)
INSERT INTO `item_mods_pet` VALUES (23774,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23774,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23774,30,50,0); -- All Pets - MACC: 50

-- Nyame Gauntlets (Checked)
INSERT INTO `item_mods_pet` VALUES (23775,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23775,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23775,30,50,0); -- All Pets - MACC: 50

-- Gletis Breeches (Checked)
INSERT INTO `item_mods_pet` VALUES (23777,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23777,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23777,30,50,0); -- All Pets - MACC: 50

-- Mpacas Hose (Checked)
INSERT INTO `item_mods_pet` VALUES (23779,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23779,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23779,30,50,0); -- All Pets - MACC: 50

-- Bunzis Pants (Checked)
INSERT INTO `item_mods_pet` VALUES (23781,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23781,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23781,30,50,0); -- All Pets - MACC: 50

-- Nyame Flanchard (Checked)
INSERT INTO `item_mods_pet` VALUES (23782,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23782,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23782,30,50,0); -- All Pets - MACC: 50

-- Gletis Boots (Checked)
INSERT INTO `item_mods_pet` VALUES (23784,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23784,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23784,30,50,0); -- All Pets - MACC: 50
-- TODO: Summoned Pet: Lvl +1

-- Mpacas Boots (Checked)
INSERT INTO `item_mods_pet` VALUES (23786,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23786,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23786,30,50,0); -- All Pets - MACC: 50

-- Bunzis Sabots (Checked)
INSERT INTO `item_mods_pet` VALUES (23788,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23788,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23788,30,50,0); -- All Pets - MACC: 50
-- TODO: Avatar: Lvl +1

-- Nyame Sollerets (Checked)
INSERT INTO `item_mods_pet` VALUES (23789,25,50,0); -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (23789,26,50,0); -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (23789,30,50,0); -- All Pets - MACC: 50

-- Beastmaster Collar
INSERT INTO `item_mods_pet` VALUES (25465,25,15,0); -- All Pets - ACC: 15
INSERT INTO `item_mods_pet` VALUES (25465,26,15,0); -- All Pets - RACC: 15
INSERT INTO `item_mods_pet` VALUES (25465,30,15,0); -- All Pets - MACC: 15

-- Beastmaster Collar +1
INSERT INTO `item_mods_pet` VALUES (25466,25,20,0); -- All Pets - ACC: 20
INSERT INTO `item_mods_pet` VALUES (25466,26,20,0); -- All Pets - RACC: 20
INSERT INTO `item_mods_pet` VALUES (25466,30,20,0); -- All Pets - MACC: 20

-- Beastmaster Collar +2
INSERT INTO `item_mods_pet` VALUES (25467,25,25,0); -- All Pets - ACC: 25
INSERT INTO `item_mods_pet` VALUES (25467,26,25,0); -- All Pets - RACC: 25
INSERT INTO `item_mods_pet` VALUES (25467,30,25,0); -- All Pets - MACC: 25

-- Summoners Collar
INSERT INTO `item_mods_pet` VALUES (25501,25,15,1); -- Avatar - ACC: 15
INSERT INTO `item_mods_pet` VALUES (25501,26,15,1); -- Avatar - RACC: 15
INSERT INTO `item_mods_pet` VALUES (25501,30,15,1); -- Avatar - MACC: 15

-- Summoners Collar +1
INSERT INTO `item_mods_pet` VALUES (25502,25,20,1); -- Avatar - ACC: 20
INSERT INTO `item_mods_pet` VALUES (25502,26,20,1); -- Avatar - RACC: 20
INSERT INTO `item_mods_pet` VALUES (25502,30,20,1); -- Avatar - MACC: 20

-- Summoners Collar +2
INSERT INTO `item_mods_pet` VALUES (25503,25,25,1); -- Avatar - ACC: 25
INSERT INTO `item_mods_pet` VALUES (25503,26,25,1); -- Avatar - RACC: 25
INSERT INTO `item_mods_pet` VALUES (25503,30,25,1); -- Avatar - MACC: 25

-- Puppetmasters Collar
INSERT INTO `item_mods_pet` VALUES (25519,25,15,3); -- Automaton - ACC: 15
INSERT INTO `item_mods_pet` VALUES (25519,26,15,3); -- Automaton - RACC: 15
INSERT INTO `item_mods_pet` VALUES (25519,30,15,3); -- Automaton - MACC: 15

-- Puppetmasters Collar +1
INSERT INTO `item_mods_pet` VALUES (25520,25,20,3); -- Automaton - ACC: 20
INSERT INTO `item_mods_pet` VALUES (25520,26,20,3); -- Automaton - RACC: 20
INSERT INTO `item_mods_pet` VALUES (25520,30,20,3); -- Automaton - MACC: 20

-- Puppetmasters Collar +2
INSERT INTO `item_mods_pet` VALUES (25521,25,25,3); -- Automaton - ACC: 25
INSERT INTO `item_mods_pet` VALUES (25521,26,25,3); -- Automaton - RACC: 25
INSERT INTO `item_mods_pet` VALUES (25521,30,25,3); -- Automaton - MACC: 25

-- Heyoka Cap
INSERT INTO `item_mods_pet` VALUES (25563,25,40,0);   -- All Pets - ACC: 40
INSERT INTO `item_mods_pet` VALUES (25563,26,40,0);   -- All Pets - RACC: 40
INSERT INTO `item_mods_pet` VALUES (25563,27,8,0);    -- All Pets - ENMITY: 8
INSERT INTO `item_mods_pet` VALUES (25563,384,600,0); -- All Pets - HASTE_GEAR: 600

-- Heyoka Cap +1
INSERT INTO `item_mods_pet` VALUES (25564,25,50,0);   -- All Pets - ACC: 50
INSERT INTO `item_mods_pet` VALUES (25564,26,50,0);   -- All Pets - RACC: 50
INSERT INTO `item_mods_pet` VALUES (25564,27,10,0);   -- All Pets - ENMITY: 10
INSERT INTO `item_mods_pet` VALUES (25564,384,600,0); -- All Pets - HASTE_GEAR: 600

-- Baayami Hat
INSERT INTO `item_mods_pet` VALUES (25565,368,3,1); -- Avatar - REGAIN: 3

-- Baayami Hat +1
INSERT INTO `item_mods_pet` VALUES (25566,368,4,1); -- Avatar - REGAIN: 4

-- Cath Palug Crown (Checked)
INSERT INTO `item_mods_pet` VALUES (25593,25,38,1);  -- Avatar - ACC: 38
INSERT INTO `item_mods_pet` VALUES (25593,26,38,1);  -- Avatar - RACC: 38
INSERT INTO `item_mods_pet` VALUES (25593,28,38,1);  -- Avatar - MATT: 38
INSERT INTO `item_mods_pet` VALUES (25593,30,38,1);  -- Avatar - MACC: 38
INSERT INTO `item_mods_pet` VALUES (25593,126,10,1); -- Avatar - BP_DAMAGE: 10

-- Emicho Haubert +1 (Checked)
INSERT INTO `item_mods_pet` VALUES (25683,28,35,0);    -- All Pets - MATT: 35
INSERT INTO `item_mods_pet` VALUES (25683,160,-400,0); -- All Pets - DMG: -400

-- Shulmanu Collar (Checked)
INSERT INTO `item_mods_pet` VALUES (26026,23,20,0); -- All Pets - ATT: 20
INSERT INTO `item_mods_pet` VALUES (26026,25,20,0); -- All Pets - ACC: 20
INSERT INTO `item_mods_pet` VALUES (26026,288,5,0); -- All Pets - DOUBLE_ATTACK: 5

-- Lugalbanda Earring (Checked)
INSERT INTO `item_mods_pet` VALUES (26082,25,15,1);  -- Avatar - ACC: 15
INSERT INTO `item_mods_pet` VALUES (26082,26,15,1);  -- Avatar - RACC: 15
INSERT INTO `item_mods_pet` VALUES (26082,30,15,1);  -- Avatar - MACC: 15
INSERT INTO `item_mods_pet` VALUES (26082,126,10,1); -- Avatar - BP_DAMAGE: 10

-- Thurandaut Ring +1 (Checked)
INSERT INTO `item_mods_pet` VALUES (26201,23,23,0);    -- All Pets - ATT: 23
INSERT INTO `item_mods_pet` VALUES (26201,24,23,0);    -- All Pets - RATT: 23
INSERT INTO `item_mods_pet` VALUES (26201,25,22,0);    -- All Pets - ACC: 22
INSERT INTO `item_mods_pet` VALUES (26201,26,22,0);    -- All Pets - RACC: 22
INSERT INTO `item_mods_pet` VALUES (26201,160,-400,0); -- All Pets - DMG: -400
INSERT INTO `item_mods_pet` VALUES (26201,384,400,0);  -- All Pets - HASTE_GEAR: 400

-- Scintillating Cape (Checked)
INSERT INTO `item_mods_pet` VALUES (26241,23,16,0); -- All Pets - ATT: 16
INSERT INTO `item_mods_pet` VALUES (26241,28,16,0); -- All Pets - MATT: 16
INSERT INTO `item_mods_pet` VALUES (26241,165,3,0); -- All Pets - CRITHITRATE: 3

-- Campestress Cape
INSERT INTO `item_mods_pet` VALUES (26260,126,5,1); -- Avatar - BP_DAMAGE: 5

-- Ankusa Helm
INSERT INTO `item_mods_pet` VALUES (26640,384,300,0); -- Pet: HASTE_GEAR: 3%

-- Ankusa Helm +1
INSERT INTO `item_mods_pet` VALUES (26641,384,400,0); -- Pet: HASTE_GEAR: 4%

-- Glyphic Horn
INSERT INTO `item_mods_pet` VALUES (26652,28,20,1); -- Avatar - MATT: 20

-- Glyphic Horn +1
INSERT INTO `item_mods_pet` VALUES (26653,28,23,1); -- Avatar - MATT: 23

-- Pitre Taj
INSERT INTO `item_mods_pet` VALUES (26658,369,2,3); -- Automaton - REFRESH: 2
INSERT INTO `item_mods_pet` VALUES (26658,370,3,3); -- Automaton - REGEN: 3

-- Pitre Taj +1
INSERT INTO `item_mods_pet` VALUES (26659,369,3,3); -- Automaton - REFRESH: 3
INSERT INTO `item_mods_pet` VALUES (26659,370,3,3); -- Automaton - REGEN: 3

-- Apogee Crown +1
INSERT INTO `item_mods_pet` VALUES (26677,2,110,1); -- Avatar - HP: 110
INSERT INTO `item_mods_pet` VALUES (26677,25,35,1); -- Avatar - ACC: 35
INSERT INTO `item_mods_pet` VALUES (26677,27,10,1); -- Avatar - ENMITY: 10

-- Karagoz Capello
INSERT INTO `item_mods_pet` VALUES (26774,345,525,3); -- Automaton - TP_BONUS: 525

-- Karagoz Capello +1
INSERT INTO `item_mods_pet` VALUES (26775,345,550,3); -- Automaton - TP_BONUS: 550

-- Ankusa Jackcoat
INSERT INTO `item_mods_pet` VALUES (26816,384,400,0); -- Pet: HASTE_GEAR: 4%

-- Ankusa Jackcoat +1
INSERT INTO `item_mods_pet` VALUES (26817,384,500,0); -- Pet: HASTE_GEAR: 5%

-- Glyphic Doublet
INSERT INTO `item_mods_pet` VALUES (26828,165,8,1); -- Avatar - CRITHITRATE: 8

-- Glyphic Doublet +1
INSERT INTO `item_mods_pet` VALUES (26829,165,12,1); -- Avatar - CRITHITRATE: 12

-- Pitre Tobe
INSERT INTO `item_mods_pet` VALUES (26834,25,18,3); -- Automaton - ACC: 18
INSERT INTO `item_mods_pet` VALUES (26834,26,18,3); -- Automaton - RACC: 18
INSERT INTO `item_mods_pet` VALUES (26834,73,12,3); -- Automaton - STORETP: 12

-- Pitre Tobe +1
INSERT INTO `item_mods_pet` VALUES (26835,25,21,3); -- Automaton - ACC: 21
INSERT INTO `item_mods_pet` VALUES (26835,26,21,3); -- Automaton - RACC: 21
INSERT INTO `item_mods_pet` VALUES (26835,73,13,3); -- Automaton - STORETP: 13

-- Apogee Dalmatica +1 (Checked)
INSERT INTO `item_mods_pet` VALUES (26853,2,160,1); -- Avatar - HP: 160

-- Shomonjijoe +1
INSERT INTO `item_mods_pet` VALUES (26888,27,14,1); -- Avatar - ENMITY: 14

-- Beckoners Doublet
INSERT INTO `item_mods_pet` VALUES (26926,126,10,1); -- Avatar - BP_DAMAGE: 10

-- Beckoners Doublet +1
INSERT INTO `item_mods_pet` VALUES (26927,126,11,1); -- Avatar - BP_DAMAGE: 11

-- Ankusa Gloves
INSERT INTO `item_mods_pet` VALUES (26992,161,-300,0); -- Pet: DMGPHYS: -3%

-- Ankusa Gloves +1
INSERT INTO `item_mods_pet` VALUES (26993,161,-400,0); -- Pet: DMGPHYS: -4%

-- Glyphic Bracers
INSERT INTO `item_mods_pet` VALUES (27004,25,20,1);   -- Avatar - ACC: 20
INSERT INTO `item_mods_pet` VALUES (27004,384,200,1); -- Avatar - HASTE_GEAR: 200

-- Glyphic Bracers +1
INSERT INTO `item_mods_pet` VALUES (27005,25,28,1);   -- Avatar - ACC: 28
INSERT INTO `item_mods_pet` VALUES (27005,384,300,1); -- Avatar - HASTE_GEAR: 300

-- Pitre Dastanas
INSERT INTO `item_mods_pet` VALUES (27010,289,7,3);   -- Automaton - SUBTLE_BLOW: 7
INSERT INTO `item_mods_pet` VALUES (27010,384,400,3); -- Automaton - HASTE_GEAR: 400

-- Pitre Dastanas +1
INSERT INTO `item_mods_pet` VALUES (27011,289,9,3);   -- Automaton - SUBTLE_BLOW: 9
INSERT INTO `item_mods_pet` VALUES (27011,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Crushers Gauntlets
INSERT INTO `item_mods_pet` VALUES (27044,2,50,2); -- Wyvern - HP: 50

-- Beckoners Bracers
INSERT INTO `item_mods_pet` VALUES (27080,25,20,1); -- Avatar - ACC: 20

-- Beckoners Bracers +1
INSERT INTO `item_mods_pet` VALUES (27081,25,30,1); -- Avatar - ACC: 30

-- Karagoz Guanti
INSERT INTO `item_mods_pet` VALUES (27086,8,13,3);  -- Automaton - STR: 13
INSERT INTO `item_mods_pet` VALUES (27086,9,13,3);  -- Automaton - DEX: 13
INSERT INTO `item_mods_pet` VALUES (27086,11,13,3); -- Automaton - AGI: 13

-- Karagoz Guanti +1
INSERT INTO `item_mods_pet` VALUES (27087,8,16,3);  -- Automaton - STR: 16
INSERT INTO `item_mods_pet` VALUES (27087,9,16,3);  -- Automaton - DEX: 16
INSERT INTO `item_mods_pet` VALUES (27087,11,16,3); -- Automaton - AGI: 16

-- Asteria Mitts
INSERT INTO `item_mods_pet` VALUES (27106,28,25,1); -- Avatar - MATT: 25

-- Asteria Mitts +1
INSERT INTO `item_mods_pet` VALUES (27107,28,26,1); -- Avatar - MATT: 26

-- Lamassu Mitts
INSERT INTO `item_mods_pet` VALUES (27108,28,25,1); -- Avatar - MATT: 25

-- Lamassu Mitts +1
INSERT INTO `item_mods_pet` VALUES (27109,28,26,1); -- Avatar - MATT: 26

-- Ankusa Trousers
INSERT INTO `item_mods_pet` VALUES (27168,384,300,0); -- Pet: HASTE_GEAR: 3%

-- Ankusa Trousers +1
INSERT INTO `item_mods_pet` VALUES (27169,384,400,0); -- Pet: HASTE_GEAR: 4%

-- Glyphic Spats
INSERT INTO `item_mods_pet` VALUES (27180,30,10,1); -- Avatar - MACC: 10

-- Glyphic Spats +1
INSERT INTO `item_mods_pet` VALUES (27181,30,13,1); -- Avatar - MACC: 13

-- Pitre Churidars
INSERT INTO `item_mods_pet` VALUES (27186,30,15,3); -- Automaton - MACC: 15
INSERT INTO `item_mods_pet` VALUES (27186,170,7,3); -- Automaton - FASTCAST: 7

-- Pitre Churidars +1
INSERT INTO `item_mods_pet` VALUES (27187,30,18,3); -- Automaton - MACC: 18
INSERT INTO `item_mods_pet` VALUES (27187,170,8,3); -- Automaton - FASTCAST: 8

-- Avatara Slops
INSERT INTO `item_mods_pet` VALUES (27221,27,4,1);  -- Avatar - ENMITY: 4
INSERT INTO `item_mods_pet` VALUES (27221,126,7,1); -- Avatar - BP_DAMAGE: 7

-- Beckoners Spats
INSERT INTO `item_mods_pet` VALUES (27265,345,550,1); -- Avatar - TP_BONUS: 550

-- Beckoners Spats +1
INSERT INTO `item_mods_pet` VALUES (27266,345,600,1); -- Avatar - TP_BONUS: 600

-- Emicho Hose +1 (Checked)
INSERT INTO `item_mods_pet` VALUES (27299,3,21,2); -- Wyvern - HPP: 21
INSERT INTO `item_mods_pet` VALUES (27299,165,5,0); -- Wyvern - CRITHITRATE: 5
INSERT INTO `item_mods_pet` VALUES (27299,288,5,0); -- All Pets - DOUBLE_ATTACK: 5

-- Ankusa Gaiters
INSERT INTO `item_mods_pet` VALUES (27344,68,15,0);    -- Pet: EVA: 15
INSERT INTO `item_mods_pet` VALUES (27344,161,-300,0); -- Pet: DMGPHYS: -3%

-- Ankusa Gaiters +1
INSERT INTO `item_mods_pet` VALUES (27345,68,18,0);    -- Pet: EVA: 18
INSERT INTO `item_mods_pet` VALUES (27345,161,-300,0); -- Pet: DMGPHYS: -3%

-- Glyphic Pigaches
INSERT INTO `item_mods_pet` VALUES (27356,23,28,1); -- Avatar - ATT: 28
INSERT INTO `item_mods_pet` VALUES (27356,562,7,1); -- Avatar - MAGIC_CRITHITRATE: 7

-- Glyphic Pigaches +1
INSERT INTO `item_mods_pet` VALUES (27357,23,28,1); -- Avatar - ATT: 28
INSERT INTO `item_mods_pet` VALUES (27357,562,9,1); -- Avatar - MAGIC_CRITHITRATE: 9

-- Pitre Babouches
INSERT INTO `item_mods_pet` VALUES (27362,28,15,3); -- Automaton - MATT: 15
INSERT INTO `item_mods_pet` VALUES (27362,30,12,3); -- Automaton - MACC: 12

-- Pitre Babouches +1
INSERT INTO `item_mods_pet` VALUES (27363,28,18,3); -- Automaton - MATT: 18
INSERT INTO `item_mods_pet` VALUES (27363,30,15,3); -- Automaton - MACC: 15

-- Bagua Sandals
INSERT INTO `item_mods_pet` VALUES (27368,370,2,8); -- Luopan - REGEN: 2

-- Bagua Sandals +1
INSERT INTO `item_mods_pet` VALUES (27369,370,3,8); -- Luopan - REGEN: 3

-- Beckoners Pigaches
INSERT INTO `item_mods_pet` VALUES (27439,30,17,1); -- Avatar - MACC: 17

-- Beckoners Pigaches +1
INSERT INTO `item_mods_pet` VALUES (27440,30,27,1); -- Avatar - MACC: 27

-- Karagoz Scarpe
INSERT INTO `item_mods_pet` VALUES (27445,12,17,3); -- Automaton - INT: 17
INSERT INTO `item_mods_pet` VALUES (27445,13,17,3); -- Automaton - MND: 17

-- Karagoz Scarpe +1
INSERT INTO `item_mods_pet` VALUES (27446,12,20,3); -- Automaton - INT: 20
INSERT INTO `item_mods_pet` VALUES (27446,13,20,3); -- Automaton - MND: 20

-- Emicho Gambieras +1 (Checked)
INSERT INTO `item_mods_pet` VALUES (27470,480,6,2); -- Wyvern - ABSORB_DMG_CHANCE: 6

-- Totemic Helm
INSERT INTO `item_mods_pet` VALUES (27671,25,20,0); -- Pet: ACC: 20

-- Convokers Horn
INSERT INTO `item_mods_pet` VALUES (27677,27,4,1); -- Avatar - ENMITY: 4

-- Foire Taj
INSERT INTO `item_mods_pet` VALUES (27680,71,6,3);    -- Automaton - MPHEAL: 6
INSERT INTO `item_mods_pet` VALUES (27680,72,6,3);    -- Automaton - HPHEAL: 6
INSERT INTO `item_mods_pet` VALUES (27680,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Totemic Helm +1
INSERT INTO `item_mods_pet` VALUES (27692,25,20,0); -- Pet: ACC: 20

-- Convokers Horn +1
INSERT INTO `item_mods_pet` VALUES (27698,27,4,1); -- Avatar - ENMITY: 4

-- Foire Taj +1
INSERT INTO `item_mods_pet` VALUES (27701,71,8,3);    -- Automaton - MPHEAL: 8
INSERT INTO `item_mods_pet` VALUES (27701,72,8,3);    -- Automaton - HPHEAL: 8
INSERT INTO `item_mods_pet` VALUES (27701,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Vishap Mail
INSERT INTO `item_mods_pet` VALUES (27820,370,2,2); -- Wyvern - REGEN: 2

-- Convokers Doublet
INSERT INTO `item_mods_pet` VALUES (27821,126,11,1); -- Avatar - BP_DAMAGE: 11

-- Foire Tobe
INSERT INTO `item_mods_pet` VALUES (27824,2,85,3);    -- Automaton - HP: 85
INSERT INTO `item_mods_pet` VALUES (27824,5,85,3);    -- Automaton - MP: 85
INSERT INTO `item_mods_pet` VALUES (27824,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Vishap Mail +1
INSERT INTO `item_mods_pet` VALUES (27841,370,3,2); -- Wyvern - REGEN: 3

-- Convokers Doublet +1
INSERT INTO `item_mods_pet` VALUES (27842,126,12,1); -- Avatar - BP_DAMAGE: 12

-- Foire Tobe +1
INSERT INTO `item_mods_pet` VALUES (27845,2,110,3);   -- Automaton - HP: 110
INSERT INTO `item_mods_pet` VALUES (27845,5,110,3);   -- Automaton - MP: 110
INSERT INTO `item_mods_pet` VALUES (27845,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Totemic Gloves
INSERT INTO `item_mods_pet` VALUES (27951,384,300,0); -- Pet: HASTE_GEAR: 3%

-- Convokers Bracers
INSERT INTO `item_mods_pet` VALUES (27957,27,5,1); -- Avatar - ENMITY: 5

-- Foire Dastanas
INSERT INTO `item_mods_pet` VALUES (27960,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Totemic Gloves
INSERT INTO `item_mods_pet` VALUES (27972,384,300,0); -- Pet: HASTE_GEAR: 3%

-- Convokers Bracers +1
INSERT INTO `item_mods_pet` VALUES (27978,27,5,1); -- Avatar - ENMITY: 5

-- Foire Dastanas +1
INSERT INTO `item_mods_pet` VALUES (27981,384,400,3); -- Automaton - HASTE_GEAR: 400

-- Geomancy Mitaines +1
INSERT INTO `item_mods_pet` VALUES (27985,160,-1100,8); -- Luopan - DMG: -1100

-- Regimen Mittens
INSERT INTO `item_mods_pet` VALUES (28025,25,20,0);   -- All Pets - ACC: 20
INSERT INTO `item_mods_pet` VALUES (28025,26,20,0);   -- All Pets - RACC: 20
INSERT INTO `item_mods_pet` VALUES (28025,30,20,0);   -- All Pets - MACC: 20
INSERT INTO `item_mods_pet` VALUES (28025,384,600,0); -- All Pets - HASTE_GEAR: 600

-- Geomancy Mitaines
INSERT INTO `item_mods_pet` VALUES (28066,160,-1000,8); -- Luopan - DMG: -1000

-- Totemic Trousers
INSERT INTO `item_mods_pet` VALUES (28098,23,20,0); -- Pet: ATT: 20

-- Vishap Brais
INSERT INTO `item_mods_pet` VALUES (28103,3,20,2); -- Wyvern - HPP: 20

-- Convokers Spats
INSERT INTO `item_mods_pet` VALUES (28104,25,20,1); -- Avatar - ACC: 20
INSERT INTO `item_mods_pet` VALUES (28104,27,4,1);  -- Avatar - ENMITY: 4

-- Foire Churidars
INSERT INTO `item_mods_pet` VALUES (28107,5,40,3);    -- Automaton - MP: 40
INSERT INTO `item_mods_pet` VALUES (28107,374,10,3);  -- Automaton - CURE_POTENCY: 10
INSERT INTO `item_mods_pet` VALUES (28107,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Totemic Trousers +1
INSERT INTO `item_mods_pet` VALUES (28119,23,20,0); -- All Pets - ATT: 20

-- Vishap Brais +1
INSERT INTO `item_mods_pet` VALUES (28124,3,23,2); -- Wyvern - HPP: 23

-- Convokers Spats +1
INSERT INTO `item_mods_pet` VALUES (28125,25,20,1); -- Avatar - ACC: 20
INSERT INTO `item_mods_pet` VALUES (28125,27,4,1);  -- Avatar - ENMITY: 4

-- Foire Churidars +1
INSERT INTO `item_mods_pet` VALUES (28128,5,50,3);    -- Automaton - MP: 50
INSERT INTO `item_mods_pet` VALUES (28128,374,12,3);  -- Automaton - CURE_POTENCY: 12
INSERT INTO `item_mods_pet` VALUES (28128,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Wisent Kecks
INSERT INTO `item_mods_pet` VALUES (28141,23,10,0);   -- All Pets - ATT: 10
INSERT INTO `item_mods_pet` VALUES (28141,24,10,0);   -- All Pets - RATT: 10
INSERT INTO `item_mods_pet` VALUES (28141,25,20,0);   -- All Pets - ACC: 20
INSERT INTO `item_mods_pet` VALUES (28141,26,20,0);   -- All Pets - RACC: 20
INSERT INTO `item_mods_pet` VALUES (28141,68,20,0);   -- All Pets - EVA: 20
INSERT INTO `item_mods_pet` VALUES (28141,384,300,0); -- All Pets - HASTE_GEAR: 300

-- Marduks Crackows +1
INSERT INTO `item_mods_pet` VALUES (28211,23,15,1);   -- Avatar - ATT: 15
INSERT INTO `item_mods_pet` VALUES (28211,384,200,1); -- Avatar - HASTE_GEAR: 200

-- Kers Sollerets
INSERT INTO `item_mods_pet` VALUES (28213,23,13,2); -- Wyvern - ATT: 13

-- Sigyns Jambeaux
INSERT INTO `item_mods_pet` VALUES (28214,68,5,0); -- All Pets - EVA: 5

-- Idis Ledelsens
INSERT INTO `item_mods_pet` VALUES (28219,68,2,0); -- All Pets - EVA: 2

-- Totemic Gaiters
INSERT INTO `item_mods_pet` VALUES (28231,23,10,0); -- All Pets - ATT: 10
INSERT INTO `item_mods_pet` VALUES (28231,25,10,0); -- All Pets - ACC: 10

-- Convokers Pigaches
INSERT INTO `item_mods_pet` VALUES (28237,27,5,1);  -- Avatar - ENMITY: 5
INSERT INTO `item_mods_pet` VALUES (28237,68,20,1); -- Avatar - EVA: 20
INSERT INTO `item_mods_pet` VALUES (28237,126,5,1); -- Avatar - BP_DAMAGE: 5

-- Foire Babouches
INSERT INTO `item_mods_pet` VALUES (28240,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Totemic Gaiters +1
INSERT INTO `item_mods_pet` VALUES (28252,23,10,0); -- All Pets - ATT: 10
INSERT INTO `item_mods_pet` VALUES (28252,25,10,0); -- All Pets - ACC: 10

-- Convokers Pigaches +1
INSERT INTO `item_mods_pet` VALUES (28258,27,5,1);  -- Avatar - ENMITY: 5
INSERT INTO `item_mods_pet` VALUES (28258,68,20,1); -- Avatar - EVA: 20
INSERT INTO `item_mods_pet` VALUES (28258,126,6,1); -- Avatar - BP_DAMAGE: 6

-- Foire Babouches +1
INSERT INTO `item_mods_pet` VALUES (28261,384,300,3); -- Automaton - HASTE_GEAR: 300

-- Eidolon Pendant +1
INSERT INTO `item_mods_pet` VALUES (28356,28,5,1); -- Avatar - MATT: 5

-- Incarnation Sash (Checked)
INSERT INTO `item_mods_pet` VALUES (28418,25,15,0); -- All Pets - ACC: 15
INSERT INTO `item_mods_pet` VALUES (28418,26,15,0); -- All Pets - RACC: 15
INSERT INTO `item_mods_pet` VALUES (28418,30,15,0); -- All Pets - MACC: 15
INSERT INTO `item_mods_pet` VALUES (28418,288,4,0); -- All Pets - DOUBLE_ATTACK: 4

-- Ukko Sash
INSERT INTO `item_mods_pet` VALUES (28432,25,15,3);   -- Automaton - ACC: 15
INSERT INTO `item_mods_pet` VALUES (28432,26,15,3);   -- Automaton - RACC: 15
INSERT INTO `item_mods_pet` VALUES (28432,30,15,3);   -- Automaton - MACC: 15
INSERT INTO `item_mods_pet` VALUES (28432,170,5,3);   -- Automaton - FASTCAST: 5
INSERT INTO `item_mods_pet` VALUES (28432,384,500,3); -- Automaton - HASTE_GEAR: 500

-- Handlers Earring (Checked)
INSERT INTO `item_mods_pet` VALUES (28490,161,-300,0); -- All Pets - DMGPHYS: -300

-- Handlers Earring +1 (Checked)
INSERT INTO `item_mods_pet` VALUES (28491,161,-400,0); -- All Pets - DMGPHYS: -400

-- Rimeice Earring
INSERT INTO `item_mods_pet` VALUES (28495,27,5,0);    -- All Pets - ENMITY: 5
INSERT INTO `item_mods_pet` VALUES (28495,160,100,0); -- All Pets - DMG: 100
INSERT INTO `item_mods_pet` VALUES (28495,384,300,0); -- All Pets - HASTE_GEAR: 300

-- Karagoz Mantle +1
INSERT INTO `item_mods_pet` VALUES (28588,23,15,3); -- Automaton - ATT: 15
INSERT INTO `item_mods_pet` VALUES (28588,25,15,3); -- Automaton - ACC: 15
INSERT INTO `item_mods_pet` VALUES (28588,68,10,3); -- Automaton - EVA: 10

-- Samanisi Cape
INSERT INTO `item_mods_pet` VALUES (28605,25,7,1); -- Avatar - ACC: 7
INSERT INTO `item_mods_pet` VALUES (28605,30,7,1); -- Avatar - MACC: 7

-- Refraction Cape
INSERT INTO `item_mods_pet` VALUES (28643,12,8,3); -- Automaton - INT: 8
INSERT INTO `item_mods_pet` VALUES (28643,13,8,3); -- Automaton - MND: 8
INSERT INTO `item_mods_pet` VALUES (28643,30,3,3); -- Automaton - MACC: 3
