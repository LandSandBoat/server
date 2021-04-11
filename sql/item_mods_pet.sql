-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- G?n?r? le : Dim 07 Octobre 2012 ? 09:39
-- Version du serveur: 6.0.0
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de donn?es: `xidb`
--

-- --------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 PACK_KEYS=1;

-- (Please keep item ID sequential)
INSERT INTO `item_mods_pet` VALUES (10296,25,3,3);      -- Charivari Earring Automaton: Accuracy+3
INSERT INTO `item_mods_pet` VALUES (10296,26,3,3);      -- Automaton: Ranged Accuracy+3
INSERT INTO `item_mods_pet` VALUES (10296,30,3,3);      -- Automaton: Magic Accuracy+3
INSERT INTO `item_mods_pet` VALUES (10299,288,2,0);     -- Sabong Earring Pet: "Double Attack"+2%
INSERT INTO `item_mods_pet` VALUES (10370,28,3,1);      -- Shedir crackows Avatar: Enhances "Magic Atk. Bonus" +3
INSERT INTO `item_mods_pet` VALUES (10370,30,3,1);      -- Enhances magic accuracy +3
INSERT INTO `item_mods_pet` VALUES (10370,126,3,1);     -- Increases "Blood Pact" damage +3%
INSERT INTO `item_mods_pet` VALUES (10440,384,600,3);   -- Murzim Zucchetto Automaton: Haste+6%
INSERT INTO `item_mods_pet` VALUES (10530,28,5,1);      -- Tethyan Cuffs +1 Avatar: "Magic Atk. Bonus"+5
INSERT INTO `item_mods_pet` VALUES (10531,28,5,1);      -- Tethyan Cuffs +2 Avatar: "Magic Atk. Bonus"+5
INSERT INTO `item_mods_pet` VALUES (10532,28,5,1);      -- Tethyan Cuffs +3 Avatar: "Magic Atk. Bonus"+5
INSERT INTO `item_mods_pet` VALUES (10537,23,9,1);      -- Auspex Gages Enhances avatar attack +9
INSERT INTO `item_mods_pet` VALUES (10537,126,4,1);     -- Increases "Blood Pact" damage 4%
INSERT INTO `item_mods_pet` VALUES (10542,23,12,1);     -- Spurrina Gages Enhances avatar attack +12
INSERT INTO `item_mods_pet` VALUES (10542,126,5,1);     -- Increases "Blood Pact" damage 5%
INSERT INTO `item_mods_pet` VALUES (10664,28,4,1);      -- Smn. Horn +2 Avatar: "Magic Atk. Bonus"+4 Perpetuation cost -3
INSERT INTO `item_mods_pet` VALUES (10664,346,3,1);     -- Avatar: Perpetuation cost -3
INSERT INTO `item_mods_pet` VALUES (10684,165,6,1);     -- Smn. Doublet +2 Avatar Critical hit rate +6%
INSERT INTO `item_mods_pet` VALUES (10684,346,3,1);     -- Avatar: Perpetuation cost -3
-- INSERT INTO `item_mods_pet` VALUES (10704,unimplemented,1,1); -- Smn. Bracers +2 Avatar: Enhances accuracy
INSERT INTO `item_mods_pet` VALUES (10724,30,5,1);      -- Smn. Spats +2 Avatar: Enhances magic accuracy
-- INSERT INTO `item_mods_pet` VALUES (10744,unimplemented,1,1); -- Smn. Pigaches +2 Avatar: Enhances attack
INSERT INTO `item_mods_pet` VALUES (10744,562,5,1);     -- Avatar: Magic critical hit rate +5%
INSERT INTO `item_mods_pet` VALUES (10817,384,500,0);    -- Moepapa Stone Pet: Haste+5%
INSERT INTO `item_mods_pet` VALUES (10914,27,-2,0);     -- Muzzling Collar Pet: Enmity-2
INSERT INTO `item_mods_pet` VALUES (10915,27,-3,0);     -- Muzzling Collar +1 Pet: Enmity-3
INSERT INTO `item_mods_pet` VALUES (10972,161,-3,0);    -- Oneiros Cappa Pet: Physical damage taken -3%
INSERT INTO `item_mods_pet` VALUES (11052,126,3,1);     -- Esper Earring Avatar: Increases "Blood Pact" damage 3%
INSERT INTO `item_mods_pet` VALUES (11098,126,10,1);    -- Call. Doublet +2 Avatar: Increases Blood Pact damage
INSERT INTO `item_mods_pet` VALUES (11118,25,15,1);     -- Call. Bracers +2 Avatar: Accuracy +15
INSERT INTO `item_mods_pet` VALUES (11138,345,500,1);   -- Caller's Spats +2 Avatar: TP Bonus +500 (?)
INSERT INTO `item_mods_pet` VALUES (11158,30,5,1);      -- Caller's Pgch. +2 Avatar: Enhances magic accuracy +5 (?)
INSERT INTO `item_mods_pet` VALUES (11198,126,5,1);     -- Caller's Doublet +1 Avatar: Increases Blood Pact damage +5%
INSERT INTO `item_mods_pet` VALUES (11218,25,10,1);     -- Caller's Bracers +1   Avatar: Accuracy +10 (?)
INSERT INTO `item_mods_pet` VALUES (11238,345,250,1);   -- Caller's Spats +1 Avatar: TP Bonus +250
INSERT INTO `item_mods_pet` VALUES (11258,30,5,1);      -- Caller's Pgch. +1 Avatar: Enhances magic accuracy +5 (?)
INSERT INTO `item_mods_pet` VALUES (11261,12,10,3);     -- Cirque Scarpe +1 Automaton: INT+10
INSERT INTO `item_mods_pet` VALUES (11261,13,10,3);     -- Automaton: MND+10
INSERT INTO `item_mods_pet` VALUES (11297,2,20,4);      -- Pup. Tobe +1 Harlequin Automaton: HP+20
INSERT INTO `item_mods_pet` VALUES (11297,5,20,4);      -- Harlequin Automaton: MP+20
INSERT INTO `item_mods_pet` VALUES (11297,2,24,5);      -- Valoredge Automaton: HP+24
INSERT INTO `item_mods_pet` VALUES (11297,2,18,6);      -- Sharpshot Automaton: HP+18
INSERT INTO `item_mods_pet` VALUES (11297,2,16,7);      -- Stormwaker Automaton: HP+16
INSERT INTO `item_mods_pet` VALUES (11297,5,24,7);      -- Stormwaker Automaton: MP+24
INSERT INTO `item_mods_pet` VALUES (11298,25,10,3);     -- Pantin Tobe Automaton: Accuracy +10
INSERT INTO `item_mods_pet` VALUES (11299,25,10,3);     -- Pantin Tobe +1 Automaton: Accuracy +10
INSERT INTO `item_mods_pet` VALUES (11338,25,3,0);      -- Aega's Doublet Pet: accuracy +3
INSERT INTO `item_mods_pet` VALUES (11338,289,3,0);     -- Pet: Subtle Blow +3
INSERT INTO `item_mods_pet` VALUES (11388,28,5,3);      -- Pantin Babouches Automaton: "Magic Atk. Bonus"+5
INSERT INTO `item_mods_pet` VALUES (11389,28,5,3);      -- Ptn. Babouches +1 Automaton: "Magic Atk. Bonus"+5
INSERT INTO `item_mods_pet` VALUES (11470,72,3,3);      -- Puppetry Taj +1 Automaton: HP recovered while healing +3
INSERT INTO `item_mods_pet` VALUES (11470,71,3,3);      -- Automaton: MP recovered while healing +3
INSERT INTO `item_mods_pet` VALUES (11471,370,1,3);     -- Pantin Taj  Automaton: Adds "Regen" effect
INSERT INTO `item_mods_pet` VALUES (11472,370,1,3);     -- Pantin Taj +1 Automaton: Adds "Regen" effect
INSERT INTO `item_mods_pet` VALUES (11497,384,500,0);    -- Spurrer Beret Pet: Haste+5%
INSERT INTO `item_mods_pet` VALUES (11531,73,3,0);      -- Fidelity Mantle Pet: Store TP +3
INSERT INTO `item_mods_pet` VALUES (11536,101,2,3);     -- Wyg. Klt. Mantle Automaton: Melee skill +2
INSERT INTO `item_mods_pet` VALUES (11555,25,10,0);     -- Ferine Mantle Pet: Accuracy+10
INSERT INTO `item_mods_pet` VALUES (11564,28,1,1);      -- Tiresias' Cape Avatar:"Magic Atk. Bonus"+1
INSERT INTO `item_mods_pet` VALUES (11571,25,12,3);     -- Karagoz Mantle Automaton: Accuracy +10
INSERT INTO `item_mods_pet` VALUES (11612,28,2,1);      -- Eidolon Pendant Avatar: "Magic Atk. Bonus"+2
INSERT INTO `item_mods_pet` VALUES (11617,288,2,0);     -- Ferine Necklace Pet: "Double Attack"+2%
INSERT INTO `item_mods_pet` VALUES (11619,368,25,1);    -- Caller's Pendant Avatar: Regain + 25
INSERT INTO `item_mods_pet` VALUES (11711,25,3,0);      -- Ferine Earring Pet: Accuracy+3
INSERT INTO `item_mods_pet` VALUES (11720,23,2,3);      -- Cirque Earring Automaton: Attack+2
INSERT INTO `item_mods_pet` VALUES (11720,24,3,3);      -- Automaton: Ranged Attack+2
INSERT INTO `item_mods_pet` VALUES (11720,28,3,3);      -- Automaton: "Magic Atk. Bonus"+2
INSERT INTO `item_mods_pet` VALUES (11739,27,2,1);      -- Caller's Sash Avatar: Enmity +2
INSERT INTO `item_mods_pet` VALUES (11739,28,2,1);      -- Avatar: Magic Atk. Bonus +2
INSERT INTO `item_mods_pet` VALUES (11987,126,5,1);     -- Ngen Seraweels Avatar: Increases "Blood Pact" damage 5%
INSERT INTO `item_mods_pet` VALUES (11987,370,1,1);     -- Adds "Regen" effect
INSERT INTO `item_mods_pet` VALUES (12520,27,-3,1);     -- Evoker's Horn Avatar: Enmity -3
INSERT INTO `item_mods_pet` VALUES (12649,370,1,2);     -- Drachen Mail Adds "Regen" effect to wyvern
INSERT INTO `item_mods_pet` VALUES (12650,27,-2,1);     -- Evoker's Doublet Avatar: Enmity -2
INSERT INTO `item_mods_pet` VALUES (13974,25,5,2);      -- Drachen Fng. Gnt. Enhances wyvern's accuracy+5 (?)
INSERT INTO `item_mods_pet` VALUES (13975,27,-2,1);     -- Evoker's Bracers Avatar: Enmity -2
INSERT INTO `item_mods_pet` VALUES (14103,27,-2,1);     -- Evoker's Pigaches Avatar: Enmity -2
INSERT INTO `item_mods_pet` VALUES (14103,68,5,1);      -- Avatar: Enhances evasion +5 (?)
INSERT INTO `item_mods_pet` VALUES (14227,3,10,2);      -- Drachen Brais Wyvern: HP+10%
INSERT INTO `item_mods_pet` VALUES (14228,25,10,1);     -- Evoker's Spats Avatar: Enhances accuracy +10
INSERT INTO `item_mods_pet` VALUES (14228,27,-2,1);     -- Avatar: Enmity -2
INSERT INTO `item_mods_pet` VALUES (14405,2,65,2);      -- Wyvern Mail Wyvern: HP+65
INSERT INTO `item_mods_pet` VALUES (14405,72,65,2);     -- Wyvern: HP recovered while healing +1
INSERT INTO `item_mods_pet` VALUES (14468,27,5,1);      -- Yinyang Robe Avatar: Pet: Enmity +5
INSERT INTO `item_mods_pet` VALUES (14486,370,1,2);     -- Drachen Mail + 1 Adds "Regen" effect to wyvern
INSERT INTO `item_mods_pet` VALUES (14514,165,4,1);     -- Smn. Doublet +1 Avatar: Critical Hit Rate +4%
INSERT INTO `item_mods_pet` VALUES (14523,2,20,4);      -- Pup. Tobe  Harlequin Automaton: HP+20
INSERT INTO `item_mods_pet` VALUES (14523,5,20,4);      -- Harlequin Automaton: MP+20
INSERT INTO `item_mods_pet` VALUES (14523,2,24,5);      -- Valoredge Automaton: HP+24
INSERT INTO `item_mods_pet` VALUES (14523,2,18,6);      -- Sharpshot Automaton: HP+18
INSERT INTO `item_mods_pet` VALUES (14523,2,16,7);      -- Stormwaker Automaton: HP+16
INSERT INTO `item_mods_pet` VALUES (14523,5,24,7);      -- Stormwaker Automaton: MP+24
INSERT INTO `item_mods_pet` VALUES (14872,2,10,2);      -- Ostreger Mitts Wyvern: HP +10
INSERT INTO `item_mods_pet` VALUES (14903,25,5,2);      -- Drn. Fng. Gnt. +1 Wyvern: Increases Accuracy +5 (?)
INSERT INTO `item_mods_pet` VALUES (14904,27,-2,1);     -- Evk. Bracers +1 Avatar: Enmity -2
INSERT INTO `item_mods_pet` VALUES (14923,25,14,1);     -- Smn. Bracers +1 Avatar: Enhances accuracy +14 (?)
INSERT INTO `item_mods_pet` VALUES (14958,63,5,0);      -- Beast Bazubands Pet: Defense Bonus 5% (?)
INSERT INTO `item_mods_pet` VALUES (15031,384,300,3);    -- Pantin Dastanas Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (15032,384,300,3);    -- Pantin Dastanas +1 Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (15101,165,3,1);     -- Summoner's Dblt. Avatar: Critical Hit Rate +3%
INSERT INTO `item_mods_pet` VALUES (15116,25,7,1);      -- Summoner's Brcr. Avatar: Enhances accuracy +7
-- INSERT INTO `item_mods_pet` VALUES (15131,unimplemented,1,1); -- Summoner's Spats Avatar: Shortens magic recast time for spirits
INSERT INTO `item_mods_pet` VALUES (15146,23,7,1);      -- Summoner's Pgch. Avatar: Enhances attack +7
INSERT INTO `item_mods_pet` VALUES (15146,357,-2,1);    -- "Blood Pact" ability delay -2
INSERT INTO `item_mods_pet` VALUES (15239,27,-3,1);     -- Evk. Horn +1 Avatar: Enmity -3
INSERT INTO `item_mods_pet` VALUES (15267,72,3,3);      -- Pup. Taj Automaton: HP recovered while healing +3
INSERT INTO `item_mods_pet` VALUES (15267,71,3,3);      -- Automaton: MP recovered while healing +3
INSERT INTO `item_mods_pet` VALUES (15366,27,-4,1);     -- Evk. Pigaches +1 Avatar: Enmity -4
INSERT INTO `item_mods_pet` VALUES (15366,68,5,1);      -- Avatar: Enhances evasion +5 (?)
INSERT INTO `item_mods_pet` VALUES (15367,2,30,2);      -- Falconer's Hose Wyvern: HP+30
INSERT INTO `item_mods_pet` VALUES (15574,3,15,2);      -- Drn. Brais +1Wyvern: HP+15%
INSERT INTO `item_mods_pet` VALUES (15575,25,14,1);     -- Evk. Spats +1 Avatar: Enhances accuracy +14 (?)
INSERT INTO `item_mods_pet` VALUES (15575,27,-2,1);     -- Avatar: Enmity -2
INSERT INTO `item_mods_pet` VALUES (15594,27,2,1);      -- Smn. Spats +1 Avatar: Enmity +2
INSERT INTO `item_mods_pet` VALUES (15602,374,5,3);     -- Pup. Churidars Automaton: Enhances "Cure" potency +5% (?)
INSERT INTO `item_mods_pet` VALUES (15602,168,10,3);    -- Automaton: Spell interruption rate down 10% (?)
INSERT INTO `item_mods_pet` VALUES (15647,1,10,0);      -- Askar Dirs Pet: DEF +10
INSERT INTO `item_mods_pet` VALUES (15649,1,10,0);      -- Goliard Trews Pet: DEF +10
INSERT INTO `item_mods_pet` VALUES (15661,2,50,2);      -- Homam Gambieras Wyvern: HP+50
INSERT INTO `item_mods_pet` VALUES (15679,23,10,1);     -- Smn. Pigaches +1 Avatar: Enhances attack +10 (?)
INSERT INTO `item_mods_pet` VALUES (15679,27,2,1);      -- Avatar: Enmity +2
INSERT INTO `item_mods_pet` VALUES (15679,357,-2,1);    -- "Blood Pact" ability delay -2
INSERT INTO `item_mods_pet` VALUES (15910,1,5,0);       -- Primal Belt Pet: DEF+5
INSERT INTO `item_mods_pet` VALUES (15910,27,3,0);      -- Pet: Enmity+3
INSERT INTO `item_mods_pet` VALUES (15944,163,-7,0);    -- Selemnus Belt Pet: Magic Damage taken -3%
INSERT INTO `item_mods_pet` VALUES (16173,1,10,0);      -- Pallas's Shield Pet: DEF +10
INSERT INTO `item_mods_pet` VALUES (16245,23,15,3);     -- Pantin Cape Automaton: Attack +15
INSERT INTO `item_mods_pet` VALUES (16270,2,50,2);      -- Chanoix's Gorget Wyvern: HP+50
INSERT INTO `item_mods_pet` VALUES (16297,161,-2,0);    -- Shepherd's Chain Pet: Damage taken -2%
INSERT INTO `item_mods_pet` VALUES (16351,374,5,3);     -- Pup. Churidars +1 Automaton: Enhances "Cure" potency +5% (?)
INSERT INTO `item_mods_pet` VALUES (16351,168,10,3);    -- Automaton: Spell interruption rate down 10% (?)
INSERT INTO `item_mods_pet` VALUES (16352,30,5,3);      -- Pantin Churidars Automaton: Magic Accuracy +5
INSERT INTO `item_mods_pet` VALUES (16353,30,7,3);      -- Ptn. Churidars +1 Automaton: Magic Accuracy +7
INSERT INTO `item_mods_pet` VALUES (16368,25,10,0);     -- Herder's Subligar Enhances pet accuracy +10 (?)
INSERT INTO `item_mods_pet` VALUES (16654,368,10,0);    -- Glyph Axe Pet: "Regain"+10
INSERT INTO `item_mods_pet` VALUES (16843,25,10,2);     -- Draconis Lance Wyvern: Accuracy+10
INSERT INTO `item_mods_pet` VALUES (16843,23,10,2);     -- Wyvern: Attack+10
INSERT INTO `item_mods_pet` VALUES (17579,2,50,2);      -- Wyvern Perch Wyvern: HP+50
INSERT INTO `item_mods_pet` VALUES (17857,2,50,4);      -- Animator +1 Harlequin Automaton: HP+50 (Allows orders to be more directly relayed to the automaton.)
INSERT INTO `item_mods_pet` VALUES (17857,5,50,4);      -- Harlequin Automaton: MP+50
INSERT INTO `item_mods_pet` VALUES (17857,2,60,5);      -- Valoredge Automaton: HP+60
INSERT INTO `item_mods_pet` VALUES (17857,2,45,6);      -- Sharpshot Automaton: HP+45
INSERT INTO `item_mods_pet` VALUES (17857,2,40,7);      -- Stormwaker Automaton: HP+40
INSERT INTO `item_mods_pet` VALUES (17857,5,60,7);      -- Stormwaker Automaton: MP+60
INSERT INTO `item_mods_pet` VALUES (17961,1,10,0);      -- Lion Tamer Pet: DEF +10
INSERT INTO `item_mods_pet` VALUES (18547,370,3,0);     -- Ravana's Axe Pet: Adds "Regen" effect
INSERT INTO `item_mods_pet` VALUES (18745,3,1,3);       -- Adaman Sainti Automaton: HP +1% (Supposed to be 0.75%)
INSERT INTO `item_mods_pet` VALUES (18746,3,2,3);       -- Gem Sainti Automaton: HP +2% (Supposed to be 1.5%)
INSERT INTO `item_mods_pet` VALUES (18778,369,1,3);     -- Marotte Claws Automaton: Adds "Refresh" effect
INSERT INTO `item_mods_pet` VALUES (18778,370,1,3);     -- Automaton: Adds "Regen" effect
INSERT INTO `item_mods_pet` VALUES (18780,368,10,3);    -- Burattinaios Automaton: "Regain"+10
INSERT INTO `item_mods_pet` VALUES (18791,2,30,3);      -- Buzbaz Sainti Automaton: HP+30
INSERT INTO `item_mods_pet` VALUES (18791,23,9,3);      -- Automaton: Attack+9
INSERT INTO `item_mods_pet` VALUES (18791,24,9,3);      -- Automaton: Ranged Attack+9
INSERT INTO `item_mods_pet` VALUES (18792,2,40,3);      -- Buzbaz Sainti +1 Automaton: HP+40
INSERT INTO `item_mods_pet` VALUES (18792,23,10,3);     -- Automaton: Attack+10
INSERT INTO `item_mods_pet` VALUES (18792,24,10,3);     -- Automaton: Ranged Attack+10
INSERT INTO `item_mods_pet` VALUES (18999,23,40,0);     -- Aymur 75 Pet: Attack+40
INSERT INTO `item_mods_pet` VALUES (19005,28,20,1);     -- Nirvana 75 Avatar: "Magic Atk. Bonus"+20
INSERT INTO `item_mods_pet` VALUES (19068,23,50,0);     -- Aymur 80 Pet: Attack+50
INSERT INTO `item_mods_pet` VALUES (19074,28,25,1);     -- Nirvana 80 Avatar: "Magic Atk. Bonus"+25
INSERT INTO `item_mods_pet` VALUES (19088,23,60,0);     -- Aymur 85 Pet: Attack+60
INSERT INTO `item_mods_pet` VALUES (19094,28,30,1);     -- Nirvana 85 Avatar: "Magic Atk. Bonus"+30
INSERT INTO `item_mods_pet` VALUES (19620,23,70,0);     -- Aymur 90 Pet: Attack+70
INSERT INTO `item_mods_pet` VALUES (19626,28,35,1);     -- Nirvana 90 Avatar: "Magic Atk. Bonus"+35
INSERT INTO `item_mods_pet` VALUES (19718,23,70,0);     -- Aymur 95 Pet: Attack+70
INSERT INTO `item_mods_pet` VALUES (19724,28,35,1);     -- Nirvana 95 Avatar: "Magic Atk. Bonus"+35
INSERT INTO `item_mods_pet` VALUES (19772,28,1,1);      -- Esper Stone Avatar: "Magic Atk. Bonus"+1
INSERT INTO `item_mods_pet` VALUES (19827,23,80,0);     -- Aymur 99 Pet: Attack+80
INSERT INTO `item_mods_pet` VALUES (19833,28,40,1);     -- Nirvana 99 Avatar: "Magic Atk. Bonus"+40
INSERT INTO `item_mods_pet` VALUES (19956,23,80,0);     -- Aymur 99 AG Pet: Attack+80
INSERT INTO `item_mods_pet` VALUES (19962,28,40,1);     -- Nirvana 99 AG Avatar: "Magic Atk. Bonus"+40
INSERT INTO `item_mods_pet` VALUES (20792,23,80,0);     -- Aymur 119 Pet: Attack+80
INSERT INTO `item_mods_pet` VALUES (20793,23,80,0);     -- Aymur 119 AG Pet: Attack+80
INSERT INTO `item_mods_pet` VALUES (20822,27,6,0);      -- Anahera Tabar Pet: Enmity +6
INSERT INTO `item_mods_pet` VALUES (20822,68,40,0);     -- Pet: Evasion +40
INSERT INTO `item_mods_pet` VALUES (20831,288,2,0);     -- Aalak' Axe Pet: Double Attack +2%
INSERT INTO `item_mods_pet` VALUES (20832,288,3,0);     -- Aalak' Axe +1 Pet: Double Attack +3%
INSERT INTO `item_mods_pet` VALUES (20944,370,2,2);     -- Pelagos Lance Wyvern: "Regen"+2
INSERT INTO `item_mods_pet` VALUES (20944,161,3,2);     -- Wyvern: Physical damage taken -3%
INSERT INTO `item_mods_pet` VALUES (21141,126,40,1);    -- Nirvana 119 Avatar: Increases "Blood Pact: Rage" damage
INSERT INTO `item_mods_pet` VALUES (21142,126,40,1);    -- Nirvana 119 AG Avatar: Increases "Blood Pact: Rage" damage
INSERT INTO `item_mods_pet` VALUES (21155,30,35,1);     -- Marquetry Staff Avatar: Magic Accuracy+35 un
INSERT INTO `item_mods_pet` VALUES (21155,28,110,1);    -- Avatar: "Magic Atk. Bonus"+110
INSERT INTO `item_mods_pet` VALUES (21155,126,3,1);     -- Avatar: "Blood Pact" damage +3
INSERT INTO `item_mods_pet` VALUES (21167,30,20,1);     -- Frazil Staff Avatar: Magic Accuracy+20
INSERT INTO `item_mods_pet` VALUES (21167,28,120,1);    -- Avatar: "Magic Atk. Bonus"+120
INSERT INTO `item_mods_pet` VALUES (21167,27,10,1);     -- Avatar: Enmity+10
INSERT INTO `item_mods_pet` VALUES (21183,28,108,1);    -- Eminent Pole Avatar: "Magic Atk. Bonus"+108
INSERT INTO `item_mods_pet` VALUES (21361,28,6,0);      -- Esper Stone +1 Pet: "Magic Atk. Bonus"+6
INSERT INTO `item_mods_pet` VALUES (21526,25,50,3);     -- Xiucoatl: Automaton: Accuracy+50
INSERT INTO `item_mods_pet` VALUES (21526,26,50,3);     -- Xiucoatl: Automaton: Ranged Accuracy+50
INSERT INTO `item_mods_pet` VALUES (21526,30,50,3);     -- Xiucoatl: Automaton: Magic Accuracy+50
INSERT INTO `item_mods_pet` VALUES (21715,25,30,0);     -- Monster Axe: Pet: Accuracy+30
INSERT INTO `item_mods_pet` VALUES (21715,26,30,0);     -- Monster Axe: Pet: Ranged Accuracy+30
INSERT INTO `item_mods_pet` VALUES (21715,30,30,0);     -- Monster Axe: Pet: Magic Accuracy+30
INSERT INTO `item_mods_pet` VALUES (21716,25,40,0);     -- Ankusa Axe: Pet: Accuracy+40
INSERT INTO `item_mods_pet` VALUES (21716,26,40,0);     -- Ankusa Axe: Pet: Ranged Accuracy+40
INSERT INTO `item_mods_pet` VALUES (21716,30,40,0);     -- Ankusa Axe: Pet: Magic Accuracy+40
INSERT INTO `item_mods_pet` VALUES (21717,25,50,0);     -- Pangu: Pet: Accuracy+50
INSERT INTO `item_mods_pet` VALUES (21717,26,50,0);     -- Pangu: Pet: Ranged Accuracy+50
INSERT INTO `item_mods_pet` VALUES (21717,30,50,0);     -- Pangu: Pet: Magic Accuracy+50
INSERT INTO `item_mods_pet` VALUES (21751,23,80,0);     -- Aymur 119 III Pet: Attack Bonus V
INSERT INTO `item_mods_pet` VALUES (21865,370,5,2);     -- Arasy Lance: Wyvern: "Regen"+5
INSERT INTO `item_mods_pet` VALUES (21866,370,8,2);     -- Arasy Lance +1: Wyvern: "Regen"+8
INSERT INTO `item_mods_pet` VALUES (22015,30,10,1);     -- Arasy Rod: Avatar: Magic Accuracy+10
INSERT INTO `item_mods_pet` VALUES (22016,30,15,1);     -- Arasy Rod +1: Avatar: Magic Accuracy+15
INSERT INTO `item_mods_pet` VALUES (22054,28,115,1);    -- Grioavolr: Avatar: "Magic Atk. Bonus"+115
INSERT INTO `item_mods_pet` VALUES (22054,30,35,1);     -- Grioavolr: Avatar: Magic Accuracy+35
INSERT INTO `item_mods_pet` VALUES (22063,126,40,1);    -- Nirvana 119 III Avatar: "Blood Pact" damage +40
INSERT INTO `item_mods_pet` VALUES (22074,126,3,1);     -- Arasy Staff: Avatar: "Blood Pact" damage +3
INSERT INTO `item_mods_pet` VALUES (22075,126,5,1);     -- Arasy Staff +1: Avatar: "Blood Pact" damage +5
INSERT INTO `item_mods_pet` VALUES (22096,25,50,1);     -- Draumstafir: Avatar: Accuracy+50
INSERT INTO `item_mods_pet` VALUES (22096,26,50,1);     -- Draumstafir: Avatar: Ranged Accuracy+50
INSERT INTO `item_mods_pet` VALUES (22096,30,50,1);     -- Draumstafir: Avatar: Magic Accuracy+50
INSERT INTO `item_mods_pet` VALUES (22210,126,3,1);     -- Elan Strap: Avatar: "Blood Pact" damage +3
INSERT INTO `item_mods_pet` VALUES (22211,126,5,1);     -- Elan Strap +1: Avatar: "Blood Pact" damage +5
INSERT INTO `item_mods_pet` VALUES (23057,25,31,3);     -- Foire Taj +2 Automaton: Accuracy +31
INSERT INTO `item_mods_pet` VALUES (23057,369,1,3);     -- Automaton: Refresh +1
INSERT INTO `item_mods_pet` VALUES (23057,370,3,3);     -- Automaton: Regen +3
INSERT INTO `item_mods_pet` VALUES (23057,384,600,3);   -- Automaton: Haste +6%
INSERT INTO `item_mods_pet` VALUES (23120,370,10,2);    -- Vishap Mail +2 Wyvern: "Regen"+10
INSERT INTO `item_mods_pet` VALUES (23121,25,35,1);     -- Convoker's Doublet +2 Avatar: Accuracy+35
INSERT INTO `item_mods_pet` VALUES (23121,30,35,1);     -- Magic Accuracy+35
INSERT INTO `item_mods_pet` VALUES (23121,126,14,1);    -- "Blood Pact" damage +14
INSERT INTO `item_mods_pet` VALUES (23124,2,165,3);     -- Foire Tobe Automaton: HP +165
INSERT INTO `item_mods_pet` VALUES (23124,5,165,3);     -- Automaton: MP +165
INSERT INTO `item_mods_pet` VALUES (23124,384,400,3);   -- Automaton: Haste +4%
INSERT INTO `item_mods_pet` VALUES (23191,25,32,3);     -- Foire Dastanas +2 Automaton: Accuracy +32
INSERT INTO `item_mods_pet` VALUES (23191,384,500,3);   -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (23325,28,20,3);     -- Foire Babouches +2 Automaton: Magic Attack Bonus +20
INSERT INTO `item_mods_pet` VALUES (23325,30,40,3);     -- Automaton: Magic Accuracy +40
INSERT INTO `item_mods_pet` VALUES (23325,384,400,3);   -- Automaton: Haste +4%
INSERT INTO `item_mods_pet` VALUES (23392,25,41,3);     -- Foire Taj +3 Automaton: Accuracy +41
INSERT INTO `item_mods_pet` VALUES (23392,369,2,3);     -- Automaton: Refresh +2
INSERT INTO `item_mods_pet` VALUES (23392,370,6,3);     -- Automaton: Regen +6
INSERT INTO `item_mods_pet` VALUES (23392,384,700,3);   -- Automaton: Haste +7%
INSERT INTO `item_mods_pet` VALUES (23455,370,15,2);    -- Vishap Mail +3 Wyvern: "Regen"+15
INSERT INTO `item_mods_pet` VALUES (23254,3,25,2);      -- Vishap Brais +2 Wyvern: HP+25%
INSERT INTO `item_mods_pet` VALUES (23258,5,75,3);      -- Foire Churidars +2 Automaton: MP+75
INSERT INTO `item_mods_pet` VALUES (23258,160,-3,3);    -- Automaton: Damage taken -3%
INSERT INTO `item_mods_pet` VALUES (23258,374,14,3);    -- Automaton: "Cure" Potency +14%
INSERT INTO `item_mods_pet` VALUES (23258,384,400,3);   -- Automaton: Haste +4%
INSERT INTO `item_mods_pet` VALUES (23456,25,45,1);     -- Convoker's Doublet +3 Avatar: Acc.+45
INSERT INTO `item_mods_pet` VALUES (23456,30,45,1);     -- Magic Acc.+45
INSERT INTO `item_mods_pet` VALUES (23456,126,16,1);    -- "Blood Pact" damage +16
INSERT INTO `item_mods_pet` VALUES (23459,2,220,3);     -- Foire Tobe +3 Automaton: HP +220
INSERT INTO `item_mods_pet` VALUES (23459,5,220,3);     -- Automaton: MP +220
INSERT INTO `item_mods_pet` VALUES (23459,384,500,3);   -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (23526,25,42,3);     -- Foire Dastanas +3 Automaton: Accuracy +42
INSERT INTO `item_mods_pet` VALUES (23526,384,500,3);   -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (23589,3,27,2);      -- Vishap Brais Wyvern: HP+27%
INSERT INTO `item_mods_pet` VALUES (23593,5,75,3);      -- Foire Churidars +3 Automaton: MP+75
INSERT INTO `item_mods_pet` VALUES (23593,160,-6,3);    -- Automaton: Damage taken -6%
INSERT INTO `item_mods_pet` VALUES (23593,374,14,3);    -- Automaton: "Cure" Potency +14%
INSERT INTO `item_mods_pet` VALUES (23593,384,600,3);   -- Automaton: Haste +6%
INSERT INTO `item_mods_pet` VALUES (23660,28,25,3);     -- Foire Babouches +3 Automaton: Magic Attack Bonus +25
INSERT INTO `item_mods_pet` VALUES (23660,30,50,3);     -- Automaton: Magic Accuracy +50
INSERT INTO `item_mods_pet` VALUES (23660,384,500,3);   -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (23674,68,38,0);     -- Ankusa Gaiters +3: Pet: Evasion+38
INSERT INTO `item_mods_pet` VALUES (23674,161,-5,0);    -- Ankusa Gaiters +3: Pet: Physical damage taken -5%
INSERT INTO `item_mods_pet` VALUES (23679,2,290,2);     -- Pteroslaver Greaves +3: Wyvern: HP+290
INSERT INTO `item_mods_pet` VALUES (23679,370,10,2);    -- Pteroslaver Greaves +3: Wyvern: "Regen"+10
INSERT INTO `item_mods_pet` VALUES (23680,23,89,1);     -- Glyphic Pigaches +3: Avatar: Attack+89
INSERT INTO `item_mods_pet` VALUES (23680,25,36,1);     -- Glyphic Pigaches +3: Avatar: Accuracy+36
INSERT INTO `item_mods_pet` VALUES (23680,562,13,1);    -- Glyphic Pigaches +3: Avatar: Magic critical hit rate +13%
INSERT INTO `item_mods_pet` VALUES (23683,28,57,3);     -- Pitre Babouches +3: Automaton: "Magic Atk. Bonus"+57
INSERT INTO `item_mods_pet` VALUES (23683,30,43,3);     -- Pitre Babouches +3: Automaton: Magic Accuracy+43
-- INSERT INTO `item_mods_pet` VALUES (23686,370,5,?);  -- Bagua Sandals +3: Luopan: "Regen"+5
INSERT INTO `item_mods_pet` VALUES (25465,25,15,0);     -- Beastmaster Collar: Pet: Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25465,26,15,0);     -- Beastmaster Collar: Pet: Ranged Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25465,30,15,0);     -- Beastmaster Collar: Pet: Magic Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25466,25,20,0);     -- Beastmaster Collar+1: Pet: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25466,26,20,0);     -- Beastmaster Collar+1: Pet: Ranged Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25466,30,20,0);     -- Beastmaster Collar+1: Pet: Magic Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25467,25,25,0);     -- Beastmaster Collar+2: Pet: Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25467,26,25,0);     -- Beastmaster Collar+2: Pet: Ranged Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25467,30,25,0);     -- Beastmaster Collar+2: Pet: Magic Accuracy+25
-- INSERT INTO `item_mods_pet` VALUES (25495,??,1,2);   -- Dragoon's Collar: Wyvern: Lv.+1
-- INSERT INTO `item_mods_pet` VALUES (25496,??,1,2);   -- Dragoon's Collar+1: Wyvern: Lv.+1
-- INSERT INTO `item_mods_pet` VALUES (25497,??,1,2);   -- Dragoon's Collar+2: Wyvern: Lv.+1
INSERT INTO `item_mods_pet` VALUES (25501,25,15,1);     -- Summoner's Collar: Avatar: Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25501,26,15,1);     -- Summoner's Collar: Avatar: Ranged Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25501,30,15,1);     -- Summoner's Collar: Avatar: Magic Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25502,25,20,1);     -- Summoner's Collar: Avatar: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25502,26,20,1);     -- Summoner's Collar: Avatar: Ranged Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25502,30,20,1);     -- Summoner's Collar: Avatar: Magic Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25503,25,25,1);     -- Summoner's Collar: Avatar: Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25503,26,25,1);     -- Summoner's Collar: Avatar: Ranged Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25503,30,25,1);     -- Summoner's Collar: Avatar: Magic Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25519,25,15,3);     -- Pup. Collar: Automaton: Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25519,26,15,3);     -- Pup. Collar: Automaton: Ranged Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25519,30,15,3);     -- Pup. Collar: Automaton: Magic Accuracy+15
INSERT INTO `item_mods_pet` VALUES (25520,25,20,3);     -- Pup. Collar+1: Automaton: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25520,26,20,3);     -- Pup. Collar+1: Automaton: Ranged Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25520,30,20,3);     -- Pup. Collar+1: Automaton: Magic Accuracy+20
INSERT INTO `item_mods_pet` VALUES (25521,25,25,3);     -- Pup. Collar+2: Automaton: Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25521,26,25,3);     -- Pup. Collar+2: Automaton: Ranged Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25521,30,25,3);     -- Pup. Collar+2: Automaton: Magic Accuracy+25
INSERT INTO `item_mods_pet` VALUES (25563,25,40,0);     -- Heyoka Cap: Pet: Accuracy+40
INSERT INTO `item_mods_pet` VALUES (25563,26,40,0);     -- Heyoka Cap: Pet: Ranged Accuracy+40
INSERT INTO `item_mods_pet` VALUES (25563,27,8,0);      -- Heyoka Cap: Pet: Enmity+8
INSERT INTO `item_mods_pet` VALUES (25563,384,600,0);   -- Heyoka Cap: Pet: Haste+6%
INSERT INTO `item_mods_pet` VALUES (25564,25,50,0);     -- Heyoka Cap +1: Pet: Accuracy+50
INSERT INTO `item_mods_pet` VALUES (25564,26,50,0);     -- Heyoka Cap +1: Pet: Ranged Accuracy+50
INSERT INTO `item_mods_pet` VALUES (25564,27,10,0);     -- Heyoka Cap +1: Pet: Enmity+10
INSERT INTO `item_mods_pet` VALUES (25564,384,600,0);   -- Heyoka Cap +1: Pet: Haste+6%
INSERT INTO `item_mods_pet` VALUES (25565,368,3,1);     -- Baayami Hat: Avatar: "Regain"+3
INSERT INTO `item_mods_pet` VALUES (25566,368,4,1);     -- Baayami Hat+1: Avatar: "Regain"+4
INSERT INTO `item_mods_pet` VALUES (26201,23,23,0);     -- Thur. Ring +1 Pet: Attack+23
INSERT INTO `item_mods_pet` VALUES (26201,24,23,0);     -- Pet: Ranged Attack+23
INSERT INTO `item_mods_pet` VALUES (26201,25,22,0);     -- Pet: Accuracy+22
INSERT INTO `item_mods_pet` VALUES (26201,26,22,0);     -- Pet: Ranged Accuracy+22
INSERT INTO `item_mods_pet` VALUES (26201,384,400,0);   -- Pet: Haste+4%
INSERT INTO `item_mods_pet` VALUES (26201,160,-4,0);    -- Pet: Damage Taken -4%
INSERT INTO `item_mods_pet` VALUES (26652,28,20,1);     -- Glyphic Horn Avatar: "Magic Atk. Bonus"+20
INSERT INTO `item_mods_pet` VALUES (26653,28,23,1);     -- Glyphic Horn +1 Avatar: "Magic Atk. Bonus"+23
INSERT INTO `item_mods_pet` VALUES (26658,369,2,3);     -- Pitre Taj Automaton: Refresh +2
INSERT INTO `item_mods_pet` VALUES (26658,370,3,3);     -- Automaton: Regen +3
INSERT INTO `item_mods_pet` VALUES (26659,369,3,3);     -- Pitre Taj +1 Automaton: Refresh +3
INSERT INTO `item_mods_pet` VALUES (26659,370,3,3);     -- Automaton: Regen +3
INSERT INTO `item_mods_pet` VALUES (26774,345,525,3);   -- Karagoz Capello Automaton: TP Bonus +525
INSERT INTO `item_mods_pet` VALUES (26775,345,550,3);   -- Karagoz Capello +1 Automaton: TP Bonus +550
INSERT INTO `item_mods_pet` VALUES (26828,165,8,1);     -- Glyphic Doublet Avatar: Critical hit rate +8%
INSERT INTO `item_mods_pet` VALUES (26829,165,12,1);    -- Glyphic Doublet +1 Avatar: Critical hit rate +12%
INSERT INTO `item_mods_pet` VALUES (26834,25,18,3);     -- Pitre Tobe Automaton: Accuracy +18
INSERT INTO `item_mods_pet` VALUES (26834,26,18,3);     -- Automaton: Ranged Accuracy +18
INSERT INTO `item_mods_pet` VALUES (26834,73,12,3);     -- Automaton: Store TP +12
INSERT INTO `item_mods_pet` VALUES (26835,25,21,3);     -- Pitre Tobe +1 Automaton: Accuracy +21
INSERT INTO `item_mods_pet` VALUES (26835,26,21,3);     -- Automaton: Ranged Accuracy +21
INSERT INTO `item_mods_pet` VALUES (26835,73,13,3);     -- Automaton: Store TP +13
INSERT INTO `item_mods_pet` VALUES (26888,27,14,1);     -- Shomonjijoe +1 Avatar: Enmity +14
INSERT INTO `item_mods_pet` VALUES (26926,126,10,1);    -- Beckoner's Doublet Avatar: "Blood Pact" damage +10
INSERT INTO `item_mods_pet` VALUES (26927,126,11,1);    -- Beckoner's Doublet +1 Avatar: "Blood Pact" damage +11
INSERT INTO `item_mods_pet` VALUES (27004,25,20,1);     -- Glyphic Bracers Avatar: Accuracy +20
INSERT INTO `item_mods_pet` VALUES (27004,384,200,1);   -- Avatar: Haste +2%
INSERT INTO `item_mods_pet` VALUES (27005,25,28,1);     -- Glyphic Bracers +1 Avatar: Accuracy +28
INSERT INTO `item_mods_pet` VALUES (27005,384,300,1);   -- Avatar: Haste +3%
INSERT INTO `item_mods_pet` VALUES (27010,289,7,3);     -- Pitre Dastanas Automaton: Subtle Blow +7
INSERT INTO `item_mods_pet` VALUES (27010,384,400,3);   -- Automaton: Haste +4%
INSERT INTO `item_mods_pet` VALUES (27011,289,9,3);     -- Pitre Dastanas +1 Automaton: Subtle Blow +9
INSERT INTO `item_mods_pet` VALUES (27011,384,500,3);   -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (27044,2,50,2);      -- Crusher Gauntlets Wyvern: HP+50
INSERT INTO `item_mods_pet` VALUES (27080,25,20,1);     -- Beckoner's Bracers Avatar: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (27081,25,30,1);     -- Beck. Bracers +1 Avatar: Accuracy+30
INSERT INTO `item_mods_pet` VALUES (27086,8,13,3);      -- Karagoz Guanti Automaton: STR +13
INSERT INTO `item_mods_pet` VALUES (27086,9,13,3);      -- Automaton: DEX +13
INSERT INTO `item_mods_pet` VALUES (27086,11,13,3);     -- Automaton: AGI +13
INSERT INTO `item_mods_pet` VALUES (27087,8,16,3);      -- Karagoz Guanti +1 Automaton: STR +16
INSERT INTO `item_mods_pet` VALUES (27087,9,16,3);      -- Automaton: DEX +16
INSERT INTO `item_mods_pet` VALUES (27087,11,16,3);     -- Automaton: AGI +16
INSERT INTO `item_mods_pet` VALUES (27180,30,10,1);     -- Glyphic Spats Avatar: Magic Accuracy+10
INSERT INTO `item_mods_pet` VALUES (27181,30,13,1);     -- Glyphic Spats +1 Avatar: Magic Accuracy+13
INSERT INTO `item_mods_pet` VALUES (27186,30,15,3);     -- Pitre Churidars Automaton: Magic Accuracy +15
INSERT INTO `item_mods_pet` VALUES (27186,170,7,3);     -- Automaton: Fast Cast +7%
INSERT INTO `item_mods_pet` VALUES (27187,30,18,3);     -- Pitre Churidars +1 Automaton: Magic Accuracy +18
INSERT INTO `item_mods_pet` VALUES (27187,170,8,3);     -- Automaton: Fast Cast +8%
INSERT INTO `item_mods_pet` VALUES (27221,27,4,1);      -- Avatara Slops Avatar: Enmity+4
INSERT INTO `item_mods_pet` VALUES (27221,126,7,1);     -- "Blood Pact" damage +7
INSERT INTO `item_mods_pet` VALUES (27265,345,550,1);   -- Beckoner's Spats Avatar: TP Bonus +550
INSERT INTO `item_mods_pet` VALUES (27266,345,600,1);   -- Beck. Spats +1 Avatar: TP Bonus +600
INSERT INTO `item_mods_pet` VALUES (27356,23,28,1);     -- Glyphic Pigaches Avatar: Attack+25
INSERT INTO `item_mods_pet` VALUES (27356,562,7,1);     -- Avatar: Magic critical hit rate +7%
INSERT INTO `item_mods_pet` VALUES (27357,23,28,1);     -- Glyph. Pigaches +1 Avatar: Attack+28
INSERT INTO `item_mods_pet` VALUES (27357,562,9,1);     -- Avatar: Magic critical hit rate +9%
INSERT INTO `item_mods_pet` VALUES (27362,28,15,3);     -- Pitre Babouches Automaton: Magic Attack Bonus +15
INSERT INTO `item_mods_pet` VALUES (27362,30,12,3);     -- Automaton: Magic Accuracy +12
INSERT INTO `item_mods_pet` VALUES (27363,28,18,3);     -- Pitre Babouches Automaton: Magic Attack Bonus +18
INSERT INTO `item_mods_pet` VALUES (27363,30,15,3);     -- Automaton: Magic Accuracy +15
INSERT INTO `item_mods_pet` VALUES (27439,30,17,1);     -- Beck. Pigaches Avatar: Magic Accuracy+17
INSERT INTO `item_mods_pet` VALUES (27440,30,27,1);     -- Beck. Pigaches +1 Avatar: Magic Accuracy+27
INSERT INTO `item_mods_pet` VALUES (27445,12,17,3);     -- Karagoz Scarpe Automaton: INT +17
INSERT INTO `item_mods_pet` VALUES (27445,13,17,3);     -- Automaton: MND +17
INSERT INTO `item_mods_pet` VALUES (27446,12,20,3);     -- Karagoz Scarpe +1 Automaton: INT +20
INSERT INTO `item_mods_pet` VALUES (27446,13,20,3);     -- Automaton: MND +20
INSERT INTO `item_mods_pet` VALUES (27677,27,4,1);      -- Convoker's Horn Avatar: Enmity+4
INSERT INTO `item_mods_pet` VALUES (27680,71,6,3);      -- Foire Taj Automaton: HP recovered while healing +6
INSERT INTO `item_mods_pet` VALUES (27680,72,6,3);      -- Automaton: MP recovered while healing +6
INSERT INTO `item_mods_pet` VALUES (27680,384,500,3);    -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (27698,27,4,1);      -- Con. Horn +1 Avatar: Enmity+4
INSERT INTO `item_mods_pet` VALUES (27701,71,8,3);      -- Foire Taj +1 Automaton: HP recovered while healing +8
INSERT INTO `item_mods_pet` VALUES (27701,72,8,3);      -- Automaton: MP recovered while healing +8
INSERT INTO `item_mods_pet` VALUES (27701,384,500,3);   -- Automaton: Haste +5%
INSERT INTO `item_mods_pet` VALUES (27820,370,2,2);     -- Vishap Mail Adds "Regen" effect to wyvern
INSERT INTO `item_mods_pet` VALUES (27821,126,11,1);    -- Convoker's Doublet Avatar: Increases "Blood Pact" damage (11%)
INSERT INTO `item_mods_pet` VALUES (27824,2,85,3);      -- Foire Tobe Automaton: HP +85
INSERT INTO `item_mods_pet` VALUES (27824,5,85,3);      -- Automaton: MP +85
INSERT INTO `item_mods_pet` VALUES (27824,384,300,3);   -- Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (27841,370,3,2);     -- Vishap Mail +1 Wyvern: "Regen" +3
INSERT INTO `item_mods_pet` VALUES (27842,126,12,1);    -- Con. Doublet +1 Avatar: "Blood Pact" ability damage +12
INSERT INTO `item_mods_pet` VALUES (27845,2,110,3);     -- Foire Tobe +1 Automaton: HP +110
INSERT INTO `item_mods_pet` VALUES (27845,5,110,3);     -- Automaton: MP +110
INSERT INTO `item_mods_pet` VALUES (27845,384,300,3);   -- Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (27957,27,5,1);      -- Con. Bracers Avatar: Enmity+5
INSERT INTO `item_mods_pet` VALUES (27960,384,300,3);   -- Foire Dastanas Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (27978,27,5,1);      -- Con. Bracers +1 Avatar: Enmity+5
INSERT INTO `item_mods_pet` VALUES (27981,384,400,3);   -- Foire Dastanas +1 Automaton: Haste +4%
INSERT INTO `item_mods_pet` VALUES (28025,25,20,0);     -- Regimen Mittens Pet: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (28025,26,20,0);     -- Pet: Ranged Accuracy+20
INSERT INTO `item_mods_pet` VALUES (28025,30,20,0);     -- Pet: Magic Accuracy+20
INSERT INTO `item_mods_pet` VALUES (28025,384,600,0);   -- Pet: Haste+6%
INSERT INTO `item_mods_pet` VALUES (28103,3,20,2);      -- Vishap Brais Wyvern: HP+20%
INSERT INTO `item_mods_pet` VALUES (28104,25,20,1);     -- Convoker's Spats Avatar: Increases Accuracy +20 (?)
INSERT INTO `item_mods_pet` VALUES (28104,27,4,1);      -- Avatar: Enmity+4
INSERT INTO `item_mods_pet` VALUES (28107,5,40,3);      -- Foire Churidars Automaton: MP +40 (?)
INSERT INTO `item_mods_pet` VALUES (28107,374,10,3);    -- Automaton: Cure potency +10% (?)
INSERT INTO `item_mods_pet` VALUES (28107,384,300,3);   -- Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (28119,23,20,0);     -- Tot. Trousers +1 Pet: Attack+20
INSERT INTO `item_mods_pet` VALUES (28124,3,23,2);      -- Vishap Brais +1 Wyvern: HP+23%
INSERT INTO `item_mods_pet` VALUES (28125,25,20,1);     -- Con. Spats +1 Avatar: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (28125,27,4,1);      -- Avatar: Enmity+4
INSERT INTO `item_mods_pet` VALUES (28128,5,50,3);      -- Foire Churidars +1 Automaton: MP+50
INSERT INTO `item_mods_pet` VALUES (28128,374,12,3);    -- Automaton: "Cure" Potency +12%
INSERT INTO `item_mods_pet` VALUES (28128,384,300,3);   -- Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (28141,25,20,0);     -- Wisent Kecks Pet: Accuracy+20
INSERT INTO `item_mods_pet` VALUES (28141,23,10,0);     -- Pet: Attack+10
INSERT INTO `item_mods_pet` VALUES (28141,26,20,0);     -- Pet: Ranged Accuracy+20
INSERT INTO `item_mods_pet` VALUES (28141,24,10,0);     -- Pet: Ranged Attack+10
INSERT INTO `item_mods_pet` VALUES (28141,68,20,0);     -- Pet: Evasion+20
INSERT INTO `item_mods_pet` VALUES (28141,384,300,0);   -- Pet: Haste+3%
INSERT INTO `item_mods_pet` VALUES (28211,23,15,1);     -- Mdk. Crackows +1 Avatar: Increases attack +15 (?)
INSERT INTO `item_mods_pet` VALUES (28211,384,200,1);   -- Avatar: Haste+2%
INSERT INTO `item_mods_pet` VALUES (28213,23,13,2);     -- Ker's Sollerets Wyvern: Attack+13
INSERT INTO `item_mods_pet` VALUES (28214,68,5,0);      -- Sigyn's Jambeaux Pet: Evasion+5
INSERT INTO `item_mods_pet` VALUES (28219,68,2,0);      -- Idi's Ledelsens Pet: Evasion+2
INSERT INTO `item_mods_pet` VALUES (28231,23,10,0);     -- Totemic Gaiters Pet: Attack+10
INSERT INTO `item_mods_pet` VALUES (28231,25,10,0);     -- Pet: Accuracy+10
INSERT INTO `item_mods_pet` VALUES (28237,27,5,1);      -- Con. Pigaches Avatar: Enmity+5
INSERT INTO `item_mods_pet` VALUES (28237,68,20,1);     -- Avatar: Enhances evasion +20
INSERT INTO `item_mods_pet` VALUES (28237,126,5,1);     -- Avatar: Increases "Blood Pact" damage +5%
INSERT INTO `item_mods_pet` VALUES (28240,384,300,3);   -- Foire Babouches Automaton: Haste +3%
INSERT INTO `item_mods_pet` VALUES (28252,23,10,0);     -- Tot. Gaiters +1 Pet: Attack+10
INSERT INTO `item_mods_pet` VALUES (28252,25,10,0);     -- Pet: Accuracy+10
INSERT INTO `item_mods_pet` VALUES (28258,27,5,1);      -- Con. Pigaches +1 Avatar: Enmity+5
INSERT INTO `item_mods_pet` VALUES (28258,68,20,1);     -- Avatar: Evasion+20
INSERT INTO `item_mods_pet` VALUES (28258,126,6,1);     -- Avatar: "Blood Pact" damage +6
INSERT INTO `item_mods_pet` VALUES (28261,384,300,3);   -- Foire Bab. +1 Automaton: Haste+3%
INSERT INTO `item_mods_pet` VALUES (28356,28,5,1);      -- Eidolon Pendant +1 Avatar: "Magic Atk. Bonus"+5
INSERT INTO `item_mods_pet` VALUES (28432,25,15,3);     -- Ukko Sash Automaton: Accuracy+15
INSERT INTO `item_mods_pet` VALUES (28432,26,15,3);     -- Automaton: Ranged Accuracy+15
INSERT INTO `item_mods_pet` VALUES (28432,30,15,3);     -- Automaton: Magic Accuracy+15
INSERT INTO `item_mods_pet` VALUES (28432,384,500,3);   -- Automaton: Haste+5%
INSERT INTO `item_mods_pet` VALUES (28432,170,5,3);     -- Automaton: "Fast Cast"+5%
INSERT INTO `item_mods_pet` VALUES (28495,384,300,0);   -- Rimeice Earring Pet: Haste+3%
INSERT INTO `item_mods_pet` VALUES (28495,27,5,0);      -- Pet: Enmity+5
INSERT INTO `item_mods_pet` VALUES (28495,160,1,0);     -- Pet: Damage taken -1%
INSERT INTO `item_mods_pet` VALUES (28588,23,15,3);     -- Karagoz Mantle +1 Automaton: Attack +15
INSERT INTO `item_mods_pet` VALUES (28588,25,15,3);     -- Automaton: Accuracy +15
INSERT INTO `item_mods_pet` VALUES (28588,68,10,3);     -- Automaton: Evasion +10
INSERT INTO `item_mods_pet` VALUES (28605,25,7,1);      -- Samanisi Cape Avatar: Accuracy +7
INSERT INTO `item_mods_pet` VALUES (28605,30,7,1);      -- Avatar: Magic Accuracy +7
INSERT INTO `item_mods_pet` VALUES (28643,12,8,3);     -- Refraction Cape Automaton: INT+8
INSERT INTO `item_mods_pet` VALUES (28643,13,8,3);      -- Automaton: MND+8
INSERT INTO `item_mods_pet` VALUES (28643,30,3,3);      -- Automaton: Magic Accuracy+3

