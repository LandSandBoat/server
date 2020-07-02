
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


DROP TABLE IF EXISTS `item_latents`;
CREATE TABLE IF NOT EXISTS `item_latents` (
  `itemId` smallint(5) unsigned NOT NULL,
  `modId` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `latentId` smallint(5) NOT NULL,
  `latentParam` smallint(5) NOT NULL,
  PRIMARY KEY (`itemId`, `modId`, `value`, `latentId`, `latentParam`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 PACK_KEYS=1;




-- INSERT INTO `item_latents` VALUES(itemID, modId, modValue, latentId, latentParam);

-- -------------------------------------------------------
-- Chocobo Shirt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10293, 25, 50, 50, 31);   -- Acc.+50
INSERT INTO `item_latents` VALUES(10293, 26, 50, 50, 31);   -- Rng. Acc.+50
INSERT INTO `item_latents` VALUES(10293, 30, 50, 50, 31);   -- Mag. Acc.+50
-- INSERT INTO `item_latents` VALUES(10293, ??, -1, 50, 31); -- Initiate and below: Likelihood of synthesis material loss -1%

INSERT INTO `item_latents` VALUES(10670, 68, 10, 13, 58);  -- WAR AF2 +2 Body Reduces evasion penalty by 10 if Aggressor Active

INSERT INTO `item_latents` VALUES(10679, 8, 10, 10, 0);
INSERT INTO `item_latents` VALUES(10679, 9, 10, 10, 0);
INSERT INTO `item_latents` VALUES(10679, 10, 10, 10, 0);
INSERT INTO `item_latents` VALUES(10679, 11, 10, 10, 0);
INSERT INTO `item_latents` VALUES(10719, 12, 10, 11, 0);
INSERT INTO `item_latents` VALUES(10719, 13, 10, 11, 0);
INSERT INTO `item_latents` VALUES(10719, 14, 10, 11, 0);
INSERT INTO `item_latents` VALUES(10730, 63, 10, 13, 56);  -- WAR AF2 +2 Feet Reduces defense penalty by 10% if Berserk Active

-- -------------------------------------------------------
-- Abyss Sollerets +2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10737, 63, 10, 13, 64);   -- +2: Enhances "Last Resort" effect

-- -------------------------------------------------------
-- Lunette ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10766, 29, 5, 10, 0);     -- MDEF+7
INSERT INTO `item_latents` VALUES(10766, 369, -2, 10, 0);   -- Latent is active when engaged and drains 2mp/tick.

-- -------------------------------------------------------
-- Mandraguard
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10807, 370, 1, 26, 0);    -- Regen 1/tick during Daytime

-- -------------------------------------------------------
-- LAVALIER
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10961, 60, -40, 13, 14);  -- CHARMED:LIGHTRES
INSERT INTO `item_latents` VALUES(10961, 61, -40, 13, 14);  -- CHARMED:DARKRES

-- -------------------------------------------------------
-- LAVALIER +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10962, 60, -50, 13, 14);  -- CHARMED:LIGHTRES
INSERT INTO `item_latents` VALUES(10962, 61, -50, 13, 14);  -- CHARMED:DARKRES
INSERT INTO `item_latents` VALUES(10962, 169, -12, 13, 14); -- CHARMED:DECREASES MOV SPEED

-- -------------------------------------------------------
-- Archon Cape +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(10975, 25, 13, 52, 8);   -- DARK WEATHER:ACC
INSERT INTO `item_latents` VALUES(10975, 23, 13, 52, 8);   -- DARK WEATHER:ATT

-- -------------------------------------------------------
-- Eerie Cloak +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11300, 369, 1, 40, 0);    -- Level multiple of 13 and Nighttime: Refresh +1MP/tick

-- -------------------------------------------------------
-- Eerie cloak +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11301, 369, 1, 40, 0);    -- Refresh+1 at night when the level of the player's main job is a multiple of 13.

-- -------------------------------------------------------
-- Rambler's Cloak
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11312, 8, 5, 7, 100);     -- STR+5 while TP >=100%

-- -------------------------------------------------------
-- Dinner Jacket
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11355, 14, 1, 26, 1);     -- CHR+1 during Nighttime
INSERT INTO `item_latents` VALUES(11355, 27, -1, 0, 75);    -- Enmity-1 when HP <75%

-- -------------------------------------------------------
-- Nobushi Kyahan
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11367, 1, 30, 49, 4277);  -- def+30 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 30, 49, 4278);  -- def+30 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 40, 49, 4590);  -- def+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 40, 49, 4605);  -- def+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 40, 49, 5928);  -- def+40 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 40, 49, 5929);  -- def+40 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 50, 49, 4405);  -- def+50 Rice Ball
INSERT INTO `item_latents` VALUES(11367, 1, 50, 49, 4604);  -- def+50 Rogue Rice Ball
INSERT INTO `item_latents` VALUES(11367, 23, 40, 49, 4590); -- atk+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(11367, 23, 40, 49, 4605); -- atk+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(11367, 23, 50, 49, 4277); -- atk+50 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(11367, 23, 50, 49, 4278); -- atk+50 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(11367, 23, 60, 49, 5928); -- atk+60 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(11367, 23, 60, 49, 5929); -- atk+60 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(11367, 230, 5, 49, 4604); -- beast killer 5% (guesstimated) Rogue Rice Ball
INSERT INTO `item_latents` VALUES(11367, 232, 5, 49, 4604); -- arcana killer 5% (guesstimated) Naval Rice Ball
INSERT INTO `item_latents` VALUES(11367, 288, 1, 49, 4277); -- double attack 1% Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(11367, 288, 5, 49, 4278); -- double attack 5% Shogun Rice Ball
INSERT INTO `item_latents` VALUES(11367, 302, 1, 49, 5928); -- triple attack 1% Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(11367, 302, 2, 49, 5929); -- triple attack 2% Ojo Rice Ball

-- -------------------------------------------------------
-- Louhi's Mask
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11474, 161, -3, 26, 0);   -- Daytime: Physical damage taken -3%
INSERT INTO `item_latents` VALUES(11474, 163, -3, 26, 1);   -- Nighttime: Magic damage taken -3%

-- -------------------------------------------------------
-- Diana Corona
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11486, 28, 4, 37, 4);     -- Full moon magic attack bonus +4

-- -------------------------------------------------------
-- Aesir Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11546, 288, 1, 32, 0);    -- Double Attack +2% On Darksdays

-- -------------------------------------------------------
-- Colossus's Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11547, 163, -3, 36, 0);   -- Magic damage taken -3% On Lightsdays

-- -------------------------------------------------------
-- Beguiling Collar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11585, 27, -3, 0, 100);   -- Boosts enmity decrease when taking damage (used additional -3)

-- -------------------------------------------------------
-- Nyx Gorget
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11587, 25, 12, 13, 75);   -- accuracy+12 under status arcane circle

-- -------------------------------------------------------
-- Aesir Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11589, 115, 3, 32, 0);    -- Elemental magic skill +7 On Darksdays
INSERT INTO `item_latents` VALUES(11589, 116, 3, 32, 0);    -- Dark magic skill +7 On Darksdays

-- -------------------------------------------------------
-- Colossus's Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11590, 112, 3, 36, 0);    -- Healing magic skill +10 On Lightsdays
INSERT INTO `item_latents` VALUES(11590, 113, 3, 36, 0);    -- Enhancing magic skill +10 On Lightsdays

-- -------------------------------------------------------
-- Chrys. Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11621, 368, -1, 7, 0);    -- Drains 1 TP/tick and gives 1 MP/tick
INSERT INTO `item_latents` VALUES(11621, 369, 1, 7, 0);     -- Latent Effect is active when you have TP.

-- -------------------------------------------------------
-- Rollers Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11667, 368, 10, 57, 0);   -- Rollers Ring Regain +10 with Eleven COR Roll
INSERT INTO `item_latents` VALUES(11667, 369, 1, 57, 0);    -- Rollers Ring Refresh +1 with Eleven COR Roll

-- -------------------------------------------------------
-- Oneiros Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11671, 302, 2, 55, 100);  -- Triple Attack +2% when mp is greater than or equal to 100

-- -------------------------------------------------------
-- Flock Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11676, 26, 1, 16, 3);
INSERT INTO `item_latents` VALUES(11676, 26, 1, 16, 4);
INSERT INTO `item_latents` VALUES(11676, 26, 1, 16, 5);
INSERT INTO `item_latents` VALUES(11676, 26, 1, 16, 6);

-- -------------------------------------------------------
-- Flock Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11727, 68, 1, 16, 3);
INSERT INTO `item_latents` VALUES(11727, 68, 1, 16, 4);
INSERT INTO `item_latents` VALUES(11727, 68, 1, 16, 5);
INSERT INTO `item_latents` VALUES(11727, 68, 1, 16, 6);

-- -------------------------------------------------------
-- Destrier Beret
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(11811, 369, 1, 50, 30);   -- Adds "Refresh"
INSERT INTO `item_latents` VALUES(11811, 370, 1, 50, 30);   -- Adds "Regen"
INSERT INTO `item_latents` VALUES(11811, 456, 1, 50, 30);   -- Adds "Reraise"

-- -------------------------------------------------------
-- Royal Squire's Shield +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12366, 2, 7, 53, 0);      -- HP +7 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(12366, 5, 7, 53, 0);      -- MP +7 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(12367, 2, 8, 53, 0);      -- HP +8 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(12367, 5, 8, 53, 0);      -- MP +8 in areas inside own nation's control

-- -------------------------------------------------------
-- Royal Knight Army Shield +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12368, 8, 3, 53, 0);      -- STR +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(12369, 8, 4, 53, 0);      -- STR +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Tortoise Shield
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12374, 7, 15, 53, 0);     -- HPconvMP +15 in areas inside own nation's control

-- -------------------------------------------------------
-- Temple Knight Army Shield +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12376, 10, 3, 53, 0);     -- VIT +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(12377, 10, 4, 53, 0);     -- VIT +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Mercenary's Targe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12389, 2, 5, 8, 1);       -- HP+5 when WAR Subjob
INSERT INTO `item_latents` VALUES(12389, 5, 10, 8, 1);      -- MP+10 when WAR Subjob

-- -------------------------------------------------------
-- Wrestler's Aspis
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12390, 12, 2, 8, 2);      -- INT+2 when MNK Subjob

-- -------------------------------------------------------
-- Healer's Shield
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(12391, 9, 2, 8, 3);       -- DEX+2 when WHM subjob

INSERT INTO `item_latents` VALUES(12392, 8, 2, 8, 4);
INSERT INTO `item_latents` VALUES(12393, 2, 7, 8, 5);
INSERT INTO `item_latents` VALUES(12393, 5, 7, 8, 5);
INSERT INTO `item_latents` VALUES(12394, 109, 5, 8, 6);
INSERT INTO `item_latents` VALUES(12395, 11, 2, 8, 7);
INSERT INTO `item_latents` VALUES(12396, 5, 5, 8, 8);
INSERT INTO `item_latents` VALUES(12396, 14, 2, 8, 8);
INSERT INTO `item_latents` VALUES(12397, 13, 2, 8, 9);
INSERT INTO `item_latents` VALUES(12398, 110, 5, 8, 10);
INSERT INTO `item_latents` VALUES(12399, 68, 2, 8, 11);
INSERT INTO `item_latents` VALUES(12400, 106, 5, 8, 12);
INSERT INTO `item_latents` VALUES(12401, 23, 5, 8, 13);
INSERT INTO `item_latents` VALUES(12402, 384, 100, 8, 14);  -- Wyvern Targe Latent effect: Haste+1%
INSERT INTO `item_latents` VALUES(12403, 2, 10, 8, 15);
INSERT INTO `item_latents` VALUES(12403, 5, 5, 8, 15);
INSERT INTO `item_latents` VALUES(12461, 369, 1, 13, 4);
INSERT INTO `item_latents` VALUES(12589, 370, 2, 13, 3);
INSERT INTO `item_latents` VALUES(12621, 370, 2, 13, 3);
INSERT INTO `item_latents` VALUES(12717, 71, 5, 13, 6);
INSERT INTO `item_latents` VALUES(12742, 1, 32, 56, 0);     -- Rune Bangles +32 Def.
INSERT INTO `item_latents` VALUES(12742, 68, 5, 56, 0);     -- Rune Bangles +5 Eva.
INSERT INTO `item_latents` VALUES(12742, 369, -4, 56, 0);   -- Rune Bangles -4MP/tic
INSERT INTO `item_latents` VALUES(12751, 71, 4, 13, 6);

-- -------------------------------------------------------
-- Brisingamen / Brisingamen +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13097, 2, 10, 26, 0);     -- Daytime: HP +10
INSERT INTO `item_latents` VALUES(13097, 5, 10, 26, 1);     -- Nighttime: MP +10
INSERT INTO `item_latents` VALUES(13097, 8, 5, 28, 0);      -- Firesday: STR +5
INSERT INTO `item_latents` VALUES(13097, 9, 5, 35, 0);      -- Lightningsday: DEX +5
INSERT INTO `item_latents` VALUES(13097, 10, 5, 29, 0);     -- Earthsday: VIT +5
INSERT INTO `item_latents` VALUES(13097, 11, 5, 31, 0);     -- Windsday: AGI +5
INSERT INTO `item_latents` VALUES(13097, 12, 5, 34, 0);     -- Iceday: INT +5
INSERT INTO `item_latents` VALUES(13097, 13, 5, 30, 0);     -- Watersday: MND +5
INSERT INTO `item_latents` VALUES(13097, 14, 5, 36, 0);     -- Lightsday: CHR +5

-- -------------------------------------------------------
-- Fenrir's Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13138, 5, 30, 26, 0);     -- Daytime: MP +30
INSERT INTO `item_latents` VALUES(13138, 27, -3, 26, 1);    -- Nighttime: Enmity -3

-- -------------------------------------------------------
-- Grand Temple Knight's Army Collar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13140, 1, 7, 53, 1);      -- DEF +7 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(13140, 23, 5, 53, 1);     -- ATT +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(13140, 25, 5, 53, 1);     -- ACC +5 in areas outside own nation's control

-- -------------------------------------------------------
-- Republican Gold Medal
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13141, 5, 50, 53, 1);     -- MP +50 in areas outside own nation's control

-- -------------------------------------------------------
-- Windurstian Scarf
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13142, 1, 7, 53, 1);      -- DEF +7 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(13142, 2, 15, 53, 1);     -- HP +15 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(13142, 68, 7, 53, 1);     -- EVA +7 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(13143, 368, 25, 13, 2);
INSERT INTO `item_latents` VALUES(13143, 368, 25, 13, 19);
INSERT INTO `item_latents` VALUES(13143, 368, 25, 13, 193);

-- -------------------------------------------------------
-- Uggalepih Pendant
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13145, 28, 8, 4, 51);     -- "Magic Atk. Bonus" while MP <51%

-- Brisingamen+1 stats need to be found on retail so they can be corrected
INSERT INTO `item_latents` VALUES(13162, 2, 10, 26, 0);     -- Daytime: HP +10 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 5, 10, 26, 1);     -- Nighttime: MP +10 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 8, 5, 28, 0);      -- Firesday: STR +5 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 9, 5, 35, 0);      -- Lightningsday: DEX +5 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 10, 5, 29, 0);     -- Earthsday: VIT +5 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 11, 5, 31, 0);     -- Windsday: AGI +5 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 12, 5, 34, 0);     -- Iceday: INT +5 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 13, 5, 30, 0);     -- Watersday: MND +5 (needs HQ stats)
INSERT INTO `item_latents` VALUES(13162, 14, 5, 36, 0);     -- Lightsday: CHR +5 (needs HQ stats)

-- -------------------------------------------------------
-- Auditory Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13178, 8, 4, 25, 0);      -- STR+4 song/roll active
INSERT INTO `item_latents` VALUES(13178, 10, 4, 25, 0);     -- VIT+4 song/roll active

-- -------------------------------------------------------
-- Muscle Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13185, 291, 1, 0, 50);    -- Counter+1 when HP <50%
INSERT INTO `item_latents` VALUES(13185, 370, 1, 0, 50);    -- Regen+1 when HP <50%

-- -------------------------------------------------------
-- Fire Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13241, 8, 3, 28, 0);      -- +3 STR on Firesday

-- -------------------------------------------------------
-- Ice Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13242, 12, 3, 34, 0);     -- +3 INT on Iceday

-- -------------------------------------------------------
-- Wind Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13243, 11, 3, 31, 0);     -- +3 AGI on Windsday

-- -------------------------------------------------------
-- Earth Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13244, 10, 3, 29, 0);     -- +3 VIT on Earthsday

-- -------------------------------------------------------
-- Lightning Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13245, 9, 3, 35, 0);      -- +3 DEX on Lightningsday

-- -------------------------------------------------------
-- Water Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13246, 13, 3, 30, 0);     -- +3 MND on Watersday

INSERT INTO `item_latents` VALUES(13248, 384, 800, 13, 4);

-- -------------------------------------------------------
-- Royal Knight's Belt +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13277, 24, 5, 53, 0);     -- RATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13278, 24, 6, 53, 0);     -- RATK +6 in areas inside own nation's control

-- -------------------------------------------------------
-- Muscle Belt +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13279, 291, 2, 0, 50);    -- Counter+2 when HP <50%
INSERT INTO `item_latents` VALUES(13279, 370, 2, 0, 50);    -- Regen+2 when HP <50%

-- -------------------------------------------------------
-- Soldier's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13286, 288, 2, 2, 75);    -- Double Attack+2% when HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Kampfer Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13287, 291, 2, 2, 75);    -- Counter+2 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Medicine Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13288, 374, 10, 2, 75);   -- "Cure" potency +10% while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Sorcerer's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13289, 28, 10, 2, 76);    -- "Magic Atk. Bonus"+10 while HP <76% and TP <100%

-- -------------------------------------------------------
-- Fencer's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13290, 432, 5, 2, 75);    -- Sword enhancement spell damage +5 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Rogue's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13291, 298, 3, 2, 75);    -- Steel+3 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Guardian's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13292, 385, 10, 2, 75);   -- "Shield Bash"+10 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Slayer's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13293, 392, 10, 2, 75);   -- "Weapon Bash"+10 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Tamer's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13294, 224, 3, 2, 75);    -- Enhances "Vermin Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 225, 3, 2, 75);    -- Enhances "Bird Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 226, 3, 2, 75);    -- Enhances "Amorph Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 227, 3, 2, 75);    -- Enhances "Lizard Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 228, 3, 2, 75);    -- Enhances "Aquan Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 229, 3, 2, 75);    -- Enhances "Plantiod Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 230, 3, 2, 75);    -- Enhances "Beast Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 231, 3, 2, 75);    -- Enhances "Undead Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 232, 3, 2, 75);    -- Enhances "Arcana Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 233, 3, 2, 75);    -- Enhances "Dragon Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 234, 3, 2, 75);    -- Enhances "Demon Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 235, 3, 2, 75);    -- Enhances "Empty Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 236, 3, 2, 75);    -- Enhances "Humanoid Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 237, 3, 2, 75);    -- Enhances "Lumorian Killer" effect while HP <=75% and TP <=100%
INSERT INTO `item_latents` VALUES(13294, 238, 3, 2, 75);    -- Enhances "Luminion Killer" effect while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Minstrel's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13295, 455, -25, 2, 75);  -- "Shield Bash"+10 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Tracker's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13296, 27, -2, 2, 75);    -- Enmity-2 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Ronin Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13297, 25, 5, 2, 75);     -- Accuracy+5 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Shinobi Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13298, 384, 400, 2, 75);  -- Haste+4% while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Drake Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13299, 361, 10, 2, 75);   -- Enhances "Jump" effects while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Conjurer's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13300, 346, 1, 2, 75);    -- Avatar perpetuation cost -1 while HP <=75% and TP <=100%

-- -------------------------------------------------------
-- Fenrir's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13399, 23, 10, 26, 0);    -- Daytime: ATT +10
INSERT INTO `item_latents` VALUES(13399, 24, 10, 26, 1);    -- Nighttime: RATT +10

INSERT INTO `item_latents` VALUES(13400, 26, 5, 13, 9);
INSERT INTO `item_latents` VALUES(13400, 26, 5, 13, 20);
INSERT INTO `item_latents` VALUES(13416, 68, 15, 13, 5);

-- -------------------------------------------------------
-- Soldier's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13419, 63, 20, 2, 25);    -- DEF:20% when HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Kampfer Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13420, 291, 5, 2, 25);    -- Counter+5 while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Medicine Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13421, 160, -30, 2, 25);  -- Damage Taken -30% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Sorcerer's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13422, 160, -30, 2, 25);  -- Damage Taken -30% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Fencer's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13423, 163, -30, 2, 25);  -- Magic Taken -30% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Rogue's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13424, 68, 15, 2, 25);    -- Evasion+15 while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Guardian Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13425, 168, 30, 2, 25);   -- Spell interruption rate down 30% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Slayer's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13426, 161, -20, 2, 25);  -- Physical damage taken -20% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Tamer's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13427, 304, 5, 2, 25);    -- "Tame" success rate  while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Minstrel's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13428, 161, -30, 2, 25);  -- Physical damage taken -30% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Tracker's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13429, 161, -30, 2, 25);  -- Physical damage taken -30% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Ronin Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13430, 163, -20, 2, 25);  -- Magic damage taken -20% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Shinobi Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13431, 384, 2000, 2, 25); -- Haste+20% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Drake Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13432, 288, 5, 2, 25);    -- "Double Attack"+5% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Conjurer's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13433, 160, -20, 2, 25);  -- Damage taken -20% while HP <=25% and TP <=100%

-- -------------------------------------------------------
-- Mercen. Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13435, 10, 2, 8, 1);      -- VIT+2 when WAR Subjob

-- -------------------------------------------------------
-- Wrestler's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13436, 2, 30, 8, 2);      -- HP+30 when MNK Subjob

-- -------------------------------------------------------
-- Healer's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13437, 27, -1, 8, 3);     -- Enmity -1 when WHM subjob

INSERT INTO `item_latents` VALUES(13438, 115, 5, 8, 4);
INSERT INTO `item_latents` VALUES(13439, 71, 1, 8, 5);

-- -------------------------------------------------------
-- Grand Knight's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13557, 5, 6, 53, 0);      -- MP +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13557, 9, 2, 53, 0);      -- DEX +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13557, 13, 3, 53, 0);     -- MND +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Gold Musketeer's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13558, 1, 4, 53, 0);      -- DEF +4 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13558, 11, 2, 53, 0);     -- AGI +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13558, 10, 2, 53, 0);     -- VIT +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Patriarch Protector's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13559, 2, 6, 53, 0);      -- HP +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13559, 8, 2, 53, 0);      -- STR +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13559, 12, 3, 53, 0);     -- INT +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Fire Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13560, 3, -15, 28, 0);    -- -15% HP on Firesday
INSERT INTO `item_latents` VALUES(13560, 23, 15, 28, 0);    -- +15 Attack on Firesday
INSERT INTO `item_latents` VALUES(13560, 24, 15, 28, 0);    -- +15 Ranged Attack on Firesday

-- -------------------------------------------------------
-- Ice Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13561, 6, -15, 34, 0);    -- -15% MP on Iceday
INSERT INTO `item_latents` VALUES(13561, 115, 15, 34, 0);   -- +15 Elemental Magic Skill on Iceday

-- -------------------------------------------------------
-- Wind Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13562, 3, -15, 31, 0);    -- -15% HP on Windsday
INSERT INTO `item_latents` VALUES(13562, 68, 15, 31, 0);    -- +15 Evasion on Windsday

-- -------------------------------------------------------
-- Earth Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13563, 1, 15, 29, 0);     -- +15 DEF on Earthsday
INSERT INTO `item_latents` VALUES(13563, 3, -15, 29, 0);    -- -15% HP on Earthsday

-- -------------------------------------------------------
-- Lightning Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13564, 3, -15, 35, 0);    -- -15% HP on Lightningsday
INSERT INTO `item_latents` VALUES(13564, 25, 15, 35, 0);    -- +15 Accuracy on Lightningsday
INSERT INTO `item_latents` VALUES(13564, 26, 15, 35, 0);    -- +15 Ranged Accuracy on Lightningsday

-- -------------------------------------------------------
-- Water Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13565, 6, -15, 30, 0);    -- -15% MP on Watersday
INSERT INTO `item_latents` VALUES(13565, 296, 15, 30, 0);   -- +15 "Conserve MP" on Watersday

-- -------------------------------------------------------
-- Fenrir's Cape
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13572, 1, 10, 26, 0);     -- Daytime: DEF +10
INSERT INTO `item_latents` VALUES(13572, 27, 3, 26, 1);     -- Nighttime: Enmity +3

-- -------------------------------------------------------
-- Cheviot/Umbra Cape (physical damage reduction doubled at night)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13651, 161, -5, 26, 1);

INSERT INTO `item_latents` VALUES(13652, 161, -6, 26, 1);
INSERT INTO `item_latents` VALUES(13655, 161, -20, 13, 7);

-- -------------------------------------------------------
-- Shadow Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13658, 10, 20, 32, 0);    -- Darksday: VIT+20

-- -------------------------------------------------------
-- Mercen. Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13659, 27, 1, 8, 1);      -- Enmity+1 when WAR Subjob

-- -------------------------------------------------------
-- Wrestler's Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13660, 173, 10, 8, 2);    -- Enhances "Martial Arts" effect when MNK Subjob

-- -------------------------------------------------------
-- Healer's Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13661, 29, 1, 8, 3);      -- Magic Defense Bonus while WHM subjob

INSERT INTO `item_latents` VALUES(13662, 71, 1, 8, 4);
INSERT INTO `item_latents` VALUES(13663, 170, 2, 8, 5);
INSERT INTO `item_latents` VALUES(13664, 68, 4, 8, 6);
INSERT INTO `item_latents` VALUES(13665, 231, 4, 8, 7);
INSERT INTO `item_latents` VALUES(13666, 116, 5, 8, 8);
INSERT INTO `item_latents` VALUES(13667, 250, 5, 8, 9);
INSERT INTO `item_latents` VALUES(13668, 244, 5, 8, 10);
INSERT INTO `item_latents` VALUES(13669, 359, 5, 8, 11);
INSERT INTO `item_latents` VALUES(13670, 243, 5, 8, 12);
INSERT INTO `item_latents` VALUES(13671, 247, 5, 8, 13);
INSERT INTO `item_latents` VALUES(13672, 23, 6, 8, 14);
INSERT INTO `item_latents` VALUES(13673, 117, 5, 8, 15);

-- -------------------------------------------------------
-- Variable Mantle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 30);     -- DEF+1 per 10 Level over 20
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 40);
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 50);
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 60);
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 70);
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 80);
INSERT INTO `item_latents` VALUES(13680, 1, 1, 51, 90);

-- -------------------------------------------------------
-- Variable Cape
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 30);     -- DEF+1 per 10 Level over 20
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 40);
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 50);
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 60);
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 70);
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 80);
INSERT INTO `item_latents` VALUES(13681, 1, 1, 51, 90);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 25);     -- MP+2 per 5 Level over 20
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 30);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 35);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 40);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 45);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 50);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 55);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 60);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 65);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 70);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 75);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 80);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 85);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 90);
INSERT INTO `item_latents` VALUES(13681, 5, 2, 51, 95);

INSERT INTO `item_latents` VALUES(13693, 369, 1, 13, 2);
INSERT INTO `item_latents` VALUES(13693, 369, 1, 13, 19);
INSERT INTO `item_latents` VALUES(13693, 370, 1, 13, 2);
INSERT INTO `item_latents` VALUES(13693, 370, 1, 13, 19);

-- -------------------------------------------------------
-- Carapace Breastplate
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13789, 1, 44, 0, 25);     -- DEF:44 whem HP<=25%
INSERT INTO `item_latents` VALUES(13789, 23, 12, 0, 25);    -- Attack+12 when HP <=25%

-- -------------------------------------------------------
-- Carapace Breastplate +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13790, 1, 45, 0, 25);     -- DEF:45 when HP <=25%
INSERT INTO `item_latents` VALUES(13790, 23, 13, 0, 25);    -- Attack+13 when HP <=25%

INSERT INTO `item_latents` VALUES(13846, 369, 1, 13, 4);

-- -------------------------------------------------------
-- Suijin Kabuto
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13852, 370, 2, 30, 0);    -- Watersdays: Adds "Regen" effect

-- -------------------------------------------------------
-- Opo-opo crown
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13870, 2, 50, 49, 4468);  -- HP +50 (pamamas)
INSERT INTO `item_latents` VALUES(13870, 2, 50, 49, 4596);  -- HP +50 (wild pamamas)
INSERT INTO `item_latents` VALUES(13870, 5, 50, 49, 4468);  -- MP +50 (pamamas)
INSERT INTO `item_latents` VALUES(13870, 5, 50, 49, 4596);  -- MP +50 (wild pamamas)
INSERT INTO `item_latents` VALUES(13870, 14, 14, 49, 4468); -- CHR +14 (pamamas)
INSERT INTO `item_latents` VALUES(13870, 14, 14, 49, 4596); -- CHR +14 (wild pamamas)

INSERT INTO `item_latents` VALUES(13875, 68, 8, 52, 6);     -- Jinpachi: Evasion +8 in Water weather

-- -------------------------------------------------------
-- Carapace Helm
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13878, 1, 23, 0, 50);     -- DEF:23 when HP <=50%
INSERT INTO `item_latents` VALUES(13878, 23, 10, 0, 50);    -- Attack+10 when HP <=50%

-- -------------------------------------------------------
-- Carapace Helm +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13879, 1, 24, 0, 50);     -- DEF:24 when HP <=50%
INSERT INTO `item_latents` VALUES(13879, 23, 11, 0, 50);    -- Attack+11 when HP <=50%

-- -------------------------------------------------------
-- Presidential Hairpin
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13880, 370, 1, 53, 1);    -- Regen +1/tick in areas outside own nation's control

-- -------------------------------------------------------
-- San d'Orian Helm/Kingdom Helm
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13891, 2, 10, 53, 0);     -- HP +10 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13892, 2, 12, 53, 0);     -- HP +12 in areas inside own nation's control

-- -------------------------------------------------------
-- Iron Musketeer's Armet +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13893, 5, 14, 53, 0);     -- MP +14 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13894, 5, 16, 53, 0);     -- MP +16 in areas inside own nation's control

-- -------------------------------------------------------
-- Bastokan Visor/Republic Visor
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13897, 2, 5, 53, 0);      -- HP +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13897, 5, 5, 53, 0);      -- MP +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13898, 2, 6, 53, 0);      -- HP +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13898, 5, 6, 53, 0);      -- MP +6 in areas inside own nation's control

-- -------------------------------------------------------
-- Bastokan Circlet/Republic Circlet
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13899, 28, 3, 53, 0);     -- MATT +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13900, 28, 5, 53, 0);     -- MATT +5 in areas inside own nation's control

-- -------------------------------------------------------
-- Windurstian Headgear/Federation Headgear
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13903, 5, 10, 53, 0);     -- MP +10 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13904, 5, 12, 53, 0);     -- MP +12 in areas inside own nation's control

-- -------------------------------------------------------
-- Tactician Magician's Hat +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13905, 12, 3, 53, 0);     -- INT +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13905, 13, 3, 53, 0);     -- MND +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13906, 12, 4, 53, 0);     -- INT +4 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(13906, 13, 4, 53, 0);     -- MND +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Roshi Jinpachi
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13910, 1, 30, 49, 4277);  -- def+30 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 30, 49, 4278);  -- def+30 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 40, 49, 4590);  -- def+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 40, 49, 4605);  -- def+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 40, 49, 5928);  -- def+40 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 40, 49, 5929);  -- def+40 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 50, 49, 4405);  -- def+50 Rice Ball
INSERT INTO `item_latents` VALUES(13910, 1, 50, 49, 4604);  -- def+50 Rogue Rice Ball
INSERT INTO `item_latents` VALUES(13910, 23, 40, 49, 4590); -- atk+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(13910, 23, 40, 49, 4605); -- atk+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(13910, 23, 50, 49, 4277); -- atk+50 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13910, 23, 50, 49, 4278); -- atk+50 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13910, 23, 60, 49, 5928); -- atk+60 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13910, 23, 60, 49, 5929); -- atk+60 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(13910, 230, 5, 49, 4604); -- beast killer 5% (guesstimated) Rogue Rice Ball
INSERT INTO `item_latents` VALUES(13910, 232, 5, 49, 4604); -- arcana killer 5% (guesstimated) Naval Rice Ball
INSERT INTO `item_latents` VALUES(13910, 288, 1, 49, 4277); -- double attack 1% Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13910, 288, 5, 49, 4278); -- double attack 5% Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13910, 302, 1, 49, 5928); -- triple attack 1% Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13910, 302, 2, 49, 5929); -- triple attack 2% Ojo Rice Ball

-- -------------------------------------------------------
-- Mushroom Helm
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13913, 370, 1, 30, 0);    -- Regen 1/tick on Watersdays
INSERT INTO `item_latents` VALUES(13913, 370, 1, 32, 0);    -- Regen 1/tick on Darksdays

-- -------------------------------------------------------
-- Rasetsu Jinpachi
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13925, 291, 1, 0, 25);    -- Counter+1 when HP <25%

-- -------------------------------------------------------
-- Roshi Jinpachi +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13949, 1, 30, 49, 4277);  -- def+30 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 30, 49, 4278);  -- def+30 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 40, 49, 4590);  -- def+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 40, 49, 4605);  -- def+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 40, 49, 5928);  -- def+40 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 40, 49, 5929);  -- def+40 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 50, 49, 4405);  -- def+50 Rice Ball
INSERT INTO `item_latents` VALUES(13949, 1, 50, 49, 4604);  -- def+50 Rogue Rice Ball
INSERT INTO `item_latents` VALUES(13949, 23, 40, 49, 4590); -- atk+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(13949, 23, 40, 49, 4605); -- atk+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(13949, 23, 50, 49, 4277); -- atk+50 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13949, 23, 50, 49, 4278); -- atk+50 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13949, 23, 60, 49, 5928); -- atk+60 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13949, 23, 60, 49, 5929); -- atk+60 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(13949, 230, 5, 49, 4604); -- beast killer 5% (guesstimated) Rogue Rice Ball
INSERT INTO `item_latents` VALUES(13949, 232, 5, 49, 4604); -- arcana killer 5% (guesstimated) Naval Rice Ball
INSERT INTO `item_latents` VALUES(13949, 288, 1, 49, 4277); -- double attack 1% Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13949, 288, 5, 49, 4278); -- double attack 5% Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13949, 302, 1, 49, 5928); -- triple attack 1% Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13949, 302, 2, 49, 5929); -- triple attack 2% Ojo Rice Ball

-- -------------------------------------------------------
-- Myochin Kote
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(13972, 1, 30, 49, 4277);  -- def+30 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 30, 49, 4278);  -- def+30 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 40, 49, 4590);  -- def+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 40, 49, 4605);  -- def+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 40, 49, 5928);  -- def+40 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 40, 49, 5929);  -- def+40 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 50, 49, 4405);  -- def+50 Rice Ball
INSERT INTO `item_latents` VALUES(13972, 1, 50, 49, 4604);  -- def+50 Rogue Rice Ball
INSERT INTO `item_latents` VALUES(13972, 23, 40, 49, 4590); -- atk+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(13972, 23, 40, 49, 4605); -- atk+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(13972, 23, 50, 49, 4277); -- atk+50 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13972, 23, 50, 49, 4278); -- atk+50 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13972, 23, 60, 49, 5928); -- atk+60 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13972, 23, 60, 49, 5929); -- atk+60 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(13972, 230, 5, 49, 4604); -- beast killer 5% (guesstimated) Rogue Rice Ball
INSERT INTO `item_latents` VALUES(13972, 232, 5, 49, 4604); -- arcana killer 5% (guesstimated) Naval Rice Ball
INSERT INTO `item_latents` VALUES(13972, 288, 1, 49, 4277); -- double attack 1% Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(13972, 288, 5, 49, 4278); -- double attack 5% Shogun Rice Ball
INSERT INTO `item_latents` VALUES(13972, 302, 1, 49, 5928); -- triple attack 1% Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(13972, 302, 2, 49, 5929); -- triple attack 2% Ojo Rice Ball

INSERT INTO `item_latents` VALUES(14005, 25, 8, 52, 6);     -- Tekko: Accuracy +8 in Water weather

-- -------------------------------------------------------
-- Carapace Gauntlets
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14008, 1, 16, 0, 75);     -- DEF:16 whem HP <= 75%
INSERT INTO `item_latents` VALUES(14008, 23, 8, 0, 75);     -- Attack+8 when HP <=75%

-- -------------------------------------------------------
-- Cpc. Gauntlets +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14009, 1, 17, 0, 75);     -- DEF:17 whem HP <= 75%
INSERT INTO `item_latents` VALUES(14009, 23, 9, 0, 75);     -- Attack+9 when HP <=75%

-- -------------------------------------------------------
-- Grand Temple Knight's Gauntlets
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14013, 9, 2, 53, 1);      -- DEX +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14013, 110, 10, 53, 1);   -- DEX +2 in areas outside own nation's control

-- -------------------------------------------------------
-- Grand Temple Knight's Bangles
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14014, 11, 2, 53, 1);     -- AGI +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14014, 68, 7, 53, 1);     -- EVA +7 in areas outside own nation's control

-- -------------------------------------------------------
-- Praefectus's Gloves
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14015, 10, 2, 53, 1);     -- VIT +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14015, 68, 5, 53, 1);     -- EVA +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14015, 110, 5, 53, 1);    -- Parrying skill +5 in areas outside own nation's control

-- -------------------------------------------------------
-- Master Caster's Mitts
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14016, 11, 2, 53, 1);     -- AGI +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14016, 108, 10, 53, 1);   -- EVA skill +10 in areas outside own nation's control

-- -------------------------------------------------------
-- Master Caster's Bracelets
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14017, 12, 1, 53, 1);     -- INT +1 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14017, 13, 1, 53, 1);     -- MND +1 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14017, 114, 7, 53, 1);    -- Enfeeb +7 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(14017, 115, 7, 53, 1);    -- element +7 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(14026, 25, 9, 52, 6);     -- Hailstorm Tekko: Accuracy +9 in Water weather
INSERT INTO `item_latents` VALUES(14027, 25, 10, 52, 6);    -- Hailstorm Tekko +1: Accuracy +10 in Water weather

-- -------------------------------------------------------
-- Royal Knight's Mufflers +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14029, 26, 5, 53, 0);     -- RACC +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14030, 26, 6, 53, 0);     -- RACC +6 in areas inside own nation's control

-- -------------------------------------------------------
-- San d'Orian Mufflers/Kingdom Mufflers
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14033, 5, 10, 53, 0);     -- MP +10 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14034, 5, 12, 53, 0);     -- MP +12 in areas inside own nation's control

-- -------------------------------------------------------
-- Iron Musketeer's Gauntlets +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14035, 8, 2, 53, 0);      -- STR +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14036, 8, 3, 53, 0);      -- STR +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Bastokan Finger Gauntlets/Federation Finger Gauntlets
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14039, 8, 1, 53, 0);      -- STR +1 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14040, 8, 2, 53, 0);      -- STR +2 in areas inside own nation's control

-- -------------------------------------------------------
-- Windurstian Gloves/Federation Gloves
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14045, 23, 5, 53, 0);     -- ATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14045, 24, 5, 53, 0);     -- RATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14046, 23, 7, 53, 0);     -- ATK +7 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14046, 24, 7, 53, 0);     -- RATK +7 in areas inside own nation's control

-- -------------------------------------------------------
-- Combat Caster's Mitts +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14047, 2, 14, 53, 0);     -- HP +14 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14048, 2, 16, 53, 0);     -- HP +16 in areas inside own nation's control

-- -------------------------------------------------------
-- Tactician Magician's Cuffs +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14049, 25, 5, 53, 0);     -- ACC +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14050, 25, 6, 53, 0);     -- ACC +6 in areas inside own nation's control

-- -------------------------------------------------------
-- Unicorn Mittens
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14055, 23, 7, 1, 75);     -- Attack+7 when HP >75%

-- -------------------------------------------------------
-- Unicorn Mittens +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14056, 23, 8, 1, 75);     -- Attack+8 when HP >75%

INSERT INTO `item_latents` VALUES(14062, 346, 0, 9, 8);

-- -------------------------------------------------------
-- Garden Bangles / Feronia's Bangles
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14065, 370, 1, 26, 0);    -- Daytime: Regen +1HP/tick
INSERT INTO `item_latents` VALUES(14066, 370, 1, 26, 0);    -- Daytime: Regen +1HP/tick

-- -------------------------------------------------------
-- Serpentes Sabots
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14085, 369, 1, 26, 0);    -- Daytime: Adds "Refresh" effect
INSERT INTO `item_latents` VALUES(14085, 370, 1, 26, 1);    -- Nighttime: Adds "Regen" effect

-- -------------------------------------------------------
-- Ninja Kyahan
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14101, 169, 25, 26, 1);   -- %25 during nighttime

INSERT INTO `item_latents` VALUES(14122, 68, 8, 52, 6);     -- Kyahan: Evasion +8 in Water weather

-- -------------------------------------------------------
-- Royal Knight's Sollerets +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14137, 10, 3, 53, 0);     -- VIT +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14138, 10, 4, 53, 0);     -- VIT +4 in areas inside own nation's control

-- -------------------------------------------------------
-- San d'Orian Sollerets/Kingdom Sollerets
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14141, 9, 1, 53, 0);      -- DEX +1 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14142, 9, 2, 53, 0);      -- DEX +2 in areas inside own nation's control

-- -------------------------------------------------------
-- Iron Musketeer's Sabatons +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14143, 11, 2, 53, 0);     -- AGI +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14144, 11, 3, 53, 0);     -- AGI +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Bastokan Greaves/Republic Greaves
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14147, 25, 3, 53, 0);     -- ACC +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14147, 26, 3, 53, 0);     -- RACC +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14148, 25, 4, 53, 0);     -- ACC +4 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14148, 26, 4, 53, 0);     -- RACC +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Windurstian Gaiters/Federation Gaiters
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14153, 23, 5, 53, 0);     -- ATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14153, 24, 5, 53, 0);     -- RATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14154, 23, 7, 53, 0);     -- ATK +7 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14154, 24, 7, 53, 0);     -- RATK +7 in areas inside own nation's control

-- -------------------------------------------------------
-- Combat Caster's Shoes +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14155, 11, 2, 53, 0);     -- AGI +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14156, 11, 3, 53, 0);     -- AGI +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Tactician Magician's Pigaches +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14157, 12, 3, 53, 0);     -- INT +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14158, 12, 4, 53, 0);     -- INT +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Inferno Sabots (+1)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14164, 12, 1, 37, 0);     -- New moon INT+1
INSERT INTO `item_latents` VALUES(14164, 116, 3, 37, 0);    -- New moon Dark Magic skill +3
INSERT INTO `item_latents` VALUES(14165, 12, 2, 37, 0);     -- New moon INT+2
INSERT INTO `item_latents` VALUES(14165, 116, 5, 37, 0);    -- New moon Dark Magic skill +5

-- -------------------------------------------------------
-- Desert Boots
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14166, 169, 12, 52, 4);  -- movement speed +12% in Earth weather
INSERT INTO `item_latents` VALUES(14167, 169, 12, 52, 4);  -- Desert Boots +1

-- -------------------------------------------------------
-- Rasetsu Sune-Ate
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14178, 291, 1, 0, 25);    -- Counter+1 when HP <25%

-- -------------------------------------------------------
-- Ninja Hakama
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14226, 68, 10, 26, 1);    -- Nighttime: EVA +10

-- -------------------------------------------------------
-- Royal Squire's Breeches +1 /+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14261, 2, 14, 53, 0);     -- HP +14 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14262, 2, 16, 53, 0);     -- HP +16 in areas inside own nation's control

-- -------------------------------------------------------
-- I.M. Cuisses +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14263, 8, 3, 53, 0);
INSERT INTO `item_latents` VALUES(14264, 8, 4, 53, 0);

-- -------------------------------------------------------
-- Bastokan Cuisses/Ruplic Cuisses
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14267, 23, 5, 53, 0);     -- ATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14267, 24, 5, 53, 0);     -- RATK +5 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14268, 23, 7, 53, 0);     -- ATK +7 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14268, 24, 7, 53, 0);     -- RATK +7 in areas inside own nation's control

-- -------------------------------------------------------
-- Windurstian Brais/Federation Brais
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14271, 2, 10, 53, 0);     -- HP +10 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14272, 2, 12, 53, 0);     -- HP +12 in areas inside own nation's control

-- -------------------------------------------------------
-- Combat Caster's Slacks +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14275, 5, 14, 53, 0);     -- MP +14 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14276, 5, 16, 53, 0);     -- MP +16 in areas inside own nation's control

-- -------------------------------------------------------
-- Tactician Magician's Slops +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14277, 13, 3, 53, 0);     -- MND +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14278, 13, 4, 53, 0);     -- MND +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Luna Subligar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14287, 9, 2, 37, 4);      -- Full moon DEX+2
INSERT INTO `item_latents` VALUES(14287, 11, 2, 37, 4);     -- Full moon AGI+2
INSERT INTO `item_latents` VALUES(14287, 14, 4, 37, 4);     -- Full moon CHR +4 (total +7)

-- -------------------------------------------------------
-- Clowns Subligar / Clowns Subligar +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14288, 4, 20, 26, 0);     -- Daytime: Converts 20MP to HP
INSERT INTO `item_latents` VALUES(14288, 7, 20, 26, 1);     -- Nighttime: Converts 20HP to MP
INSERT INTO `item_latents` VALUES(14289, 4, 25, 26, 0);     -- Daytime: Converts 20MP to HP
INSERT INTO `item_latents` VALUES(14289, 7, 25, 26, 1);     -- Nighttime: Converts 20HP to MP

-- -------------------------------------------------------
-- Rasetsu Hakama
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14299, 291, 1, 0, 25);    -- Counter+1 when HP <25%

INSERT INTO `item_latents` VALUES(14324, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14326, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14330, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14330, 68, 2, 31, 0);

-- -------------------------------------------------------
-- Royal Squire's Chainmail +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14340, 23, 6, 53, 0);     -- ATK +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14340, 24, 6, 53, 0);     -- RATK +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14341, 23, 8, 53, 0);     -- ATK +8 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14341, 24, 8, 53, 0);     -- RATK +8 in areas inside own nation's control

-- -------------------------------------------------------
-- Iron Musketeer's Cuirass +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14342, 108, 6, 53, 0);    -- EVA +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14343, 108, 7, 53, 0);    -- EVA +7 in areas inside own nation's control

-- -------------------------------------------------------
-- Bastokan Scale Mail/Republic Scale Mail
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14346, 108, 3, 53, 0);    -- EVA +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14347, 108, 4, 53, 0);    -- EVA +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Windurstian Doublet/Federation Doublet
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14352, 14, 1, 53, 0);     -- CHR +1 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14353, 14, 2, 53, 0);     -- CHR +2 in areas inside own nation's control

-- -------------------------------------------------------
-- Combat Caster's Cloak +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14354, 108, 4, 53, 0);    -- EVA +4 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14355, 108, 6, 53, 0);    -- EVA +6 in areas inside own nation's control

-- -------------------------------------------------------
-- Iron Musketeer's Gambison +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14356, 1, 6, 53, 0);      -- DEF +6 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14357, 1, 8, 53, 0);      -- DEF +8 in areas inside own nation's control

-- -------------------------------------------------------
-- Royal Squire's Robe +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14358, 12, 2, 53, 0);     -- INT +2 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14359, 12, 3, 53, 0);     -- INT +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Royal Knight's Cloak +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14360, 11, 3, 53, 0);     -- AGI +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14361, 11, 4, 53, 0);     -- AGI +4 in areas inside own nation's control

-- -------------------------------------------------------
-- Tactician Magician's Coat +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14362, 5, 18, 53, 0);     -- MP +18 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(14363, 5, 20, 53, 0);     -- MP +20 in areas inside own nation's control

-- -------------------------------------------------------
-- Rasetsu Samue
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14376, 291, 1, 0, 25);    -- Counter+1 when HP <25%

INSERT INTO `item_latents` VALUES(14401, 346, 1, 9, 7);
INSERT INTO `item_latents` VALUES(14410, 346, 1, 9, 6);

-- -------------------------------------------------------
-- Gaudy Harness
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14413, 369, 1, 5, 49);    -- "Refresh" effect while MP under 49 (actual number, not %)

INSERT INTO `item_latents` VALUES(14423, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14425, 68, 2, 29, 0);

-- -------------------------------------------------------
-- Kingdom Aketon
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14428, 169, 12, 54, 19);

-- -------------------------------------------------------
-- Republic Aketon
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14429, 169, 12, 54, 20);

-- -------------------------------------------------------
-- Federation Aketon
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14430, 169, 12, 54, 21);

INSERT INTO `item_latents` VALUES(14432, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14432, 68, 2, 31, 0);

-- -------------------------------------------------------
-- Vampire Cloak
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14443, 369, 1, 26, 1);    -- Nighttime: Refresh +1MP/tick
INSERT INTO `item_latents` VALUES(14443, 370, 1, 26, 0);    -- Daytime: Regen +1HP/tick

-- -------------------------------------------------------
-- Unicorn Harness
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14448, 10, 6, 1, 71);     -- VIT+6 when HP >71%

-- -------------------------------------------------------
-- Unicorn Harness +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14449, 10, 7, 1, 71);     -- VIT+7 when HP >71%
INSERT INTO `item_latents` VALUES(14500, 68, 10, 13, 58);  -- WAR AF2 +1 Body Reduces evasion penalty by 10 if Aggressor Active
INSERT INTO `item_latents` VALUES(14509, 8, 8, 10, 0);
INSERT INTO `item_latents` VALUES(14509, 9, 8, 10, 0);
INSERT INTO `item_latents` VALUES(14509, 10, 8, 10, 0);
INSERT INTO `item_latents` VALUES(14509, 11, 8, 10, 0);

-- -------------------------------------------------------
-- Shadow Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14646, 29, 10, 32, 0);    -- Darksday: MDB+10

-- -------------------------------------------------------
-- Hercules' Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14659, 369, 1, 0, 50);    -- Refresh+1 when HP <=50%
INSERT INTO `item_latents` VALUES(14659, 370, 3, 0, 50);    -- Regen+3 when HP <=50%

-- -------------------------------------------------------
-- Melody Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14725, 68, 5, 25, 0);     -- EVA+5 song/roll active

-- -------------------------------------------------------
-- Melody Earring +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14726, 68, 6, 25, 0);     -- EVA+6 song/roll active

INSERT INTO `item_latents` VALUES(14729, 9, 2, 8, 6);
INSERT INTO `item_latents` VALUES(14730, 1, 5, 8, 7);
INSERT INTO `item_latents` VALUES(14731, 23, 5, 8, 8);
INSERT INTO `item_latents` VALUES(14732, 25, 5, 8, 9);
INSERT INTO `item_latents` VALUES(14733, 68, 5, 8, 10);
INSERT INTO `item_latents` VALUES(14734, 26, 3, 8, 11);
INSERT INTO `item_latents` VALUES(14735, 110, 5, 8, 12);
INSERT INTO `item_latents` VALUES(14736, 11, 4, 8, 13);
INSERT INTO `item_latents` VALUES(14737, 384, 500, 8, 14);
INSERT INTO `item_latents` VALUES(14738, 5, 30, 8, 15);

-- -------------------------------------------------------
-- Vampire Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14783, 8, 4, 26, 1);      -- STR+4 during Nighttime
INSERT INTO `item_latents` VALUES(14783, 10, 4, 26, 1);     -- VIT+4 during Nighttime

-- -------------------------------------------------------
-- Intruder Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14806, 4, 40, 53, 1);     -- convmptohp 40 in areas outside own nation's control

-- -------------------------------------------------------
-- Diabolos's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14814, 25, -3, 52, 8);    -- cumulative acc-3 in Dark weather
INSERT INTO `item_latents` VALUES(14814, 30, 2, 52, 8);     -- magic acc+2 in Dark weather

-- -------------------------------------------------------
-- Rasetsu Tekko
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14819, 291, 1, 0, 25);    -- Counter+1 when HP <25%
INSERT INTO `item_latents` VALUES(14855, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14857, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14861, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(14861, 68, 2, 31, 0);

-- -------------------------------------------------------
-- Hachiman Kote
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14876, 23, 10, 7, 1000);  -- Attack+10 while TP >=100%

-- -------------------------------------------------------
-- Hachiman Kote +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14878, 23, 12, 7, 1000);  -- Attack+12 while TP >=100%

-- -------------------------------------------------------
-- Sennight Bangles
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14885, 30, 1, 28, 0);     -- Weekday: Magic Accuracy+1
INSERT INTO `item_latents` VALUES(14885, 30, 1, 29, 0);
INSERT INTO `item_latents` VALUES(14885, 30, 1, 30, 0);
INSERT INTO `item_latents` VALUES(14885, 30, 1, 31, 0);
INSERT INTO `item_latents` VALUES(14885, 30, 1, 34, 0);
INSERT INTO `item_latents` VALUES(14885, 30, 1, 35, 0);

-- -------------------------------------------------------
-- Myochin Kote +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14901, 1, 30, 49, 4277);  -- def+30 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 30, 49, 4278);  -- def+30 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 40, 49, 4590);  -- def+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 40, 49, 4605);  -- def+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 40, 49, 5928);  -- def+40 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 40, 49, 5929);  -- def+40 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 50, 49, 4405);  -- def+50 Rice Ball
INSERT INTO `item_latents` VALUES(14901, 1, 50, 49, 4604);  -- def+50 Rogue Rice Ball
INSERT INTO `item_latents` VALUES(14901, 23, 40, 49, 4590); -- atk+40 Salmon Rice Ball
INSERT INTO `item_latents` VALUES(14901, 23, 40, 49, 4605); -- atk+40 Naval Rice Ball
INSERT INTO `item_latents` VALUES(14901, 23, 50, 49, 4277); -- atk+50 Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(14901, 23, 50, 49, 4278); -- atk+50 Shogun Rice Ball
INSERT INTO `item_latents` VALUES(14901, 23, 60, 49, 5928); -- atk+60 Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(14901, 23, 60, 49, 5929); -- atk+60 Ojo Rice Ball
INSERT INTO `item_latents` VALUES(14901, 230, 5, 49, 4604); -- beast killer 5% (guesstimated) Rogue Rice Ball
INSERT INTO `item_latents` VALUES(14901, 232, 5, 49, 4604); -- arcana killer 5% (guesstimated) Naval Rice Ball
INSERT INTO `item_latents` VALUES(14901, 288, 1, 49, 4277); -- double attack 1% Tonosama Rice Ball
INSERT INTO `item_latents` VALUES(14901, 288, 5, 49, 4278); -- double attack 5% Shogun Rice Ball
INSERT INTO `item_latents` VALUES(14901, 302, 1, 49, 5928); -- triple attack 1% Hinesama Rice Ball
INSERT INTO `item_latents` VALUES(14901, 302, 2, 49, 5929); -- triple attack 2% Ojo Rice Ball

-- -------------------------------------------------------
-- Koga Tekko +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14921, 8, 13, 26, 2);     -- Dusk - Dawn: STR +13
INSERT INTO `item_latents` VALUES(14921, 384, 400, 26, 2);  -- Dusk - Dawn: Haste +4%

INSERT INTO `item_latents` VALUES(14937, 71, 3, 58, 0);     -- storm gages hmp +3

-- -------------------------------------------------------
-- Deadeye Gloves
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14944, 26, 10, 13, 4);    -- Paralysis: Ranged Accuracy+10
INSERT INTO `item_latents` VALUES(14944, 26, 10, 13, 566);

INSERT INTO `item_latents` VALUES(14946, 346, 1, 13, 2);
INSERT INTO `item_latents` VALUES(14946, 346, 1, 13, 19);

-- -------------------------------------------------------
-- Sadhu Bracelets (Triggered when not under food effect.)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(14953, 288, 2, 14, 0);    -- "Double Attack"+2%
INSERT INTO `item_latents` VALUES(14953, 384, 100, 14, 0);  -- Haste+1%

INSERT INTO `item_latents` VALUES(14954, 5, 35, 14, 0);
INSERT INTO `item_latents` VALUES(14954, 71, 1, 14, 0);
INSERT INTO `item_latents` VALUES(14954, 168, -5, 14, 0);

-- -------------------------------------------------------
-- Serpentes Cuffs
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15019, 369, 1, 26, 1);    -- Nighttime: Adds "Regen" effect
INSERT INTO `item_latents` VALUES(15019, 370, 1, 26, 0);    -- Daytime: Adds "Refresh" effect

-- -------------------------------------------------------
-- Bulwark Shield
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15067, 1, 21, 48, 0);     -- DEF:22

-- -------------------------------------------------------
-- Dynamis Shield
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15068, 1, 6, 48, 0);      -- DEF:28

-- -------------------------------------------------------
-- Ancile
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15069, 385, 200, 48, 0);  -- Augments "Shield Bash"

-- -------------------------------------------------------
-- Koga Hatsuburi
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15084, 110, 10, 26, 1);   -- Nighttime: Parry +10

INSERT INTO `item_latents` VALUES(15087, 68, 10, 13, 58);  -- WAR AF2 Body Reduces evasion penalty by 10 if Aggressor Active

INSERT INTO `item_latents` VALUES(15096, 8, 8, 10, 0);
INSERT INTO `item_latents` VALUES(15096, 9, 8, 10, 0);
INSERT INTO `item_latents` VALUES(15096, 10, 8, 10, 0);
INSERT INTO `item_latents` VALUES(15096, 11, 8, 10, 0);
INSERT INTO `item_latents` VALUES(15096, 12, -8, 10, 0);
INSERT INTO `item_latents` VALUES(15096, 13, -8, 10, 0);
INSERT INTO `item_latents` VALUES(15096, 14, -8, 10, 0);

-- -------------------------------------------------------
-- Koga Tekko
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15114, 8, 12, 26, 1);     -- STR +12 during nighttime
INSERT INTO `item_latents` VALUES(15114, 384, 400, 26, 1);  -- Haste +%4 during nighttime

INSERT INTO `item_latents` VALUES(15126, 8, -8, 11, 0);
INSERT INTO `item_latents` VALUES(15126, 9, -8, 11, 0);
INSERT INTO `item_latents` VALUES(15126, 10, -8, 11, 0);
INSERT INTO `item_latents` VALUES(15126, 11, -8, 11, 0);
INSERT INTO `item_latents` VALUES(15126, 12, 8, 11, 0);
INSERT INTO `item_latents` VALUES(15126, 13, 8, 11, 0);
INSERT INTO `item_latents` VALUES(15126, 14, 8, 11, 0);

-- -------------------------------------------------------
-- Koga Hakama
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15129, 68, 10, 26, 1);    -- Nighttime: EVA +10

INSERT INTO `item_latents` VALUES(15132, 63, 10, 13, 56);  -- WAR AF2 Feet Reduces defense penalty by 10% if Berserk Active

-- -------------------------------------------------------
-- Abyss Sollerets
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15139, 63, 10, 13, 64);   -- Enhances "Last Resort" effect

-- -------------------------------------------------------
-- Koga Kyahan
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15144, 9, 7, 26, 1);      -- DEX +7 during nighttime

INSERT INTO `item_latents` VALUES(15162, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(15164, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(15168, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(15168, 68, 2, 31, 0);
INSERT INTO `item_latents` VALUES(15174, 25, 12, 10, 0);
INSERT INTO `item_latents` VALUES(15174, 370, -100, 10, 0);
INSERT INTO `item_latents` VALUES(15174, 384, 400, 10, 0);

-- -------------------------------------------------------
-- Trump Crown
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 30);     -- "MP +15 at Lv 30-33"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 34);     -- "MP +16 at Lv 34-39"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 40);     -- "MP +17 at Lv 40-43"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 44);     -- "MP +18 at Lv 44-46"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 47);     -- "MP +19 at Lv 47-49"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 50);     -- "MP +20 at Lv 50-54"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 55);     -- "MP +21 at Lv 55-57"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 58);     -- "MP +22 at Lv 58-60"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 61);     -- "MP +23 at Lv 61-64"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 65);     -- "MP +24 at Lv 65-69"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 70);     -- "MP +25 at Lv 70-72"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 73);     -- "MP +26 at Lv 73-74"
INSERT INTO `item_latents` VALUES(15186, 2, 1, 51, 75);     -- "MP +27 at Lv 75~"
INSERT INTO `item_latents` VALUES(15186, 2, 14, 51, 20);    -- "MP +14 at Lv 20-29"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 30);     -- "HP +15 at Lv 30-33"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 34);     -- "HP +16 at Lv 34-39"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 40);     -- "HP +17 at Lv 40-43"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 44);     -- "HP +18 at Lv 44-46"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 47);     -- "HP +19 at Lv 47-49"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 50);     -- "HP +20 at Lv 50-54"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 55);     -- "HP +21 at Lv 55-57"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 58);     -- "HP +22 at Lv 58-60"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 61);     -- "HP +23 at Lv 61-64"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 65);     -- "HP +24 at Lv 65-69"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 70);     -- "HP +25 at Lv 70-72"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 73);     -- "HP +26 at Lv 73-74"
INSERT INTO `item_latents` VALUES(15186, 5, 1, 51, 75);     -- "HP +27 at Lv 75~"
INSERT INTO `item_latents` VALUES(15186, 5, 14, 51, 20);    -- "HP +14 at Lv 20-29"

-- -------------------------------------------------------
-- Hachiman Jinpachi +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15187, 288, 3, 7, 1000);  -- "Double Attack"+3% while TP >=100%

-- -------------------------------------------------------
-- Hachiman Jinpachi
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15188, 288, 2, 7, 1000);  -- "Double Attack"+2% while TP >=100%

-- -------------------------------------------------------
-- Vampire Mask
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15197, 25, 3, 26, 1);     -- Nighttime: ACC +3

-- -------------------------------------------------------
-- Unicorn Cap
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15209, 8, 4, 1, 75);      -- STR+4 when HP >75%

-- -------------------------------------------------------
-- Unicorn Cap +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15210, 8, 5, 1, 75);      -- STR+5 when HP >75%

-- -------------------------------------------------------
-- Rain Hat
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15220, 370, 1, 52, 6);    -- Regen 1HP/tick in Water weather

-- -------------------------------------------------------
-- Koga Hatsuburi +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15257, 110, 12, 26, 2);   -- Dusk - Dawn: Parry +12

-- -------------------------------------------------------
-- Axe Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15271, 85, 5, 8, 1);      -- Great Axe skill +5 when WAR Subjob

-- -------------------------------------------------------
-- Cestus Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15272, 80, 5, 8, 2);      -- Hand-to-Hand skill +5 when MNK Subjob

-- -------------------------------------------------------
-- Mace Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15273, 90, 5, 8, 3);      -- Club skill+5 while WHM subjob

INSERT INTO `item_latents` VALUES(15274, 91, 5, 8, 4);
INSERT INTO `item_latents` VALUES(15275, 82, 5, 8, 5);
INSERT INTO `item_latents` VALUES(15276, 81, 5, 8, 6);
INSERT INTO `item_latents` VALUES(15277, 109, 5, 8, 7);
INSERT INTO `item_latents` VALUES(15278, 86, 5, 8, 8);
INSERT INTO `item_latents` VALUES(15279, 84, 5, 8, 9);
INSERT INTO `item_latents` VALUES(15280, 119, 5, 8, 10);
INSERT INTO `item_latents` VALUES(15281, 105, 5, 8, 11);
INSERT INTO `item_latents` VALUES(15282, 73, 1, 8, 12);
INSERT INTO `item_latents` VALUES(15283, 259, 1, 8, 13);
INSERT INTO `item_latents` VALUES(15284, 87, 5, 8, 14);
INSERT INTO `item_latents` VALUES(15285, 346, 2, 8, 15);
INSERT INTO `item_latents` VALUES(15312, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(15314, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(15318, 68, 2, 29, 0);
INSERT INTO `item_latents` VALUES(15318, 68, 2, 31, 0);

-- -------------------------------------------------------
-- Caitiff's Socks
-- -------------------------------------------------------
-- INSERT INTO `item_latents` VALUES(15324, ???, 1, 2, 25); -- Flee when HP <25% and TP <100%

INSERT INTO `item_latents` VALUES(15328, 370, 2, 13, 11);

-- -------------------------------------------------------
-- Vampire Boots
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15338, 68, 10, 26, 1);    -- Nighttime: EVA +10

-- -------------------------------------------------------
-- Unicorn Leggings
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15345, 384, 300, 1, 75);  -- Haste+3% when HP > 75%

-- -------------------------------------------------------
-- Unicorn Leggings +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15346, 384, 400, 1, 75);  -- Haste+4% when HP > 75%

-- -------------------------------------------------------
-- Ninja Kyahan +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15364, 169, 25, 26, 2);   -- Dusk - Dawn: Speed + 25%

-- -------------------------------------------------------
-- Hachiman Hakama
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15392, 24, 7, 7, 1000);   -- Ranged Attack+7 while TP >=100%

-- -------------------------------------------------------
-- Hachiman Hakama +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15394, 24, 8, 7, 1000);   -- Ranged Attack+8 while TP >=100%

-- -------------------------------------------------------
-- Unicorn Subligar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15406, 68, 3, 1, 75);     -- Evasion+3 when HP >75%

-- -------------------------------------------------------
-- Unicorn Subligar +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15407, 68, 4, 1, 75);     -- Evasion+4 when HP >75%

-- -------------------------------------------------------
-- Resentment Cape
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15468, 163, -5, 53, 1);   -- magic damge taken -5% ( in areas outside own nation's control

INSERT INTO `item_latents` VALUES(15483, 2, 75, 58, 0);     -- Storm Mantle hp +75
INSERT INTO `item_latents` VALUES(15489, 71, 2, 58, 0);     -- Storm Cape hmp +2

-- -------------------------------------------------------
-- Ajase Beads
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15504, 23, 3, 53, 0);     -- ATK +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(15504, 25, 3, 53, 0);     -- ACC +3 in areas inside own nation's control

-- -------------------------------------------------------
-- Parade Gorget
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15506, 369, 1, 1, 85);    -- Refresh when HP >=85%

-- -------------------------------------------------------
-- Diabolos's Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15516, 24, 7, 52, 8);     -- ranged acc+8 in Dark weather
INSERT INTO `item_latents` VALUES(15516, 26, -16, 52, 8);   -- cumulative ranged acc-8 in Dark weather

INSERT INTO `item_latents` VALUES(15519, 370, 1, 58, 0);    -- storm muffler regen +1
INSERT INTO `item_latents` VALUES(15520, 68, 7, 58, 0);     -- storm torque eva +7

-- -------------------------------------------------------
-- Berserker's Torque
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15530, 368, 10, 10, 0);   -- HP-50/Tick of TP while weapon drawn
INSERT INTO `item_latents` VALUES(15530, 370, -50, 10, 0);

-- -------------------------------------------------------
-- Shark Necklace
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15532, 369, -3, 56, 2);   -- Has a hidden effect of draining 3 MP/tick while weapon is drawn.
INSERT INTO `item_latents` VALUES(15532, 370, 1, 56, 2);    -- Latent Effect is triggered when the player's weapon is drawn and has more than 2 MP.

-- -------------------------------------------------------
-- Rajas Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15543, 8, 1, 51, 45);     -- INT+1 above level 45
INSERT INTO `item_latents` VALUES(15543, 8, 1, 51, 60);     -- INT+1 above level 60
INSERT INTO `item_latents` VALUES(15543, 8, 1, 51, 75);     -- INT+1 above level 75
INSERT INTO `item_latents` VALUES(15543, 9, 1, 51, 45);     -- MND+1 above level 45
INSERT INTO `item_latents` VALUES(15543, 9, 1, 51, 60);     -- MND+1 above level 60
INSERT INTO `item_latents` VALUES(15543, 9, 1, 51, 75);     -- MND+1 above level 75

-- -------------------------------------------------------
-- Tamas Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15544, 2, 5, 51, 45);     -- MP+5 above level 45
INSERT INTO `item_latents` VALUES(15544, 2, 5, 51, 60);     -- MP+5 above level 60
INSERT INTO `item_latents` VALUES(15544, 2, 5, 51, 75);     -- MP+5 above level 75
INSERT INTO `item_latents` VALUES(15544, 10, 1, 51, 45);    -- INT+1 above level 45
INSERT INTO `item_latents` VALUES(15544, 10, 1, 51, 60);    -- INT+1 above level 60
INSERT INTO `item_latents` VALUES(15544, 10, 1, 51, 75);    -- INT+1 above level 75
INSERT INTO `item_latents` VALUES(15544, 11, 1, 51, 45);    -- MND+1 above level 45
INSERT INTO `item_latents` VALUES(15544, 11, 1, 51, 60);    -- MND+1 above level 60
INSERT INTO `item_latents` VALUES(15544, 11, 1, 51, 75);    -- MND+1 above level 75

-- -------------------------------------------------------
-- Sattva Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15545, 5, 5, 51, 45);     -- MP+5 above level 45
INSERT INTO `item_latents` VALUES(15545, 5, 5, 51, 60);     -- MP+5 above level 60
INSERT INTO `item_latents` VALUES(15545, 5, 5, 51, 75);     -- MP+5 above level 75
INSERT INTO `item_latents` VALUES(15545, 12, 1, 51, 45);    -- INT+1 above level 45
INSERT INTO `item_latents` VALUES(15545, 12, 1, 51, 60);    -- INT+1 above level 60
INSERT INTO `item_latents` VALUES(15545, 12, 1, 51, 75);    -- INT+1 above level 75
INSERT INTO `item_latents` VALUES(15545, 13, 1, 51, 45);    -- MND+1 above level 45
INSERT INTO `item_latents` VALUES(15545, 13, 1, 51, 60);    -- MND+1 above level 60
INSERT INTO `item_latents` VALUES(15545, 13, 1, 51, 75);    -- MND+1 above level 75

-- -------------------------------------------------------
-- Diabolos's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15557, 6, -15, 32, 0);    -- -15% MP on Darksday
INSERT INTO `item_latents` VALUES(15557, 116, 15, 32, 0);   -- +15 Dark magic skill on Darksday

-- -------------------------------------------------------
-- Ninja Hakama +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15573, 68, 10, 26, 2);    -- Dusk - Dawn: EVA +10

INSERT INTO `item_latents` VALUES(15589, 12, 8, 11, 0);
INSERT INTO `item_latents` VALUES(15589, 13, 8, 11, 0);
INSERT INTO `item_latents` VALUES(15589, 14, 8, 11, 0);

-- -------------------------------------------------------
-- Koga Hakama +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15592, 68, 12, 26, 2);    -- Dusk - Dawn: EVA +12

INSERT INTO `item_latents` VALUES(15665, 63, 10, 13, 56);  -- WAR AF2 +1 Feet Reduces defense penalty by 10% if Berserk Active

-- -------------------------------------------------------
-- Abyss Sollerets +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15672, 63, 10, 13, 64);   -- +1: Enhances "Last Resort" effect

-- -------------------------------------------------------
-- Koga Kyahan +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15677, 9, 7, 26, 2);      -- Dusk - Dawn: DEX +7

INSERT INTO `item_latents` VALUES(15692, 169, 12, 58, 0);   -- storm crackows movement +12

-- -------------------------------------------------------
-- Marabout Sandals
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15760, 5, 15, 28, 0);     -- Firesday: MP +15
INSERT INTO `item_latents` VALUES(15760, 28, 4, 28, 0);     -- Firesday: MATT +4

INSERT INTO `item_latents` VALUES(15774, 25, 10, 58, 0);    -- Storm ring

-- -------------------------------------------------------
-- Dominion Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15784, 5, 30, 8, 3);      -- MP+30 when WHM subjob

-- -------------------------------------------------------
-- Divisor Ring (Active when level is divisible by 5)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15786, 23, 3, 38, 0);     -- Attack+3
INSERT INTO `item_latents` VALUES(15786, 25, 6, 38, 0);     -- Accuracy+6

-- -------------------------------------------------------
-- Multiple Ring (Active when level is a multiple of 10)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15790, 1, 50, 39, 0);     -- HP+50
INSERT INTO `item_latents` VALUES(15790, 5, 20, 39, 0);     -- MP+20

-- -------------------------------------------------------
-- Balrahn's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15807, 12, 4, 58, 0);     -- INT +4
INSERT INTO `item_latents` VALUES(15807, 13, 4, 58, 0);     -- MND +4
INSERT INTO `item_latents` VALUES(15807, 14, 4, 58, 0);     -- CHR +4
INSERT INTO `item_latents` VALUES(15807, 369, 1, 58, 0);    -- Refresh +1

-- -------------------------------------------------------
-- Ulthalam's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15808, 8, 4, 58, 0);      -- STR +4
INSERT INTO `item_latents` VALUES(15808, 9, 4, 58, 0);      -- DEX +4
INSERT INTO `item_latents` VALUES(15808, 370, 1, 58, 0);    -- regen +1

-- -------------------------------------------------------
-- Jalzahns's Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15809, 11, 6, 58, 0);     -- AGI +6
INSERT INTO `item_latents` VALUES(15809, 365, 1, 58, 0);    -- Snapshot

-- -------------------------------------------------------
-- Ladybug Ring / Ladybug Ring +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15815, 2, 20, 26, 0);     -- HP+20 during Daytime
INSERT INTO `item_latents` VALUES(15815, 5, 20, 26, 0);     -- MP+20 during Daytime
INSERT INTO `item_latents` VALUES(15816, 2, 22, 26, 0);     -- HP+22 during Daytime
INSERT INTO `item_latents` VALUES(15816, 5, 22, 26, 0);     -- MP+22 during Daytime

-- -------------------------------------------------------
-- Desperado Ring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15835, 23, 5, 4, 5);      -- Attack+5 while MP <=5%

INSERT INTO `item_latents` VALUES(15882, 25, 15, 58, 0);    -- storm belt acc +15
INSERT INTO `item_latents` VALUES(15883, 12, 6, 58, 0);     -- storm sash int +6
INSERT INTO `item_latents` VALUES(15883, 14, 6, 58, 0);     -- chr +6

-- -------------------------------------------------------
-- Sothic Rope
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15915, 5, 20, 37, 4);     -- Full Moon: MP+20
INSERT INTO `item_latents` VALUES(15915, 12, 6, 37, 4);     -- Full Moon: INT+6
INSERT INTO `item_latents` VALUES(15915, 13, 6, 37, 4);     -- Full Moon: MND+6

-- -------------------------------------------------------
-- Lycopodium Sash
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15928, 370, 3, 26, 0);    -- Daytime: Regen +3HP/tick

-- -------------------------------------------------------
-- Tempest Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15946, 384, 600, 52, 3);  -- Haste +6% in Wind weather

-- -------------------------------------------------------
-- Fatality Belt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 44);   -- critical hit damage 2% under status mighty strikes (war)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 48);   -- critical hit damage 2% under status chainspell (rdm)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 49);   -- critical hit damage 2% under status perfect dodge (thf)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 50);   -- critical hit damage 2% under status invincible (pld)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 51);   -- critical hit damage 2% under status blood weapon (drk)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 52);   -- critical hit damage 2% under status soul voice (brd)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 53);   -- critical hit damage 2% under status eagle eye shot (rng)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 54);   -- critical hit damage 2% under status meikyo shisui (sam)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 126);  -- critical hit damage 2% under status spirit surge (drg)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 163);  -- critical hit damage 2% under status azure lore (blu)
INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, 376);  -- critical hit damage 2% under status trance (dnc)
-- NEED STATUS # INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, ??); -- critical hit damage 2% under status familiar (bst)
-- NEED STATUS # INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, ??); -- critical hit damage 2% under status mijin gakure (nin)
-- NEED STATUS # INSERT INTO `item_latents` VALUES(15955, 421, 2, 13, ??); -- critical hit damage 2% under status wild card (cor)

INSERT INTO `item_latents` VALUES(15968, 23, 10, 58, 0);    -- storm loop
INSERT INTO `item_latents` VALUES(15969, 5, 15, 58, 0);     -- storm earring mp +15
INSERT INTO `item_latents` VALUES(15969, 27, -4, 58, 0);    -- enmity -4
INSERT INTO `item_latents` VALUES(15975, 122, 5, 8, 16);
INSERT INTO `item_latents` VALUES(15976, 24, 5, 8, 17);
INSERT INTO `item_latents` VALUES(15977, 107, 5, 8, 18);
INSERT INTO `item_latents` VALUES(15981, 73, 2, 13, 117);
INSERT INTO `item_latents` VALUES(15982, 1, 8, 13, 74);
INSERT INTO `item_latents` VALUES(15983, 23, 7, 13, 75);

-- -------------------------------------------------------
-- Ladybug Earring / Ladybug Earring +1
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(15996, 24, 3, 26, 0);     -- Ranged Attack+3 during Daytime

INSERT INTO `item_latents` VALUES(15997, 24, 4, 26, 0);     -- Ranged Attack+4 during Daytime

INSERT INTO `item_latents` VALUES(16014, 23, 4, 22, 1);     -- Stormer Earring, ATT+4 if WAR is in party
INSERT INTO `item_latents` VALUES(16015, 2, 20, 22, 2);     -- Esse Earring, HP+20 if MNK is in party
INSERT INTO `item_latents` VALUES(16016, 27, -1, 22, 3);    -- Chary Earring, Enmity-1 if WHM is in party
INSERT INTO `item_latents` VALUES(16017, 28, 1, 22, 4);     -- Ardent Earring, MATT+1 if BLM is in party
INSERT INTO `item_latents` VALUES(16018, 30, 1, 22, 5);     -- Ataraxy Earring, MACC+1 if RDM is in party
INSERT INTO `item_latents` VALUES(16019, 9, 1, 22, 6);      -- Forte Earring, DEX+1 if THF is in party
INSERT INTO `item_latents` VALUES(16020, 10, 1, 22, 7);     -- Survivor Earring, VIT+1 if PLD is in party
INSERT INTO `item_latents` VALUES(16021, 8, 1, 22, 8);      -- Brawn Earring, STR+1 if DRK is in party
INSERT INTO `item_latents` VALUES(16023, 14, 1, 22, 10);    -- Mystique Earring, CHR+1 if BRD is in party
INSERT INTO `item_latents` VALUES(16024, 24, 1, 22, 11);    -- Impetus Earring, RATT+1 if RNG is in party
INSERT INTO `item_latents` VALUES(16025, 73, 1, 22, 12);    -- Rathe Earring, Store TP+1 if SAM is in party
INSERT INTO `item_latents` VALUES(16026, 68, 4, 22, 13);    -- Elan Earring, EVA+4 if NIN is in party
INSERT INTO `item_latents` VALUES(16027, 25, 1, 22, 14);    -- Seeker Earring, ACC+1 if DRG is in party
INSERT INTO `item_latents` VALUES(16028, 5, 15, 22, 15);    -- Psyche Earring, MP+15 if SMN is in party
INSERT INTO `item_latents` VALUES(16029, 2, 10, 22, 16);    -- Booster Earring, HP+10 if BLU is in party
INSERT INTO `item_latents` VALUES(16029, 5, 10, 22, 16);    -- Booster Earring, MP+10 if BLU is in party
INSERT INTO `item_latents` VALUES(16030, 26, 1, 22, 17);    -- Soarer Earring, RACC+1 if COR is in party
INSERT INTO `item_latents` VALUES(16032, 289, 3, 22, 19);   -- Muffle Earring, Subtle Blow +3 if DNC is in party
INSERT INTO `item_latents` VALUES(16033, 71, 1, 22, 20);    -- Sylph Earring, Healing MP +1 if SCH is in party

-- -------------------------------------------------------
-- Aesir Ear Pendant
-- -------------------------------------------------------
-- NEED modID# INSERT INTO `item_latents` VALUES(16057, ??, 6, 52, 8); -- conserve tp+6 during dark weather

-- -------------------------------------------------------
-- Colossus's Earring
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16058, 161, -1, 52, 7);   -- physical damage -2% during light weather (has -1% normally)

INSERT INTO `item_latents` VALUES(16071, 48, 5, 13, 5);
INSERT INTO `item_latents` VALUES(16071, 165, 5, 13, 5);

-- -------------------------------------------------------
-- Coven Hat
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16076, 3, 3, 41, 0);      -- HP+3% is active when your current job level is odd.
INSERT INTO `item_latents` VALUES(16076, 6, 3, 42, 0);      -- MP+3% is active when your current job level is even.

-- -------------------------------------------------------
-- Mamool Ja Helm Latent Effect is active in Mamook, Arrapago Reef, and Halvung
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16121, 8, 4, 23, 54);     -- STR+4
INSERT INTO `item_latents` VALUES(16121, 8, 4, 23, 62);
INSERT INTO `item_latents` VALUES(16121, 8, 4, 23, 65);
INSERT INTO `item_latents` VALUES(16121, 56, 15, 23, 54);   -- [Element: Air]+15
INSERT INTO `item_latents` VALUES(16121, 56, 15, 23, 62);
INSERT INTO `item_latents` VALUES(16121, 56, 15, 23, 65);
INSERT INTO `item_latents` VALUES(16121, 60, 15, 23, 54);   -- [Element: Light]+15
INSERT INTO `item_latents` VALUES(16121, 60, 15, 23, 62);
INSERT INTO `item_latents` VALUES(16121, 60, 15, 23, 65);

-- -------------------------------------------------------
-- Troll Coif Latent Effect is active in Mamook, Arrapago Reef, and Halvung
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16122, 2, 32, 23, 54);    -- HP+32
INSERT INTO `item_latents` VALUES(16122, 2, 32, 23, 62);
INSERT INTO `item_latents` VALUES(16122, 2, 32, 23, 65);
INSERT INTO `item_latents` VALUES(16122, 10, 5, 23, 54);    -- VIT+5
INSERT INTO `item_latents` VALUES(16122, 10, 5, 23, 62);
INSERT INTO `item_latents` VALUES(16122, 10, 5, 23, 65);
INSERT INTO `item_latents` VALUES(16122, 59, -50, 23, 54);  -- [Element: Water]-50
INSERT INTO `item_latents` VALUES(16122, 59, -50, 23, 62);
INSERT INTO `item_latents` VALUES(16122, 59, -50, 23, 65);

-- -------------------------------------------------------
-- Lamia Garland Latent Effect is active in Mamook, Arrapago Reef, and Halvung
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16123, 14, 7, 23, 54);    -- CHR+7
INSERT INTO `item_latents` VALUES(16123, 14, 7, 23, 62);
INSERT INTO `item_latents` VALUES(16123, 14, 7, 23, 65);
INSERT INTO `item_latents` VALUES(16123, 241, 2, 23, 54);   -- Enhances "Resist Charm" effect
INSERT INTO `item_latents` VALUES(16123, 241, 2, 23, 62);
INSERT INTO `item_latents` VALUES(16123, 241, 2, 23, 65);

-- -------------------------------------------------------
-- Qiqirn Hood Latent Effect is active in Mamook, Arrapago Reef, and Halvung
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16124, 24, 2, 23, 54);    -- Ranged Attack+2
INSERT INTO `item_latents` VALUES(16124, 24, 2, 23, 62);
INSERT INTO `item_latents` VALUES(16124, 24, 2, 23, 65);
INSERT INTO `item_latents` VALUES(16124, 26, 2, 23, 54);    -- Ranged Accuracy+2
INSERT INTO `item_latents` VALUES(16124, 26, 2, 23, 62);
INSERT INTO `item_latents` VALUES(16124, 26, 2, 23, 65);
INSERT INTO `item_latents` VALUES(16124, 68, 2, 23, 54);    -- Evasion+2
INSERT INTO `item_latents` VALUES(16124, 68, 2, 23, 62);
INSERT INTO `item_latents` VALUES(16124, 68, 2, 23, 65);

-- -------------------------------------------------------
-- Dandy Spectacles / Fancy Spectacles
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16132, 25, -20, 26, 1);   -- Nighttime: ACC -20
INSERT INTO `item_latents` VALUES(16133, 25, -30, 26, 1);   -- Nighttime: ACC -30

INSERT INTO `item_latents` VALUES(16154, 346, 2, 9, 13);
INSERT INTO `item_latents` VALUES(16165, 109, 5, 58, 0);    -- storm shield shiel skill +5
INSERT INTO `item_latents` VALUES(16217, 240, 5, 8, 16);
INSERT INTO `item_latents` VALUES(16218, 242, 5, 8, 17);
INSERT INTO `item_latents` VALUES(16219, 27, -2, 8, 18);

-- -------------------------------------------------------
-- Volitional Mantle (Latent effect is active when Cover is active.)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16220, 10, 10, 13, 114);  -- VIT+10

INSERT INTO `item_latents` VALUES(16238, 369, 1, 13, 3);

-- -------------------------------------------------------
-- Casaba Melon Tank
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16251, 71, 3, 52, 1);     -- Healing MP +3 in Fire weather

-- -------------------------------------------------------
-- Haraldr's Muffler
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16280, 73, 4, 52, 2);     -- cumulative Store TP +5 in Ice weather

-- -------------------------------------------------------
-- Halting Stole
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16306, 25, 20, 13, 4);    -- accuracy+20 while under status paralysis

-- -------------------------------------------------------
-- Armadillo Cuisses
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16340, 23, 15, 13, 16);   -- Amnesia: Attack+15
INSERT INTO `item_latents` VALUES(16340, 25, 15, 13, 16);   -- Amnesia: Accuracy+15

-- -------------------------------------------------------
-- Bedivere's Hose
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16355, 23, 25, 0, 25);    -- Attack+25 when HP <=25%
INSERT INTO `item_latents` VALUES(16355, 25, 25, 0, 25);    -- Accuracy+25 when HP <=25%

-- -------------------------------------------------------
-- Phlegethon's Trousers
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16367, 8, 4, 52, 1);      -- cumulative STR+5 in Fire weather

-- -------------------------------------------------------
-- Dinner Hose
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16378, 14, 1, 26, 1);     -- CHR+1 during Nighttime
INSERT INTO `item_latents` VALUES(16378, 27, -1, 0, 75);    -- Enmity-1 when HP <75%

INSERT INTO `item_latents` VALUES(16408, 8, 7, 56, 0);      -- Rune Baghnakhs +7 STR
INSERT INTO `item_latents` VALUES(16408, 291, 1, 56, 0);    -- Rune Baghnakhs +1 Counter
INSERT INTO `item_latents` VALUES(16408, 369, -4, 56, 0);   -- Rune Baghnakhs -4MP/tic

-- -------------------------------------------------------
-- Avengers
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 1);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 10);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 19);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 28);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 37);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 46);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 55);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 64);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 73);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 82);
INSERT INTO `item_latents` VALUES(16426, 25, 2, 0, 92);

-- -------------------------------------------------------
-- Lunaris Claws
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16427,23,3,37,4);         -- Att+3 Full Moon
INSERT INTO `item_latents` VALUES(16427,23,9,37,2);         -- Att+9 First Quarter Moon
INSERT INTO `item_latents` VALUES(16427,23,9,37,6);         -- Att+9 Last Quarter Moon
INSERT INTO `item_latents` VALUES(16427,23,15,37,0);        -- Att+15 New Moon
INSERT INTO `item_latents` VALUES(16427,25,3,37,0);         -- Acc+3 New Moon
INSERT INTO `item_latents` VALUES(16427,25,9,37,2);         -- Acc+9 First Quarter Moon
INSERT INTO `item_latents` VALUES(16427,25,9,37,6);         -- Acc+9 Last Quarter Moon
INSERT INTO `item_latents` VALUES(16427,25,15,37,4);        -- Acc+15 Full Moon


INSERT INTO `item_latents` VALUES(16563, 9, 5, 56, 0);      -- Rune Blade +5 DEX
INSERT INTO `item_latents` VALUES(16563, 366, 4, 56, 0);    -- Rune Blade DMG: 43
INSERT INTO `item_latents` VALUES(16563, 369, -4, 56, 0);   -- Rune Blade -4MP/tic

-- -------------------------------------------------------
-- Perdu Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16602, 23, 12, 6, 1000);  -- Attack+12 while TP <100%
INSERT INTO `item_latents` VALUES(16602, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(16602, 366, 4, 6, 1000);  -- DMG+4 while TP <100%

-- -------------------------------------------------------
-- Save The Queen
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16604, 25, 20, 13, 114);  -- Accuracy+20 (Latent effect is active when Cover is active.)

INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 94);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 95);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 96);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 97);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 98);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 99);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 277);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 278);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 279);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 280);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 281);
INSERT INTO `item_latents` VALUES(16605, 23, 16, 13, 282);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 94);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 95);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 96);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 97);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 98);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 99);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 277);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 278);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 279);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 280);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 281);
INSERT INTO `item_latents` VALUES(16605, 25, 8, 13, 282);
INSERT INTO `item_latents` VALUES(16647, 23, 5, 56, 0);     -- Rune Axe +5 Atk.
INSERT INTO `item_latents` VALUES(16647, 369, -3, 56, 0);   -- Rune Axe -3MP/tic
INSERT INTO `item_latents` VALUES(16647, 370, 5, 56, 0);    -- Rune Axe +5HP/tic
INSERT INTO `item_latents` VALUES(16686, 165, 7, 59, 3);    -- Arcanabane - Vs. arcana: Critical hit rate +7%

-- -------------------------------------------------------
-- Schwarz Axt
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16728, 25, 10, 26, 1);    -- Nighttime: ACC +10

-- -------------------------------------------------------
-- Bastokan Greataxe / Republic Greataxe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16732, 8, 1, 53, 1);      -- STR +1 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(16733, 8, 2, 53, 1);      -- STR +2 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(16735, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(16735, 57, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16735, 59, -10, 47, 0);

-- -------------------------------------------------------
-- Leste Jambiya
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16756, 68, 20, 31, 0);    -- Windsdays: Evasion+20

INSERT INTO `item_latents` VALUES(16792, 25, 7, 59, 19);    -- Goshisho's Scythe - Vs. undead: Accuracy+7
INSERT INTO `item_latents` VALUES(16793, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(16793, 58, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16793, 60, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16883, 25, 10, 52, 6);    -- Spear: Accuracy +10 in Water weather
INSERT INTO `item_latents` VALUES(16892, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(16892, 59, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16892, 61, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16899, 110, 5, 25, 0);    -- Hototogisu, parry skill +5 song/roll active

-- -------------------------------------------------------
-- Amanojaku
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 1);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 10);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 19);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 28);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 37);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 46);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 55);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 64);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 73);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 82);
INSERT INTO `item_latents` VALUES(16911, 366, 1, 0, 92);

INSERT INTO `item_latents` VALUES(16912, 165, 5, 59, 17);   -- Kitsutsuki - Vs. plantoids: Critical hit rate +5%

-- -------------------------------------------------------
-- Royal Swordsman's Blade +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16948, 10, 2, 53, 1);     -- VIT +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(16949, 10, 3, 53, 1);     -- VIT +3 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(16952, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(16952, 55, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16952, 57, -10, 47, 0);
INSERT INTO `item_latents` VALUES(16968, 165, 7, 59, 3);    -- Kamewari - Vs. arcana: Critical hit rate +7%
INSERT INTO `item_latents` VALUES(16969, 165, 5, 59, 9);    -- Onikiri - Vs. demons: Critical hit rate +5%

-- -------------------------------------------------------
-- Onimaru
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(16976, 23, 18, 6, 1000);  -- Attack+18 while TP <100%
INSERT INTO `item_latents` VALUES(16976, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(16976, 366, 6, 6, 1000);  -- DMG+6 while TP <100%

INSERT INTO `item_latents` VALUES(17073, 369, 1, 7, 2);     -- Mistilteinn adds Refresh 1MP per tick
INSERT INTO `item_latents` VALUES(17073, 406, 30, 7, 2);    -- Mistilteinn drains 30TP if TP >= 30
INSERT INTO `item_latents` VALUES(17093, 12, 2, 56, 0);     -- Rune Staff +2 INT
INSERT INTO `item_latents` VALUES(17093, 13, 2, 56, 0);     -- Rune Staff +2 MND
INSERT INTO `item_latents` VALUES(17093, 14, 2, 56, 0);     -- Rune Staff +2 CHR
INSERT INTO `item_latents` VALUES(17093, 28, 1, 56, 0);     -- Rune Staff +1 MAB
INSERT INTO `item_latents` VALUES(17093, 369, -4, 56, 0);   -- Rune Staff -4MP/tic
INSERT INTO `item_latents` VALUES(17158, 26, 5, 56, 0);     -- Rune Bow +5 R. Acc.
INSERT INTO `item_latents` VALUES(17158, 27, -2, 56, 0);    -- Rune Bow -2 Enmity
INSERT INTO `item_latents` VALUES(17158, 369, -4, 56, 0);   -- Rune Bow -4MP/tic

-- -------------------------------------------------------
-- Arco de Velocidad
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17165, 370, 1, 26, 0);    -- Daytime: Regen +1HP/tick

-- -------------------------------------------------------
-- Ifrit's Bow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17192, 165, 3, 21, 10);   -- Increases Critical Hit Rate

INSERT INTO `item_latents` VALUES(17204, 56, 15, 31, 0);    -- [Element: Wind]+15
INSERT INTO `item_latents` VALUES(17204, 376, 10, 31, 0);   -- Mighty Bow DMG+10 (to ranged) on Windsday
INSERT INTO `item_latents` VALUES(17207, 376, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17208, 26, 10, 59, 12);   -- Hamayumi - Vs. Empty: Ranged Accuracy+10
INSERT INTO `item_latents` VALUES(17208, 66, 10, 59, 12);   -- Vs. Empty: Ranged Attack+10%

-- -------------------------------------------------------
-- Selene's Bow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17212, 24, 5, 37, 4);     -- Full moon
INSERT INTO `item_latents` VALUES(17212, 24, 10, 37, 3);    -- Waxing gibbous
INSERT INTO `item_latents` VALUES(17212, 24, 10, 37, 5);    -- Waning gibbous
INSERT INTO `item_latents` VALUES(17212, 24, 15, 37, 2);    -- First quarter
INSERT INTO `item_latents` VALUES(17212, 24, 15, 37, 6);    -- Last quarter
INSERT INTO `item_latents` VALUES(17212, 24, 20, 37, 1);    -- Waxing crescent
INSERT INTO `item_latents` VALUES(17212, 24, 20, 37, 7);    -- Waning crescent
INSERT INTO `item_latents` VALUES(17212, 24, 25, 37, 0);    -- New moon ratk
INSERT INTO `item_latents` VALUES(17212, 26, 5, 37, 0);     -- New moon racc
INSERT INTO `item_latents` VALUES(17212, 26, 10, 37, 1);
INSERT INTO `item_latents` VALUES(17212, 26, 10, 37, 7);
INSERT INTO `item_latents` VALUES(17212, 26, 15, 37, 2);
INSERT INTO `item_latents` VALUES(17212, 26, 15, 37, 6);
INSERT INTO `item_latents` VALUES(17212, 26, 20, 37, 3);
INSERT INTO `item_latents` VALUES(17212, 26, 20, 37, 5);
INSERT INTO `item_latents` VALUES(17212, 26, 25, 37, 4);

-- -------------------------------------------------------
-- Musketeer Gun +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17269, 24, 8, 53, 1);     -- RATT +8 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17270, 24, 9, 53, 1);     -- RATT +9 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17275, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17275, 376, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17333, 10, 1, 56, 0);     -- Rune Arrow +1 VIT
INSERT INTO `item_latents` VALUES(17333, 24, 10, 56, 0);    -- Rune Arrow +10 R.Atk.
INSERT INTO `item_latents` VALUES(17333, 369, -1, 56, 0);   -- Rune Arrow -1MP/tic
INSERT INTO `item_latents` VALUES(17365, 8, 4, 25, 0);      -- Frenzy Fife, STR+4 song/roll active

-- -------------------------------------------------------
-- Tactician Magician's Wand +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17446, 5, 18, 53, 1);     -- MP +18 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17447, 5, 20, 53, 1);     -- MP +20 in areas outside own nation's control

-- -------------------------------------------------------
-- San d'Orian Mace / Kingdom Mace
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17448, 13, 1, 53, 1);     -- MND +1 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17449, 13, 2, 53, 1);     -- MND +2 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17451, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17451, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17456, 2, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17456, 5, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17456, 57, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17456, 59, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17461, 23, 10, 56, 0);    -- Rune Rod +10 Atk.
INSERT INTO `item_latents` VALUES(17461, 112, 6, 56, 0);    -- Rune Rod +6 Healing Magic Skill
INSERT INTO `item_latents` VALUES(17461, 369, -4, 56, 0);   -- Rune Rod -4MP/tic
INSERT INTO `item_latents` VALUES(17465, 12, 9, 28, 0);     -- Mighty Cudgel INT+9 on Firesday (has 1 base INT to total +9)
INSERT INTO `item_latents` VALUES(17465, 13, 9, 28, 0);     -- Mighty Cudgel MND+9 on Firesday (has 1 base MND to total +9)
INSERT INTO `item_latents` VALUES(17465, 54, 15, 28, 0);    -- [Element: Fire]+15

-- -------------------------------------------------------
-- Horrent Mace
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17471, 23, 10, 0, 25);    -- Attack+10 when HP <=25% while weapon drawn
INSERT INTO `item_latents` VALUES(17471, 25, 10, 0, 25);    -- Accuracy+10 when HP <=25% while weapon drawn

-- -------------------------------------------------------
-- Tactician Magician's Hooks +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17501, 14, 3, 53, 1);     -- CHR +3 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17502, 14, 4, 53, 1);     -- CHR +4 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17507, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(17507, 57, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17507, 59, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17509, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17509, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17527, 2, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17527, 5, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17527, 54, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17527, 60, -10, 47, 0);

-- -------------------------------------------------------
-- Musketeer's Pole +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17539, 2, 10, 53, 1);     -- HP +10 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17539, 5, 10, 53, 1);     -- MP +10 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17540, 2, 12, 53, 1);     -- HP +12 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17540, 5, 12, 53, 1);     -- MP +12 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17581, 56, 15, 31, 0);    -- [Element: Wind]+15
INSERT INTO `item_latents` VALUES(17581, 111, 13, 31, 0);   -- Mighty Pole Divine magic skill +13 Windsday
INSERT INTO `item_latents` VALUES(17581, 115, 13, 31, 0);   -- Mighty Pole Elemental magic skill +13 Windsday
INSERT INTO `item_latents` VALUES(17589, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17589, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17590, 25, 10, 49, 4468); -- Primate Staff (pamamas)
INSERT INTO `item_latents` VALUES(17590, 25, 10, 49, 4596); -- (wild pamamas)
INSERT INTO `item_latents` VALUES(17590, 171, 83, 49, 4468); -- (pamamas)
INSERT INTO `item_latents` VALUES(17590, 171, 83, 49, 4596); -- (wild pamamas)
INSERT INTO `item_latents` VALUES(17591, 25, 12, 49, 4468); -- Primate Staff +1 (pamamas)
INSERT INTO `item_latents` VALUES(17591, 25, 12, 49, 4596); -- (wild pamamas)
INSERT INTO `item_latents` VALUES(17591, 171, 80, 49, 4468); -- (pamamas)
INSERT INTO `item_latents` VALUES(17591, 171, 80, 49, 4596); -- (wild pamamas)
INSERT INTO `item_latents` VALUES(17592, 25, 10, 49, 4468); -- Kinkobo (pamamas)
INSERT INTO `item_latents` VALUES(17592, 25, 10, 49, 4596); -- (wild pamamas)
INSERT INTO `item_latents` VALUES(17592, 171, 83, 49, 4468); -- (pamamas)
INSERT INTO `item_latents` VALUES(17592, 171, 83, 49, 4596); -- (wild pamamas)

-- -------------------------------------------------------
-- Diabolos's Pole
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17599, 315, 25, 52, 8);   -- +25% drain/aspir potency in Dark weather

INSERT INTO `item_latents` VALUES(17616, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(17616, 55, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17616, 57, -10, 47, 0);

-- -------------------------------------------------------
-- Daylight Dagger
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17619, 25, 12, 26, 0);    -- Daytime: ACC +12

INSERT INTO `item_latents` VALUES(17624, 165, 7, 13, 3);

-- -------------------------------------------------------
-- Nightmare Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17649, 25, 12, 26, 1);    -- Nighttime: ACC +12

INSERT INTO `item_latents` VALUES(17654, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(17654, 54, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17654, 56, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17661, 27, 5, 58, 0);     -- enmity +5
INSERT INTO `item_latents` VALUES(17661, 366, 4, 58, 0);    -- storm scimatar dmg +4

-- -------------------------------------------------------
-- Company Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17662, 366, 2, 15, 3);    -- DMG 46~54, increases by 2 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17662, 366, 2, 15, 4);    -- DMG 46~54, increases by 2 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17662, 366, 2, 15, 5);    -- DMG 46~54, increases by 2 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17662, 366, 2, 15, 6);    -- DMG 46~54, increases by 2 for every person in party (excl. wearer)

-- -------------------------------------------------------
-- Junior Musketeer's Tuck +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17666, 24, 4, 53, 1);     -- RATT +4 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17666, 26, 4, 53, 1);     -- RACC +4 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17667, 24, 5, 53, 1);     -- RATT +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17667, 26, 5, 53, 1);     -- RACC +5 in areas outside own nation's control

-- -------------------------------------------------------
-- Temple Knight Army Sword +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17670, 9, 3, 53, 1);      -- DEX +3 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17671, 9, 4, 53, 1);      -- DEX +4 in areas outside own nation's control

-- -------------------------------------------------------
-- Bastokan Sword/Republic Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17672, 2, 5, 53, 1);      -- HP +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17672, 5, 5, 53, 1);      -- MP +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17673, 2, 6, 53, 1);      -- HP +6 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17673, 5, 6, 53, 1);      -- MP +6 in areas outside own nation's control

-- -------------------------------------------------------
-- Combat Caster's Scimitar +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17674, 5, 14, 53, 1);     -- MP +14 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17675, 5, 16, 53, 1);     -- HP +16 in areas outside own nation's control

-- -------------------------------------------------------
-- Tactician Magician's Espadon +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17676, 2, 18, 53, 1);     -- HP +18 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17677, 2, 20, 53, 1);     -- HP +20 in areas outside own nation's control

-- -------------------------------------------------------
-- Musketeer's Sword +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17680, 5, 18, 53, 1);     -- MP +18 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17681, 5, 20, 53, 1);     -- MP +20 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17697, 56, 15, 31, 0);    -- [Element: Wind]+15
INSERT INTO `item_latents` VALUES(17697, 366, 8, 31, 0);    -- Mighty Talwar DMG+8 on Windsday
INSERT INTO `item_latents` VALUES(17699, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17699, 366, 13, 47, 0);

-- -------------------------------------------------------
-- Shiva's Shotel
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17711, 431, 1, 21, 14);   -- Additional effect: Ice damage

-- -------------------------------------------------------
-- Mensur Epee
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17719, 366, -2, 15, 2);   -- DMG 47~39, decreases by 2 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17719, 366, -2, 15, 3);   -- DMG 47~39, decreases by 2 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17719, 366, -2, 15, 4);   -- DMG 47~39, decreases by 2 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17719, 366, -2, 15, 5);   -- DMG 47~39, decreases by 2 for every person in party (excl. wearer)

-- -------------------------------------------------------
-- Company Fleuret
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17720, 366, 1, 15, 2);    -- DMG 36~41, increases by 1 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17720, 366, 1, 15, 3);    -- DMG 36~41, increases by 1 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17720, 366, 1, 15, 4);    -- DMG 36~41, increases by 1 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17720, 366, 1, 15, 5);    -- DMG 36~41, increases by 1 for every person in party (excl. wearer)
INSERT INTO `item_latents` VALUES(17720, 366, 1, 15, 6);    -- DMG 36~41, increases by 1 for every person in party (excl. wearer)

-- -------------------------------------------------------
-- Perdu Hanger
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17741, 23, 15, 6, 1000);  -- Attack+15 while TP <100%
INSERT INTO `item_latents` VALUES(17741, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(17741, 366, 6, 6, 1000);  -- DMG+6 while TP <100%

INSERT INTO `item_latents` VALUES(17759, 165, 7, 59, 20);   -- Koggelmander - Vs. vermin: Critical hit rate +7%

-- -------------------------------------------------------
-- Lyft Scimitar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17766, 10, 2, 16, 3);     -- VIT +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17766, 10, 2, 16, 4);     -- VIT +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17766, 10, 2, 16, 5);     -- VIT +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17766, 10, 2, 16, 6);     -- VIT +1~4, party size 3+. Effect strengthens with more members

INSERT INTO `item_latents` VALUES(17773, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(17773, 54, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17773, 60, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17788, 8, 4, 32, 0);      -- Sairen STR +4 on Darksday (has 3 base STR to total +7)
INSERT INTO `item_latents` VALUES(17788, 27, 1, 32, 0);     -- Enmity +1
INSERT INTO `item_latents` VALUES(17791, 54, 15, 28, 0);    -- [Element: Fire]+15
INSERT INTO `item_latents` VALUES(17791, 366, 7, 28, 0);    -- Rai Kunimitsu DMG+7 on Firesday
INSERT INTO `item_latents` VALUES(17793, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17793, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17804, 25, 7, 59, 6);     -- Ushikirimaru - Vs. beasts: Accuracy+7

-- -------------------------------------------------------
-- Futsuno Mitama
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17810, 8, 8, 6, 1);       -- Latent effect: STR+8

-- -------------------------------------------------------
-- Raikiri
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17814, 23, 10, 52, 5);    -- Attack +10 in Thunder weather

INSERT INTO `item_latents` VALUES(17815, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(17815, 55, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17815, 61, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17824, 54, 15, 28, 0);    -- [Element: Fire]+15
INSERT INTO `item_latents` VALUES(17824, 366, 10, 28, 0);   -- Nukemaru DMG+10 on Firesday
INSERT INTO `item_latents` VALUES(17827, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17827, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(17831, 369, 1, 13, 2);
INSERT INTO `item_latents` VALUES(17831, 370, 1, 13, 19);

-- -------------------------------------------------------
-- Oliphant
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17843, 121, 3, 53, 1);    -- WIND +3 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17851, 442, 1, 58, 0);    -- storm fife

-- -------------------------------------------------------
-- Combat Caster's Axe +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17931, 9, 2, 53, 1);      -- DEX +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17932, 9, 3, 53, 1);      -- DEX +3 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(17933, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(17933, 56, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17933, 58, -10, 47, 0);
INSERT INTO `item_latents` VALUES(17941, 56, 15, 31, 0);    -- [Element: Wind]+15
INSERT INTO `item_latents` VALUES(17941, 366, 5, 31, 0);    -- Mighty Pick DMG+5 on Windsday
INSERT INTO `item_latents` VALUES(17944, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(17944, 366, 13, 47, 0);

-- -------------------------------------------------------
-- Maneater
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17946, 23, 18, 6, 1000);  -- Attack+18 while TP <100%
INSERT INTO `item_latents` VALUES(17946, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(17946, 366, 6, 6, 1000);  -- DMG+6 while TP <100%

-- -------------------------------------------------------
-- Garde Pick
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17947, 24, 3, 53, 0);     -- RATK +3 in areas inside own nation's control
INSERT INTO `item_latents` VALUES(17947, 26, 3, 53, 0);     -- RACC +3 in areas inside own nation's control

INSERT INTO `item_latents` VALUES(17950, 366, 4, 58, 0);    -- Marid Ancus dmg +4
INSERT INTO `item_latents` VALUES(17950, 391, 2, 58, 0);    -- charm +2

-- -------------------------------------------------------
-- Sirius Axe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17952, 160, 2, 15, 2);    -- DMG increases by 2 per member
INSERT INTO `item_latents` VALUES(17952, 160, 2, 15, 3);    -- DMG increases by 2 per member
INSERT INTO `item_latents` VALUES(17952, 160, 2, 15, 4);    -- DMG increases by 2 per member
INSERT INTO `item_latents` VALUES(17952, 160, 2, 15, 5);    -- DMG increases by 2 per member
INSERT INTO `item_latents` VALUES(17952, 160, 2, 15, 6);    -- DMG increases by 2 per member
INSERT INTO `item_latents` VALUES(17952, 366, 2, 16, 3);
INSERT INTO `item_latents` VALUES(17952, 366, 2, 16, 4);
INSERT INTO `item_latents` VALUES(17952, 366, 2, 16, 5);
INSERT INTO `item_latents` VALUES(17952, 366, 2, 16, 6);

INSERT INTO `item_latents` VALUES(17964, 165, 7, 59, 17);   -- Barkborer - Vs. plantoid: Critical hit rate +7%

-- -------------------------------------------------------
-- Lyft Tabar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17970, 9, 1, 16, 3);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 9, 1, 16, 4);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 9, 1, 16, 5);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 9, 1, 16, 6);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 23, 2, 16, 3);     -- ATT +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 23, 2, 16, 4);     -- ATT +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 23, 2, 16, 5);     -- ATT +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(17970, 23, 2, 16, 6);     -- ATT +2~8, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- San d'Orian Dagger / Kingdom Dagger
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17972, 11, 1, 53, 1);     -- AGI +1 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17973, 11, 2, 53, 1);     -- AGI +2 in areas outside own nation's control

-- -------------------------------------------------------
-- Windurstian Kukri / Federation Kukri
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17978, 23, 5, 53, 1);     -- ATT +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17979, 23, 7, 53, 1);     -- ATT +7 in areas outside own nation's control

-- -------------------------------------------------------
-- Valiant Knife
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 1);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 10);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 19);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 28);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 37);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 46);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 55);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 64);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 73);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 82);
INSERT INTO `item_latents` VALUES(17983, 366, 1, 0, 92);

-- -------------------------------------------------------
-- Combat Caster's Dagger +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(17990, 5, 14, 53, 1);     -- MP +14 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(17991, 5, 16, 53, 1);     -- MP +16 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(18000, 56, 15, 31, 0);    -- [Element: Wind]+15
INSERT INTO `item_latents` VALUES(18000, 366, 10, 31, 0);   -- Mighty Knife DMG+10 on Windsday
INSERT INTO `item_latents` VALUES(18005, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(18005, 366, 15, 47, 0);

-- -------------------------------------------------------
-- Blau Dolch
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18015, 23, 16, 6, 1000);  -- Attack+16 while TP <100%
INSERT INTO `item_latents` VALUES(18015, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18015, 366, 7, 6, 1000);  -- DMG+7 while TP <100%

-- -------------------------------------------------------
-- Titan's Baselard
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18021, 366, 5, 21, 11);   -- DMG: 33

-- -------------------------------------------------------
-- Windurstian Scythe/Federation Scythe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18036, 5, 10, 53, 1);     -- MP +10 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(18037, 5, 12, 53, 1);     -- MP +12 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18049, 56, 15, 31, 0);    -- [Element: Wind]+15
INSERT INTO `item_latents` VALUES(18049, 366, 8, 31, 0);    -- Mighty Zaghnal DMG+8 on Windsday
INSERT INTO `item_latents` VALUES(18053, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(18053, 366, 13, 47, 0);

-- -------------------------------------------------------
-- Garuda's Sickle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18063, 25, 13, 21, 13);   -- Accuracy +13

INSERT INTO `item_latents` VALUES(18064, 23, 6, 58, 0);     -- Volunteer's Scythe att +6
INSERT INTO `item_latents` VALUES(18064, 366, 2, 58, 0);    -- dmg +2

-- -------------------------------------------------------
-- San d'Orian Halberd / Kingdom Halberd
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18070, 25, 3, 53, 1);     -- ACC +3 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18071, 25, 4, 53, 1);     -- ACC +4 in areas outside own nation's control

-- -------------------------------------------------------
-- Royal Knight's Army Lance +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18072, 23, 8, 53, 1);     -- ATT +8 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18073, 23, 9, 53, 1);     -- ATT +9 in areas outside own nation's control

-- -------------------------------------------------------
-- Rossignol
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18075, 8, 2, 26, 2);      -- Dusk - Dawn: STR +2

INSERT INTO `item_latents` VALUES(18084, 9, 6, 56, 0);      -- Rune Halberd +6 DEX
INSERT INTO `item_latents` VALUES(18084, 288, 5, 56, 0);    -- Rune Halberd +5% Dbl.Atk.
INSERT INTO `item_latents` VALUES(18084, 369, -3, 56, 0);   -- Rune Halberd -3MP/tic

INSERT INTO `item_latents` VALUES(18091, 54, 15, 28, 0);    -- [Element: Fire]+15
INSERT INTO `item_latents` VALUES(18091, 366, 12, 28, 0);   -- Mighty Lance DMG+12 on Firesday
INSERT INTO `item_latents` VALUES(18097, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(18097, 366, 13, 47, 0);

-- -------------------------------------------------------
-- Stone-splitter
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18099, 23, 24, 6, 1000);  -- Attack+24 while TP <100%
INSERT INTO `item_latents` VALUES(18099, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18099, 366, 5, 6, 1000);  -- DMG+5 while TP <100%

-- -------------------------------------------------------
-- Leviathan's Couse
-- -------------------------------------------------------
-- TODO: INSERT INTO `item_latents` VALUES(18109, 431, 1, 21, 12); -- Additional effect: Water damage

INSERT INTO `item_latents` VALUES(18112, 366, 9, 58, 0);    -- Puk Lance dmg +9

-- -------------------------------------------------------
-- Combat Caster's Boomerang +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18132, 25, 4, 53, 1);     -- ACC +4 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18132, 26, 4, 53, 1);     -- RACC +4 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18133, 25, 5, 53, 1);     -- ACC +5 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18133, 26, 5, 53, 1);     -- RACC +5 in areas outside own nation's control

-- -------------------------------------------------------
-- Junior Musketeer's Chakram +1/+2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18134, 8, 2, 53, 1);      -- STR +2 in areas outside own nation's control
INSERT INTO `item_latents` VALUES(18135, 8, 3, 53, 1);      -- STR +3 in areas outside own nation's control

INSERT INTO `item_latents` VALUES(18144, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(18144, 56, -10, 47, 0);
INSERT INTO `item_latents` VALUES(18144, 58, -10, 47, 0);
INSERT INTO `item_latents` VALUES(18146, 2, -20, 47, 0);
INSERT INTO `item_latents` VALUES(18146, 57, -10, 47, 0);
INSERT INTO `item_latents` VALUES(18146, 59, -10, 47, 0);

-- -------------------------------------------------------
-- Fenrir's Stone
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18165, 2, 30, 26, 0);     -- Daytime: HP+30
INSERT INTO `item_latents` VALUES(18165, 68, 10, 26, 1);    -- Nighttime: Evasion+10

INSERT INTO `item_latents` VALUES(18206, 25, 5, 56, 0);     -- Rune Chopper +5 Acc.
INSERT INTO `item_latents` VALUES(18206, 369, -3, 56, 0);   -- Rune Chopper -3MP/tic
INSERT INTO `item_latents` VALUES(18206, 384, 900, 56, 0);  -- Rune Chopper +9% haste
INSERT INTO `item_latents` VALUES(18213, 54, 15, 28, 0);    -- [Element: Fire]+15
INSERT INTO `item_latents` VALUES(18213, 366, 10, 28, 0);   -- Mighty Axe DMG+10 on Firesday
INSERT INTO `item_latents` VALUES(18217, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(18217, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(18256, 23, 1, 25, 0);     -- Orphic Egg, ATT+1 song/roll active
INSERT INTO `item_latents` VALUES(18256, 25, 1, 25, 0);     -- Orphic Egg, ACC+1 song/roll active
INSERT INTO `item_latents` VALUES(18256, 68, 1, 25, 0);     -- Orphic Egg, EVA+1 song/roll active

-- -------------------------------------------------------
-- Militant Knuckles
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18261, 59, 7, 48, 0);     -- [Element: Water]+7
INSERT INTO `item_latents` VALUES(18261, 366, 15, 48, 0);   -- DMG:+16

-- -------------------------------------------------------
-- Dynamis Knuckles
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18262, 59, 9, 48, 0);     -- [Element: Water]+9
INSERT INTO `item_latents` VALUES(18262, 366, 2, 48, 0);    -- DMG:+18

-- -------------------------------------------------------
-- Malefic Dagger
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18267, 61, 7, 48, 0);     -- [Element: Dark]+7
INSERT INTO `item_latents` VALUES(18267, 366, 22, 48, 0);   -- DMG:+23

-- -------------------------------------------------------
-- Dynamis Dagger
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18268, 61, 9, 48, 0);     -- [Element: Dark]+9
INSERT INTO `item_latents` VALUES(18268, 366, 3, 48, 0);    -- DMG:+26

-- -------------------------------------------------------
-- Glyptic Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18273, 58, 7, 48, 0);     -- [Element: Thunder]+7
INSERT INTO `item_latents` VALUES(18273, 366, 39, 48, 0);   -- DMG:+40

-- -------------------------------------------------------
-- Dynamis Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18274, 58, 9, 48, 0);     -- [Element: Thunder]+9
INSERT INTO `item_latents` VALUES(18274, 366, 8, 48, 0);    -- DMG:48

-- -------------------------------------------------------
-- Gilded Blade
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18279, 56, 7, 48, 0);     -- [Element: Air]+7
INSERT INTO `item_latents` VALUES(18279, 366, 79, 48, 0);   -- DMG:80

-- -------------------------------------------------------
-- Dynamis Blade
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18280, 56, 9, 48, 0);     -- [Element: Air]+9
INSERT INTO `item_latents` VALUES(18280, 366, 5, 48, 0);    -- DMG:85

-- -------------------------------------------------------
-- Leonine Axe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18285, 60, 7, 48, 0);     -- [Element: Light]+7
INSERT INTO `item_latents` VALUES(18285, 366, 45, 48, 0);   -- DMG:46

-- -------------------------------------------------------
-- Dynamis Axe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18286, 60, 9, 48, 0);     -- [Element: Light]+9
INSERT INTO `item_latents` VALUES(18286, 366, 4, 48, 0);    -- DMG:50

-- -------------------------------------------------------
-- Agonal Bhuj
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18291, 60, 7, 48, 0);     -- [Element: Light]+7
INSERT INTO `item_latents` VALUES(18291, 366, 86, 48, 0);   -- DMG:87

-- -------------------------------------------------------
-- Dynamis Bhuj
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18292, 60, 9, 48, 0);     -- [Element: Light]+9
INSERT INTO `item_latents` VALUES(18292, 366, 4, 48, 0);    -- DMG:93

-- -------------------------------------------------------
-- Hotspur Lance
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18297, 57, 7, 48, 0);     -- [Element: Earth]+7
INSERT INTO `item_latents` VALUES(18297, 366, 81, 48, 0);   -- DMG:82

-- -------------------------------------------------------
-- Dynamis Lance
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18298, 57, 9, 48, 0);     -- [Element: Earth]+9
INSERT INTO `item_latents` VALUES(18298, 366, 2, 48, 0);    -- DMG:84

-- -------------------------------------------------------
-- Memento Scythe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18303, 55, 7, 48, 0);     -- [Element: Ice]+7
INSERT INTO `item_latents` VALUES(18303, 366, 81, 48, 0);   -- DMG:82

-- -------------------------------------------------------
-- Dynamis Scythe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18304, 55, 9, 48, 0);     -- [Element: Ice]+9
INSERT INTO `item_latents` VALUES(18304, 366, 3, 48, 0);    -- DMG:85

-- -------------------------------------------------------
-- Mimizuku
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18309, 61, 7, 48, 0);     -- [Element: Dark]+7
INSERT INTO `item_latents` VALUES(18309, 366, 32, 48, 0);   -- DMG:33

-- -------------------------------------------------------
-- Rogetsu
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18310, 61, 9, 48, 0);     -- [Element: Dark]+9
INSERT INTO `item_latents` VALUES(18310, 366, 7, 48, 0);    -- DMG:40

-- -------------------------------------------------------
-- Hayatemaru
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18315, 56, 7, 48, 0);     -- [Element: Air]+7
INSERT INTO `item_latents` VALUES(18315, 366, 75, 48, 0);   -- DMG:76

-- -------------------------------------------------------
-- Oboromaru
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18316, 56, 9, 48, 0);     -- [Element: Air]+9
INSERT INTO `item_latents` VALUES(18316, 366, 3, 48, 0);    -- DMG:79

-- -------------------------------------------------------
-- Battering Maul
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18321, 58, 7, 48, 0);     -- [Element: Thunder]+7
INSERT INTO `item_latents` VALUES(18321, 366, 28, 48, 0);   -- DMG:29

-- -------------------------------------------------------
-- Dynamis Maul
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18322, 58, 9, 48, 0);     -- [Element: Thunder]+9
INSERT INTO `item_latents` VALUES(18322, 366, 5, 48, 0);    -- DMG:35

-- -------------------------------------------------------
-- Sage's Staff
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18327, 54, 7, 48, 0);     -- [Element: Fire]+7
INSERT INTO `item_latents` VALUES(18327, 366, 54, 48, 0);   -- DMG:55

-- -------------------------------------------------------
-- Dynamis Staff
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18328, 54, 9, 48, 0);     -- [Element: Fire]+9
INSERT INTO `item_latents` VALUES(18328, 366, 3, 48, 0);    -- DMG:58

-- -------------------------------------------------------
-- Marksman Gun
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18333, 54, 7, 48, 0);     -- [Element: Fire]+7
INSERT INTO `item_latents` VALUES(18333, 366, 38, 48, 0);   -- DMG:39

-- -------------------------------------------------------
-- Dynamis Gun
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18334, 54, 9, 48, 0);     -- [Element: Fire]+9
INSERT INTO `item_latents` VALUES(18334, 366, 3, 48, 0);    -- DMG:42

-- -------------------------------------------------------
-- Pyrrhic Horn
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18339, 14, 1, 48, 0);     -- CHR+1
INSERT INTO `item_latents` VALUES(18339, 55, 7, 48, 0);     -- [Element: Ice]+7

-- -------------------------------------------------------
-- Dynamis Horn
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18340, 14, 2, 48, 0);     -- CHR+2
INSERT INTO `item_latents` VALUES(18340, 55, 9, 48, 0);     -- [Element: Ice]+9

-- -------------------------------------------------------
-- Millennium Horn
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18341, 14, 3, 48, 0);     -- CHR+3
INSERT INTO `item_latents` VALUES(18341, 452, 2, 48, 0);    -- All songs +2

-- -------------------------------------------------------
-- Wolver Bow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18345, 59, 7, 48, 0);     -- [Element: Water]+7
INSERT INTO `item_latents` VALUES(18345, 366, 67, 48, 0);   -- DMG:68

-- -------------------------------------------------------
-- Dynamis Bow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18346, 59, 9, 48, 0);     -- [Element: Water]+9
INSERT INTO `item_latents` VALUES(18346, 366, 3, 48, 0);    -- DMG:71

INSERT INTO `item_latents` VALUES(18352, 54, 15, 28, 0);    -- [Element: Fire]+15
INSERT INTO `item_latents` VALUES(18352, 366, 5, 28, 0);    -- Mighty Patas DMG+10 on Firesday

-- -------------------------------------------------------
-- Wagh Baghnakhs
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18358, 23, 14, 6, 1000);  -- Attack+14 while TP <100%
INSERT INTO `item_latents` VALUES(18358, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18358, 366, 5, 6, 1000);  -- DMG+5 while TP <100%

INSERT INTO `item_latents` VALUES(18364, 291, 1, 58, 0);    -- counter +1
INSERT INTO `item_latents` VALUES(18364, 366, 2, 58, 0);    -- Pahluwan Katars dmg +2
INSERT INTO `item_latents` VALUES(18374, 54, 15, 28, 0);    -- [Element: Fire]+15
INSERT INTO `item_latents` VALUES(18374, 366, 9, 28, 0);    -- Mighty Sword DMG+9 on Firesday
INSERT INTO `item_latents` VALUES(18378, 165, 6, 47, 0);
INSERT INTO `item_latents` VALUES(18378, 366, 13, 47, 0);
INSERT INTO `item_latents` VALUES(18387, 25, 5, 58, 0);     -- acc +5
INSERT INTO `item_latents` VALUES(18387, 366, 3, 58, 0);    -- Djinnbringer dmg +3
INSERT INTO `item_latents` VALUES(18390, 28, 3, 8, 4);

-- -------------------------------------------------------
-- Ramuh's Mace
-- -------------------------------------------------------
-- TODO: INSERT INTO `item_latents` VALUES(18404, 431, 1, 21, 15); -- Additional effect: Lightning damage

INSERT INTO `item_latents` VALUES(18407, 5, 20, 58, 0);     -- mp +20
INSERT INTO `item_latents` VALUES(18407, 27, -3, 58, 0);    -- enmity -3
INSERT INTO `item_latents` VALUES(18407, 366, 2, 58, 0);    -- Imperial Wand dmg +2
INSERT INTO `item_latents` VALUES(18416, 289, 1, 58, 0);    -- subtle blow +1
INSERT INTO `item_latents` VALUES(18416, 366, 4, 58, 0);    -- Karasuageha dmg +4
INSERT INTO `item_latents` VALUES(18422, 62, 1, 13, 66);
INSERT INTO `item_latents` VALUES(18422, 62, 1, 13, 444);
INSERT INTO `item_latents` VALUES(18422, 62, 1, 13, 445);
INSERT INTO `item_latents` VALUES(18422, 62, 1, 13, 446);

-- -------------------------------------------------------
-- Perdu Blade
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18425, 23, 10, 6, 1000);  -- Attack+10 while TP <100%
INSERT INTO `item_latents` VALUES(18425, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18425, 366, 5, 6, 1000);  -- DMG+5 while TP <100%

INSERT INTO `item_latents` VALUES(18434, 73, 2, 58, 0);     -- store tp +2
INSERT INTO `item_latents` VALUES(18434, 366, 3, 58, 0);    -- Kosetsusamonji dmg +3
INSERT INTO `item_latents` VALUES(18438, 165, 8, 59, 20);   -- Kumokirimaru - Vs. vermin: Critical hit rate +8%

-- -------------------------------------------------------
-- Amakura
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18445, 73, 10, 0, 50);    -- "Store TP"+10 when HP <50%

INSERT INTO `item_latents` VALUES(18484, 288, 1, 58, 0);    -- double attack +1
INSERT INTO `item_latents` VALUES(18484, 366, 5, 58, 0);    -- Wamoura Axe dmg +5
INSERT INTO `item_latents` VALUES(18486, 171, -30, 25, 0);  -- Wardancer, Delay: 474 (504 - 30) song/roll active

-- -------------------------------------------------------
-- Perdu Voulge
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18491, 23, 10, 6, 1000);  -- Attack+10 while TP <100%
INSERT INTO `item_latents` VALUES(18491, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18491, 366, 5, 6, 1000);  -- DMG+5 while TP <100%

INSERT INTO `item_latents` VALUES(18504, 165, 7, 59, 17);   -- Eventreuse - Vs. plantoid: Critical hit rate +7%

-- -------------------------------------------------------
-- Lyft Voulge
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18508, 8, 1, 16, 3);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 8, 1, 16, 4);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 8, 1, 16, 5);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 8, 1, 16, 6);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 25, 2, 16, 3);     -- ACC +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 25, 2, 16, 4);     -- ACC +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 25, 2, 16, 5);     -- ACC +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18508, 25, 2, 16, 6);     -- ACC +2~8, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Carbuncle's Pole
-- --------------------------------------------------------
INSERT INTO `item_latents` VALUES(18581, 431, 2, 21, 8);    -- Additional effect: Light damage

INSERT INTO `item_latents` VALUES(18582, 6, 2, 58, 0);      -- mp% +2
INSERT INTO `item_latents` VALUES(18582, 366, 1, 58, 0);    -- Yigit Staff dmg +1

-- -------------------------------------------------------
-- Perdu Staff
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18588, 23, 10, 6, 1000);  -- Attack+10 while TP <100%
INSERT INTO `item_latents` VALUES(18588, 25, 6, 6, 1000);   -- Accuracy+6 while TP <100%
INSERT INTO `item_latents` VALUES(18588, 366, 6, 6, 1000);  -- DMG+6 while TP <100%

INSERT INTO `item_latents` VALUES(18683, 26, 10, 58, 0);    -- ranged acc +10
INSERT INTO `item_latents` VALUES(18683, 366, 2, 58, 0);    -- Imperial Bow dmg +2

INSERT INTO `item_latents` VALUES(18684, 24, 10, 58, 0);    -- ranged att +10
INSERT INTO `item_latents` VALUES(18684, 366, 2, 58, 0);    -- Storm Zamburak dmg +2

-- -------------------------------------------------------
-- Perdu Bow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18717, 24, 10, 6, 1000);  -- Ranged Attack+10 while TP <100%, changed to value on bg since it is different value than ffxicyclopedia
INSERT INTO `item_latents` VALUES(18717, 26, 5, 6, 1000);   -- Ranged Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18717, 366, 4, 6, 1000);  -- DMG+4 while TP <100%

-- -------------------------------------------------------
-- Perdu Crossbow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18718, 24, 10, 6, 1000);  -- Ranged Attack+10 while TP <100%
INSERT INTO `item_latents` VALUES(18718, 26, 5, 6, 1000);   -- Ranged Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18718, 366, 4, 6, 1000);  -- DMG+4 while TP <100%

INSERT INTO `item_latents` VALUES(18741, 23, 10, 9, 4);

-- -------------------------------------------------------
-- Gnole Sainti (+1)
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18757, 8, 2, 37, 4);      -- Full moon STR+2
INSERT INTO `item_latents` VALUES(18757, 9, 2, 37, 4);      -- Full moon DEX+2
INSERT INTO `item_latents` VALUES(18758, 8, 3, 37, 4);      -- Full moon STR+3
INSERT INTO `item_latents` VALUES(18758, 9, 3, 37, 4);      -- Full moon DEX+3

INSERT INTO `item_latents` VALUES(18767, 25, 3, 59, 8);     -- Birdbanes - Vs. birds: Accuracy+3
INSERT INTO `item_latents` VALUES(18768, 23, 12, 9, 4);

-- -------------------------------------------------------
-- Lyft Sainti
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18771, 23, 1, 16, 3);     -- ATT +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18771, 23, 1, 16, 4);     -- ATT +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18771, 23, 1, 16, 5);     -- ATT +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18771, 23, 1, 16, 6);     -- ATT +1~4, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Perdu Wand
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18850, 23, 14, 6, 1000);  -- Attack+14 while TP <100%
INSERT INTO `item_latents` VALUES(18850, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18850, 366, 5, 6, 1000);  -- DMG+5 while TP <100%

-- -------------------------------------------------------
-- Kerykeion
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18859, 370, 3, 0, 50);    -- Regen+3 when HP <51%

-- -------------------------------------------------------
-- Hannibal's Sword
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18891,368,10,56,0);       -- Regain +10
INSERT INTO `item_latents` VALUES(18891,369,-3,56,0);       -- Refresh -3

-- -------------------------------------------------------
-- Chimeric Fleuret
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18895,288,4,13,94);       -- Double attack +4 ENFIRE
INSERT INTO `item_latents` VALUES(18895,288,4,13,95);       -- Double attack +4 ENBLIZZARD
INSERT INTO `item_latents` VALUES(18895,288,4,13,96);       -- Double attack +4 ENAERO
INSERT INTO `item_latents` VALUES(18895,288,4,13,97);       -- Double attack +4 ENSTONE
INSERT INTO `item_latents` VALUES(18895,288,4,13,98);       -- Double attack +4 ENTHUNDER
INSERT INTO `item_latents` VALUES(18895,288,4,13,99);       -- Double attack +4 ENWATER
INSERT INTO `item_latents` VALUES(18895,288,4,13,277);      -- Double attack +4 ENFIRE_II
INSERT INTO `item_latents` VALUES(18895,288,4,13,278);      -- Double attack +4 ENBLIZZARD_II
INSERT INTO `item_latents` VALUES(18895,288,4,13,279);      -- Double attack +4 ENAERO_II
INSERT INTO `item_latents` VALUES(18895,288,4,13,280);      -- Double attack +4 ENSTONE_II
INSERT INTO `item_latents` VALUES(18895,288,4,13,281);      -- Double attack +4 ENTHUNDER_II
INSERT INTO `item_latents` VALUES(18895,288,4,13,282);      -- Double attack +4 ENWATER_II


INSERT INTO `item_latents` VALUES(18865, 165, 7, 59, 20);   -- Zonure - Vs. vermin: Critical hit rate +7%

-- -------------------------------------------------------
-- Perdu Sickle
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18943, 23, 14, 6, 1000);  -- Attack+14 while TP <100%
INSERT INTO `item_latents` VALUES(18943, 25, 5, 6, 1000);   -- Accuracy+5 while TP <100%
INSERT INTO `item_latents` VALUES(18943, 366, 5, 6, 1000);  -- DMG+5 while TP <100%

-- -------------------------------------------------------
-- Zareehkl Scythe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18949, 302, 1, 0, 25);    -- Tiple Attack 1% when HP <=25%

-- -------------------------------------------------------
-- Lyft Scythe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18958, 8, 1, 16, 3);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18958, 8, 1, 16, 4);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18958, 8, 1, 16, 5);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(18958, 8, 1, 16, 6);      -- STR +1~4, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Conqueror 75
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(18991, 165, 5, 13, 56);   -- Crit Rate +5% if Berserk Active
INSERT INTO `item_latents` VALUES(18991, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Conqueror 80
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19060, 165, 7, 13, 56);   -- Crit Rate +7% if Berserk Active
INSERT INTO `item_latents` VALUES(19060, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Conqueror 85
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19080, 165, 9, 13, 56);   -- Crit Rate +9% if Berserk Active
INSERT INTO `item_latents` VALUES(19080, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Zareehkl Jambiya
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19108, 366, 5, 0, 75);    -- DNG:36 when HP <=75%

-- INSERT INTO `item_latents` VALUES(19110, 132, 1, 24, x); -- Trainee's Needle - : +1 Leather craft (x not implemented)
INSERT INTO `item_latents` VALUES(19113, 165, 7, 59, 14);   -- Ermine's Tail - Vs. lizards: Critical hit rate +7%
INSERT INTO `item_latents` VALUES(19120, 25, 6, 13, 368);
INSERT INTO `item_latents` VALUES(19120, 25, 6, 13, 369);
INSERT INTO `item_latents` VALUES(19120, 25, 6, 13, 370);

-- -------------------------------------------------------
-- Lyft Jambiya
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19125, 9, 1, 16, 3);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19125, 9, 1, 16, 4);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19125, 9, 1, 16, 5);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19125, 9, 1, 16, 6);      -- DEX +1~4, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Papilio Kirpan
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19126,23,14,6,1000);      -- ATT+14 TP<1000
INSERT INTO `item_latents` VALUES(19126,25,5,6,1000);       -- ACC+5  TP<1000
INSERT INTO `item_latents` VALUES(19126,366,6,6,1000);      -- DMG+6  TP<1000


INSERT INTO `item_latents` VALUES(19158, 165, 7, 59, 14);   -- Scheherazade - Vs. lizards: Critical hit rate +7%

-- -------------------------------------------------------
-- Lyft Claymore
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19161, 8, 1, 16, 3);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19161, 8, 1, 16, 4);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19161, 8, 1, 16, 5);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19161, 8, 1, 16, 6);      -- STR +1~4, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Wurger
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19222, 24, 3, 52, 6);     -- Ranged attack +3 in Water weather

-- -------------------------------------------------------
-- Lyft Crossbow
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19233, 13, 1, 16, 3);     -- MND +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19233, 13, 1, 16, 4);     -- MND +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19233, 13, 1, 16, 5);     -- MND +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19233, 13, 1, 16, 6);     -- MND +1~4, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Lyft Hexagun
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19234, 11, 1, 16, 3);     -- AGI +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19234, 11, 1, 16, 4);     -- AGI +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19234, 11, 1, 16, 5);     -- AGI +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19234, 11, 1, 16, 6);     -- AGI +1~4, party size 3+. Effect strengthens with more members

INSERT INTO `item_latents` VALUES(19273, 165, 7, 59, 6);    -- Onishibari - Vs. beasts: Critical hit rate +7%

-- -------------------------------------------------------
-- Musanto
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19279, 9, 1, 16, 3);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19279, 9, 1, 16, 4);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19279, 9, 1, 16, 5);      -- DEX +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19279, 9, 1, 16, 6);      -- DEX +1~4, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Lyft Lance
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19306, 8, 1, 16, 3);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 8, 1, 16, 4);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 8, 1, 16, 5);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 8, 1, 16, 6);      -- STR +1~4, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 23, 2, 16, 3);     -- ATT +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 23, 2, 16, 4);     -- ATT +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 23, 2, 16, 5);     -- ATT +2~8, party size 3+. Effect strengthens with more members
INSERT INTO `item_latents` VALUES(19306, 23, 2, 16, 6);     -- ATT +2~8, party size 3+. Effect strengthens with more members

-- -------------------------------------------------------
-- Conqueror 90
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19612, 165, 11, 13, 56);  -- Crit Rate +11% if Berserk Active
INSERT INTO `item_latents` VALUES(19612, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Conqueror 95
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19710, 165, 11, 13, 56);  -- Crit Rate +11% if Berserk Active
INSERT INTO `item_latents` VALUES(19710, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Conqueror 99
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19819, 165, 14, 13, 56);  -- Crit Rate +14% if Berserk Active
INSERT INTO `item_latents` VALUES(19819, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Conqueror 99 AG
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(19948, 165, 14, 13, 56);  -- Crit Rate +14% if Berserk Active
INSERT INTO `item_latents` VALUES(19948, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Eminent Baghnakhs
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(20540,23,10,6,1000);      -- Att+10 TP<1000
INSERT INTO `item_latents` VALUES(20540,25,39,6,1000);      -- Acc+39 TP<1000
INSERT INTO `item_latents` VALUES(20540,366,4,6,1000);      -- Dmg+4  TP<1000

-- -------------------------------------------------------
-- Eminent Scimitar
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(20726,23,10,6,1000);      -- Att+10 TP>1000
INSERT INTO `item_latents` VALUES(20726,25,15,6,1000);      -- Acc+15 TP>1000
INSERT INTO `item_latents` VALUES(20726,366,6,6,1000);      -- Dmg+6  TP>1000


-- -------------------------------------------------------
-- Conqueror 119
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(20837, 165, 14, 13, 56);  -- Crit Rate +14% if Berserk Active
INSERT INTO `item_latents` VALUES(20837, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- -------------------------------------------------------
-- Conqueror 119 AG
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(20838, 165, 14, 13, 56);  -- Crit Rate +14% if Berserk Active
INSERT INTO `item_latents` VALUES(20838, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- INSERT INTO `item_latents` VALUES(21521, 25, 10, ??, 0); -- Melee fists: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21521, 30, 10, ??, 0); -- Melee fists: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21522, 25, 10, ??, 0); -- Hesychast's fists: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21522, 30, 10, ??, 0); -- Hesychast's fists: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21524, 25, 10, ??, 0); -- Pantin Fists: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21524, 25, 30, ??, 0); -- Pantin Fists: Dynamis (D): Automaton: Accuracy+30
-- INSERT INTO `item_latents` VALUES(21524, 26, 30, ??, 0); -- Pantin Fists: Dynamis (D): Automaton: Ranged Accuracy+30
-- INSERT INTO `item_latents` VALUES(21524, 30, 10, ??, 0); -- Pantin Fists: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21524, 30, 30, ??, 0); -- Pantin Fists: Dynamis (D): Automaton: Magic Accuracy+30
-- INSERT INTO `item_latents` VALUES(21525, 25, 10, ??, 0); -- Pitre Fists: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21525, 25, 40, ??, 0); -- Pitre Fists: Dynamis (D): Automaton: Accuracy+40
-- INSERT INTO `item_latents` VALUES(21525, 26, 40, ??, 0); -- Pitre Fists: Dynamis (D): Automaton: Ranged Accuracy+40
-- INSERT INTO `item_latents` VALUES(21525, 30, 10, ??, 0); -- Pitre Fists: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21525, 30, 40, ??, 0); -- Pitre Fists: Dynamis (D): Automaton: Magic Accuracy+40
INSERT INTO `item_latents` VALUES(21558,11,5,56,0);         -- Rune Kris: Agi+5     MP>0
INSERT INTO `item_latents` VALUES(21558,73,5,56,0);         -- Rune Kris: StoreTP+5 MP>0
INSERT INTO `item_latents` VALUES(21558,369,-3,56,0);       -- Rune Kris: Refresh-3 MP>0
-- INSERT INTO `item_latents` VALUES(21573, 25, 10, ??, 0); -- Assassin's Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21573, 30, 10, ??, 0); -- Assassin's Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21574, 25, 10, ??, 0); -- Plunderer's Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21574, 30, 10, ??, 0); -- Plunderer's Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21576, 25, 10, ??, 0); -- Bard's Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21576, 30, 10, ??, 0); -- Bard's Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21576, 160, -1, 13, ??); -- Bard's Knife: Song effects: Damage taken -1% - May need to check for all songs (All 30... song types...)
-- INSERT INTO `item_latents` VALUES(21577, 25, 10, ??, 0); -- Bihu Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21577, 30, 10, ??, 0); -- Bihu Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21577, 160, -2, 13, ??); -- Bihu Knife: Song effects: Damage taken -2%
-- INSERT INTO `item_latents` VALUES(21578, 160, -3, 13, ??); -- Barfawc: Song effects: Damage taken -3%
-- INSERT INTO `item_latents` VALUES(21579, 25, 10, ??, 0); -- Commodore's Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21579, 30, 10, ??, 0); -- Commodore's Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21579, 160, -3, 13, ??); -- Commodore's Knife: "Phantom Roll" effect: Damage taken -2%
-- INSERT INTO `item_latents` VALUES(21580, 25, 10, ??, 0); -- Lanun Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21580, 30, 10, ??, 0); -- Lanun Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21580, 160, -3, 13, ??); -- Lanun Knife: "Phantom Roll" effect: Damage taken -4%
-- INSERT INTO `item_latents` VALUES(21581, 160, -3, 13, ??); -- Rostam: "Phantom Roll" effect: Damage taken -6%
-- INSERT INTO `item_latents` VALUES(21582, 25, 10, ??, 0); -- Etoile Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21582, 30, 10, ??, 0); -- Etoile Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21583, 25, 10, ??, 0); -- Horos Knife: Dynamis (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21583, 30, 10, ??, 0); -- Horos Knife: Dynamis (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21625, 25, 10, ??, 0); -- Duelist's Sword: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21625, 30, 10, ??, 0); -- Duelist's Sword: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21626, 25, 10, ??, 0); -- Vitiation Sword: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21626, 30, 10, ??, 0); -- Vitiation Sword: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21628, 25, 10, ??, 0); -- Valor Sword: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21628, 30, 10, ??, 0); -- Valor Sword: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21629, 25, 10, ??, 0); -- Caballarius Sword: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21629, 30, 10, ??, 0); -- Caballarius Sword: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21631, 25, 10, ??, 0); -- Mirage Sword: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21631, 30, 10, ??, 0); -- Mirage Sword: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21632, 25, 10, ??, 0); -- Luhlaza Sword: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21632, 30, 10, ??, 0); -- Luhlaza Sword: (D): Magic Accuracy+10
INSERT INTO `item_latents` VALUES(21661, 10, 5, 56, 0);     -- Rune Algol: Latent effect (MP>0): VIT+5
INSERT INTO `item_latents` VALUES(21661, 369, -3, 56, 0);   -- Rune Algol: Drains 3 MP/tic from player (while weapon is drawn).
INSERT INTO `item_latents` VALUES(21661, 840, 1, 56, 0);    -- Rune Algol: Latent effect (MP>0): Weapon skill damage +1%
-- INSERT INTO `item_latents` VALUES(21667, 25, 10, ??, 0); -- Futhark Claymore: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21667, 30, 10, ??, 0); -- Futhark Claymore: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21668, 25, 10, ??, 0); -- Peord Claymore: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21668, 30, 10, ??, 0); -- Peord Claymore: (D): Magic Accuracy+10

-- -------------------------------------------------------
-- Conqueror 119 AG v3
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(21757, 165, 14, 13, 56);  -- Crit Rate +14% if Berserk Active
INSERT INTO `item_latents` VALUES(21757, 288, 3, 13, 56);   -- Double Attack +3% if Berserk Active

-- INSERT INTO `item_latents` VALUES(21772, 25, 10, ??, 0); -- Warrior's Chopper: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21772, 30, 10, ??, 0); -- Warrior's Chopper: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21773, 25, 10, ??, 0); -- Agoge Chopper: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21773, 30, 10, ??, 0); -- Agoge Chopper: (D): Magic Accuracy+10

-- -------------------------------------------------------
-- Rune Scythe
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(21817, 2, 10, 56, 0);     -- HP+10
INSERT INTO `item_latents` VALUES(21817, 165, 5, 56, 0);    -- Critical hit rate +5
INSERT INTO `item_latents` VALUES(21817, 369, -3, 56, 0);   -- Drains 3 MP/tic from player

-- INSERT INTO `item_latents` VALUES(21823, 25, 10, ??, 0); -- Abyss Scythe: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21823, 30, 10, ??, 0); -- Abyss Scythe: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21824, 25, 10, ??, 0); -- Fallen's Scythe: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21824, 30, 10, ??, 0); -- Fallen's Scythe: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21876, 25, 10, ??, 0); -- Wyrm Lance: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21876, 30, 10, ??, 0); -- Wyrm Lance: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21877, 25, 10, ??, 0); -- Pteroslaver Lance: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21877, 30, 10, ??, 0); -- Pteroslaver Lance: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21915, 23, 5, ??, ??); -- Koga shinobi-gatana: Attack+5 for each Utsusemi shadow image
-- INSERT INTO `item_latents` VALUES(21915, 25, 10, ??, 0); -- Koga shinobi-gatana: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21915, 30, 10, ??, 0); -- Koga shinobi-gatana: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21916, 23, 10, ??, ??); -- Mochizuki shinobi-gatana: Attack+10 for each Utsusemi shadow image
-- INSERT INTO `item_latents` VALUES(21916, 25, 10, ??, 0); -- Mochizuki shinobi-gatana: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21916, 30, 10, ??, 0); -- Mochizuki shinobi-gatana: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21917, 23, 15, ??, ??); -- Fudo Masamune: Attack+15 for each Utsusemi shadow image
-- INSERT INTO `item_latents` VALUES(21922, 368, 1, ??, ??); -- Gokotai: Regain based on Dual Wield, 1 TP/tic for every 1 Dual Wield
-- INSERT INTO `item_latents` VALUES(21968, 25, 10, ??, 0); -- Saotome-no-Tachi: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21968, 30, 10, ??, 0); -- Saotome-no-Tachi: (D): Magic Accuracy+10
INSERT INTO `item_latents` VALUES(21968, 345, 50, 13, 408); -- Saotome-no-Tachi: Sekkanoki: TP Bonus +50% based on remaining TP
-- INSERT INTO `item_latents` VALUES(21969, 25, 10, ??, 0); -- Sakonji-no-Tachi: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(21969, 30, 10, ??, 0); -- Sakonji-no-Tachi: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(21969, ??, 50, ??, 0); -- Sakonji-no-Tachi: Sekkanoki: TP Bonus +60% based on remaining TP
-- INSERT INTO `item_latents` VALUES(21970, ??, 70, 13, 408); -- Fusenaikyo: Sekkanoki: TP Bonus +70% based on remaining TP
INSERT INTO `item_latents` VALUES(21970, 355, 144, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Enpi)
INSERT INTO `item_latents` VALUES(21970, 355, 145, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Hobaku)
INSERT INTO `item_latents` VALUES(21970, 355, 146, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Goten)
INSERT INTO `item_latents` VALUES(21970, 355, 147, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Kagero)
INSERT INTO `item_latents` VALUES(21970, 355, 148, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Jinpu)
INSERT INTO `item_latents` VALUES(21970, 355, 149, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Koki)
INSERT INTO `item_latents` VALUES(21970, 355, 150, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Yukikaze)
INSERT INTO `item_latents` VALUES(21970, 355, 151, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Gekko)
INSERT INTO `item_latents` VALUES(21970, 355, 152, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Kasha)
INSERT INTO `item_latents` VALUES(21970, 355, 153, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Kaiten)
INSERT INTO `item_latents` VALUES(21970, 355, 154, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Rana)
INSERT INTO `item_latents` VALUES(21970, 355, 155, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Ageha)
INSERT INTO `item_latents` VALUES(21970, 355, 156, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Fudo)
INSERT INTO `item_latents` VALUES(21970, 355, 157, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Shoha)
INSERT INTO `item_latents` VALUES(21970, 355, 158, 13, 408); -- Fusenaikyo: Sekkanoki: Able to use all Great Katana weapon skills (Suikawari)
-- INSERT INTO `item_latents` VALUES(22031, ??, ??, ??, 0); -- Maxentius: Main hand: Increases magic burst damage based on skillchain length
-- INSERT INTO `item_latents` VALUES(22033, 25, 10, ??, 0); -- Cleric's Wand: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22033, 30, 10, ??, 0); -- Cleric's Wand: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22033, ??, ??, ??, 0); -- Cleric's Wand: Afflatus Misery: Esuna removes one extra status ailment
-- INSERT INTO `item_latents` VALUES(22034, 25, 10, ??, 0); -- Piety Wand: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22034, 30, 10, ??, 0); -- Piety Wand: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22034, ??, ??, ??, 0); -- Piety Wand: Afflatus Misery: Esuna removes two extra status ailments
-- INSERT INTO `item_latents` VALUES(22035, ??, ??, ??, 0); -- Asclepius: Afflatus Misery: Esuna removes three extra status ailments
-- INSERT INTO `item_latents` VALUES(22036, 25, 10, ??, 0); -- Bagua Wand: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22036, 30, 10, ??, 0); -- Bagua Wand: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22037, 25, 10, ??, 0); -- Sifang Wand: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22037, 30, 10, ??, 0); -- Sifang Wand: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22057, 369, 1, ??, 0); -- Contemplator: Unity Ranking: "Refresh"+1
-- INSERT INTO `item_latents` VALUES(22058, 369, 1, ??, 0); -- Contemplator +1: Unity Ranking: "Refresh"+1~2
-- INSERT INTO `item_latents` VALUES(22091, 25, 10, ??, 0); -- Sorcerer's Staff: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22091, 30, 10, ??, 0); -- Sorcerer's Staff: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22092, 25, 10, ??, 0); -- Archmage's Staff: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22092, 30, 10, ??, 0); -- Archmage's Staff: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22094, 25, 10, ??, 0); -- Summoner's Staff: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22094, 30, 10, ??, 0); -- Summoner's Staff: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22094, ??, 30, ??, 0); -- Summoner's Staff: (D): Avatar: Accuracy+30
-- INSERT INTO `item_latents` VALUES(22094, ??, 30, ??, 0); -- Summoner's Staff: (D): Avatar: Ranged Accuracy+30
-- INSERT INTO `item_latents` VALUES(22094, ??, 30, ??, 0); -- Summoner's Staff: (D): Avatar: Magic Accuracy+30
-- INSERT INTO `item_latents` VALUES(22095, 25, 10, ??, 0); -- Glyphic Staff: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22095, 30, 10, ??, 0); -- Glyphic Staff: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22095, ??, 40, ??, 0); -- Glyphic Staff: (D): Avatar: Accuracy+40
-- INSERT INTO `item_latents` VALUES(22095, ??, 40, ??, 0); -- Glyphic Staff: (D): Avatar: Ranged Accuracy+40
-- INSERT INTO `item_latents` VALUES(22095, ??, 40, ??, 0); -- Glyphic Staff: (D): Avatar: Magic Accuracy+40
-- INSERT INTO `item_latents` VALUES(22097, 25, 10, ??, 0); -- Argute Staff: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22097, 30, 10, ??, 0); -- Argute Staff: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22098, 25, 10, ??, 0); -- Pedagogy Staff: (D): Accuracy+10
-- INSERT INTO `item_latents` VALUES(22098, 30, 10, ??, 0); -- Pedagogy Staff: (D): Magic Accuracy+10
INSERT INTO `item_latents` VALUES(22118, 24, 35, 13, 198);  -- Venery Bow: Minuet: Ranged Attack+35
INSERT INTO `item_latents` VALUES(22118, 174, 5, 13, 198);  -- Venery Bow: Minuet: "Skillchain Bonus"+5
INSERT INTO `item_latents` VALUES(22118, 944, 5, 13, 198);  -- Venery Bow: Minuet: "Conserve TP"+5
-- INSERT INTO `item_latents` VALUES(22120, 24, ??, ??, 0); -- Imati: Unity Ranking: Ranged Attack+20~30
-- INSERT INTO `item_latents` VALUES(22121, 24, ??, ??, 0); -- Imati +1: Unity Ranking: Ranged Attack+20~30
-- INSERT INTO `item_latents` VALUES(22143, ??, 500, ??, ??); -- Fomalhaut: "TP Bonus"+500 (only applied to Marksmanship weapon skills)
-- INSERT INTO `item_latents` VALUES(22147, 26, 10, ??, 0); -- Scout's Crossbow: (D): Ranged Accuracy+10
-- INSERT INTO `item_latents` VALUES(22147, 30, 10, ??, 0); -- Scout's Crossbow: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22148, 26, 10, ??, 0); -- Arke Crossbow: (D): Ranged Accuracy+10
-- INSERT INTO `item_latents` VALUES(22148, 30, 10, ??, 0); -- Arke Crossbow: (D): Magic Accuracy+10
-- INSERT INTO `item_latents` VALUES(22254, 8, ??, ??, 0);  -- Seething Bomblet: Unity ranking: STR+1～5
-- INSERT INTO `item_latents` VALUES(22255, 8, ??, ??, 0);  -- Seething Bomblet +1: Unity ranking: STR+1～5
-- INSERT INTO `item_latents` VALUES(22266, 288, ??, ??, 0); -- Antitail: Unity Ranking: "Double Attack"+1~3%
-- INSERT INTO `item_latents` VALUES(22267, 288, ??, ??, 0); -- Antitail +1: Unity Ranking: "Double Attack"+1~3%

INSERT INTO `item_latents` VALUES(23197, 518, 10, 13, 57);  -- WAR AF2 119 +2 Hands Defender Shield Rate +10

-- -------------------------------------------------------
-- Hachiya Kyahan +2
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(23320, 169, 25, 26, 2);   -- Dusk to dawn: Movement speed +25%

INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 1);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (FIRE)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 2);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (EARTH)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 3);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (WATER)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 4);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (WIND)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 5);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (ICE)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 6);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (THUNDER)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 7);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (LIGHT)
INSERT INTO `item_latents` VALUES(23350, 399, 17, 52, 8);   -- Pedagogy Loafers+2: Weather: Enhances Celerity and Alacrity Effect +17% (DARK)

INSERT INTO `item_latents` VALUES(23532, 518, 15, 13, 57); -- WAR AF2 119 +3 Hands Defender Shield Rate +15
-- -------------------------------------------------------
-- Hachiya Kyahan +3
-- -------------------------------------------------------
INSERT INTO `item_latents` VALUES(23655, 169, 25, 26, 2);   -- Dusk to dawn: Movement speed +25%

INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 1);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (FIRE)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 2);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (EARTH)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 3);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (WATER)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 4);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (WIND)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 5);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (ICE)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 6);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (THUNDER)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 7);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (LIGHT)
INSERT INTO `item_latents` VALUES(23685, 399, 18, 52, 8);   -- Pedagogy Loafers+3: Weather: Enhances Celerity and Alacrity Effect +18% (DARK)
INSERT INTO `item_latents` VALUES(27342, 63, 10, 13, 64);   -- Fallen's Sollerets, "Last Resort"+1
INSERT INTO `item_latents` VALUES(27343, 63, 10, 13, 64);   -- Fallen's Sollerets +1, "Last Resort"+1
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 1);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (FIRE)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 2);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (EARTH)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 3);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (WATER)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 4);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (WIND)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 5);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (ICE)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 6);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (THUNDER)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 7);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (LIGHT)
INSERT INTO `item_latents` VALUES(27366, 399, 15, 52, 8);   -- Pedagogy Loafers: Weather: Enhances Celerity and Alacrity Effect +15% (DARK)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 1);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (FIRE)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 2);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (EARTH)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 3);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (WATER)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 4);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (WIND)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 5);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (ICE)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 6);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (THUNDER)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 7);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (LIGHT)
INSERT INTO `item_latents` VALUES(27367, 399, 16, 52, 8);   -- Pedagogy Loafers+1: Weather: Enhances Celerity and Alacrity Effect +16% (DARK)
INSERT INTO `item_latents` VALUES(28235, 169, 25, 26, 2);   -- Hachiya Kyahan: Dusk to dawn: Movement speed +25%
INSERT INTO `item_latents` VALUES(28256, 169, 25, 26, 2);   -- Hachiya Kyahan +1: Dusk to dawn: Movement speed +25%
