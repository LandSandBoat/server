/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mob_droplist`
--

DROP TABLE IF EXISTS `mob_droplist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_droplist` (
  `dropId` smallint(5) unsigned NOT NULL,
  `dropType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `groupRate` smallint(4) unsigned NOT NULL DEFAULT '1000',
  `itemId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `itemRate` smallint(4) unsigned NOT NULL DEFAULT '0',
  KEY `dropId` (`dropId`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=9;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Variables
SET @ALWAYS = 1000;  -- Always, 100%
SET @VCOMMON = 240;  -- Very common, 24%
SET @COMMON = 150;   -- Common, 15%
SET @UNCOMMON = 100; -- Uncommon, 10%
SET @RARE = 50;      -- Rare, 5%
SET @VRARE = 10;     -- Very rare, 1%
SET @SRARE = 5;      -- Super Rare, 0.5%
SET @URARE = 1;      -- Ultra rare, 0.1%

--
-- Dumping data for table `mob_droplist`
--

LOCK TABLES `mob_droplist` WRITE;
/*!40000 ALTER TABLE `mob_droplist` DISABLE KEYS */;
-- ZoneID:  99 - Aa Xalmo The Savage

-- ZoneID:  24 - Abraxas

-- ZoneID:  33 - Absolute Virtue

-- ZoneID: 161 - Abyssal Demon

-- ZoneID: 216 - Abyssic Cluster -- TODO: Abyssea NM

-- ZoneID: 216 - Abyssobugard

-- ZoneID: 176 - Abyss Sahagin

-- ZoneID: 198 - Abyss Worm

-- ZoneID:  15 - Abxzomit
-- ZoneID:  15 - Dybbuk
-- ZoneID:  15 - Meanderer
-- ZoneID:  45 - Bhumi
-- ZoneID:  45 - Naul
-- ZoneID:  45 - Thalassinon
-- ZoneID:  45 - Vermes Carnium
-- ZoneID: 132 - Akash
-- ZoneID: 132 - Psychopomp
-- ZoneID: 132 - Meditator

-- ZoneID: 170 - Ace Of Batons

-- ZoneID: 170 - Ace Of Coins

-- ZoneID: 170 - Ace Of Cups

-- ZoneID: 170 - Ace Of Swords

-- ZoneID:  62 - Achamoth

-- ZoneID:  11 - Amoebic Nodule
-- ZoneID:  27 - Sponge
-- ZoneID:  27 - Water Pumpkin
-- ZoneID:  27 - Freshwater Trepang
-- ZoneID:  27 - Oil Spill
-- ZoneID:  65 - Brei
-- ZoneID:  68 - Slime Mold
-- ZoneID:  77 - Mousse
-- ZoneID:  79 - Caedarva Pondscum
-- ZoneID:  79 - Caedarva Marshscum
-- ZoneID:  79 - Oil Slick
-- ZoneID:  85 - Gloop Fished
-- ZoneID:  85 - Oil Spill Fished
-- ZoneID:  90 - Mousse
-- ZoneID: 149 - Gloop Fished
-- ZoneID: 149 - Oil Spill Fished
-- ZoneID: 164 - Mousse
-- ZoneID: 166 - Oil Slick
-- ZoneID: 167 - Acid Grease Fished
-- ZoneID: 167 - Mousse Fished
-- ZoneID: 193 - Rancid Ooze Fished
-- ZoneID: 194 - Black Slime
-- ZoneID: 196 - Mush
-- ZoneID: 196 - Jelly
-- ZoneID: 196 - Ooze Fished
INSERT INTO `mob_droplist` VALUES (15,0,0,1000,637,@COMMON); -- Vial Of Slime Oil (Common, 15%)
INSERT INTO `mob_droplist` VALUES (15,4,0,1000,637,0);       -- Vial Of Slime Oil (Despoil)

-- ZoneID: 200 - Acid Grease

-- ZoneID:  24 - Acrophies
-- ZoneID:  61 - Volcanic Leech
-- ZoneID: 121 - Goobbue Parasite

-- ZoneID: 103 - Thread Leech
-- ZoneID: 110 - Poison Leech
-- ZoneID: 126 - Acrophies
-- ZoneID: 169 - Bloodsucker Fished
-- ZoneID: 169 - Bloodsucker
-- ZoneID: 193 - Poison Leech
-- ZoneID: 198 - Poison Leech
-- ZoneID: 198 - Bleeder Leech

-- ZoneID: 100 - Mouse Bat
-- ZoneID: 101 - Mouse Bat
-- ZoneID: 102 - Acro Bat
-- ZoneID: 102 - Poison Bat
-- ZoneID: 157 - Stirge

-- ZoneID: 186 - Adamantking Effigy
-- ZoneID: 186 - Adamantking Effigy

-- ZoneID: 128 - Adamantoise

-- ZoneID:  92 - Adaman Quadav
-- ZoneID:  92 - Ferroalloy Quadav
-- ZoneID:  92 - Iron Quadav
-- ZoneID:  92 - Steel Quadav
-- ZoneID: 138 - Adaman Quadav
-- ZoneID: 138 - Ancient Quadav
-- ZoneID: 138 - Gold Quadav
-- ZoneID: 138 - Iron Quadav
-- ZoneID: 155 - Steel Quadav

-- ZoneID: 148 - Adaman Quadav

-- ZoneID: 132 - Adamastor -- TODO: Abyssea NM

-- ZoneID: 253 - Adasaurus

-- ZoneID:  27 - Addled Tumor

-- ZoneID: 137 - Adjudicator Demon
-- ZoneID: 155 - Adjudicator Demon

-- ZoneID: 217 - Aestutaur

-- ZoneID: 215 - Aggressor Antlion -- TODO: Abyssea NM

-- ZoneID:   5 - Morozko
-- ZoneID:   5 - Akselloak
-- ZoneID:   5 - Agloolik
-- ZoneID:   9 - Morozko
-- ZoneID:   9 - Avalanche

-- ZoneID:  85 - Agrios

-- ZoneID: 161 - Ahriman

-- ZoneID: 105 - Ahtu

-- ZoneID:  51 - Aht Urhgan Attercop
-- ZoneID:  52 - Aht Urhgan Attercop

-- ZoneID:  30 - Aiatar

-- ZoneID:  77 - Aiatar
-- ZoneID:  77 - Ungur
-- ZoneID:  77 - Vouivre
-- ZoneID:  77 - Wyvern
INSERT INTO `mob_droplist` VALUES (36,0,0,1000,1122,@RARE);  -- Wyvern Skin (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (36,0,0,1000,1124,@VRARE); -- Wyvern Wing (Very Rare, 1%)

-- ZoneID:  61 - Zazalda Jagil
-- ZoneID:  77 - Stygian Pugil
-- ZoneID: 126 - Greater Pugil Fished
INSERT INTO `mob_droplist` VALUES (37,0,0,1000,868,@RARE);   -- Handful Of Pugil Scales (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (37,0,0,1000,4484,@VRARE); -- Shall Shell (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (37,2,0,1000,864,0);       -- Handful Of Fish Scales (Steal)
INSERT INTO `mob_droplist` VALUES (37,4,0,1000,868,0);       -- Handful Of Pugil Scales (Despoil)
INSERT INTO `mob_droplist` VALUES (37,4,0,1000,864,0);       -- Handful Of Fish Scales (Despoil)

-- ZoneID:   7 - Air Elemental
-- ZoneID:   7 - Air Elemental
-- ZoneID:  24 - Air Elemental
-- ZoneID:  25 - Air Elemental
-- ZoneID:  27 - Air Elemental
-- ZoneID:  28 - Air Elemental
-- ZoneID:  29 - Air Elemental
-- ZoneID:  30 - Air Elemental
-- ZoneID:  51 - Air Elemental
-- ZoneID:  52 - Air Elemental
-- ZoneID:  58 - Air Elemental
-- ZoneID:  59 - Air Elemental
-- ZoneID:  65 - Air Elemental
-- ZoneID:  68 - Air Elemental
-- ZoneID:  83 - Air Elemental
-- ZoneID:  89 - Air Elemental
-- ZoneID:  89 - Air Elemental
-- ZoneID:  96 - Air Elemental
-- ZoneID: 102 - Air Elemental
-- ZoneID: 113 - Air Elemental
-- ZoneID: 117 - Air Elemental
-- ZoneID: 118 - Air Elemental
-- ZoneID: 130 - Air Elemental
-- ZoneID: 174 - Air Elemental
-- ZoneID: 177 - Air Elemental
-- ZoneID: 178 - Air Elemental
-- ZoneID: 213 - Air Elemental

-- ZoneID: 193 - Air Elemental

-- ZoneID: 198 - Air Elemental

-- ZoneID:  40 - Aitvaras

-- ZoneID:  89 - Ajattara
-- ZoneID: 212 - Typhoon Wyvern

-- ZoneID:  25 - Seaboard Vulture
-- ZoneID:  83 - Carrion Marabou
-- ZoneID: 102 - Akbaba
-- ZoneID: 104 - Screamer
-- ZoneID: 115 - Carrion Crow
-- ZoneID: 116 - Carrion Crow
-- ZoneID: 117 - Akbaba
-- ZoneID: 118 - Zu
-- ZoneID: 119 - Jubjub

-- ZoneID: 218 - Akrab

-- ZoneID:   7 - Alastor Antlion

-- 46 Available

-- ZoneID: 254 - Alfard -- TODO: Abyssea NM

-- ZoneID:  40 - Alklha

-- ZoneID:  15 - Alkonost -- TODO: Abyssea NM

-- ZoneID: 158 - Alkyoneus

-- ZoneID:  85 - All-Seeing Onyx Eye

-- ZoneID:  59 - Almighty Apkallu

-- 53 Available

-- ZoneID: 204 - Altedour I Tavnazia

-- ZoneID:  24 - Amaltheia

-- ZoneID: 218 - Amarok -- TODO: Abyssea NM

-- ZoneID:  88 - Amber Quadav

-- ZoneID: 106 - Amber Quadav
-- ZoneID: 107 - Amber Quadav
-- ZoneID: 108 - Amber Quadav

-- ZoneID: 143 - Amber Quadav

-- 60 Available

-- ZoneID:   7 - Ambusher Antlion

-- ZoneID: 174 - Amemet

-- ZoneID:  51 - Ameretat
-- ZoneID:  51 - Great Ameretat
-- ZoneID:  52 - Ameretat

-- ZoneID:  77 - Ameretat
-- ZoneID:  77 - Jaded Jody
INSERT INTO `mob_droplist` VALUES (64,0,0,1000,2361,@COMMON); -- Ameretat Vine (Common, 15%)
INSERT INTO `mob_droplist` VALUES (64,0,0,1000,1446,@VRARE);  -- Lacquer Tree Log (Very Rare, 1%)

-- ZoneID:  88 - Amethyst Quadav
-- ZoneID:  89 - Amethyst Quadav

-- 66 Available

-- ZoneID: 106 - Amethyst Quadav
-- ZoneID: 107 - Amethyst Quadav
-- ZoneID: 108 - Amethyst Quadav

-- 68 Available

-- ZoneID: 143 - Amethyst Quadav

-- ZoneID: 216 - Amhuluk -- TODO: Abyssea NM

-- ZoneID:  77 - Carnero
-- ZoneID:  77 - Stray Mary
INSERT INTO `mob_droplist` VALUES (71,0,0,1000,4372,@COMMON);  -- Slice Of Giant Sheep Meat (Common, 15%)
INSERT INTO `mob_droplist` VALUES (71,0,0,1000,505,@UNCOMMON); -- Sheepskin (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (71,0,0,1000,882,@VRARE);    -- Sheep Tooth (Very Rare, 1%)

-- ZoneID: 212 - Amikiri

-- ZoneID: 136 - Amphiptere

-- ZoneID: 196 - Amphisbaena

-- ZoneID: 254 - Amphitrite -- TODO: Abyssea NM

-- ZoneID: 215 - Amuckatrice

-- ZoneID: 215 - Amun -- TODO: Abyssea NM

-- ZoneID:  61 - Anantaboga

-- ZoneID:  65 - Mamool Ja Bloodsucker
-- ZoneID:  77 - Bouncing Ball
-- ZoneID:  90 - Swamp Leech
-- ZoneID: 104 - Forest Leech
-- ZoneID: 110 - Big Leech Fished
-- ZoneID: 173 - Spool Leech
-- ZoneID: 191 - Thread Leech Fished
-- ZoneID: 193 - Thread Leech Fished
-- ZoneID: 193 - Poison Leech Fished
-- ZoneID: 193 - Thread Leech
INSERT INTO `mob_droplist` VALUES (79,0,0,1000,924,@UNCOMMON); -- Vial Of Fiend Blood (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (79,4,0,1000,924,0);         -- Vial Of Fiend Blood (Despoil)
INSERT INTO `mob_droplist` VALUES (79,4,0,1000,930,0);         -- Vial Of Beastman Blood (Despoil)
INSERT INTO `mob_droplist` VALUES (79,4,0,1000,2014,0);        -- Vial Of Bird Blood (Despoil)

-- ZoneID:   2 - Bulldog Bats
-- ZoneID:  89 - Vampire Bat
-- ZoneID:  90 - Sanguine Bat
-- ZoneID:  97 - Night Bats
-- ZoneID:  98 - Midnight Wings
-- ZoneID: 204 - Undead Bats

-- ZoneID: 193 - Seeker Bats
-- ZoneID: 193 - Stink Bats

-- ZoneID:  77 - Old Two-Wings
-- ZoneID:  77 - Golden Bat
-- ZoneID:  81 - Mouse Bat
-- ZoneID:  91 - Midnight Wings
-- ZoneID: 100 - Ding Bats
-- ZoneID: 101 - Ding Bats
-- ZoneID: 102 - Gale Bats
-- ZoneID: 102 - Plague Bats
-- ZoneID: 103 - Night Bats
-- ZoneID: 106 - Ding Bats
-- ZoneID: 107 - Ding Bats
-- ZoneID: 109 - Night Bats
-- ZoneID: 110 - Midnight Wings
-- ZoneID: 119 - Night Bats
-- ZoneID: 120 - Midnight Wings
-- ZoneID: 126 - Dark Bats
-- ZoneID: 126 - Seeker Bats
-- ZoneID: 149 - Wood Bats
-- ZoneID: 140 - Spectacled Bats
-- ZoneID: 141 - Spectacled Bats
-- ZoneID: 142 - Grotto Bats
-- ZoneID: 151 - Bastion Bats
-- ZoneID: 157 - Mold Bats
-- ZoneID: 157 - Tower Bats
-- ZoneID: 166 - Seeker Bats
-- ZoneID: 166 - Wind Bats
-- ZoneID: 184 - Seeker Bats
-- ZoneID: 190 - Wind Bats
-- ZoneID: 194 - Fetor Bats
-- ZoneID: 198 - Chaser Bats
-- ZoneID: 198 - Seeker Bats
-- ZoneID: 198 - Stink Bats
-- ZoneID: 200 - Fortalice Bats
INSERT INTO `mob_droplist` VALUES (82,0,0,1000,922,@COMMON); -- Bat Wing (Common, 15%)
INSERT INTO `mob_droplist` VALUES (82,4,0,1000,922,0);       -- Bat Wing (Despoil)

-- ZoneID:  11 - Ancient Bomb

-- ZoneID:  61 - Ancient Bombs

-- ZoneID: 216 - Ancient Orobon

-- ZoneID:  90 - Ancient Quadav
-- ZoneID:  92 - Ancient Quadav

-- 87 Available

-- ZoneID: 147 - Ancient Quadav

-- ZoneID: 148 - Ancient Quadav

-- ZoneID: 253 - Anemic Aloysius -- TODO: Abyssea NM

-- ZoneID: 124 - Anemone

-- ZoneID: 195 - Anemone

-- ZoneID:   1 - Snipper Fished
-- ZoneID:   2 - Snipper Fished
-- ZoneID:   2 - Clipper Fished
-- ZoneID:   3 - Ghost Crab Fished
-- ZoneID:   3 - Cutter Fished
-- ZoneID:  11 - Cutter Fished
-- ZoneID:  11 - Ghost Crab Fished
-- ZoneID:  24 - Clipper Fished
-- ZoneID:  25 - Clipper Fished
-- ZoneID:  81 - Snipper Fished
-- ZoneID:  82 - Stag Crab
-- ZoneID:  83 - Submarine Nipper
-- ZoneID:  84 - Snipper Fished
-- ZoneID:  84 - Cutter Fished
-- ZoneID:  88 - Stone Crab
-- ZoneID:  88 - Land Crab Fished
-- ZoneID:  89 - River Crab Fished
-- ZoneID:  90 - Stag Crab
-- ZoneID:  91 - Snipper Fished
-- ZoneID:  91 - Clipper
-- ZoneID: 103 - Stag Crab
-- ZoneID: 103 - Cutter Fished
-- ZoneID: 104 - Stag Crab
-- ZoneID: 105 - Clipper
-- ZoneID: 105 - Snipper Fished
-- ZoneID: 105 - Cutter Fished
-- ZoneID: 107 - Mole Crab
-- ZoneID: 107 - Passage Crab
-- ZoneID: 109 - Stag Crab
-- ZoneID: 110 - Snipper Fished
-- ZoneID: 114 - Cutter Fished
-- ZoneID: 114 - Ironshell Fished
-- ZoneID: 115 - Passage Crab
-- ZoneID: 118 - Stag Crab
-- ZoneID: 120 - Snipper Fished
-- ZoneID: 120 - Cutter Fished
-- ZoneID: 121 - Clipper Fished
-- ZoneID: 123 - Ironshell Fished
-- ZoneID: 125 - Ironshell Fished
-- ZoneID: 126 - Clipper
-- ZoneID: 143 - Stag Crab
-- ZoneID: 173 - Snipper Fished
-- ZoneID: 191 - Land Crab Fished
-- ZoneID: 193 - Stag Crab

-- ZoneID: 132 - Angler Tiger

-- ZoneID: 155 - Yagudo Yojimbo
-- ZoneID: 155 - Yagudo Nokizaru

-- ZoneID:  98 - Yagudo Abbot
-- ZoneID: 164 - Yagudo Abbot

-- ZoneID:  99 - Yagudo Abbot

-- ZoneID:  77 - Emergent Elm
-- ZoneID:  77 - Fraelissa
INSERT INTO `mob_droplist` VALUES (98,1,1,@VRARE,700,300);   -- Mahogany Log (Group 1, Very Rare, 1% - 30%)
INSERT INTO `mob_droplist` VALUES (98,1,1,@VRARE,701,450);   -- Rosewood Log (Group 1, Very Rare, 1% - 45%)
INSERT INTO `mob_droplist` VALUES (98,1,1,@VRARE,702,150);   -- Ebony Log (Group 1, Very Rare, 1% - 15%)
INSERT INTO `mob_droplist` VALUES (98,1,1,@VRARE,703,100);   -- Petrified Log (Group 1, Very Rare, 1% - 10%)

-- ZoneID:  77 - Amikiri
-- ZoneID:  77 - Tyrannic Tunnok
-- ZoneID:  77 - Serket
INSERT INTO `mob_droplist` VALUES (99,0,0,1000,897,@COMMON);   -- Scorpion Claw (Common, 15%)
INSERT INTO `mob_droplist` VALUES (99,0,0,1000,896,@UNCOMMON); -- Scorpion Shell (Uncommon, 10%)

-- ZoneID:  77 - Cargo Crab Colin
-- ZoneID:  77 - Aquarius
INSERT INTO `mob_droplist` VALUES (100,0,0,1000,4400,@UNCOMMON); -- Slice Of Land Crab Meat (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (100,0,0,1000,881,@VRARE);     -- Crab Shell (Very Rare, 1%)

-- ZoneID:  77 - Bloodsucker NM
-- ZoneID:  77 - Bloodpool Vorax
-- ZoneID:  77 - Leech King
INSERT INTO `mob_droplist` VALUES (101,0,0,1000,924,@UNCOMMON); -- Vial Of Fiend Blood (Uncommon, 10%)

-- ZoneID:  77 - Buburimboo
-- ZoneID:  77 - Swamfisk
INSERT INTO `mob_droplist` VALUES (102,0,0,1000,868,@UNCOMMON);  -- Handful Of Pugil Scales (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (102,0,0,1000,4484,@UNCOMMON); -- Shall Shell (Uncommon, 10%)

-- ZoneID:  77 - Sand Lizard
-- ZoneID:  77 - Leaping Lizzy
INSERT INTO `mob_droplist` VALUES (103,0,0,1000,926,@COMMON);   -- Lizard Tail (Common, 15%)
INSERT INTO `mob_droplist` VALUES (103,0,0,1000,852,@UNCOMMON); -- Lizard Skin (Uncommon, 10%)

-- ZoneID:  77 - Jaggedy-Eared Jack
-- ZoneID:  77 - Sharp-Eared Ropipi
-- ZoneID:  77 - Unut
INSERT INTO `mob_droplist` VALUES (104,0,0,1000,856,@COMMON);    -- Rabbit Hide (Common, 15%)
INSERT INTO `mob_droplist` VALUES (104,0,0,1000,4358,@UNCOMMON); -- Slice Of Hare Meat (Uncommon, 10%)

-- ZoneID:  77 - Gargantua
INSERT INTO `mob_droplist` VALUES (105,0,0,1000,644,@COMMON); -- Chunk Of Mythril Ore (Common, 15%)
INSERT INTO `mob_droplist` VALUES (105,0,0,1000,955,@VRARE);  -- Golem Shard (Very Rare, 1%)

-- ZoneID:  77 - Intulo
INSERT INTO `mob_droplist` VALUES (106,0,0,1000,4362,@UNCOMMON); -- Lizard Egg (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (106,0,0,1000,1623,@RARE);     -- Eft Skin (Rare, 5%)

-- ZoneID:  77 - Serpopard Ishtar
INSERT INTO `mob_droplist` VALUES (107,0,0,1000,4359,@COMMON); -- Slice Of Dhalmel Meat (Common, 15%)
INSERT INTO `mob_droplist` VALUES (107,0,0,1000,857,@RARE);    -- Dhalmel Hide (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (107,0,0,1000,893,@RARE);    -- Giant Femur (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (107,0,0,1000,938,@VRARE);   -- Sprig Of Papaka Grass (Very Rare, 1%)

-- ZoneID:  77 - Mischievous Micholas
INSERT INTO `mob_droplist` VALUES (108,0,0,1000,4432,@UNCOMMON); -- Kazham Pineapple (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (108,0,0,1000,4468,@COMMON);   -- Bunch Of Pamamas (Common, 15%)
INSERT INTO `mob_droplist` VALUES (108,0,0,1000,4412,@UNCOMMON); -- Thundermelon (Uncommon, 10%)

-- ZoneID:  77 - Keeper Of Halidom
-- ZoneID:  77 - Jolly Green
INSERT INTO `mob_droplist` VALUES (109,0,0,1000,1237,@RARE);  -- Bag Of Tree Cuttings (Rare, 5%)

-- ZoneID:  77 - Peg Powler
INSERT INTO `mob_droplist` VALUES (110,0,0,1000,4484,@COMMON); -- Shall Shell (Common, 15%)
INSERT INTO `mob_droplist` VALUES (110,0,0,1000,792,@VRARE);   -- Pearl (Very Rare, 1%)

-- ZoneID: 218 - Ansherekh -- TODO: Abyssea NM

-- ZoneID:  41 - Antaeus

-- ZoneID:   7 - Doom Scorpion
-- ZoneID:   7 - Tulwar Scorpion
-- ZoneID: 171 - Doom Scorpion

-- ZoneID: 208 - Antican Aedilis -- TODO: Xhifut Strings are rumored to only drop on map 4 and not from all Aedilis.

-- ZoneID: 208 - Antican Antesignanus

-- ZoneID: 114 - Antican Auxiliarius

-- ZoneID: 114 - Antican Veles
-- ZoneID: 114 - Antican Centurio
-- ZoneID: 125 - Antican Secutor

-- ZoneID: 208 - Antican Consul

-- ZoneID: 114 - Antican Decurio
-- ZoneID: 125 - Antican Eques

-- 120 Available

-- ZoneID: 114 - Antican Sagittarius
-- ZoneID: 125 - Antican Essedarius

-- 122 Available

-- ZoneID: 114 - Antican Faber

-- ZoneID: 114 - Antican Funditor

-- ZoneID: 208 - Antican Hastatus

-- ZoneID: 125 - Antican Hoplomachus

-- ZoneID: 125 - Antican Lanista

-- ZoneID: 208 - Antican Legatus

-- ZoneID: 208 - Antican Magister

-- ZoneID: 208 - Antican Praefectus

-- ZoneID: 208 - Antican Praetor

-- ZoneID: 208 - Antican Princeps

-- ZoneID: 208 - Antican Proconsul

-- ZoneID: 208 - Antican Quaestor

-- ZoneID: 114 - Antican Speculator
-- ZoneID: 125 - Antican Retiarius

-- 135-136 Available

-- ZoneID: 208 - Antican Signifer

-- ZoneID: 208 - Antican Triarius

-- ZoneID: 208 - Antican Tribunus

-- ZoneID:  84 - Forester Beetle

-- ZoneID:  30 - Darner
-- ZoneID:  83 - Dragonfly
-- ZoneID:  84 - Sadfly
-- ZoneID:  90 - Gadfly
-- ZoneID:  91 - Dragonfly
-- ZoneID:  91 - Hawker
-- ZoneID:  96 - Dragonfly
-- ZoneID:  97 - Dragonfly
-- ZoneID:  99 - Antlion Fly

-- ZoneID: 188 - Tufflix Loglimbs
-- ZoneID: 188 - Smeltix Thickhide
-- ZoneID: 188 - Jabkix Pigeonpecs
-- ZoneID: 188 - Wasabix Callusdigit
-- ZoneID: 188 - Hermitrix Toothrot
-- ZoneID: 188 - Wyrmwix Snakespecs
-- ZoneID: 188 - Morgmox Moldnoggin
-- ZoneID: 188 - Sparkspox Sweatbrow
-- ZoneID: 188 - Elixmix Hooknose
-- ZoneID: 188 - Buffrix Eargone
-- ZoneID: 188 - Humnox Drumbelly
-- ZoneID: 188 - Ticktox Beadyeyes
-- ZoneID: 188 - Lurklox Dhalmelneck
-- ZoneID: 188 - Anvilix Sootwrists
-- ZoneID: 188 - Bootrix Jaggedelbow
-- ZoneID: 188 - Mobpix Mucousmouth
-- ZoneID: 188 - Distilix Stickytoes
-- ZoneID: 188 - Jabbrox Grannyguise
-- ZoneID: 188 - Scruffix Shaggychest
-- ZoneID: 188 - Blazox Boneybod
-- ZoneID: 188 - Cloktix Longnail
-- ZoneID: 188 - Slystix Megapeepers
-- ZoneID: 188 - Bandrix Rockjaw
-- ZoneID: 188 - Gabblox Magpietongue
-- ZoneID: 188 - Rutrix Hamgams
-- ZoneID: 188 - Trailblix Goatmug

-- ZoneID: 188 - Kikklix Longlegs
-- ZoneID: 188 - Karashix Swollenskull
-- ZoneID: 188 - Snypestix Eaglebeak
-- ZoneID: 188 - Eremix Snottynostril
-- ZoneID: 188 - Prowlox Barrelbelly
-- ZoneID: 188 - Mortilox Wartpaws
-- ZoneID: 188 - Tymexox Ninefingers

-- ZoneID: 253 - Apademak -- TODO: Abyssea NM

-- ZoneID:  54 - Arrapago Apkallu
-- ZoneID:  58 - Apkallu
-- ZoneID:  59 - Apkallu

-- ZoneID:  40 - Apocalyptic Beast

-- ZoneID:   1 - Big Jaw Fished
-- ZoneID:   2 - Greater Pugil Fished
-- ZoneID:   3 - Greater Pugil Fished
-- ZoneID:   4 - Apsaras
-- ZoneID:  24 - Greater Pugil Fished
-- ZoneID:  24 - Apsaras
-- ZoneID:  25 - Greater Pugil Fished
-- ZoneID:  61 - Vozold Jagil
-- ZoneID:  65 - Suhur Mas Fished
-- ZoneID:  79 - Suhur Mas Fished
-- ZoneID:  82 - Spring Pugil
-- ZoneID:  82 - Ferocious Pugil
-- ZoneID:  85 - Ferocious Pugil
-- ZoneID:  89 - Gill Pugil
-- ZoneID:  90 - Swamp Pugil
-- ZoneID:  91 - Big Jaw Fished
-- ZoneID: 102 - Giant Pugil Fished
-- ZoneID: 104 - Spring Pugil
-- ZoneID: 104 - Ferocious Pugil
-- ZoneID: 105 - Greater Pugil Fished
-- ZoneID: 109 - Swamp Pugil
-- ZoneID: 110 - Big Jaw Fished
-- ZoneID: 110 - Greater Pugil Fished
-- ZoneID: 111 - Greater Pugil Fished
-- ZoneID: 111 - Vepar
-- ZoneID: 111 - Apsaras
-- ZoneID: 113 - Razorjaw Pugil Fished
-- ZoneID: 113 - Stygian Pugil Fished
-- ZoneID: 114 - Greater Pugil Fished
-- ZoneID: 114 - Makara Fished
-- ZoneID: 120 - Big Jaw Fished
-- ZoneID: 120 - Greater Pugil Fished
-- ZoneID: 121 - Greater Pugil Fished
-- ZoneID: 121 - Apsaras
-- ZoneID: 124 - Greater Pugil Fished
-- ZoneID: 124 - Vepar
-- ZoneID: 124 - Makara Fished
-- ZoneID: 125 - Apsaras
-- ZoneID: 125 - Razorjaw Pugil Fished
-- ZoneID: 126 - Qufim Pugil
-- ZoneID: 126 - Vepar
-- ZoneID: 140 - Giant Pugil Fished
-- ZoneID: 141 - Giant Pugil Fished
-- ZoneID: 149 - Ferocious Pugil
-- ZoneID: 149 - Greater Pugil Fished
-- ZoneID: 153 - Demonic Pugil Fished
-- ZoneID: 154 - Demonic Pugil Fished
-- ZoneID: 160 - Razorjaw Pugil Fished
-- ZoneID: 176 - Big Jaw Fished
-- ZoneID: 176 - Stygian Pugil Fished
-- ZoneID: 196 - Pirate Pugil
-- ZoneID: 220 - Ocean Pugil
-- ZoneID: 220 - Pirate Pugil
-- ZoneID: 221 - Ocean Pugil
-- ZoneID: 221 - Pirate Pugil
-- ZoneID: 227 - Ocean Pugil
-- ZoneID: 227 - Pirate Pugil
-- ZoneID: 228 - Ocean Pugil
-- ZoneID: 228 - Pirate Pugil

-- ZoneID:  77 - Bat Eye
-- ZoneID:  77 - Shadow Eye
INSERT INTO `mob_droplist` VALUES (148,0,0,1000,557,@RARE);   -- Ahriman Lens (Rare, 5%)

-- ZoneID: 153 - Aquarius

-- ZoneID: 174 - Arachne

-- ZoneID:  74 - Archaic Chariot -- TODO: Salvage
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5367,@ALWAYS);    -- Cumulus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5369,@ALWAYS);    -- Stratus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5372,@ALWAYS);    -- Virga Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5735,@ALWAYS);    -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5367,500);        -- Cumulus Cell (50.0%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5369,500);        -- Stratus Cell (50.0%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,5372,500);        -- Virga Cell (50.0%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,14976,120);       -- Enlils Kolluks (12.0%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,15636,120);       -- Hikazu Hakama (12.0%)
INSERT INTO `mob_droplist` VALUES (151,0,0,1000,15718,@UNCOMMON); -- Freyas Ledelsens (Uncommon, 10%)

-- ZoneID:  75 - Troll Smelter
-- ZoneID:  75 - Troll Stoneworker
-- ZoneID:  75 - Troll_Cameist
-- ZoneID:  75 - Wandering_Wamoura
-- ZoneID:  75 - Troll_Engraver
-- ZoneID:  75 - Troll_Gemologist
-- ZoneID:  75 - Troll_Lapidarist
-- ZoneID:  75 - Troll Ironworker
-- ZoneID:  75 - Black Pudding
INSERT INTO `mob_droplist` VALUES (152,1,1,@URARE,14970,200); -- Hoshikazu Tekko (Group 1, Ultra Rare, 0.1%)
INSERT INTO `mob_droplist` VALUES (152,1,1,@URARE,15712,200); -- Enyo's Leggings (Group 1, Ultra Rare, 0.1%)
INSERT INTO `mob_droplist` VALUES (152,1,1,@URARE,15728,200); -- Nemain's Sabots (Group 1, Ultra Rare, 0.1%)
INSERT INTO `mob_droplist` VALUES (152,1,1,@URARE,15630,200); -- Njord's Trousers (Group 1, Ultra Rare, 0.1%)
INSERT INTO `mob_droplist` VALUES (152,1,1,@URARE,16097,200); -- Anu's Tiara (Group 1, Ultra Rare, 0.1%)

-- ZoneID:   9 - Archaic Chest

-- ZoneID:  76 - Archaic Rampart
-- ZoneID:  76 - Archaic Gear
-- ZoneID:  76 - Archaic Gears
INSERT INTO `mob_droplist` VALUES (154,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)

-- ZoneID:  74 - Archaic Gear -- TODO: Salvage
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,5373,800);       -- Duplicatus Cell (80.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,5369,680);       -- Stratus Cell (68.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,15642,80);       -- Nemains Slops (8.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,2376,60);        -- Arrapago Card (6.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,14966,60);       -- Njords Gloves (6.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,15724,60);       -- Anus Gaiters (6.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,15626,20);       -- Enyos Cuisses (2.0%)
INSERT INTO `mob_droplist` VALUES (155,0,0,1000,16093,20);       -- Hoshikazu Hachimaki (2.0%)

-- ZoneID:  75 - Zebra Zachary
INSERT INTO `mob_droplist` VALUES (156,0,0,1000,5735,@ALWAYS); -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (156,0,0,1000,5735,@SRARE);  -- Cotton Coin Purse (Super Rare, 1%)
INSERT INTO `mob_droplist` VALUES (156,0,0,1000,14964,@RARE);  -- Deimos's Gauntlets (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (156,0,0,1000,16091,@RARE);  -- Freya's Mask (Rare, 5%)

-- ZoneID:  73 - Fourth Rampart -- TODO: Salvage
-- ZoneID:  73 - Archaic Gears
INSERT INTO `mob_droplist` VALUES (157,0,0,1000,2375,@UNCOMMON); -- Zhayolm Card (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (157,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)

-- ZoneID:  74 - Archaic Gears -- TODO: Salvage
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,2376,@UNCOMMON);  -- Arrapago Card (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,2488,@UNCOMMON);  -- Piece Of Alexandrite (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,5367,@UNCOMMON);  -- Cumulus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,5371,@UNCOMMON);  -- Undulatus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,14966,@UNCOMMON); -- Njords Gloves (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,15626,@UNCOMMON); -- Enyos Cuisses (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,15642,@UNCOMMON); -- Nemains Slops (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,15724,@UNCOMMON); -- Anus Gaiters (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (158,0,0,1000,16093,@UNCOMMON); -- Hoshikazu Hachimaki (Uncommon, 10%)

-- ZoneID:  75 - Archaic Gears
-- ZoneID:  75 - Archaic Gear
INSERT INTO `mob_droplist` VALUES (159,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (159,0,0,1000,2488,@SRARE);    -- Piece Of Alexandrite (Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (159,0,0,1000,5374,@RARE);     -- Opacus Cell (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (159,0,0,1000,5375,@RARE);     -- Praecipitatio Cell (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (159,1,1,@VRARE,14970,200);    -- Hoshikazu Tekko (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (159,1,1,@VRARE,15712,200);    -- Enyo's Leggings (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (159,1,1,@VRARE,15728,200);    -- Nemain's Sabots (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (159,1,1,@VRARE,15630,200);    -- Njord's Trousers (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (159,1,1,@VRARE,16097,200);    -- Anu's Tiara (Group 1, Very Rare, 1%)

-- ZoneID:  54 - Archaic Mirror
-- ZoneID:  62 - Archaic Mirror
-- ZoneID:  65 - Archaic Mirror

-- ZoneID:  74 - Archaic Rampart -- TODO: Salvage
INSERT INTO `mob_droplist` VALUES (161,0,0,1000,2376,@UNCOMMON); -- Arrapago Card (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (161,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (161,0,0,1000,5368,@UNCOMMON); -- Radiatus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (161,0,0,1000,5383,@UNCOMMON); -- Humilus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (161,0,0,1000,5384,@UNCOMMON); -- Spissatus Cell (Uncommon, 10%)

-- ZoneID:   7 - Arch Corse

-- ZoneID: 161 - Arch Demon

-- ZoneID:  77 - Argus
INSERT INTO `mob_droplist` VALUES (164,0,0,1000,914,@COMMON);   -- Vial Of Mercury (Common, 15%)
INSERT INTO `mob_droplist` VALUES (164,0,0,1000,939,@UNCOMMON); -- Hecteyes Eye (Uncommon, 10%)

-- ZoneID: 198 - Argus

-- ZoneID:  15 - Arimaspi -- TODO: Abyssea NM

-- ZoneID: 159 - Temple Bee

-- ZoneID:  72 - Armed Gears

-- ZoneID:   2 - Diving Beetle
-- ZoneID:  83 - Goliath Beetle
-- ZoneID:  98 - Diving Beetle

-- ZoneID: 217 - Armillaria -- TODO: Abyssea NM

-- ZoneID:  74 - Armored Chariot
INSERT INTO `mob_droplist` VALUES (171,1,1,@ALWAYS,14560,166);    -- Eas Doublet (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,1,@ALWAYS,15729,166);    -- Bodbs Pigaches (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,1,@ALWAYS,16098,166);    -- Eas Tiara (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,1,@ALWAYS,14971,166);    -- Tsukikazu Gote (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,1,@ALWAYS,15631,166);    -- Freyrs Trousers (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,1,@ALWAYS,15713,166);    -- Phoboss Sabatons (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,2,@ALWAYS,14560,166);    -- Eas Doublet (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,2,@ALWAYS,15729,166);    -- Bodbs Pigaches (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,2,@ALWAYS,16098,166);    -- Eas Tiara (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,2,@ALWAYS,14971,166);    -- Tsukikazu Gote (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,2,@ALWAYS,15631,166);    -- Freyrs Trousers (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,1,2,@ALWAYS,15713,166);    -- Phoboss Sabatons (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (171,0,0,1000,5736,@UNCOMMON);  -- Linen Coin Purse (Uncommon, 10%)

-- 172-173 Available

-- ZoneID:  51 - Red Smoocher
-- ZoneID:  51 - Red Osculator
-- ZoneID:  51 - Kissing Leech
-- ZoneID:  51 - Red Kisser
-- ZoneID:  52 - Red Smoocher
-- ZoneID:  52 - Red Osculator
-- ZoneID:  52 - Kissing Leech
-- ZoneID:  52 - Red Kisser
-- ZoneID:  54 - Arrapago Leech
-- ZoneID:  54 - Ashakku
-- ZoneID:  54 - Nirgali
-- ZoneID:  68 - Phlebotomic Slug
-- ZoneID:  79 - Caedarva Leech
-- ZoneID:  83 - Bloodsucker Fished
-- ZoneID: 123 - Bloodsucker Fished
-- ZoneID: 159 - Bloodsucker Fished
-- ZoneID: 159 - Uggalepih Leech
-- ZoneID: 160 - Bloodsucker Fished
-- ZoneID: 167 - Bloodsucker
-- ZoneID: 167 - Bloodsucker Fished
-- ZoneID: 176 - Sahagin Parasite
-- ZoneID: 212 - Labyrinth Leech

-- ZoneID: 216 - Asanbosam -- TODO: Abyssea NM

-- ZoneID: 134 - Moltenox Stubthumbs
-- ZoneID: 134 - Droprix Granitepalms
-- ZoneID: 134 - Brewnix Bittypupils
-- ZoneID: 134 - Ascetox Ratgums
-- ZoneID: 134 - Gibberox Pimplebeak
-- ZoneID: 134 - Swypestix Tigershins
-- ZoneID: 134 - Bordox Kittyback
-- ZoneID: 134 - Ruffbix Jumbolobes
-- ZoneID: 134 - Draklix Scalecrust
-- ZoneID: 134 - Tocktix Thinlids
-- ZoneID: 134 - Routsix Rubbertendon
-- ZoneID: 134 - Morblox Chubbychin
-- ZoneID: 134 - Whistrix Toadthroat
-- ZoneID: 134 - Slinkix Trufflesniff
-- ZoneID: 134 - Shisox Widebrow

-- ZoneID:  85 - Ashmaker Gotblut

-- ZoneID: 142 - Ashmaker Gotblut

-- ZoneID: 205 - Ash Dragon

-- ZoneID: 205 - Ash Lizard

-- ZoneID:  77 - Asphyxiated Amsel
-- ZoneID:  77 - Crushed Krause
-- ZoneID:  77 - Burned Bergmann
-- ZoneID:  77 - Pulverized Pfeffer
-- ZoneID:  77 - Smothered Schmidt
-- ZoneID:  77 - Wounded Wurfel
INSERT INTO `mob_droplist` VALUES (181,0,0,1000,825,@COMMON); -- Square Of Cotton Cloth (Common, 15%)
INSERT INTO `mob_droplist` VALUES (181,0,0,1000,940,@RARE);   -- Revival Tree Root (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (181,0,0,1000,529,@VRARE);  -- Luminicloth (Very Rare, 1%)

-- ZoneID: 196 - Asphyxiated Amsel

-- ZoneID: 128 - Aspidochelone

-- ZoneID: 254 - Assailer Chariot -- TODO: Abyssea NM

-- ZoneID:  99 - Asterion

-- ZoneID: 216 - Athamas -- TODO: Abyssea NM

-- ZoneID:  24 - Atomic Cluster
-- ZoneID:  25 - Atomic Cluster

-- ZoneID:  30 - Atomic Cluster

-- ZoneID: 216 - Atrociraptor

-- ZoneID:   7 - Attohwa Coeurl

-- ZoneID: 253 - Audumbla -- TODO: Abyssea NM

-- ZoneID: 111 - Living Statue
-- ZoneID: 157 - Jagd Doll
-- ZoneID: 158 - Demonic Doll
-- ZoneID: 159 - Branding Iron
-- ZoneID: 177 - Caretaker
-- ZoneID: 178 - Aura Butler
-- ZoneID: 178 - Aura Gear
-- ZoneID: 184 - Chaos Idol
-- ZoneID: 204 - Drone
-- ZoneID: 204 - Talos

-- ZoneID: 178 - Aura Pot

-- ZoneID: 216 - Avalerion -- TODO: Abyssea NM

-- ZoneID: 187 - Avatar Icon
-- ZoneID: 187 - Avatar Icon

-- ZoneID: 253 - Awahondo -- TODO: Abyssea NM

-- ZoneID: 197 - Awd Goggie

-- ZoneID:  35 - Awaern Mnk
-- ZoneID:  35 - Awaern Blm
-- ZoneID:  35 - Awaern Thf
-- ZoneID:  35 - Awaern Rdm
-- ZoneID:  35 - Awaern Sam
-- ZoneID:  35 - Awaern Rng
-- ZoneID:  35 - Awaern Nin
-- ZoneID:  35 - Awaern Drg
-- ZoneID:  35 - Awaern Whm
-- ZoneID:  35 - Awaern Brd
-- ZoneID:  35 - Awaern Bst
-- ZoneID:  35 - Awaern War
-- ZoneID:  35 - Awaern Smn
-- ZoneID:  35 - Awaern Drk
-- ZoneID:  35 - Awaern Pld

-- ZoneID:  33 - Aweuvhi
-- ZoneID:  35 - Aweuvhi

-- ZoneID:  35 - Awghrah

-- ZoneID:  77 - Pelican
-- ZoneID:  97 - Axe Beak
-- ZoneID: 119 - Axe Beak
-- ZoneID: 174 - Greater Cockatrice
INSERT INTO `mob_droplist` VALUES (201,0,0,1000,4435,@COMMON);  -- Slice Of Cockatrice Meat (Common, 15%)
INSERT INTO `mob_droplist` VALUES (201,0,0,1000,842,@UNCOMMON); -- Giant Bird Feather (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (201,0,0,1000,854,@VRARE);    -- Cockatrice Skin (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (201,2,0,1000,842,0);         -- Giant Bird Feather (Steal)
INSERT INTO `mob_droplist` VALUES (201,4,0,1000,842,0);         -- Giant Bird Feather (Despoil)

-- 202 Available

-- ZoneID:  24 - Grindylow
-- ZoneID:  25 - Grindylow
-- ZoneID:  65 - Mamook Crab
-- ZoneID:  68 - Aydeewa Crab

-- ZoneID:  68 - Aydeewa Diremite

-- ZoneID: 217 - Ayravata -- TODO: Abyssea NM

-- ZoneID: 254 - Azdaja

-- ZoneID:  82 - Screamer
-- ZoneID:  84 - Ba
-- ZoneID:  88 - Vulture
-- ZoneID:  97 - Condor
-- ZoneID: 105 - Ba
-- ZoneID: 106 - Vulture
-- ZoneID: 107 - Vulture

-- ZoneID:   4 - Raven
-- ZoneID:   4 - Toucan
-- ZoneID:   4 - Tragopan
-- ZoneID:  97 - Mountain Jubjub
-- ZoneID:  97 - Jubjub

-- ZoneID:  40 - Baa Dava The Bibliophage

-- ZoneID: 132 - Baba Yaga -- TODO: Abyssea NM

-- ZoneID: 218 - Badlands Crab

-- ZoneID:  92 - Baetyl Quadav

-- ZoneID:  15 - Bakka -- TODO: Abyssea NM

-- ZoneID:  98 - Balam-Quitz

-- ZoneID:  15 - Balaur -- TODO: Abyssea NM

-- ZoneID:   2 - Glide Bomb
-- ZoneID: 100 - Bomb
-- ZoneID: 101 - Bomb
-- ZoneID: 106 - Shrapnel
-- ZoneID: 107 - Shrapnel
-- ZoneID: 115 - Balloon
-- ZoneID: 116 - Balloon
-- ZoneID: 122 - Cannonball

-- ZoneID: 192 - Balloon

-- ZoneID:  28 - Balor
-- ZoneID:  28 - Caithleann
-- ZoneID:  28 - Indich
-- ZoneID:  28 - Lobais
-- ZoneID:  28 - Luaith

-- ZoneID: 196 - Bandersnatch

-- ZoneID: 194 - Balloon

-- ZoneID:   7 - Chasm Lizard
-- ZoneID:   7 - Bane Lizard
-- ZoneID:  89 - War Lizard
-- ZoneID:  96 - War Lizard
-- ZoneID: 171 - Labyrinth Lizard
-- ZoneID: 212 - Labyrinth Lizard

-- ZoneID: 126 - Banshee
-- ZoneID: 157 - Banshee

-- 223 Available

-- ZoneID: 196 - Banshee

-- ZoneID: 212 - Baobhan Sith

-- ZoneID:  77 - Garm
-- ZoneID:  97 - Scavenging Hound
-- ZoneID:  98 - Scavenging Hound
-- ZoneID: 100 - Tainted Hound
-- ZoneID: 101 - Tainted Hound
-- ZoneID: 102 - Wolf Zombie
-- ZoneID: 104 - Scavenging Hound
-- ZoneID: 105 - Mauthe Doog
-- ZoneID: 108 - Wolf Zombie
-- ZoneID: 115 - Mad Fox
-- ZoneID: 116 - Mad Fox
-- ZoneID: 117 - Barghest
-- ZoneID: 119 - Scavenging Hound
-- ZoneID: 121 - Hell Hound
-- ZoneID: 175 - Hell Hound
-- ZoneID: 195 - Hell Hound
-- ZoneID: 195 - Marchosias
INSERT INTO `mob_droplist` VALUES (226,0,0,1000,858,@UNCOMMON); -- Wolf Hide (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (226,0,0,1000,940,@RARE);     -- Revival Tree Root (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (226,4,0,1000,858,0);         -- Wolf Hide (Despoil)
INSERT INTO `mob_droplist` VALUES (226,4,0,1000,940,0);         -- Revival Tree Root (Despoil)

-- ZoneID: 153 - Bark Spider

-- ZoneID:  77 - Spinner
-- ZoneID: 153 - Bark Tarantula
-- ZoneID: 154 - Bark Tarantula
-- ZoneID: 208 - Sand Tarantula
INSERT INTO `mob_droplist` VALUES (228,0,0,1000,838,@UNCOMMON); -- Spider Web (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (228,2,0,1000,838,0);         -- Spider Web (Steal)
INSERT INTO `mob_droplist` VALUES (228,4,0,1000,821,0);         -- Spool Of Rainbow Thread (Despoil)
INSERT INTO `mob_droplist` VALUES (228,4,0,1000,838,0);         -- Spider Web (Despoil)

-- ZoneID: 162 - Baronet Romwe

-- ZoneID:  40 - Barong

-- ZoneID: 135 - Baron Avnas

-- ZoneID: 162 - Baron Vapula

-- ZoneID: 218 - Barrens Treant

-- ZoneID:   5 - Esbat
-- ZoneID:   5 - Succubus Bats
-- ZoneID:   5 - Nightmare Bats
-- ZoneID:  11 - Dark Bats
-- ZoneID:  11 - Stirge
-- ZoneID:  12 - Dire Bat
-- ZoneID:  12 - Succubus Bats
-- ZoneID:  27 - Canal Bats
-- ZoneID:  27 - Hell Bat
-- ZoneID:  27 - Vampire Bat
-- ZoneID:  28 - Greater Gaylas
-- ZoneID:  52 - Incubus Bats
-- ZoneID:  54 - Naraka Bat
-- ZoneID:  54 - Purgatory Bat
-- ZoneID:  62 - Purgatory Bat
-- ZoneID:  62 - Volcanic Bats
-- ZoneID:  83 - Dire Bat
-- ZoneID:  89 - Wingrats
-- ZoneID:  90 - Night Bats
-- ZoneID:  98 - Moon Bat
-- ZoneID:  99 - Bastion Bats
-- ZoneID: 158 - Dire Bat
-- ZoneID: 158 - Incubus Bats
-- ZoneID: 164 - Dire Bat
-- ZoneID: 164 - Incubus Bats
-- ZoneID: 167 - Funnel Bats
-- ZoneID: 167 - Werebat
-- ZoneID: 176 - Dire Bat
-- ZoneID: 204 - Vampire Bat
-- ZoneID: 212 - Greater Gaylas
-- ZoneID: 212 - Hell Bat

-- ZoneID: 132 - Bathyal Gigas

-- ZoneID: 102 - Battering Ram

-- ZoneID: 185 - Voidstreaker Butchnotch
-- ZoneID: 185 - Reapertongue Gadgquok
-- ZoneID: 185 - Wyrmgnasher Bjakdek

-- ZoneID:  73 - Battleclad Chariot
INSERT INTO `mob_droplist` VALUES (238,1,1,@ALWAYS,14556,166);   -- Tsukikazu Togi (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,1,@ALWAYS,15627,166);   -- Phoboss Cuisses (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,1,@ALWAYS,14967,166);   -- Freyrs Gloves (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,1,@ALWAYS,16094,166);   -- Tsukikazu Jinpachi (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,1,@ALWAYS,15725,166);   -- Eas Crackows (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,1,@ALWAYS,15643,166);   -- Bodbs Slops (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,2,@ALWAYS,14556,166);   -- Tsukikazu Togi (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,2,@ALWAYS,15627,166);   -- Phoboss Cuisses (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,2,@ALWAYS,14967,166);   -- Freyrs Gloves (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,2,@ALWAYS,16094,166);   -- Tsukikazu Jinpachi (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,2,@ALWAYS,15725,166);   -- Eas Crackows (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,1,2,@ALWAYS,15643,166);   -- Bodbs Slops (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (238,0,0,1000,5736,@UNCOMMON); -- Linen Coin Purse (Uncommon, 10%)

-- ZoneID: 192 - Battle Bat

-- ZoneID: 218 - Battlerigged Chariot -- TODO: Abyssea NM

-- ZoneID: 194 - Stink Bats

-- ZoneID:  65 - Battle Bugard
-- ZoneID:  77 - Bull Bugard
INSERT INTO `mob_droplist` VALUES (242,0,0,1000,1640,@COMMON); -- Bugard Skin (Common, 15%)
INSERT INTO `mob_droplist` VALUES (242,0,0,1000,1622,@VRARE);  -- Bugard Tusk (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (242,0,0,1000,1680,@RARE);   -- High-Quality Bugard Skin (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (242,4,0,1000,1640,0);       -- Bugard Skin (Despoil)
INSERT INTO `mob_droplist` VALUES (242,4,0,1000,1622,0);       -- Bugard Tusk (Despoil)

-- ZoneID:  77 - Orctrap
-- ZoneID:  81 - Battrap
-- ZoneID:  82 - Hawkertrap
INSERT INTO `mob_droplist` VALUES (243,0,0,1000,1617,@UNCOMMON); -- Flytrap Leaf (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (243,4,0,1000,1617,0);         -- Flytrap Leaf (Despoil)

-- ZoneID: 192 - Battue Bats
-- ZoneID: 192 - Troika Bats
-- ZoneID: 194 - Battue Bats

-- ZoneID: 111 - Bat Eye

-- ZoneID: 166 - Bat Eye

-- ZoneID: 113 - Beach Bunny

-- ZoneID:   3 - Fatty Pugil
-- ZoneID:   4 - Jagil
-- ZoneID:  81 - Pugil
-- ZoneID: 103 - Beach Pugil Fished
-- ZoneID: 103 - Beach Pugil
-- ZoneID: 118 - Shoal Pugil Fished
-- ZoneID: 118 - Shoal Pugil
-- ZoneID: 126 - Greater Pugil

-- ZoneID:   2 - Beady Beetle

-- ZoneID: 135 - Marquis Caim

-- ZoneID: 127 - Behemoth

-- ZoneID:  45 - Beholder

-- ZoneID: 108 - Haty
-- ZoneID: 108 - Bendigeit Vran

-- ZoneID: 218 - Bennu -- TODO: Abyssea NM

-- ZoneID:  51 - Berried Chigoe
-- ZoneID:  52 - Berried Chigoe

-- ZoneID:  77 - Spiny Spipi
-- ZoneID:  91 - Berry Grub
-- ZoneID:  91 - Worker Crawler
-- ZoneID:  95 - Crawler
-- ZoneID: 109 - Carnivorous Crawler
-- ZoneID: 110 - Berry Grub
-- ZoneID: 118 - Carnivorous Crawler
-- ZoneID: 117 - Canyon Crawler
-- ZoneID: 147 - Caterpillar
-- ZoneID: 147 - Larva
-- ZoneID: 197 - Soldier Crawler
-- ZoneID: 197 - Worker Crawler
INSERT INTO `mob_droplist` VALUES (256,0,0,1000,816,@UNCOMMON); -- Spool Of Silk Thread (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (256,4,0,1000,839,0);         -- Piece Of Crawler Cocoon (Despoil)
INSERT INTO `mob_droplist` VALUES (256,4,0,1000,4357,0);        -- Crawler Egg (Despoil)

-- 257 Available

-- ZoneID: 137 - Berserker Demon
-- ZoneID: 138 - Deathwreaker Demon
-- ZoneID: 138 - Foredoomer Demon
-- ZoneID: 138 - Woebringer Demon
-- ZoneID: 155 - Berserker Demon

-- ZoneID: 215 - Berstuk -- TODO: Abyssea NM

-- ZoneID: 159 - Beryl-Footed Molberry

-- ZoneID: 134 - Gunha Wallstormer
-- ZoneID: 134 - Nahya Floodmaker
-- ZoneID: 134 - Jifhu Infiltrator
-- ZoneID: 134 - Gafho Venomtouch
-- ZoneID: 134 - Tahyu Gallanthunter
-- ZoneID: 134 - Nubhi Spiraleye
-- ZoneID: 134 - Debho Pyrohand
-- ZoneID: 134 - Gotyo Magenapper
-- ZoneID: 134 - Sozho Metalbender
-- ZoneID: 134 - Mugha Legionkiller
-- ZoneID: 134 - Sogho Adderhandler
-- ZoneID: 134 - Gukhu Dukesniper
-- ZoneID: 134 - Jikhu Towercleaver
-- ZoneID: 134 - Mirhe Whisperblade
-- ZoneID: 134 - Bezhe Keeprazer

-- ZoneID:  54 - Bhoot

-- ZoneID:  77 - Bhoot
INSERT INTO `mob_droplist` VALUES (263,0,0,1000,940,@UNCOMMON); -- Revival Tree Root (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (263,0,0,1000,2274,@COMMON);  -- Square Of Mohbwa Cloth (Common, 15%)
INSERT INTO `mob_droplist` VALUES (263,4,0,1000,825,0);         -- Square Of Cotton Cloth (Despoil)

-- ZoneID:  83 - Haunt
-- ZoneID: 110 - Evil Spirit
-- ZoneID: 111 - Lugat
-- ZoneID: 112 - Etemmu
-- ZoneID: 120 - Evil Spirit
-- ZoneID: 127 - Bhuta
-- ZoneID: 200 - Bhuta

-- ZoneID: 134 - Foo Peku The Bloodcloak
-- ZoneID: 134 - Xaa Chau The Roctalon
-- ZoneID: 134 - Koo Saxu The Everfast
-- ZoneID: 134 - Bhuu Wjato The Firepool
-- ZoneID: 134 - Caa Xaza The Madpiercer
-- ZoneID: 134 - Maa Zaua The Wyrmkeeper
-- ZoneID: 134 - Ryy Qihi The Idolrobber
-- ZoneID: 134 - Guu Waji The Preacher
-- ZoneID: 134 - Nee Huxa The Judgmental
-- ZoneID: 134 - Kuu Xuka The Nimble
-- ZoneID: 134 - Soo Jopo The Fiendking
-- ZoneID: 134 - Xhoo Fuza The Sublime
-- ZoneID: 134 - Hee Mida The Meticulous
-- ZoneID: 134 - Knii Hoqo The Bisector
-- ZoneID: 134 - Puu Timu The Phantasmal

-- ZoneID: 112 - Biast

-- ZoneID:  82 - Biddybug

-- ZoneID:   4 - Ignis Fatuus
-- ZoneID:   7 - Bifrons
-- ZoneID:   7 - Will-O-The-Wykes

-- ZoneID:  75 - Archaic Gear
INSERT INTO `mob_droplist` VALUES (269,0,0,1000,2377,@URARE);  -- Bhaflau Card (Ultra Rare, 0.1%)
INSERT INTO `mob_droplist` VALUES (269,0,0,1000,2488,@COMMON); -- Piece Of Alexandrite (Common, 15%)
INSERT INTO `mob_droplist` VALUES (269,0,0,1000,2488,@SRARE);  -- Piece Of Alexandrite (Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (269,1,1,@RARE,5374,333);    -- Opacus Cell (Group 1, Rare, 5%)
INSERT INTO `mob_droplist` VALUES (269,1,1,@RARE,5375,333);    -- Praecipitatio Cell (Group 1, Rare, 5%)
INSERT INTO `mob_droplist` VALUES (269,1,1,@RARE,5382,333);    -- Mediocris Cell (Group 1, Rare, 5%)
INSERT INTO `mob_droplist` VALUES (269,1,2,@SRARE,16097,200);  -- Anu's Tiara (Group 2, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (269,1,2,@SRARE,15712,200);  -- Enyo's Leggings (Group 2, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (269,1,2,@SRARE,14970,200);  -- Hoshikazu Tekko (Group 2, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (269,1,2,@SRARE,15728,200);  -- Nemain's Sabots (Group 2, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (269,1,2,@SRARE,15630,200);  -- Njord's Trousers (Group 2, Super Rare, 0.5%)

-- ZoneID: 160 - Bifrons

-- ZoneID:  25 - Bigclaw
-- ZoneID:  65 - Nipper

-- ZoneID:  58 - Bigclaw
-- ZoneID:  59 - Bigclaw

-- ZoneID: 113 - Rock Crab Fished
-- ZoneID: 114 - Bigclaw Fished
-- ZoneID: 121 - Bigclaw Fished
-- ZoneID: 160 - Rock Crab Fished
-- ZoneID: 169 - Rock Crab Fished

-- ZoneID: 169 - Bigclaw Fished
-- ZoneID: 169 - Bigclaw

-- ZoneID: 176 - Bigclaw Fished
-- ZoneID: 176 - Bigclaw

-- ZoneID: 101 - Bigmouth Billy

-- ZoneID:  62 - Big Bomb

-- ZoneID:  25 - Makara
-- ZoneID:  27 - Big Jaw Noaggro
-- ZoneID:  27 - Makara

-- ZoneID:   1 - Aipaloovik
-- ZoneID:   2 - Spinous Pugil
-- ZoneID:  46 - Gugru Jagil
-- ZoneID:  46 - Ocean Jagil
-- ZoneID:  47 - Gugru Jagil
-- ZoneID:  47 - Ocean Jagil
-- ZoneID:  58 - Thalassic Pugil
-- ZoneID:  58 - Cyan Deep Pugil
-- ZoneID:  59 - Thalassic Pugil
-- ZoneID:  59 - Cyan Deep Pugil
-- ZoneID:  61 - Sulphuric Jagil
-- ZoneID:  81 - Fighting Pugil
-- ZoneID:  84 - Greater Pugil Fished
-- ZoneID:  85 - Greater Pugil Fished
-- ZoneID:  88 - Fighting Pugil
-- ZoneID:  89 - Fighting Pugil
-- ZoneID:  91 - Greater Pugil Fished
-- ZoneID:  95 - Fighting Pugil
-- ZoneID: 101 - Fighting Pugil
-- ZoneID: 101 - Pugil
-- ZoneID: 101 - Pugil Fished
-- ZoneID: 105 - Land Pugil Fished
-- ZoneID: 106 - Fighting Pugil
-- ZoneID: 106 - Sand Pugil
-- ZoneID: 109 - Land Pugil
-- ZoneID: 113 - Terror Pugil
-- ZoneID: 116 - Fighting Pugil
-- ZoneID: 123 - Makara
-- ZoneID: 124 - Big Jaw
-- ZoneID: 140 - Pugil Fished
-- ZoneID: 145 - Pugil Fished
-- ZoneID: 147 - Big Jaw
-- ZoneID: 160 - Demonic Pugil
-- ZoneID: 169 - Makara
-- ZoneID: 173 - Greater Pugil
-- ZoneID: 173 - Greater Pugil Fished
-- ZoneID: 212 - Makara
-- ZoneID: 218 - Sand Pugil

-- ZoneID: 124 - Bisque-Heeled Sunberry

-- ZoneID: 160 - Bistre-Hearted Malberry

-- ZoneID: 227 - Blackbeard

-- ZoneID:   2 - Orcish Fighter
-- ZoneID:   2 - Orcish Cursemaker
-- ZoneID:   2 - Orcish Serjeant
-- ZoneID:  24 - Orcish Impaler
-- ZoneID:  24 - Splinterspine Grukjuk
-- ZoneID:  24 - Blackbone Frazdiz
-- ZoneID:  25 - Orcish Footsoldier
-- ZoneID: 105 - Orcish Fighter
-- ZoneID: 105 - Orcish Cursemaker
-- ZoneID: 105 - Orcish Serjeant

-- ZoneID:   5 - Black Coney
-- ZoneID:   5 - White Coney

-- ZoneID: 132 - Black Merino

-- ZoneID: 110 - Black Triple Stars

-- ZoneID:  88 - Black Wolf
-- ZoneID:  89 - Black Wolf
-- ZoneID:  95 - Mad Fox
-- ZoneID: 107 - Black Wolf

-- ZoneID: 106 - Black Wolf

-- ZoneID: 217 - Blademaw Pugil

-- ZoneID:  46 - Blanched Kraken
-- ZoneID:  46 - Ocean Kraken
-- ZoneID:  47 - Blanched Kraken
-- ZoneID:  47 - Ocean Kraken
-- ZoneID:  54 - Nostokulshedra
-- ZoneID:  58 - Kulshedra
-- ZoneID:  59 - Kulshedra
-- ZoneID:  77 - Kulshedra
INSERT INTO `mob_droplist` VALUES (290,0,0,1000,888,@ALWAYS); -- Seashell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (290,0,0,1000,4484,@RARE);  -- Shall Shell (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (290,4,0,1000,888,0);       -- Seashell (Despoil)

-- ZoneID: 253 - Blanga -- TODO: Abyssea NM

-- ZoneID: 197 - Blazer Beetle

-- ZoneID: 215 - Blazing Eruca -- TODO: Abyssea NM

-- ZoneID:  92 - Blifnix Oilycheeks

-- ZoneID: 196 - Blind Moby

-- ZoneID: 112 - Blizzard Gigas
-- ZoneID: 112 - Frost Gigas
-- ZoneID: 112 - Graupel Gigas
-- ZoneID: 112 - Hail Gigas

-- ZoneID: 192 - Blob
-- ZoneID: 194 - Rotten Jam

-- ZoneID:  15 - Bloodeye Vileberry -- TODO: Abyssea NM

-- ZoneID:  15 - Bloodguzzler -- TODO: Abyssea NM

-- ZoneID:  97 - Bloodlapper

-- ZoneID: 109 - Bloodpool Vorax

-- 302 Available

-- ZoneID:  77 - Bloodtear Baldurf
-- ZoneID:  77 - Steelfleece Baldarich
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,859,@ALWAYS);  -- Ram Skin (Always, 100%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,895,@VCOMMON); -- Ram Horn (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,859,@VCOMMON); -- Ram Skin (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,895,@VCOMMON); -- Ram Horn (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,859,@VCOMMON); -- Ram Skin (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,859,@VCOMMON); -- Ram Skin (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,859,@COMMON);  -- Ram Skin (Common, 15%)
INSERT INTO `mob_droplist` VALUES (303,0,0,1000,859,@COMMON);  -- Ram Skin (Common, 15%)

-- ZoneID: 102 - Bloodtear Baldurf

-- ZoneID: 174 - Bloodthirster Madkix

-- ZoneID:  54 - Bloody Bones

-- ZoneID: 100 - Marauder Dvogzog
-- ZoneID: 140 - Fodderchief Vokdek
-- ZoneID: 140 - Warchief Vatgit
-- ZoneID: 140 - Fogweaver Mozzfuzz
-- ZoneID: 140 - Bloody Vrukwuk
-- ZoneID: 149 - Gavotvut
-- ZoneID: 149 - Three-Eyed Prozpuz

-- ZoneID:  45 - Blood Bat

-- ZoneID:   4 - Island Rarab
-- ZoneID:   4 - Locus Bight Rarab
-- ZoneID: 143 - Pit Hare
-- ZoneID: 143 - Rabid Rat
-- ZoneID: 191 - Hoarder Hare
-- ZoneID: 193 - Blood Bunny

-- ZoneID: 161 - Blood Demon

-- ZoneID:  89 - Blood Soul

-- ZoneID: 195 - Blood Soul

-- ZoneID:  96 - Jumbo Rafflesia
-- ZoneID:  97 - Jumbo Rafflesia

-- ZoneID:   9 - Blubber Eyes

-- ZoneID:   5 - Mindgazer
-- ZoneID:   9 - Gazer
-- ZoneID:   9 - Million Eyes
-- ZoneID:  28 - Blubber Eyes
-- ZoneID:  77 - Taisaijin
-- ZoneID:  77 - Thousand Eyes
INSERT INTO `mob_droplist` VALUES (315,0,0,1000,939,@RARE);   -- Hecteyes Eye (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (315,0,0,1000,914,@COMMON); -- Vial Of Mercury (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (315,4,0,1000,939,0);       -- Hecteyes Eye (Despoil)

-- ZoneID: 176 - Blubber Eyes

-- ZoneID:  68 - Bluestreak Gyugyuroon

-- ZoneID: 253 - Bluffalo

-- ZoneID: 104 - Boggart
-- ZoneID: 119 - Boggart
-- ZoneID: 192 - Boggart

-- ZoneID:  90 - Bogy

-- ZoneID: 103 - Bogy

-- ZoneID: 104 - Bogy
-- ZoneID: 109 - Bogy
-- ZoneID: 118 - Bogy
-- ZoneID: 119 - Bogy

-- ZoneID: 173 - Bogy

-- ZoneID: 184 - Bogy

-- ZoneID: 196 - Bogy

-- ZoneID:   4 - Tropical Rarab
-- ZoneID:   4 - Bight Rarab
-- ZoneID:  90 - Bog Bunny
-- ZoneID:  95 - Hispid Rarab
-- ZoneID: 109 - Bog Bunny
-- ZoneID: 193 - Buds Bunny
-- ZoneID: 193 - Vorpal Bunny

-- 327 Available

-- ZoneID:  90 - Moor Hound
-- ZoneID: 109 - Bog Dog

-- ZoneID: 176 - Bog Sahagin

-- ZoneID:  15 - Bombadeel -- TODO: Abyssea NM

-- ZoneID: 254 - Bomblix Flamefinger -- TODO: Abyssea NM

-- ZoneID:  77 - Bomb King
-- ZoneID:  77 - Friar Rush
INSERT INTO `mob_droplist` VALUES (332,0,0,1000,928,@COMMON); -- Pinch Of Bomb Ash (Common, 15%)
INSERT INTO `mob_droplist` VALUES (332,0,0,1000,17316,@RARE); -- Bomb Arm (Rare, 5%)

-- ZoneID: 194 - Bomb King

-- ZoneID: 205 - Bomb Queen

-- ZoneID: 218 - Bonfire

-- ZoneID:   5 - Bonnacon

-- ZoneID:  77 - Bonnacon
INSERT INTO `mob_droplist` VALUES (337,0,0,1000,5703,@COMMON);   -- Jug Of Uleguerand Milk (Common, 15%)
INSERT INTO `mob_droplist` VALUES (337,0,0,1000,5152,@UNCOMMON); -- Slice Of Buffalo Meat (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (337,0,0,1000,1628,@RARE);     -- Buffalo Hide (Rare, 5%)

-- ZoneID: 159 - Bonze Marberry

-- ZoneID:  72 - Boompadu

-- ZoneID: 200 - Borer Beetle

-- ZoneID:  29 - Boroka

-- ZoneID: 153 - Bouncing Ball Fished

-- ZoneID: 159 - Bouncing Ball Fished
-- ZoneID: 173 - Thread Leech

-- ZoneID: 169 - Bouncing Ball

-- ZoneID: 132 - Brae Opo-Opo

-- ZoneID:  88 - Coppercap -- TODO: Implement proper steal mixin.
-- ZoneID:  89 - Brasscap
-- ZoneID:  90 - Electrumcap
-- ZoneID:  91 - Coppercap
-- ZoneID:  92 - Electrumcap
-- ZoneID: 171 - Electrumcap

-- ZoneID:  61 - Brass Borer

-- ZoneID:  89 - Old Quadav
-- ZoneID:  91 - Old Quadav
-- ZoneID: 171 - Old Quadav

-- ZoneID:  89 - Brass Quadav
-- ZoneID:  91 - Brass Quadav
-- ZoneID: 171 - Brass Quadav

-- ZoneID: 109 - Brass Quadav

-- ZoneID: 110 - Brass Quadav

-- ZoneID: 143 - Brass Quadav

-- ZoneID: 147 - Brass Quadav

-- ZoneID:  89 - Heliodor Quadav
-- ZoneID:  91 - Heliodor Quadav
-- ZoneID: 171 - Heliodor Quadav

-- ZoneID:  92 - Bres

-- ZoneID: 132 - Briareus -- TODO: Abyssea NM

-- ZoneID: 177 - Brigandish Blade

-- ZoneID: 124 - Bright-Handed Kunberry

-- ZoneID:   5 - Brontotaur
-- ZoneID:   5 - Tyrannotaur
-- ZoneID:   5 - Molech
-- ZoneID: 136 - Dryptotaur
-- ZoneID: 137 - Gorgotaur
-- ZoneID: 137 - Tarbotaur
-- ZoneID: 155 - Titanotaur

-- ZoneID:  89 - Bronze Quadav
-- ZoneID:  91 - Bronze Quadav
-- ZoneID: 171 - Bronze Quadav

-- ZoneID: 110 - Bronze Quadav
-- ZoneID: 110 - Copper Quadav
-- ZoneID: 110 - Silver Quadav
-- ZoneID: 110 - Zircon Quadav

-- ZoneID: 147 - Bronze Quadav

-- ZoneID: 147 - Broo

-- ZoneID: 132 - Brooder -- TODO: Abyssea NM

-- ZoneID: 176 - Brook Sahagin

-- ZoneID: 218 - Brulo -- TODO: Abyssea NM

-- ZoneID:  81 - Wild Sheep
-- ZoneID:  82 - Brutal Sheep
-- ZoneID:  88 - Ornery Sheep
-- ZoneID: 100 - Wild Sheep
-- ZoneID: 101 - Wild Sheep

-- ZoneID: 102 - Mad Sheep
-- ZoneID: 103 - Brutal Sheep
-- ZoneID: 104 - Brutal Sheep
-- ZoneID: 108 - Mad Sheep

-- ZoneID: 118 - Buburimboo

-- ZoneID:   5 - Buffalo

-- ZoneID:  24 - Bugard
-- ZoneID:  24 - Gigantobugard
-- ZoneID:  83 - Bugard

-- ZoneID:  25 - Bugard

-- ZoneID:  11 - Bugbear Bondman

-- ZoneID:  12 - Bugbear Deathsman
-- ZoneID:  12 - Bugbear Watchman

-- ZoneID:  12 - Bugbear Matman

-- ZoneID:  11 - Bugbear Muscleman

-- ZoneID:  11 - Bugbear Servingman

-- ZoneID:  11 - Bugbear Strongman

-- ZoneID:  12 - Bugbear Trashman

-- ZoneID: 204 - Camazotz

-- ZoneID: 218 - Bugul Noz -- TODO: Abyssea NM

-- ZoneID: 217 - Bukhis -- TODO: Abyssea NM

-- ZoneID: 160 - Bullbeggar

-- ZoneID:  73 - Bull Bugard
INSERT INTO `mob_droplist` VALUES (384,0,0,1000,5373,@ALWAYS); -- Duplicatus Cell

-- ZoneID: 118 - Bull Dhalmel

-- ZoneID:   2 - Specter Bat
-- ZoneID:  24 - Vampire Bat
-- ZoneID:  24 - Wingrats
-- ZoneID:  25 - Vampire Bat
-- ZoneID:  25 - Wingrats
-- ZoneID:  85 - Wolf Bat
-- ZoneID:  85 - Wood Bats
-- ZoneID:  99 - Bulwark Bat
-- ZoneID: 121 - Ancient Bat
-- ZoneID: 151 - Bulwark Bat
-- ZoneID: 157 - Big Bat
-- ZoneID: 160 - Dire Bat
-- ZoneID: 169 - Hell Bat
-- ZoneID: 173 - Combat
-- ZoneID: 176 - Undead Bats
-- ZoneID: 190 - Mouse Bat
-- ZoneID: 204 - Vampire Bat

-- ZoneID:  95 - Bumblebee

-- ZoneID: 115 - Bumblebee
-- ZoneID: 116 - Bumblebee

-- ZoneID: 212 - Bune

-- ZoneID:  77 - Black Pudding
-- ZoneID:  77 - Ebony Pudding
-- ZoneID:  77 - Caramel Custard
-- ZoneID:  77 - Cardamon Custard
-- ZoneID:  77 - Groaty Custard
-- ZoneID:  92 - Pitchy Pudding
INSERT INTO `mob_droplist` VALUES (390,0,0,1000,2175,@COMMON); -- Chunk Of Flan Meat (Common, 15%)

-- ZoneID: 196 - Burned Bergmann

-- ZoneID:   7 - Burrow Antlion

-- ZoneID: 254 - Burstrox Powderpate -- TODO: Abyssea NM

-- ZoneID: 130 - Byakko

-- ZoneID: 114 - Cactrot Rapido

-- ZoneID: 114 - Sabotender
-- ZoneID: 125 - Cactuar

-- ZoneID:  77 - Cactuar Cantautor
-- ZoneID:  77 - Sabotender Bailarin
-- ZoneID:  77 - Sabotender Mariachi
INSERT INTO `mob_droplist` VALUES (397,0,0,1000,4509,@VCOMMON); -- Flask Of Distilled Water (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (397,0,0,1000,916,@UNCOMMON); -- Cactuar Needle (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (397,0,0,1000,1236,@RARE);    -- Bag Of Cactus Stems (Rare, 5%)

-- ZoneID: 125 - Cactuar Cantautor

-- ZoneID: 173 - Seeker Bats

-- ZoneID:   9 - Camazotz

-- ZoneID: 166 - Stirge

-- ZoneID: 218 - Camelopardalis

-- ZoneID: 174 - Cancer

-- ZoneID: 132 - Cankercap

-- 405 Available

-- ZoneID:  45 - Canyon Eft

-- ZoneID: 117 - Canyon Rarab

-- ZoneID:  45 - Canyon Scorpion

-- ZoneID:  45 - Caoineag

-- ZoneID:  77 - Capricious Cassie
-- ZoneID:  77 - Drooling Daisy
INSERT INTO `mob_droplist` VALUES (410,0,0,1000,920,@COMMON); -- Malboro Vine (Common, 15%)
INSERT INTO `mob_droplist` VALUES (410,0,0,1000,920,@COMMON); -- Malboro Vine (Common, 15%)

-- ZoneID: 204 - Capricious Cassie

-- ZoneID: 132 - Carabosse -- TODO: Abyssea NM

-- ZoneID:  99 - War Lynx
-- ZoneID: 137 - Caracal

-- 414-415 Available

-- ZoneID: 173 - Cargo Crab Colin

-- ZoneID: 160 - Carmine-Tailed Janberry

-- ZoneID:  30 - Carmine Dobsonfly

-- ZoneID:  51 - Carmine Eruca
-- ZoneID:  52 - Date Eruca
-- ZoneID:  61 - Magmatic Eruca
-- ZoneID:  61 - Scoriaceous Eruca
-- ZoneID:  62 - Magmatic Eruca
-- ZoneID:  77 - Carmine Eruca
INSERT INTO `mob_droplist` VALUES (419,0,0,1000,839,@UNCOMMON); -- Piece Of Crawler Cocoon (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (419,0,0,1000,816,@RARE);     -- Spool Of Silk Thread (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (419,0,0,1000,4357,@COMMON);  -- Crawler Egg (Common, 15%)
INSERT INTO `mob_droplist` VALUES (419,4,0,1000,839,0);         -- Piece Of Crawler Cocoon (Despoil)
INSERT INTO `mob_droplist` VALUES (419,4,0,1000,4357,0);        -- Crawler Egg (Despoil)

-- ZoneID:  75 - Common Bhafalu Remnants Drops
INSERT INTO `mob_droplist` VALUES (420,1,1,@SRARE,14970,200); -- Hoshikazu Tekko (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (420,1,1,@SRARE,15712,200); -- Enyo's Leggings (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (420,1,1,@SRARE,15728,200); -- Nemain's Sabots (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (420,1,1,@SRARE,15630,200); -- Njord's Trousers (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (420,1,1,@SRARE,16097,200); -- Anu's Tiara (Group 1, Super Rare, 0.5%)

-- ZoneID: 107 - Carnero

-- ZoneID: 198 - Crypterpillar

-- ZoneID: 198 - Carnivorous Crawler

-- ZoneID:  65 - Carriage Lizard
-- ZoneID: 160 - Tormentor

-- ZoneID:  95 - Carrion Crow
-- ZoneID:  96 - Carrion Crow

-- 426-427 Available

-- ZoneID:  68 - Mold Eater
-- ZoneID:  68 - Slime Eater
-- ZoneID:  81 - Carrion Worm
-- ZoneID:  88 - Rock Eater
-- ZoneID:  88 - Stone Eater
-- ZoneID:  88 - Tunnel Worm
-- ZoneID:  89 - Rock Eater
-- ZoneID: 100 - Carrion Worm
-- ZoneID: 101 - Carrion Worm
-- ZoneID: 102 - Rock Eater
-- ZoneID: 106 - Stone Eater
-- ZoneID: 107 - Stone Eater
-- ZoneID: 108 - Rock Eater
-- ZoneID: 126 - Land Worm
-- ZoneID: 145 - Dirt Eater
-- ZoneID: 145 - Earth Eater
-- ZoneID: 190 - Carrion Worm
-- ZoneID: 190 - Locus Tomb Worm
-- ZoneID: 196 - Ore Eater
-- ZoneID: 196 - Rockmill
-- ZoneID: 198 - Maze Maker

-- ZoneID:  81 - Colibri

-- ZoneID: 198 - Caterchipillar

-- 431 Available

-- ZoneID:   4 - Catoblepas
-- ZoneID:   4 - Locus Camelopard

-- ZoneID: 197 - Caveberry

-- ZoneID:   7 - Cave Antlion
-- ZoneID:   7 - Trench Antlion

-- ZoneID: 143 - Cave Funguar

-- ZoneID: 166 - Cave Scorpion

-- ZoneID:  68 - Cave Tiger
-- ZoneID:  77 - Wajaom Tiger
INSERT INTO `mob_droplist` VALUES (437,0,0,1000,884,@COMMON);   -- Black Tiger Fang (Common, 15%)
INSERT INTO `mob_droplist` VALUES (437,0,0,1000,861,@UNCOMMON); -- Black Tiger Hide (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (437,4,0,1000,884,0);         -- Black Tiger Fang (Despoil)
INSERT INTO `mob_droplist` VALUES (437,4,0,1000,861,0);         -- Black Tiger Hide (Despoil)

-- ZoneID: 114 - Flesh Eater
-- ZoneID: 125 - Desert Worm
-- ZoneID: 160 - Cave Worm
-- ZoneID: 173 - Land Worm

-- ZoneID: 174 - Cave Worm

-- ZoneID: 160 - Celeste-Eyed Tozberry

-- ZoneID: 125 - Celphie

-- ZoneID: 190 - Cemetery Cherry

-- ZoneID: 208 - Centurio X-I

-- ZoneID: 114 - Centurio Xii-I

-- ZoneID: 216 - Cep-Kamuy -- TODO: Abyssea NM

-- ZoneID:  61 - Cerberus

-- ZoneID:  16 - Cerebrator

-- ZoneID: 200 - Chamber Beetle

-- ZoneID: 120 - Champaign Coeurl

-- ZoneID:  65 - Chamrosh

-- ZoneID: 200 - Chandelier

-- ZoneID: 112 - Chaos Elemental

-- ZoneID: 193 - Clipper

-- ZoneID: 147 - Charging Sheep

-- ZoneID: 141 - Chariotbuster Byakzak

-- ZoneID: 176 - Charybdis

-- ZoneID: 132 - Chasmic Hornet -- TODO: Abyssea NM

-- ZoneID: 215 - Chasm Coeurl

-- ZoneID:  92 - Chatoyant Quadav

-- ZoneID:  72 - Cheese Hoarder Gigiroon

-- ZoneID:  88 - Fledermaus
-- ZoneID:  91 - Moon Bat
-- ZoneID:  97 - Black Bat
-- ZoneID: 103 - Star Bat
-- ZoneID: 103 - Giant Bat
-- ZoneID: 106 - Fledermaus
-- ZoneID: 107 - Fledermaus
-- ZoneID: 109 - Black Bat
-- ZoneID: 110 - Moon Bat
-- ZoneID: 119 - Black Bat
-- ZoneID: 120 - Moon Bat
-- ZoneID: 126 - Ancient Bat
-- ZoneID: 126 - Glow Bat
-- ZoneID: 140 - Cheiroptera
-- ZoneID: 142 - Stealth Bat
-- ZoneID: 149 - Wolf Bat
-- ZoneID: 166 - Bilesucker
-- ZoneID: 166 - Blade Bat
-- ZoneID: 184 - Ancient Bat
-- ZoneID: 190 - Locus Dire Bat
-- ZoneID: 192 - Blade Bat
-- ZoneID: 193 - Ancient Bat
-- ZoneID: 194 - Blade Bat
-- ZoneID: 198 - Combat
-- ZoneID: 192 - Covin Bat
-- ZoneID: 193 - Hognosed Bat
-- ZoneID: 194 - Thorn Bat
-- ZoneID: 198 - Warren Bat
-- ZoneID: 198 - Ancient Bat
-- ZoneID: 200 - Donjon Bat

-- ZoneID: 105 - Sobbing Sapling
-- ZoneID: 190 - Cherry Sapling

-- ZoneID:   2 - Land Pugil
-- ZoneID:   2 - Fosse Pugil
-- ZoneID:  51 - Mercurial Makara
-- ZoneID:  52 - Mercurial Makara
-- ZoneID:  61 - Sicklemoon Jagil
-- ZoneID:  81 - Pug Pugil Fished
-- ZoneID:  83 - Thalassic Pugil
-- ZoneID:  83 - Abyssal Pugil
-- ZoneID:  85 - La Vaule Pugil
-- ZoneID:  88 - Pug Pugil Fished
-- ZoneID:  89 - Pug Pugil Fished
-- ZoneID:  95 - Pug Pugil Fished
-- ZoneID: 101 - Cheval Pugil
-- ZoneID: 101 - Pug Pugil Fished
-- ZoneID: 102 - Pug Pugil Fished
-- ZoneID: 104 - Land Pugil
-- ZoneID: 106 - Pug Pugil Fished
-- ZoneID: 116 - Pug Pugil Fished
-- ZoneID: 116 - Pug Pugil
-- ZoneID: 140 - Pug Pugil Fished
-- ZoneID: 141 - Pug Pugil Fished
-- ZoneID: 145 - Pug Pugil Fished
-- ZoneID: 145 - Giant Pugil
-- ZoneID: 212 - Demonic Pugil
-- ZoneID: 220 - Sea Pugil Fished
-- ZoneID: 220 - Sea Pugil
-- ZoneID: 221 - Sea Pugil Fished
-- ZoneID: 221 - Sea Pugil
-- ZoneID: 227 - Sea Pugil Fished
-- ZoneID: 227 - Sea Pugil
-- ZoneID: 228 - Sea Pugil Fished
-- ZoneID: 228 - Sea Pugil

-- ZoneID: 217 - Chhir Batti -- TODO: Abyssea NM

-- ZoneID: 218 - Chickcharney -- TODO: Abyssea NM

-- ZoneID:  51 - Chigoe
-- ZoneID:  52 - Chigoe
-- ZoneID:  68 - Fossorial Flea
-- ZoneID:  79 - Chigoe
-- ZoneID:  83 - Chigoe
-- ZoneID:  89 - Chigoe
-- ZoneID:  91 - Chigoe

-- ZoneID:  68 - Chigre

-- ZoneID: 253 - Chillwing Hwitti -- TODO: Abyssea NM

-- ZoneID: 253 - Chione -- TODO: Abyssea NM

-- ZoneID: 191 - Chocoboleech

-- ZoneID: 216 - Cirein-Croin -- TODO: Abyssea NM

-- ZoneID:  39 - Cirrate Christelle

-- ZoneID: 200 - Citadel Bats

-- ZoneID:  76 - Citadel Chelonian
INSERT INTO `mob_droplist` VALUES (474,0,0,1000,5735,@ALWAYS);  -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (474,0,0,1000,16101,@ALWAYS); -- Nemains Crown (Always, 100%)
INSERT INTO `mob_droplist` VALUES (474,0,0,1000,14557,30);      -- Hikazu Hara-Ate (3.0%)

-- ZoneID:   7 - Citipati

-- ZoneID: 217 - Clammy Imp

-- ZoneID:  61 - Claret

-- ZoneID: 120 - Climbpix Highrise

-- ZoneID:  15 - Clingy Clare -- TODO: Abyssea NM

-- ZoneID:  84 - Clipper

-- ZoneID:   1 - Thickshell Fished
-- ZoneID:   2 - Triangle Crab
-- ZoneID:  11 - Snipper Fished
-- ZoneID:  11 - Blind Crab
-- ZoneID:  81 - River Crab
-- ZoneID:  88 - River Crab
-- ZoneID:  88 - Sand Crab
-- ZoneID:  95 - Savanna Crab
-- ZoneID:  95 - Mugger Crab
-- ZoneID:  95 - River Crab
-- ZoneID: 100 - Land Crab Fished
-- ZoneID: 100 - Limicoline Crab
-- ZoneID: 100 - Passage Crab
-- ZoneID: 100 - Tree Crab
-- ZoneID: 100 - Vermivorous Crab
-- ZoneID: 102 - Coral Crab
-- ZoneID: 106 - Land Crab Fished
-- ZoneID: 106 - River Crab
-- ZoneID: 106 - Sand Crab Fished
-- ZoneID: 107 - Sand Crab
-- ZoneID: 107 - Land Crab Fished
-- ZoneID: 107 - Land Crab
-- ZoneID: 115 - Mugger Crab Fished
-- ZoneID: 115 - Palm Crab
-- ZoneID: 115 - Land Crab Fished
-- ZoneID: 115 - River Crab
-- ZoneID: 115 - Savanna Crab
-- ZoneID: 116 - Palm Crab
-- ZoneID: 116 - Savanna Crab
-- ZoneID: 118 - Clipper Fished
-- ZoneID: 136 - Angler Crab
-- ZoneID: 143 - Coral Crab
-- ZoneID: 191 - Coral Crab

-- ZoneID: 104 - Snipper
-- ZoneID: 109 - Snipper
-- ZoneID: 110 - Clipper
-- ZoneID: 118 - Snipper
-- ZoneID: 118 - Snipper Fished
-- ZoneID: 193 - Snipper

-- ZoneID:  82 - Snipper
-- ZoneID:  90 - Snipper Fished
-- ZoneID:  90 - Snipper
-- ZoneID: 173 - Clipper

-- ZoneID: 106 - Stone Crab
-- ZoneID: 107 - Stone Crab
-- ZoneID: 143 - Mine Crab

-- ZoneID: 200 - Clockwork Pod

-- ZoneID: 204 - Clockwork Pod

-- ZoneID:   3 - Clot

-- ZoneID:  29 - Strato Hippogryph
-- ZoneID:  30 - Cloud Hippogryph

-- ZoneID:  45 - Cluckatrice

-- ZoneID:  24 - Cluster

-- ZoneID: 216 - Coastal Colibri

-- ZoneID: 176 - Coastal Sahagin

-- ZoneID: 134 - Humegutter Adzjbadj
-- ZoneID: 134 - Jeunoraider Gepkzip
-- ZoneID: 134 - Cobraclaw Buchzvotch
-- ZoneID: 134 - Wraithdancer Gidbnod
-- ZoneID: 134 - Galkarider Retzpratz
-- ZoneID: 134 - Deathcaller Bidfbid
-- ZoneID: 134 - Spinalsucker Galflmall
-- ZoneID: 134 - Lockbuster Zapdjipp
-- ZoneID: 134 - Heavymail Djidzbad
-- ZoneID: 134 - Elvaanlopper Grokdok
-- ZoneID: 134 - Skinmask Ugghfogg
-- ZoneID: 134 - Taruroaster Biggsjig
-- ZoneID: 134 - Mithraslaver Debhabob
-- ZoneID: 134 - Ultrasonic Zeknajak
-- ZoneID: 134 - Drakefeast Wubmfub

-- ZoneID: 217 - Coccinelle

-- ZoneID: 213 - Cockatrice

-- ZoneID: 119 - Coeurl

-- ZoneID:  85 - Cogtooth Skagnogg

-- ZoneID:  85 - Coinbiter Cjaknokk

-- ZoneID: 111 - Cold Gigas
-- ZoneID: 111 - Rime Gigas
-- ZoneID: 111 - Sleet Gigas
-- ZoneID: 111 - Snow Gigas

-- ZoneID:  52 - Colibri
-- ZoneID:  65 - Colibri

-- ZoneID:  24 - Colorful Leshy

-- ZoneID:  51 - Colorful Treant
-- ZoneID:  52 - Colorful Treant
-- ZoneID:  79 - Elder Treant

-- ZoneID:  77 - Leshy
INSERT INTO `mob_droplist` VALUES (503,0,0,1000,923,@COMMON);   -- Dryad Root (Common, 15%)
INSERT INTO `mob_droplist` VALUES (503,0,0,1000,4448,@RARE);    -- Puffball (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (503,0,0,1000,918,@UNCOMMON); -- Sprig Of Mistletoe (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (503,1,1,@VRARE,700,300);     -- Mahogany Log (Group 1, Very Rare, 1% - 30%)
INSERT INTO `mob_droplist` VALUES (503,1,1,@VRARE,701,450);     -- Rosewood Log (Group 1, Very Rare, 1% - 45%)
INSERT INTO `mob_droplist` VALUES (503,1,1,@VRARE,702,150);     -- Ebony Log (Group 1, Very Rare, 1% - 15%)
INSERT INTO `mob_droplist` VALUES (503,1,1,@VRARE,703,100);     -- Petrified Log (Group 1, Very Rare, 1% - 10%)
INSERT INTO `mob_droplist` VALUES (503,4,0,1000,573,0);         -- Bag Of Vegetable Seeds (Despoil)
INSERT INTO `mob_droplist` VALUES (503,4,0,1000,953,0);         -- Treant Bulb (Despoil)
INSERT INTO `mob_droplist` VALUES (503,4,0,1000,2235,0);        -- Bag Of Wildgrass Seeds (Despoil)

-- ZoneID:   3 - Colossal Calamari
-- ZoneID:   3 - Kraken Fished
-- ZoneID:   4 - Kraken Fished
-- ZoneID:   4 - Kraken
-- ZoneID:   4 - Kraken
-- ZoneID: 126 - Kraken
-- ZoneID: 173 - Sea Monk
-- ZoneID: 176 - Sea Bonze

-- ZoneID: 111 - Stone Golem
-- ZoneID: 177 - Enkidu
-- ZoneID: 204 - Colossus

-- 506 Available

-- ZoneID:  72 - Cookieduster Lipiroon

-- ZoneID: 119 - Coo Keja The Unseen

-- 509 Available

-- ZoneID: 143 - Copper Beetle

-- ZoneID:  88 - Copper Quadav
-- ZoneID:  89 - Copper Quadav

-- ZoneID: 109 - Copper Quadav

-- ZoneID: 147 - Copper Quadav

-- ZoneID: 143 - Copper Quadav

-- ZoneID:  98 - Coquecigrue

-- ZoneID: 176 - Coral Sahagin

-- ZoneID:   7 - Corse

-- ZoneID: 162 - Count Bifrons

-- ZoneID: 135 - Count Raum

-- ZoneID: 135 - Count Vine

-- ZoneID: 135 - Count Zaebos

-- ZoneID:  20 - Coveter

-- 523 Available

-- ZoneID: 119 - Crane Fly

-- ZoneID: 132 - Crapaudy

-- ZoneID:  20 - Craver -- TODO: Needs to drop memory based on foe element (10%). Grouping for now instead.
-- ZoneID:  20 - Craver
-- ZoneID:  20 - Craver
-- ZoneID:  20 - Craver

-- ZoneID:  22 - Craver  -- TODO: Needs to drop memory based on foe element (10%). Grouping for now instead.
-- ZoneID:  22 - Craver
-- ZoneID:  22 - Craver
-- ZoneID:  22 - Craver

-- 528-529 Available

-- ZoneID: 115 - Crawler
-- ZoneID: 116 - Crawler

-- ZoneID: 197 - Crawler Hunter

-- ZoneID: 123 - Creek Sahagin

-- ZoneID: 132 - Crepuscule Puk

-- ZoneID: 135 - Count Haagenti

-- ZoneID: 159 - Crimson-Toothed Pawberry

-- ZoneID:  24 - Crimson Knight Crab
-- ZoneID:  25 - Crimson Knight Crab

-- ZoneID: 227 - Crossbones Blm
-- ZoneID: 227 - Crossbones War
-- ZoneID: 228 - Crossbones Blm
-- ZoneID: 228 - Crossbones War

-- ZoneID: 196 - Crushed Krause

-- ZoneID:   9 - Cryptonberry Cutter

-- ZoneID:   9 - Cryptonberry Harrier

-- ZoneID:  15 - Cryptonberry Occultist

-- ZoneID:   9 - Cryptonberry Plaguer

-- ZoneID:   9 - Cryptonberry Stalker

-- ZoneID: 190 - Crypt Ghost

-- ZoneID:  68 - Crystal Eater

-- ZoneID: 218 - Cuijatender -- TODO: Abyssea NM

-- ZoneID: 122 - Cursed Puppet

-- ZoneID: 112 - Cursed Weapon

-- ZoneID:   7 - Cutlass Scorpion
-- ZoneID:  62 - Antares
-- ZoneID: 190 - Barrow Scorpion

-- ZoneID: 160 - Cutlass Scorpion

-- 551 Available

-- ZoneID: 104 - Knight Crab
-- ZoneID: 124 - Clipper Fished
-- ZoneID: 151 - Cutter

-- ZoneID:   5 - Cwn Annwn

-- ZoneID: 195 - Dark Stalker War
-- ZoneID: 195 - Dark Stalker Blm
-- ZoneID: 195 - Dark Stalker Rng

-- ZoneID:  46 - Passage Crab
-- ZoneID:  47 - Passage Crab
-- ZoneID:  54 - Nipper
-- ZoneID:  58 - Cyan Deep Crab
-- ZoneID:  58 - Submarine Nipper
-- ZoneID:  59 - Cyan Deep Crab
-- ZoneID:  59 - Submarine Nipper

-- ZoneID:   3 - Cyclopean Conch

-- ZoneID:  77 - Daggerclaw Dracos
-- ZoneID: 119 - Raptor
INSERT INTO `mob_droplist` VALUES (557,0,0,1000,853,@RARE);  -- Raptor Skin (Rare, 5%)

-- ZoneID: 119 - Daggerclaw Dracos

-- ZoneID: 134 - Dagourmarche

-- ZoneID: 148 - Darksteel Quadav

-- ZoneID: 173 - Dame Blanche

-- ZoneID: 103 - Damselfly

-- ZoneID: 126 - Dancing Weapon

-- ZoneID:  15 - Dapifer Imp

-- ZoneID: 121 - Rock Golem
-- ZoneID: 122 - Darksteel Golem
-- ZoneID: 122 - Mythril Golem

-- ZoneID: 147 - Darksteel Quadav

-- ZoneID: 169 - Dark Aspic

-- ZoneID:   9 - Dark Elemental
-- ZoneID:  24 - Dark Elemental
-- ZoneID:  25 - Dark Elemental
-- ZoneID:  27 - Dark Elemental
-- ZoneID:  28 - Dark Elemental
-- ZoneID:  54 - Dark Elemental
-- ZoneID:  79 - Dark Elemental
-- ZoneID: 111 - Dark Elemental
-- ZoneID: 112 - Dark Elemental
-- ZoneID: 130 - Dark Elemental
-- ZoneID: 136 - Dark Elemental
-- ZoneID: 137 - Dark Elemental
-- ZoneID: 138 - Dark Elemental
-- ZoneID: 161 - Dark Elemental
-- ZoneID: 178 - Dark Elemental
-- ZoneID: 204 - Dark Elemental

-- ZoneID:   2 - Spunkie
-- ZoneID:   2 - Will-o-the-Wisp
-- ZoneID:  51 - Dark Esquire
-- ZoneID:  52 - Dark Esquire
-- ZoneID:  61 - Dark Esquire
-- ZoneID: 102 - Grenade
-- ZoneID: 103 - Will-o-the-Wisp
-- ZoneID: 104 - Will-o-the-Wisp
-- ZoneID: 105 - Ignis Fatuus
-- ZoneID: 108 - Grenade
-- ZoneID: 109 - Fox Fire
-- ZoneID: 110 - Ignis Fatuus
-- ZoneID: 113 - Enna-Enna
-- ZoneID: 117 - Grenade
-- ZoneID: 118 - Will-o-the-Wisp
-- ZoneID: 119 - Will-o-the-Wisp
-- ZoneID: 120 - Ignis Fatuus
-- ZoneID: 121 - Puroboros
-- ZoneID: 123 - Lava Bomb
-- ZoneID: 124 - Puroboros
-- ZoneID: 164 - Explosure
-- ZoneID: 171 - Puroboros
-- ZoneID: 192 - Will-o-the-Wisp
-- ZoneID: 193 - Will-o-the-Wisp
-- ZoneID: 200 - Puroboros

-- ZoneID: 195 - Dark Stalker Thf

-- ZoneID:  30 - Hawker
-- ZoneID:  61 - Assassin Fly
-- ZoneID:  77 - Valkurm Emperor
-- ZoneID: 121 - Ogrefly
-- ZoneID: 153 - Darter
-- ZoneID: 153 - Skimmer
-- ZoneID: 154 - Darter
-- ZoneID: 212 - Hawker
-- ZoneID: 216 - Buzzfly
INSERT INTO `mob_droplist` VALUES (571,0,0,1000,846,@COMMON); -- Insect Wing (Common, 15%)
INSERT INTO `mob_droplist` VALUES (571,4,0,1000,846,0);       -- Insect Wing (Despoil)

-- ZoneID:  65 - Darting Kachaal Ja

-- ZoneID: 81 - Dark Ixion
-- ZoneID: 82 - Dark Ixion
-- ZoneID: 84 - Dark Ixion
-- ZoneID: 89 - Dark Ixion
-- ZoneID: 91 - Dark Ixion
-- ZoneID: 95 - Dark Ixion
-- ZoneID: 96 - Dark Ixion

-- ZoneID:  77 - Stinging Sophie
INSERT INTO `mob_droplist` VALUES (574,0,0,1000,912,@COMMON);    -- Beehive Chip (Common, 15%)
INSERT INTO `mob_droplist` VALUES (574,0,0,1000,4370,@UNCOMMON); -- Pot Of Honey (Uncommon ,10%)
INSERT INTO `mob_droplist` VALUES (574,0,0,1000,846,@RARE);      -- Insect Wing (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (574,0,0,1000,925,@RARE);      -- Giant Stinger (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (574,2,0,1000,4370,0);         -- Pot Of Honey (Steal)
INSERT INTO `mob_droplist` VALUES (574,4,0,1000,912,0);          -- Beehive Chip (Despoil)
INSERT INTO `mob_droplist` VALUES (574,4,0,1000,925,0);          -- Giant Stinger (Despoil)
INSERT INTO `mob_droplist` VALUES (574,4,0,1000,4370,0);         -- Pot Of Honey (Despoil)

-- ZoneID: 149 - Davoi Pugil

-- 576 Available

-- ZoneID:  52 - Dea

-- ZoneID: 120 - Deadly Dodo

-- ZoneID: 136 - Gawper
-- ZoneID: 138 - Doom Lens
-- ZoneID: 138 - Ogler
-- ZoneID: 155 - Doom Lens
-- ZoneID: 155 - Ogler
-- ZoneID: 162 - Deadly Iris

-- ZoneID: 162 - Deadly Iris

-- ZoneID:  77 - Death Cap
-- ZoneID:  77 - Tumbling Truffle
INSERT INTO `mob_droplist` VALUES (581,0,0,1000,4374,@VCOMMON); -- Sleepshroom (Very Common, 24%)

-- ZoneID: 153 - Death Cap

-- ZoneID: 159 - Death From Above

-- ZoneID:  24 - Death Jacket
-- ZoneID:  24 - Miner Bee
-- ZoneID:  25 - Death Jacket
-- ZoneID:  25 - Miner Bee
-- ZoneID:  88 - Huge Hornet
-- ZoneID:  88 - Maneating Hornet
-- ZoneID:  91 - Death Jacket
-- ZoneID:  91 - Death Wasp
-- ZoneID: 106 - Maneating Hornet
-- ZoneID: 107 - Maneating Hornet
-- ZoneID: 110 - Death Wasp
-- ZoneID: 115 - Giant Bee
-- ZoneID: 116 - Giant Bee
-- ZoneID: 117 - Killer Bee
-- ZoneID: 123 - Death Jacket
-- ZoneID: 124 - Yhoator Wasp
-- ZoneID: 145 - Digger Wasp
-- ZoneID: 145 - Giddeus Bee
-- ZoneID: 149 - Davoi Hornet
-- ZoneID: 149 - Davoi Wasp
-- ZoneID: 197 - Vespo

-- ZoneID:  96 - Death Jacket

-- ZoneID: 197 - Death Jacket

-- 587-588 Available

-- ZoneID: 215 - Decayed Flesh

-- ZoneID:  82 - Decrepit Gnole

-- ZoneID: 254 - Deelgeed -- TODO: Abyssea NM

-- ZoneID:  15 - Deep Eye

-- 593 Available

-- ZoneID:  99 - Dee Zelko The Esoteric

-- ZoneID: 215 - Defile Scorpion

-- ZoneID:  24 - Defoliate Leshy

-- ZoneID:  51 - Defoliate Treant
-- ZoneID:  52 - Olden Treant
-- ZoneID:  79 - Mature Treant

-- ZoneID:  68 - Defoliator
-- ZoneID:  68 - Deforester

-- ZoneID: 254 - Deimobugard

-- ZoneID:  51 - Woodland Runner
-- ZoneID:  65 - Hunting Raptor
-- ZoneID:  77 - Deinonychus
-- ZoneID:  97 - Raptor
-- ZoneID:  98 - Sauromugue Skink
-- ZoneID: 113 - Velociraptor
-- ZoneID: 128 - Velociraptor
-- ZoneID: 205 - Eotyrannus
INSERT INTO `mob_droplist` VALUES (600,0,0,1000,853,@UNCOMMON); -- Raptor Skin (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (600,4,0,1000,853,0);         -- Raptor Skin (Despoil)

-- ZoneID: 174 - Deinonychus

-- ZoneID:  76 - Dekka
INSERT INTO `mob_droplist` VALUES (602,0,0,1000,15716,@ALWAYS); -- Njords Ledelsens (Always, 100%)
INSERT INTO `mob_droplist` VALUES (602,0,0,1000,5735,60);       -- Cotton Coin Purse (6.0%)
INSERT INTO `mob_droplist` VALUES (602,0,0,1000,15726,@RARE);   -- Enlils Crackows (Rare, 5%)

-- ZoneID: 176 - Delta Sahagin

-- ZoneID:  75 - Demented Jalaawa
INSERT INTO `mob_droplist` VALUES (604,0,0,1000,14559,@ALWAYS); -- Anus Doublet (Always, 100%)

-- ZoneID: 132 - Demersal Gigas

-- ZoneID:   9 - Demonic Millstone
-- ZoneID: 157 - Magic Jar
-- ZoneID: 184 - Magic Pot

-- ZoneID:  77 - Magic Flagon
-- ZoneID:  77 - Nightmare Vase
INSERT INTO `mob_droplist` VALUES (607,0,0,1000,954,@COMMON);   -- Magic Pot Shard (Common, 15%)
INSERT INTO `mob_droplist` VALUES (607,0,0,1000,914,@UNCOMMON); -- Vial Of Mercury (Uncommon, 10%)

-- ZoneID:  74 - Demonic Rose
INSERT INTO `mob_droplist` VALUES (608,0,0,1000,5367,@UNCOMMON); -- Cumulus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (608,0,0,1000,5369,@UNCOMMON); -- Stratus Cell (Uncommon, 10%)

-- ZoneID: 153 - Demonic Rose

-- ZoneID: 197 - Demonic Tiphia

-- ZoneID: 137 - Demon Befouler
-- ZoneID: 137 - Demon Justiciar
-- ZoneID: 137 - Demon Magus
-- ZoneID: 137 - Demon Warrior
-- ZoneID: 138 - Demon Befouler
-- ZoneID: 138 - Demon Condemner
-- ZoneID: 138 - Demon Corrupter
-- ZoneID: 138 - Demon Entomber
-- ZoneID: 138 - Demon Justiciar
-- ZoneID: 138 - Demon Magus
-- ZoneID: 138 - Demon Suppressor
-- ZoneID: 138 - Demon Warrior
-- ZoneID: 155 - Demon Befouler
-- ZoneID: 155 - Demon Condemner
-- ZoneID: 155 - Demon Corrupter
-- ZoneID: 155 - Demon Entomber
-- ZoneID: 155 - Demon Justiciar
-- ZoneID: 155 - Demon Magus
-- ZoneID: 155 - Demon Suppressor
-- ZoneID: 155 - Demon Warrior

-- ZoneID: 161 - Demon Chancellor

-- ZoneID: 161 - Demon Commander

-- ZoneID: 161 - Demon General

-- 615 Available

-- ZoneID: 112 - Demon Knight

-- ZoneID: 161 - Demon Knight
-- ZoneID: 162 - Demon Knight

-- ZoneID: 161 - Demon Magistrate

-- 619-620 Available

-- ZoneID: 112 - Demon Pawn
-- ZoneID: 112 - Demon Wizard

-- ZoneID: 161 - Demon Pawn
-- ZoneID: 161 - Demon Wizard
-- ZoneID: 162 - Demon Pawn
-- ZoneID: 162 - Demon Wizard

-- ZoneID: 161 - Demons Elemental
-- ZoneID: 161 - Demons Elemental
-- ZoneID: 161 - Demons Elemental

-- ZoneID: 112 - Demon Warlock

-- ZoneID: 161 - Demon Warlock
-- ZoneID: 162 - Demon Warlock

-- 626-627 Available

-- ZoneID: 176 - Denn The Orcavoiced

-- ZoneID: 160 - Den Scorpion
-- ZoneID: 205 - Sulfur Scorpion
-- ZoneID: 208 - Girtab
-- ZoneID: 212 - Antares

-- ZoneID:  15 - Depths Digester -- TODO: Abyssea NM

-- 631 Available

-- ZoneID: 114 - Desert Dhalmel
-- ZoneID: 125 - Desert Dhalmel

-- ZoneID: 114 - Lesser Manticore
-- ZoneID: 125 - Desert Manticore

-- ZoneID: 218 - Desert Puk

-- ZoneID:  88 - Huge Spider
-- ZoneID: 125 - Desert Spider

-- 636 Available

-- ZoneID: 194 - Desmodont

-- ZoneID: 130 - Despot

-- ZoneID: 177 - Detector

-- ZoneID: 217 - Devegetator

-- ZoneID:  74 - Deviate Bhoot
INSERT INTO `mob_droplist` VALUES (641,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (641,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (641,0,0,1000,5378,@UNCOMMON); -- Congestus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (641,0,0,1000,5378,@UNCOMMON); -- Congestus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (641,0,0,1000,5735,@UNCOMMON); -- Cotton Coin Purse (Uncommon, 10%)

-- ZoneID:  22 - Deviator

-- ZoneID:  74 - Devil Manta
INSERT INTO `mob_droplist` VALUES (643,0,0,1000,5369,@UNCOMMON); -- Stratus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (643,0,0,1000,5370,@UNCOMMON); -- Cirrocumulus Cell (Uncommon, 10%)

-- ZoneID: 174 - Devil Manta Fished

-- ZoneID: 176 - Devil Manta

-- ZoneID:  65 - Devout Radol Ja

-- ZoneID:  62 - Dextrose

-- ZoneID: 253 - Dhorme Khimaira

-- ZoneID: 208 - Diamond Daig

-- ZoneID: 148 - Diamond Quadav

-- ZoneID:  25 - Diatryma
-- ZoneID: 114 - Diatryma

-- ZoneID:   2 - Digger Wasp

-- 653 Available

-- ZoneID: 172 - Colliery Bat
-- ZoneID: 172 - Ding Bats

-- ZoneID: 190 - Ding Bats

-- ZoneID: 174 - Diplopod

-- ZoneID:   9 - Diremite

-- ZoneID:  27 - Diremite

-- ZoneID:   9 - Diremite Assaulter
-- ZoneID:   9 - Diremite Dominator

-- 660 Available

-- ZoneID:   9 - Diremite Stalker

-- ZoneID:   9 - Dire Bat
-- ZoneID:   9 - Purgatory Bat
-- ZoneID:   9 - Vampire Bat

-- ZoneID: 169 - Dire Bat

-- ZoneID: 136 - Gargouille
-- ZoneID: 137 - Dire Gargouille
-- ZoneID: 138 - Dire Gargouille
-- ZoneID: 155 - Gnarled Gargouille

-- 665 Available

-- ZoneID: 149 - Dirtyhanded Gochakzuk

-- 667 Available

-- ZoneID: 217 - Div-E Sepid -- TODO: Abyssea NM

-- 669 Available

-- ZoneID:  77 - Fungus Beetle
-- ZoneID:  77 - Panzer Percival
-- ZoneID:  98 - Gouger Beetle
-- ZoneID: 120 - Diving Beetle
-- ZoneID: 125 - Desert Beetle
-- ZoneID: 190 - Locus Armet Beetle
-- ZoneID: 192 - Deathwatch Beetle
-- ZoneID: 193 - Dung Beetle
-- ZoneID: 193 - Targe Beetle
-- ZoneID: 200 - Warden Beetle
INSERT INTO `mob_droplist` VALUES (670,0,0,1000,846,@COMMON);   -- Insect Wing (Common, 15%)
INSERT INTO `mob_droplist` VALUES (670,0,0,1000,889,@UNCOMMON); -- Beetle Shell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (670,0,0,1000,894,@RARE);     -- Beetle Jaw (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (670,4,0,1000,846,0);         -- Insect Wing (Despoil)
INSERT INTO `mob_droplist` VALUES (670,4,0,1000,889,0);         -- Beetle Shell (Despoil)
INSERT INTO `mob_droplist` VALUES (670,4,0,1000,894,0);         -- Beetle Jaw (Despoil)

-- ZoneID:  81 - Djinn
-- ZoneID:  84 - Djinn

-- ZoneID: 205 - Dodomeki

-- ZoneID:  76 - Don Poroggo
INSERT INTO `mob_droplist` VALUES (673,0,0,1000,14547,@ALWAYS); -- Enyos Breastplate (Always, 100%)
INSERT INTO `mob_droplist` VALUES (673,0,0,1000,14563,@ALWAYS); -- Nemains Robe (Always, 100%)

-- ZoneID: 161 - Doom Demon

-- ZoneID: 212 - Doom Guard

-- ZoneID:   5 - Doom Mage
-- ZoneID:   7 - Tomb Mage
-- ZoneID: 113 - Doom Mage
-- ZoneID: 212 - Doom Mage

-- ZoneID:  88 - Enchanted Bones War
-- ZoneID:  88 - Enchanted Bones Blm
-- ZoneID: 121 - Lost Soul Blm

-- ZoneID:   7 - Mummy
-- ZoneID:   7 - Tomb Warrior
-- ZoneID:  79 - Guard Skeleton Blm
-- ZoneID:  79 - Guard Skeleton War
-- ZoneID:  83 - Doom Mage
-- ZoneID:  89 - Doom Mage
-- ZoneID: 114 - Lost Soul Blm
-- ZoneID: 114 - Lost Soul War
-- ZoneID: 175 - Lich
-- ZoneID: 192 - Skinnymalinks
-- ZoneID: 196 - Accursed Soldier

-- ZoneID: 169 - Doom Mage

-- 680 Available

-- ZoneID: 114 - Doom Scorpion

-- ZoneID: 197 - Doom Scorpion

-- ZoneID:   5 - Doom Soldier
-- ZoneID: 169 - Fallen Knight

-- ZoneID: 113 - Doom Soldier

-- ZoneID: 169 - Doom Soldier

-- ZoneID: 212 - Doom Soldier

-- ZoneID: 160 - Doom Toad

-- ZoneID: 212 - Doom Warlock

-- ZoneID:  40 - Doo Peku The Fleetfoot

-- ZoneID: 194 - Doppelganger Dio

-- ZoneID: 194 - Doppelganger Gog

-- ZoneID:  62 - Dorgerwor The Astute

-- ZoneID: 126 - Dosetsu Tree

-- ZoneID:  92 - Doyen Quadav
-- ZoneID: 155 - Doyen Quadav

-- ZoneID: 132 - Dozing Dorian -- TODO: Abyssea NM

-- ZoneID:  73 - Draco Lizard
INSERT INTO `mob_droplist` VALUES (696,0,0,1000,5367,@VCOMMON); -- Cumulus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (696,0,0,1000,5368,@ALWAYS);  -- Radiatus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (696,0,0,1000,5368,@ALWAYS);  -- Radiatus Cell (Always, 100%)

-- ZoneID: 197 - Dragonfly

-- ZoneID:  65 - Dragonscaled Bugaal Ja

-- ZoneID: 218 - Dragua -- TODO: Abyssea NM

-- ZoneID:  85 - Draketrader Zlodgodd

-- 701 Available

-- ZoneID:  54 - Draugar Servant Drk
-- ZoneID:  54 - Draugar Servant Blm
-- ZoneID:  54 - Draugar Servant Drg
-- ZoneID:  54 - Draugar Servant Thf
-- ZoneID:  79 - Draugar Servant Blm
-- ZoneID:  79 - Draugar Servant Drg
-- ZoneID:  79 - Draugar Servant Thf
-- ZoneID:  79 - Draugar Servant Drk

-- ZoneID: 197 - Dreadbug

-- ZoneID:   5 - Dread Demon

-- ZoneID: 161 - Dread Demon

-- ZoneID: 215 - Drekavac -- TODO: Abyssea NM

-- ZoneID: 167 - Drexerion The Condemned

-- ZoneID: 200 - Droma

-- ZoneID: 204 - Droma

-- 710 Available

-- ZoneID: 197 - Drone Crawler

-- ZoneID: 110 - Drooling Daisy

-- ZoneID: 135 - Duke Berith

-- ZoneID: 135 - Duke Haures

-- ZoneID: 135 - Duke Gomory

-- ZoneID: 161 - Duke Haborym

-- ZoneID: 135 - Duke Scox

-- ZoneID: 218 - Dune Cockatrice

-- ZoneID: 218 - Dune Manticore

-- ZoneID: 114 - Dune Widow

-- 721 Available

-- ZoneID: 217 - Durinn -- TODO: Abyssea NM

-- ZoneID: 216 - Dusk Lizard

-- ZoneID: 177 - Dustbuster

-- ZoneID:  99 - Duu Masa The Onecut

-- ZoneID: 217 - Dvalinn -- TODO: Abyssea NM

-- 727 Available

-- ZoneID:  91 - Dyinyinga

-- ZoneID: 135 - Dynamis Lord

-- ZoneID: 135 - Arch Dynamis Lord

-- ZoneID: 216 - Dynamo Cluster

-- Available

-- ZoneID:   7 - Earth Elemental
-- ZoneID:   7 - Earth Elemental
-- ZoneID:  11 - Earth Elemental
-- ZoneID:  12 - Earth Elemental
-- ZoneID:  12 - Earth Elemental
-- ZoneID:  61 - Earth Elemental
-- ZoneID:  84 - Earth Elemental
-- ZoneID:  96 - Earth Elemental
-- ZoneID:  97 - Earth Elemental
-- ZoneID:  98 - Earth Elemental
-- ZoneID:  99 - Earth Elemental
-- ZoneID: 103 - Earth Elemental
-- ZoneID: 105 - Earth Elemental
-- ZoneID: 108 - Earth Elemental
-- ZoneID: 114 - Earth Elemental
-- ZoneID: 117 - Earth Elemental
-- ZoneID: 119 - Earth Elemental
-- ZoneID: 120 - Earth Elemental
-- ZoneID: 125 - Earth Elemental
-- ZoneID: 130 - Earth Elemental
-- ZoneID: 164 - Earth Elemental
-- ZoneID: 175 - Earth Elemental
-- ZoneID: 177 - Earth Elemental
-- ZoneID: 178 - Earth Elemental
-- ZoneID: 195 - Earth Elemental
-- ZoneID: 200 - Earth Elemental
-- ZoneID: 212 - Earth Elemental

-- ZoneID: 151 - Earth Elemental

-- ZoneID: 196 - Earth Elemental

-- ZoneID: 198 - Earth Elemental

-- ZoneID:  77 - Eastern Shadow
-- ZoneID:  77 - Western Shadow
-- ZoneID:  77 - Northern Shadow
-- ZoneID:  77 - Southern Shadow
INSERT INTO `mob_droplist` VALUES (737,0,0,1000,940,@COMMON); -- Revival Tree Root (Common, 15%)

-- ZoneID: 204 - Eastern Shadow

-- ZoneID:  27 - Eba

-- ZoneID:  61 - Ebony Pudding
-- ZoneID:  62 - Black Pudding
-- ZoneID:  62 - Ebony Pudding

-- ZoneID:  15 - Eccentric Eve -- TODO: Abyssea NM

-- ZoneID: 137 - Eclipse Demon
-- ZoneID: 155 - Eclipse Demon

-- ZoneID: 253 - Ectozoon

-- ZoneID: 124 - Edacious Opo-Opo

-- ZoneID:  39 - Adamantking Effigy
-- ZoneID:  39 - Adamantking Effigy
-- ZoneID:  40 - Adamantking Effigy
-- ZoneID:  40 - Adamantking Effigy
-- ZoneID:  41 - Adamantking Effigy
-- ZoneID:  41 - Adamantking Effigy
-- ZoneID:  42 - Adamantking Effigy

-- ZoneID:   4 - Eft

-- ZoneID: 194 - Eight Of Batons

-- ZoneID: 194 - Eight Of Coins

-- ZoneID: 194 - Eight Of Cups

-- ZoneID: 194 - Eight Of Swords

-- ZoneID: 136 - Ekimmu

-- ZoneID:  90 - Elder Quadav

-- ZoneID: 147 - Elder Quadav
-- ZoneID: 147 - Iron Quadav

-- ZoneID: 161 - Iron Quadav
-- ZoneID: 162 - Iron Quadav

-- ZoneID: 161 - Elder Quadav
-- ZoneID: 162 - Elder Quadav

-- 756 Available

-- ZoneID:  28 - Elel

-- ZoneID:  77 - Ellyllon
INSERT INTO `mob_droplist` VALUES (758,0,0,1000,4374,@COMMON); -- Sleepshroom (Common, 15%)
INSERT INTO `mob_droplist` VALUES (758,0,0,1000,4449,@RARE);   -- Reishi Mushroom (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (758,0,0,1000,4386,@SRARE);  -- King Truffle (Super Rare, 0.5%)

-- ZoneID: 121 - Elusive Edwin

-- ZoneID:  40 - Elvaansticker Bxafraff

-- ZoneID:  91 - Emerald Quadav
-- ZoneID: 171 - Emerald Quadav

-- ZoneID: 147 - Emerald Quadav

-- ZoneID: 161 - Emerald Quadav
-- ZoneID: 162 - Emerald Quadav

-- ZoneID:  52 - Emergent Elm

-- ZoneID:  75 - Wandering Wamoura
-- ZoneID:  75 - Sulfur Scorpion
-- ZoneID:  75 - Empathic Flan
INSERT INTO `mob_droplist` VALUES (765,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (765,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (765,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (765,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (765,1,1,@SRARE,14970,200);    -- Hoshikazu Tekko (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (765,1,1,@SRARE,15712,200);    -- Enyo's Leggings (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (765,1,1,@SRARE,15728,200);    -- Nemain's Sabots (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (765,1,1,@SRARE,15630,200);    -- Njord's Trousers (Group 1, Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (765,1,1,@SRARE,16097,200);    -- Anu's Tiara (Group 1, Super Rare, 0.5%)

-- ZoneID: 218 - Emperador De Altepa

-- ZoneID:  54 - Emperor Apkallu

-- ZoneID: 253 - Empousa -- TODO: Abyssea NM

-- ZoneID:  77 - Draugar
-- ZoneID:  81 - Enchanted Bones War
-- ZoneID:  81 - Enchanted Bones Blm
-- ZoneID:  82 - Skeleton Esquire
-- ZoneID:  83 - Doom Soldier
-- ZoneID:  89 - Doom Soldier
-- ZoneID: 100 - Enchanted Bones Blm
-- ZoneID: 100 - Enchanted Bones War
-- ZoneID: 101 - Enchanted Bones Blm
-- ZoneID: 101 - Enchanted Bones War
-- ZoneID: 102 - Skeleton Warrior
-- ZoneID: 102 - Skeleton Sorcerer
-- ZoneID: 106 - Enchanted Bones Blm
-- ZoneID: 106 - Enchanted Bones War
-- ZoneID: 107 - Enchanted Bones War
-- ZoneID: 107 - Enchanted Bones Blm
-- ZoneID: 108 - Skeleton Warrior
-- ZoneID: 108 - Skeleton Sorcerer
-- ZoneID: 115 - Magicked Bones War
-- ZoneID: 115 - Magicked Bones Blm
-- ZoneID: 116 - Magicked Bones War
-- ZoneID: 116 - Magicked Bones Blm
-- ZoneID: 117 - Skeleton Warrior
-- ZoneID: 117 - Skeleton Sorcerer
-- ZoneID: 136 - Thawed Bones War
-- ZoneID: 136 - Thawed Bones Blm
-- ZoneID: 137 - Snow Wight War
-- ZoneID: 137 - Snow Wight Blm
-- ZoneID: 190 - Enchanted Bones Blm
-- ZoneID: 190 - Enchanted Bones War
-- ZoneID: 192 - Skinnymajinx
-- ZoneID: 195 - Hellbound Warlock
-- ZoneID: 195 - Lost Soul Blm
-- ZoneID: 195 - Lost Soul War
-- ZoneID: 196 - Accursed Sorcerer
-- ZoneID: 196 - Skeleton Warrior
-- ZoneID: 227 - Ship Wight
-- ZoneID: 228 - Ship Wight
INSERT INTO `mob_droplist` VALUES (769,0,0,1000,880,@COMMON); -- Bone Chip (Common, 15%)
INSERT INTO `mob_droplist` VALUES (769,2,0,1000,880,0);       -- Bone Chip (Steal)
INSERT INTO `mob_droplist` VALUES (769,4,0,1000,880,0);       -- Bone Chip (Despoil)

-- ZoneID:  61 - Energetic Eruca

-- ZoneID:  77 - Energetic Eruca
INSERT INTO `mob_droplist` VALUES (771,0,0,1000,839,@UNCOMMON); -- Piece Of Crawler Cocoon (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (771,0,0,1000,816,@RARE);     -- Spool Of Silk Thread (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (771,0,0,1000,4357,@COMMON);  -- Crawler Egg (Common, 15%)

-- ZoneID: 158 - Enkelados

-- 773 Available

-- ZoneID: 215 - Entozoon

-- ZoneID:  34 - Eoaern War
-- ZoneID:  34 - Eoaern Mnk
-- ZoneID:  34 - Eoaern Blm
-- ZoneID:  34 - Eoaern Smn
-- ZoneID:  34 - Eoaern Thf
-- ZoneID:  34 - Eoaern Pld
-- ZoneID:  34 - Eoaern Rng
-- ZoneID:  34 - Eoaern Nin
-- ZoneID:  34 - Eoaern Drg
-- ZoneID:  34 - Eoaern Whm
-- ZoneID:  34 - Eoaern Bst
-- ZoneID:  34 - Eoaern Brd
-- ZoneID:  34 - Eoaern Sam
-- ZoneID:  34 - Eoaern Drk
-- ZoneID:  34 - Eoaern Rdm

-- ZoneID:  34 - Eoeuvhi

-- ZoneID:  34 - Eoghrah

-- ZoneID:  34 - Eozdei
-- ZoneID:  35 - Awzdei
-- ZoneID:  35 - Awzdei_Still

-- ZoneID: 215 - Crevice Amoeban
-- ZoneID: 215 - Ephemeral Amoeban
-- ZoneID: 216 - Ephemeral Amoeban
-- ZoneID: 216 - Protoamoeban
-- ZoneID: 217 - Ephemeral Amoeban
-- ZoneID: 217 - Stream Amoeban
-- ZoneID: 218 - Oasis Amoeban
-- ZoneID: 253 - Floe Amoeban
-- ZoneID: 254 - Pond Amoeban

-- 780 Available

-- ZoneID:  15 - Ephemeral Clionid
-- ZoneID:  15 - Ephemeral Clionid
-- ZoneID:  45 - Ephemeral Clionid
-- ZoneID: 132 - Ephemeral Clionid
-- ZoneID: 132 - Veld Clionid
-- ZoneID: 132 - Veld Clionid
-- ZoneID: 218 - Desert Clionid
-- ZoneID: 253 - Range Clionid
-- ZoneID: 254 - Knoll Clionid

-- 782 Available

-- ZoneID:  15 - Ephemeral Limule
-- ZoneID:  15 - Ephemeral Limule
-- ZoneID:  45 - Ephemeral Limule
-- ZoneID: 132 - Ephemeral Limule
-- ZoneID: 132 - Gigadaphnia
-- ZoneID: 132 - Gigadaphnia
-- ZoneID: 218 - Arid Limule
-- ZoneID: 253 - Crag Limule
-- ZoneID: 254 - Stream Limule

-- ZoneID: 215 - Ephemeral Murex
-- ZoneID: 215 - Rock Murex
-- ZoneID: 216 - Ephemeral Murex
-- ZoneID: 216 - Escarp Murex
-- ZoneID: 217 - Ephemeral Murex
-- ZoneID: 217 - River Murex
-- ZoneID: 218 - Sand Murex
-- ZoneID: 253 - Iceberg Murex
-- ZoneID: 254 - Hillock Murex

-- 785 Available

-- ZoneID:  54 - Ephramadian Shade Mnk
-- ZoneID:  54 - Ephramadian Shade Rdm
-- ZoneID:  54 - Ephramadian Shade Rng
-- ZoneID:  54 - Ephramadian Shade Cor
-- ZoneID:  79 - Ephramadian Shade Mnk
-- ZoneID:  79 - Ephramadian Shade Rng
-- ZoneID:  79 - Ephramadian Shade Rdm
-- ZoneID:  79 - Ephramadian Shade Cor

-- ZoneID: 157 - Eurytos
-- ZoneID: 157 - Polybotes
-- ZoneID: 157 - Rhoitos
-- ZoneID: 157 - Ophion
-- ZoneID: 157 - Rhoikos
-- ZoneID: 184 - Epialtes
-- ZoneID: 184 - Hippolytos
-- ZoneID: 184 - Eurymedon

-- ZoneID: 112 - Ereshkigal

-- ZoneID: 218 - Ergdrake

-- ZoneID: 212 - Erlik

-- ZoneID: 253 - Ermit Imp

-- 792-793 Available

-- ZoneID: 112 - Evil Eye
-- ZoneID: 161 - Evil Eye
-- ZoneID: 162 - Evil Eye

-- ZoneID:  84 - Evil Spirit
-- ZoneID:  91 - Evil Spirit
-- ZoneID: 105 - Evil Spirit

-- 796-797 Available

-- ZoneID: 157 - Evil Spirit

-- ZoneID: 166 - Evil Weapon

-- ZoneID: 197 - Exoray

-- ZoneID:  79 - Experimental Lamia

-- ZoneID: 200 - Explosure

-- ZoneID: 145 - Eyy Mon The Ironbreaker

-- ZoneID:   5 - Fachan
-- ZoneID:   5 - Smolenkos
-- ZoneID:   5 - Scowlenkos

-- ZoneID: 154 - Fafnir
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,903,@ALWAYS);     -- Dragon Talon (Always, 100%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,14075,@VCOMMON);  -- Andvaranauts (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,13914,@COMMON);   -- Aegishjalmr (Common, 15%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,867,@VCOMMON);    -- Handful Of Dragon Scales (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,867,@VCOMMON);    -- Handful Of Dragon Scales (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,4486,@COMMON);    -- Dragon Heart (Common, 15%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,16942,@UNCOMMON); -- Balmung (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,17653,@UNCOMMON); -- Hrotti (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (805,1,1,@ALWAYS,1339,310);     -- Neptunal Abjuration Head (Group 1, Always, 100% - 31%)
INSERT INTO `mob_droplist` VALUES (805,1,1,@ALWAYS,1326,230);     -- Aquarian Abjuration Hands (Group 1, Always, 100% - 23%)
INSERT INTO `mob_droplist` VALUES (805,1,1,@ALWAYS,1321,230);     -- Earthen Abjuration Hands (Group 1, Always, 100% - 23%)
INSERT INTO `mob_droplist` VALUES (805,1,1,@ALWAYS,1328,230);     -- Aquarian Abjuration Feet (Group 1, Always, 100% - 23%)
INSERT INTO `mob_droplist` VALUES (805,1,2,@UNCOMMON,1339,310);   -- Neptunal Abjuration Head (Group 2, Uncommon, 10% - 31%)
INSERT INTO `mob_droplist` VALUES (805,1,2,@UNCOMMON,1326,230);   -- Aquarian Abjuration Hands (Group 2, Uncommon, 10% - 23%)
INSERT INTO `mob_droplist` VALUES (805,1,2,@UNCOMMON,1321,230);   -- Earthen Abjuration Hands (Group 2, Uncommon, 10% - 23%)
INSERT INTO `mob_droplist` VALUES (805,1,2,@UNCOMMON,1328,230);   -- Aquarian Abjuration Feet (Group 2, Uncommon, 10% - 23%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,3340,@RARE);      -- Cup Of Sweet Tea (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (805,0,0,1000,16555,@VRARE);    -- Ridill (Very Rare, 1%)

-- ZoneID:  39 - Fairy Ring

-- ZoneID:  77 - Dune Widow
-- ZoneID:  77 - Falcatus Aranei
INSERT INTO `mob_droplist` VALUES (807,0,0,1000,838,@UNCOMMON); -- Spider Web (Uncommon, 10%)

-- ZoneID: 173 - Falcatus Aranei

-- ZoneID: 200 - Fallen Evacuee Blm
-- ZoneID: 200 - Fallen Evacuee War

-- ZoneID: 125 - Fallen Knight

-- ZoneID: 195 - Fallen Knight

-- ZoneID: 200 - Fallen Mage

-- ZoneID: 200 - Fallen Major

-- ZoneID: 200 - Fallen Officer Blm
-- ZoneID: 200 - Fallen Officer War

-- ZoneID: 200 - Fallen Soldier Blm
-- ZoneID: 200 - Fallen Soldier War

-- ZoneID:  85 - Falsespinner Bhudbrodd

-- ZoneID: 113 - Fantasma

-- ZoneID: 132 - Farfadet

-- ZoneID:  62 - Farlarder The Shrewd

-- ZoneID:   5 - Snow Maiden
-- ZoneID:   5 - Father Frost

-- ZoneID: 29 - Bahamut

-- ZoneID: 254 - Faunus Wyvern

-- ZoneID: 218 - Fear Dearg

-- ZoneID:  15 - Fear Gorta -- TODO: Abyssea NM

-- ZoneID:  85 - Feeblescheme Bhogbigg

-- ZoneID: 200 - Fetid Flesh

-- ZoneID: 196 - Feu Follet

-- ZoneID:  82 - War Smilodon
-- ZoneID:  83 - Fierce Smilodon
-- ZoneID:  84 - Smilodon
-- ZoneID:  85 - Fighting Smilodon
-- ZoneID: 136 - Icefang Tiger
-- ZoneID: 175 - War Smilodon

-- 829 Available

-- ZoneID:  30 - Firedrake

-- ZoneID:  61 - Fire Elemental
-- ZoneID:  62 - Fire Elemental
-- ZoneID:  91 - Fire Elemental
-- ZoneID:  97 - Fire Elemental
-- ZoneID:  99 - Fire Elemental
-- ZoneID: 103 - Fire Elemental
-- ZoneID: 110 - Fire Elemental
-- ZoneID: 113 - Fire Elemental
-- ZoneID: 114 - Fire Elemental
-- ZoneID: 119 - Fire Elemental
-- ZoneID: 123 - Fire Elemental
-- ZoneID: 124 - Fire Elemental
-- ZoneID: 125 - Fire Elemental
-- ZoneID: 128 - Fire Elemental
-- ZoneID: 130 - Fire Elemental
-- ZoneID: 151 - Fire Elemental
-- ZoneID: 159 - Fire Elemental
-- ZoneID: 160 - Fire Elemental
-- ZoneID: 171 - Fire Elemental
-- ZoneID: 174 - Fire Elemental
-- ZoneID: 177 - Fire Elemental
-- ZoneID: 178 - Fire Elemental
-- ZoneID: 212 - Fire Elemental

-- ZoneID: 197 - Fire Elemental

-- ZoneID:  73 - First Rampart
-- ZoneID:  73 - Second Rampart
-- ZoneID:  73 - Third Rampart
INSERT INTO `mob_droplist` VALUES (833,0,0,1000,2375,@UNCOMMON); -- Zhayolm Card (Uncommon, 10%)

-- ZoneID:   1 - Fishtrap
-- ZoneID:   2 - Fishtrap

-- ZoneID:  15 - Fistule -- TODO: Abyssea NM

-- ZoneID: 194 - Five Of Batons

-- ZoneID: 194 - Five Of Coins

-- ZoneID: 194 - Five Of Cups

-- ZoneID: 194 - Five Of Swords

-- ZoneID:  40 - Flamecaller Zoeqdoq

-- ZoneID:  30 - Flamedrake

-- ZoneID: 216 - Flame Skimmer -- TODO: Abyssea NM

-- ZoneID: 130 - Flamingo

-- ZoneID: 159 - Flauros

-- ZoneID: 169 - Fleshcraver

-- ZoneID: 254 - Fleshflayer Killakriq -- TODO: Abyssea NM

-- ZoneID:  99 - Fleshgnasher

-- ZoneID:   7 - Flesh Eater

-- 849-850 Available

-- ZoneID: 213 - Flying Manta

-- ZoneID:   1 - Flytrap
-- ZoneID:   2 - Battrap
-- ZoneID:   2 - Birdtrap
-- ZoneID:   2 - Flytrap
-- ZoneID:  30 - Hawkertrap
-- ZoneID:  68 - Puktrap
-- ZoneID:  77 - Puktrap
-- ZoneID:  79 - Puktrap
INSERT INTO `mob_droplist` VALUES (852,0,0,1000,1617,@RARE); -- Flytrap Leaf (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (852,4,0,1000,1617,0);     -- Flytrap Leaf (Despoil)

-- ZoneID: 193 - Fly Agaric

-- ZoneID: 196 - Fly Agaric

-- ZoneID:  25 - Fomor Paladin
-- ZoneID:  25 - Fomor Bard
-- ZoneID:  25 - Fomor Red Mage

-- ZoneID:  27 - Fomor Bard

-- ZoneID:  28 - Fomor Bard

-- ZoneID:  24 - Fomor Beastmaster
-- ZoneID:  24 - Fomor Ranger
-- ZoneID:  24 - Fomor Summoner
-- ZoneID:  24 - Fomor Thief
-- ZoneID:  25 - Fomor Summoner
-- ZoneID:  175 - Eastern Spriggan
-- ZoneID:  175 - Northern Spriggan
-- ZoneID:  175 - Southern Spriggan
-- ZoneID:  175 - Western Spriggan

-- ZoneID:  27 - Fomor Beastmaster

-- ZoneID:  28 - Fomor Beastmaster

-- ZoneID:  27 - Fomor Black Mage

-- ZoneID:  28 - Fomor Black Mage

-- ZoneID:  27 - Fomor Dark Knight

-- ZoneID:  28 - Fomor Dark Knight

-- ZoneID:  27 - Fomor Dragoon

-- ZoneID:  28 - Fomor Dragoon

-- ZoneID:  24 - Fomor Monk
-- ZoneID:  24 - Fomor Paladin
-- ZoneID:  24 - Fomor Samurai
-- ZoneID:  24 - Fomor Warrior

-- ZoneID:  27 - Fomor Monk

-- ZoneID:  28 - Fomor Monk

-- ZoneID:  27 - Fomor Ninja

-- ZoneID:  28 - Fomor Ninja

-- ZoneID:  28 - Fomor Paladin

-- ZoneID:  27 - Fomor Ranger

-- ZoneID:  28 - Fomor Ranger

-- ZoneID:  27 - Fomor Red Mage

-- ZoneID:  28 - Fomor Red Mage

-- ZoneID:  24 - Fomor Bard (Blueblade Fell) -- TODO: mob_groups.SQL doesn't distinguish between lower and higher level fomors in the zone
-- ZoneID:  24 - Fomor Paladin (Blueblade Fell)
-- ZoneID:  24 - Fomor Red Mage (Blueblade Fell)
-- INSERT INTO `mob_droplist` VALUES (877,0,0,1000,1843,@UNCOMMON); -- Square Of Spectral Crimson (Uncommon, 10%)
-- INSERT INTO `mob_droplist` VALUES (877,0,0,1000,940,@VRARE);     -- Revival Tree Root (Very Rare, 1%)

-- ZoneID:  27 - Fomor Samurai

-- ZoneID:  28 - Fomor Samurai

-- ZoneID:  27 - Fomor Paladin

-- ZoneID:  27 - Fomor Summoner

-- ZoneID:  28 - Fomor Summoner

-- ZoneID:  28 - Fomors Bats

-- ZoneID:  28 - Fomors Wyvern

-- 885 Available

-- ZoneID:  27 - Fomor Thief

-- ZoneID:  28 - Fomor Thief

-- 888 Available

-- ZoneID:  27 - Fomor Warrior

-- ZoneID:  28 - Fomor Warrior

-- ZoneID: 205 - Foreseer Oramix

-- ZoneID: 100 - Forest Funguar
-- ZoneID: 101 - Forest Funguar

-- ZoneID: 100 - Forest Hare
-- ZoneID: 101 - Wild Rabbit

-- ZoneID:  81 - Forest Hare
-- ZoneID: 100 - Wild Rabbit
-- ZoneID: 101 - Forest Hare

-- ZoneID:  82 - Thread Leech Fished
-- ZoneID:  82 - Forest Leech
-- ZoneID:  83 - Royal Leech
-- ZoneID:  90 - Thread Leech Fished
-- ZoneID:  90 - Thread Leech
-- ZoneID:  91 - Horrid Fluke
-- ZoneID:  91 - Poison Leech
-- ZoneID: 104 - Thread Leech Fished
-- ZoneID: 104 - Huge Leech
-- ZoneID: 109 - Swamp Leech Fished
-- ZoneID: 109 - Thread Leech Fished
-- ZoneID: 110 - Horrid Fluke Fished

-- ZoneID:   2 - Forest Tiger
-- ZoneID: 104 - Forest Tiger

-- ZoneID: 108 - Forger

-- ZoneID:  27 - Foul Meat

-- ZoneID: 196 - Foul Meat

-- ZoneID: 194 - Four Of Batons

-- ZoneID: 194 - Four Of Coins

-- ZoneID: 194 - Four Of Cups

-- ZoneID: 194 - Four Of Swords

-- ZoneID: 104 - Fradubio

-- ZoneID: 104 - Fraelissa

-- ZoneID: 160 - Friar Rush
INSERT INTO `mob_droplist` VALUES (906,0,0,1000,18139,@ALWAYS);   -- Bomb Core (Always, 100%)
INSERT INTO `mob_droplist` VALUES (906,0,0,1000,928,@VCOMMON);    -- Pinch Of Bomb Ash (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (906,0,0,1000,17316,@UNCOMMON); -- Bomb Arm (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (906,2,0,1000,17316,0);         -- Bomb Arm (Steal)

-- ZoneID:  62 - Friars Lantern (Grow)

-- ZoneID:  62 - Friars Lantern

-- ZoneID:  77 - Friars Lantern
INSERT INTO `mob_droplist` VALUES (909,0,0,1000,928,@COMMON);     -- Pinch Of Bomb Ash (Common, 15%)
INSERT INTO `mob_droplist` VALUES (909,0,0,1000,17316,@UNCOMMON); -- Bomb Arm (Uncommon, 10%)

-- ZoneID: 216 - Frigatebird

-- ZoneID:  77 - Frostmane
INSERT INTO `mob_droplist` VALUES (911,0,0,1000,1116,@UNCOMMON); -- Manticore Hide (Uncommon, 10%)

-- ZoneID: 113 - Frostmane

-- ZoneID:   9 - Frost Lizard

-- ZoneID: 254 - Fuath -- TODO: Abyssea NM

-- ZoneID:  82 - Ignis Djinn
-- ZoneID:  83 - Ignis Djinn
-- ZoneID: 136 - Fulminator
-- ZoneID: 137 - Harum-Scarum
-- ZoneID: 175 - Ignis Djinn

-- ZoneID: 216 - Funereal Apkallu -- TODO: Abyssea NM

-- ZoneID: 100 - Fungus Beetle

-- 918 Available

-- ZoneID: 200 - Funnel Bats

-- ZoneID:  82 - Lobison
-- ZoneID:  85 - Lobison
-- ZoneID: 137 - Fusty Gnole

-- ZoneID: 176 - Fyuu The Seabellow

-- ZoneID: 191 - Fume Lizard

-- ZoneID:  84 - Tsetse Fly
-- ZoneID: 105 - May Fly
-- ZoneID: 109 - Gadfly
-- ZoneID: 196 - Madfly
-- ZoneID: 197 - Dancing Jewel

-- ZoneID: 215 - Gaizkin -- TODO: Abyssea NM

-- ZoneID:   7 - Gallinipper
-- ZoneID:   7 - Monarch Ogrefly
-- ZoneID:   7 - Ogrefly

-- ZoneID: 196 - Gallinipper
-- ZoneID: 196 - Sadfly

-- ZoneID: 254 - Gamayun -- TODO: Abyssea NM

-- ZoneID:  15 - Gangly Gean -- TODO: Abyssea NM

-- ZoneID:  61 - Garharlor The Unruly

-- ZoneID: 111 - Gargantua

-- 931 Available

-- ZoneID:   9 - Gargoyle

-- ZoneID: 167 - Garm
-- ZoneID: 167 - Hecatomb Hound

-- ZoneID:  90 - Garnet Quadav
-- ZoneID:  92 - Star Ruby Quadav
-- ZoneID: 138 - Star Ruby Quadav
-- ZoneID: 138 - Vajra Quadav
-- ZoneID: 155 - Meteor Quadav

-- ZoneID: 110 - Garnet Quadav

-- ZoneID: 147 - Garnet Quadav

-- ZoneID: 216 - Gasher

-- ZoneID: 218 - Gastornis

-- ZoneID:  75 - Gate Widow
INSERT INTO `mob_droplist` VALUES (939,0,0,1000,5735,@ALWAYS);    -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (939,0,0,1000,5735,@SRARE);     -- Cotton Coin Purse (Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (939,0,0,1000,14980,@UNCOMMON); -- Machas Cuffs (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (939,0,0,1000,15640,@RARE);     -- Enlils Brayettes (Rare, 5%)

-- 940 Available

-- ZoneID:  28 - Gazer

-- ZoneID: 195 - Gazer

-- ZoneID: 149 - Geezard

-- ZoneID: 132 - Geier

-- ZoneID:  77 - Gem Heister Roorooroon
-- ZoneID:  77 - Stealth Bomber Gagaroon
-- ZoneID:  77 - Quick Draw Sasaroon
INSERT INTO `mob_droplist` VALUES (945,0,0,1000,2503,@VCOMMON); -- Handful Of Almonds (Very Common, 24%)

-- ZoneID: 130 - Genbu

-- ZoneID: 193 - Gerwitzs Axe

-- ZoneID: 193 - Gerwitzs Sword

-- ZoneID:  74 - Gespenst
INSERT INTO `mob_droplist` VALUES (949,0,0,1000,5372,@UNCOMMON); -- Virga Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (949,0,0,1000,5378,@UNCOMMON); -- Congestus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (949,0,0,1000,5380,@UNCOMMON); -- Velum Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (949,0,0,1000,5372,@RARE);     -- Virga Cell (Rare, 5%)

-- ZoneID: 167 - Gespenst

-- ZoneID:   5 - Geush Urvan

-- ZoneID: 191 - Geyser Lizard

-- ZoneID:  82 - Ghoul War
-- ZoneID: 111 - Ghast War
-- ZoneID: 111 - Ghast Blm

-- ZoneID: 176 - Ghast Blm
-- ZoneID: 176 - Ghast War

-- ZoneID: 196 - Ghast Blm

-- ZoneID: 102 - Ghost
-- ZoneID: 108 - Ghost
-- ZoneID: 117 - Ghost

-- 957 Available

-- ZoneID:   2 - Ghoul Blm
-- ZoneID:   2 - Ghoul War
-- ZoneID:   2 - Wendigo War
-- ZoneID:   7 - Lich
-- ZoneID:  28 - Lich
-- ZoneID:  84 - Wight War
-- ZoneID:  84 - Wight Blm
-- ZoneID:  90 - Ghoul War
-- ZoneID:  91 - Wight War
-- ZoneID:  91 - Wight Blm
-- ZoneID: 169 - Lich
-- ZoneID: 175 - Lost Soul War

-- ZoneID: 198 - Ghoul War

-- ZoneID: 103 - Ghoul War
-- ZoneID: 103 - Ghoul Blm
-- ZoneID: 104 - Ghoul War
-- ZoneID: 109 - Ghoul War
-- ZoneID: 118 - Ghoul Blm

-- ZoneID: 194 - Ghoul War
-- ZoneID: 194 - Ghoul Blm

-- ZoneID: 196 - Ghoul War
-- ZoneID: 196 - Ghoul Blm

-- ZoneID: 172 - Veindigger Leech

-- ZoneID: 126 - Giant Ascetic
-- ZoneID: 126 - Giant Ranger
-- ZoneID: 126 - Giant Trapper
-- ZoneID: 157 - Giant Gatekeeper
-- ZoneID: 157 - Giant Guard
-- ZoneID: 157 - Giant Sentry
-- ZoneID: 184 - Giant Gatekeeper
-- ZoneID: 184 - Giant Guard
-- ZoneID: 184 - Giant Sentry

-- 965 Available

-- ZoneID:   5 - Giant Buffalo

-- 967 Available

-- ZoneID: 126 - Giant Hunter
-- ZoneID: 157 - Giant Lobber
-- ZoneID: 184 - Giant Lobber

-- ZoneID:  46 - Gugru Orobon
-- ZoneID:  47 - Gugru Orobon
-- ZoneID:  57 - Giant Orobon
-- ZoneID:  61 - Giant Orobon

-- ZoneID:   1 - Giant Pugil

-- 971 Available

-- ZoneID: 166 - Giant Scorpion

-- ZoneID:  81 - Giant Spider
-- ZoneID: 114 - Giant Spider

-- 974 Available

-- ZoneID:  58 - Abyssal Pugil
-- ZoneID:  81 - Mud Pugil
-- ZoneID:  84 - Land Pugil Fished
-- ZoneID:  95 - Mud Pugil
-- ZoneID: 101 - Mud Pugil
-- ZoneID: 102 - Puffer Pugil
-- ZoneID: 103 - Puffer Pugil
-- ZoneID: 116 - Mud Pugil
-- ZoneID: 118 - Puffer Pugil
-- ZoneID: 140 - Puffer Pugil
-- ZoneID: 140 - Ghelsba Pugil
-- ZoneID: 141 - Puffer Pugil
-- ZoneID: 141 - Land Pugil Fished
-- ZoneID: 145 - Puffer Pugil
-- ZoneID: 145 - Land Pugil Fished
-- ZoneID: 145 - Giddeus Pugil
-- ZoneID: 147 - Land Pugil

-- ZoneID: 137 - Gidim

-- ZoneID: 215 - Gieremund -- TODO: Abyssea NM

-- 978 Available

-- ZoneID:  25 - Gigantobugard

-- ZoneID: 158 - Gigas Bonecutter
-- ZoneID: 158 - Gigas Spirekeeper
-- ZoneID: 158 - Gigas Stonemason
-- ZoneID: 158 - Gigas Torturer
-- ZoneID: 184 - Gigas Sculptor
-- ZoneID: 184 - Gigas Punisher
-- ZoneID: 184 - Gigas Hallwatcher

-- ZoneID:  24 - Gigas Braver
-- ZoneID:  24 - Gigas Catapulter
-- ZoneID:  24 - Gigas Fighter
-- ZoneID:  24 - Gigas Martialist
-- ZoneID:  24 - Gigas Slinger
-- ZoneID:  24 - Gigas Warwolf
-- ZoneID:  24 - Gigas Wrestler

-- ZoneID:  25 - Gigas Braver
-- ZoneID:  25 - Gigas Martialist
-- ZoneID:  25 - Gigas Warwolf

-- ZoneID:  25 - Gigas Catapulter

-- ZoneID: 136 - Gigas Pelter
-- ZoneID: 136 - Gigas Cleaver
-- ZoneID: 136 - Gigas Pounder
-- ZoneID: 137 - Gigas Lopper
-- ZoneID: 137 - Gigas Slugger

-- ZoneID:  83 - Gigas Deckhand
-- ZoneID:  83 - Gigas Helmsman
-- ZoneID:  83 - Gigas Jack
-- ZoneID:  83 - Gigas Marine

-- ZoneID: 157 - Gigas Wallwatcher
-- ZoneID: 157 - Gigas Kettlemaster

-- ZoneID: 136 - Gigas Flesher
-- ZoneID: 137 - Gigas Flogger
-- ZoneID: 137 - Gigas Hurler

-- ZoneID: 173 - Gigas Foreman
-- ZoneID: 173 - Gigas Stonecarrier
-- ZoneID: 173 - Gigas Stonegrinder
-- ZoneID: 173 - Gigas Stonemason

-- 989-1000 Available

-- ZoneID: 169 - Girtab

-- ZoneID:  54 - Seneschal Imp
-- ZoneID:  58 - Imp
-- ZoneID:  59 - Imp
-- ZoneID:  77 - Imp
-- ZoneID:  77 - Heraldic Imp
-- ZoneID:  79 - Orderly Imp
-- ZoneID:  85 - Seneschal Imp
-- ZoneID:  92 - Seneschal Imp
-- ZoneID:  99 - Seneschal Imp
-- ZoneID: 136 - Glacial Imp
-- ZoneID: 137 - Ruly Imp
-- ZoneID: 138 - Errand Imp
-- ZoneID: 155 - Errand Imp
INSERT INTO `mob_droplist` VALUES (1002,0,0,1000,2163,@COMMON); -- Imp Wing (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1002,0,0,1000,2157,@RARE);   -- Imp Horn (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1002,4,0,1000,2163,0);       -- Imp Wing (Despoil)

-- ZoneID:   5 - Glacier Eater

-- ZoneID: 254 - Glade Wivre

-- ZoneID:  83 - Duriumshell
-- ZoneID: 173 - Lacerator
-- ZoneID: 176 - Robber Crab
-- ZoneID: 176 - Greatclaw
-- ZoneID: 254 - Glen Crab

-- ZoneID:  88 - Gloomanita

-- ZoneID: 147 - Gloop

-- ZoneID:  97 - Gnat
-- ZoneID:  98 - Gnat
-- ZoneID:  99 - Gnat

-- ZoneID: 217 - Gnawtooth Gary -- TODO: Abyssea NM

-- ZoneID:  15 - Gneiss Leech

-- ZoneID:  83 - Gnole
-- ZoneID:  84 - Gnole

-- ZoneID: 212 - Goblinsavior Heronox

-- ZoneID:  88 - Goblin Aidman

-- ZoneID:   9 - Goblin Alchemist
-- ZoneID: 174 - Goblin Alchemist
-- ZoneID: 205 - Goblin Alchemist
-- ZoneID: 212 - Goblin Alchemist
-- ZoneID: 213 - Goblin Alchemist

-- ZoneID: 113 - Goblin Alchemist

 -- 1016 Available

-- ZoneID: 102 - Goblin Ambusher
-- ZoneID: 103 - Goblin Ambusher
-- ZoneID: 104 - Goblin Ambusher
-- ZoneID: 108 - Goblin Ambusher
-- ZoneID: 109 - Goblin Ambusher
-- ZoneID: 117 - Goblin Ambusher
-- ZoneID: 118 - Goblin Ambusher
-- ZoneID: 119 - Goblin Ambusher

-- ZoneID: 192 - Goblin Trailblazer
-- ZoneID: 193 - Goblin Ambusher
-- ZoneID: 194 - Goblin Ambusher
-- ZoneID: 198 - Goblin Ambusher

-- ZoneID: 190 - Goblin Ambusher

-- ZoneID: 191 - Goblin Ambusher

-- ZoneID: 102 - Goblin Archaeologist
-- ZoneID: 108 - Goblin Archaeologist
-- ZoneID: 117 - Goblin Archaeologist

-- ZoneID:   9 - Goblin Bandit
-- ZoneID: 113 - Goblin Bandit
-- ZoneID: 174 - Goblin Bandit
-- ZoneID: 205 - Goblin Bandit
-- ZoneID: 213 - Goblin Bandit

-- ZoneID:  82 - Goblin Bombardier
-- ZoneID:  97 - Goblin Bombardier

-- ZoneID:   4 - Hobgoblin Animalier
-- ZoneID:   4 - Hobgoblin Fascinator
-- ZoneID:   4 - Hobgoblin Toreador
-- ZoneID:  83 - Goblin Flagman
-- ZoneID:  84 - Goblin Corpsman
-- ZoneID:  84 - Goblin Blastmaster
-- ZoneID:  89 - Goblin Corpsman
-- ZoneID:  89 - Goblin Blastmaster
-- ZoneID:  90 - Goblin Flagman
-- ZoneID:  98 - Goblin Flagman
-- ZoneID: 175 - Goblin Blastmaster
-- ZoneID: 175 - Goblin Corpsman

-- ZoneID:  82 - Goblin Field Doctor
-- ZoneID:  97 - Goblin Field Doctor

-- ZoneID: 191 - Goblin Bladesmith

-- ZoneID:   9 - Goblin Bouncer
-- ZoneID: 124 - Goblin Bouncer
-- ZoneID: 125 - Goblin Bouncer

-- ZoneID: 162 - Goblin Bouncer

-- ZoneID: 213 - Goblin Bouncer

-- ZoneID: 103 - Goblin Bounty Hunter
-- ZoneID: 105 - Goblin Bounty Hunter
-- ZoneID: 118 - Goblin Bounty Hunter
-- ZoneID: 120 - Goblin Bounty Hunter
-- ZoneID: 126 - Goblin Bounty Hunter
-- ZoneID: 126 - Goblin Bounty Hunter
-- ZoneID: 173 - Goblin Bounty Hunter

-- ZoneID: 191 - Goblin Bushwhacker

-- ZoneID: 102 - Goblin Tinkerer
-- ZoneID: 102 - Goblin Butcher
-- ZoneID: 103 - Goblin Butcher
-- ZoneID: 103 - Goblin Tinkerer
-- ZoneID: 104 - Goblin Tinkerer
-- ZoneID: 104 - Goblin Butcher
-- ZoneID: 108 - Goblin Butcher
-- ZoneID: 108 - Goblin Tinkerer
-- ZoneID: 109 - Goblin Tinkerer
-- ZoneID: 109 - Goblin Butcher
-- ZoneID: 117 - Goblin Tinkerer
-- ZoneID: 117 - Goblin Butcher
-- ZoneID: 118 - Goblin Tinkerer
-- ZoneID: 118 - Goblin Butcher
-- ZoneID: 119 - Goblin Tinkerer
-- ZoneID: 119 - Goblin Butcher

-- ZoneID: 190 - Goblin Butcher

-- ZoneID: 191 - Goblin Butcher

-- ZoneID: 191 - Goblin Headsman
-- ZoneID: 192 - Goblin Flesher
-- ZoneID: 192 - Goblin Metallurgist
-- ZoneID: 194 - Goblin Tinkerer
-- ZoneID: 194 - Goblin Butcher
-- ZoneID: 193 - Goblin Tinkerer
-- ZoneID: 193 - Goblin Butcher
-- ZoneID: 198 - Goblin Tinkerer
-- ZoneID: 198 - Goblin Butcher

-- ZoneID:  88 - Goblin Chapman

-- ZoneID:  12 - Goblin Collector

-- ZoneID: 191 - Goblin Conjurer

-- ZoneID: 100 - Goblin Digger
-- ZoneID: 101 - Goblin Digger
-- ZoneID: 102 - Goblin Digger
-- ZoneID: 106 - Goblin Digger
-- ZoneID: 107 - Goblin Digger
-- ZoneID: 108 - Goblin Digger
-- ZoneID: 115 - Goblin Digger
-- ZoneID: 116 - Goblin Digger
-- ZoneID: 117 - Goblin Digger

-- ZoneID: 103 - Goblin Digger
-- ZoneID: 104 - Goblin Digger
-- ZoneID: 105 - Goblin Digger
-- ZoneID: 109 - Goblin Digger
-- ZoneID: 110 - Goblin Digger
-- ZoneID: 118 - Goblin Digger
-- ZoneID: 119 - Goblin Digger
-- ZoneID: 120 - Goblin Digger
-- ZoneID: 123 - Goblin Digger

-- 1041 Available

-- ZoneID: 114 - Goblin Digger
-- ZoneID: 124 - Goblin Digger
-- ZoneID: 125 - Goblin Digger

-- ZoneID:  11 - Goblin Doorman

-- ZoneID:  81 - Goblin Draftee
-- ZoneID:  88 - Goblin Draftee
-- ZoneID:  91 - Goblin Draftee
-- ZoneID:  95 - Goblin Draftee

-- 1045-1046 Available

-- ZoneID:   9 - Goblin Enchanter
-- ZoneID: 125 - Goblin Enchanter

-- ZoneID: 162 - Goblin Enchanter

-- ZoneID: 213 - Goblin Enchanter

-- ZoneID:  12 - Goblin Fireman
-- ZoneID:  12 - Goblin Packman

-- ZoneID: 100 - Goblin Fisher
-- ZoneID: 101 - Goblin Fisher
-- ZoneID: 102 - Goblin Fisher
-- ZoneID: 106 - Goblin Fisher
-- ZoneID: 107 - Goblin Fisher
-- ZoneID: 115 - Goblin Fisher
-- ZoneID: 116 - Goblin Fisher

-- ZoneID: 191 - Goblin Fisher

-- ZoneID:  83 - Goblin Flagman
-- ZoneID:  90 - Goblin Flagman
-- ZoneID:  98 - Goblin Flagman

-- 1054-1055 Available

-- ZoneID:  83 - Goblin Guerrilla
-- ZoneID:  90 - Goblin Guerrilla
-- ZoneID:  98 - Goblin Guerrilla

-- ZoneID:  12 - Goblin Foreman
-- ZoneID:  12 - Goblin Lengthman

-- ZoneID:  81 - Goblin Franctireur
-- ZoneID:  88 - Goblin Franctireur
-- ZoneID:  91 - Goblin Franctireur
-- ZoneID:  95 - Goblin Franctireur

-- 1059 Available

-- ZoneID:  88 - Goblin Freelance

-- ZoneID:  11 - Goblin Freelance

-- ZoneID:  82 - Orcish Dragonbrander
-- ZoneID:  85 - Orcish Dragonbrander
-- ZoneID:  85 - Orcish Warlord
-- ZoneID:  85 - Orcish Wyrmbrander
-- ZoneID: 138 - Orcish Champion
-- ZoneID: 138 - Orcish Dragonbrander
-- ZoneID: 138 - Orcish Warlord
-- ZoneID: 155 - Orcish Wyrmbrander

-- ZoneID:   4 - Hobgoblin Martialist
-- ZoneID:  84 - Goblin Freesword
-- ZoneID:  89 - Goblin Freesword
-- ZoneID: 175 - Goblin Freesword

-- ZoneID:   7 - Goblin Furrier
-- ZoneID: 105 - Goblin Furrier
-- ZoneID: 110 - Goblin Furrier
-- ZoneID: 111 - Goblin Furrier
-- ZoneID: 120 - Goblin Furrier
-- ZoneID: 121 - Goblin Furrier
-- ZoneID: 123 - Goblin Furrier

-- ZoneID: 157 - Goblin Furrier
-- ZoneID: 166 - Goblin Tanner

-- ZoneID: 193 - Goblin Furrier

-- ZoneID: 198 - Goblin Furrier

-- 1068-1080 Available

-- ZoneID: 103 - Goblin Gambler
-- ZoneID: 104 - Goblin Gambler
-- ZoneID: 105 - Goblin Gambler
-- ZoneID: 106 - Goblin Gambler
-- ZoneID: 109 - Goblin Gambler
-- ZoneID: 110 - Goblin Gambler
-- ZoneID: 118 - Goblin Gambler
-- ZoneID: 119 - Goblin Gambler
-- ZoneID: 120 - Goblin Gambler
-- ZoneID: 121 - Goblin Gambler

-- ZoneID: 166 - Goblin Gambler
-- ZoneID: 184 - Goblin Gambler
-- ZoneID: 193 - Goblin Gambler
-- ZoneID: 198 - Goblin Gambler

-- ZoneID: 190 - Goblin Gambler

-- ZoneID: 192 - Goblin Gambler

-- ZoneID: 188 - Goblin Golem

-- ZoneID:  83 - Goblin Grenadier
-- ZoneID:  90 - Goblin Grenadier
-- ZoneID:  98 - Goblin Grenadier

-- ZoneID: 190 - Goblin Gruel

-- ZoneID:  11 - Goblin Gutterman

-- ZoneID:  11 - Goblin Hammerman

-- ZoneID:  12 - Goblin Hangman

-- ZoneID:  12 - Goblin Headman
-- ZoneID:  12 - Goblin Marksman

-- ZoneID:   9 - Goblin Hunter
-- ZoneID: 124 - Goblin Hunter
-- ZoneID: 125 - Goblin Hunter

-- ZoneID: 162 - Goblin Hunter

-- ZoneID: 213 - Goblin Hunter

-- ZoneID:   9 - Goblin Jeweler

-- ZoneID:  12 - Goblin Junkman

-- ZoneID:  11 - Goblin Leadman

-- ZoneID: 103 - Goblin Leecher
-- ZoneID: 104 - Goblin Leecher
-- ZoneID: 105 - Goblin Leecher
-- ZoneID: 106 - Goblin Leecher
-- ZoneID: 109 - Goblin Leecher
-- ZoneID: 110 - Goblin Leecher
-- ZoneID: 118 - Goblin Leecher
-- ZoneID: 119 - Goblin Leecher
-- ZoneID: 120 - Goblin Leecher
-- ZoneID: 121 - Goblin Leecher

-- ZoneID: 166 - Goblin Leecher
-- ZoneID: 184 - Goblin Leecher
-- ZoneID: 193 - Goblin Leecher
-- ZoneID: 198 - Goblin Leecher

-- ZoneID: 190 - Goblin Leecher

-- ZoneID: 192 - Goblin Leecher

-- ZoneID: 134 - Hydra Warrior (Higher Level)

-- ZoneID: 134 - Hydra Bard (Higher Level)

-- ZoneID: 134 - Hydra Monk (Higher Level)
-- ZoneID: 134 - Hydra Ninja (Higher Level)

-- ZoneID: 135 - Kindred Dark Knight (Higher Level)
-- ZoneID: 135 - Kindred Red Mage (Higher Level)
-- ZoneID: 135 - Kindred Samurai (Higher Level)

-- ZoneID: 135 - Kindred Bard (Higher Level)
-- ZoneID: 135 - Kindred Ninja (Higher Level)
-- ZoneID: 135 - Kindred Summoner (Higher Level)
-- ZoneID: 135 - Kindred Warrior (Higher Level)

-- ZoneID: 135 - Kindred Dragoon (Higher Level)
-- ZoneID: 135 - Kindred Monk (Higher Level)
-- ZoneID: 135 - Kindred Thief (Higher Level)
-- ZoneID: 135 - Kindred White Mage (Higher Level)

-- ZoneID: 135 - Kindred Beastmaster (Higher Level)
-- ZoneID: 135 - Kindred Black Mage (Higher Level)
-- ZoneID: 135 - Kindred Paladin (Higher Level)
-- ZoneID: 135 - Kindred Ranger (Higher Level)

-- 1109-1112 Available

-- ZoneID: 254 - Goblin Meatgrinder

-- ZoneID:   9 - Goblin Mercenary
-- ZoneID: 113 - Goblin Mercenary

-- ZoneID: 174 - Goblin Mercenary
-- ZoneID: 205 - Goblin Mercenary
-- ZoneID: 212 - Goblin Mercenary
-- ZoneID: 213 - Goblin Mercenary

-- ZoneID: 213 - Goblin Miner

-- ZoneID: 103 - Goblin Mugger
-- ZoneID: 104 - Goblin Mugger
-- ZoneID: 105 - Goblin Mugger
-- ZoneID: 106 - Goblin Mugger
-- ZoneID: 109 - Goblin Mugger
-- ZoneID: 110 - Goblin Mugger
-- ZoneID: 118 - Goblin Mugger
-- ZoneID: 119 - Goblin Mugger
-- ZoneID: 120 - Goblin Mugger
-- ZoneID: 121 - Goblin Mugger

-- ZoneID: 190 - Goblin Mugger

-- ZoneID: 166 - Goblin Mugger
-- ZoneID: 184 - Goblin Mugger
-- ZoneID: 191 - Goblin Brigand
-- ZoneID: 193 - Goblin Mugger
-- ZoneID: 198 - Goblin Mugger

-- ZoneID: 192 - Goblin Mugger

-- ZoneID:  11 - Goblin Oilman

-- ZoneID:  82 - Goblin Paratrooper
-- ZoneID:  97 - Goblin Paratrooper

-- ZoneID:   4 - Goblin Pathfinder
-- ZoneID: 105 - Goblin Pathfinder
-- ZoneID: 110 - Goblin Pathfinder
-- ZoneID: 111 - Goblin Pathfinder
-- ZoneID: 120 - Goblin Pathfinder
-- ZoneID: 124 - Goblin Pathfinder

-- ZoneID: 157 - Goblin Pathfinder
-- ZoneID: 166 - Goblin Chaser

-- ZoneID: 193 - Goblin Pathfinder

-- ZoneID: 198 - Goblin Pathfinder

-- 1127-1133 Available

-- ZoneID:  81 - Goblin Patrolman
-- ZoneID:  88 - Goblin Patrolman
-- ZoneID:  91 - Goblin Patrolman
-- ZoneID:  95 - Goblin Patrolman

-- ZoneID:  82 - Goblin Picket
-- ZoneID:  97 - Goblin Picket

-- ZoneID:  84 - Goblin Pioneer
-- ZoneID:  89 - Goblin Pioneer
-- ZoneID:  96 - Goblin Pioneer
-- ZoneID: 175 - Goblin Pioneer

-- ZoneID: 254 - Goblin Plunderer

-- ZoneID:   7 - Goblin Poacher
-- ZoneID: 111 - Goblin Poacher
-- ZoneID: 114 - Goblin Poacher
-- ZoneID: 123 - Goblin Poacher
-- ZoneID: 124 - Goblin Poacher

-- ZoneID: 161 - Goblin Poacher
-- ZoneID: 162 - Goblin Poacher
-- ZoneID: 212 - Goblin Poacher
-- ZoneID: 213 - Goblin Poacher

-- ZoneID: 121 - Goblin Poacher

-- ZoneID: 161 - Goblin Reaper
-- ZoneID: 162 - Goblin Reaper
-- ZoneID: 212 - Goblin Reaper
-- ZoneID: 213 - Goblin Reaper

-- ZoneID:   7 - Goblin Reaper
-- ZoneID: 111 - Goblin Reaper
-- ZoneID: 114 - Goblin Reaper
-- ZoneID: 121 - Goblin Reaper
-- ZoneID: 123 - Goblin Reaper
-- ZoneID: 124 - Goblin Reaper

-- ZoneID:  39 - Goblin Replica
-- ZoneID:  39 - Goblin Replica
-- ZoneID:  40 - Goblin Replica
-- ZoneID:  40 - Goblin Replica
-- ZoneID:  41 - Goblin Replica
-- ZoneID:  41 - Goblin Replica
-- ZoneID:  42 - Goblin Replica
-- ZoneID:  42 - Vanguard Eye

-- ZoneID: 188 - Goblin Replica
-- ZoneID: 188 - Goblin Replica

-- ZoneID:   7 - Goblin Robber
-- ZoneID: 111 - Goblin Robber
-- ZoneID: 114 - Goblin Robber
-- ZoneID: 123 - Goblin Robber
-- ZoneID: 124 - Goblin Robber

-- ZoneID: 121 - Goblin Robber

-- ZoneID: 161 - Goblin Robber
-- ZoneID: 162 - Goblin Robber
-- ZoneID: 212 - Goblin Robber
-- ZoneID: 213 - Goblin Robber

-- ZoneID:   4 - Goblin Shaman
-- ZoneID:   7 - Goblin Pathfinder
-- ZoneID:   7 - Goblin Shaman
-- ZoneID: 105 - Goblin Shaman
-- ZoneID: 110 - Goblin Shaman
-- ZoneID: 111 - Goblin Shaman
-- ZoneID: 120 - Goblin Shaman
-- ZoneID: 124 - Goblin Shaman

-- ZoneID: 157 - Goblin Shaman
-- ZoneID: 166 - Goblin Hoodoo

-- ZoneID: 193 - Goblin Shaman

-- ZoneID: 198 - Goblin Shaman

-- 1152-1155 Available

-- ZoneID:   9 - Goblin Veterinarian
-- ZoneID: 113 - Goblin Shepherd
-- ZoneID: 205 - Goblin Shepherd
-- ZoneID: 212 - Goblin Shepherd
-- ZoneID: 213 - Goblin Shepherd

-- ZoneID:  11 - Goblin Shovelman

-- ZoneID:  81 - Goblin Skirmisher
-- ZoneID:  88 - Goblin Skirmisher
-- ZoneID:  91 - Goblin Skirmisher
-- ZoneID:  95 - Goblin Skirmisher

-- 1159-1161 Available

-- ZoneID:   7 - Goblin Smithy
-- ZoneID:  11 - Goblin Craftsman
-- ZoneID: 105 - Goblin Smithy
-- ZoneID: 110 - Goblin Smithy
-- ZoneID: 111 - Goblin Smithy
-- ZoneID: 120 - Goblin Smithy
-- ZoneID: 121 - Goblin Smithy
-- ZoneID: 123 - Goblin Smithy
-- ZoneID: 124 - Goblin Smithy

-- ZoneID: 157 - Goblin Smithy
-- ZoneID: 166 - Goblin Artificer

-- ZoneID: 193 - Goblin Smithy

-- ZoneID: 198 - Goblin Smithy

-- ZoneID:  12 - Goblin Swordsman

-- ZoneID:  12 - Goblins Bat
-- ZoneID:  12 - Goblins Bat

-- ZoneID: 174 - Goblin Tamer

-- ZoneID: 100 - Goblin Thug
-- ZoneID: 101 - Goblin Thug
-- ZoneID: 102 - Goblin Thug
-- ZoneID: 106 - Goblin Thug
-- ZoneID: 107 - Goblin Thug
-- ZoneID: 108 - Goblin Thug
-- ZoneID: 115 - Goblin Thug
-- ZoneID: 116 - Goblin Thug
-- ZoneID: 117 - Goblin Thug

-- ZoneID: 166 - Goblin Thug
-- ZoneID: 190 - Goblin Thug
-- ZoneID: 191 - Goblin Thug
-- ZoneID: 192 - Goblin Thug
-- ZoneID: 192 - Goblin Lurcher
-- ZoneID: 194 - Goblin Thug

-- 1171-1174 Available

-- ZoneID: 190 - Goblin Tinkerer

-- ZoneID: 191 - Goblin Tinkerer

-- ZoneID:  11 - Goblin Tollman

-- ZoneID:  83 - Goblin Toxophilite
-- ZoneID:  90 - Goblin Toxophilite
-- ZoneID:  98 - Goblin Toxophilite

-- ZoneID:   7 - Goblin Trader
-- ZoneID: 111 - Goblin Trader
-- ZoneID: 114 - Goblin Trader
-- ZoneID: 124 - Goblin Trader

-- ZoneID: 161 - Goblin Trader
-- ZoneID: 162 - Goblin Trader
-- ZoneID: 213 - Goblin Trader

-- ZoneID: 121 - Goblin Trader

-- ZoneID: 100 - Goblin Weaver
-- ZoneID: 101 - Goblin Weaver
-- ZoneID: 102 - Goblin Weaver
-- ZoneID: 106 - Goblin Weaver
-- ZoneID: 107 - Goblin Weaver
-- ZoneID: 108 - Goblin Weaver
-- ZoneID: 115 - Goblin Weaver
-- ZoneID: 117 - Goblin Weaver
-- ZoneID: 116 - Goblin Weaver

-- ZoneID: 166 - Goblin Weaver
-- ZoneID: 190 - Goblin Weaver
-- ZoneID: 191 - Goblin Weaver
-- ZoneID: 192 - Goblin Weaver
-- ZoneID: 194 - Goblin Weaver

-- 1184-1187 Available

-- ZoneID: 125 - Goblin Welldigger

-- ZoneID:  11 - Goblin Wolfman

-- ZoneID:  27 - Gloop
-- ZoneID: 166 - Ooze
-- ZoneID: 193 - Jelly
-- ZoneID: 194 - Fuligo
-- ZoneID: 198 - Jelly

-- ZoneID: 103 - Golden Bat

-- ZoneID:  90 - Gold Quadav
-- ZoneID:  90 - Vajra Quadav
-- ZoneID:  92 - Gold Quadav
-- ZoneID:  92 - Vajra Quadav

-- ZoneID: 162 - Gold Quadav

-- ZoneID: 147 - Gold Quadav

-- ZoneID: 204 - Goliath

-- ZoneID: 193 - Goliath Beetle

-- ZoneID:  90 - Goobbue
-- ZoneID:  91 - Goobbue Farmer

-- ZoneID: 109 - Goobbue

-- 1199 Available

-- ZoneID: 110 - Goobbue Farmer

-- ZoneID: 121 - Goobbue Gardener

-- 1201 Available

-- ZoneID:  74 - Goobbue Wanderer
-- ZoneID:  74 - Seasonal Treant
INSERT INTO `mob_droplist` VALUES (1203,0,0,1000,5376,@UNCOMMON); -- Pannus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1203,0,0,1000,5377,@UNCOMMON); -- Fractus Cell (Uncommon, 10%)

-- ZoneID: 216 - Gore Bats

-- ZoneID:   5 - Gore Demon

-- ZoneID: 161 - Gore Demon

-- ZoneID:  18 - Gorger
-- ZoneID:  18 - Gorger
-- ZoneID:  18 - Gorger
-- ZoneID:  18 - Gorger

-- ZoneID:  22 - Gorger
-- ZoneID:  22 - Gorger
-- ZoneID:  22 - Gorger
-- ZoneID:  22 - Gorger

-- ZoneID:  40 - Gosspix Blabberlips

-- ZoneID:  51 - Gotoh Zha The Redolent

-- ZoneID: 134 - Goublefaupe

-- ZoneID: 132 - Grandgousier -- TODO: Abyssea NM

-- ZoneID: 161 - Grand Duke Batym

-- 1214 Available

-- ZoneID: 215 - Granite Borer -- TODO: Abyssea NM

-- ZoneID: 137 - Graoully

-- ZoneID: 102 - Grass Funguar

-- 1218 Available

-- ZoneID:  89 - Grauberg Hippogryph

-- 1220 Available

-- ZoneID: 190 - Grave Bat

-- ZoneID:  77 - Greatclaw
INSERT INTO `mob_droplist` VALUES (1222,0,0,1000,936,@COMMON); -- Chunk Of Rock Salt (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1222,0,0,1000,4400,@RARE);  -- Slice Of Land Crab Meat (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1222,0,0,1000,881,@VRARE);  -- Crab Shell (Very Rare, 1%)

-- 1223 Available

-- ZoneID: 137 - Greater Amphiptere

-- ZoneID:  52 - Locus Colibri

-- ZoneID: 127 - Greater Gayla

-- 1227 Available

-- ZoneID: 113 - Greater Manticore
-- ZoneID: 128 - Valley Manticore

-- 1229-1231 Available

-- ZoneID: 196 - Greater Pugil Fished
-- ZoneID: 196 - Greater Pugil

-- ZoneID:  88 - Greater Quadav
-- ZoneID:  88 - Veteran Quadav
-- ZoneID:  88 - Young Quadav
-- ZoneID:  89 - Greater Quadav
-- ZoneID:  89 - Veteran Quadav
-- ZoneID:  89 - Young Quadav

-- ZoneID: 108 - Greater Quadav

-- ZoneID: 109 - Veteran Quadav
-- ZoneID: 109 - Greater Quadav

-- ZoneID: 143 - Greater Quadav

-- 1237 Available

-- ZoneID:  68 - Great Ameretat

-- ZoneID: 132 - Great Wasp

-- 1240 Available

-- ZoneID: 176 - Grotto Pugil

-- ZoneID: 130 - Groundskeeper
-- ZoneID: 130 - Groundskeeper

-- ZoneID: 217 - Gruesome Gargouille

-- ZoneID: 197 - Guardian Crawler

-- ZoneID: 200 - Guardian Statue

-- ZoneID:  79 - Guard Bhoot

-- 1247 Available

-- ZoneID:  46 - Gugru Crab
-- ZoneID:  47 - Gugru Crab
-- ZoneID:  54 - Wootzshell Fished
-- ZoneID:  57 - Wootzshell Fished
-- ZoneID:  61 - Sicklemoon Crab

-- 1249 Available

-- ZoneID:  15 - Guimauve -- TODO: Abyssea NM

-- ZoneID:  93 - Guivre
INSERT INTO `mob_droplist` VALUES (1251,0,0,1000,909,@ALWAYS);   -- Guivres Skull (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1251,0,0,1000,11288,@COMMON); -- Zahaks Mail (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1251,0,0,1000,19212,@COMMON); -- Black Tathlum (Common, 15%)

-- ZoneID: 174 - Guivre

-- ZoneID: 216 - Gukumatz -- TODO: Abyssea NM

-- ZoneID:  45 - Gulch Limule
-- ZoneID:  45 - Gulch Limule

-- ZoneID: 215 - Gullycampa

-- ZoneID:  45 - Gully Clionid
-- ZoneID:  45 - Gully Clionid

-- ZoneID:  65 - Gulool Ja Ja

-- ZoneID:  15 - Gunge Slug

-- ZoneID:  62 - Gurfurlur The Menacing

-- ZoneID:   9 - Gyre-Carlin

-- ZoneID:  77 - Gyre-Carlin
INSERT INTO `mob_droplist` VALUES (1261,0,0,1000,1626,@VRARE); -- Bottle Of Avatar Blood (Very Rare, 1%)

-- ZoneID:  76 - Gyroscopic Gear
INSERT INTO `mob_droplist` VALUES (1262,0,0,1000,14974,@ALWAYS);  -- Anus Gages (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1262,0,0,1000,5735,@UNCOMMON); -- Cotton Coin Purse (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1262,0,0,1000,14968,70);       -- Freyas Gloves (7.0%)

-- ZoneID:  76 - Gyroscopic Gears
INSERT INTO `mob_droplist` VALUES (1263,0,0,1000,5735,@ALWAYS);  -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1263,0,0,1000,16085,@ALWAYS); -- Enyos Mask (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1263,0,0,1000,2488,740);      -- Piece Of Alexandrite (74.0%)
INSERT INTO `mob_droplist` VALUES (1263,0,0,1000,15628,30);      -- Deimoss Cuisses (3.0%)

-- ZoneID: 187 - Haa Pevi The Stentorian
-- ZoneID: 187 - Loo Hepe The Eyepiercer
-- ZoneID: 187 - Xoo Kaza The Solemn
-- ZoneID: 187 - Wuu Qoho The Razorclaw

-- ZoneID: 159 - Habetrot

-- ZoneID: 132 - Hadal Gigas

-- ZoneID:  15 - Hadal Satiator -- TODO: Abyssea NM

-- ZoneID: 132 - Hadhayosh -- TODO: Abyssea NM

-- 1269 Available

-- ZoneID: 160 - Hakutaku

-- ZoneID:  40 - Hamfist Gukhbuk

-- ZoneID:  76 - Hammerblow Majanun
INSERT INTO `mob_droplist` VALUES (1272,0,0,1000,5735,@ALWAYS); -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1272,0,0,1000,16095,80);     -- Hikazu Kabuto (8.0%)

-- ZoneID: 132 - Hammering Ram

-- ZoneID: 215 - Hannequet
-- ZoneID: 215 - Hannequet

-- ZoneID: 217 - Hanuman -- TODO: Abyssea NM

-- ZoneID:   3 - Harajnite

-- ZoneID: 208 - Hastatus Xi-Xii

-- ZoneID: 190 - Hati
-- ZoneID: 190 - Locus Hati

-- ZoneID:  51 - Haunt
-- ZoneID:  52 - Haunt

-- ZoneID: 167 - Haunt

-- ZoneID: 174 - Haunt

-- ZoneID: 195 - Haunt

-- 1283 Available

-- ZoneID:  85 - Hawkeyed Dnatbat

-- ZoneID: 149 - Hawkeyed Dnatbat

-- ZoneID: 218 - Hazhdiha -- TODO: Abyssea NM

-- ZoneID:   7 - Hecteyes

-- ZoneID: 166 - Hecteyes

-- ZoneID: 218 - Hedjedjet -- TODO: Abyssea NM

-- 1290 Available

-- ZoneID:  30 - Heliodromos

-- ZoneID: 118 - Helldiver

-- ZoneID: 213 - Hellion

-- ZoneID: 204 - Hellish Weapon

-- ZoneID: 200 - Hellmine

-- ZoneID: 200 - Kaboom

-- ZoneID: 195 - Nekros Hound

-- ZoneID: 197 - Helm Beetle

-- ZoneID: 208 - Helm Beetle

-- ZoneID: 217 - Helter-Skelter

-- ZoneID: 216 - Heqet -- TODO: Abyssea NM

-- ZoneID:  54 - Heraldic Imp
-- ZoneID:  79 - Heraldic Imp

-- ZoneID:   2 - Hercules Beetle

-- ZoneID:  15 - Hexenpilz -- TODO: Abyssea NM

-- ZoneID:  45 - Hieracosphinx

-- ZoneID:  15 - Highland Treant

-- ZoneID:  15 - Highland Rafflesia

-- ZoneID:  61 - Hilltroll Dark Knight

-- ZoneID:  61 - Hilltroll Monk
-- ZoneID:  61 - Hilltroll Ranger

-- ZoneID:  61 - Hilltroll Paladin
-- ZoneID:  62 - Troll Targeteer

-- ZoneID:  61 - Hilltroll Puppetmaster

-- ZoneID:  61 - Hilltroll Red Mage

-- ZoneID:  61 - Hilltroll Warrior

-- ZoneID:  97 - Hill Lizard
-- ZoneID:  98 - Hill Lizard
-- ZoneID: 120 - Hill Lizard

-- ZoneID: 140 - Watch Lizard

-- ZoneID: 103 - Hill Lizard

-- ZoneID: 119 - Hill Lizard

-- 1318 Available

-- ZoneID:  30 - Hippogryph

-- 1320 Available

-- ZoneID: 253 - Hoarmite

-- ZoneID:  15 - Hoary Ragwort

-- 1323-1326 Available

-- ZoneID:   4 - Hobgoblin Venerer

-- 1328 Available

-- ZoneID: 145 - Hoo Mjuu The Torrent

-- ZoneID: 197 - Hornfly

-- ZoneID: 159 - Hover Tank

-- ZoneID: 217 - Hrosshvalur -- TODO: Abyssea NM

-- ZoneID:  51 - Hydra

-- ZoneID: 106 - Huge Hornet
-- ZoneID: 107 - Huge Hornet

-- ZoneID: 173 - Huge Spider

-- ZoneID: 102 - Huge Wasp
-- ZoneID: 108 - Huge Wasp

-- ZoneID:  65 - Hundredfaced Hapool Ja

-- ZoneID: 141 - Hundredscar Hajwaj

-- ZoneID:   7 - Hunter Antlion

-- ZoneID: 205 - Hurricane Wyvern

-- ZoneID: 151 - Huu Xalmo The Savage

-- ZoneID:  42 - Hydra Warrior
-- ZoneID:  42 - Hydra Red Mage
-- ZoneID:  42 - Hydra Paladin
-- ZoneID:  42 - Hydra Ninja
-- ZoneID:  42 - Hydra Monk
-- ZoneID:  42 - Hydra White Mage
-- ZoneID:  42 - Hydra Beastmaster
-- ZoneID:  42 - Hydra Black Mage
-- ZoneID:  42 - Hydra Dark Knight
-- ZoneID:  42 - Hydra Bard
-- ZoneID:  42 - Hydra Dragoon
-- ZoneID:  42 - Hydra Thief
-- ZoneID:  42 - Hydra Ranger
-- ZoneID:  42 - Hydra Samurai
-- ZoneID:  42 - Hydra Summoner

-- ZoneID: 134 - Hydra Warrior (Lower Level)
-- ZoneID: 134 - Hydra Red Mage (Lower Level)
-- ZoneID: 134 - Hydra Paladin (Lower Level)

-- ZoneID: 134 - Hydra Bard (Lower Level)
-- ZoneID: 134 - Hydra White Mage (Lower Level)
-- ZoneID: 134 - Hydra Black Mage (Lower Level)

-- ZoneID: 134 - Hydra Monk (Lower Level)
-- ZoneID: 134 - Hydra Ninja (Lower Level)
-- ZoneID: 134 - Hydra Thief (Lower Level)

-- ZoneID: 138 - Icefall

-- ZoneID:   5 - Ice Elemental
-- ZoneID:   5 - Ice Elemental
-- ZoneID:   5 - Ice Elemental
-- ZoneID:   9 - Ice Elemental
-- ZoneID:  54 - Ice Elemental
-- ZoneID:  84 - Ice Elemental
-- ZoneID: 105 - Ice Elemental
-- ZoneID: 111 - Ice Elemental
-- ZoneID: 112 - Ice Elemental
-- ZoneID: 130 - Ice Elemental
-- ZoneID: 136 - Ice Elemental
-- ZoneID: 137 - Ice Elemental
-- ZoneID: 138 - Ice Elemental
-- ZoneID: 161 - Ice Elemental
-- ZoneID: 175 - Ice Elemental
-- ZoneID: 177 - Ice Elemental
-- ZoneID: 178 - Ice Elemental
-- ZoneID: 195 - Ice Elemental
-- ZoneID: 204 - Ice Elemental

-- ZoneID: 198 - Ichorous Ire

-- ZoneID: 123 - Bayawak

-- ZoneID:  16 - Idle Wanderer
-- ZoneID:  16 - Livid Seether
-- ZoneID:  16 - Woeful Weeper
-- ZoneID:  18 - Idle Wanderer
-- ZoneID:  18 - Livid Seether
-- ZoneID:  18 - Woeful Weeper
-- ZoneID:  20 - Idle Wanderer
-- ZoneID:  20 - Livid Seether
-- ZoneID:  20 - Woeful Weeper
-- ZoneID:  22 - Idle Wanderer
-- ZoneID:  22 - Livid Seether
-- ZoneID:  22 - Woeful Weeper

-- 1351 Available

-- ZoneID:  29 - Ignidrake

-- ZoneID: 215 - Ignis Eruca

-- 1354 Available

-- ZoneID: 254 - Ika-Roa -- TODO: Abyssea NM

-- ZoneID: 217 - Iktomi -- TODO: Abyssea NM

-- ZoneID: 217 - Iku-Turso -- TODO: Abyssea NM

-- ZoneID:  29 - Imdugud

-- ZoneID:  99 - Immolatory Pugil

-- ZoneID: 253 - Impervious Chariot -- TODO: Abyssea NM

-- ZoneID: 169 - Impish Bats

-- 1362 Available

-- ZoneID: 253 - Indrik -- TODO: Abyssea NM

-- ZoneID:   4 - Intulo

-- ZoneID: 215 - Inugami

-- ZoneID: 132 - Irate Sheep

-- ZoneID:  65 - Iriri Samariri

-- ZoneID:  51 - Iriz Ima

-- ZoneID: 215 - Ironclad Cleaver -- TODO: Abyssea NM

-- ZoneID: 216 - Ironclad Observer -- TODO: Abyssea NM

-- ZoneID: 216 - Ironclad Pulverizer -- TODO: Abyssea NM

-- ZoneID: 216 - Ironclad Severer -- TODO: Abyssea NM

-- ZoneID: 218 - Ironclad Smiter -- TODO: Abyssea NM

-- ZoneID: 254 - Ironclad Sunderer -- TODO: Abyssea NM

-- ZoneID: 253 - Ironclad Triturator -- TODO: Abyssea NM

-- ZoneID: 176 - Ironshell

-- ZoneID: 159 - Iron Maiden

-- ZoneID: 162 - Steel Quadav

-- ZoneID: 132 - Irrlicht -- TODO: Abyssea NM

-- ZoneID: 253 - Isgebind -- TODO: Abyssea NM

-- ZoneID: 215 - Itzpapalotl -- TODO: Abyssea NM

-- ZoneID: 123 - Ivory Lizard

-- ZoneID: 158 - Ixtab

-- ZoneID: 194 - Jack Of Batons

-- ZoneID: 194 - Jack Of Coins

-- ZoneID: 194 - Jack Of Cups

-- ZoneID: 194 - Jack Of Swords

-- ZoneID: 254 - Jaculus -- TODO: Abyssea NM

-- ZoneID:  51 - Jaded Jody

-- ZoneID: 100 - Jaggedy-Eared Jack

-- 1391-1394 Available

-- ZoneID:  45 - Jaguarundi

-- ZoneID:  35 - Jailer Of Faith

-- ZoneID:  35 - Jailer Of Fortitude

-- ZoneID:  33 - Jailer Of Hope

-- ZoneID:  33 - Jailer Of Justice

-- ZoneID:  33 - Jailer Of Love

-- ZoneID:  33 - Jailer Of Prudence

-- ZoneID:  34 - Jailer Of Temperance

-- ZoneID:  73 - Jakko
INSERT INTO `mob_droplist` VALUES (1403,0,0,1000,14551,@ALWAYS); -- Njords Jerkin (Always, 100%)

-- 1404 Available

-- ZoneID: 217 - Jasconius

-- ZoneID:  95 - Jeduah

-- ZoneID: 167 - Dark Aspic
-- ZoneID: 167 - Mousse
-- ZoneID: 173 - Jelly

-- ZoneID:  54 - Jnun
-- ZoneID:  79 - Jnun

-- ZoneID: 109 - Jolly Green

-- ZoneID:   5 - Jormungand

-- ZoneID: 158 - Jotunn Gatekeeper

-- ZoneID: 158 - Jotunn Hallkeeper

-- ZoneID: 158 - Jotunn Wallkeeper

-- ZoneID: 158 - Jotunn Wildkeeper

-- ZoneID:   5 - Judicator Demon

-- ZoneID: 161 - Judicator Demon

-- ZoneID: 196 - Juggler Hecatomb

-- ZoneID:  82 - Jugner Funguar

-- ZoneID: 104 - Jugner Funguar

-- ZoneID: 123 - Jungle Coeurl

-- ZoneID: 145 - Juu Duzu The Whirlwind

-- ZoneID: 217 - Kadraeth The Hatespawn -- TODO: Abyssea NM

-- ZoneID: 215 - Kampe -- TODO: Abyssea NM

-- ZoneID: 217 - Karkadann -- TODO: Abyssea NM

-- ZoneID: 216 - Karkatakam -- TODO: Abyssea NM

-- ZoneID: 132 - Karkinos -- TODO: Abyssea NM

-- 1427 Available

-- ZoneID: 121 - Keeper Of Halidom

-- ZoneID: 132 - Keesha Poppo -- TODO: Abyssea NM

-- ZoneID:  15 - Keratyrannos -- TODO: Abyssea NM

-- ZoneID:  28 - Keremet

-- ZoneID: 217 - Ketea -- TODO: Abyssea NM

-- ZoneID:  15 - Khalamari -- TODO: Abyssea NM

-- ZoneID: 217 - Khalkotaur -- TODO: Abyssea NM

-- ZoneID: 215 - Kharon -- TODO: Abyssea NM

-- 1436 Available

-- ZoneID:  79 - Khimaira

-- ZoneID:  61 - Khromasoul Bhurborlor

-- ZoneID:  68 - Mycohopper
-- ZoneID: 197 - Killer Mushroom

-- ZoneID: 197 - Olid Funguar

-- ZoneID:  42 - Kindred Monk
-- ZoneID:  42 - Kindred Black Mage
-- ZoneID:  42 - Kindred Beastmaster
-- ZoneID:  42 - Kindred White Mage
-- ZoneID:  42 - Kindred Dark Knight
-- ZoneID:  42 - Kindred Ranger
-- ZoneID:  42 - Kindred Red Mage
-- ZoneID:  42 - Kindred Paladin
-- ZoneID:  42 - Kindred Samurai
-- ZoneID:  42 - Kindred Warrior
-- ZoneID:  42 - Kindred Thief
-- ZoneID:  42 - Kindred Summoner
-- ZoneID:  42 - Kindred Bard
-- ZoneID:  42 - Kindred Ninja
-- ZoneID:  42 - Kindred Dragoon

-- ZoneID: 135 - Kindred Paladin (Lower Level)
-- ZoneID: 135 - Kindred Dark Knight (Lower Level)
-- ZoneID: 135 - Kindred Beastmaster (Lower Level)
-- ZoneID: 135 - Kindred Ranger (Lower Level)
-- ZoneID: 135 - Kindred Bard (Lower Level)
-- ZoneID: 135 - Kindred Samurai (Lower Level)
-- ZoneID: 135 - Kindred Ninja (Lower Level)
-- ZoneID: 135 - Kindred Summoner (Lower Level)
-- ZoneID: 135 - Kindred Dragoon (Lower Level)
-- ZoneID: 135 - Kindred White Mage (Lower Level)
-- ZoneID: 135 - Kindred Black Mage (Lower Level)
-- ZoneID: 135 - Kindred Red Mage (Lower Level)
-- ZoneID: 135 - Kindred Warrior (Lower Level)
-- ZoneID: 135 - Kindred Monk (Lower Level)
-- ZoneID: 135 - Kindred Thief (Lower Level)

-- ZoneID:   5 - Kindred Black Mage

-- ZoneID:   5 - Kindred Warrior
-- ZoneID:   5 - Kindred Dark Knight

-- ZoneID:   5 - Kindred Summoner

-- ZoneID:  90 - Kinepikwa

-- ZoneID:  61 - Zhayolm Apkallu
-- ZoneID:  61 - King Apkallu

-- ZoneID:  86 - King Arthro
INSERT INTO `mob_droplist` VALUES (1448,0,0,1000,16178,@VCOMMON); -- Avalon Shield (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1448,0,0,1000,11286,@VCOMMON); -- Avalon Breastplate (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1448,0,0,1000,836,@RARE);      -- Square Of Damascene Cloth (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1448,0,0,1000,12924,@RARE);    -- Magic Cuisses (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1448,0,0,1000,15899,@RARE);    -- Velocious Belt (Rare, 5%)

-- ZoneID: 104 - King Arthro

-- ZoneID: 127 - King Behemoth

-- ZoneID: 125 - King Vinegarroon

-- ZoneID: 135 - King Zagan

-- ZoneID: 111 - Kirata

-- ZoneID:  62 - Kirlirger The Abhorrent

-- ZoneID:  96 - Kirtimukha

-- ZoneID: 153 - Knight Crawler

-- ZoneID: 197 - Knight Crawler

-- ZoneID:  89 - Knotty Treant

-- ZoneID: 253 - Koghatu -- TODO: Abyssea NM

-- ZoneID: 218 - Koios -- TODO: Abyssea NM

-- ZoneID:  40 - Koo Rahi The Levinblade

-- ZoneID:  74 - Korrigan
INSERT INTO `mob_droplist` VALUES (1463,0,0,1000,5378,@UNCOMMON); -- Congestus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1463,0,0,1000,5379,@UNCOMMON); -- Nimbus Cell (Uncommon, 10%)

-- ZoneID:  57 - Lahama Fished
-- ZoneID:  84 - Kraken Fished
-- ZoneID: 105 - Kraken Fished
-- ZoneID: 111 - Kraken Fished
-- ZoneID: 120 - Kraken Fished
-- ZoneID: 173 - Kraken Fished

-- ZoneID: 126 - Kraken Fished Nm

-- ZoneID: 113 - Kreutzet

-- ZoneID: 174 - Kuftal Digger

-- ZoneID:  15 - Kukulkan -- TODO: Abyssea NM

-- ZoneID: 253 - Kur -- TODO: Abyssea NM

-- ZoneID:  24 - Kurrea

-- ZoneID: 216 - Kutharei -- TODO: Abyssea NM

-- ZoneID: 213 - Labyrinth Leech

-- ZoneID:   9 - Labyrinth Lizard

-- ZoneID: 197 - Labyrinth Lizard

-- ZoneID:  77 - Manticore
-- ZoneID: 213 - Labyrinth Manticore
INSERT INTO `mob_droplist` VALUES (1475,0,0,1000,1163,@VCOMMON);  -- Lock Of Manticore Hair (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1475,0,0,1000,1116,@UNCOMMON); -- Manticore Hide (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1475,0,0,1000,1123,@RARE);     -- Manticore Fang (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1475,4,0,1000,1116,0);         -- Manticore Hide (Despoil)
INSERT INTO `mob_droplist` VALUES (1475,4,0,1000,1163,0);         -- Lock Of Manticore Hair (Despoil)

-- ZoneID: 198 - Labyrinth Scorpion

-- ZoneID: 174 - Ladon

-- ZoneID:  81 - Ladybug

-- ZoneID: 176 - Lagoon Sahagin

-- ZoneID: 176 - Lake Sahagin

-- ZoneID:  86 - Lambton Worm
-- ZoneID:  93 - Lambton Worm
-- ZoneID: 129 - Lambton Worm
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,11285,@VCOMMON); -- Morganas Cotehardie (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,16275,@VCOMMON); -- Ancient Torque (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,16344,@VCOMMON); -- Oily Trousers (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,17751,@VCOMMON); -- Fragarach (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,909,@COMMON);    -- Guivres Skull (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,901,@COMMON);    -- Venomous Claw (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1481,0,0,1000,836,@COMMON);    -- Square Of Damascene Cloth (Common, 15%)

-- ZoneID:  54 - Lahama
-- ZoneID:  54 - Lahama Fished

-- 1483 Available

-- ZoneID:  45 - Lamenter

-- ZoneID:  54 - Lamia Bellydancer
-- ZoneID:  54 - Lamia Deathdancer
-- ZoneID:  54 - Lamie Necromancer
-- ZoneID:  54 - Lamie Bellydancer
-- ZoneID:  54 - Lamie Deathdancer
-- ZoneID:  54 - Lamie Toxophilite

-- ZoneID:  79 - Lamia Chaukidar

-- ZoneID:  54 - Lamia Dartist
-- ZoneID:  54 - Lamia Dancer
-- ZoneID:  54 - Lamia Graverobber

-- ZoneID:  74 - Lamia Graverobber
-- ZoneID:  74 - Lamia Dancer
-- ZoneID:  74 - Merrow Shadowdancer
INSERT INTO `mob_droplist` VALUES (1488,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1488,0,0,1000,5384,@UNCOMMON); -- Spissatus Cell (Uncommon, 10%)

-- ZoneID:  74 - Lamia Dartist
INSERT INTO `mob_droplist` VALUES (1489,0,0,1000,5365,@UNCOMMON); -- Incus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1489,0,0,1000,5371,@UNCOMMON); -- Undulatus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1489,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)

-- ZoneID:  54 - Lamia Fatedealer
-- ZoneID:  79 - Lamia Fatedealer

-- ZoneID:  74 - Lamia Fatedealer
-- ZoneID:  74 - Merrow Icedancer
INSERT INTO `mob_droplist` VALUES (1491,0,0,1000,5371,@UNCOMMON); -- Undulatus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1491,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)

-- ZoneID:  54 - Lamia Idolater Drk
-- ZoneID:  54 - Lamia Idolater Blm

-- ZoneID:  79 - Lamia Idolater Drk
-- ZoneID:  79 - Lamia Idolater Blm

-- ZoneID:  54 - Lamia Necromancer
-- ZoneID:  79 - Lamia Necromancer

-- ZoneID:  54 - Lamia Toxophilite
-- ZoneID:  54 - Lamie Toxophilite
-- ZoneID:  79 - Lamia Toxophilite

-- 1496 Available

-- ZoneID: 192 - Nocuous Weapon

-- 1498-1501 Available

-- ZoneID: 132 - La Theine Liege -- TODO: Abyssea NM, figure out the rest of the drops. Sharpeye Mantle is also guessed.

-- ZoneID:  84 - La Velue

-- ZoneID: 107 - Leaping Lizzy

-- ZoneID: 198 - Leech King

-- ZoneID: 190 - Locus Lemures

-- ZoneID:  15 - Lentor -- TODO: Abyssea NM

-- ZoneID:  15 - Lesser Arimaspi -- TODO: Abyssea NM - Yellow proc for drops. Unknown rate or grouping without proc.
-- INSERT INTO `mob_droplist` VALUES (1508,0,0,1000,1740,@SRARE); -- Iolite (Super Rare, 0.5%)
-- INSERT INTO `mob_droplist` VALUES (1508,0,0,1000,1294,@SRARE); -- Spool Of Arachne Thread (Super Rare, 0.5%)
-- INSERT INTO `mob_droplist` VALUES (1508,0,0,1000,1633,@SRARE); -- Handful Of Clot Plasma (Super Rare, 0.5%)

-- ZoneID:  51 - Lesser Colibri
-- ZoneID:  52 - Lesser Colibri

-- ZoneID:  77 - Lesser Colibri
INSERT INTO `mob_droplist` VALUES (1510,0,0,1000,2150,@COMMON); -- Colibri Feather (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1510,0,0,1000,2171,@RARE);   -- Colibri Beak (Rare, 5%)

-- ZoneID: 121 - Lesser Gaylas

-- ZoneID: 127 - Lesser Gaylas
-- ZoneID: 169 - Canal Bats

-- 1513 Available

-- ZoneID:  29 - Lesser Roc

-- ZoneID:  88 - Lesser Wivre

-- ZoneID:  15 - Ley Clionid
-- ZoneID:  15 - Ley Clionid

-- ZoneID: 125 - Lich

-- ZoneID: 195 - Lich

-- 1519 Available

-- ZoneID:  15 - Licorice

-- ZoneID: 126 - Light Elemental
-- ZoneID: 127 - Light Elemental
-- ZoneID: 130 - Light Elemental
-- ZoneID: 157 - Light Elemental
-- ZoneID: 158 - Light Elemental
-- ZoneID: 184 - Light Elemental

-- ZoneID: 161 - Likho

-- ZoneID:  54 - Lil Apkallu

-- ZoneID: 216 - Limestone Hare

-- ZoneID: 205 - Lindwurm

-- ZoneID:  52 - Lividroot Amooshah

-- 1527 Available

-- ZoneID:  54 - Llamhigyn Y Dwr
-- ZoneID:  57 - Llamhigyn Y Dwr
-- ZoneID:  77 - Hellion
-- ZoneID:  77 - Tainted Flesh
-- ZoneID:  79 - Llamhigyn Y Dwr
INSERT INTO `mob_droplist` VALUES (1528,0,0,1000,940,@COMMON);   -- Revival Tree Root (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1528,0,0,1000,849,@UNCOMMON); -- Undead Skin (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1528,4,0,1000,849,0);         -- Undead Skin (Despoil)

-- 1529-1530 Available

-- ZoneID:  76 - Long-Armed Chariot
INSERT INTO `mob_droplist` VALUES (1531,0,0,1000,5736,@COMMON); -- Linen Coin Purse (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1531,1,1,@ALWAYS,14979,166); -- Bodbs Cuffs (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,1,@ALWAYS,14552,166); -- Freyrs Jerkin (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,1,@ALWAYS,15639,166); -- Eas Brais (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,1,@ALWAYS,16090,166); -- Freyrs Mask (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,1,@ALWAYS,15721,166); -- Tsukikazu Sune-Ate (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,1,@ALWAYS,14963,166); -- Phoboss Gauntlets (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,2,@ALWAYS,14979,166); -- Bodbs Cuffs (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,2,@ALWAYS,14552,166); -- Freyrs Jerkin (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,2,@ALWAYS,15639,166); -- Eas Brais (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,2,@ALWAYS,16090,166); -- Freyrs Mask (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,2,@ALWAYS,15721,166); -- Tsukikazu Sune-Ate (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1531,1,2,@ALWAYS,14963,166); -- Phoboss Gauntlets (Group 2, Always, 100%)

-- ZoneID: 218 - Long-Barreled Chariot -- TODO: Abyssea NM

-- ZoneID:  75 - Long-Bowed Chariot
INSERT INTO `mob_droplist` VALUES (1533,0,0,1000,5736,@COMMON); -- Linen Coin Purse (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,15635,166); -- Tsukikazu Haidate (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,15717,166); -- Freyrs Ledelsens (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,16086,166); -- Phoboss Mask (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,14975,166); -- Eas Dastanas (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,14548,166); -- Phoboss Cuirass (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,16102,166); -- Bodbs Crown (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,1,@ALWAYS,14564,166); -- Bodbs Robe (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,15635,166); -- Tsukikazu Haidate (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,15717,166); -- Freyrs Ledelsens (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,16086,166); -- Phoboss Mask (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,14975,166); -- Eas Dastanas (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,14548,166); -- Phoboss Cuirass (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,16102,166); -- Bodbs Crown (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (1533,1,2,@ALWAYS,14564,166); -- Bodbs Robe (Group 2, Always, 100%)

-- ZoneID:  24 - Leshy

-- ZoneID:  99 - Loo Kutto The Pensive

-- ZoneID: 213 - Lord Of Onzozo

-- ZoneID: 217 - Lord Varney -- TODO: Abyssea NM

-- ZoneID: 254 - Lorelei -- TODO: Abyssea NM

-- ZoneID: 112 - Lost Soul War
-- ZoneID: 112 - Lost Soul Blm

-- 1540 Available

-- ZoneID: 127 - Lost Soul Blm
-- ZoneID: 127 - Lost Soul War

 -- 1542 Available

-- ZoneID:  90 - Lou Carcolh

-- 1544 Available

-- ZoneID: 132 - Lugarhoo -- TODO: Abyssea NM

-- 1546 Available

-- ZoneID: 132 - Luison

-- ZoneID: 102 - Lumbering Lambert

-- ZoneID: 105 - Lumber Jack

-- ZoneID:  29 - Lunantishee

-- ZoneID: 215 - Lusca -- TODO: Abyssea NM

-- ZoneID:  84 - Lycopodium
-- ZoneID:  91 - Lycopodium
-- ZoneID:  95 - Tiny Lycopodium
-- ZoneID:  96 - Lycopodium
-- ZoneID:  97 - Lycopodium
-- ZoneID:  98 - Lycopodium

-- 1553-1555 Available

-- ZoneID:  40 - Lyncean Juwgneg

-- ZoneID:  97 - Lynx
-- ZoneID:  98 - Lynx

-- 1558 Available

-- ZoneID: 215 - Maahes -- TODO: Abyssea NM

-- ZoneID: 174 - Machairodus

-- ZoneID:  99 - Maa Illmu The Bestower

-- 1563-1564 Available

-- ZoneID: 254 - Maere -- TODO: Abyssea NM

-- ZoneID: 122 - Magic Flagon

-- ZoneID: 200 - Magic Jug

-- ZoneID:   9 - Magic Millstone

-- ZoneID: 157 - Magic Pot

-- ZoneID: 158 - Magic Pot

-- ZoneID: 158 - Magic Urn

-- ZoneID: 184 - Magic Urn

-- ZoneID: 205 - Magma

-- 1573 Available

-- ZoneID:  92 - Magnes Quadav
-- ZoneID: 138 - Magnes Quadav

-- ZoneID:  27 - Mahisha

-- ZoneID:  79 - Mahjlaef The Paintorn

-- ZoneID:  77 - Maighdean Uaine
-- ZoneID:  77 - Tottering Toby
INSERT INTO `mob_droplist` VALUES (1577,0,0,1000,953,@COMMON); -- Treant Bulb (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1577,0,0,1000,574,@RARE);   -- Bag Of Fruit Seeds (Rare, 5%)

-- ZoneID: 106 - Maighdean Uaine

-- 1579-1582 Available

-- ZoneID:   9 - Maledict Millstone

-- ZoneID: 192 - Maltha

-- ZoneID:  31 - Mammet-19 Epsilon
-- ZoneID:  32 - Mammet-22 Zeta

-- ZoneID:  31 - Mammet-800

-- ZoneID:  52 - Mamool Ja Blusterer
-- ZoneID:  52 - Mamool Ja Philosopher
-- ZoneID:  65 - Mamool Ja Blusterer
-- ZoneID:  65 - Mamool Ja Philosopher

-- ZoneID:  51 - Mamool Ja Bounder
-- ZoneID:  51 - Mamool Ja Mimicker
-- ZoneID:  51 - Mamool Ja Zenist
-- ZoneID:  65 - Mamool Ja Bounder
-- ZoneID:  65 - Mamool Ja Mimicker
-- ZoneID:  65 - Mamool Ja Spearman
-- ZoneID:  65 - Mamool Ja Strapper

-- ZoneID:  73 - Mamool Ja Bounder
INSERT INTO `mob_droplist` VALUES (1589,0,0,1000,5366,@ALWAYS);  -- Castellanus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1589,0,0,1000,5367,@VCOMMON); -- Cumulus Cell (Very Common, 24%)

-- ZoneID:  65 - Mamool Ja Frogman
-- ZoneID:  65 - Mamool Ja Diver

-- ZoneID:  52 - Mamool Ja Infiltrator
-- ZoneID:  52 - Mamool Ja Pikeman
-- ZoneID:  65 - Mamool Ja Infiltrator
-- ZoneID:  65 - Mamool Ja Pikeman

-- ZoneID:  52 - Mamool Ja Lurker
-- ZoneID:  52 - Mamool Ja Mimer
-- ZoneID:  65 - Mamool Ja Lurker
-- ZoneID:  65 - Mamool Ja Mimer

-- ZoneID:  51 - Mamool Ja Sophist
-- ZoneID:  51 - Mamool Ja Savant
-- ZoneID:  51 - Mamool Ja Zenist
-- ZoneID:  65 - Mamool Ja Savant
-- ZoneID:  65 - Mamool Ja Sophist
-- ZoneID:  65 - Mamool Ja Strapper
-- ZoneID:  65 - Mamool Ja Zenist

-- ZoneID:  52 - Mamool Ja Stabler
-- ZoneID:  65 - Mamool Ja Stabler

-- ZoneID:  73 - Mamool Ja Zenist
-- ZoneID:  74 - Orobon
INSERT INTO `mob_droplist` VALUES (1595,0,0,1000,5367,@UNCOMMON); -- Cumulus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1595,0,0,1000,5368,@UNCOMMON); -- Radiatus Cell (Uncommon, 10%)

-- ZoneID: 115 - Mandragora
-- ZoneID: 116 - Mandragora

-- ZoneID: 187 - Vanguard Salvager (Higher Level)
-- ZoneID: 187 - Vanguard Visionary (Higher Level)
-- ZoneID: 187 - Vanguard Inciter (Higher Level)
-- ZoneID: 187 - Vanguard Oracle (Higher Level)

-- ZoneID: 187 - Vanguard Prelate (Higher Level)
-- ZoneID: 187 - Vanguard Exemplar (Higher Level)
-- ZoneID: 187 - Vanguard Liberator (Higher Level)
-- ZoneID: 187 - Vanguard Partisan (Higher Level)

-- ZoneID: 187 - Vanguard Priest (Higher Level)
-- ZoneID: 187 - Vanguard Assassin (Higher Level)
-- ZoneID: 187 - Vanguard Chanter (Higher Level)

-- ZoneID: 187 - Vanguard Skirmisher (Higher Level)
-- ZoneID: 187 - Vanguard Sentinel (Higher Level)
-- ZoneID: 187 - Vanguard Ogresoother (Higher Level)
-- ZoneID: 187 - Vanguard Persecutor (Higher Level)

-- ZoneID: 186 - Vanguard Vindicator (Higher Level)
-- ZoneID: 186 - Vanguard Kusa (Higher Level)
-- ZoneID: 186 - Vanguard Defender (Higher Level)

-- ZoneID: 186 - Vanguard Militant (Higher Level)
-- ZoneID: 186 - Vanguard Drakekeeper (Higher Level)
-- ZoneID: 186 - Vanguard Vigilante (Higher Level)
-- ZoneID: 186 - Vanguard Hatamoto (Higher Level)

-- ZoneID: 186 - Vanguard Constable (Higher Level)
-- ZoneID: 186 - Vanguard Beasttender (Higher Level)
-- ZoneID: 186 - Vanguard Purloiner (Higher Level)
-- ZoneID: 186 - Vanguard Undertaker (Higher Level)

-- ZoneID: 186 - Vanguard Thaumaturge (Higher Level)
-- ZoneID: 186 - Vanguard Protector (Higher Level)
-- ZoneID: 186 - Vanguard Minstrel (Higher Level)
-- ZoneID: 186 - Vanguard Mason (Higher Level)

-- 1605-1610 Available

-- ZoneID: 105 - Prankster Maverix

-- ZoneID: 132 - Mangy-Tailed Marvin -- TODO: Abyssea NM

-- ZoneID:  39 - Manifest Icon
-- ZoneID:  39 - Manifest Icon
-- ZoneID:  40 - Manifest Icon
-- ZoneID:  40 - Manifest Icon
-- ZoneID:  41 - Manifest Icon
-- ZoneID:  41 - Manifest Icon
-- ZoneID:  42 - Manifest Icon

-- ZoneID: 218 - Manigordo

-- ZoneID: 159 - Manipulator

-- ZoneID: 216 - Manohra -- TODO: Abyssea NM

-- ZoneID: 103 - Marchelute

-- ZoneID:  51 - Grand Marid
-- ZoneID:  51 - Marid
-- ZoneID:  52 - Grand Marid
-- ZoneID:  52 - Marid

-- ZoneID:  77 - Marid
INSERT INTO `mob_droplist` VALUES (1618,0,0,1000,2151,@COMMON); -- Marid Hide (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1618,0,0,1000,2166,@RARE);   -- Lock Of Marid Hair (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1618,2,0,1000,2155,0);       -- Lesser Chigoe (Steal)

-- ZoneID:  85 - Mariehene

-- ZoneID:   4 - Marine Dhalmel

-- ZoneID: 216 - Maritime Peiste

-- ZoneID: 161 - Marquis Allocen

-- ZoneID: 161 - Marquis Amon

-- ZoneID: 135 - Marquis Andras

-- ZoneID: 135 - Marquis Cimeries

-- ZoneID: 135 - Marquis Decarabia

-- ZoneID:  99 - Marquis Forneus

-- ZoneID: 135 - Marquis Gamygyn

-- ZoneID: 135 - Marquis Nebiros

-- ZoneID: 135 - Marquis Orias

-- ZoneID: 135 - Marquis Sabnak

-- ZoneID:   2 - Marsh Funguar
-- ZoneID: 109 - Marsh Funguar

-- 1633 Available

-- ZoneID:  77 - Helldiver
-- ZoneID:  77 - Marsh Murre
-- ZoneID:  77 - Nunyenunc
INSERT INTO `mob_droplist` VALUES (1634,0,0,1000,2503,@VCOMMON); -- Handful Of Almonds (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (1634,0,0,1000,847,@COMMON);   -- Bird Feather (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1634,0,0,1000,4570,@RARE);    -- Bird Egg (Rare, 5%)

-- ZoneID:  79 - Marsh Murre
-- ZoneID:  79 - Slough Skua

-- ZoneID: 176 - Marsh Sahagin

-- ZoneID: 176 - Masan

-- ZoneID:   7 - Master Coeurl

-- ZoneID: 121 - Master Coeurl
-- ZoneID: 124 - Master Coeurl

-- ZoneID: 127 - Master Coeurl

-- ZoneID: 197 - Matron Crawler
-- ZoneID: 197 - Queen Crawler

-- 1642 Available

-- ZoneID: 196 - Mauthe Doog

-- ZoneID:   9 - Maze Lizard

-- ZoneID: 197 - Maze Lizard

-- 1646 Available

-- ZoneID: 198 - Maze Scorpion

-- 1648 Available

-- ZoneID: 151 - Meat Maggot

-- ZoneID: 253 - Mechanical Menace

-- ZoneID:  54 - Medusa

-- ZoneID: 151 - Mee Deggi The Punisher

-- ZoneID:  24 - Megalobugard

-- ZoneID: 132 - Megamaw Mikey -- TODO: Abyssea NM

-- ZoneID: 132 - Megantereon -- TODO: Abyssea NM

-- ZoneID: 254 - Melo Melo -- TODO: Abyssea NM

-- ZoneID:  54 - Merrow Songstress
-- ZoneID:  54 - Merrow Bladedancer
-- ZoneID:  54 - Merrow Wavedancer
-- ZoneID:  54 - Merrow Typhoondancer
-- ZoneID:  54 - Nix Bladedancer
-- ZoneID:  54 - Nix Songstress
-- ZoneID:  54 - Nix Wavedancer
-- ZoneID:  54 - Nix Typhoondancer

-- ZoneID:  54 - Merrow Chantress
-- ZoneID:  54 - Merrow Icedancer
-- ZoneID:  54 - Merrow Kabukidancer
-- ZoneID:  54 - Merrow Shadowdancer

-- ZoneID:  74 - Merrow Chantress
INSERT INTO `mob_droplist` VALUES (1659,0,0,1000,5371,@UNCOMMON); -- Undulatus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1659,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)

-- ZoneID:  74 - Merrow Kabukidancer
INSERT INTO `mob_droplist` VALUES (1660,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1660,0,0,1000,5384,@UNCOMMON); -- Spissatus Cell (Uncommon, 10%)

-- 1661-1662 Available

-- ZoneID:  15 - Mesa Wivre

-- ZoneID: 104 - Meteormauler Zhagtegg

-- ZoneID:  92 - Meteor Quadav

-- ZoneID: 123 - Meww The Turtlerider

-- 1667-1668 Available

-- ZoneID: 215 - Mielikki -- TODO: Abyssea NM

-- ZoneID: 118 - Mighty Rarab

-- ZoneID:  74 - Migrant Russula
INSERT INTO `mob_droplist` VALUES (1671,0,0,1000,5366,@UNCOMMON); -- Castellanus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1671,0,0,1000,5381,@UNCOMMON); -- Pileus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1671,0,0,1000,5384,@UNCOMMON); -- Spissatus Cell (Uncommon, 10%)

-- ZoneID: 134 - Mildaunegeux

-- ZoneID: 160 - Million Eyes

-- ZoneID: 158 - Mimas

-- ZoneID:  12 - Mimic

-- ZoneID: 130 - Mimic

-- ZoneID: 147 - Mimic

-- ZoneID: 150 - Mimic

-- ZoneID: 151 - Mimic

-- ZoneID: 153 - Mimic

-- ZoneID: 159 - Mimic

-- ZoneID: 160 - Mimic

-- ZoneID: 161 - Mimic

-- ZoneID: 169 - Mimic

-- ZoneID: 174 - Mimic

-- ZoneID: 176 - Mimic

-- ZoneID: 177 - Mimic

-- ZoneID: 195 - Mimic

-- ZoneID: 197 - Mimic

-- ZoneID: 200 - Mimic

-- ZoneID: 205 - Mimic

-- ZoneID: 208 - Mimic

-- ZoneID: 254 - Minaruja -- TODO: Abyssea NM

-- ZoneID: 216 - Minax Bugard -- TODO: Abyssea NM

-- ZoneID: 169 - Mindcraver

-- ZoneID: 176 - Mindgazer

-- 1697 Available

-- ZoneID: 143 - Mine Scorpion

-- ZoneID: 123 - Mischievous Micholas

-- ZoneID: 204 - Miser Murphy

-- ZoneID: 108 - Mist Lizard

-- ZoneID:  11 - Moblin Ashman

-- ZoneID:  12 - Moblin Aidman
-- ZoneID:  12 - Moblin Aidman

-- ZoneID:  62 - Moblin Billionaire

-- ZoneID:  11 - Moblin Chapman

-- ZoneID:  11 - Moblin Coalman
-- ZoneID:  11 - Moblin Gasman
-- ZoneID:  11 - Moblin Pikeman
-- ZoneID:  11 - Moblin Repairman

-- ZoneID:  12 - Moblin Draftsman

-- ZoneID:  12 - Moblin Engineman
-- ZoneID:  12 - Moblin Engineman

-- ZoneID:  12 - Moblin Groundman

-- ZoneID:  11 - Moblin Gurneyman

-- ZoneID:  62 - Moblin Millionaire

-- ZoneID:  11 - Moblin Pickman
-- ZoneID:  11 - Moblin Ragman

-- ZoneID:  12 - Moblin Roadman

-- ZoneID:  11 - Moblin Rodman

-- ZoneID:  12 - Moblin Scalpelman

-- ZoneID:  12 - Moblin Tankman

-- ZoneID:  12 - Moblin Topsman

-- ZoneID:  11 - Moblin Witchman

-- ZoneID:  12 - Moblin Workman
-- ZoneID:  12 - Moblin Yardman

-- 1720-1729 Available

-- ZoneID: 151 - Moo Ouzi The Swiftblade

-- ZoneID: 161 - Morbid Eye
-- ZoneID: 162 - Morbid Eye

-- 1732-1733 Available

-- ZoneID:  85 - Morbol

-- ZoneID: 149 - Morbol

-- ZoneID: 193 - Morbolger

-- ZoneID:  15 - Morboling

-- ZoneID: 153 - Morbol Menace

-- ZoneID: 173 - Morion Worm

-- ZoneID: 217 - Morose Marid

-- ZoneID:  79 - Mosshorn

-- ZoneID: 153 - Moss Eater

-- ZoneID:  97 - Mountain Scolopendrid
-- ZoneID:  97 - Scolopendrid
-- ZoneID: 164 - Scolopendrid

-- ZoneID:   5 - Mountain Worm

-- ZoneID:  74 - Mourioche
INSERT INTO `mob_droplist` VALUES (1745,0,0,1000,5382,@UNCOMMON); -- Mediocris Cell (Uncommon, 10%)

-- ZoneID: 153 - Mourioche

-- 1747-1749 Available

-- ZoneID: 160 - Mousse Fished
-- ZoneID: 160 - Mousse

-- ZoneID: 169 - Mousse Fished
-- ZoneID: 169 - Mousse

-- ZoneID: 176 - Mouu The Waverider

-- ZoneID: 195 - Mummy

-- ZoneID:  28 - Mummy

-- ZoneID: 215 - Murrain Chigoe

-- ZoneID: 197 - Mushussu

-- ZoneID: 213 - Mushussu

-- 1758 Available

-- ZoneID:  68 - Mycoskulker

-- ZoneID: 196 - Myconid

-- ZoneID:   2 - Mycophile

-- ZoneID: 215 - Myriadeyes

-- ZoneID: 213 - Mysticmaker Profblix

-- ZoneID: 177 - Mystic Weapon

-- 1765 Available

-- ZoneID:  62 - Mythril Mouth Monamaq

-- ZoneID:  90 - Mythril Quadav

-- ZoneID: 147 - Mythril Quadav

-- ZoneID: 162 - Mythril Quadav

-- ZoneID: 121 - Myxomycete

-- ZoneID: 190 - Nachzehrer War
-- ZoneID: 190 - Nachzehrer Blm

-- ZoneID: 132 - Nahn -- TODO: Abyssea NM

-- ZoneID: 176 - Namtar

-- ZoneID: 218 - Nannakola

-- ZoneID: 193 - Napalm

-- ZoneID: 213 - Narasimha

-- ZoneID: 216 - Nehebkau -- TODO: Abyssea NM

-- ZoneID: 197 - Nest Beetle

-- ZoneID: 132 - Nguruvilu

-- ZoneID:  90 - Nickel Quadav

-- ZoneID: 154 - Nidhogg

-- ZoneID:  12 - Nightmare Bats

-- ZoneID: 176 - Nightmare Bats
-- ZoneID: 205 - Nightmare Bats

-- ZoneID:  42 - Nightmare Taurus

-- ZoneID:  40 - Nightmare Bunny (Lower Level)
-- ZoneID:  40 - Nightmare Mandragora (Lower Level)
-- ZoneID:  40 - Nightmare Eft (Lower Level)

-- ZoneID:  42 - Nightmare Cluster

-- ZoneID:  40 - Nightmare Crab (Lower Level)
-- ZoneID:  40 - Nightmare Dhalmel (Lower Level)
-- ZoneID:  40 - Nightmare Scorpion (Lower Level)

-- ZoneID:  40 - Nightmare Uragnite (Lower Level)
-- ZoneID:  40 - Nightmare Crawler (Lower Level)
-- ZoneID:  40 - Nightmare Raven (Lower Level)

-- ZoneID:  40 - Nightmare Bunny (Higher Level)
-- ZoneID:  40 - Nightmare Mandragora (Higher Level)
-- ZoneID:  40 - Nightmare Eft (Higher Level)

-- ZoneID:  41 - Nightmare Tiger (Lower Level)
-- ZoneID:  41 - Nightmare Diremite (Lower Level)
-- ZoneID:  41 - Nightmare Raptor (Lower Level)

-- ZoneID:  40 - Nightmare Crab (Higher Level)
-- ZoneID:  40 - Nightmare Dhalmel (Higher Level)
-- ZoneID:  40 - Nightmare Scorpion (Higher Level)

-- ZoneID:  39 - Nightmare Fly (Lower Level)
-- ZoneID:  39 - Nightmare Funguar (Lower Level)
-- ZoneID:  39 - Nightmare Flytrap (Lower Level)

-- ZoneID:  41 - Nightmare Kraken (Lower Level)
-- ZoneID:  41 - Nightmare Gaylas (Lower Level)
-- ZoneID:  41 - Nightmare Roc (Lower Level)

-- ZoneID:  39 - Nightmare Hippogryph (Lower Level)
-- ZoneID:  39 - Nightmare Sabotender (Lower Level)
-- ZoneID:  39 - Nightmare Sheep (Lower Level)

-- ZoneID:  42 - Nightmare Bugard
-- ZoneID:  42 - Nightmare Hornet

-- ZoneID:  42 - Nightmare Leech

-- ZoneID:  42 - Nightmare Makara

-- ZoneID:  40 - Nightmare Uragnite (Higher Level)
-- ZoneID:  40 - Nightmare Crawler (Higher Level)
-- ZoneID:  40 - Nightmare Raven (Higher Level)

-- ZoneID:  39 - Nightmare Manticore (Lower Level)
-- ZoneID:  39 - Nightmare Treant (Lower Level)
-- ZoneID:  39 - Nightmare Goobbue (Lower Level)

-- ZoneID:  41 - Nightmare Tiger (Higher Level)
-- ZoneID:  41 - Nightmare Diremite (Higher Level)
-- ZoneID:  41 - Nightmare Raptor (Higher Level)

-- ZoneID:   5 - Mountain Worm Nm

-- ZoneID:  40 - Lost Aitvaras

-- ZoneID:  41 - Nightmare Snoll (Lower Level)
-- ZoneID:  41 - Nightmare Stirge (Lower Level)
-- ZoneID:  41 - Nightmare Weapon (Lower Level)

-- ZoneID:  41 - Nightmare Snoll (Higher Level)
-- ZoneID:  41 - Nightmare Stirge (Higher Level)
-- ZoneID:  41 - Nightmare Weapon (Higher Level)

-- ZoneID:  40 - Lost Alklha

-- ZoneID: 122 - Nightmare Vase

-- ZoneID:  42 - Nightmare Worm

-- ZoneID: 215 - Nightshade -- TODO: Abyssea NM

-- ZoneID: 102 - Nihniknoovi

-- ZoneID:  29 - Nimbus Hippogryph

-- ZoneID: 194 - Nine Of Batons

-- ZoneID: 194 - Nine Of Coins

-- ZoneID: 194 - Nine Of Cups

-- ZoneID: 194 - Nine Of Swords

-- ZoneID: 254 - Ningishzida -- TODO: Abyssea NM

-- 1816 Available

-- ZoneID:  74 - Nipper
INSERT INTO `mob_droplist` VALUES (1817,0,0,1000,5377,@UNCOMMON); -- Fractus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1817,0,0,1000,5378,@UNCOMMON); -- Congestus Cell (Uncommon, 10%)

-- ZoneID:  29 - Nitro Cluster

-- ZoneID:   5 - Nival Raptor

-- 1820 Available

-- ZoneID: 121 - Noble Mold

-- ZoneID: 216 - Nonno -- TODO: Abyssea NM

-- ZoneID: 204 - Northern Shadow

-- ZoneID:  68 - Nosferatu

-- ZoneID: 176 - Novv The Whitehearted

-- ZoneID: 216 - Npfundlwa -- TODO: Abyssea NM

-- ZoneID: 111 - Nue

-- ZoneID:  54 - Nuhn

-- ZoneID: 115 - Nunyenunc

-- ZoneID: 208 - Nussknacker

-- 1831 Available

-- ZoneID:  72 - Ob

-- ZoneID:  92 - Observant Zekka

-- ZoneID: 216 - Observer

-- ZoneID: 220 - Ocean Crab (Fished without pirates present)
-- ZoneID: 221 - Ocean Crab (Fished without pirates present)

-- ZoneID: 176 - Ocean Sahagin

-- ZoneID: 110 - Ochu

-- ZoneID: 151 - Odontotyrannus

-- ZoneID:  25 - Odqan

-- ZoneID: 160 - Ogama

-- ZoneID: 253 - Ogopogo -- TODO: Abyssea NM

-- 1842-1843 Available

-- ZoneID: 157 - Ogygos

-- ZoneID:  77 - Sewer Syrup
-- ZoneID: 149 - Davoi Mush
-- ZoneID: 149 - Blubbery Bulge
-- ZoneID: 176 - Mousse
-- ZoneID: 200 - Oil Spill
INSERT INTO `mob_droplist` VALUES (1845,0,0,1000,637,@COMMON); -- Vial Of Slime Oil (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1845,0,0,1000,637,@COMMON); -- Vial Of Slime Oil (Common, 15%)
INSERT INTO `mob_droplist` VALUES (1845,4,0,1000,637,0);       -- Vial Of Slime Oil (Despoil)

-- ZoneID: 205 - Old Opo-Opo

-- ZoneID: 109 - Old Quadav

-- ZoneID: 110 - Old Quadav

-- ZoneID: 143 - Old Quadav

-- ZoneID: 147 - Old Quadav

-- ZoneID: 200 - Old Two-Wings

-- ZoneID: 253 - Olyphant

-- ZoneID:  33 - Omaern Whm
-- ZoneID:  33 - Omaern Bst
-- ZoneID:  33 - Omaern Drg
-- ZoneID:  33 - Omaern Smn
-- ZoneID:  33 - Omaern Nin
-- ZoneID:  33 - Omaern Pld
-- ZoneID:  33 - Omaern Drk
-- ZoneID:  33 - Omaern Brd
-- ZoneID:  33 - Omaern Sam
-- ZoneID:  33 - Omaern Mnk
-- ZoneID:  33 - Omaern Blm
-- ZoneID:  33 - Omaern War
-- ZoneID:  33 - Omaern Rng
-- ZoneID:  33 - Omaern Rdm
-- ZoneID:  33 - Omaern Thf

-- ZoneID:  33 - Omhpemde
-- ZoneID:  33 - Omhpemde Nodive

-- ZoneID:  33 - Omphuabo

-- ZoneID:  33 - Omxzomit

-- ZoneID:  33 - Omyovra

-- ZoneID:  85 - Orcish Strategist
-- ZoneID: 155 - Orcish Strategist

-- ZoneID: 149 - One-Eyed Gwajboj

-- ZoneID: 169 - Oni Carcass

-- ZoneID:  88 - Onyx Quadav
-- ZoneID:  89 - Onyx Quadav

-- 1862 Available

-- ZoneID: 108 - Onyx Quadav
-- ZoneID: 108 - Veteran Quadav

-- ZoneID: 109 - Onyx Quadav

-- ZoneID: 143 - Onyx Quadav

-- ZoneID:   1 - Protozoan Fished
-- ZoneID:   1 - Ooze

-- ZoneID: 147 - Ooze

-- ZoneID: 151 - Ooze

-- ZoneID: 176 - Ooze

-- ZoneID: 216 - Orapodium

-- ZoneID:  82 - Orcish Bowshooter
-- ZoneID:  82 - Orcish Champion
-- ZoneID: 138 - Orcish Augur
-- ZoneID: 155 - Orcish Prophetess

-- ZoneID: 140 - Orcish Barricader

-- ZoneID: 105 - Orcish Beastrider
-- ZoneID: 105 - Orcish Brawler
-- ZoneID: 105 - Orcish Impaler
-- ZoneID: 105 - Orcish Nightraider

-- ZoneID: 149 - Orcish Beastrider

-- ZoneID: 149 - Orcish Bowshooter

-- ZoneID: 150 - Orcish Bowshooter
-- ZoneID: 161 - Orcish Bowshooter
-- ZoneID: 162 - Orcish Bowshooter

-- 1877-1878 Available

-- ZoneID:  81 - Orcish Fodder
-- ZoneID:  84 - Orcish Trooper
-- ZoneID: 175 - Orcish Trooper

-- ZoneID: 149 - Orcish Brawler

-- ZoneID:  84 - Orcish Brawler
-- ZoneID: 175 - Orcish Brawler

-- ZoneID: 149 - Orcish Champion
-- ZoneID: 150 - Orcish Champion

-- 1883 Available

-- ZoneID:  81 - Orcish Mesmerizer
-- ZoneID:  81 - Orcish Stonechucker
-- ZoneID:  84 - Orcish Impaler
-- ZoneID:  84 - Orcish Chasseur
-- ZoneID: 104 - Orcish Chasseur
-- ZoneID: 175 - Orcish Chasseur

-- ZoneID:  85 - Orcish Cupholder

-- ZoneID: 104 - Orcish Fighter
-- ZoneID: 104 - Orcish Cursemaker
-- ZoneID: 104 - Orcish Serjeant

-- ZoneID: 141 - Orcish Cursemaker
-- ZoneID: 142 - Orcish Cursemaker

-- ZoneID: 149 - Orcish Cursemaker

-- ZoneID: 175 - Orcish Cursemaker

-- 1890 Available

-- ZoneID: 149 - Orcish Dragoon
-- ZoneID: 150 - Orcish Dragoon

-- 1892 Available

-- ZoneID: 149 - Orcish Dreadnought
-- ZoneID: 150 - Orcish Dreadnought

-- 1894 Available

-- ZoneID:  85 - Orcish Dreadnought
-- ZoneID:  85 - Orcish Imperial Guard
-- ZoneID: 155 - Orcish Dreadnought
-- ZoneID: 155 - Orcish Imperial Guard

-- ZoneID: 149 - Orcish Farkiller
-- ZoneID: 150 - Orcish Farkiller

-- ZoneID:  85 - Orcish Farkiller
-- ZoneID: 155 - Orcish Cupholder
-- ZoneID: 155 - Orcish Farkiller

-- ZoneID: 141 - Orcish Fighter
-- ZoneID: 141 - Orcish Fighter

-- ZoneID: 142 - Orcish Fighter

-- ZoneID: 149 - Orcish Fighter

-- ZoneID: 149 - Orcish Firebelcher

-- 1902-1903 Available

-- ZoneID: 100 - Orcish Fodder
-- ZoneID: 101 - Orcish Fodder
-- ZoneID: 102 - Orcish Fodder

-- ZoneID: 140 - Orcish Fodder
-- ZoneID: 141 - Orcish Fodder

-- ZoneID: 149 - Orcish Footsoldier
-- ZoneID: 150 - Orcish Footsoldier

-- ZoneID:  83 - Orcish Footsoldier

-- ZoneID: 161 - Orcish Footsoldier
-- ZoneID: 162 - Orcish Footsoldier

-- 1909 Available

-- ZoneID:  83 - Orcish Gladiator
-- ZoneID:  83 - Orcish Hexspinner

-- ZoneID: 149 - Orcish Gladiator
-- ZoneID: 150 - Orcish Gladiator

-- ZoneID: 161 - Orcish Gladiator
-- ZoneID: 162 - Orcish Gladiator

-- ZoneID:   2 - Orcish Grunt
-- ZoneID:   2 - Orcish Stonechucker
-- ZoneID:   2 - Orcish Neckchopper
-- ZoneID: 100 - Orcish Grappler
-- ZoneID: 101 - Orcish Grappler
-- ZoneID: 102 - Orcish Grappler
-- ZoneID: 102 - Orcish Grunt
-- ZoneID: 102 - Orcish Neckchopper
-- ZoneID: 102 - Orcish Stonechucker

-- ZoneID: 140 - Orcish Grappler
-- ZoneID: 141 - Orcish Grappler

-- 1915-1916 Available

-- ZoneID: 104 - Orcish Grunt
-- ZoneID: 104 - Orcish Stonechucker
-- ZoneID: 104 - Orcish Neckchopper

-- ZoneID: 140 - Orcish Grunt
-- ZoneID: 141 - Orcish Grunt
-- ZoneID: 140 - Orcish Neckchopper
-- ZoneID: 141 - Orcish Neckchopper

-- ZoneID: 142 - Orcish Grunt
-- ZoneID: 142 - Orcish Neckchopper

-- ZoneID: 150 - Orcish Hexspinner

-- ZoneID: 149 - Orcish Impaler

-- ZoneID:  82 - Orcish Protector
-- ZoneID:  82 - Orcish Veteran
-- ZoneID:  83 - Orcish Zerker
-- ZoneID:  85 - Orcish Protector
-- ZoneID:  85 - Orcish Veteran
-- ZoneID: 138 - Orcish Protector
-- ZoneID: 138 - Orcish Veteran

-- 1923 Available

-- ZoneID: 100 - Orcish Mesmerizer
-- ZoneID: 101 - Orcish Mesmerizer
-- ZoneID: 102 - Orcish Mesmerizer

-- ZoneID: 140 - Orcish Mesmerizer
-- ZoneID: 141 - Orcish Mesmerizer

-- 1926 Available

-- ZoneID:  81 - Orcish Neckchopper

-- 1928-1930 Available

-- ZoneID: 149 - Orcish Nightraider

-- ZoneID: 150 - Orcish Overlord

-- ZoneID: 149 - Orcish Predator
-- ZoneID: 150 - Orcish Predator

-- ZoneID: 162 - Orcish Predator

-- ZoneID: 150 - Orcish Protector

-- ZoneID: 141 - Orcish Serjeant

-- ZoneID: 142 - Orcish Serjeant

-- ZoneID: 149 - Orcish Serjeant

-- ZoneID: 85 - Orcish Prophetess

-- ZoneID: 140 - Orcish Stonechucker
-- ZoneID: 141 - Orcish Stonechucker

-- ZoneID: 142 - Orcish Stonechucker

-- ZoneID:  24 - Orcish Stonelauncher
-- ZoneID:  25 - Orcish Stonelauncher

-- ZoneID: 140 - Orcish Stonelauncher

-- 1944 Available

-- ZoneID: 149 - Orcish Trooper
-- ZoneID: 150 - Orcish Trooper

-- ZoneID: 161 - Orcish Trooper
-- ZoneID: 162 - Orcish Trooper

-- 1947 Available

-- ZoneID: 149 - Orcish Veteran
-- ZoneID: 150 - Orcish Veteran

-- ZoneID: 162 - Orcish Veteran

-- ZoneID: 140 - Orcish Wallbreacher

-- ZoneID: 149 - Orcish Warchief
-- ZoneID: 150 - Orcish Warchief

-- ZoneID: 162 - Orcish Warchief

-- ZoneID: 150 - Orcish Warlord

-- ZoneID: 162 - Orcish Zerker

-- ZoneID: 149 - Orcish Zerker
-- ZoneID: 150 - Orcish Zerker

-- ZoneID: 204 - Ore Golem

-- ZoneID: 177 - Ornamental Weapon

-- ZoneID: 107 - Ornery Sheep

-- ZoneID: 218 - Orthrus -- TODO: Abyssea NM

-- ZoneID: 213 - Ose

-- ZoneID:  72 - Oupire

-- Ouryu Cometh BCNM

-- ZoneID: 218 - Ouzelum -- TODO: Abyssea NM

-- ZoneID:  25 - Overgrown Rose

-- ZoneID: 216 - Overking Apkallu

-- ZoneID: 150 - Overlord Bakgodek

-- ZoneID: 185 - Overlords Tombstone

-- ZoneID: 200 - Over Weapon
-- ZoneID: 200 - Vault Weapon

-- ZoneID: 174 - Ovinnik

-- ZoneID: 132 - Ovni -- TODO: Abyssea NM

-- ZoneID:  45 - Pachypodium

-- ZoneID: 167 - Panna Cotta

-- ZoneID: 176 - Pahh The Gullcaller

-- ZoneID:  83 - Pallas

-- ZoneID: 158 - Pallas

-- ZoneID: 215 - Pallid Percy -- TODO: Abyssea NM

-- ZoneID:  68 - Pandemonium Warden

-- ZoneID: 132 - Pantagruel -- TODO: Abyssea NM

-- ZoneID: 253 - Pantokrator -- TODO: Abyssea NM

-- ZoneID: 157 - Panzer Doll

-- ZoneID: 104 - Panzer Percival

-- 1982 Available

-- ZoneID:  79 - Peallaidh

-- ZoneID: 217 - Peapuk

-- ZoneID: 213 - Peg Powler

-- ZoneID:  89 - Peiste

-- ZoneID:  90 - Peiste
-- ZoneID:  90 - Virulent Peiste
-- ZoneID:  92 - Virulent Peiste

-- ZoneID: 174 - Pelican

-- ZoneID:  75 - Peryton
INSERT INTO `mob_droplist` VALUES (1989,0,0,1000,5735,@ALWAYS); -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (1989,0,0,1000,5735,@SRARE);  -- Cotton Coin Purse (Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (1989,0,0,1000,14553,@RARE);  -- Freyas Jerkin (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (1989,0,0,1000,15640,@RARE);  -- Enlils Brayettes (Rare, 5%)

-- ZoneID:  77 - Peryton
-- ZoneID:  77 - Roc
-- ZoneID:  77 - Simurgh
INSERT INTO `mob_droplist` VALUES (1990,0,0,1000,842,@UNCOMMON); -- Giant Bird Feather (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (1990,0,0,1000,843,@VRARE);    -- Giant Bird Plume (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (1990,4,0,1000,842,0);         -- Giant Bird Feather (Despoil)

-- ZoneID: 125 - Phorusrhacos
-- ZoneID: 128 - Peryton

-- ZoneID: 167 - Phanduron The Condemned

-- ZoneID: 220 - Phantom
-- ZoneID: 221 - Phantom
-- ZoneID: 227 - Phantom
-- ZoneID: 228 - Phantom

-- ZoneID: 174 - Phantom Worm

-- ZoneID:   5 - Phasma

-- ZoneID:  54 - Phasma
-- ZoneID:  61 - Phasma

-- ZoneID: 158 - Phasma

-- ZoneID: 132 - Piasa -- TODO: Abyssea NM

-- ZoneID:   7 - Pit Antlion

-- ZoneID:  81 - Pixie
-- ZoneID:  82 - Sprite
-- ZoneID:  83 - Sprite
-- ZoneID:  84 - Pixie
-- ZoneID:  88 - Pixie
-- ZoneID:  89 - Pixie
-- ZoneID:  90 - Sprite
-- ZoneID:  91 - Sprite
-- ZoneID:  95 - Pixie
-- ZoneID:  96 - Pixie
-- ZoneID:  97 - Sprite
-- ZoneID:  98 - Sprite

-- ZoneID: 104 - Sprite
-- ZoneID: 105 - Sprite
-- ZoneID: 109 - Sprite
-- ZoneID: 110 - Sprite
-- ZoneID: 119 - Sprite
-- ZoneID: 120 - Sprite
-- ZoneID: 100 - Pixie
-- ZoneID: 101 - Pixie
-- ZoneID: 102 - Pixie
-- ZoneID: 103 - Pixie
-- ZoneID: 106 - Pixie
-- ZoneID: 107 - Pixie
-- ZoneID: 108 - Pixie
-- ZoneID: 115 - Pixie
-- ZoneID: 116 - Pixie
-- ZoneID: 117 - Pixie
-- ZoneID: 118 - Pixie

-- ZoneID: 190 - Plague Bats

-- ZoneID: 132 - Plateau Glider

-- ZoneID: 132 - Plateau Hare

-- ZoneID:  92 - Platinum Quadav
-- ZoneID: 155 - Platinum Quadav

-- ZoneID: 148 - Platinum Quadav

-- ZoneID: 217 - Pneumaflayer

-- ZoneID: 149 - Poisonhand Gnadgad

-- ZoneID:   2 - Poison Funguar

-- ZoneID: 102 - Poison Funguar

-- ZoneID: 118 - Poison Leech

-- ZoneID:   5 - Polar Hare
-- ZoneID:   5 - Variable Hare

-- ZoneID: 176 - Pond Sahagin

-- ZoneID:  65 - Poroggo
-- ZoneID:  77 - Aroro Samaroro
-- ZoneID:  77 - Iroro Samaroro
-- ZoneID:  77 - Poroggo Gent
-- ZoneID:  77 - Uroro Samaroro
INSERT INTO `mob_droplist` VALUES (2014,0,0,1000,2334,@COMMON); -- Poroggo Hat (Common, 15%)
INSERT INTO `mob_droplist` VALUES (2014,4,0,1000,2334,0);       -- Poroggo Hat (Despoil)

-- ZoneID: 132 - Poroggo Dom Juan

-- ZoneID:  73 - Poroggo Gent
INSERT INTO `mob_droplist` VALUES (2016,0,0,1000,5375,@ALWAYS); -- Praecipitatio Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2016,0,0,1000,5375,@ALWAYS); -- Praecipitatio Cell (Always, 100%)

-- ZoneID: 132 - Poroggo Seducteur

-- ZoneID: 158 - Porphyrion

-- ZoneID:  76 - Powderkeg Yanadahn
INSERT INTO `mob_droplist` VALUES (2019,0,0,1000,5735,@ALWAYS);  -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2019,0,0,1000,15634,@ALWAYS); -- Hoshikazu Hakama (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2019,0,0,1000,15644,40);      -- Machas Slops (4.0%)

-- ZoneID:  74 - Princess Pudding
INSERT INTO `mob_droplist` VALUES (2020,0,0,1000,14555,@ALWAYS);  -- Hoshikazu Gi (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2020,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2020,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2020,0,0,1000,5384,@UNCOMMON); -- Spissatus Cell (Uncommon, 10%)

-- ZoneID: 135 - Prince Seere

-- ZoneID: 123 - Soldier Crawler
-- ZoneID: 124 - Worker Crawler
-- ZoneID: 153 - Processionaire
-- ZoneID: 159 - Rumble Crawler
-- ZoneID: 159 - Rumble Crawler

-- ZoneID: 171 - Processionaire

-- ZoneID: 208 - Proconsul Xii

-- ZoneID:  58 - Proteus

-- ZoneID: 191 - Prim Pika

-- ZoneID: 198 - Protozoan

-- ZoneID:  22 - Provoker

-- ZoneID:  74 - Psycheflayer
INSERT INTO `mob_droplist` VALUES (2029,0,0,1000,16103,140);      -- Machas Crown (14.0%)
INSERT INTO `mob_droplist` VALUES (2029,0,0,1000,5374,@UNCOMMON); -- Opacus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2029,0,0,1000,5375,@UNCOMMON); -- Praecipitatio Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2029,0,0,1000,5735,@UNCOMMON); -- Cotton Coin Purse (Uncommon, 10%)

-- ZoneID:  54 - Soulflayer
-- ZoneID:  77 - Psycheflayer
-- ZoneID:  79 - Soulflayer
INSERT INTO `mob_droplist` VALUES (2030,0,0,1000,2335,@COMMON);   -- Soulflayer Tentacle (Common, 15%)
INSERT INTO `mob_droplist` VALUES (2030,0,0,1000,2336,@UNCOMMON); -- Soulflayer Staff (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2030,0,0,1000,1724,@RARE);     -- Soulflayer Robe (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2030,4,0,1000,2336,0);         -- Soulflayer Staff (Despoil)
INSERT INTO `mob_droplist` VALUES (2030,4,0,1000,1724,0);         -- Soulflayer Robe (Despoil)

-- ZoneID: 160 - Puck

-- 2032 Available

-- ZoneID:  95 - Toad
-- ZoneID:  95 - Poroggo Gent
-- ZoneID:  216 - Squib

-- 2034 Available

-- ZoneID:  51 - Puk WW
-- ZoneID:  65 - Puk M

-- ZoneID:  77 - Puk
INSERT INTO `mob_droplist` VALUES (2036,0,0,1000,2148,@COMMON); -- Puk Wing (Common, 15%)
INSERT INTO `mob_droplist` VALUES (2036,0,0,1000,5569,@RARE);   -- Puk Egg (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2036,0,0,1000,2229,@VRARE);  -- Vial Of Chimera Blood (Very Rare, 1%)

-- ZoneID:  73 - Puk
INSERT INTO `mob_droplist` VALUES (2037,0,0,1000,5365,@ALWAYS); -- Incus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2037,0,0,1000,5373,@ALWAYS); -- Duplicatus Cell (Always, 100%)

-- ZoneID:  52 - Sea Puk
-- ZoneID:  65 - Sea Puk

-- 2039 Available

-- ZoneID: 196 - Pulverized Pfeffer

-- ZoneID:  12 - Purgatory Bat

-- ZoneID: 195 - Puroboros

-- ZoneID: 197 - Puroboros

-- ZoneID: 149 - Purpleflash Brukdok

-- ZoneID: 254 - Putrid Peapuk

-- ZoneID: 117 - Pygmaioi

-- ZoneID: 100 - Pyracmon
-- ZoneID: 101 - Pyracmon
-- ZoneID: 106 - Pyracmon
-- ZoneID: 107 - Pyracmon
-- ZoneID: 115 - Pyracmon
-- ZoneID: 116 - Pyracmon

-- ZoneID:  29 - Pyrodrake

-- ZoneID:  15 - Qaitu

-- ZoneID:  54 - Qiqirn Trailer
-- ZoneID:  54 - Qiqirn Treasure Hunter
-- ZoneID:  62 - Qiqirn Mercenary
-- ZoneID:  62 - Qiqirn Diamantaire
-- ZoneID:  65 - Qiqirn Goldsmith
-- ZoneID:  65 - Qiqirn Poulterer
-- ZoneID:  68 - Qiqirn Archaeologist
-- ZoneID:  68 - Qiqirn Enterpriser
-- ZoneID:  68 - Qiqirn Lieuter
-- ZoneID:  68 - Qiqirn Mosstrooper
-- ZoneID:  72 - Qiqirn Poulterer
-- ZoneID:  72 - Qiqirn Goldsmith

-- ZoneID:  77 - Qiqirn Treasure Hunter
-- ZoneID:  77 - Qiqirn Archaeologist
INSERT INTO `mob_droplist` VALUES (2051,0,0,1000,2503,@VCOMMON); -- Handful Of Almonds (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (2051,2,0,1000,2153,0);        -- Qiqirn Sandbag (Steal)

-- ZoneID:  74 - Qiqirn Astrologer
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5380,1390); -- Velum Cell (139.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5369,1150); -- Stratus Cell (115.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5375,970);  -- Praecipitatio Cell (97.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5380,700);  -- Velum Cell (70.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5369,580);  -- Stratus Cell (58.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5735,510);  -- Cotton Coin Purse (51.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5375,480);  -- Praecipitatio Cell (48.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5380,460);  -- Velum Cell (46.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,5369,380);  -- Stratus Cell (38.0%)
INSERT INTO `mob_droplist` VALUES (2052,0,0,1000,14549,70);  -- Deimoss Cuirass (7.0%)
INSERT INTO `mob_droplist` VALUES (2052,2,0,1000,5373,0);    -- Duplicatus Cell (Steal)

-- ZoneID:  74 - Qiqirn Treasure Hunter
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5377,1390); -- Fractus Cell (139.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5379,1010); -- Nimbus Cell (101.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5377,690);  -- Fractus Cell (69.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5365,570);  -- Incus Cell (57.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5379,510);  -- Nimbus Cell (51.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5377,460);  -- Fractus Cell (46.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5365,280);  -- Incus Cell (28.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,5735,280);  -- Cotton Coin Purse (28.0%)
INSERT INTO `mob_droplist` VALUES (2053,0,0,1000,14565,40);  -- Machas Coat (4.0%)
INSERT INTO `mob_droplist` VALUES (2053,2,0,1000,5367,0);    -- Cumulus Cell (Steal)

-- ZoneID:  79 - Qiqirn Mireguide
-- ZoneID:  79 - Qiqirn Rock Hound

-- 2055-2060 Available

-- ZoneID: 217 - Quasimodo -- TODO: Abyssea NM

-- ZoneID: 194 - Queen Of Batons

-- ZoneID: 194 - Queen Of Coins

-- ZoneID: 146 - Queen Of Cups

-- ZoneID: 194 - Queen Of Swords

-- ZoneID: 134 - Quiebitiel

-- ZoneID: 176 - Qull The Shellbuster

-- ZoneID:  74 - Qutrub Drk
INSERT INTO `mob_droplist` VALUES (2068,0,0,1000,5365,200); -- Incus Cell (20.0%)
INSERT INTO `mob_droplist` VALUES (2068,0,0,1000,5366,190); -- Castellanus Cell (19.0%)

-- ZoneID: 151 - Quu Domi The Gallant

-- ZoneID:  95 - Rafflesia
-- ZoneID:  96 - Rafflesia

-- ZoneID:  99 - Blooming Rafflesia

-- ZoneID: 254 - Raja -- TODO: Abyssea NM

-- ZoneID: 217 - Rakshas -- TODO: Abyssea NM

-- ZoneID: 108 - Rampaging Ram

-- ZoneID: 196 - Rancid Ooze

-- ZoneID: 218 - Rani -- TODO: Abyssea NM

-- ZoneID:  15 - Raskovnik -- TODO: Abyssea NM

-- ZoneID:  79 - Ravin Raven

-- ZoneID:  15 - Razorback

-- ZoneID: 176 - Razorjaw Pugil

-- ZoneID:  75 - Reactionary Rampart -- TODO: Salvage
INSERT INTO `mob_droplist` VALUES (2081,0,0,1000,2377,@UNCOMMON); -- Bhaflau Card (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2081,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2081,0,0,1000,2488,@RARE);     -- Piece Of Alexandrite (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2081,0,0,1000,2488,30);        -- Piece Of Alexandrite (3.0%)

-- ZoneID:  62 - Reacton

-- 2083 Available

-- ZoneID: 174 - Recluse Spider

-- ZoneID:  40 - Ree Nata The Melomanic

-- ZoneID: 253 - Refitted Chariot -- TODO: Abyssea NM

-- ZoneID: 254 - Rencounter Chariot -- TODO: Abyssea NM

-- ZoneID:  54 - Reserve Draugar Thf
-- ZoneID:  54 - Reserve Draugar Blm
-- ZoneID:  54 - Reserve Draugar Drk
-- ZoneID:  54 - Reserve Draugar Drg
-- ZoneID:  79 - Reserve Draugar Blm
-- ZoneID:  79 - Reserve Draugar Thf

-- ZoneID:  74 - Reserve Draugar Blm
-- ZoneID:  74 - Reserve Draugar Drk
-- ZoneID:  74 - Reserve Draugar Drg
-- ZoneID:  74 - Reserve Draugar Thf
INSERT INTO `mob_droplist` VALUES (2089,0,0,1000,5370,@UNCOMMON); -- Cirrocumulus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2089,0,0,1000,5376,@UNCOMMON); -- Pannus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2089,0,0,1000,5378,@UNCOMMON); -- Congestus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2089,0,0,1000,5379,@UNCOMMON); -- Nimbus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2089,0,0,1000,5380,@UNCOMMON); -- Velum Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2089,0,0,1000,5383,@UNCOMMON); -- Humilus Cell (Uncommon, 10%)

-- ZoneID: 253 - Resheph -- TODO: Abyssea NM

-- ZoneID:  46 - Revenant
-- ZoneID:  47 - Revenant
-- ZoneID:  58 - Utukku
-- ZoneID:  59 - Utukku

-- ZoneID: 121 - Revenant

-- ZoneID:  88 - Revenant
-- ZoneID: 175 - Revenant
-- ZoneID: 195 - Revenant
-- ZoneID: 200 - Revenant
-- ZoneID: 204 - Revenant

-- 2094 Available

-- ZoneID: 142 - Riding Lizard

-- ZoneID: 215 - Rift Dragon

-- ZoneID: 215 - Rift Treant

-- 2098 Available

-- ZoneID: 176 - Riparian Sahagin

-- ZoneID:  30 - Riverne Vulture

-- ZoneID: 100 - River Crab

-- ZoneID: 116 - River Crab

-- ZoneID: 172 - River Crab

-- ZoneID: 172 - Soot Crab

-- ZoneID: 123 - River Sahagin

-- ZoneID: 176 - Rivulet Sahagin

-- ZoneID:  83 - Robber Crab
-- ZoneID: 113 - Robber Crab

-- 1208 Available

-- ZoneID: 153 - Robber Crab

-- ZoneID: 174 - Robber Crab
-- ZoneID: 174 - Robber Crab

-- ZoneID: 212 - Robber Crab

-- ZoneID: 120 - Roc

-- ZoneID: 176 - Rock Crab Fished
-- ZoneID: 176 - Rock Crab

-- 2114-2115 Available

-- ZoneID: 190 - Rock Eater

-- 2117 Available

-- ZoneID: 132 - Rock Grinder

-- ZoneID:  88 - Rock Lizard

-- ZoneID: 106 - Rock Lizard
-- ZoneID: 107 - Rock Lizard
-- ZoneID: 191 - Rock Lizard

-- 2121 Available

-- ZoneID: 121 - Rot Prowler

-- ZoneID: 123 - Rose Garden

-- ZoneID: 169 - Rotten Sod

-- ZoneID: 190 - Spartoi Warrior

-- 2126 Available

-- ZoneID: 176 - Royal Leech

-- ZoneID:  90 - Ruby Quadav

-- ZoneID: 148 - Ruby Quadav

-- ZoneID:  85 - Rugaroo

-- 2131 Available

-- ZoneID: 197 - Rumble Crawler

-- ZoneID: 132 - Ruminator -- TODO: Abyssea NM

-- ZoneID: 217 - Russet Rarab

-- ZoneID: 136 - Ruszor
-- ZoneID: 137 - Savage Ruszor

-- ZoneID:   2 - Sabertooth Tiger

-- ZoneID: 105 - Sabertooth Tiger

-- ZoneID: 120 - Sabertooth Tiger

-- 2139-2138 Available

-- ZoneID:  74 - Sabotender Maestro
INSERT INTO `mob_droplist` VALUES (2139,0,0,1000,5379,@UNCOMMON); -- Nimbus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2139,0,0,1000,5382,@UNCOMMON); -- Mediocris Cell (Uncommon, 10%)

-- ZoneID: 174 - Sabotender Mariachi

-- ZoneID: 174 - Sabotender Sediendo

-- ZoneID: 159 - Sacrificial Goblet

-- 2143 Available

-- ZoneID: 208 - Sagittarius X-Xiii

-- ZoneID: 103 - Sand Bats

-- ZoneID: 114 - Sand Beetle

-- ZoneID: 113 - Sand Cockatrice

-- ZoneID: 208 - Sand Digger

-- ZoneID: 208 - Sand Eater

-- ZoneID: 102 - Steppe Hare
-- ZoneID: 103 - Sand Hare

-- ZoneID:   7 - Sand Lizard

-- ZoneID: 113 - Sand Lizard

-- ZoneID: 174 - Sand Lizard

-- ZoneID: 208 - Sand Lizard

-- 2155 Available

-- ZoneID: 208 - Sand Spider

-- ZoneID: 218 - Sand Sweeper

-- ZoneID: 147 - Sapphire Quadav

-- ZoneID: 148 - Sapphire Quadav

-- ZoneID:  89 - Sapphirine Quadav

-- ZoneID:  91 - Sapphirine Quadav
-- ZoneID: 171 - Sapphirine Quadav

-- ZoneID:  61 - Sarameya

-- ZoneID:  15 - Sarcophilus -- TODO: Abyssea NM

-- ZoneID: 167 - Nachtmahr

-- ZoneID: 167 - Blind Bat

-- ZoneID:  18 - Satiator

-- 2167-2168 Available

-- ZoneID:  95 - Savanna Dhalmel

-- ZoneID:  95 - Savanna Rarab
-- ZoneID:  96 - Vorpal Bunny

-- ZoneID: 116 - Savanna Rarab

-- ZoneID:  91 - Scabrous Slug
-- ZoneID:  92 - Edible Slug

-- ZoneID:  81 - Scarab Beetle

-- ZoneID: 100 - Scarab Beetle
-- ZoneID: 101 - Scarab Beetle

-- 2174 Available

-- ZoneID: 153 - Scavenger Crab Fished

-- ZoneID: 169 - Scavenger Crab

-- ZoneID: 174 - Scavenger Crab Fished

-- 2179 Available

-- ZoneID: 215 - Schnitter

-- ZoneID: 143 - Scimitar Scorpion

-- ZoneID:  89 - Scitalis

-- ZoneID: 126 - Sea Bishop
-- ZoneID: 111 - Morgawr

-- ZoneID: 220 - Sea Crab
-- ZoneID: 221 - Sea Crab
-- ZoneID: 227 - Sea Crab
-- ZoneID: 228 - Sea Crab

-- ZoneID: 176 - Sea Hog

-- ZoneID: 220 - Sea Horror
-- ZoneID: 221 - Sea Horror

-- 2187 Available

-- ZoneID: 220 - Sea Monk Fished
-- ZoneID: 220 - Sea Monk
-- ZoneID: 221 - Sea Monk Fished
-- ZoneID: 221 - Sea Monk
-- ZoneID: 227 - Sea Monk Fished
-- ZoneID: 227 - Sea Monk
-- ZoneID: 228 - Sea Monk Fished
-- ZoneID: 228 - Sea Monk

-- 2189 Available

-- ZoneID: 217 - Sedna -- TODO: Abyssea NM

-- ZoneID: 254 - Seelie

-- ZoneID:  16 - Seether
-- ZoneID:  16 - Seether
-- ZoneID:  16 - Seether
-- ZoneID:  22 - Wanderer
-- ZoneID:  22 - Wanderer
-- ZoneID:  22 - Wanderer
-- ZoneID:  22 - Wanderer

-- ZoneID:  18 - Seether
-- ZoneID:  18 - Seether
-- ZoneID:  18 - Seether

-- ZoneID:  20 - Seether
-- ZoneID:  20 - Seether
-- ZoneID:  20 - Seether
-- ZoneID:  22 - Seether
-- ZoneID:  22 - Seether
-- ZoneID:  22 - Seether

-- 2195 Available

-- ZoneID: 130 - Seiryu

-- ZoneID: 254 - Sensenmann

-- ZoneID: 132 - Sentinel Crab

-- ZoneID: 141 - Sentry Lizard

-- ZoneID: 217 - Seps -- TODO: Abyssea NM

-- ZoneID: 185 - Serjeant Tombstone
-- ZoneID: 185 - Serjeant Tombstone

-- ZoneID: 129 - Serket
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,4175,@VRARE);    -- Vile Elixir +1 (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,4173,@VRARE);    -- Hi-Reraiser (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,11287,@VCOMMON); -- Antares Harness (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,19213,@VCOMMON); -- White Tathlum (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,12348,@VRARE);   -- Serket Shield (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,13552,@VRARE);   -- Serket Ring (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,16767,@VRARE);   -- Triple Dagger (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2202,0,0,1000,901,@VRARE);     -- Venomous Claw (Very Rare, 1%)

-- ZoneID: 200 - Serket

-- ZoneID: 117 - Serpopard Ishtar

-- ZoneID: 194 - Seven Of Batons

-- ZoneID: 194 - Seven Of Coins

-- ZoneID: 194 - Seven Of Cups

-- ZoneID: 194 - Seven Of Swords

-- ZoneID: 167 - Sewer Syrup

-- ZoneID: 176 - Seww The Squidlimbed

-- ZoneID: 204 - Shadow War
-- ZoneID: 204 - Shadow Rng
-- ZoneID: 204 - Shadow Blm
-- ZoneID: 204 - Shadow Thf

-- 2212-2225 Available

-- ZoneID: 112 - Shadow Eye

-- ZoneID:  15 - Shadow Funguar

-- ZoneID:  15 - Shadow Lizard

-- ZoneID:  40 - Shamblix Rottenheart

-- ZoneID: 218 - Sharabha -- TODO: Abyssea NM

-- ZoneID: 116 - Sharp-Eared Ropipi

-- ZoneID:  85 - Shatterskull Mippdapp

-- ZoneID: 218 - Shaula -- TODO: Abyssea NM

-- ZoneID: 217 - Shewriwhile

-- ZoneID:  30 - Shieldtrap

-- ZoneID: 167 - Shii

-- ZoneID: 122 - Shikigami Weapon

-- ZoneID: 255 - Shinryu -- TODO: Abyssea NM

-- Weapons/Armor are a base estimate without blue proc.
-- Drops 0-2 materials without the need of a yellow proc. Yellow adds extra items to the list and ups the drop rate.
-- Base materials without yellow seem to be the items that arent scrolls(?)
-- These base materials aren't equal weights. Items like Apkallu Egg and Adaman Ore are favored in videos and XIDB data.
-- Jewels (Light Opal etc) can drop without a proc but it is unclear which and if some jewels or the elemental gems require yellow proc.

-- 2239-2240 Available

-- ZoneID: 176 - Shore Sahagin

-- ZoneID: 216 - Shore Spider

-- ZoneID:   2 - Shrieker
-- ZoneID: 193 - Shrieker

-- 2244-2245 Available

-- ZoneID: 200 - Siege Bat

-- ZoneID: 253 - Sierra Tiger

-- ZoneID: 110 - Silk Caterpillar

-- ZoneID: 228 - Silverhook

-- ZoneID:  89 - Sidhe

-- ZoneID:  89 - Silver Quadav
-- ZoneID:  90 - Silver Quadav
-- ZoneID:  91 - Silver Quadav
-- ZoneID: 171 - Silver Quadav

-- ZoneID: 147 - Silver Quadav

-- 2253-2254 Available

-- ZoneID: 110 - Simurgh

-- ZoneID: 254 - Sinister Seidel

-- ZoneID: 217 - Sippoy -- TODO: Abyssea NM

-- ZoneID: 216 - Sirrush -- TODO: Abyssea NM

-- ZoneID: 253 - Sisyphus -- TODO: Abyssea NM

-- ZoneID: 194 - Six Of Batons

-- ZoneID: 194 - Six Of Coins

-- ZoneID: 194 - Six Of Cups

-- ZoneID: 194 - Six Of Swords

-- 2264-2265 Available

-- ZoneID: 200 - Skewer Sam

-- ZoneID:  75 - Skirmish Pephredo
INSERT INTO `mob_droplist` VALUES (2267,0,0,1000,5735,@ALWAYS); -- Cotton Coin Purse (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2267,0,0,1000,5735,@SRARE);  -- Cotton Coin Purse (Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (2267,0,0,1000,15722,@RARE);  -- Hikazu Sune-Ate (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2267,0,0,1000,16091,@RARE);  -- Freyas Mask (Rare, 5%)

-- ZoneID:  52 - Skoffin

-- ZoneID:  81 - Skogs Fru

-- ZoneID: 216 - Slasher

-- ZoneID: 217 - Slaughterous Smilodon

-- 2272 Available

-- ZoneID: 192 - Slendlix Spindlethumb

-- ZoneID: 217 - Slough Bats

-- 2275 Available

-- ZoneID: 215 - Smok -- TODO: Abyssea NM

-- 2277 Available

-- ZoneID: 196 - Smothered Schmidt

-- 2279-2280 Available

-- ZoneID: 103 - Snipper Fished
-- ZoneID: 103 - Snipper

-- 2282 Available

-- ZoneID: 270 - Snippy Rafflesia

-- ZoneID:   5 - Snoll

-- ZoneID:   9 - Snoll

-- ZoneID:   9 - Snowball

-- ZoneID: 253 - Snowflake

-- 2288 Available

-- ZoneID:   9 - Snow Lizard

-- ZoneID: 216 - Sobek -- TODO: Abyssea NM

-- ZoneID:  15 - Sods Limule
-- ZoneID:  15 - Sods Limule

-- 2292 Available

-- ZoneID:  51 - Soldier Pephredo
-- ZoneID:  51 - Worker Pephredo

-- ZoneID: 213 - Soulstealer Skullnix

-- ZoneID: 197 - Soul Stinger

-- ZoneID: 204 - Southern Shadow

-- ZoneID: 160 - Sozu Bliberry

-- ZoneID: 159 - Sozu Rogberry

-- ZoneID: 159 - Sozu Sarberry

-- ZoneID: 159 - Sozu Terberry

-- ZoneID: 190 - Spartoi Sorcerer

-- ZoneID: 204 - Specter War
-- ZoneID: 204 - Specter Blm
-- ZoneID: 204 - Specter Thf
-- ZoneID: 204 - Specter Rng

-- ZoneID: 217 - Speltercap

-- ZoneID: 208 - Spelunking Sabotender

-- ZoneID:   2 - Spider Wasp

-- ZoneID: 147 - Spinel Quadav

-- ZoneID: 161 - Spinel Quadav
-- ZoneID: 162 - Spinel Quadav

-- ZoneID: 116 - Spiny Spipi

-- ZoneID: 217 - Spitting Spider

-- ZoneID:  79 - Spongilla Fly
-- ZoneID:  79 - Vauxia Fly

-- ZoneID: 195 - Spriggan War
-- ZoneID: 195 - Spriggan Blm
-- ZoneID: 195 - Spriggan Thf
-- ZoneID: 195 - Spriggan Rng

-- ZoneID: 176 - Spring Sahagin

-- ZoneID: 130 - Sprinkler

-- ZoneID: 215 - Spuk

-- ZoneID: 196 - Spunkie

-- ZoneID:   5 - Srei Ap

-- ZoneID:  74 - Staggering Sapling
INSERT INTO `mob_droplist` VALUES (2317,0,0,1000,5377,@UNCOMMON); -- Fractus Cell (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2317,0,0,1000,5381,@UNCOMMON); -- Pileus Cell (Uncommon, 10%)

-- ZoneID:   2 - Stag Beetle
-- ZoneID:  82 - Stag Beetle
-- ZoneID:  97 - Stag Beetle

-- ZoneID: 104 - Stag Beetle
-- ZoneID: 119 - Stag Beetle

-- 2320-2322 Available

-- ZoneID:  83 - Wandering Sapling
-- ZoneID:  84 - Stalking Sapling

-- ZoneID: 193 - Stalking Sapling

-- ZoneID: 169 - Starmite

-- ZoneID: 177 - Steam Cleaner

-- ZoneID: 191 - Steam Lizard

-- ZoneID: 149 - Steelbiter Gudrud

-- ZoneID: 108 - Steelfleece Baldarich

-- ZoneID: 153 - Steelshell

-- 2231 Available

-- ZoneID:  27 - Stegotaur
-- ZoneID:  27 - Taurus

-- ZoneID:  28 - Stegotaur
-- ZoneID:  28 - Teratotaur

-- 2334 Available

-- ZoneID:  40 - Stihi

-- ZoneID: 106 - Stinging Sophie

-- ZoneID:  65 - Spinner

-- 2338-2339 Available

-- ZoneID: 190 - Stone Eater

-- ZoneID: 191 - Stone Eater

-- 2342 Available

-- ZoneID: 108 - Stray Mary

-- ZoneID: 123 - Stream Sahagin

-- ZoneID: 102 - Strolling Sapling

-- ZoneID: 108 - Strolling Sapling

-- ZoneID: 117 - Strolling Sapling

-- ZoneID: 193 - Stroper

-- ZoneID: 193 - Stroper Chyme

-- ZoneID:   1 - Stubborn Dredvodd

-- ZoneID:   5 - Stygian Demon

-- ZoneID: 161 - Stygian Demon

-- ZoneID: 254 - Stygian Djinn

-- ZoneID:  82 - Land Pugil
-- ZoneID:  83 - Stygian Pugil

-- ZoneID: 153 - Stygian Pugil Fished

-- ZoneID: 174 - Stygian Pugil Fished

-- ZoneID: 253 - Sub-Zero Gear

-- ZoneID: 160 - Succubus Bats

-- ZoneID:  65 - Suhur Mas

-- ZoneID:  75 - Sulfur Scorpion
INSERT INTO `mob_droplist` VALUES (2360,1,1,@VRARE,14970,200); -- Hoshikazu Tekko (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2360,1,1,@VRARE,15712,200); -- Enyo's Leggings (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2360,1,1,@VRARE,15728,200); -- Nemain's Sabots (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2360,1,1,@VRARE,15630,200); -- Njord's Trousers (Group 1, Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2360,1,1,@VRARE,16097,200); -- Anu's Tiara (Group 1, Very Rare, 1%)

-- ZoneID:  99 - Suu Xicu The Cantabile

-- ZoneID: 130 - Suzaku

-- ZoneID: 253 - Svelldrake

-- ZoneID: 101 - Swamfisk

-- ZoneID: 176 - Swamp Sahagin

-- ZoneID:  12 - Swashstox Beadblinker

-- ZoneID:  61 - Sweeping Cluster

-- ZoneID:  77 - Odqan
-- ZoneID:  77 - Sweeping Cluster
INSERT INTO `mob_droplist` VALUES (2368,0,0,1000,17305,@RARE); -- Cluster Arm (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2368,0,0,1000,1630,@VRARE); -- Pinch Of Cluster Ash (Very Rare, 1%)

-- ZoneID: 118 - Sylvestre

-- ZoneID:  98 - Tabar Beak
-- ZoneID: 120 - Tabar Beak

-- ZoneID: 218 - Tablilla -- TODO: Abyssea NM

-- ZoneID: 200 - Tainted Flesh

-- ZoneID: 213 - Tainted Flesh

-- ZoneID: 166 - Taisai
-- ZoneID: 175 - Gazer

-- ZoneID: 166 - Taisaijin

-- 2376 Available

-- ZoneID: 205 - Tarasque

-- 2378 Available

-- ZoneID:   4 - Tartarus Eft
-- ZoneID:   4 - Hypnos Eft

-- 2380 Available

-- ZoneID:  24 - Tavnazian Ram

-- ZoneID:  24 - Tavnazian Sheep

-- ZoneID:  25 - Tavnazian Sheep

-- ZoneID: 160 - Tawny-Fingered Mugberry

-- ZoneID: 212 - Taxim

-- ZoneID: 254 - Teekesselchen -- TODO: Abyssea NM

-- 2387 Available

-- ZoneID: 167 - Arioch

-- ZoneID: 159 - Temple Opo-Opo

-- ZoneID: 194 - Ten Of Batons

-- ZoneID: 194 - Ten Of Coins

-- ZoneID: 194 - Ten Of Cups

-- ZoneID: 194 - Ten Of Swords

-- 2394 Available

-- ZoneID: 215 - Terminus Eft

-- ZoneID: 254 - Teugghia -- TODO: Abyssea NM

-- ZoneID: 102 - Thickshell Fished
-- ZoneID: 102 - Thickshell

-- ZoneID:  16 - Thinker
-- ZoneID:  16 - Thinker
-- ZoneID:  16 - Thinker
-- ZoneID:  16 - Thinker

-- ZoneID:  22 - Thinker
-- ZoneID:  22 - Thinker
-- ZoneID:  22 - Thinker
-- ZoneID:  22 - Thinker

-- ZoneID: 140 - Thousandarm Deshglesh

-- ZoneID:   9 - Thousand Eyes

-- ZoneID: 190 - Locus Thousand Eyes

-- 2403-2404 Available

-- ZoneID: 109 - Thread Leech

-- ZoneID: 194 - Three Of Batons

-- ZoneID: 194 - Three Of Coins

-- ZoneID: 194 - Three Of Cups

-- ZoneID: 194 - Three Of Swords

-- ZoneID:   1 - Thunder Elemental
-- ZoneID:   2 - Thunder Elemental
-- ZoneID:  12 - Thunder Elemental
-- ZoneID:  24 - Thunder Elemental
-- ZoneID:  24 - Thunder Elemental
-- ZoneID:  25 - Thunder Elemental
-- ZoneID:  27 - Thunder Elemental
-- ZoneID:  28 - Thunder Elemental
-- ZoneID:  29 - Thunder Elemental
-- ZoneID:  30 - Thunder Elemental
-- ZoneID:  46 - Thunder Elemental
-- ZoneID:  47 - Thunder Elemental
-- ZoneID:  58 - Thunder Elemental
-- ZoneID:  59 - Thunder Elemental
-- ZoneID:  79 - Thunder Elemental
-- ZoneID:  82 - Thunder Elemental
-- ZoneID:  83 - Thunder Elemental
-- ZoneID:  85 - Thunder Elemental
-- ZoneID:  89 - Thunder Elemental
-- ZoneID:  90 - Thunder Elemental
-- ZoneID:  92 - Thunder Elemental
-- ZoneID: 104 - Thunder Elemental
-- ZoneID: 108 - Thunder Elemental
-- ZoneID: 109 - Thunder Elemental
-- ZoneID: 120 - Thunder Elemental
-- ZoneID: 121 - Thunder Elemental
-- ZoneID: 122 - Thunder Elemental
-- ZoneID: 126 - Thunder Elemental
-- ZoneID: 127 - Thunder Elemental
-- ZoneID: 130 - Thunder Elemental
-- ZoneID: 147 - Thunder Elemental
-- ZoneID: 149 - Thunder Elemental
-- ZoneID: 153 - Thunder Elemental
-- ZoneID: 157 - Thunder Elemental
-- ZoneID: 158 - Thunder Elemental
-- ZoneID: 164 - Thunder Elemental
-- ZoneID: 173 - Thunder Elemental
-- ZoneID: 176 - Thunder Elemental
-- ZoneID: 177 - Thunder Elemental
-- ZoneID: 178 - Thunder Elemental
-- ZoneID: 184 - Thunder Elemental
-- ZoneID: 221 - Thunder Elemental

-- ZoneID:  11 - Thunder Elemental

-- ZoneID: 196 - Thunder Elemental

-- ZoneID: 200 - Thunder Elemental

-- 2414-2415 Available

-- ZoneID:   7 - Tiamat

-- ZoneID: 149 - Tigerbane Bakdak

-- ZoneID:  51 - Tinnin

-- ZoneID: 115 - Tiny Mandragora
-- ZoneID: 116 - Tiny Mandragora

-- 2420 Available

-- ZoneID: 215 - Titlacauan -- TODO: Abyssea NM

-- ZoneID: 140 - Toadstool

-- ZoneID: 190 - Tomb Bat

-- ZoneID: 195 - Tomb Mage

-- ZoneID: 195 - Tomb Warrior

-- ZoneID:  77 - Tom Tit Tat
INSERT INTO `mob_droplist` VALUES (2426,0,0,1000,4368,@COMMON);  -- Two-Leaf Mandragora Bud (Common, 15%)
INSERT INTO `mob_droplist` VALUES (2426,0,0,1000,834,@UNCOMMON); -- Ball Of Saruta Cotton (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2426,2,0,1000,4369,0);        -- Four-Leaf Mandragora Bud (Steal)

-- ZoneID: 115 - Tom Tit Tat

-- ZoneID:  15 - Tonberry Bedeviler

-- ZoneID: 160 - Tonberry Beleaguerer

-- ZoneID: 124 - Tonberry Chopper

-- ZoneID: 124 - Tonberry Creeper

-- ZoneID: 159 - Tonberry Cutter

-- ZoneID: 160 - Tonberry Decapitator

-- ZoneID: 159 - Tonberry Dismayer

-- ZoneID: 124 - Tonberry Harasser

-- ZoneID: 159 - Tonberry Harrier

-- ZoneID: 124 - Tonberry Hexer

-- ZoneID: 124 - Tonberry Jinxer
-- ZoneID: 160 - Tonberry Imprecator

-- 2439 Available

-- ZoneID: 159 - Tonberry Kinq

-- ZoneID:  15 - Tonberry Lieje -- TODO: Abyssea NM

-- ZoneID: 159 - Tonberry Maledictor

-- ZoneID: 160 - Tonberry Pontifex

-- ZoneID: 159 - Tonberry Pursuer

-- ZoneID: 124 - Tonberry Shadower

-- ZoneID: 160 - Tonberry Slasher

-- ZoneID: 159 - Tonberry Stabber

-- ZoneID: 159 - Tonberry Stalker

-- ZoneID: 160 - Tonberry Tracker

-- ZoneID: 160 - Tonberry Trailer

-- ZoneID: 147 - Topaz Quadav

-- ZoneID: 162 - Topaz Quadav

-- ZoneID: 132 - Toppling Tuber

-- ZoneID: 159 - Torama

-- ZoneID: 213 - Torama

-- ZoneID: 105 - Tottering Toby

-- ZoneID:   7 - Tracer Antlion

-- ZoneID:   7 - Tracker Antlion

-- ZoneID: 195 - Tomb Wolf

-- ZoneID: 215 - Treacle Slug

-- ZoneID:  83 - Treant

-- ZoneID: 105 - Treant

-- ZoneID:  24 - Leshachikha
-- ZoneID:  51 - Treant Sapling
-- ZoneID:  52 - Treant Sapling
-- ZoneID:  68 - Treant Sapling

-- ZoneID:  97 - Treant Sapling

-- 2465 Available

-- ZoneID: 108 - Tremor Ram

-- 2467 Available

-- ZoneID:  27 - Tres Duendes

-- ZoneID: 208 - Triarius X-Xv

-- ZoneID: 208 - Tribunus Vii-I

-- ZoneID: 126 - Trickster Kinetix

-- ZoneID: 216 - Tristitia -- TODO: Abyssea

-- ZoneID:  62 - Troll Artilleryman
-- ZoneID:  62 - Troll Combatant

-- ZoneID:  51 - Woodtroll Monk
-- ZoneID:  51 - Woodtroll Ranger
-- ZoneID:  62 - Troll Stoneworker
-- ZoneID:  62 - Troll Smelter

-- 2475 Available

-- ZoneID:  62 - Troll Cuirasser
-- ZoneID:  62 - Troll Scrimer

-- ZoneID:  52 - Troll Sabreur
-- ZoneID:  52 - Troll Surveillant
-- ZoneID:  62 - Troll Cameist
-- ZoneID:  62 - Troll Engraver

-- ZoneID:  52 - Troll Shieldbearer
-- ZoneID:  62 - Troll Gemologist

-- ZoneID:  62 - Troll Grenadier

-- ZoneID:  51 - Woodtroll Dark Knight
-- ZoneID:  51 - Woodtroll Warrior
-- ZoneID:  62 - Troll Ironworker
-- ZoneID:  62 - Troll Lapidarist

-- ZoneID:  75 Archain Chariot
INSERT INTO `mob_droplist` VALUES (2481,0,0,1000,2377,@URARE);  -- Bhaflau Card (Ultra Rare, .1%)
INSERT INTO `mob_droplist` VALUES (2481,0,0,1000,2488,@COMMON); -- Piece Of Alexandrite (Common, 10%)
INSERT INTO `mob_droplist` VALUES (2481,0,0,1000,2488,@SRARE);  -- Piece Of Alexandrite (Super Rare, 0.5%)
INSERT INTO `mob_droplist` VALUES (2481,1,1,@RARE,5374,500);    -- Opacus Cell (Group 1, Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2481,1,1,@RARE,5375,500);    -- Praecipitatio Cell (Group 1, Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2481,1,2,@SRARE,16097,200);  -- Anu's Tiara (Group 2, Super Rare 0.5%)
INSERT INTO `mob_droplist` VALUES (2481,1,2,@SRARE,15712,200);  -- Enyo's Leggings (Group 2, Super Rare 0.5%)
INSERT INTO `mob_droplist` VALUES (2481,1,2,@SRARE,14970,200);  -- Hoshikazu Tekko (Group 2, Super Rare 0.5%)
INSERT INTO `mob_droplist` VALUES (2481,1,2,@SRARE,15728,200);  -- Nemain's Sabots (Group 2, Super Rare 0.5%)
INSERT INTO `mob_droplist` VALUES (2481,1,2,@SRARE,15630,200);  -- Njord's Trousers (Group 2, Super Rare 0.5%)

-- 2482-2483 Available

-- ZoneID:  62 - Troll Machinist

-- 2485-2487 Available

-- ZoneID:  15 - Trotting Sapling

-- ZoneID: 132 - Trudging Thomas -- TODO: Abyssea NM

-- ZoneID: 191 - Trimmer

-- 2491 Available

-- ZoneID: 125 - Tulwar Scorpion

-- ZoneID: 102 - Tumbling Truffle

-- ZoneID: 111 - Tundra Tiger

-- ZoneID: 215 - Tunga -- TODO: Abyssea NM

-- ZoneID: 100 - Tunnel Worm
-- ZoneID: 101 - Tunnel Worm
-- ZoneID: 106 - Tunnel Worm
-- ZoneID: 107 - Tunnel Worm

-- 2497-2500 Available

-- ZoneID: 172 - Burrower Worm

-- ZoneID:  15 - Turul -- TODO: Abyssea NM

-- ZoneID: 216 - Tuskertrap -- TODO: Abyssea NM

-- ZoneID: 194 - Two Of Batons

-- ZoneID: 194 - Two Of Coins

-- ZoneID: 194 - Two Of Cups

-- ZoneID: 194 - Two Of Swords

-- ZoneID:  79 - Tyger

-- ZoneID: 205 - Tyrannic Tunnok

-- ZoneID: 187 - Tzee Xicu Idol

-- ZoneID: 151 - Tzee Xicu The Manifest

-- ZoneID:   5 - Uleguerand Tiger

-- ZoneID: 215 - Ulhuadshi -- TODO: Abyssea NM

-- ZoneID:  33 - Ulaern War
-- ZoneID:  33 - Ulaern Sam
-- ZoneID:  33 - Ulaern Blm
-- ZoneID:  33 - Ulaern Rdm
-- ZoneID:  33 - Ulaern Nin
-- ZoneID:  33 - Ulaern Rng
-- ZoneID:  33 - Ulaern Mnk
-- ZoneID:  33 - Ulaern Bst
-- ZoneID:  33 - Ulaern Drg
-- ZoneID:  33 - Ulaern Thf
-- ZoneID:  33 - Ulaern Drk
-- ZoneID:  33 - Ulaern Smn
-- ZoneID:  33 - Ulaern Whm
-- ZoneID:  33 - Ulaern Brd
-- ZoneID:  33 - Ulaern Pld

-- ZoneID:  33 - Ulhpemde

-- ZoneID:  33 - Ulphuabo

-- ZoneID:  33 - Ulxzomit (Mother)

-- ZoneID:  33 - Ulyovra

-- 2519 Available

-- ZoneID: 204 - Underworld Bats

-- ZoneID: 212 - Ungur

-- ZoneID: 254 - Unseelie

-- ZoneID:  29 - Unstable Cluster

-- ZoneID: 153 - Unut

-- ZoneID: 253 - Upas-Kamuy -- TODO: Abyssea NM

-- ZoneID:  25 - Upyri

-- ZoneID:   3 - Uragnite

-- ZoneID:  28 - Utukku

-- ZoneID: 195 - Utukku

-- ZoneID: 204 - Wekufe

-- ZoneID: 218 - Vadleany -- TODO: Abyssea NM

-- ZoneID:  73 - Vagrant Lindwurm
INSERT INTO `mob_droplist` VALUES (2532,0,0,1000,5374,@ALWAYS); -- Opacus Cell (Always, 100%)

-- ZoneID: 103 - Valkurm Emperor

-- ZoneID: 176 - Vampire Bat

-- ZoneID:  39 - Vanguard Smithy (Lower Level)
-- ZoneID:  39 - Vanguard Dragontamer (Lower Level)
-- ZoneID:  39 - Vanguard Necromancer (Lower Level)
-- ZoneID:  39 - Vanguard Pitfighter (Lower Level)
-- ZoneID:  39 - Vanguard Enchanter (Lower Level)
-- ZoneID:  39 - Vanguard Ronin (Lower Level)
-- ZoneID:  39 - Vanguard Maestro (Lower Level)
-- ZoneID:  39 - Vanguard Hitman (Lower Level)
-- ZoneID:  39 - Vanguard Alchemist (Lower Level)
-- ZoneID:  39 - Vanguard Welldigger (Lower Level)
-- ZoneID:  39 - Vanguard Tinkerer (Lower Level)
-- ZoneID:  39 - Vanguard Shaman (Lower Level)
-- ZoneID:  39 - Vanguard Armorer (Lower Level)
-- ZoneID:  39 - Vanguard Ambusher (Lower Level)
-- ZoneID:  39 - Vanguard Pathfinder (Lower Level)

-- ZoneID:  39 - Vanguard Smithy (Higher Level)
-- ZoneID:  39 - Vanguard Dragontamer (Higher Level)
-- ZoneID:  39 - Vanguard Necromancer (Higher Level)
-- ZoneID:  39 - Vanguard Pitfighter (Higher Level)
-- ZoneID:  39 - Vanguard Enchanter (Higher Level)
-- ZoneID:  39 - Vanguard Ronin (Higher Level)
-- ZoneID:  39 - Vanguard Maestro (Higher Level)
-- ZoneID:  39 - Vanguard Hitman (Higher Level)
-- ZoneID:  39 - Vanguard Alchemist (Higher Level)
-- ZoneID:  39 - Vanguard Welldigger (Higher Level)
-- ZoneID:  39 - Vanguard Tinkerer (Higher Level)
-- ZoneID:  39 - Vanguard Shaman (Higher Level)
-- ZoneID:  39 - Vanguard Armorer (Higher Level)
-- ZoneID:  39 - Vanguard Ambusher (Higher Level)
-- ZoneID:  39 - Vanguard Pathfinder (Higher Level)

-- ZoneID:  40 - Vanguard Pathfinder (Lower Level)
-- ZoneID:  40 - Vanguard Maestro (Lower Level)
-- ZoneID:  40 - Vanguard Ronin (Lower Level)
-- ZoneID:  40 - Vanguard Smithy (Lower Level)
-- ZoneID:  40 - Vanguard Alchemist (Lower Level)
-- ZoneID:  40 - Vanguard Shaman (Lower Level)
-- ZoneID:  40 - Vanguard Tinkerer (Lower Level)
-- ZoneID:  40 - Vanguard Hitman (Lower Level)
-- ZoneID:  40 - Vanguard Pitfighter (Lower Level)
-- ZoneID:  40 - Vanguard Enchanter (Lower Level)
-- ZoneID:  40 - Vanguard Welldigger (Lower Level)
-- ZoneID:  40 - Vanguard Armorer (Lower Level)
-- ZoneID:  40 - Vanguard Ambusher (Lower Level)
-- ZoneID:  40 - Vanguard Necromancer (Lower Level)
-- ZoneID:  40 - Vanguard Dragontamer (Lower Level)

-- ZoneID:  40 - Vanguard Pathfinder (Higher Level)
-- ZoneID:  40 - Vanguard Maestro (Higher Level)
-- ZoneID:  40 - Vanguard Ronin (Higher Level)
-- ZoneID:  40 - Vanguard Smithy (Higher Level)
-- ZoneID:  40 - Vanguard Alchemist (Higher Level)
-- ZoneID:  40 - Vanguard Shaman (Higher Level)
-- ZoneID:  40 - Vanguard Tinkerer (Higher Level)
-- ZoneID:  40 - Vanguard Hitman (Higher Level)
-- ZoneID:  40 - Vanguard Pitfighter (Higher Level)
-- ZoneID:  40 - Vanguard Enchanter (Higher Level)
-- ZoneID:  40 - Vanguard Welldigger (Higher Level)
-- ZoneID:  40 - Vanguard Armorer (Higher Level)
-- ZoneID:  40 - Vanguard Ambusher (Higher Level)
-- ZoneID:  40 - Vanguard Necromancer (Higher Level)
-- ZoneID:  40 - Vanguard Dragontamer (Higher Level)

-- ZoneID:  41 - Vanguard Smithy (Lower Level)
-- ZoneID:  41 - Vanguard Enchanter (Lower Level)
-- ZoneID:  41 - Vanguard Ambusher (Lower Level)
-- ZoneID:  41 - Vanguard Hitman (Lower Level)
-- ZoneID:  41 - Vanguard Dragontamer (Lower Level)
-- ZoneID:  41 - Vanguard Pitfighter (Lower Level)
-- ZoneID:  41 - Vanguard Shaman (Lower Level)
-- ZoneID:  41 - Vanguard Tinkerer (Lower Level)
-- ZoneID:  41 - Vanguard Maestro (Lower Level)
-- ZoneID:  41 - Vanguard Necromancer (Lower Level)
-- ZoneID:  41 - Vanguard Alchemist (Lower Level)
-- ZoneID:  41 - Vanguard Welldigger (Lower Level)
-- ZoneID:  41 - Vanguard Armorer (Lower Level)
-- ZoneID:  41 - Vanguard Pathfinder (Lower Level)
-- ZoneID:  41 - Vanguard Ronin (Lower Level)

-- ZoneID:  41 - Vanguard Smithy (Higher Level)
-- ZoneID:  41 - Vanguard Enchanter (Higher Level)
-- ZoneID:  41 - Vanguard Ambusher (Higher Level)
-- ZoneID:  41 - Vanguard Hitman (Higher Level)
-- ZoneID:  41 - Vanguard Dragontamer (Higher Level)
-- ZoneID:  41 - Vanguard Pitfighter (Higher Level)
-- ZoneID:  41 - Vanguard Shaman (Higher Level)
-- ZoneID:  41 - Vanguard Tinkerer (Higher Level)
-- ZoneID:  41 - Vanguard Maestro (Higher Level)
-- ZoneID:  41 - Vanguard Necromancer (Higher Level)
-- ZoneID:  41 - Vanguard Alchemist (Higher Level)
-- ZoneID:  41 - Vanguard Welldigger (Higher Level)
-- ZoneID:  41 - Vanguard Armorer (Higher Level)
-- ZoneID:  41 - Vanguard Pathfinder (Higher Level)
-- ZoneID:  41 - Vanguard Ronin (Higher Level)

-- ZoneID: 134 - Vanguard Smithy
-- ZoneID: 134 - Vanguard Pitfighter
-- ZoneID: 134 - Vanguard Shaman
-- ZoneID: 134 - Vanguard Enchanter
-- ZoneID: 134 - Vanguard Pathfinder
-- ZoneID: 134 - Vanguard Maestro
-- ZoneID: 134 - Vanguard Welldigger
-- ZoneID: 134 - Vanguard Armorer
-- ZoneID: 134 - Vanguard Ambusher
-- ZoneID: 134 - Vanguard Necromancer
-- ZoneID: 134 - Vanguard Ronin
-- ZoneID: 134 - Vanguard Hitman
-- ZoneID: 134 - Vanguard Dragontamer
-- ZoneID: 134 - Vanguard Alchemist
-- ZoneID: 134 - Vanguard Tinkerer

-- ZoneID: 188 - Vanguard Alchemist (Lower Level)
-- ZoneID: 188 - Vanguard Ambusher (Lower Level)
-- ZoneID: 188 - Vanguard Armorer (Lower Level)
-- ZoneID: 188 - Vanguard Enchanter (Lower Level)
-- ZoneID: 188 - Vanguard Dragontamer (Lower Level)
-- ZoneID: 188 - Vanguard Hitman (Lower Level)
-- ZoneID: 188 - Vanguard Maestro (Lower Level)
-- ZoneID: 188 - Vanguard Necromancer (Lower Level)
-- ZoneID: 188 - Vanguard Pathfinder (Lower Level)
-- ZoneID: 188 - Vanguard Pitfighter (Lower Level)
-- ZoneID: 188 - Vanguard Ronin (Lower Level)
-- ZoneID: 188 - Vanguard Shaman (Lower Level)
-- ZoneID: 188 - Vanguard Smithy (Lower Level)
-- ZoneID: 188 - Vanguard Tinkerer (Lower Level)
-- ZoneID: 188 - Vanguard Welldigger (Lower Level)

-- ZoneID: 188 - Vanguard Armorer (Higher Level)
-- ZoneID: 188 - Vanguard Dragontamer (Higher Level)
-- ZoneID: 188 - Vanguard Shaman (Higher Level)
-- ZoneID: 188 - Vanguard Welldigger (Higher Level)

-- ZoneID: 188 - Vanguard Alchemist (Higher Level)
-- ZoneID: 188 - Vanguard Hitman (Higher Level)
-- ZoneID: 188 - Vanguard Maestro (Higher Level)

-- ZoneID:  39 - Vanguard Pillager (Lower Level)
-- ZoneID:  39 - Vanguard Predator (Lower Level)
-- ZoneID:  39 - Vanguard Grappler (Lower Level)
-- ZoneID:  39 - Vanguard Trooper (Lower Level)
-- ZoneID:  39 - Vanguard Gutslasher (Lower Level)
-- ZoneID:  39 - Vanguard Amputator (Lower Level)
-- ZoneID:  39 - Vanguard Backstabber (Lower Level)
-- ZoneID:  39 - Vanguard Hawker (Lower Level)
-- ZoneID:  39 - Vanguard Mesmerizer (Lower Level)
-- ZoneID:  39 - Vanguard Neckchopper (Lower Level)
-- ZoneID:  39 - Vanguard Impaler (Lower Level)
-- ZoneID:  39 - Vanguard Vexer (Lower Level)
-- ZoneID:  39 - Vanguard Bugler (Lower Level)
-- ZoneID:  39 - Vanguard Dollmaster (Lower Level)
-- ZoneID:  39 - Vanguard Footsoldier (Lower Level)

-- ZoneID:  40 - Vanguard Mesmerizer (Lower Level)
-- ZoneID:  40 - Vanguard Vexer (Lower Level)
-- ZoneID:  40 - Vanguard Pillager (Lower Level)
-- ZoneID:  40 - Vanguard Neckchopper (Lower Level)
-- ZoneID:  40 - Vanguard Hawker (Lower Level)
-- ZoneID:  40 - Vanguard Bugler (Lower Level)
-- ZoneID:  40 - Vanguard Backstabber (Lower Level)
-- ZoneID:  40 - Vanguard Impaler (Lower Level)
-- ZoneID:  40 - Vanguard Footsoldier (Lower Level)
-- ZoneID:  40 - Vanguard Grappler (Lower Level)
-- ZoneID:  40 - Vanguard Amputator (Lower Level)
-- ZoneID:  40 - Vanguard Predator (Lower Level)
-- ZoneID:  40 - Vanguard Trooper (Lower Level)
-- ZoneID:  40 - Vanguard Gutslasher (Lower Level)
-- ZoneID:  40 - Vanguard Dollmaster (Lower Level)

-- ZoneID:  41 - Vanguard Footsoldier (Lower Level)
-- ZoneID:  41 - Vanguard Amputator (Lower Level)
-- ZoneID:  41 - Vanguard Vexer (Lower Level)
-- ZoneID:  41 - Vanguard Predator (Lower Level)
-- ZoneID:  41 - Vanguard Impaler (Lower Level)
-- ZoneID:  41 - Vanguard Grappler (Lower Level)
-- ZoneID:  41 - Vanguard Pillager (Lower Level)
-- ZoneID:  41 - Vanguard Trooper (Lower Level)
-- ZoneID:  41 - Vanguard Bugler (Lower Level)
-- ZoneID:  41 - Vanguard Dollmaster (Lower Level)
-- ZoneID:  41 - Vanguard Mesmerizer (Lower Level)
-- ZoneID:  41 - Vanguard Neckchopper (Lower Level)
-- ZoneID:  41 - Vanguard Hawker (Lower Level)
-- ZoneID:  41 - Vanguard Gutslasher (Lower Level)
-- ZoneID:  41 - Vanguard Backstabber (Lower Level)

-- ZoneID: 134 - Vanguard Trooper
-- ZoneID: 134 - Vanguard Neckchopper
-- ZoneID: 134 - Vanguard Footsoldier
-- ZoneID: 134 - Vanguard Vexer
-- ZoneID: 134 - Vanguard Backstabber
-- ZoneID: 134 - Vanguard Grappler
-- ZoneID: 134 - Vanguard Gutslasher
-- ZoneID: 134 - Vanguard Amputator
-- ZoneID: 134 - Vanguard Impaler
-- ZoneID: 134 - Vanguard Predator
-- ZoneID: 134 - Vanguard Dollmaster
-- ZoneID: 134 - Vanguard Mesmerizer
-- ZoneID: 134 - Vanguard Hawker
-- ZoneID: 134 - Vanguard Pillager
-- ZoneID: 134 - Vanguard Bugler

-- ZoneID: 185 - Vanguard Amputator (Lower Level)
-- ZoneID: 185 - Vanguard Footsoldier (Lower Level)
-- ZoneID: 185 - Vanguard Vexer (Lower Level)
-- ZoneID: 185 - Vanguard Pillager (Lower Level)
-- ZoneID: 185 - Vanguard Predator (Lower Level)
-- ZoneID: 185 - Vanguard Neckchopper (Lower Level)
-- ZoneID: 185 - Vanguard Backstabber (Lower Level)
-- ZoneID: 185 - Vanguard Dollmaster (Lower Level)
-- ZoneID: 185 - Vanguard Mesmerizer (Lower Level)
-- ZoneID: 185 - Vanguard Impaler (Lower Level)
-- ZoneID: 185 - Vanguard Hawker (Lower Level)
-- ZoneID: 185 - Vanguard Trooper (Lower Level)
-- ZoneID: 185 - Vanguard Grappler (Lower Level)
-- ZoneID: 185 - Vanguard Bugler (Lower Level)
-- ZoneID: 185 - Vanguard Gutslasher (Lower Level)

-- ZoneID:  39 - Vanguard Inciter (Lower Level)
-- ZoneID:  39 - Vanguard Skirmisher (Lower Level)
-- ZoneID:  39 - Vanguard Chanter (Lower Level)
-- ZoneID:  39 - Vanguard Partisan (Lower Level)
-- ZoneID:  39 - Vanguard Sentinel (Lower Level)
-- ZoneID:  39 - Vanguard Liberator (Lower Level)
-- ZoneID:  39 - Vanguard Oracle (Lower Level)
-- ZoneID:  39 - Vanguard Priest (Lower Level)
-- ZoneID:  39 - Vanguard Salvager (Lower Level)
-- ZoneID:  39 - Vanguard Exemplar (Lower Level)
-- ZoneID:  39 - Vanguard Prelate (Lower Level)
-- ZoneID:  39 - Vanguard Persecutor (Lower Level)
-- ZoneID:  39 - Vanguard Visionary (Lower Level)
-- ZoneID:  39 - Vanguard Assassin (Lower Level)
-- ZoneID:  39 - Vanguard Ogresoother (Lower Level)

-- ZoneID:  40 - Vanguard Sentinel (Lower Level)
-- ZoneID:  40 - Vanguard Priest (Lower Level)
-- ZoneID:  40 - Vanguard Liberator (Lower Level)
-- ZoneID:  40 - Vanguard Exemplar (Lower Level)
-- ZoneID:  40 - Vanguard Ogresoother (Lower Level)
-- ZoneID:  40 - Vanguard Chanter (Lower Level)
-- ZoneID:  40 - Vanguard Persecutor (Lower Level)
-- ZoneID:  40 - Vanguard Partisan (Lower Level)
-- ZoneID:  40 - Vanguard Skirmisher (Lower Level)
-- ZoneID:  40 - Vanguard Prelate (Lower Level)
-- ZoneID:  40 - Vanguard Visionary (Lower Level)
-- ZoneID:  40 - Vanguard Inciter (Lower Level)
-- ZoneID:  40 - Vanguard Salvager (Lower Level)
-- ZoneID:  40 - Vanguard Assassin (Lower Level)
-- ZoneID:  40 - Vanguard Oracle (Lower Level)

-- ZoneID:  41 - Vanguard Skirmisher (Lower Level)
-- ZoneID:  41 - Vanguard Sentinel (Lower Level)
-- ZoneID:  41 - Vanguard Exemplar (Lower Level)
-- ZoneID:  41 - Vanguard Inciter (Lower Level)
-- ZoneID:  41 - Vanguard Ogresoother (Lower Level)
-- ZoneID:  41 - Vanguard Priest (Lower Level)
-- ZoneID:  41 - Vanguard Prelate (Lower Level)
-- ZoneID:  41 - Vanguard Chanter (Lower Level)
-- ZoneID:  41 - Vanguard Partisan (Lower Level)
-- ZoneID:  41 - Vanguard Assassin (Lower Level)
-- ZoneID:  41 - Vanguard Visionary (Lower Level)
-- ZoneID:  41 - Vanguard Liberator (Lower Level)
-- ZoneID:  41 - Vanguard Salvager (Lower Level)
-- ZoneID:  41 - Vanguard Persecutor (Lower Level)
-- ZoneID:  41 - Vanguard Oracle (Lower Level)

-- ZoneID: 134 - Vanguard Sentinel
-- ZoneID: 134 - Vanguard Assassin
-- ZoneID: 134 - Vanguard Skirmisher
-- ZoneID: 134 - Vanguard Visionary
-- ZoneID: 134 - Vanguard Liberator
-- ZoneID: 134 - Vanguard Exemplar
-- ZoneID: 134 - Vanguard Ogresoother
-- ZoneID: 134 - Vanguard Priest
-- ZoneID: 134 - Vanguard Inciter
-- ZoneID: 134 - Vanguard Chanter
-- ZoneID: 134 - Vanguard Prelate
-- ZoneID: 134 - Vanguard Partisan
-- ZoneID: 134 - Vanguard Salvager
-- ZoneID: 134 - Vanguard Oracle
-- ZoneID: 134 - Vanguard Persecutor

-- ZoneID: 187 - Vanguard Skirmisher (Lower Level)
-- ZoneID: 187 - Vanguard Priest (Lower Level)
-- ZoneID: 187 - Vanguard Prelate (Lower Level)
-- ZoneID: 187 - Vanguard Chanter (Lower Level)
-- ZoneID: 187 - Vanguard Sentinel (Lower Level)
-- ZoneID: 187 - Vanguard Visionary (Lower Level)
-- ZoneID: 187 - Vanguard Liberator (Lower Level)
-- ZoneID: 187 - Vanguard Inciter (Lower Level)
-- ZoneID: 187 - Vanguard Exemplar (Lower Level)
-- ZoneID: 187 - Vanguard Salvager (Lower Level)
-- ZoneID: 187 - Vanguard Ogresoother (Lower Level)
-- ZoneID: 187 - Vanguard Persecutor (Lower Level)
-- ZoneID: 187 - Vanguard Assassin (Lower Level)
-- ZoneID: 187 - Vanguard Partisan (Lower Level)
-- ZoneID: 187 - Vanguard Oracle (Lower Level)

-- ZoneID:  39 - Vanguard Vindicator (Lower Level)
-- ZoneID:  39 - Vanguard Thaumaturge (Lower Level)
-- ZoneID:  39 - Vanguard Minstrel (Lower Level)
-- ZoneID:  39 - Vanguard Kusa (Lower Level)
-- ZoneID:  39 - Vanguard Beasttender (Lower Level)
-- ZoneID:  39 - Vanguard Militant (Lower Level)
-- ZoneID:  39 - Vanguard Vigilante (Lower Level)
-- ZoneID:  39 - Vanguard Protector (Lower Level)
-- ZoneID:  39 - Vanguard Mason (Lower Level)
-- ZoneID:  39 - Vanguard Drakekeeper (Lower Level)
-- ZoneID:  39 - Vanguard Constable (Lower Level)
-- ZoneID:  39 - Vanguard Purloiner (Lower Level)
-- ZoneID:  39 - Vanguard Defender (Lower Level)
-- ZoneID:  39 - Vanguard Hatamoto (Lower Level)
-- ZoneID:  39 - Vanguard Undertaker (Lower Level)

-- ZoneID:  40 - Vanguard Vindicator (Lower Level)
-- ZoneID:  40 - Vanguard Militant (Lower Level)
-- ZoneID:  40 - Vanguard Constable (Lower Level)
-- ZoneID:  40 - Vanguard Beasttender (Lower Level)
-- ZoneID:  40 - Vanguard Minstrel (Lower Level)
-- ZoneID:  40 - Vanguard Mason (Lower Level)
-- ZoneID:  40 - Vanguard Drakekeeper (Lower Level)
-- ZoneID:  40 - Vanguard Thaumaturge (Lower Level)
-- ZoneID:  40 - Vanguard Protector (Lower Level)
-- ZoneID:  40 - Vanguard Purloiner (Lower Level)
-- ZoneID:  40 - Vanguard Defender (Lower Level)
-- ZoneID:  40 - Vanguard Vigilante (Lower Level)
-- ZoneID:  40 - Vanguard Hatamoto (Lower Level)
-- ZoneID:  40 - Vanguard Kusa (Lower Level)
-- ZoneID:  40 - Vanguard Undertaker (Lower Level)

-- ZoneID:  41 - Vanguard Militant (Lower Level)
-- ZoneID:  41 - Vanguard Thaumaturge (Lower Level)
-- ZoneID:  41 - Vanguard Beasttender (Lower Level)
-- ZoneID:  41 - Vanguard Mason (Lower Level)
-- ZoneID:  41 - Vanguard Hatamoto (Lower Level)
-- ZoneID:  41 - Vanguard Vindicator (Lower Level)
-- ZoneID:  41 - Vanguard Protector (Lower Level)
-- ZoneID:  41 - Vanguard Defender (Lower Level)
-- ZoneID:  41 - Vanguard Kusa (Lower Level)
-- ZoneID:  41 - Vanguard Undertaker (Lower Level)
-- ZoneID:  41 - Vanguard Constable (Lower Level)
-- ZoneID:  41 - Vanguard Purloiner (Lower Level)
-- ZoneID:  41 - Vanguard Vigilante (Lower Level)
-- ZoneID:  41 - Vanguard Minstrel (Lower Level)
-- ZoneID:  41 - Vanguard Drakekeeper (Lower Level)

-- ZoneID: 134 - Vanguard Vindicator
-- ZoneID: 134 - Vanguard Protector
-- ZoneID: 134 - Vanguard Beasttender
-- ZoneID: 134 - Vanguard Minstrel
-- ZoneID: 134 - Vanguard Militant
-- ZoneID: 134 - Vanguard Drakekeeper
-- ZoneID: 134 - Vanguard Constable
-- ZoneID: 134 - Vanguard Defender
-- ZoneID: 134 - Vanguard Hatamoto
-- ZoneID: 134 - Vanguard Kusa
-- ZoneID: 134 - Vanguard Purloiner
-- ZoneID: 134 - Vanguard Mason
-- ZoneID: 134 - Vanguard Undertaker
-- ZoneID: 134 - Vanguard Vigilante
-- ZoneID: 134 - Vanguard Thaumaturge

-- ZoneID: 186 - Vanguard Vindicator (Lower Level)
-- ZoneID: 186 - Vanguard Militant (Lower Level)
-- ZoneID: 186 - Vanguard Beasttender (Lower Level)
-- ZoneID: 186 - Vanguard Thaumaturge (Lower Level)
-- ZoneID: 186 - Vanguard Protector (Lower Level)
-- ZoneID: 186 - Vanguard Purloiner (Lower Level)
-- ZoneID: 186 - Vanguard Vigilante (Lower Level)
-- ZoneID: 186 - Vanguard Defender (Lower Level)
-- ZoneID: 186 - Vanguard Constable (Lower Level)
-- ZoneID: 186 - Vanguard Hatamoto (Lower Level)
-- ZoneID: 186 - Vanguard Kusa (Lower Level)
-- ZoneID: 186 - Vanguard Drakekeeper (Lower Level)
-- ZoneID: 186 - Vanguard Minstrel (Lower Level)
-- ZoneID: 186 - Vanguard Mason (Lower Level)
-- ZoneID: 186 - Vanguard Undertaker (Lower Level)

-- ZoneID: 135 - Vanguard Dragon

-- ZoneID: 134 - Vanguard Eye
-- ZoneID: 134 - Vanguard Eye
-- ZoneID: 135 - Vanguard Eye
-- ZoneID: 135 - Vanguard Eye

-- ZoneID: 188 - Vanguard Ambusher (Higher Level)
-- ZoneID: 188 - Vanguard Enchanter (Higher Level)
-- ZoneID: 188 - Vanguard Necromancer (Higher Level)
-- ZoneID: 188 - Vanguard Tinkerer (Higher Level)

-- ZoneID: 188 - Vanguard Smithy (Higher Level)
-- ZoneID: 188 - Vanguard Pitfighter (Higher Level)
-- ZoneID: 188 - Vanguard Ronin (Higher Level)
-- ZoneID: 188 - Vanguard Pathfinder (Higher Level)

-- ZoneID:  39 - Vanguard Pillager (Higher Level)
-- ZoneID:  39 - Vanguard Predator (Higher Level)
-- ZoneID:  39 - Vanguard Grappler (Higher Level)
-- ZoneID:  39 - Vanguard Trooper (Higher Level)
-- ZoneID:  39 - Vanguard Gutslasher (Higher Level)
-- ZoneID:  39 - Vanguard Amputator (Higher Level)
-- ZoneID:  39 - Vanguard Backstabber (Higher Level)
-- ZoneID:  39 - Vanguard Hawker (Higher Level)
-- ZoneID:  39 - Vanguard Mesmerizer (Higher Level)
-- ZoneID:  39 - Vanguard Neckchopper (Higher Level)
-- ZoneID:  39 - Vanguard Impaler (Higher Level)
-- ZoneID:  39 - Vanguard Vexer (Higher Level)
-- ZoneID:  39 - Vanguard Bugler (Higher Level)
-- ZoneID:  39 - Vanguard Dollmaster (Higher Level)
-- ZoneID:  39 - Vanguard Footsoldier (Higher Level)

-- ZoneID:  40 - Vanguard Mesmerizer (Higher Level)
-- ZoneID:  40 - Vanguard Vexer (Higher Level)
-- ZoneID:  40 - Vanguard Pillager (Higher Level)
-- ZoneID:  40 - Vanguard Neckchopper (Higher Level)
-- ZoneID:  40 - Vanguard Hawker (Higher Level)
-- ZoneID:  40 - Vanguard Bugler (Higher Level)
-- ZoneID:  40 - Vanguard Backstabber (Higher Level)
-- ZoneID:  40 - Vanguard Impaler (Higher Level)
-- ZoneID:  40 - Vanguard Footsoldier (Higher Level)
-- ZoneID:  40 - Vanguard Grappler (Higher Level)
-- ZoneID:  40 - Vanguard Amputator (Higher Level)
-- ZoneID:  40 - Vanguard Predator (Higher Level)
-- ZoneID:  40 - Vanguard Trooper (Higher Level)
-- ZoneID:  40 - Vanguard Gutslasher (Higher Level)
-- ZoneID:  40 - Vanguard Dollmaster (Higher Level)

-- ZoneID:  41 - Vanguard Footsoldier (Higher Level)
-- ZoneID:  41 - Vanguard Amputator (Higher Level)
-- ZoneID:  41 - Vanguard Vexer (Higher Level)
-- ZoneID:  41 - Vanguard Predator (Higher Level)
-- ZoneID:  41 - Vanguard Impaler (Higher Level)
-- ZoneID:  41 - Vanguard Grappler (Higher Level)
-- ZoneID:  41 - Vanguard Pillager (Higher Level)
-- ZoneID:  41 - Vanguard Trooper (Higher Level)
-- ZoneID:  41 - Vanguard Bugler (Higher Level)
-- ZoneID:  41 - Vanguard Dollmaster (Higher Level)
-- ZoneID:  41 - Vanguard Mesmerizer (Higher Level)
-- ZoneID:  41 - Vanguard Neckchopper (Higher Level)
-- ZoneID:  41 - Vanguard Hawker (Higher Level)
-- ZoneID:  41 - Vanguard Gutslasher (Higher Level)
-- ZoneID:  41 - Vanguard Backstabber (Higher Level)

-- ZoneID:  39 - Vanguard Inciter (Higher Level)
-- ZoneID:  39 - Vanguard Skirmisher (Higher Level)
-- ZoneID:  39 - Vanguard Chanter (Higher Level)
-- ZoneID:  39 - Vanguard Partisan (Higher Level)
-- ZoneID:  39 - Vanguard Sentinel (Higher Level)
-- ZoneID:  39 - Vanguard Liberator (Higher Level)
-- ZoneID:  39 - Vanguard Oracle (Higher Level)
-- ZoneID:  39 - Vanguard Priest (Higher Level)
-- ZoneID:  39 - Vanguard Salvager (Higher Level)
-- ZoneID:  39 - Vanguard Exemplar (Higher Level)
-- ZoneID:  39 - Vanguard Prelate (Higher Level)
-- ZoneID:  39 - Vanguard Persecutor (Higher Level)
-- ZoneID:  39 - Vanguard Visionary (Higher Level)
-- ZoneID:  39 - Vanguard Assassin (Higher Level)
-- ZoneID:  39 - Vanguard Ogresoother (Higher Level)

-- ZoneID:  40 - Vanguard Sentinel (Higher Level)
-- ZoneID:  40 - Vanguard Priest (Higher Level)
-- ZoneID:  40 - Vanguard Liberator (Higher Level)
-- ZoneID:  40 - Vanguard Exemplar (Higher Level)
-- ZoneID:  40 - Vanguard Ogresoother (Higher Level)
-- ZoneID:  40 - Vanguard Chanter (Higher Level)
-- ZoneID:  40 - Vanguard Persecutor (Higher Level)
-- ZoneID:  40 - Vanguard Partisan (Higher Level)
-- ZoneID:  40 - Vanguard Skirmisher (Higher Level)
-- ZoneID:  40 - Vanguard Prelate (Higher Level)
-- ZoneID:  40 - Vanguard Visionary (Higher Level)
-- ZoneID:  40 - Vanguard Inciter (Higher Level)
-- ZoneID:  40 - Vanguard Salvager (Higher Level)
-- ZoneID:  40 - Vanguard Assassin (Higher Level)
-- ZoneID:  40 - Vanguard Oracle (Higher Level)

-- ZoneID:  41 - Vanguard Skirmisher (Higher Level)
-- ZoneID:  41 - Vanguard Sentinel (Higher Level)
-- ZoneID:  41 - Vanguard Exemplar (Higher Level)
-- ZoneID:  41 - Vanguard Inciter (Higher Level)
-- ZoneID:  41 - Vanguard Ogresoother (Higher Level)
-- ZoneID:  41 - Vanguard Priest (Higher Level)
-- ZoneID:  41 - Vanguard Prelate (Higher Level)
-- ZoneID:  41 - Vanguard Chanter (Higher Level)
-- ZoneID:  41 - Vanguard Partisan (Higher Level)
-- ZoneID:  41 - Vanguard Assassin (Higher Level)
-- ZoneID:  41 - Vanguard Visionary (Higher Level)
-- ZoneID:  41 - Vanguard Liberator (Higher Level)
-- ZoneID:  41 - Vanguard Salvager (Higher Level)
-- ZoneID:  41 - Vanguard Persecutor (Higher Level)
-- ZoneID:  41 - Vanguard Oracle (Higher Level)

-- ZoneID:  39 - Vanguard Vindicator (Higher Level)
-- ZoneID:  39 - Vanguard Thaumaturge (Higher Level)
-- ZoneID:  39 - Vanguard Minstrel (Higher Level)
-- ZoneID:  39 - Vanguard Kusa (Higher Level)
-- ZoneID:  39 - Vanguard Beasttender (Higher Level)
-- ZoneID:  39 - Vanguard Militant (Higher Level)
-- ZoneID:  39 - Vanguard Vigilante (Higher Level)
-- ZoneID:  39 - Vanguard Protector (Higher Level)
-- ZoneID:  39 - Vanguard Mason (Higher Level)
-- ZoneID:  39 - Vanguard Drakekeeper (Higher Level)
-- ZoneID:  39 - Vanguard Constable (Higher Level)
-- ZoneID:  39 - Vanguard Purloiner (Higher Level)
-- ZoneID:  39 - Vanguard Defender (Higher Level)
-- ZoneID:  39 - Vanguard Hatamoto (Higher Level)
-- ZoneID:  39 - Vanguard Undertaker (Higher Level)

-- ZoneID:  40 - Vanguard Vindicator (Higher Level)
-- ZoneID:  40 - Vanguard Militant (Higher Level)
-- ZoneID:  40 - Vanguard Constable (Higher Level)
-- ZoneID:  40 - Vanguard Beasttender (Higher Level)
-- ZoneID:  40 - Vanguard Minstrel (Higher Level)
-- ZoneID:  40 - Vanguard Mason (Higher Level)
-- ZoneID:  40 - Vanguard Drakekeeper (Higher Level)
-- ZoneID:  40 - Vanguard Thaumaturge (Higher Level)
-- ZoneID:  40 - Vanguard Protector (Higher Level)
-- ZoneID:  40 - Vanguard Purloiner (Higher Level)
-- ZoneID:  40 - Vanguard Defender (Higher Level)
-- ZoneID:  40 - Vanguard Vigilante (Higher Level)
-- ZoneID:  40 - Vanguard Hatamoto (Higher Level)
-- ZoneID:  40 - Vanguard Kusa (Higher Level)
-- ZoneID:  40 - Vanguard Undertaker (Higher Level)

-- ZoneID:  41 - Vanguard Militant (Higher Level)
-- ZoneID:  41 - Vanguard Thaumaturge (Higher Level)
-- ZoneID:  41 - Vanguard Beasttender (Higher Level)
-- ZoneID:  41 - Vanguard Mason (Higher Level)
-- ZoneID:  41 - Vanguard Hatamoto (Higher Level)
-- ZoneID:  41 - Vanguard Vindicator (Higher Level)
-- ZoneID:  41 - Vanguard Protector (Higher Level)
-- ZoneID:  41 - Vanguard Defender (Higher Level)
-- ZoneID:  41 - Vanguard Kusa (Higher Level)
-- ZoneID:  41 - Vanguard Undertaker (Higher Level)
-- ZoneID:  41 - Vanguard Constable (Higher Level)
-- ZoneID:  41 - Vanguard Purloiner (Higher Level)
-- ZoneID:  41 - Vanguard Vigilante (Higher Level)
-- ZoneID:  41 - Vanguard Minstrel (Higher Level)
-- ZoneID:  41 - Vanguard Drakekeeper (Higher Level)

-- ZoneID: 185 - Vanguard Neckchopper (Higher Level)
-- ZoneID: 185 - Vanguard Backstabber (Higher Level)
-- ZoneID: 185 - Vanguard Dollmaster (Higher Level)

-- ZoneID: 185 - Vanguard Footsoldier (Higher Level)
-- ZoneID: 185 - Vanguard Vexer (Higher Level)
-- ZoneID: 185 - Vanguard Pillager (Higher Level)
-- ZoneID: 185 - Vanguard Predator (Higher Level)

-- ZoneID:  99 - Vee Ladu The Titterer

-- ZoneID:  54 - Velionis

-- ZoneID: 134 - Velosareon

-- ZoneID:  79 - Verdelet

-- ZoneID: 253 - Verglas Golem

-- ZoneID: 253 - Veri Selen -- TODO: Abyssea NM

-- ZoneID: 143 - Veteran Quadav

-- ZoneID:  15 - Viridis Wyvern

-- ZoneID: 162 - Viscount Morax

-- ZoneID:   1 - Vodyanoi

-- ZoneID: 205 - Volcanic Bomb

-- ZoneID: 205 - Volcanic Gas

-- ZoneID: 205 - Volcano Wasp

-- ZoneID: 176 - Voll The Sharkfinned

-- ZoneID: 123 - Voluptuous Vilma

-- 2590 Available

-- ZoneID: 205 - Vouivre

-- ZoneID: 190 - Vrtra

-- ZoneID:  82 - Vulkodlac

-- ZoneID:  51 - Vulpangue

-- 2595 Available

-- ZoneID: 145 - Vuu Puqu The Beguiler

-- ZoneID: 191 - Wadi Crab

-- ZoneID: 191 - Wadi Hare
-- ZoneID: 191 - Prim Pika

-- ZoneID: 191 - Wadi Leech Fished
-- ZoneID: 191 - Wadi Leech
-- ZoneID: 191 - Couloir Leech
-- ZoneID: 193 - Bilis Leech

-- ZoneID:  22 - Wailer

-- ZoneID:  51 - Wajaom Tiger
-- ZoneID:  52 - Wajaom Tiger

-- 2602 Available

-- ZoneID:  88 - Walking Sapling
-- ZoneID: 106 - Walking Sapling
-- ZoneID: 107 - Walking Sapling

-- ZoneID:  81 - Walking Tree
-- ZoneID:  82 - Walking Tree

-- ZoneID: 104 - Walking Tree

-- ZoneID:  77 - Wamoura
INSERT INTO `mob_droplist` VALUES (2606,0,0,1000,2337,@UNCOMMON); -- Clump Of Wamoura Hair (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2606,0,0,1000,2338,@RARE);     -- Wamoura Scale (Rare, 5%)

-- ZoneID:  61 - Wamoura
-- ZoneID:  62 - Wamoura

-- ZoneID:  62 - Wamouracampa

-- ZoneID:  77 - Wamouracampa
INSERT INTO `mob_droplist` VALUES (2609,0,0,1000,2173,@RARE); -- Wamoura Cocoon (Rare, 5%)

-- ZoneID:  61 - Wamoura Prince

-- 2611 Available

-- ZoneID:  16 - Wanderer
-- ZoneID:  16 - Wanderer
-- ZoneID:  16 - Wanderer
-- ZoneID:  16 - Wanderer

-- ZoneID:  18 - Wanderer
-- ZoneID:  18 - Wanderer
-- ZoneID:  18 - Wanderer
-- ZoneID:  18 - Wanderer

-- ZoneID:  20 - Wanderer
-- ZoneID:  20 - Wanderer
-- ZoneID:  20 - Wanderer
-- ZoneID:  20 - Wanderer

-- ZoneID: 196 - Wandering Ghost

-- ZoneID:  82 - Wandering Sapling

-- ZoneID:  89 - Wandering Sapling

-- ZoneID:  96 - Wandering Sapling
-- ZoneID:  97 - Wandering Sapling
-- ZoneID: 119 - Wandering Sapling

-- ZoneID: 104 - Wandering Sapling

-- ZoneID:  89 - Feyweald Sapling

-- ZoneID: 119 - Waraxe Beak

-- ZoneID: 215 - Warbler -- TODO: Abyssea NM

-- ZoneID:  39 - Serjeant Tombstone
-- ZoneID:  39 - Serjeant Tombstone
-- ZoneID:  40 - Serjeant Tombstone
-- ZoneID:  40 - Serjeant Tombstone
-- ZoneID:  41 - Serjeant Tombstone
-- ZoneID:  41 - Serjeant Tombstone
-- ZoneID:  42 - Serjeant Tombstone

-- ZoneID: 85 - War Lizard

-- ZoneID: 149 - War Lizard

-- 2626-2627 Available

-- ZoneID:  65 - Watch Wyvern

-- ZoneID:   1 - Water Elemental
-- ZoneID:   2 - Water Elemental
-- ZoneID:  46 - Water Elemental
-- ZoneID:  47 - Water Elemental
-- ZoneID:  79 - Water Elemental
-- ZoneID:  82 - Water Elemental
-- ZoneID:  85 - Water Elemental
-- ZoneID:  90 - Water Elemental
-- ZoneID:  91 - Water Elemental
-- ZoneID:  92 - Water Elemental
-- ZoneID: 102 - Water Elemental
-- ZoneID: 104 - Water Elemental
-- ZoneID: 109 - Water Elemental
-- ZoneID: 110 - Water Elemental
-- ZoneID: 118 - Water Elemental
-- ZoneID: 121 - Water Elemental
-- ZoneID: 122 - Water Elemental
-- ZoneID: 123 - Water Elemental
-- ZoneID: 124 - Water Elemental
-- ZoneID: 130 - Water Elemental
-- ZoneID: 147 - Water Elemental
-- ZoneID: 149 - Water Elemental
-- ZoneID: 153 - Water Elemental
-- ZoneID: 159 - Water Elemental
-- ZoneID: 160 - Water Elemental
-- ZoneID: 171 - Water Elemental
-- ZoneID: 173 - Water Elemental
-- ZoneID: 176 - Water Elemental
-- ZoneID: 177 - Water Elemental
-- ZoneID: 178 - Water Elemental
-- ZoneID: 213 - Water Elemental
-- ZoneID: 220 - Water Elemental
-- ZoneID: 221 - Water Elemental

-- ZoneID: 193 - Water Elemental

-- ZoneID: 197 - Water Elemental

-- 2632 Available

-- ZoneID: 218 - Waugyl -- TODO: Abyssea NM

-- ZoneID:  16 - Weeper
-- ZoneID:  16 - Weeper
-- ZoneID:  16 - Weeper
-- ZoneID:  16 - Weeper

-- ZoneID:  18 - Weeper
-- ZoneID:  18 - Weeper
-- ZoneID:  18 - Weeper
-- ZoneID:  18 - Weeper

-- ZoneID:  20 - Weeper
-- ZoneID:  20 - Weeper
-- ZoneID:  20 - Weeper
-- ZoneID:  20 - Weeper
-- ZoneID:  22 - Weeper
-- ZoneID:  22 - Weeper
-- ZoneID:  22 - Weeper
-- ZoneID:  22 - Weeper

-- 2637 Available

-- ZoneID: 192 - Wendigo War

-- ZoneID: 196 - Wendigo War

-- ZoneID: 192 - Wendigo Blm

-- 2641 Available

-- ZoneID: 159 - Wespe

-- ZoneID: 171 - Wespe

-- ZoneID: 197 - Vespo
-- ZoneID: 197 - Wespe

-- ZoneID: 204 - Western Shadow

-- ZoneID: 215 - Wherwetrice -- TODO: Abyssea NM

-- ZoneID: 215 - Whiro -- TODO: Abyssea NM

-- 2648 Available

-- ZoneID: 124 - White Lizard

-- ZoneID:   2 - Wight Blm

-- ZoneID: 105 - Wight War
-- ZoneID: 105 - Wight Blm
-- ZoneID: 110 - Wight War
-- ZoneID: 110 - Wight Blm
-- ZoneID: 120 - Wight War
-- ZoneID: 120 - Wight Blm
-- ZoneID: 126 - Wight Blm
-- ZoneID: 126 - Wight War

-- 2652 Available

-- ZoneID: 196 - Wight War
-- ZoneID: 196 - Wight Blm

-- ZoneID: 198 - Wight War
-- ZoneID: 198 - Wight Blm

-- ZoneID: 117 - Wild Dhalmel

-- ZoneID:  77 - Peallaidh
-- ZoneID:  77 - Wild Karakul
INSERT INTO `mob_droplist` VALUES (2656,0,0,1000,878,@COMMON);    -- Karakul Skin (Common, 15%)
INSERT INTO `mob_droplist` VALUES (2656,0,0,1000,5571,@UNCOMMON); -- Slice Of Karakul Meat (Uncommon, 10%)

-- ZoneID:  79 - Wild Karakul

-- 2658-2661 Available

-- ZoneID: 200 - Wingrats

-- ZoneID: 171 - Witch Hazel

-- ZoneID:  77 - Wivre
INSERT INTO `mob_droplist` VALUES (2664,0,0,1000,2426,@RARE);   -- Wivre Horn (Rare, 5%)
INSERT INTO `mob_droplist` VALUES (2664,0,0,1000,2428,@VRARE);  -- Wivre Hide (Very Rare, 1%)
INSERT INTO `mob_droplist` VALUES (2664,0,0,1000,2427,@COMMON); -- Wivre Maul (Common, 15%)

-- ZoneID:  89 - Wivre

-- ZoneID: 124 - Woodland Sage

-- ZoneID:  40 - Woodnix Shrillwhistle

-- ZoneID:  54 - Dweomershell
-- ZoneID:  61 - Wootzshell
-- ZoneID:  61 - Orichalcumshell

-- 2669-2672 Available

-- ZoneID: 176 - Worr The Clawfisted

-- ZoneID: 196 - Wounded Wurfel

-- ZoneID: 200 - Wraith

-- ZoneID: 176 - Wuur The Sandcomber

-- ZoneID: 213 - Wyvern

-- ZoneID:  73 - Wyvern
INSERT INTO `mob_droplist` VALUES (2678,0,0,1000,5367,@VCOMMON); -- Cumulus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (2678,0,0,1000,5369,@ALWAYS);  -- Stratus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2678,0,0,1000,5369,@ALWAYS);  -- Stratus Cell (Always, 100%)

-- 2679 Available

-- ZoneID: 212 - Wyvernpoacher Drachlox

-- ZoneID: 217 - Xan -- TODO: Abyssea NM

-- ZoneID: 254 - Xibalba -- TODO: Abyssea NM

-- ZoneID:   7 - Xolotl

-- ZoneID: 215 - Yaanei -- TODO: Abyssea NM

-- ZoneID: 151 - Yaa Haqa The Profane

-- ZoneID: 253 - Yaguarogui -- TODO: Abyssea NM

-- ZoneID:  98 - Yagudo Zealot
-- ZoneID: 164 - Yagudo Zealot

-- ZoneID: 155 - Yagudo Abbot

-- ZoneID: 151 - Yagudo Abbot

-- ZoneID: 162 - Yagudo Abbot

-- ZoneID:  95 - Yagudo Acolyte

-- ZoneID: 115 - Yagudo Acolyte
-- ZoneID: 116 - Yagudo Acolyte
-- ZoneID: 117 - Yagudo Acolyte

-- ZoneID: 145 - Yagudo Acolyte

-- 2694 Available

-- ZoneID: 151 - Yagudo Assassin

-- ZoneID: 151 - Yagudo Avatar

-- ZoneID:  97 - Yagudo Chanter
-- ZoneID:  99 - Yagudo Chanter
-- ZoneID:  99 - Yagudo Conductor

-- ZoneID: 151 - Yagudo Chanter

-- ZoneID: 162 - Yagudo Chanter

-- ZoneID:  95 - Yagudo Condottiere

-- ZoneID: 151 - Yagudo Conquistador

-- ZoneID: 161 - Yagudo Conquistador
-- ZoneID: 162 - Yagudo Conquistador

-- ZoneID: 138 - Yagudo Chanter
-- ZoneID: 155 - Yagudo Conductor

-- ZoneID:  96 - Yagudo Drummer

-- ZoneID: 120 - Yagudo Drummer

-- ZoneID: 151 - Yagudo Drummer

-- ZoneID:  97 - Yagudo Eradicator
-- ZoneID:  97 - Yagudo Knight Templar
-- ZoneID:  99 - Yagudo Knight Templar
-- ZoneID:  99 - Yagudo Eradicator

-- ZoneID:  99 - Yagudo Flagellant
-- ZoneID: 155 - Yagudo Flagellant

-- ZoneID: 120 - Yagudo Herald

-- ZoneID: 151 - Yagudo Herald

-- ZoneID:  99 - Yagudo Hierogrammat
-- ZoneID: 155 - Yagudo Hierogrammat

-- ZoneID:  97 - Yagudo High Priest
-- ZoneID:  99 - Yagudo High Priest

-- ZoneID: 138 - Yagudo High Priest

-- ZoneID: 151 - Yagudo High Priest

-- ZoneID:  95 - Yagudo Initiate

-- ZoneID: 115 - Yagudo Initiate
-- ZoneID: 116 - Yagudo Initiate
-- ZoneID: 117 - Yagudo Initiate

-- 2717 Available

-- ZoneID: 145 - Yagudo Initiate

-- ZoneID:  98 - Yagudo Inquisitor
-- ZoneID:  98 - Yagudo Missionary
-- ZoneID: 164 - Yagudo Missionary

-- ZoneID: 151 - Yagudo Inquisitor

-- ZoneID: 162 - Yagudo Inquisitor

-- ZoneID: 120 - Yagudo Interrogator

-- ZoneID: 151 - Yagudo Interrogator

-- 2724 Available

-- ZoneID: 138 - Yagudo Eradicator
-- ZoneID: 138 - Yagudo Knight Templar

-- ZoneID: 151 - Yagudo Lutenist

-- ZoneID: 161 - Yagudo Lutenist
-- ZoneID: 162 - Yagudo Lutenist

-- 2728 Available

-- ZoneID:  98 - Yagudo Lutenist
-- ZoneID: 164 - Yagudo Lutenist

-- ZoneID:  95 - Yagudo Mendicant

-- ZoneID: 117 - Yagudo Mendicant
-- ZoneID: 117 - Yagudo Persecutor

-- ZoneID: 119 - Yagudo Mendicant

-- ZoneID: 145 - Yagudo Mendicant

-- 2734 Available

-- ZoneID:  99 - Yagudo Nokizaru
-- ZoneID:  99 - Yagudo Yojimbo

-- ZoneID: 120 - Yagudo Oracle

-- ZoneID: 151 - Yagudo Oracle

-- ZoneID:  68 - Anautogenous Slug
-- ZoneID:  99 - Yagudo Parasite

-- 2739 Available

-- ZoneID:  95 - Yagudo Persecutor
-- ZoneID:  96 - Yagudo Interrogator
-- ZoneID:  96 - Yagudo Herald

-- ZoneID: 145 - Yagudo Persecutor

-- ZoneID:  95 - Yagudo Piper

-- ZoneID: 117 - Yagudo Piper

-- ZoneID: 119 - Yagudo Piper

-- ZoneID: 145 - Yagudo Piper

-- ZoneID:  97 - Yagudo Prelate
-- ZoneID:  99 - Yagudo Prelate

-- ZoneID: 138 - Yagudo Prelate

-- ZoneID: 151 - Yagudo Prelate
-- ZoneID: 151 - Yagudo Prelate

-- ZoneID: 119 - Yagudo Priest

-- ZoneID: 120 - Yagudo Priest

-- ZoneID: 145 - Yagudo Priest

-- ZoneID: 151 - Yagudo Priest

-- ZoneID:  98 - Yagudo Prior
-- ZoneID: 164 - Yagudo Prior

-- ZoneID: 151 - Yagudo Prior

-- ZoneID: 161 - Yagudo Prior
-- ZoneID: 162 - Yagudo Prior

-- ZoneID:  96 - Yagudo Priest

-- 2757 Available

-- ZoneID:  98 - Yagudo Pythoness
-- ZoneID: 164 - Yagudo Pythoness

-- ZoneID:  97 - Yagudo Prioress
-- ZoneID:  99 - Yagudo Prioress

-- ZoneID:  95 - Yagudo Scribe
-- ZoneID:  96 - Yagudo Theologist

-- ZoneID: 115 - Yagudo Scribe
-- ZoneID: 116 - Yagudo Scribe
-- ZoneID: 117 - Yagudo Scribe

-- 2762 Available

-- ZoneID: 145 - Yagudo Scribe

-- ZoneID:  97 - Yagudo Sentinel
-- ZoneID:  99 - Yagudo Sentinel
-- ZoneID: 138 - Yagudo Sentinel

-- ZoneID: 151 - Yagudo Sentinel
-- ZoneID: 161 - Yagudo Zealot
-- ZoneID: 162 - Yagudo Zealot

-- ZoneID: 162 - Yagudo Sentinel

-- ZoneID:  99 - Yagudo Superior

-- ZoneID: 151 - Yagudo Templar

-- ZoneID: 164 - Yagudo Templar

-- ZoneID: 119 - Yagudo Theologist
-- ZoneID: 119 - Yagudo Votary

-- ZoneID: 120 - Yagudo Theologist
-- ZoneID: 120 - Yagudo Votary

-- ZoneID: 145 - Yagudo Theologist

-- ZoneID: 151 - Yagudo Theologist

-- 2774 Available

-- ZoneID: 151 - Yagudo Votary

-- ZoneID: 145 - Yagudo Votary

-- ZoneID:  96 - Yagudo Votary

-- ZoneID: 151 - Yagudo Zealot

-- ZoneID: 117 - Yara Ma Yha Who

-- ZoneID: 176 - Yarr The Pearleyed

-- ZoneID: 124 - Yhoator Mandragora

-- 2782 Available

-- ZoneID: 123 - Young Opo-Opo

-- ZoneID: 124 - Young Opo-Opo

-- 2785-2788 Available

-- ZoneID: 106 - Young Quadav
-- ZoneID: 107 - Young Quadav
-- ZoneID: 108 - Young Quadav

-- ZoneID: 143 - Young Quadav

-- ZoneID: 174 - Yowie

-- ZoneID:  15 - Ypotryll

-- ZoneID: 123 - Yuhtunga Mandragora

-- ZoneID:  54 - Zareehkl The Jubilant

-- ZoneID:  40 - Lost Barong

-- ZoneID:  40 - Lost Stihi

-- ZoneID:  40 - Arch Apocalyptic Beast

-- ZoneID:  41 - Nightmare Roc (Higher Level)
-- ZoneID:  41 - Nightmare Gaylas (Higher Level)
-- ZoneID:  41 - Nightmare Kraken (Higher Level)

-- ZoneID:  79 - Zikko

-- ZoneID: 177 - Zipacna

-- ZoneID:  25 - Ziphius

-- ZoneID:  90 - Zircon Quadav
-- ZoneID: 155 - Baetyl Quadav

-- ZoneID: 147 - Zircon Quadav

-- ZoneID:  30 - Ziryu

-- ZoneID:  65 - Ziz
-- ZoneID:  77 - Ziz
-- ZoneID:  77 - Zizzy Zillah
INSERT INTO `mob_droplist` VALUES (2805,0,0,1000,842,@UNCOMMON); -- Giant Bird Feather (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (2805,0,0,1000,5581,@COMMON);  -- Slice Of Ziz Meat (Common, 15%)
INSERT INTO `mob_droplist` VALUES (2805,2,0,1000,842,0);         -- Giant Bird Feather (Steal)
INSERT INTO `mob_droplist` VALUES (2805,4,0,1000,842,0);         -- Giant Bird Feather (Despoil)

-- ZoneID:  73 - Bull Bugard
-- ZoneID:  73 - Puk
-- ZoneID:  73 - Vagrant Lindwurm
-- ZoneID:  73 - Ziz
INSERT INTO `mob_droplist` VALUES (2806,0,0,1000,5374,@ALWAYS); -- Opacus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (2806,0,0,1000,5375,@ALWAYS); -- Praecipitatio Cell (Always, 100%)

-- ZoneID:  65 - Zizzy Zillah

-- ZoneID:  90 - Zombie Blm

-- ZoneID: 104 - Zombie Blm
-- ZoneID: 109 - Zombie Blm
-- ZoneID: 118 - Zombie War
-- ZoneID: 119 - Zombie War
-- ZoneID: 119 - Zombie Blm

-- ZoneID:  51 - Zoraal Jas Pkuucha

-- ZoneID:   3 - Zoredonite

-- 2812 Available

-- ZoneID: 176 - Zuug The Shoreleaper

-- ZoneID: 153 - Snaggletooth Peapuk

-- ZoneID: 212 - Pygmytoise

-- ZoneID: 212 - Boulder Eater

-- ZoneID: 147 - Gobhu Gascon

-- ZoneID: 147 - Devyu Headhunter

-- ZoneID: 178 - Kirin

-- ZoneID: 178 - Mother Globe

-- ZoneID: 178 - Faust

-- ZoneID: 178 - Ullikummi

-- ZoneID: 178 - Olla Grande

-- ZoneID: 178 - Aura Statue

-- ZoneID: 143 - Nighu Nestfender

-- 2826-2828 Available

-- ZoneID:  72 - Wulgaru

-- ZoneID: 148 - Zadha Adamantking

-- ZoneID: 153 - Voluptuous Vivian

-- ZoneID: 151 - Yagudo Parasite

-- ZoneID: 151 - Yagudo Flagellant
-- ZoneID: 151 - Yagudo Flagellant

-- ZoneID: 151 - Yagudo Conductor
-- ZoneID: 151 - Yagudo Conductor

-- ZoneID:   4 - Shen

-- ZoneID: 194 - Ah Puch

-- ZoneID: 143 - Bughi Howlblade

-- ZoneID: 143 - Zighi Boneeater

-- ZoneID: 143 - Nomho Crimsonarmor

-- ZoneID: 190 - Spook

-- ZoneID: 147 - Dadha Hundredmask

-- ZoneID: 147 - Gedha Evileye

-- ZoneID:  35 - Ixaern Drg

-- ZoneID:  35 - Ixaern Drk

-- 2845 Available

-- ZoneID: 115 - Savanna Rarab

-- ZoneID:   2 - Orctrap

-- ZoneID: 107 - Bubbly Bernie

-- ZoneID: 147 - Gabhu Unvanquished

-- ZoneID: 147 - Zokhu Blackcloud

-- ZoneID: 147 - Bigho Headtaker

-- ZoneID: 109 - Bowho Warmonger

-- ZoneID:  99 - Zhuu Buxu The Silent

-- ZoneID: 145 - Zhuu Buxu The Silent

-- 2855 Available

-- ZoneID:  37 - Goblin Slaughterman
-- ZoneID:  37 - Moblin Dustman
-- ZoneID:  37 - Telchines Bard
-- ZoneID:  37 - Telchines White Mage
-- ZoneID:  37 - Telchines Dragoon
-- ZoneID:  37 - Telchines Monk
-- ZoneID:  37 - Praetorian Guard Cccxi
-- ZoneID:  37 - Praetorian Guard Ccxx
-- ZoneID:  37 - Praetorian Guard Cxlviii
-- ZoneID:  37 - Praetorian Guard Lxxiii
-- ZoneID:  37 - Fire Elemental (Eastern)
-- ZoneID:  37 - Ice Elemental (Eastern)
-- ZoneID:  37 - Air Elemental (Eastern)
-- ZoneID:  37 - Earth Elemental (Eastern)
-- ZoneID:  37 - Thunder Elemental (Eastern)
-- ZoneID:  37 - Water Elemental (Eastern)
-- ZoneID:  37 - Dark Elemental (Eastern)
-- ZoneID:  37 - Enhanced Slime
-- ZoneID:  37 - Enhanced Tiger
-- ZoneID:  37 - Enhanced Mandragora
-- ZoneID:  37 - Enhanced Pugil
-- ZoneID:  37 - Enhanced Beetle
-- ZoneID:  37 - Enhanced Lizard
-- ZoneID:  37 - Enhanced Vulture
-- ZoneID:  38 - Bardha
-- ZoneID:  38 - Metalloid Amoeba
-- ZoneID:  38 - Barometz
-- ZoneID:  38 - Borametz
-- ZoneID:  38 - Fir Bholg Thf Ev
-- ZoneID:  38 - Fir Bholg Pld Gk
-- ZoneID:  38 - Fir Bholg Sam Hm
-- ZoneID:  38 - Fir Bholg Rdm Mr
-- ZoneID:  38 - Fir Bholg Blm Tt
-- ZoneID:  38 - Mountain Buffalo
-- ZoneID:  38 - Cornu

-- ZoneID:  38 - Barometz
-- ZoneID:  38 - Borametz

-- ZoneID:  37 - Skadi
-- ZoneID:  37 - Thrym
-- ZoneID:  37 - Beli
-- ZoneID:  37 - Kari
-- ZoneID:  37 - Kindred Warrior
-- ZoneID:  37 - Kindred Dark Knight
-- ZoneID:  37 - Kindred Summoner
-- ZoneID:  37 - Kindred Black Mage
-- ZoneID:  37 - Cryptonberry Charmer
-- ZoneID:  37 - Cryptonberry Skulker
-- ZoneID:  37 - Cryptonberry Abductor
-- ZoneID:  37 - Cryptonberry Designator
-- ZoneID:  38 - Arboricole Raven
-- ZoneID:  38 - Armoury Crate
-- ZoneID:  38 - Apollyon Scavenger
-- ZoneID:  38 - Adamantshell
-- ZoneID:  38 - Inhumer
-- ZoneID:  38 - Apollyon Cleaner
-- ZoneID:  38 - Apollyon Cleaner

-- 2859 Available

-- ZoneID:  37 - Mystic_Avatar (Eastern Tower)
-- ZoneID:  38 - Arboricole Hornet
-- ZoneID:  38 - Arboricole Opo-Opo
-- ZoneID:  38 - Arboricole Spider
-- ZoneID:  38 - Arboricole Beetle
-- ZoneID:  38 - Arboricole Crawler
-- ZoneID:  38 - Apollyon Sapling

-- ZoneID:  38 - Air Elemental
-- ZoneID:  38 - Dark Elemental
-- ZoneID:  38 - Earth Elemental
-- ZoneID:  38 - Fire Elemental
-- ZoneID:  38 - Ice Elemental
-- ZoneID:  38 - Light Elemental
-- ZoneID:  38 - Water Elemental
-- ZoneID:  38 - Thunder Elemental
-- ZoneID:  38 - Kerkopes
-- ZoneID:  38 - Kerkopes
-- ZoneID:  38 - Sirin

-- ZoneID:  37 - Temenos Aern Pld
-- ZoneID:  37 - Temenos Aern Pld
-- ZoneID:  37 - Temenos Aern Nin
-- ZoneID:  37 - Temenos Aern Drg
-- ZoneID:  37 - Temenos Aern War
-- ZoneID:  37 - Temenos Aern Blm
-- ZoneID:  37 - Temenos Aern Brd
-- ZoneID:  37 - Temenos Aern Mnk
-- ZoneID:  37 - Temenos Aern Sam
-- ZoneID:  37 - Temenos Aern Thf
-- ZoneID:  37 - Temenos Aern Rng
-- ZoneID:  37 - Temenos Aern Bst
-- ZoneID:  37 - Temenos Aern Whm
-- ZoneID:  37 - Temenos Aern Rdm
-- ZoneID:  37 - Temenos Aern Smn
-- ZoneID:  37 - Temenos Aern Drk
-- ZoneID:  37 - Temenos Aern Nin
-- ZoneID:  37 - Temenos Aern Drg
-- ZoneID:  37 - Temenos Aern War
-- ZoneID:  37 - Temenos Aern Blm
-- ZoneID:  37 - Temenos Aern Brd
-- ZoneID:  37 - Temenos Aern Mnk
-- ZoneID:  37 - Temenos Aern Sam
-- ZoneID:  37 - Temenos Aern Thf
-- ZoneID:  37 - Temenos Aern Rng
-- ZoneID:  37 - Temenos Aern Bst
-- ZoneID:  37 - Temenos Aern Whm
-- ZoneID:  37 - Temenos Aern Rdm
-- ZoneID:  37 - Temenos Aern Smn
-- ZoneID:  37 - Temenos Aern Drk
-- ZoneID:  38 - Gorynich
-- ZoneID:  38 - Flying Spear
-- ZoneID:  38 - Criosphinx
-- ZoneID:  38 - Hieracosphinx
-- ZoneID:  38 - Troglodyte Dhalmel

-- ZoneID:  37 - Abyssdweller Jhabdebb
-- ZoneID:  37 - Orichalcum Quadav
-- ZoneID:  37 - Pee Qoho The Python
-- ZoneID:  38 - Kronprinz Behemoth

-- ZoneID:  38 - Nergal
-- ZoneID:  38 - Bata
-- ZoneID:  38 - Aeshma

-- ZoneID:  37 - Goblin Warlord
-- ZoneID:  37 - Goblin Fencer
-- ZoneID:  37 - Goblin Theurgist
-- ZoneID:  38 - Apollyon Demon Blm
-- ZoneID:  38 - Apollyon Demon Pld
-- ZoneID:  38 - Apollyon Demon Drk
-- ZoneID:  38 - Apollyon Demon Rdm
-- ZoneID:  38 - Apollyon Taurus
-- ZoneID:  38 - Apollyon Ahriman

-- 2866 Available

-- ZoneID: 192 - Magicked Bones

-- ZoneID: 169 - Brazen Bones

-- ZoneID: 195 - Lich C Magnus

-- ZoneID: 195 - Skull Of Envy

-- ZoneID: 195 - Skull Of Gluttony

-- ZoneID: 195 - Skull Of Greed

-- ZoneID: 195 - Skull Of Lust

-- ZoneID: 195 - Skull Of Pride

-- ZoneID: 195 - Skull Of Sloth

-- ZoneID: 195 - Skull Of Wrath

-- 2877 Available

-- ZoneID: 167 - Dabilla

-- ZoneID: 167 - Manes

-- ZoneID: 204 - Utukku

-- ZoneID: 191 - Goblin Healer

-- ZoneID: 167 - Wurdalak

-- ZoneID: 195 - Shade War
-- ZoneID: 195 - Shade Rng
-- ZoneID: 195 - Shade Thf
-- ZoneID: 195 - Shade Drk

-- ZoneID: 195 - Ka War
-- ZoneID: 195 - Ka Blm
-- ZoneID: 195 - Ka Rng
-- ZoneID: 195 - Ka Thf

-- ZoneID:  54 - Qutrub Drk
-- ZoneID:  54 - Qutrub Blm

-- ZoneID: 195 - Cwn Cyrff

-- 2887-2889 Available

-- ZoneID: 153 - Ellyllon

-- ZoneID:  52 - Harvestman

-- ZoneID: 167 - Bloodsucker Nm

-- ZoneID:  52 - Mahishasura

-- ZoneID:  52 - Nis Puk

-- ZoneID:   2 - Tempest Tigon

-- 2896-2897 Available

-- ZoneID:   4 - Lancet Jagil

-- ZoneID:   4 - Serra

-- ZoneID:  68 - Cave Pugil

-- ZoneID:  40 - Gibhe Fleshfeaster

-- ZoneID:  40 - Qupho Bloodspiller

-- ZoneID:  40 - Tezha Ironclad

-- ZoneID:  40 - Varhu Bodysnatcher

-- 2905 Available

-- ZoneID: 186 - Gudha Effigy

-- ZoneID: 186 - Gunhi Noondozer
-- ZoneID: 186 - Zevho Fallsplitter
-- ZoneID: 186 - Gipha Manameister
-- ZoneID: 186 - Kodho Cannonball

-- ZoneID:  42 - Diabolos Spade
-- ZoneID:  42 - Diabolos Heart
-- ZoneID:  42 - Diabolos Diamond
-- ZoneID:  42 - Diabolos Club

-- ZoneID:  39 - Stcemqestcint

-- ZoneID:  39 - Nantina

-- 2911 Available

-- ZoneID: 105 - Stalking Sapling
-- ZoneID: 153 - Boyahda Sapling

-- ZoneID:  82 - Gnoletrap

-- ZoneID: 213 - Goblins Leech
-- ZoneID: 213 - Goblins Leech Hi

-- ZoneID: 147 - Platinum Quadav

-- ZoneID: 193 - Slash Pine

-- ZoneID: 144 - Maat Thf

-- ZoneID: 109 - Malboro

-- ZoneID:  90 - Malboro

-- ZoneID:  91 - Ochu

-- 2921 Available

-- ZoneID: 123 - Overgrown Rose

-- 2923 Available

-- ZoneID:  83 - Demonic Rose

-- ZoneID: 154 - Demonic Rose

-- ZoneID:   4 - Viscous Clot

-- 2927-2929 Available

-- ZoneID:   4 - Ghost Crab Fished
-- ZoneID:   4 - Grindylow
-- ZoneID: 123 - Bigclaw Fished
-- ZoneID: 125 - Bigclaw Fished

-- 2931 Available

-- ZoneID:   4 - Coralline Uragnite

-- ZoneID:   4 - Coastal Opo-Opo

-- ZoneID:   4 - Alraune

-- ZoneID: 120 - Sauromugue Skink

-- ZoneID:  79 - Aynu-Kaysey

-- ZoneID: 111 - Calcabrina

-- ZoneID: 106 - Bedrock Barry

-- ZoneID: 107 - Tococo

-- ZoneID: 143 - Quvho Deathhurler

-- ZoneID: 100 - Amanita

-- ZoneID: 102 - Slumbering Samwell

-- ZoneID: 112 - Duke Focalor

-- ZoneID:   7 - Sargas

-- ZoneID: 113 - Tegmine

-- ZoneID: 122 - Martinet

-- ZoneID: 197 - Aqrabuamelu

-- ZoneID: 184 - Tyrant

-- ZoneID: 158 - Autarch

-- ZoneID:  89 - Kotan-Kor Kamuy

-- ZoneID:  90 - Sugaar

-- ZoneID:  52 - Wivre

-- ZoneID:   7 - Sekhmet

-- ZoneID: 108 - Ghillie Dhu

-- ZoneID: 108 - Highlander Lizard

-- ZoneID: 261 - Blanched Mandragora

-- 2957 Available

-- ZoneID: 261 - Deathmaw Orobon -- TODO: add to orobon lure family mixin

-- ZoneID: 261 - Fernfelling Chapuli

-- ZoneID: 261 - Careening Twitherym

-- ZoneID: 261 - Frenzied Mantis

-- ZoneID: 261 - Belaboring Wasp
-- ZoneID: 261 - Undergrowth Hornet

-- ZoneID: 261 - Longclaw Raptor

-- ZoneID: 261 - Velkk Torturer

-- ZoneID: 261 - Resplendent Luckybug

-- ZoneID: 261 - Sedge Scorpion

-- 2967 Available

-- ZoneID: 261 - Knobby Treant

-- ZoneID: 261 - Colossal Spider

-- ZoneID: 261 - Downy Emerald

-- ZoneID: 190 - Barbastelle

-- ZoneID: 262 - Zoldeff Jagil

-- ZoneID: 262 - Hoary Craklaw

-- ZoneID: 262 - Perfidious Crab

-- ZoneID: 262 - Bellicose Tarichuk

-- ZoneID: 117 - Habrok

-- ZoneID: 262 - Vampire Leech

-- ZoneID: 262 - Velkk Sage

-- ZoneID: 262 - Velkk Destructeur

-- ZoneID: 262 - Scummy Slug

-- ZoneID: 262 - Phantasmagoric Umbril

-- ZoneID: 262 - Skinsipper Chigoe -- TODO: add to family mixin

-- ZoneID: 117 - Herbage Hunter

-- ZoneID: 262 - Primordial Orobon -- TODO: add to orobon lure family mixin

-- ZoneID: 262 - Vorst Gnat

-- ZoneID:  84 - Chaneque

-- ZoneID:  95 - Ramponneau

-- ZoneID: 116 - Duke Decapod

-- ZoneID: 190 - Ankou

-- ZoneID:  98 - Hyakinthos

-- ZoneID:  91 - Lamina

-- ZoneID: 119 - Chonchon

-- ZoneID: 110 - Eldritch Edge

-- ZoneID: 120 - Blighting Brand

-- ZoneID:  95 - Belladonna

-- ZoneID:  54 - Lamia No19

-- ZoneID: 101 - Rambukk

-- ZoneID: 103 - Hippomaritimus

-- ZoneID: 123 - Koropokkur

-- ZoneID: 115 - Numbing Norman

-- ZoneID: 103 - Metal Shears

-- ZoneID: 104 - Sappy Sycamore

-- ZoneID: 105 - Skirling Liger

-- ZoneID: 118 - Wake Warder Wanda

-- 3005 Available

-- ZoneID:  27 - Aqueduct Spider
-- ZoneID:  28 - Aqueduct Spider

-- ZoneID: 153 - Mourning Crawler

-- ZoneID: 197 - King Crawler

-- ZoneID: 171 - Morille Mortelle

-- ZoneID: 200 - Hovering Hotpot

-- ZoneID:  54 - Lamie No9

-- ZoneID: 153 - Elder Goobbue

-- ZoneID: 216 - Boartrap

-- ZoneID: 121 - Huwasi

-- ZoneID: 151 - Lii Jixa The Somnolist

-- ZoneID: 166 - Mucoid Mass

-- ZoneID: 119 - Patripatan

-- ZoneID: 151 - Saa Doyi The Fervid

-- ZoneID: 191 - Teporingo

-- ZoneID: 173 - Thoon

-- ZoneID:  81 - Goblintrap

-- ZoneID: 109 - Nizho Bladebender

-- ZoneID:  82 - Boll Weevil

-- ZoneID:  88 - Drachenlizard

-- ZoneID:  91 - Champion Crawler

-- ZoneID:  61 - Ignamoth

-- ZoneID:  88 - Ankabut

-- ZoneID: 141 - Kegpaunch Doshgnosh

-- ZoneID:  82 - Drumskull Zogdregg

-- ZoneID:  92 - Batho Mercifulheart

-- ZoneID:  92 - Dadha Hundredmask

-- ZoneID:  92 - Eatho Cruelheart

-- 3033 Available

-- ZoneID:  96 - Ratatoskr

-- 3035 Available

-- ZoneID: 193 - Agar Agar

-- ZoneID:  90 - Nommo

-- ZoneID:  91 - Delicieuse Delphine

-- ZoneID: 153 - Leshonki

-- ZoneID: 169 - Konjac

-- ZoneID:  51 - Chelicerata

-- ZoneID: 137 - Tikbalang

-- ZoneID:  84 - Burlibix Brawnback

-- ZoneID:  84 - Habergoass

-- ZoneID: 136 - Grandgoule

-- ZoneID:   4 - Splacknuck

-- ZoneID: 161 - Marquis Sabnock

-- ZoneID: 114 - Donnergugi

-- ZoneID: 204 - Mind Hoarder

-- ZoneID:  83 - Big Bang
-- ZoneID:  96 - Demoiselle Desolee

-- ZoneID: 200 - Hazmat

-- ZoneID: 104 - Supplespine Mujwuj

-- ZoneID: 190 - Gwyllgi

-- ZoneID: 198 - Trembler Tabitha

-- ZoneID: 119 - Naa Zeku The Unwaiting

-- ZoneID:  97 - Centipedal Centruroides

-- ZoneID:  25 - Okyupete

-- ZoneID: 143 - Behya Hundredwall

-- ZoneID: 126 - Slippery Sucker

-- ZoneID: 166 - Gloom Eye

-- ZoneID: 145 - Quu Xijo The Illusory

-- ZoneID: 112 - Timeworn Warrior

-- ZoneID: 105 - Eyegouger

-- ZoneID: 111 - Humbaba

-- ZoneID: 197 - Dynast Beetle

-- ZoneID:  81 - Myradrosh

-- ZoneID: 114 - Nandi

-- ZoneID: 124 - Powderer Penny

-- ZoneID: 124 - Hoar-Knuckled Rimberry

-- ZoneID: 124 - Acolnahuacatl

-- ZoneID: 169 - Canal Moocher

-- ZoneID:   5 - Skvader

-- ZoneID:   5 - Magnotaur

-- ZoneID: 125 - Calchas

-- ZoneID:  83 - Warabouc

-- ZoneID:  51 - Gharial

-- ZoneID:  25 - Mantrap

-- 3078 Available

-- ZoneID: 120 - Thunderclaw Thuban

-- ZoneID: 194 - Legalox Heftyhind

-- ZoneID:   4 - Shankha

-- ZoneID:  81 - Melusine
-- ZoneID:  88 - Peaseblossom
-- ZoneID:  95 - Tiffenotte

-- ZoneID:  68 - Lizardtrap

-- ZoneID:  25 - Goaftrap

-- ZoneID:  89 - Sarcopsylla

-- ZoneID: 122 - Rogue Receptacle

-- ZoneID: 200 - Frogamander

-- ZoneID: 113 - Killer Jonny

-- ZoneID: 161 - Marquis Naberius

-- ZoneID: 114 - Sabotender Corrido

-- ZoneID:  54 - Euryale

-- ZoneID: 198 - Gloombound Lurker

-- ZoneID: 198 - Lesath

-- ZoneID:  97 - Muq Shabeel

-- ZoneID: 193 - Donggu

-- ZoneID: 126 - Qoofim

-- ZoneID: 110 - Ravenous Crawler

-- ZoneID: 112 - Barbaric Weapon

-- ZoneID:  98 - Herensugue

-- ZoneID:   5 - King Buffalo

-- 3101-3106 Available

-- ZoneID: 178 - Aura Sculpture

-- ZoneID: 169 - Starborer

-- ZoneID: 185 - Bladeburner Rokgevok

-- ZoneID: 185 - Steelshank Kratzvatz

-- ZoneID: 185 - Bloodfist Voshgrosh

-- ZoneID: 185 - Spellspear Djokvukk

-- ZoneID: 185 - Arch Overlord Tombstone

-- ZoneID: 134 - Adamantking Effigy

-- ZoneID: 135 - Adamantking Effigy

-- ZoneID: 134 - Goblin Replica

-- ZoneID: 135 - Goblin Replica

-- ZoneID: 134 - Serjeant Tombstone

-- ZoneID: 135 - Serjeant Tombstone

-- ZoneID: 134 - Avatar Icon

-- ZoneID: 135 - Avatar Icon

-- ZoneID:  39 - Nightmare Flytrap (Higher Level)
-- ZoneID:  39 - Nightmare Funguar (Higher Level)
-- ZoneID:  39 - Nightmare Fly (Higher Level)

-- ZoneID:  39 - Nightmare Sabotender (Higher Level)
-- ZoneID:  39 - Nightmare Hippogryph (Higher Level)
-- ZoneID:  39 - Nightmare Sheep (Higher Level)

-- ZoneID:  39 - Nightmare Goobbue (Higher Level)
-- ZoneID:  39 - Nightmare Manticore (Higher Level)
-- ZoneID:  39 - Nightmare Treant (Higher Level)

-- ZoneID:  39 - Lost Fairy Ring

-- ZoneID:  39 - Lost Stcemqestcint

-- ZoneID:  39 - Lost Nantina

-- ZoneID:  39 - Arch Christelle

-- ZoneID:   5 - Frost Flambeau

-- ZoneID:  41 - Arch Antaeus

-- ZoneID:  41 - Scolopendra

-- ZoneID:  41 - Stringes

-- ZoneID:  41 - Suttung

-- ZoneID:  41 - Lost Scolopendra

-- ZoneID:  41 - Lost Stringes

-- ZoneID:  41 - Lost Suttung

-- ZoneID:  42 - Diabolos Nox
-- ZoneID:  42 - Diabolos Letum
-- ZoneID:  42 - Diabolos Umbra
-- ZoneID:  42 - Diabolos Somnus

-- 3138-3139 Available

-- ZoneID: 118 - Backoo

-- ZoneID: 153 - Ancient Goobbue

-- ZoneID: 120 - Bashe

-- ZoneID: 134 - Hydra Ranger (Lower Level)
-- ZoneID: 134 - Hydra Dark Knight (Lower Level)
-- ZoneID: 134 - Hydra Samurai (Lower Level)

-- ZoneID: 134 - Hydra Ranger (Higher Level)

-- ZoneID: 134 - Hydra Summoner (Lower Level)
-- ZoneID: 134 - Hydra Beastmaster (Lower Level)
-- ZoneID: 134 - Hydra Dragoon (Lower Level)

-- ZoneID: 134 - Hydra Summoner (Higher Level)

-- ZoneID: 185 - Vanguard Mesmerizer (Higher Level)
-- ZoneID: 185 - Vanguard Hawker (Higher Level)
-- ZoneID: 185 - Vanguard Impaler (Higher Level)

-- ZoneID: 185 - Vanguard Amputator (Higher Level)

-- ZoneID: 185 - Vanguard Grappler (Higher Level)
-- ZoneID: 185 - Vanguard Trooper (Higher Level)
-- ZoneID: 185 - Vanguard Bugler (Higher Level)
-- ZoneID: 185 - Vanguard Gutslasher (Higher Level)

-- 3150 Available

-- ZoneID: 135 - Satellite Knuckles

-- ZoneID: 135 - Satellite Daggers

-- ZoneID: 135 - Satellite Longswords

-- ZoneID: 135 - Satellite Claymores

-- ZoneID: 135 - Satellite Tabars

-- ZoneID: 135 - Satellite Great Axes

-- ZoneID: 135 - Satellite Scythes

-- ZoneID: 135 - Satellite Spears

-- ZoneID: 135 - Satellite Kunai

-- ZoneID: 135 - Satellite Tachi

-- ZoneID: 135 - Satellite Hammers

-- ZoneID: 135 - Satellite Staves

-- ZoneID: 135 - Satellite Longbows

-- ZoneID: 135 - Satellite Guns

-- ZoneID: 135 - Satellite Horns

-- ZoneID: 135 - Satellite Shield

-- 3167 Available

-- ZoneID:  81 - Capricornus
-- ZoneID:  82 - Capricornus
-- ZoneID: 101 - Capricornus
-- ZoneID: 104 - Capricornus

-- ZoneID:  81 - Yacumama
-- ZoneID:  82 - Yacumama
-- ZoneID: 101 - Yacumama
-- ZoneID: 104 - Yacumama

-- ZoneID:  88 - Lamprey Lord
-- ZoneID:  90 - Lamprey Lord
-- ZoneID: 106 - Lamprey Lord
-- ZoneID: 109 - Lamprey Lord

-- ZoneID:  88 - Shoggoth
-- ZoneID:  90 - Shoggoth
-- ZoneID: 106 - Shoggoth
-- ZoneID: 109 - Shoggoth

-- ZoneID:  95 - Jyeshtha
-- ZoneID:  97 - Jyeshtha
-- ZoneID: 115 - Jyeshtha
-- ZoneID: 119 - Jyeshtha

-- ZoneID:  95 - Farruca Fly
-- ZoneID:  97 - Farruca Fly
-- ZoneID: 115 - Farruca Fly
-- ZoneID: 119 - Farruca Fly

-- ZoneID:  84 - Skuld
-- ZoneID:  91 - Skuld
-- ZoneID:  98 - Skuld
-- ZoneID: 105 - Skuld
-- ZoneID: 110 - Skuld
-- ZoneID: 120 - Skuld

-- ZoneID:  84 - Urd
-- ZoneID:  91 - Urd
-- ZoneID:  98 - Urd
-- ZoneID: 105 - Urd
-- ZoneID: 110 - Urd
-- ZoneID: 120 - Urd

-- ZoneID: 111 - Erebus
-- ZoneID: 112 - Erebus
-- ZoneID: 136 - Erebus
-- ZoneID: 137 - Erebus

-- ZoneID: 111 - Feuerunke
-- ZoneID: 112 - Feuerunke
-- ZoneID: 136 - Feuerunke
-- ZoneID: 137 - Feuerunke

-- ZoneID: 102 - Chesma
-- ZoneID: 108 - Chesma
-- ZoneID: 117 - Chesma

-- ZoneID: 102 - Tammuz
-- ZoneID: 108 - Tammuz
-- ZoneID: 117 - Tammuz

-- ZoneID:  81 - Krabkatoa
-- ZoneID:  82 - Krabkatoa
-- ZoneID: 101 - Krabkatoa
-- ZoneID: 104 - Krabkatoa

-- ZoneID:  88 - Blobdingnag
-- ZoneID:  90 - Blobdingnag
-- ZoneID: 106 - Blobdingnag
-- ZoneID: 109 - Blobdingnag

-- ZoneID:  95 - Orcus
-- ZoneID:  97 - Orcus
-- ZoneID: 115 - Orcus
-- ZoneID: 119 - Orcus

-- ZoneID:  84 - Verthandi
-- ZoneID:  91 - Verthandi
-- ZoneID:  98 - Verthandi
-- ZoneID: 105 - Verthandi
-- ZoneID: 110 - Verthandi
-- ZoneID: 120 - Verthandi

-- ZoneID: 102 - Dawon
-- ZoneID: 108 - Dawon
-- ZoneID: 117 - Dawon

-- ZoneID:  81 - Yilbegan
-- ZoneID:  82 - Yilbegan
-- ZoneID:  84 - Yilbegan
-- ZoneID:  88 - Yilbegan
-- ZoneID:  90 - Yilbegan
-- ZoneID:  91 - Yilbegan
-- ZoneID:  95 - Yilbegan
-- ZoneID:  97 - Yilbegan
-- ZoneID:  98 - Yilbegan
-- ZoneID: 101 - Yilbegan
-- ZoneID: 102 - Yilbegan
-- ZoneID: 104 - Yilbegan
-- ZoneID: 105 - Yilbegan
-- ZoneID: 106 - Yilbegan
-- ZoneID: 108 - Yilbegan
-- ZoneID: 109 - Yilbegan
-- ZoneID: 110 - Yilbegan
-- ZoneID: 111 - Yilbegan
-- ZoneID: 112 - Yilbegan
-- ZoneID: 115 - Yilbegan
-- ZoneID: 117 - Yilbegan
-- ZoneID: 119 - Yilbegan
-- ZoneID: 120 - Yilbegan
-- ZoneID: 136 - Yilbegan
-- ZoneID: 137 - Yilbegan

-- ZoneID: 111 - Lord Ruthven
-- ZoneID: 112 - Lord Ruthven
-- ZoneID: 136 - Lord Ruthven
-- ZoneID: 137 - Lord Ruthven

-- 3187 Available

-- ZoneID: 191 - Natty Gibbon

-- 3189 Available

-- ZoneID: 204 - Balayang

-- ZoneID: 204 - Sentient Carafe

-- ZoneID: 174 - Kuftal Delver

-- 3193 Available

-- ZoneID: 213 - Babaulas
-- ZoneID: 213 - Boribaba

-- 3195 Available

-- ZoneID: 166 - Hovering Oculus

-- ZoneID: 153 - Viseclaw

-- ZoneID: 169 - Deviling Bats

-- ZoneID: 169 - Drowned Bones

-- ZoneID: 169 - Plunderer Crab

-- ZoneID: 169 - Poroggo Excavator

-- ZoneID: 169 - Rapier Scorpion

-- ZoneID: 169 - Sodden Bones

-- ZoneID: 169 - Blackwater Pugil

-- ZoneID: 169 - Flume Toad

-- 3206 Available

-- ZoneID: 134 - Angra Mainyu

-- ZoneID: 208 - Sabotender Bailarin

-- ZoneID: 208 - Sabotender Bailarina

-- ZoneID: 134 - Hitaume

-- ZoneID: 134 - Cavanneche

-- ZoneID: 134 - Arch Angra Mainyu

-- ZoneID: 134 - Hydra Paladin (Higher Level)

-- ZoneID: 134 - Hydra Red Mage (Higher Level)

-- ZoneID: 134 - Hydra White Mage (Higher Level)

-- ZoneID: 134 - Hydra Black Mage (Higher Level)

-- ZoneID: 134 - Hydra Thief (Higher Level)

-- ZoneID: 134 - Hydra Dark Knight (Higher Level)
-- ZoneID: 134 - Hydra Samurai (Higher Level)

-- ZoneID: 134 - Hydra Beastmaster (Higher Level)

-- ZoneID: 134 - Hydra Dragoon (Higher Level)

-- ZoneID: 134 - Taquede

-- ZoneID: 134 - Pignonpausard

-- ZoneID: 193 - Bombast

-- ZoneID:  12 - Sword Sorcerer Solisoq

-- ZoneID: 125 - Picolaton

-- Garrison Drops

-- ZoneID: 115 - Crawler (Starfall Hillock)

-- ZoneID: 153 - Old Goobbue

-- ZoneID: 153 - Korrigan

-- 3220 Available

-- ZoneID:  33 - Ulxzomit (baby)

-- ZoneID:  38 - Carnagechief Jackbodokk
-- ZoneID:  38 - Grognard Mesmerizer
-- ZoneID:  38 - Grognard Neckchopper
-- ZoneID:  38 - Grognard Footsoldier
-- ZoneID:  38 - Grognard Grappler
-- ZoneID:  38 - Grognard Predator
-- ZoneID:  38 - Grognard Impaler
-- ZoneID:  38 - Naqba Chirurgeon
-- ZoneID:  38 - Star Ruby Quadav
-- ZoneID:  38 - Wootz Quadav
-- ZoneID:  38 - Fossil Quadav
-- ZoneID:  38 - Star Sapphire Quadav
-- ZoneID:  38 - Whitegold Quadav
-- ZoneID:  38 - Lightsteel Quadav
-- ZoneID:  38 - Dee Wapa The Desolator
-- ZoneID:  38 - Yagudo Archpriest
-- ZoneID:  38 - Yagudo Knight Templar
-- ZoneID:  38 - Yagudo Disciplinant
-- ZoneID:  38 - Yagudo Prelatess
-- ZoneID:  38 - Yagudo Kapellmeister
-- ZoneID:  38 - Yagudo Eradicator

-- ZoneID:  37 - Airi
-- ZoneID:  37 - Temenos Cleaner
-- ZoneID:  37 - Iruci
-- ZoneID:  37 - Temenos Weapon
-- ZoneID:  37 - Enhanced Dragon
-- ZoneID:  37 - Enhanced Ahriman

-- ZoneID:  37 - Fire Elemental
-- ZoneID:  37 - Ice Elemental
-- ZoneID:  37 - Air Elemental
-- ZoneID:  37 - Earth Elemental
-- ZoneID:  37 - Thunder Elemental
-- ZoneID:  37 - Water Elemental
-- ZoneID:  37 - Dark Elemental
-- ZoneID:  37 - Mystic_Avatar

-- ZoneID:  37 - Light Elemental
-- ZoneID:  37 - Mystic_Avatar (Carbuncle)

-- ZoneID:  37 - Grognard Mesmerizer
-- ZoneID:  37 - Grognard Footsoldier
-- ZoneID:  37 - Grognard Predator
-- ZoneID:  37 - Grognard Neckchopper
-- ZoneID:  37 - Grognard Grappler
-- ZoneID:  37 - Grognard Impaler
-- ZoneID:  37 - Star Ruby Quadav
-- ZoneID:  37 - Whitegold Quadav
-- ZoneID:  37 - Wootz Quadav
-- ZoneID:  37 - Star Sapphire Quadav
-- ZoneID:  37 - Lightsteel Quadav
-- ZoneID:  37 - Yagudo Archpriest
-- ZoneID:  37 - Yagudo Disciplinant
-- ZoneID:  37 - Yagudo Kapellmeister
-- ZoneID:  37 - Yagudo Knight Templar
-- ZoneID:  37 - Yagudo Prelatess
-- ZoneID:  37 - Yagudo Eradicator

-- ZoneID:  37 - Kingslayer_Doggvdegg
-- ZoneID:  37 - JiGho_Ageless
-- ZoneID:  37 - Koo_Buzu_the_Theomanic
-- ZoneID:  37 - Mystic_Avatar
-- ZoneID:  37 - Enhanced_Koenigstiger
-- ZoneID:  37 - Enhanced_Pygmaioi
-- ZoneID:  37 - Enhanced_Kettenkaefer
-- ZoneID:  37 - Enhanced_Salamander
-- ZoneID:  37 - Enhanced_Jelly
-- ZoneID:  37 - Enhanced_Makara
-- ZoneID:  37 - Enhanced_Akbaba

-- ZoneID:  135 - Animated Knuckles

-- ZoneID:  135 - Animated Dagger

-- ZoneID:  135 - Animated Longsword

-- ZoneID:  135 - Animated Claymore

-- ZoneID:  135 - Animated Tabar

-- ZoneID:  135 - Animated Great Axe

-- ZoneID:  135 - Animated Scythe

-- ZoneID:  135 - Animated Spear

-- ZoneID:  135 - Animated Kunai

-- ZoneID:  135 - Animated Tachi

-- ZoneID:  135 - Animated Hammer

-- ZoneID:  135 - Animated Staff

-- ZoneID:  135 - Animated Longbow

-- ZoneID:  135 - Animated Horn

-- ZoneID:  135 - Animated Gun

-- ZoneID:  135 - Animated Shield

-- ZoneID: 198 - Wendigo Blm

-- ZoneID:  25 - Orcish Gladiator
-- ZoneID:  25 - Orcish Trooper

-- ZoneID:  25 - Orcish Bowshooter

-- ZoneID:  24 - Orcish Beastrider
-- ZoneID:  24 - Orcish Bowshooter
-- ZoneID:  24 - Orcish Brawler
-- ZoneID:  24 - Orcish Footsoldier
-- ZoneID:  24 - Orcish Nightrider
-- ZoneID:  24 - Orcish Gladiator
-- ZoneID:  24 - Orcish Trooper

-- ZoneID: 123  - Pyuu the Spatemaker

-- ZoneID:  61  - Fahrafahr the Bloodied

-- ZoneID:  45 - Abas -- TODO: Abyssea NM

-- ZoneID:  45 - Alectryon -- TODO: Abyssea NM

-- ZoneID:  45 - Cannered Noz -- TODO: Abyssea NM. Reraises like Ix'aern DRK. Doesn't drop items until after the last RR.

-- ZoneID:  45 - Chloris -- TODO: Abyssea NM

-- ZoneID:  45 - Gancanagh -- TODO: Abyssea NM

-- ZoneID:  45 - Glavoid -- TODO: Abyssea NM

-- ZoneID:  45 - Halimede -- TODO: Abyssea NM

-- ZoneID:  45 - Hedetet -- TODO: Abyssea NM

-- ZoneID:  45 - Lachrymater -- TODO: Abyssea NM

-- ZoneID:  45 - Lacovie -- TODO: Abyssea NM

-- ZoneID:  45 - Muscaliet -- TODO: Abyssea NM

-- ZoneID:  45 - Ophanim -- TODO: Abyssea NM

-- ZoneID:  45 - Tefenet -- TODO: Abyssea NM

-- ZoneID:  45 - Treble Noctules -- TODO: Abyssea NM

-- ZoneID:  45 - Vetehinen

-- ZoneID:  45 - Cuelebre -- TODO: Abyssea NM

-- ZoneID:  45 - Mictlantecuhtli -- TODO: Abyssea NM

-- ZoneID:  45 - Chukwa -- TODO: Abyssea NM

-- ZoneID:  45 - Minhocao -- TODO: Abyssea NM

-- ZoneID:  45 - Adze -- TODO: Abyssea NM

-- ZoneID:  45 - Quetzalli -- TODO: Abyssea NM

-- ZoneID:  45 - Manananggal -- TODO: Abyssea NM

-- ZoneID:  45 - Myrmecoleon -- TODO: Abyssea NM

-- ZoneID:  45 - Iratham -- TODO: Abyssea NM

-- ZoneID:  96 - Emela-ntouka

-- ZoneID:  88 - Olgoi-Khorkhoi

-- ZoneID:  65 - Firedance Magmaal Ja

-- ZoneID:  61 - Chary Apkallu

-- ZoneID: 24 - Flockbock

-- ZoneID: 113 - Zmey Gorynych

-- 3290 Available

-- ZoneID: 62 - Copper Borer

-- 3292 Available

-- ZoneID: 121 - Bastet

-- ZoneID: 137 - Zirnitra

-- ZoneID 126 - Atkorkamuy

-- 3296 Available

-- ZoneID:  91 - Erle

-- ZoneID:  29 - Blazedrake

-- ZoneID:  89 - Vasiliceratops

-- ZoneID: 254 - Peak Pugil

-- ZoneID: 227 - Ocean Crab
-- ZoneID: 228 - Ocean Crab

-- ZoneID:  77 - Eye Piercer Fafaroon
-- ZoneID:  77 - Mad Miner Boboroon
-- ZoneID:  77 - Nerve Render Yiyiroon
INSERT INTO `mob_droplist` VALUES (3302,0,0,1000,2503,@COMMON); -- Handful Of Almonds (Common, 15%)
INSERT INTO `mob_droplist` VALUES (3302,0,0,1000,2153,@VRARE);  -- Qiqirn Sandbag (Very Rare, 1%)

-- ZoneID:  45 - Bog Body

-- ZoneID:  45 - Nematocera

-- ZoneID:  45 - Wiederganger

-- ZoneID:  46 - Northern Piranu

-- ZoneID:  47 - Southern Piranu

-- ZoneID:  54 - Merrow No.5

-- ZoneID:  54 - Lamie No.7

-- ZoneID:  54 - Lamie No.8

-- ZoneID:  82 - Voirloup

-- ZoneID:  83 - Judgmental Julika

-- ZoneID:  92 - Radha Scarscute

-- ZoneID:  92 - Vagho Bloodbasked

-- ZoneID:  92 - Munhi Thimbletail

-- ZoneID:  92 - Dizho Spongeshell

-- ZoneID:  92 - Galhu Nevermolt

-- ZoneID:  97 - Hemodrosophila

-- 3319 Available

-- ZoneID:  109 - Toxic Tamlyn

-- ZoneID: 122 - Nargun

-- ZoneID: 125 - Dahu

-- ZoneID: 132 - Pasture Funguar

-- ZoneID: 136 - Came-Cruse

-- ZoneID: 136 - Scylla

-- ZoneID: 136 - Becut

-- ZoneID: 137 - Prince Orobas

-- ZoneID: 137 - Inferno Demon
-- ZoneID: 138 - Soulsearer Demon
-- ZoneID: 155 - Inferno Demon

-- ZoneID: 147 - Steel Quadav

-- ZoneID: 155 - Desmodus

-- ZoneID: 155 - Keep Imp

-- ZoneID: 159 - Temple Guardian

-- ZoneID: 164 - Buarainech

-- ZoneID: 164 - Elatha

-- ZoneID: 164 - Citadel Pipistrelles

-- ZoneID: 169 - Stygian Pugil

-- ZoneID: 171 - Lugh

-- ZoneID: 171 - Abatwa

-- ZoneID: 175 - Ethniu

-- ZoneID: 175 - Laelaps

-- ZoneID: 175 - Tethra

-- ZoneID: 186 - Arch Gudha Effigy

-- ZoneID: 186 - Vazhe Pummelsong

-- ZoneID: 186 - Ragho Darkfount

-- ZoneID: 186 - Bubho Truesteel

-- ZoneID: 186 - Zopha Forgesoul

-- ZoneID: 187 - Arch Tzee Xicu Idol

-- ZoneID: 187 - Tee Zaksa The Ceaseless

-- ZoneID: 187 - Fuu Tzapo The Blessed

-- ZoneID: 187 - Naa Yixo The Stillrage

-- ZoneID: 187 - Xuu Bhoqa The Enigma

-- ZoneID: 188 - Arch Goblin Golem

-- ZoneID: 188 - Feralox Honeylip

-- ZoneID: 188 - Scourquix Scaleskin

-- ZoneID: 188 - Wilywox Tenderpalm

-- ZoneID: 188 - Quicktrix Hexhands

-- ZoneID: 191 - Witchetty Grub

-- ZoneID: 193 - Swagger Spruce

-- 3359 Available

-- ZoneID: 195 - Azer

-- ZoneID: 197 - Witch Hazel

-- ZoneID: 204 - Jenglot

-- ZoneID: 204 - Sluagh

-- ZoneID: 208 - Sabotender Bailaor

-- ZoneID:  215 - Chasm Gnat

-- ZoneID:   215 - Funnel Antlion

-- ZoneID:   216 - Brine Crab

-- ZoneID:   216 - Wily Opo-Opo

-- ZoneID:   216 - Ironclad Executioner -- TODO: Abyssea NM

-- ZoneID: 253 - Benumbed Vodoriga

-- ZoneID: 205 - Dire Bat

-- ZoneID: 194 - Combat

-- ZoneID:  88 - Ding Bats

-- ZoneID:  73 - Puk
INSERT INTO `mob_droplist` VALUES (3374,0,0,1000,5365,@ALWAYS); -- Incus Cell (Always, 100%)

-- ZoneID:  73 - Ziz
INSERT INTO `mob_droplist` VALUES (3375,0,0,1000,5375,@ALWAYS); -- Praecipitatio Cell (Always, 100%)

-- ZoneID: 73 - Poroggo Gent
INSERT INTO `mob_droplist` VALUES (3376,0,0,1000,5365,@ALWAYS); -- Incus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3376,0,0,1000,5365,@ALWAYS); -- Incus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3377,0,0,1000,5373,@ALWAYS); -- Duplicatus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3377,0,0,1000,5373,@ALWAYS); -- Duplicatus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3378,0,0,1000,5374,@ALWAYS); -- Opacus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3378,0,0,1000,5374,@ALWAYS); -- Opacus Cell (Always, 100%)

-- ZoneID: 73 - Poroggo Madame
INSERT INTO `mob_droplist` VALUES (3379,1,1,@COMMON,14962,200); -- Enyo's Gauntlets (Group 1, Common, 15%)
INSERT INTO `mob_droplist` VALUES (3379,1,1,@COMMON,14978,200); -- Nemain's Cuffs (Group 1, Common, 15%)
INSERT INTO `mob_droplist` VALUES (3379,1,1,@COMMON,15638,200); -- Anu's Brais (Group 1, Common, 15%)
INSERT INTO `mob_droplist` VALUES (3379,1,1,@COMMON,15720,200); -- Hoshikazu Kyahan (Group 1, Common, 15%)
INSERT INTO `mob_droplist` VALUES (3379,1,1,@COMMON,16089,200); -- Njord's Mask (Group 1, Common, 15%)

-- ZoneID:  73 - Draco Lizard
INSERT INTO `mob_droplist` VALUES (3380,0,0,1000,5370,0); -- TODO: Listener to adjust drop conditionally.

-- ZoneID:  73 - Wyvern
INSERT INTO `mob_droplist` VALUES (3381,0,0,1000,5366,@ALWAYS);  -- Castellanus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3381,0,0,1000,5366,@ALWAYS);  -- Castellanus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3381,0,0,1000,5367,@VCOMMON); -- Cumulus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Zenist
INSERT INTO `mob_droplist` VALUES (3382,0,0,1000,5366,@VCOMMON); -- Castellanus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3382,0,0,1000,5370,@VCOMMON); -- Cirrocumulus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Spearman
INSERT INTO `mob_droplist` VALUES (3383,0,0,1000,5369,@ALWAYS);  -- Stratus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3383,0,0,1000,5367,@VCOMMON); -- Cumulus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Zenist
INSERT INTO `mob_droplist` VALUES (3384,0,0,1000,5377,@ALWAYS);  -- Fractus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3384,0,0,1000,5377,@ALWAYS);  -- Fractus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3384,0,0,1000,5377,@ALWAYS);  -- Fractus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3384,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3384,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Savant
INSERT INTO `mob_droplist` VALUES (3385,0,0,1000,5370,0); -- TODO: Listener to adjust drop conditionally.

-- ZoneID:  73 - Mamool Ja Zenist
INSERT INTO `mob_droplist` VALUES (3386,0,0,1000,5379,@ALWAYS);  -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3386,0,0,1000,5379,@ALWAYS);  -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3386,0,0,1000,5379,@ALWAYS);  -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3386,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3386,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Zenist
-- ZoneID:  73 - Mamool Ja Spearman
INSERT INTO `mob_droplist` VALUES (3387,0,0,1000,5380,@ALWAYS);  -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3387,0,0,1000,5380,@ALWAYS);  -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3387,0,0,1000,5380,@ALWAYS);  -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3387,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3387,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Spearman
-- ZoneID:  73 - Mamool Ja Stapper
INSERT INTO `mob_droplist` VALUES (3388,0,0,1000,5376,@ALWAYS);  -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3388,0,0,1000,5376,@ALWAYS);  -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3388,0,0,1000,5376,@ALWAYS);  -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3388,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3388,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Spearman
INSERT INTO `mob_droplist` VALUES (3389,0,0,1000,5379,@ALWAYS);  -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3389,0,0,1000,5379,@ALWAYS);  -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3389,0,0,1000,5379,@ALWAYS);  -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3389,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3389,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Spearman
INSERT INTO `mob_droplist` VALUES (3390,0,0,1000,5382,@ALWAYS);  -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3390,0,0,1000,5382,@ALWAYS);  -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3390,0,0,1000,5382,@ALWAYS);  -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3390,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3390,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Strapper, Mamool Ja Spearman
INSERT INTO `mob_droplist` VALUES (3391,0,0,1000,5378,@ALWAYS);  -- Congestus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3391,0,0,1000,5378,@ALWAYS);  -- Congestus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3391,0,0,1000,5378,@ALWAYS);  -- Congestus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3391,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3391,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Mamool Ja Strapper, Mamool Ja Bounder
INSERT INTO `mob_droplist` VALUES (3392,0,0,1000,5381,@ALWAYS);  -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3392,0,0,1000,5381,@ALWAYS);  -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3392,0,0,1000,5381,@ALWAYS);  -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3392,0,0,1000,5383,@VCOMMON); -- Humilus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3392,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Archaic Gear, Archaic_Gears, Archaic Chariot
INSERT INTO `mob_droplist` VALUES (3393,0,0,1000,2375,@COMMON);   -- Zhayolm Card (Common, 15%)
INSERT INTO `mob_droplist` VALUES (3393,0,0,1000,2488,@UNCOMMON); -- Piece Of Alexandrite (Uncommon, 10%)

-- ZoneID:  73 - Mamool Ja
INSERT INTO `mob_droplist` VALUES (3394,0,0,1000,5380,@ALWAYS); -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,0,0,1000,5380,@ALWAYS); -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,0,0,1000,5381,@ALWAYS); -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,0,0,1000,5381,@ALWAYS); -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,0,0,1000,5382,@ALWAYS); -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,0,0,1000,5382,@ALWAYS); -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,1,1,@ALWAYS,5383,500);  -- Humilus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,1,1,@ALWAYS,5384,500);  -- Spissatus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,1,2,@ALWAYS,5383,500);  -- Humilus Cell (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3394,1,2,@ALWAYS,5384,500);  -- Spissatus Cell (Group 2, Always, 100%)

-- ZoneID:  73 - Mamool Ja
INSERT INTO `mob_droplist` VALUES (3395,0,0,1000,5376,@ALWAYS); -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,0,0,1000,5376,@ALWAYS); -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,0,0,1000,5378,@ALWAYS); -- Congestus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,0,0,1000,5378,@ALWAYS); -- Congestus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,0,0,1000,5379,@ALWAYS); -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,0,0,1000,5379,@ALWAYS); -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,1,1,@ALWAYS,5383,500);  -- Humilus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,1,1,@ALWAYS,5384,500);  -- Spissatus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,1,2,@ALWAYS,5383,500);  -- Humilus Cell (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3395,1,2,@ALWAYS,5384,500);  -- Spissatus Cell (Group 2, Always, 100%)

-- ZoneID:  73 - Mamool Ja
INSERT INTO `mob_droplist` VALUES (3396,0,0,1000,5377,@ALWAYS); -- Fractus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,0,0,1000,5377,@ALWAYS); -- Fractus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,0,0,1000,5379,@ALWAYS); -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,0,0,1000,5379,@ALWAYS); -- Nimbus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,0,0,1000,5380,@ALWAYS); -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,0,0,1000,5380,@ALWAYS); -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,1,1,@ALWAYS,5383,500);  -- Humilus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,1,1,@ALWAYS,5384,500);  -- Spissatus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,1,2,@ALWAYS,5383,500);  -- Humilus Cell (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3396,1,2,@ALWAYS,5384,500);  -- Spissatus Cell (Group 2, Always, 100%)

-- ZoneID:  73 - Mamool Ja
INSERT INTO `mob_droplist` VALUES (3397,0,0,1000,5376,@ALWAYS); -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,0,0,1000,5376,@ALWAYS); -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,0,0,1000,5381,@ALWAYS); -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,0,0,1000,5381,@ALWAYS); -- Pileus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,0,0,1000,5382,@ALWAYS); -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,0,0,1000,5382,@ALWAYS); -- Mediocris Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,1,1,@ALWAYS,5383,500);  -- Humilus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,1,1,@ALWAYS,5384,500);  -- Spissatus Cell (Group 1, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,1,2,@ALWAYS,5383,500);  -- Humilus Cell (Group 2, Always, 100%)
INSERT INTO `mob_droplist` VALUES (3397,1,2,@ALWAYS,5384,500);  -- Spissatus Cell (Group 2, Always, 100%)

-- ZoneID:  73 - Mamool Ja Savant
INSERT INTO `mob_droplist` VALUES (3398,0,0,1000,5376,@ALWAYS); -- Pannus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3398,0,0,1000,5383,@ALWAYS); -- Humilus Cell (Always, 100%)

-- ZoneID:  73 - Mamool Ja Savant
INSERT INTO `mob_droplist` VALUES (3399,0,0,1000,5378,@ALWAYS); -- Congestus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3399,0,0,1000,5379,@ALWAYS); -- Congestus Cell (Always, 100%)

-- ZoneID:  73 - Mamool Ja Sophist
INSERT INTO `mob_droplist` VALUES (3400,0,0,1000,5380,@ALWAYS); -- Velum Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3400,0,0,1000,5382,@ALWAYS); -- Mediocris Cell (Always, 100%)

-- ZoneID:  73 - Mamool Ja Sophist, Mamool Ja Mimiker
INSERT INTO `mob_droplist` VALUES (3401,0,0,1000,5377,@ALWAYS); -- Fractus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3401,0,0,1000,5381,@ALWAYS); -- Pileus Cell (Always, 100%)

-- ZoneID:  73 - Poroggo Gent
INSERT INTO `mob_droplist` VALUES (3402,0,0,1000,5371,@VCOMMON); -- Undulatus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3402,0,0,1000,5384,@VCOMMON); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  73 - Poroggo Madame
INSERT INTO `mob_droplist` VALUES (3403,0,0,1000,15638,@ALWAYS); -- Anu's Brais (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3403,0,0,1000,15720,@ALWAYS); -- Hoshikazu Kyahan (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3403,0,0,1000,16089,@ALWAYS); -- Njord's Mask (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3403,0,0,1000,5735,@ALWAYS);  -- Cotton Coin Purse (Always, 100%)

-- ZoneID:  73 - Poroggo Madame
INSERT INTO `mob_droplist` VALUES (3404,0,0,1000,14561,@UNCOMMON); -- Enlil's Gambison (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (3404,0,0,1000,14972,@UNCOMMON); -- Hikazu Gote (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (3404,0,0,1000,15632,@UNCOMMON); -- Freya's Trousers (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (3404,0,0,1000,5735,@ALWAYS);    -- Cotton Coin Purse (Always, 100%)

-- ZoneID:  73 - Poroggo Madame
INSERT INTO `mob_droplist` VALUES (3405,0,0,1000,15714,@UNCOMMON); -- Deimos's Leggings (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (3405,0,0,1000,15730,@UNCOMMON); -- Macha's Pigaches (Uncommon, 10%)
INSERT INTO `mob_droplist` VALUES (3405,0,0,1000,16099,@UNCOMMON); -- Enlil's Tiara (Uncommon, 10%)

-- ZoneID:  73 - Poroggo Gent
INSERT INTO `mob_droplist` VALUES (3406,0,0,1000,5367,@VCOMMON); -- Cumulus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3406,0,0,1000,5372,@VCOMMON); -- Virga Cell (Very Common, 24%)

-- ZoneID:  73 - Poroggo Gent
INSERT INTO `mob_droplist` VALUES (3407,0,0,1000,5366,@VCOMMON); -- Castellanus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3407,0,0,1000,5370,@VCOMMON); -- Cirrocumulus Cell (Very Common, 24%)

-- ZoneID:  73 - Archaic Rampart, Poroggo Madame
INSERT INTO `mob_droplist` VALUES (3408,0,0,1000,14962,@ALWAYS); -- Enyo's Gauntlets (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3408,0,0,1000,14978,@ALWAYS); -- Nemain's Cuffs (Always, 100%)

-- ZoneID:  73 - Archaic Rampart, Poroggo Madame
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5383,@ALWAYS); -- Humilus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5383,@ALWAYS); -- Humilus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5383,@ALWAYS); -- Humilus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5383,@ALWAYS); -- Humilus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5383,@ALWAYS); -- Humilus Cell (Always, 100%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5384,@ALWAYS); -- Spissatus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5384,@ALWAYS); -- Spissatus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5384,@ALWAYS); -- Spissatus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5384,@ALWAYS); -- Spissatus Cell (Very Common, 24%)
INSERT INTO `mob_droplist` VALUES (3409,0,0,1000,5384,@ALWAYS); -- Spissatus Cell (Very Common, 24%)

-- ZoneID:  78 - Dark Elemental
-- ZoneID:  78 - Rotting Huskarl
-- ZoneID:  78 - Craven Einherjar
-- ZoneID:  78 - Hyndla
-- ZoneID:  78 - Nickur
-- ZoneID:  78 - Hazhalm Bat
-- ZoneID:  78 - Hazhalm Bats
-- ZoneID:  78 - Gardsvor
-- ZoneID:  78 - Einherjar Brei
-- ZoneID:  78 - Hazhalm Leech
-- ZoneID:  78 - Winebibber
-- ZoneID:  78 - Waldgeist
-- ZoneID:  78 - Odins Fool
-- ZoneID:  78 - Battlemite
-- ZoneID:  78 - Utgarth Bat
-- ZoneID:  78 - Utgarth Bats
-- ZoneID:  78 - Utgarth Leech
-- ZoneID:  78 - Experimental Poroggo
-- ZoneID:  78 - Liquified Einherjar
-- ZoneID:  78 - Soulflayer
-- ZoneID:  78 - Audhumbla
-- ZoneID:  78 - Marid X
-- ZoneID:  78 - Wivre X
-- ZoneID:  78 - Berserkr
-- ZoneID:  78 - Margygr
-- ZoneID:  78 - Odins Jester
-- ZoneID:  78 - Corrupt Einherjar
-- ZoneID:  78 - Manticore X
-- ZoneID:  78 - Ormr
-- ZoneID:  78 - Chigoe
-- ZoneID:  78 - Djigga
-- ZoneID:  78 - Logi
-- ZoneID:  78 - Flames of Muspelheim
-- ZoneID:  78 - Infected Wamoura
-- ZoneID:  78 - Sjokrakjen
-- ZoneID:  78 - Einherjar Eater
-- ZoneID:  78 - Hafgygr
-- ZoneID:  78 - Hervarth
-- ZoneID:  78 - Hjorvarth
-- ZoneID:  78 - Hrani
-- ZoneID:  78 - Angantyr
-- ZoneID:  78 - Bui
-- ZoneID:  78 - Brami
-- ZoneID:  78 - Barri
-- ZoneID:  78 - Reifnir
-- ZoneID:  78 - Tind
-- ZoneID:  78 - Tyrfing
-- ZoneID:  78 - Hadding the Elder
-- ZoneID:  78 - Hadding the Younger
-- ZoneID:  78 - Vampyr Dog
-- ZoneID:  78 - Idun
-- ZoneID:  78 - Vanquished Einherjar
-- ZoneID:  78 - Bugard X

-- ZoneID:  78 - Odin (Odin's Chamber)

/*!40000 ALTER TABLE `mob_droplist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
