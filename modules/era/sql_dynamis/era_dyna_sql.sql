-- Variables
SET @ALWAYS = 1000;  -- Always, 100%
SET @VCOMMON = 240;  -- Very common, 24%
SET @COMMON = 150;   -- Common, 15%
SET @UNCOMMON = 100; -- Uncommon, 10%
SET @RARE = 50;      -- Rare, 5%
SET @VRARE = 10;     -- Very rare, 1%
SET @SRARE = 5;      -- Super Rare, 0.5%
SET @URARE = 1;      -- Ultra rare, 0.1%

-- --------------------------------------------------------------------
--                        Dynamis Era Module                        --
-- --------------------------------------------------------------------
LOCK TABLES `mob_droplist`       WRITE,
            `mob_spell_lists`    WRITE,
            `mob_skill_lists`    WRITE,
            `mob_skills`         WRITE,
            `mob_groups`         WRITE,
            `zone_settings`      WRITE;

-- --------------------------------------------------------------------
--                          Dynamis-Bastok                          --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--            Megaboss           --
DELETE FROM `mob_droplist` WHERE dropid = "2906"; -- Delete Droplist 2906
REPLACE INTO `mob_droplist` VALUES (2906,0,0,1000,749,@UNCOMMON); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (2906,0,0,1000,748,@UNCOMMON); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (2906,0,0,1000,1474,@COMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (2906,0,0,1000,1455,@COMMON); -- Byne Bill 1
REPLACE INTO `mob_droplist` VALUES (2906,0,0,1000,1455,@COMMON); -- Byne Bill 2
REPLACE INTO `mob_droplist` VALUES (2906,0,0,1000,1456,@COMMON); -- Hundred Byne Bill
--            Statues            --
DELETE FROM `mob_droplist` WHERE dropid = "20"; -- Delete
REPLACE INTO `mob_droplist` VALUES (20,0,0,1000,749,@RARE); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (20,0,0,1000,748,@RARE); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (20,0,0,1000,1474,@UNCOMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (20,0,0,1000,1456,@VRARE); -- Hundred Byne Bill
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "2907"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15133,91); -- MNK Feet
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15120,91); -- BLM Legs
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15106,91); -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15092,90); -- THF Body
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15078,91); -- PLD Head
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15139,91); -- DRK Feet
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15095,91); -- BST Body
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15111,91); -- BRD Hands
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15113,91); -- SAM Hands
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15130,91); -- DRG Legs
REPLACE INTO `mob_droplist` VALUES (2907,1,1,@UNCOMMON,15116,91); -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2907,1,2,@RARE,16346,500); -- BLU Legs (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2907,1,2,@RARE,11385,500); -- COR Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2907,1,3,@RARE,16362,500); -- SCH Legs (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2907,1,3,@RARE,11478,500); -- DNC Head (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1469,@VRARE); -- Wootz Ore
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1521,@VRARE); -- Slime Juice
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1455,@VCOMMON); -- Byne Bill 1
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1455,@COMMON); -- Byne Bill 2
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1455,@UNCOMMON); -- Byne Bill 3
REPLACE INTO `mob_droplist` VALUES (2907,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2907,0,0,1000,1456,@VRARE); -- 1 Hbyne
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2558"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15133,91); -- MNK Feet
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15120,91); -- BLM Legs
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15106,91); -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15092,90); -- THF Body
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15078,91); -- PLD Head
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15139,91); -- DRK Feet
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15095,91); -- BST Body
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15111,91); -- BRD Hands
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15113,91); -- SAM Hands
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15130,91); -- DRG Legs
REPLACE INTO `mob_droplist` VALUES (2558,1,1,@RARE,15116,91); -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2558,1,3,@RARE,16346,500); -- BLU Legs (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2558,1,3,@RARE,11385,500); -- COR Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2558,1,4,@RARE,16362,500); -- SCH Legs (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2558,1,4,@RARE,11478,500); -- DNC Head (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2558,0,0,1000,1469,@VRARE); -- Wootz Ore
REPLACE INTO `mob_droplist` VALUES (2558,0,0,1000,1521,@VRARE); -- Slime Juice
REPLACE INTO `mob_droplist` VALUES (2558,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2558,0,0,1000,1455,@VCOMMON); -- Byne Bill 1
REPLACE INTO `mob_droplist` VALUES (2558,0,0,1000,1455,@COMMON); -- Byne Bill 2
REPLACE INTO `mob_droplist` VALUES (2558,0,0,1000,1455,@UNCOMMON); -- Byne Bill 3
REPLACE INTO `mob_droplist` VALUES (2558,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2558,1,2,@RARE,18314,250); -- Ito
REPLACE INTO `mob_droplist` VALUES (2558,1,2,@RARE,18302,250); -- Relic Scythe
REPLACE INTO `mob_droplist` VALUES (2558,1,2,@RARE,18284,250); -- Relic Axe
REPLACE INTO `mob_droplist` VALUES (2558,1,2,@RARE,18278,250); -- Relic Blade
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 143
-- Use Spell List 0
-- --------------------------------------------------------------------
--                         Dynamis-San d`Oria                       --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "1967"; -- Delete
REPLACE INTO `mob_droplist` VALUES (1967,0,0,1000,749,@UNCOMMON); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (1967,0,0,1000,748,@UNCOMMON); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (1967,0,0,1000,1474,@COMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (1967,0,0,1000,1452,@COMMON); -- Bronzepiece 1
REPLACE INTO `mob_droplist` VALUES (1967,0,0,1000,1452,@COMMON); -- Bronzepiece 2
REPLACE INTO `mob_droplist` VALUES (1967,0,0,1000,1453,@COMMON); -- Montiont Silverpiece
--            Statues            --
DELETE FROM `mob_droplist` WHERE dropid = "2201"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2201,0,0,1000,749,@RARE); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (2201,0,0,1000,748,@RARE); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (2201,0,0,1000,1474,@UNCOMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (2201,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "3111"; -- Delete
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15132,90); -- WAR Feet
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15118,91); -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15074,91); -- WHM Head
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15136,91); -- RDM Feet
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15108,91); -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15125,91); -- BST Legs
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15081,91); -- BRD Head
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15127,91); -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15129,91); -- NIN Legs
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15145,91); -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (3111,1,1,@UNCOMMON,15146,91); -- SMN Feet
-- REPLACE INTO `mob_droplist` VALUES (3111,1,2,@RARE,15025,500); -- BLU Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3111,1,2,@RARE,16349,500); -- COR Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3111,1,3,@RARE,11388,500); -- PUP Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (3111,1,3,@RARE,15040,500); -- SCH Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1519,@VRARE); -- Fresh Orc Liver
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1517,@VRARE); -- Giant Frozen Head
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1516,@VRARE); -- Griffon Hide
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1452,@VCOMMON); -- Bronzepiece 1
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1452,@COMMON); -- Bronzepiece 2
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1452,@UNCOMMON); -- Bronzepiece 3
REPLACE INTO `mob_droplist` VALUES (3111,2,0,1000,1452,0); -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (3111,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2548"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15132,90); -- WAR Feet
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15118,91); -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15074,91); -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15136,91); -- RDM Feet
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15108,91); -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15125,91); -- BST Legs
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15081,91); -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15127,91); -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15129,91); -- NIN Legs
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15145,91); -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2548,1,1,@RARE,15146,91); -- SMN Feet
-- REPLACE INTO `mob_droplist` VALUES (2548,1,3,@RARE,15025,500); -- BLU Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2548,1,3,@RARE,16349,500); -- COR Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2548,1,4,@RARE,11388,500); -- PUP Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2548,1,4,@RARE,15040,500); -- SCH Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1519,@VRARE); -- Fresh Orc Liver
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1517,@VRARE); -- Giant Frozen Head
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1516,@VRARE); -- Griffon Hide
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1452,@VCOMMON); -- Bronzepiece 1
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1452,@COMMON); -- Bronzepiece 2
REPLACE INTO `mob_droplist` VALUES (2548,0,0,1000,1452,@UNCOMMON); -- Bronzepiece 3
REPLACE INTO `mob_droplist` VALUES (2548,2,0,1000,1452,0); -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (2548,1,2,@RARE,18308,250); -- Ihintanto
REPLACE INTO `mob_droplist` VALUES (2548,1,2,@RARE,18332,250); -- Relic Gun
REPLACE INTO `mob_droplist` VALUES (2548,1,2,@RARE,18290,250); -- Relic Bhuj
REPLACE INTO `mob_droplist` VALUES (2548,1,2,@RARE,18296,250); -- Relic Lance
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 93
-- Use Spell List 49
-- --------------------------------------------------------------------
--                         Dynamis-Windurst                         --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "2510"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2510,0,0,1000,749,@UNCOMMON); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (2510,0,0,1000,748,@UNCOMMON); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (2510,0,0,1000,1474,@COMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (2510,0,0,1000,1449,@COMMON); -- Whiteshell 1
REPLACE INTO `mob_droplist` VALUES (2510,0,0,1000,1449,@COMMON); -- Whiteshell 2
REPLACE INTO `mob_droplist` VALUES (2510,0,0,1000,1450,@COMMON); -- Jadeshell
--            Statues            --
DELETE FROM `mob_droplist` WHERE dropid = "195"; -- Delete
REPLACE INTO `mob_droplist` VALUES (195,0,0,1000,749,@RARE); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (195,0,0,1000,748,@RARE); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (195,0,0,1000,1474,@UNCOMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (195,0,0,1000,1450,@VRARE); -- Jadeshell
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "1560"; -- Delete
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15072,90); -- WAR Head
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15134,91); -- WHM Feet
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15105,91); -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15077,91); -- THF Head
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15138,91); -- PLD Feet
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15109,91); -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15080,91); -- BST Head
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15112,91); -- RNG Hands
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15128,91); -- Sam Legs
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15084,91); -- NIN Head
REPLACE INTO `mob_droplist` VALUES (1560,1,1,@UNCOMMON,15131,91); -- SMN Legs
-- REPLACE INTO `mob_droplist` VALUES (1560,1,2,@RARE,11382,500); -- BLU Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1560,1,2,@RARE,15031,500); -- PUP Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1560,1,3,@RARE,11398,500); -- SCH Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1560,1,3,@RARE,15038,500); -- DNC Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1518,@VRARE); -- colossal skull
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1466,@VRARE); -- relic iron
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1464,@VRARE); -- lancewood log
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1470,@RARE); -- sparkling stone
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1449,@VCOMMON); -- Whiteshell 1
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1449,@COMMON); -- Whiteshell 2
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1449,@UNCOMMON); -- Whiteshell 3
REPLACE INTO `mob_droplist` VALUES (1560,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (1560,0,0,1000,1450,@VRARE); -- Jadeshell
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2553"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15072,90); -- WAR Head
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15134,91); -- WHM Feet
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15105,91); -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15077,91); -- THF Head
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15138,91); -- PLD Feet
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15109,91); -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15080,91); -- BST Head
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15112,91); -- RNG Hands
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15128,91); -- Sam Legs
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15084,91); -- NIN Head
REPLACE INTO `mob_droplist` VALUES (2553,1,1,@RARE,15131,91); -- SMN Legs
-- REPLACE INTO `mob_droplist` VALUES (2553,1,3,@RARE,11382,500); -- BLU Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2553,1,3,@RARE,15031,500); -- PUP Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2553,1,4,@RARE,11398,500); -- SCH Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2553,1,4,@RARE,15038,500); -- DNC Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1518,@VRARE); -- Colossal Skull
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1466,@VRARE); -- Relic Iron
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1464,@VRARE); -- Lancewood Log
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1449,@VCOMMON); -- Whiteshell 1
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1449,@COMMON); -- Whiteshell 2
REPLACE INTO `mob_droplist` VALUES (2553,0,0,1000,1449,@UNCOMMON); -- Whiteshell 3
REPLACE INTO `mob_droplist` VALUES (2553,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2553,1,2,@RARE,18266,250); -- Relic Dagger
REPLACE INTO `mob_droplist` VALUES (2553,1,2,@RARE,18260,250); -- Relic Knuckles
REPLACE INTO `mob_droplist` VALUES (2553,1,2,@RARE,18320,250); -- Relic Maul
REPLACE INTO `mob_droplist` VALUES (2553,1,2,@RARE,18272,250); -- Relic Sword
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 95
-- Use Spell List 50
-- --------------------------------------------------------------------
--                          Dynamis-Jeuno                           --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "1085"; -- Delete
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,749,@UNCOMMON); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,748,@UNCOMMON); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1474,@COMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1455,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1456,@UNCOMMON); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1450,@UNCOMMON); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1085,0,0,1000,1453,@UNCOMMON); -- Montiont Silverpiece
--            Statues            --
DELETE FROM `mob_droplist` WHERE dropid = "1144"; -- Delete
REPLACE INTO `mob_droplist` VALUES (1144,0,0,1000,749,@RARE); -- Mythril Beastcoin
REPLACE INTO `mob_droplist` VALUES (1144,0,0,1000,748,@RARE); -- Gold Beastcoin
REPLACE INTO `mob_droplist` VALUES (1144,0,0,1000,1474,@UNCOMMON); -- Infinity Core
REPLACE INTO `mob_droplist` VALUES (1144,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (1144,1,1,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1144,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1144,1,1,@VRARE,1453,334); -- Montinont Silverpiece
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "143"; -- Delete
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15102,90); -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15103,91); -- MNK Hands
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15119,91); -- WHM Legs
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15135,91); -- BLM Feet
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15121,91); -- RDM Legs
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15137,91); -- THF Feet
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15124,91); -- DRK Legs
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15141,91); -- BRD Feet
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15082,91); -- RNG Head
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15143,91); -- SAM Feet
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15144,91); -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (143,1,1,@UNCOMMON,15115,91); -- DRG Hands
-- REPLACE INTO `mob_droplist` VALUES (143,1,3,@RARE,15028,500); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (143,1,3,@RARE,16352,500); -- PUP Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (143,1,4,10,16352,1000); -- DNC Feet (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (143,0,0,1000,1520,@VRARE); -- Goblin Grease
REPLACE INTO `mob_droplist` VALUES (143,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (143,1,2,@COMMON,1455,334);   -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (143,1,2,@COMMON,1449,333);   -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (143,1,2,@COMMON,1452,333);   -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (143,1,3,@UNCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (143,1,3,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (143,1,3,@UNCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (143,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (143,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (143,2,0,1000,1452,0); -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (143,1,4,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (143,1,4,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (143,1,4,@VRARE,1453,334); -- Montiont Silverpiece
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2543"; -- Delete
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15102,90); -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15103,91); -- MNK Hands
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15119,91); -- WHM Legs
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15135,91); -- BLM Feet
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15121,91); -- RDM Legs
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15137,91); -- THF Feet
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15124,91); -- DRK Legs
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15141,91); -- BRD Feet
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15082,91); -- RNG Head
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15143,91); -- SAM Feet
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15144,91); -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2543,1,1,@RARE,15115,91); -- DRG Hands
-- REPLACE INTO `mob_droplist` VALUES (2543,1,3,10,15028,500); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2543,1,3,10,16352,500); -- PUP Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2543,1,4,5,16352,1000); -- DNC Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2543,0,0,1000,1520,@VRARE); -- Goblin Grease
REPLACE INTO `mob_droplist` VALUES (2543,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2543,1,2,@VCOMMON,1455,334);  -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2543,1,2,@VCOMMON,1449,333);  -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2543,1,2,@VCOMMON,1452,333);  -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2543,1,3,@COMMON,1455,334);   -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2543,1,3,@COMMON,1449,333);   -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2543,1,3,@COMMON,1452,333);   -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2543,1,4,@UNCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2543,1,4,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2543,1,4,@UNCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2543,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2543,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2543,2,0,1000,1452,0); -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (2543,1,5,@RARE,18344,250); -- Relic Bow
REPLACE INTO `mob_droplist` VALUES (2543,1,5,@RARE,18338,250); -- Relic Horn
REPLACE INTO `mob_droplist` VALUES (2543,1,5,@RARE,18326,250); -- Relic Staff
REPLACE INTO `mob_droplist` VALUES (2543,1,5,@RARE,15066,250); -- Relic Shield
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 92
-- Use Spell List 47
-- --------------------------------------------------------------------
--                         Dynamis-Beaucedine                       --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
-- Use Drop ID 0
--             Eyes              --
DELETE FROM `mob_droplist` WHERE dropid = "3207"; -- Angra Mainyu
REPLACE INTO `mob_droplist` VALUES (3207,1,1,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (3207,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (3207,1,1,@VRARE,1453,334); -- Montinont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "2561"; -- Eyes
REPLACE INTO `mob_droplist` VALUES (2561,1,1,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2561,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2561,1,1,@VRARE,1453,334); -- Montinont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "6000"; -- Vanguard Eyes
REPLACE INTO `mob_droplist` VALUES (6000,1,1,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (6000,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (6000,1,1,@VRARE,1453,334); -- Montinont Silverpiece
REPLACE INTO `mob_droplist` VALUES (6000,0,0,1000,4248,@UNCOMMON); -- Ginurva's Battle Theory
DELETE FROM `mob_droplist` WHERE dropid = "6001"; -- Orc Statues
REPLACE INTO `mob_droplist` VALUES (6001,0,0,1000,1453,@VRARE); -- Montinont Silverpiece
REPLACE INTO `mob_droplist` VALUES (6001,0,0,1000,4248,@UNCOMMON); -- Ginurva's Battle Theory
DELETE FROM `mob_droplist` WHERE dropid = "6002"; -- Quadav Statues
REPLACE INTO `mob_droplist` VALUES (6002,0,0,1000,1456,@VRARE); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (6002,0,0,1000,4248,@UNCOMMON); -- Ginurva's Battle Theory
DELETE FROM `mob_droplist` WHERE dropid = "6003"; -- Yagudo Statues
REPLACE INTO `mob_droplist` VALUES (6003,0,0,1000,1450,@VRARE); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (6003,0,0,1000,4248,@UNCOMMON); -- Ginurva's Battle Theory
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "176"; -- Goblin NM
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (176,1,1,@UNCOMMON,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (176,1,3,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (176,1,3,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (176,1,3,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (176,1,4,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (176,1,4,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (176,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (176,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (176,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (176,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (176,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (176,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (176,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (176,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (176,2,0,1000,1452,0); -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (176,1,2,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (176,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (176,1,2,@VRARE,1453,334); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "493"; -- Orc NM
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (493,1,1,@UNCOMMON,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (493,1,2,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (493,1,2,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (493,1,2,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (493,1,3,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (493,1,3,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (493,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (493,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (493,2,0,1000,1452,0);   -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (493,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "261"; -- Quadav NM
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (261,1,1,@UNCOMMON,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (261,1,2,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (261,1,2,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (261,1,2,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (261,1,3,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (261,1,3,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (261,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (261,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (261,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (261,0,0,1000,1456,@VRARE); -- Hundred Byne
DELETE FROM `mob_droplist` WHERE dropid = "265"; -- Yagudo NM
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (265,1,1,@UNCOMMON,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (265,1,2,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (265,1,2,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (265,1,2,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (265,1,3,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (265,1,3,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (265,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (265,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (265,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (265,0,0,1000,1450,@VRARE); -- Jadeshell
DELETE FROM `mob_droplist` WHERE dropid = "559"; -- Dagourmarche
REPLACE INTO `mob_droplist` VALUES (559,1,1,@ALWAYS,1560,333); -- Attestation of Bravery
REPLACE INTO `mob_droplist` VALUES (559,1,1,@ALWAYS,1563,333); -- Attestation of Fortitude
REPLACE INTO `mob_droplist` VALUES (559,1,1,@ALWAYS,1567,334); -- Attestation of Virtue
REPLACE INTO `mob_droplist` VALUES (559,1,2,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (559,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (559,1,2,@VRARE,1453,334); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "1211"; -- Goublefaupe
REPLACE INTO `mob_droplist` VALUES (1211,0,0,1000,1821,@COMMON); -- Attestation of Invulnerability
REPLACE INTO `mob_droplist` VALUES (1211,1,1,@ALWAYS,1559,333); -- Attestation of Righteousness
REPLACE INTO `mob_droplist` VALUES (1211,1,1,@ALWAYS,1558,333); -- Attestation of Glorys
REPLACE INTO `mob_droplist` VALUES (1211,1,1,@ALWAYS,1561,334); -- Attestation of Force
REPLACE INTO `mob_droplist` VALUES (1211,1,2,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1211,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1211,1,2,@VRARE,1453,334); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "1672"; -- Mildaunegeux
REPLACE INTO `mob_droplist` VALUES (1672,1,1,@ALWAYS,1570,333); -- Attestation of Accuracy
REPLACE INTO `mob_droplist` VALUES (1672,1,1,@ALWAYS,1564,333); -- Attestation of Legerity
REPLACE INTO `mob_droplist` VALUES (1672,1,1,@ALWAYS,1556,334); -- Attestation of Might
REPLACE INTO `mob_droplist` VALUES (1672,1,2,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1672,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1672,1,2,@VRARE,1453,334); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "2066"; -- Quiebitiel
REPLACE INTO `mob_droplist` VALUES (2066,1,1,@ALWAYS,1557,333); -- Attestation of Celerity
REPLACE INTO `mob_droplist` VALUES (2066,1,1,@ALWAYS,1566,333); -- Attestation of Sacrifice
REPLACE INTO `mob_droplist` VALUES (2066,1,1,@ALWAYS,1569,334); -- Attestation of Harmony
REPLACE INTO `mob_droplist` VALUES (2066,1,2,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2066,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2066,1,2,@VRARE,1453,334); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "2574"; -- Velosareon
REPLACE INTO `mob_droplist` VALUES (2574,1,1,@ALWAYS,1562,333); -- Attestation of Vigor
REPLACE INTO `mob_droplist` VALUES (2574,1,1,@ALWAYS,1565,333); -- Attestation of Decisiveness
REPLACE INTO `mob_droplist` VALUES (2574,1,1,@ALWAYS,1568,334); -- Attestation of Transcendence
REPLACE INTO `mob_droplist` VALUES (2574,1,2,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2574,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2574,1,2,@VRARE,1453,334); -- Montiont Silverpiece
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2542"; -- Goblin
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (2542,1,1,@RARE,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (2542,1,5,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2542,1,5,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2542,1,5,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2542,1,6,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2542,1,6,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2542,0,0,1000,1520,@VRARE); -- Goblin Grease
REPLACE INTO `mob_droplist` VALUES (2542,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2542,1,2,@VCOMMON,1455,334);  -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2542,1,2,@VCOMMON,1449,333);  -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2542,1,2,@VCOMMON,1452,333);  -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2542,1,3,@COMMON,1455,334);   -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2542,1,3,@COMMON,1449,333);   -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2542,1,3,@COMMON,1452,333);   -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2542,1,4,@UNCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2542,1,4,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2542,1,4,@UNCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2542,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2542,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2542,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2547"; -- Orc
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15090,66); -- BLM Bodys
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (2547,1,1,@RARE,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (2547,1,2,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2547,1,2,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2547,1,2,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2547,1,3,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2547,1,3,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1519,@VRARE); -- Fresh Orc Liver
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1517,@VRARE); -- Giant Frozen Head
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1516,@VRARE); -- Griffon Hide
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1452,@VCOMMON);  -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1452,@COMMON);   -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2547,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2547,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2557"; -- Quadav
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (2557,1,1,@RARE,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (2557,1,2,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2557,1,2,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2557,1,2,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2557,1,3,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2557,1,3,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2557,0,0,1000,1469,@VRARE); -- Wootz Ore
REPLACE INTO `mob_droplist` VALUES (2557,0,0,1000,1521,@VRARE); -- Slime Juice
REPLACE INTO `mob_droplist` VALUES (2557,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2557,0,0,1000,1455,@VCOMMON);  -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2557,0,0,1000,1455,@COMMON);   -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2557,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2557,2,0,1000,1455,0); -- Byne Bill (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2552"; -- Yagudo
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (2552,1,1,@RARE,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (2552,1,2,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2552,1,2,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2552,1,2,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2552,1,3,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2552,1,3,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1518,@VRARE); -- Colossal Skull
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1466,@VRARE); -- Relic Iron
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1464,@VRARE); -- Lancewood Log
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1449,@VCOMMON);  -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1449,@COMMON);   -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2552,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2552,2,0,1000,1449,0); -- Whiteshell (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "3220"; -- Hydra
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15117,66); -- WAR Legs
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15088,66); -- MNK Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15089,66); -- WHM Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15090,66); -- BLM Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15091,66); -- RDM Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15122,67); -- THF Legs
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15123,67); -- PLD Legs
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15094,67); -- DRK Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15140,67); -- BST Feet
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15096,67); -- BRD Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15142,67); -- RNG Feet
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15098,67); -- SAM Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15099,67); -- NIN Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15100,67); -- DRG Body
REPLACE INTO `mob_droplist` VALUES (3220,1,1,@RARE,15101,67); -- SMN Body
-- REPLACE INTO `mob_droplist` VALUES (3220,1,5,@RARE,11295,333); -- COR Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3220,1,5,@RARE,11292,333); -- BLU Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3220,1,5,@RARE,11298,334); -- PUP Body (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3220,1,6,@RARE,11307,500); -- SCH Body (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (3220,1,6,@RARE,16360,500); -- DNC Legs (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (3220,0,0,1000,1520,@VRARE); -- Goblin Grease
REPLACE INTO `mob_droplist` VALUES (3220,0,0,1000,1470,@RARE); -- Sparkling Stone
REPLACE INTO `mob_droplist` VALUES (3220,1,2,@VCOMMON,1455,334);  -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (3220,1,2,@VCOMMON,1449,333);  -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (3220,1,2,@VCOMMON,1452,333);  -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (3220,1,3,@COMMON,1455,334);   -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (3220,1,3,@COMMON,1449,333);   -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (3220,1,3,@COMMON,1452,333);   -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (3220,1,4,@UNCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (3220,1,4,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (3220,1,4,@UNCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (3220,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (3220,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (3220,2,0,1000,1452,0); -- Bronzepiece (Steal)
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 4
-- Use Spell List 500
-- --------------------------------------------------------------------
--                          Dynamis-Xarcabard                       --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "730"; -- Dynamis Lord
REPLACE INTO `mob_droplist` VALUES (730,0,0,1000,13658,@COMMON); -- Shadow Mantle
REPLACE INTO `mob_droplist` VALUES (730,0,0,1000,14646,@UNCOMMON); -- Shadow Ring
REPLACE INTO `mob_droplist` VALUES (730,1,1,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (730,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (730,1,1,@VRARE,1453,334); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (730,0,0,1000,4249,@VCOMMON); -- Schultz's Strategems
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "521"; -- Count Zaebos
REPLACE INTO `mob_droplist` VALUES (521,0,0,1000,15087,@UNCOMMON); -- WAR Body
REPLACE INTO `mob_droplist` VALUES (521,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (521,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (521,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (521,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "714"; -- Duke Berith
REPLACE INTO `mob_droplist` VALUES (714,0,0,1000,15076,@UNCOMMON); -- RDM Head
REPLACE INTO `mob_droplist` VALUES (714,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (714,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (714,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (714,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1626"; -- Marquis Decarabia
REPLACE INTO `mob_droplist` VALUES (1626,0,0,1000,15126,@UNCOMMON); -- BRD Legs
REPLACE INTO `mob_droplist` VALUES (1626,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1626,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1626,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1626,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "715"; -- Duke Gomory
REPLACE INTO `mob_droplist` VALUES (715,0,0,1000,15073,@UNCOMMON); -- MNK Head
REPLACE INTO `mob_droplist` VALUES (715,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (715,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (715,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (715,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1624"; -- Marquis Andras
REPLACE INTO `mob_droplist` VALUES (1624,0,0,1000,15110,@UNCOMMON); -- BST Hands
REPLACE INTO `mob_droplist` VALUES (1624,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1624,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1624,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1624,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "2021"; -- Prince Seere
REPLACE INTO `mob_droplist` VALUES (2021,0,0,1000,15104,@UNCOMMON); -- WHM Hands
REPLACE INTO `mob_droplist` VALUES (2021,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2021,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2021,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (2021,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "717"; -- Duke Scox
REPLACE INTO `mob_droplist` VALUES (717,0,0,1000,15079,@UNCOMMON); -- DRK Head
REPLACE INTO `mob_droplist` VALUES (717,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (717,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (717,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (717,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1628"; -- Marquis Gamygyn
REPLACE INTO `mob_droplist` VALUES (1628,0,0,1000,15114,@UNCOMMON); -- NIN Hands
REPLACE INTO `mob_droplist` VALUES (1628,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1628,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1628,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1628,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1630"; -- Marquis Orias
REPLACE INTO `mob_droplist` VALUES (1630,0,0,1000,15075,@UNCOMMON); -- BLM Head
REPLACE INTO `mob_droplist` VALUES (1630,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1630,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1630,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1630,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "519"; -- Count Raum
REPLACE INTO `mob_droplist` VALUES (519,0,0,1000,15107,@UNCOMMON); -- THF Hands
REPLACE INTO `mob_droplist` VALUES (519,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (519,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (519,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (519,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1629"; -- Marquis Nebiros
REPLACE INTO `mob_droplist` VALUES (1629,0,0,1000,15086,@UNCOMMON); -- SMN Head
REPLACE INTO `mob_droplist` VALUES (1629,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1629,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1629,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1629,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1631"; -- Marquis Sabnak
REPLACE INTO `mob_droplist` VALUES (1631,0,0,1000,15093,@UNCOMMON); -- PLD Body
REPLACE INTO `mob_droplist` VALUES (1631,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1631,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1631,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1631,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "520"; -- Count Vine
REPLACE INTO `mob_droplist` VALUES (520,0,0,1000,15083,@UNCOMMON); -- SAM Head
REPLACE INTO `mob_droplist` VALUES (520,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (520,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (520,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (520,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1452"; -- King Zagan
REPLACE INTO `mob_droplist` VALUES (1452,0,0,1000,15085,@UNCOMMON); -- DRG Head
REPLACE INTO `mob_droplist` VALUES (1452,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1452,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1452,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1452,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "1625"; -- Marquis Cimeries
REPLACE INTO `mob_droplist` VALUES (1625,0,0,1000,15097,@UNCOMMON); -- RNG Body
REPLACE INTO `mob_droplist` VALUES (1625,1,1,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (1625,1,1,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (1625,1,1,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (1625,0,0,1000,4249,@ALWAYS); -- Schultz's Strategems
DELETE FROM `mob_droplist` WHERE dropid = "99"; -- Animated Hammer
REPLACE INTO `mob_droplist` VALUES (99,0,0,1000,1581,@ALWAYS); -- Heavenly Fragment
DELETE FROM `mob_droplist` WHERE dropid = "108"; -- Animated Staff
REPLACE INTO `mob_droplist` VALUES (108,0,0,1000,1582,@ALWAYS); -- Celestial Fragment
DELETE FROM `mob_droplist` WHERE dropid = "104"; -- Animated Longsword
REPLACE INTO `mob_droplist` VALUES (104,0,0,1000,1573,@ALWAYS); -- Holy Fragment
DELETE FROM `mob_droplist` WHERE dropid = "109"; -- Animated Tabar
REPLACE INTO `mob_droplist` VALUES (109,0,0,1000,1575,@ALWAYS); -- Runaeic Fragment
DELETE FROM `mob_droplist` WHERE dropid = "97"; -- Animated Great Axe
REPLACE INTO `mob_droplist` VALUES (97,0,0,1000,1576,@ALWAYS); -- Seraphic Fragment
DELETE FROM `mob_droplist` WHERE dropid = "95"; -- Animated Claymore
REPLACE INTO `mob_droplist` VALUES (97,0,0,1000,1574,@ALWAYS); -- Intricate Fragment
DELETE FROM `mob_droplist` WHERE dropid = "107"; -- Animated Spear
REPLACE INTO `mob_droplist` VALUES (107,0,0,1000,1578,@ALWAYS); -- Stellar Fragment
DELETE FROM `mob_droplist` WHERE dropid = "105"; -- Animated Scythe
REPLACE INTO `mob_droplist` VALUES (105,0,0,1000,1577,@ALWAYS); -- Tenebrous Fragment
DELETE FROM `mob_droplist` WHERE dropid = "102"; -- Animated Kunai
REPLACE INTO `mob_droplist` VALUES (102,0,0,1000,1579,@ALWAYS); -- Demoniac Fragment
DELETE FROM `mob_droplist` WHERE dropid = "110"; -- Animated Tachi
REPLACE INTO `mob_droplist` VALUES (110,0,0,1000,1580,@ALWAYS); -- Divine Fragment
DELETE FROM `mob_droplist` WHERE dropid = "96"; -- Animated Dagger
REPLACE INTO `mob_droplist` VALUES (96,0,0,1000,1572,@ALWAYS); -- Ornate Fragment
DELETE FROM `mob_droplist` WHERE dropid = "101"; -- Animated Knuckles
REPLACE INTO `mob_droplist` VALUES (101,0,0,1000,1571,@ALWAYS); -- Mystic Fragment
DELETE FROM `mob_droplist` WHERE dropid = "103"; -- Animated Longbow
REPLACE INTO `mob_droplist` VALUES (103,0,0,1000,1583,@ALWAYS); -- Snarled Fragment
DELETE FROM `mob_droplist` WHERE dropid = "98"; -- Animated Gun
REPLACE INTO `mob_droplist` VALUES (98,0,0,1000,1585,@ALWAYS); -- Ethereal Fragment
DELETE FROM `mob_droplist` WHERE dropid = "100"; -- Animated Horn
REPLACE INTO `mob_droplist` VALUES (100,0,0,1000,1584,@ALWAYS); -- Mysterial Fragment
DELETE FROM `mob_droplist` WHERE dropid = "106"; -- Animated Shield
REPLACE INTO `mob_droplist` VALUES (106,0,0,1000,1822,@ALWAYS); -- Supernal Fragment
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "1442"; -- Kindred
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15087,66); -- WAR Body
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15073,66); -- MNK Head
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15104,66); -- WHM Hands
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15075,66); -- BLM Head
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15076,66); -- RDM Head
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15107,67); -- THF Hands
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15093,67); -- PLD Body
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15079,67); -- DRK Head
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15110,67); -- BST Hands
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15126,67); -- BRD Legs
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15097,67); -- RNG Body
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15083,67); -- SAM Head
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15114,67); -- NIN Hands
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15085,67); -- DRG Head
REPLACE INTO `mob_droplist` VALUES (1442,1,1,@RARE,15086,67); -- SMN Head
-- REPLACE INTO `mob_droplist` VALUES (1442,1,5,@RARE,11468,333); -- COR Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1442,1,5,@RARE,11465,333); -- BLU Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1442,1,5,@RARE,11471,334); -- PUP Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1442,1,6,@RARE,11480,500); -- SCH Head (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1442,1,6,@RARE,11305,500); -- DNC Body (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1442,1,2,@VCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1442,1,2,@VCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1442,1,2,@VCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1442,1,3,@COMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1442,1,3,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1442,1,3,@COMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1442,1,4,@UNCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1442,1,4,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1442,1,4,@UNCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1442,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (1442,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (1442,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2559"; -- Vanguard Dragon
REPLACE INTO `mob_droplist` VALUES (2559,1,1,@VCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2559,1,1,@VCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2559,1,1,@VCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2559,1,2,@VRARE,1456,334); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2559,1,2,@VRARE,1450,333); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2559,1,2,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (2559,0,0,1000,1589,@COMMON); -- Necropsyche
REPLACE INTO `mob_droplist` VALUES (2559,0,0,1000,1452,@ALWAYS); -- Strategems
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 361
-- Use Spell List 86
--           Dwagons             --
-- Use Skill List 87
-- --------------------------------------------------------------------
--                            Dynamis-Valkurm                        --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "472"; -- Cirrate Christelle
REPLACE INTO `mob_droplist` VALUES (472,0,0,1000,1456,@VRARE); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (472,0,0,1000,1450,@VRARE); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (472,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "2910"; -- NMs
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2033,66);  -- WAR -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2038,66);  -- MNK -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2043,66);  -- WHM -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2048,66);  -- BLM -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2053,66);  -- RDM -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2058,67);  -- THF -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2063,67);  -- PLD -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2068,67);  -- DRK -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2073,67);  -- BST -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2078,67);  -- BRD -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2083,67);  -- RNG -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2088,67);  -- SAM -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2093,67);  -- NIN -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2098,67);  -- DRG -1 Head
REPLACE INTO `mob_droplist` VALUES (2910,1,1,@UNCOMMON,2103,67);  -- SMN -1 Head
-- REPLACE INTO `mob_droplist` VALUES (2910,1,3,@UNCOMMON,2662,333); -- BLU -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2910,1,3,@UNCOMMON,2667,333); -- COR -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2910,1,3,@UNCOMMON,2672,334); -- PUP -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2910,1,4,@UNCOMMON,2718,500); -- DNC -1 Head (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2910,1,4,@UNCOMMON,2723,500); -- SCH -1 Head (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2910,1,2,@COMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2910,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2910,1,2,@COMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2910,1,3,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2910,1,3,@VRARE,1450,334); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2910,1,3,@VRARE,1453,333); -- Montiont Silverpiece
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2539"; -- Goblin
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15132,66);  -- WAR Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15133,66);  -- MNK Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15134,66);  -- WHM Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15135,66);  -- BLM Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15136,66);  -- RDM Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15077,67);  -- THF Head
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15138,67);  -- PLD Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15139,67);  -- DRK Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15080,67);  -- BST Head
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15141,67);  -- BRD Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15112,67);  -- RNG Hands
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15143,67);  -- SAM Feet
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15129,67);  -- NIN Legs
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15130,67);  -- DRG Legs
REPLACE INTO `mob_droplist` VALUES (2539,1,1,@RARE,15131,67);  -- SMN Legs
-- REPLACE INTO `mob_droplist` VALUES (2539,1,4,@RARE,11382,333); -- BLU Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2539,1,4,@RARE,16349,333); -- COR Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2539,1,4,@RARE,16352,334); -- PUP Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2539,1,5,@RARE,15038,500); -- DNC Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2539,1,5,@RARE,15040,500); -- SCH Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2539,1,2,@COMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2539,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2539,1,2,@COMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2539,1,3,@UNCOMMON,1455,334); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2539,1,3,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2539,1,3,@UNCOMMON,1452,333); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2539,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2539,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2539,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2544"; -- Orc
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15132,66);  -- WAR Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15133,66);  -- MNK Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15134,66);  -- WHM Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15135,66);  -- BLM Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15136,66);  -- RDM Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15077,67);  -- THF Head
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15138,67);  -- PLD Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15139,67);  -- DRK Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15080,67);  -- BST Head
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15141,67);  -- BRD Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15112,67);  -- RNG Hands
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15143,67);  -- SAM Feet
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15129,67);  -- NIN Legs
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15130,67);  -- DRG Legs
REPLACE INTO `mob_droplist` VALUES (2544,1,1,@RARE,15131,67);  -- SMN Legs
-- REPLACE INTO `mob_droplist` VALUES (2544,1,2,@RARE,11382,333); -- BLU Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2544,1,2,@RARE,16349,333); -- COR Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2544,1,2,@RARE,16352,334); -- PUP Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2544,1,3,@RARE,15038,500); -- DNC Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2544,1,3,@RARE,15040,500); -- SCH Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2544,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2544,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2544,2,0,1000,1452,0); -- Bronzepiece
DELETE FROM `mob_droplist` WHERE dropid = "2554"; -- Quadav
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15132,66);  -- WAR Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15133,66);  -- MNK Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15134,66);  -- WHM Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15135,66);  -- BLM Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15136,66);  -- RDM Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15077,67);  -- THF Head
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15138,67);  -- PLD Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15139,67);  -- DRK Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15080,67);  -- BST Head
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15141,67);  -- BRD Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15112,67);  -- RNG Hands
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15143,67);  -- SAM Feet
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15129,67);  -- NIN Legs
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15130,67);  -- DRG Legs
REPLACE INTO `mob_droplist` VALUES (2554,1,1,@RARE,15131,67);  -- SMN Legs
-- REPLACE INTO `mob_droplist` VALUES (2554,1,2,@RARE,11382,333); -- BLU Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2554,1,2,@RARE,16349,333); -- COR Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2554,1,2,@RARE,16352,334); -- PUP Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2554,1,3,@RARE,15038,500); -- DNC Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2554,1,3,@RARE,15040,500); -- SCH Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2554,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2554,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2554,2,0,1000,1455,0); -- Byne Bill
DELETE FROM `mob_droplist` WHERE dropid = "2549"; -- Yagudo
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15132,66);  -- WAR Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15133,66);  -- MNK Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15134,66);  -- WHM Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15135,66);  -- BLM Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15136,66);  -- RDM Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15077,67);  -- THF Head
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15138,67);  -- PLD Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15139,67);  -- DRK Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15080,67);  -- BST Head
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15141,67);  -- BRD Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15112,67);  -- RNG Hands
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15143,67);  -- SAM Feet
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15129,67);  -- NIN Legs
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15130,67);  -- DRG Legs
REPLACE INTO `mob_droplist` VALUES (2549,1,1,@RARE,15131,67);  -- SMN Legs
-- REPLACE INTO `mob_droplist` VALUES (2549,1,2,@RARE,11382,333); -- BLU Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2549,1,2,@RARE,16349,333); -- COR Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2549,1,2,@RARE,16352,334); -- PUP Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2549,1,3,@RARE,15038,500); -- DNC Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2549,1,3,@RARE,15040,500); -- SCH Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2549,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2549,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2549,2,0,1000,1449,0); -- Whiteshell
--           Nightmare           --
DELETE FROM `mob_droplist` WHERE dropid = "1792"; -- Hippogryph / Sabotender
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2033,66);  -- WAR -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2038,66);  -- MNK -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2043,66);  -- WHM -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2048,66);  -- BLM -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2053,66);  -- RDM -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2058,67);  -- THF -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2063,67);  -- PLD -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2068,67);  -- DRK -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2073,67);  -- BST -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2078,67);  -- BRD -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2083,67);  -- RNG -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2088,67);  -- SAM -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2093,67);  -- NIN -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2098,67);  -- DRG -1 Head
REPLACE INTO `mob_droplist` VALUES (1792,1,1,@RARE,2103,67);  -- SMN -1 Head
-- REPLACE INTO `mob_droplist` VALUES (1792,1,3,@RARE,2662,333); -- BLU -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1792,1,3,@RARE,2667,333); -- COR -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1792,1,3,@RARE,2672,334); -- PUP -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1792,1,4,@RARE,2718,500); -- DNC -1 Head (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1792,1,4,@RARE,2723,500); -- SCH -1 Head (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1792,1,2,@RARE,15481,200); -- PLD Back
REPLACE INTO `mob_droplist` VALUES (1792,1,2,@RARE,15877,200); -- NIN Waist
REPLACE INTO `mob_droplist` VALUES (1792,1,2,@RARE,15482,200); -- BRD Back
REPLACE INTO `mob_droplist` VALUES (1792,1,2,@RARE,15484,200); -- SMN Back
REPLACE INTO `mob_droplist` VALUES (1792,1,2,@RARE,15871,200); -- WAR Waist
-- REPLACE INTO `mob_droplist` VALUES (1792,1,5,10,15920,1000); -- COR Waist (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1792,1,6,10,16248,1000); -- DNC Back  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1792,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1792,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1792,2,0,1000,1452,0); -- Bronzepiece
DELETE FROM `mob_droplist` WHERE dropid = "1794"; -- Sheep / Fly
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2033,66);  -- WAR -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2038,66);  -- MNK -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2043,66);  -- WHM -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2048,66);  -- BLM -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2053,66);  -- RDM -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2058,67);  -- THF -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2063,67);  -- PLD -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2068,67);  -- DRK -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2073,67);  -- BST -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2078,67);  -- BRD -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2083,67);  -- RNG -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2088,67);  -- SAM -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2093,67);  -- NIN -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2098,67);  -- DRG -1 Head
REPLACE INTO `mob_droplist` VALUES (1794,1,1,@RARE,2103,67);  -- SMN -1 Head
-- REPLACE INTO `mob_droplist` VALUES (1794,1,3,@RARE,2662,333); -- BLU -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1794,1,3,@RARE,2667,333); -- COR -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1794,1,3,@RARE,2672,334); -- PUP -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1794,1,4,@RARE,2718,500); -- DNC -1 Head (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1794,1,4,@RARE,2723,500); -- SCH -1 Head (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1794,1,2,@RARE,15480,125); -- THF Back
REPLACE INTO `mob_droplist` VALUES (1794,1,2,@RARE,15879,125); -- SAM Waist
REPLACE INTO `mob_droplist` VALUES (1794,1,2,@RARE,15872,125); -- WHM Waist
REPLACE INTO `mob_droplist` VALUES (1794,1,2,@RARE,15874,125); -- BLM Waist
REPLACE INTO `mob_droplist` VALUES (1794,1,2,@RARE,15482,125); -- BRD Back
REPLACE INTO `mob_droplist` VALUES (1794,1,2,@RARE,15875,125); -- BST Waist
-- REPLACE INTO `mob_droplist` VALUES (1794,1,5,10,16244,1000); -- BLU Back (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1794,1,6,10,16248,1000); -- DNC Back (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1794,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1794,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1794,2,0,1000,1455,0); -- Byne Bill
DELETE FROM `mob_droplist` WHERE dropid = "1799"; -- Manticore
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2033,66);  -- WAR -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2038,66);  -- MNK -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2043,66);  -- WHM -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2048,66);  -- BLM -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2053,66);  -- RDM -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2058,67);  -- THF -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2063,67);  -- PLD -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2068,67);  -- DRK -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2073,67);  -- BST -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2078,67);  -- BRD -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2083,67);  -- RNG -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2088,67);  -- SAM -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2093,67);  -- NIN -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2098,67);  -- DRG -1 Head
REPLACE INTO `mob_droplist` VALUES (1799,1,1,@RARE,2103,67);  -- SMN -1 Head
-- REPLACE INTO `mob_droplist` VALUES (1799,1,3,@RARE,2662,333); -- BLU -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1799,1,3,@RARE,2667,333); -- COR -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1799,1,3,@RARE,2672,334); -- PUP -1 Head (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1799,1,4,@RARE,2718,500); -- DNC -1 Head (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1799,1,4,@RARE,2723,500); -- SCH -1 Head (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1799,1,2,@RARE,15480,125); -- THF Back
REPLACE INTO `mob_droplist` VALUES (1799,1,2,@RARE,15879,125); -- SAM Waist
REPLACE INTO `mob_droplist` VALUES (1799,1,2,@RARE,15872,125); -- WHM Waist
REPLACE INTO `mob_droplist` VALUES (1799,1,2,@RARE,15874,125); -- BLM Waist
REPLACE INTO `mob_droplist` VALUES (1799,1,2,@RARE,15482,125); -- BRD Back
REPLACE INTO `mob_droplist` VALUES (1799,1,2,@RARE,15875,125); -- BST Waist
-- REPLACE INTO `mob_droplist` VALUES (1799,1,5,10,16244,1000); -- BLU Back (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1799,1,6,10,16248,1000); -- DNC Back (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1799,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1799,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1799,2,0,1000,1449,0); -- Whiteshell
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- Use Skill List 0
--          Dragontrap            --
-- Use Skill List 114
--          Fairy Ring            --
-- Use Skill List 116
--           Nant`ina             --
-- Use Skill List 1214
REPLACE INTO `mob_skill_lists` VALUES ('Nantina',5000,1617);
REPLACE INTO `mob_skill_lists` VALUES ('Nantina',5000,1618);
REPLACE INTO `mob_skill_lists` VALUES ('Nantina',5000,1619);
--         Stcemqestcint          --
-- Use Skill List 245
-- --------------------------------------------------------------------
--                           Dynamis-Buburimu                       --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "146"; -- Apocalyptic Beast
REPLACE INTO `mob_droplist` VALUES (146,0,0,1000,1456,@VRARE); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (146,0,0,1000,1450,@VRARE); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (146,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "230"; -- NMs
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (230,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (230,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (230,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (230,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (230,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (230,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (230,1,2,@COMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (230,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (230,1,2,@COMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (230,1,3,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (230,1,3,@VRARE,1450,334); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (230,1,3,@VRARE,1453,333); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "2667"; -- Goblin NM
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2667,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2667,1,3,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2667,1,3,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2667,1,3,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2667,1,4,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2667,1,4,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2667,1,2,@COMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2667,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2667,1,2,@COMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2667,1,3,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (2667,1,3,@VRARE,1450,334); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (2667,1,3,@VRARE,1453,333); -- Montiont Silverpiece
REPLACE INTO `mob_droplist` VALUES (2667,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2667,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2667,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "760"; -- Orc NM
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (760,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (760,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (760,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (760,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (760,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (760,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (760,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (760,2,0,1000,1452,0); -- Bronzepiece (Steal)
REPLACE INTO `mob_droplist` VALUES (760,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
DELETE FROM `mob_droplist` WHERE dropid = "2901"; -- Quadav NM
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2901,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2901,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2901,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2901,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2901,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2901,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2901,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2901,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2901,0,0,1000,1456,@VRARE); -- Hundred Byne
DELETE FROM `mob_droplist` WHERE dropid = "2085"; -- Yagudo NM
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2085,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2085,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2085,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2085,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2085,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2085,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2085,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2085,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2085,0,0,1000,1450,@VRARE); -- Jadeshell
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2540"; -- Goblin
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2540,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2540,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2540,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2540,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2540,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2540,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2540,1,2,@COMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2540,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2540,1,2,@COMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2540,1,3,@UNCOMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2540,1,3,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2540,1,3,@UNCOMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2540,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2540,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2540,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2545"; -- Orc
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2545,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2545,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2545,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2545,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2545,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2545,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2545,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2545,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2545,2,0,1000,1452,0); -- Bronzepiece
DELETE FROM `mob_droplist` WHERE dropid = "2555"; -- Quadav
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2555,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2555,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2555,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2555,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2555,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2555,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2555,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2555,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2555,2,0,1000,1455,0); -- Byne Bill
DELETE FROM `mob_droplist` WHERE dropid = "2550"; -- Yagudo
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15102,66);  -- WAR Hands
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15118,66);  -- MNK Legs
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15074,66);  -- WHM Head
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15105,66);  -- BLM Hands
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15106,66);  -- RDM Hands
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15092,67);  -- THF Body
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15108,67);  -- PLD Hands
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15109,67);  -- DRK Hands
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15095,67);  -- BST Body
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15081,67);  -- BRD Head
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15127,67);  -- RNG Legs
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15128,67);  -- SAM Legs
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15144,67);  -- NIN Feet
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15145,67);  -- DRG Feet
REPLACE INTO `mob_droplist` VALUES (2550,1,1,@UNCOMMON,15116,67);  -- SMN Hands
-- REPLACE INTO `mob_droplist` VALUES (2550,1,2,@UNCOMMON,16346,200); -- BLU Legs  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2550,1,2,@UNCOMMON,15028,200); -- COR Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2550,1,2,@UNCOMMON,11388,200); -- PUP Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2550,1,3,@UNCOMMON,11478,200); -- DNC Head  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2550,1,3,@UNCOMMON,11398,200); -- SCH Feet  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2550,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2550,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2550,2,0,1000,1449,0); -- Whiteshell
--           Nightmare           --
DELETE FROM `mob_droplist` WHERE dropid = "1789"; -- Bunny/Mandragora
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1789,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1789,1,2,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1789,1,2,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1789,1,2,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1789,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1789,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1789,1,3,@RARE,15877,500); -- NIN Belt
REPLACE INTO `mob_droplist` VALUES (1789,1,3,@RARE,15482,500); -- BRD Back
-- REPLACE INTO `mob_droplist` VALUES (1789,1,5,10,16244,1000); -- BLU Back (Comment in for ToAU)
REPLACE INTO `mob_droplist` VALUES (1789,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1789,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1789,2,0,1000,1452,0); -- Bronzepiece
DELETE FROM `mob_droplist` WHERE dropid = "1805"; -- Cockatrice
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1805,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1805,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1805,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1805,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1805,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1805,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1805,1,2,@RARE,15874,500); -- BLM Waist
REPLACE INTO `mob_droplist` VALUES (1805,1,2,@RARE,15878,500); -- DRG Waist
-- REPLACE INTO `mob_droplist` VALUES (1805,1,5,@RARE,16245,1000); -- PUP Back (Comment in for ToAU)
REPLACE INTO `mob_droplist` VALUES (1805,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1805,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1805,2,0,1000,1449,0); -- Whiteshell (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "1791"; -- Crab
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1791,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1791,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1791,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1791,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1791,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1791,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1791,1,2,@RARE,15874,333); -- BLM Waist
REPLACE INTO `mob_droplist` VALUES (1791,1,2,@RARE,15481,333); -- PLD Back
REPLACE INTO `mob_droplist` VALUES (1791,1,2,@RARE,15878,334); -- DRG Waist
REPLACE INTO `mob_droplist` VALUES (1791,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1791,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1791,2,0,1000,1449,0); -- Whiteshell
DELETE FROM `mob_droplist` WHERE dropid = "1798"; -- Crawler
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1798,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1798,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1798,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1798,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1798,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1798,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1798,1,2,@RARE,15479,500); -- DRK Back
REPLACE INTO `mob_droplist` VALUES (1798,1,2,@RARE,15871,500); -- WAR Waist
REPLACE INTO `mob_droplist` VALUES (1798,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1798,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1798,2,0,1000,1455,0); -- Byne Bill (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2796"; -- Dhalmel
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (2796,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (2796,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2796,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2796,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2796,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2796,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2796,1,2,@RARE,15479,500); -- DRK Back
REPLACE INTO `mob_droplist` VALUES (2796,1,2,@RARE,15871,500); -- WAR Waist
-- REPLACE INTO `mob_droplist` VALUES (2796,1,5,10,16244,1000); -- BLU Back (Comment in for ToAU)
REPLACE INTO `mob_droplist` VALUES (2796,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2796,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2796,2,0,1000,1449,0); -- Whiteshell
DELETE FROM `mob_droplist` WHERE dropid = "2795"; -- Eft
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (2795,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (2795,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2795,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2795,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2795,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2795,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2795,1,2,@RARE,15478,500); -- MNK Back
REPLACE INTO `mob_droplist` VALUES (2795,1,2,@RARE,15481,500); -- PLD Back
REPLACE INTO `mob_droplist` VALUES (2795,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2795,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2795,2,0,1000,1452,0); -- Bronzepiece
DELETE FROM `mob_droplist` WHERE dropid = "1788"; -- Raven
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1788,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1788,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1788,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1788,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1788,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1788,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1788,1,2,@RARE,15873,500); -- RDM Waist
REPLACE INTO `mob_droplist` VALUES (1788,1,2,@RARE,15876,500); -- RNG Waist
-- REPLACE INTO `mob_droplist` VALUES (1788,1,5,10,16244,1000); -- BLU Back (Comment in for ToAU)
REPLACE INTO `mob_droplist` VALUES (1788,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1788,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1788,2,0,1000,1455,0); -- Byne Bill
DELETE FROM `mob_droplist` WHERE dropid = "1787"; -- Scorpion
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1787,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1787,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1787,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1787,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1787,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1787,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1787,1,2,@RARE,15873,500); -- RDM Waist
REPLACE INTO `mob_droplist` VALUES (1787,1,2,@RARE,15876,500); -- RNG Waist
REPLACE INTO `mob_droplist` VALUES (1787,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1787,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1787,2,0,1000,1449,0); -- Whiteshell
DELETE FROM `mob_droplist` WHERE dropid = "1785"; -- Uragnite
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2035,66);  -- WAR -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2040,66);  -- MNK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2045,66);  -- WHM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2050,66);  -- BLM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2055,66);  -- RDM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2060,67);  -- THF -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2065,67);  -- PLD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2070,67);  -- DRK -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2075,67);  -- BST -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2080,67);  -- BRD -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2085,67);  -- RNG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2090,67);  -- SAM -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2095,67);  -- NIN -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2100,67);  -- DRG -1 Hands
REPLACE INTO `mob_droplist` VALUES (1785,1,1,@UNCOMMON,2105,67);  -- SMN -1 Hands
-- REPLACE INTO `mob_droplist` VALUES (1785,1,3,@UNCOMMON,2664,333); -- BLU -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1785,1,3,@UNCOMMON,2669,333); -- COR -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1785,1,3,@UNCOMMON,2674,334); -- PUP -1 Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1785,1,4,@UNCOMMON,2720,500); -- DNC -1 Hands (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1785,1,4,@UNCOMMON,2725,500); -- SCH -1 Hands (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1785,1,2,@RARE,15478,500); -- MNK Back
REPLACE INTO `mob_droplist` VALUES (1785,1,2,@RARE,15481,500); -- PLD Back
-- REPLACE INTO `mob_droplist` VALUES (1785,1,5,10,16245,1000); -- PUP Back
REPLACE INTO `mob_droplist` VALUES (1785,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1785,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1785,2,0,1000,1455,0); -- Byne Bill (Steal)
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
REPLACE INTO `mob_skill_lists` VALUES ('Stihi',5001,642);
REPLACE INTO `mob_skill_lists` VALUES ('Vishap',5002,643);
REPLACE INTO `mob_skill_lists` VALUES ('Jurik',5003,644);
REPLACE INTO `mob_skill_lists` VALUES ('Barong',5004,645);
REPLACE INTO `mob_skill_lists` VALUES ('Tarasca',5005,646);
REPLACE INTO `mob_skill_lists` VALUES ('Alklha',5006,647);
REPLACE INTO `mob_skill_lists` VALUES ('Basillic',5007,648);
REPLACE INTO `mob_skill_lists` VALUES ('Aitvaras',5008,649);
REPLACE INTO `mob_skill_lists` VALUES ('Koschei',5009,650);
REPLACE INTO `mob_skill_lists` VALUES ('Stollenwurm',5010,651);
-- --------------------------------------------------------------------
--                            Dynamis-Qufim                         --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
DELETE FROM `mob_droplist` WHERE dropid = "112"; -- Antaeus
REPLACE INTO `mob_droplist` VALUES (112,0,0,1000,1456,@VRARE); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (112,0,0,1000,1450,@VRARE); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (112,0,0,1000,1453,@VRARE); -- Montiont Silverpiece
--              NMs              --
DELETE FROM `mob_droplist` WHERE dropid = "3131"; -- NMs
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2037,66);  -- WAR -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2042,66);  -- MNK -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2047,66);  -- WHM -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2052,66);  -- BLM -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2057,66);  -- RDM -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2062,67);  -- THF -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2067,67);  -- PLD -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2072,67);  -- DRK -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2077,67);  -- BST -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2082,67);  -- BRD -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2087,67);  -- RNG -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2092,67);  -- SAM -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2097,67);  -- NIN -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2102,67);  -- DRG -1 Feet
REPLACE INTO `mob_droplist` VALUES (3131,1,1,@UNCOMMON,2107,67);  -- SMN -1 Feet
-- REPLACE INTO `mob_droplist` VALUES (3131,1,3,@UNCOMMON,2666,333); -- BLU -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3131,1,3,@UNCOMMON,2671,333); -- COR -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3131,1,3,@UNCOMMON,2676,334); -- PUP -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (3131,1,4,@UNCOMMON,2722,500); -- DNC -1 Feet (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (3131,1,4,@UNCOMMON,2727,500); -- SCH -1 Feet (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (3131,1,2,@COMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (3131,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (3131,1,2,@COMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (3131,1,3,@VRARE,1456,333); -- Hundred Byne
REPLACE INTO `mob_droplist` VALUES (3131,1,3,@VRARE,1450,334); -- Jadeshell
REPLACE INTO `mob_droplist` VALUES (3131,1,3,@VRARE,1453,333); -- Montiont Silverpiece
--            Regular            --
DELETE FROM `mob_droplist` WHERE dropid = "2541"; -- Goblin
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15072,66);  -- WAR Head
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15103,66);  -- MNK Hands
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15119,66);  -- WHM Legs
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15120,66);  -- BLM Legs
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15121,66);  -- RDM Legs
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15137,67);  -- THF Feet
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15078,67);  -- PLD Head
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15124,67);  -- DRK Legs
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15125,67);  -- BST Legs
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15111,67);  -- BRD Hands
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15082,67);  -- RNG Head
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15113,67);  -- SAM Hands
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15084,67);  -- NIN Head
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15115,67);  -- DRG Hands
REPLACE INTO `mob_droplist` VALUES (2541,1,1,@UNCOMMON,15146,67);  -- SMN Feet
-- REPLACE INTO `mob_droplist` VALUES (2541,1,2,@UNCOMMON,15025,333); -- BLU Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2541,1,2,@UNCOMMON,11385,333); -- COR Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2541,1,2,@UNCOMMON,15031,334); -- PUP Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2541,1,3,@UNCOMMON,16352,500); -- DNC Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2541,1,3,@UNCOMMON,16362,500); -- SCH Legs  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2541,1,2,@COMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2541,1,2,@COMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2541,1,2,@COMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2541,1,3,@UNCOMMON,1455,333); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2541,1,3,@UNCOMMON,1449,333); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2541,1,3,@UNCOMMON,1452,334); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2541,2,0,1000,1455,0); -- Byne Bill (Steal)
REPLACE INTO `mob_droplist` VALUES (2541,2,0,1000,1449,0); -- Whiteshell (Steal)
REPLACE INTO `mob_droplist` VALUES (2541,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "2546"; -- Orc
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15072,66);  -- WAR Head
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15103,66);  -- MNK Hands
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15119,66);  -- WHM Legs
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15120,66);  -- BLM Legs
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15121,66);  -- RDM Legs
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15137,67);  -- THF Feet
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15078,67);  -- PLD Head
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15124,67);  -- DRK Legs
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15125,67);  -- BST Legs
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15111,67);  -- BRD Hands
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15082,67);  -- RNG Head
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15113,67);  -- SAM Hands
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15084,67);  -- NIN Head
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15115,67);  -- DRG Hands
REPLACE INTO `mob_droplist` VALUES (2546,1,1,@UNCOMMON,15146,67);  -- SMN Feet
-- REPLACE INTO `mob_droplist` VALUES (2546,1,2,@UNCOMMON,15025,333); -- BLU Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2546,1,2,@UNCOMMON,11385,333); -- COR Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2546,1,2,@UNCOMMON,15031,334); -- PUP Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2546,1,3,@UNCOMMON,16352,500); -- DNC Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2546,1,3,@UNCOMMON,16362,500); -- SCH Legs  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2546,0,0,1000,1449,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2546,0,0,1000,1449,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (2546,2,0,1000,1449,0); -- Bronzepiece
DELETE FROM `mob_droplist` WHERE dropid = "2556"; -- Quadav
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15072,66);  -- WAR Head
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15103,66);  -- MNK Hands
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15119,66);  -- WHM Legs
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15120,66);  -- BLM Legs
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15121,66);  -- RDM Legs
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15137,67);  -- THF Feet
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15078,67);  -- PLD Head
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15124,67);  -- DRK Legs
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15125,67);  -- BST Legs
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15111,67);  -- BRD Hands
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15082,67);  -- RNG Head
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15113,67);  -- SAM Hands
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15084,67);  -- NIN Head
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15115,67);  -- DRG Hands
REPLACE INTO `mob_droplist` VALUES (2556,1,1,@UNCOMMON,15146,67);  -- SMN Feet
-- REPLACE INTO `mob_droplist` VALUES (2556,1,2,@UNCOMMON,15025,333); -- BLU Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2556,1,2,@UNCOMMON,11385,333); -- COR Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2556,1,2,@UNCOMMON,15031,334); -- PUP Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2556,1,3,@UNCOMMON,16352,500); -- DNC Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2556,1,3,@UNCOMMON,16362,500); -- SCH Legs  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2556,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2556,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (2556,2,0,1000,1455,0); -- Byne Bill
DELETE FROM `mob_droplist` WHERE dropid = "2551"; -- Yagudo
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15072,66);  -- WAR Head
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15103,66);  -- MNK Hands
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15119,66);  -- WHM Legs
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15120,66);  -- BLM Legs
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15121,66);  -- RDM Legs
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15137,67);  -- THF Feet
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15078,67);  -- PLD Head
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15124,67);  -- DRK Legs
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15125,67);  -- BST Legs
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15111,67);  -- BRD Hands
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15082,67);  -- RNG Head
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15113,67);  -- SAM Hands
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15084,67);  -- NIN Head
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15115,67);  -- DRG Hands
REPLACE INTO `mob_droplist` VALUES (2551,1,1,@UNCOMMON,15146,67);  -- SMN Feet
-- REPLACE INTO `mob_droplist` VALUES (2551,1,2,@UNCOMMON,15025,333); -- BLU Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2551,1,2,@UNCOMMON,11385,333); -- COR Feet  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2551,1,2,@UNCOMMON,15031,334); -- PUP Hands (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (2551,1,3,@UNCOMMON,16352,500); -- DNC Feet  (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (2551,1,3,@UNCOMMON,16362,500); -- SCH Legs  (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (2551,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2551,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (2551,2,0,1000,1449,0); -- Whiteshell
--           Nightmare           --
DELETE FROM `mob_droplist` WHERE dropid = "1793"; -- Gaylas/Kraken/Raptor/Roc
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2037,66);  -- WAR -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2042,66);  -- MNK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2047,66);  -- WHM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2052,66);  -- BLM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2057,66);  -- RDM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2062,67);  -- THF -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2067,67);  -- PLD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2072,67);  -- DRK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2077,67);  -- BST -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2082,67);  -- BRD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2087,67);  -- RNG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2092,67);  -- SAM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2097,67);  -- NIN -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2102,67);  -- DRG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1793,1,1,@UNCOMMON,2107,67);  -- SMN -1 Feet
-- REPLACE INTO `mob_droplist` VALUES (1793,1,3,@UNCOMMON,2666,333); -- BLU -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1793,1,3,@UNCOMMON,2671,333); -- COR -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1793,1,3,@UNCOMMON,2676,334); -- PUP -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1793,1,4,@UNCOMMON,2722,500); -- DNC -1 Feet (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1793,1,4,@UNCOMMON,2727,500); -- SCH -1 Feet (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1793,1,2,@RARE,15872,200); -- WHM Waist
REPLACE INTO `mob_droplist` VALUES (1793,1,2,@RARE,15478,200); -- MNK Back
REPLACE INTO `mob_droplist` VALUES (1793,1,2,@RARE,15878,200); -- DRG Waist
REPLACE INTO `mob_droplist` VALUES (1793,1,2,@RARE,15484,200); -- SMN Back
REPLACE INTO `mob_droplist` VALUES (1793,1,2,@RARE,15875,200); -- BST Waist
-- REPLACE INTO `mob_droplist` VALUES (1793,1,5,10,16245,1000); -- PUP Back  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1793,1,6,10,15925,1000); -- SCH Waist (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1793,0,0,1000,1455,@COMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1793,0,0,1000,1455,@UNCOMMON); -- Byne Bill
REPLACE INTO `mob_droplist` VALUES (1793,2,0,1000,1455,0); -- Byne Bill (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "1803"; -- Snoll
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2037,66);  -- WAR -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2042,66);  -- MNK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2047,66);  -- WHM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2052,66);  -- BLM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2057,66);  -- RDM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2062,67);  -- THF -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2067,67);  -- PLD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2072,67);  -- DRK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2077,67);  -- BST -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2082,67);  -- BRD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2087,67);  -- RNG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2092,67);  -- SAM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2097,67);  -- NIN -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2102,67);  -- DRG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1803,1,1,@UNCOMMON,2107,67);  -- SMN -1 Feet
-- REPLACE INTO `mob_droplist` VALUES (1803,1,3,@UNCOMMON,2666,333); -- BLU -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1803,1,3,@UNCOMMON,2671,333); -- COR -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1803,1,3,@UNCOMMON,2676,334); -- PUP -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1803,1,4,@UNCOMMON,2722,500); -- DNC -1 Feet (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1803,1,4,@UNCOMMON,2727,500); -- SCH -1 Feet (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1803,1,2,@RARE,15872,143); -- WHM Waist
REPLACE INTO `mob_droplist` VALUES (1803,1,2,@RARE,15478,143); -- MNK Back
REPLACE INTO `mob_droplist` VALUES (1803,1,2,@RARE,15878,143); -- DRG Waist
REPLACE INTO `mob_droplist` VALUES (1803,1,2,@RARE,15484,143); -- SMN Back
REPLACE INTO `mob_droplist` VALUES (1803,1,2,@RARE,15875,143); -- BST Waist
-- REPLACE INTO `mob_droplist` VALUES (1803,1,5,10,16245,1000); -- PUP Back  (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1803,1,6,10,15925,1000); -- SCH Waist (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1803,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1803,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1803,2,0,1000,1452,0); -- Bronzepiece (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "1790"; -- Diremite
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2037,66);  -- WAR -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2042,66);  -- MNK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2047,66);  -- WHM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2052,66);  -- BLM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2057,66);  -- RDM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2062,67);  -- THF -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2067,67);  -- PLD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2072,67);  -- DRK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2077,67);  -- BST -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2082,67);  -- BRD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2087,67);  -- RNG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2092,67);  -- SAM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2097,67);  -- NIN -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2102,67);  -- DRG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1790,1,1,@UNCOMMON,2107,67);  -- SMN -1 Feet
-- REPLACE INTO `mob_droplist` VALUES (1790,1,3,@UNCOMMON,2666,333); -- BLU -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1790,1,3,@UNCOMMON,2671,333); -- COR -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1790,1,3,@UNCOMMON,2676,334); -- PUP -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1790,1,4,@UNCOMMON,2722,500); -- DNC -1 Feet (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1790,1,4,@UNCOMMON,2727,500); -- SCH -1 Feet (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1790,1,2,@RARE,15479,200); -- DRK Back
REPLACE INTO `mob_droplist` VALUES (1790,1,2,@RARE,15480,200); -- THF Back
REPLACE INTO `mob_droplist` VALUES (1790,1,2,@RARE,15873,200); -- RDM Waist
REPLACE INTO `mob_droplist` VALUES (1790,1,2,@RARE,15879,200); -- SAM Waist
REPLACE INTO `mob_droplist` VALUES (1790,1,2,@RARE,15876,200); -- RNG Waist
-- REPLACE INTO `mob_droplist` VALUES (1790,1,5,10,15920,1000); -- COR Waist (Comment in for ToAU)
REPLACE INTO `mob_droplist` VALUES (1790,0,0,1000,1449,@COMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1790,0,0,1000,1449,@UNCOMMON); -- Whiteshell
REPLACE INTO `mob_droplist` VALUES (1790,2,0,1000,1449,0); -- Whiteshell (Steal)
DELETE FROM `mob_droplist` WHERE dropid = "1804"; -- Stirge/Tiger/Weapon
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2037,66);  -- WAR -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2042,66);  -- MNK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2047,66);  -- WHM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2052,66);  -- BLM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2057,66);  -- RDM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2062,67);  -- THF -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2067,67);  -- PLD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2072,67);  -- DRK -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2077,67);  -- BST -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2082,67);  -- BRD -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2087,67);  -- RNG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2092,67);  -- SAM -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2097,67);  -- NIN -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2102,67);  -- DRG -1 Feet
REPLACE INTO `mob_droplist` VALUES (1804,1,1,@UNCOMMON,2107,67);  -- SMN -1 Feet
-- REPLACE INTO `mob_droplist` VALUES (1804,1,3,@UNCOMMON,2666,333); -- BLU -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1804,1,3,@UNCOMMON,2671,333); -- COR -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1804,1,3,@UNCOMMON,2676,334); -- PUP -1 Feet (Comment in for ToAU)
-- REPLACE INTO `mob_droplist` VALUES (1804,1,4,@UNCOMMON,2722,500); -- DNC -1 Feet (Comment in for WoTG)
-- REPLACE INTO `mob_droplist` VALUES (1804,1,4,@UNCOMMON,2727,500); -- SCH -1 Feet (Comment in for WoTG)
REPLACE INTO `mob_droplist` VALUES (1804,1,2,@RARE,15479,200); -- DRK Back
REPLACE INTO `mob_droplist` VALUES (1804,1,2,@RARE,15480,200); -- THF Back
REPLACE INTO `mob_droplist` VALUES (1804,1,2,@RARE,15873,200); -- RDM Waist
REPLACE INTO `mob_droplist` VALUES (1804,1,2,@RARE,15879,200); -- SAM Waist
REPLACE INTO `mob_droplist` VALUES (1804,1,2,@RARE,15876,200); -- RNG Waist
-- REPLACE INTO `mob_droplist` VALUES (1804,1,5,10,15920,1000); -- COR Waist
REPLACE INTO `mob_droplist` VALUES (1804,0,0,1000,1452,@COMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1804,0,0,1000,1452,@UNCOMMON); -- Bronzepiece
REPLACE INTO `mob_droplist` VALUES (1804,2,0,1000,1452,0); -- Bronzepiece (Steal)
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- --------------------------------------------------------------------
--                           Dynamis-Tavnazia                       --
-- --------------------------------------------------------------------
-- ---------------------------------
--           Droplists           --
-- ---------------------------------
--           Megaboss            --
--            Statues            --
--           Megaboss            --
--              NMs              --
--            Regular            --
-- ---------------------------------
--   Special Mob Skills/Spells   --
-- ---------------------------------
--           Megaboss            --
-- --------------------------------------------------------------------
--                     Beastmen Mob Skills/Spells                   --
-- --------------------------------------------------------------------
-- ---------------------------------
--            Quadav             --
-- ---------------------------------
--            Statue             --
-- Use List 94
-- Use Spell List 0
--              NMs              --
-- Use Skill List 202
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMQuadav',5011,611);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMQuadav',5011,612);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMQuadav',5011,613);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMQuadav',5011,1074);
--            Regular            --
-- Use Skill List 337
-- ---------------------------------
--              Orc              --
-- ---------------------------------
--            Statue             --
-- Use List
-- Use Spell List
--              NMs              --
-- Use Skill List 1200
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMOrc',5012,605);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMOrc',5012,606);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMOrc',5012,607);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMOrc',5012,608);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMOrc',5012,609);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMOrc',5012,1066);
--            Regular            --
-- Use Skill List 334
-- ---------------------------------
--            Goblin             --
-- ---------------------------------
--            Statue             --
-- Use List
-- Use Spell List
--              NMs              --
-- Use Skill List 373
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,590);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,591);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1082);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1084);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1086);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1099);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1100);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1101);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1102);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1103);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1104);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1105);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1106);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1107);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1108);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1109);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMGoblin',5013,1518);
--            Regular            --
-- Use Skill List 327
-- ---------------------------------
--            Yagudo             --
-- ---------------------------------
--            Statue             --
-- Use List
-- Use Spell List
--              NMs              --
-- Use Skill List 1201
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMYagudo',5014,617);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMYagudo',5014,618);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMYagudo',5014,619);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMYagudo',5014,620);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMYagudo',5014,764);
REPLACE INTO `mob_skill_lists` VALUES ('DynaNMYagudo',5014,1067);
--            Regular            --
-- Use Skill List 360
-- ---------------------------------
--             Hydra             --
-- ---------------------------------
--              NMs              --
-- Use Skill List 359
--            Regular            --
-- Use Skill List 359
-- ---------------------------------
--            Kindred            --
-- ---------------------------------
--              NMs              --
-- Use Skill List 358
--            Regular            --
-- Use Skill List 358
-- ---------------------------------
--          Mob Spells           --
-- ---------------------------------
--              NMs              --
-- WHM Use List 1
-- BLM Use List 500
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,144,13,22);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,145,38,47);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,146,62,67);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,147,73,85);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,149,17,27);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,150,42,53);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,151,64,68);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,152,74,88);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,154,9,18);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,155,34,44);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,156,59,66);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,157,72,82);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,159,1,10);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,160,26,35);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,161,51,60);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,162,68,73);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,164,21,46);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,165,46,55);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,166,66,70);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,167,75,92);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,169,5,12);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,170,30,40);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,171,55,61);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,172,70,78);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,174,28,35);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,175,53,60);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,176,69,90);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,179,32,39);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,180,57,62);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,181,71,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,184,23,31);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,185,48,56);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,186,67,71);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,189,15,22);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,190,40,47);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,191,63,67);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,194,36,43);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,195,61,65);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,196,73,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,199,19,27);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,200,44,52);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,201,65,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,204,60,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,206,50,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,208,52,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,210,54,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,212,56,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,214,58,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,220,3,17);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,221,43,64);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,225,24,71);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,226,72,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,230,10,34);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,231,35,59);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,232,60,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,235,24,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,236,22,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,237,20,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,238,18,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,239,16,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,240,27,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,245,12,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,247,25,82);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,249,10,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,252,45,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,253,20,40);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,254,4,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,258,7,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,259,41,255);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,273,31,55);
REPLACE INTO `mob_spell_lists` VALUES ('Era_Beastmen_BLM',5000,274,56,255);
-- RDM Use List 3
-- PLD Use List 4
-- DRK Use List 5
-- BRD Use List 6
-- NIN Use List 7
--          Goublefaupe         --
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,1,3,13);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,2,14,25);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,3,26,48);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,4,48,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,23,1,30);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,24,31,59);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,25,60,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,33,15,54);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,34,55,70);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,35,71,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,43,7,26);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,44,27,46);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,45,47,62);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,46,63,76);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,47,80,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,48,17,36);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,49,37,56);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,50,57,67);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,51,68,86);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,52,87,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,53,23,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,54,34,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,55,12,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,56,13,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,57,48,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,58,6,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,59,18,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,100,24,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,101,22,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,102,20,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,103,18,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,104,16,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,105,27,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,108,21,75);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,110,80,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,144,19,49);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,145,50,70);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,146,71,85);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,147,86,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,149,24,54);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,150,55,72);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,151,73,88);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,152,89,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,154,14,44);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,155,45,68);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,156,69,82);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,157,83,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,159,4,34);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,160,35,64);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,161,65,76);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,162,77,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,164,29,59);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,165,60,74);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,166,75,91);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,167,89,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,169,9,39);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,170,40,66);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,171,67,88);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,172,80,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,216,21,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,220,5,45);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,221,46,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,230,10,35);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,231,36,70);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,232,71,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,253,25,45);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,254,8,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,258,11,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,259,46,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,260,32,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,112,32,255);
REPLACE INTO `mob_spell_lists` VALUES ('Goublefaupe',5001,97,32,255);
--           Quieitiel           --
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,144,13,22);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,145,38,47);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,146,62,67);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,147,73,85);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,149,17,27);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,150,42,53);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,151,64,68);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,152,74,88);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,154,9,18);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,155,34,44);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,156,59,66);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,157,72,82);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,159,1,10);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,160,26,35);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,161,51,60);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,162,68,73);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,164,21,46);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,165,46,55);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,166,66,70);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,167,75,92);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,169,5,12);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,170,30,40);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,171,55,61);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,172,70,78);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,174,28,35);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,175,53,60);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,176,69,90);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,179,32,39);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,180,57,62);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,181,71,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,184,23,31);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,185,48,56);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,186,67,71);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,189,15,22);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,190,40,47);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,191,63,67);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,194,36,43);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,195,61,65);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,196,73,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,199,19,27);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,200,44,52);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,201,65,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,204,60,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,206,50,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,208,52,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,210,54,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,212,56,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,214,58,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,220,3,17);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,221,43,64);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,225,24,71);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,226,72,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,230,10,34);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,231,35,59);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,232,60,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,235,24,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,236,22,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,237,20,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,238,18,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,239,16,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,240,27,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,245,12,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,247,25,82);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,248,83,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,249,10,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,252,45,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,253,20,40);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,254,4,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,258,7,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,259,41,255);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,273,31,55);
REPLACE INTO `mob_spell_lists` VALUES ('Quieitiel',5002,274,56,255);

--            Regular            --
-- WHM Use List 1
-- BLM Use List 500
-- RDM Use List 3
-- PLD Use List 4
-- DRK Use List 5
-- BRD Use List 6
-- NIN Use List 7
-- --------------------------------------------------------------------
--                        Skill Modifictions                        --
-- --------------------------------------------------------------------
-- Dynamis - Valkurm
DELETE FROM mob_skills WHERE mob_skill_id = "1605"; -- Miasmic Breath
REPLACE INTO mob_skills VALUES (1605,63,'miasmic_breath',4,15.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1607"; -- Fragrant Breath
REPLACE INTO mob_skills VALUES (1607,63,'fragrant_breath',4,15.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1609"; -- Putrid Breath
REPLACE INTO mob_skills VALUES (1609,63,'putrid_breath',4,15.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1610"; -- Extremely Bad Breath
REPLACE INTO mob_skills VALUES (1610,63,'extremely_bad_breath',1,15.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1611"; -- Vampiric Lash
REPLACE INTO mob_skills VALUES (1611,61,'vampiric_lash',0,15.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1617"; -- Blow
REPLACE INTO mob_skills VALUES (1617,325,'blow',0,7.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1618"; -- Uppercut
REPLACE INTO mob_skills VALUES (1618,328,'uppercut',0,7.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1619"; -- Attractant
REPLACE INTO mob_skills VALUES (1619,331,'attractant',1,15.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1146"; -- Hecatomb Wave (RNG/NIN)
REPLACE INTO mob_skills VALUES (1146,304,'hecatomb_wave',0,25.0,2000,1500,4,0,0,0,0,0,0);
DELETE FROM mob_skills WHERE mob_skill_id = "1123"; -- Hecatomb Wave (RNG/NIN)
REPLACE INTO mob_skills VALUES (1123,355,'ore_toss',0,25.0,2000,1500,4,0,0,0,0,0,0);
-- --------------------------------------------------------------------
--                         Add Missing Mobs                         --
-- --------------------------------------------------------------------
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (198,1153,134,'Dynamis_Icon',600,128,3209,9000,8000,80,82,0);
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (199,1155,134,'Dynamis_Statue',600,128,3208,9000,8000,80,82,0);
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (200,1152,134,'Dynamis_Effigy',600,128,3211,9000,8000,80,82,0);
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (201,1156,134,'Dynamis_Tombstone',600,128,3210,9000,8000,82,82,0);
-- --------------------------------------------------------------------
--                            Fix Mob MP                            --
-- --------------------------------------------------------------------
DELETE FROM mob_groups WHERE name = "Goublefaupe";
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (6,1774,134,'Goublefaupe',0,128,2574,5000,0,81,83,0);
DELETE FROM mob_groups WHERE name = "Quiebitiel";
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (7,3289,134,'Quiebitiel',0,128,2066,5000,0,81,83,0);
DELETE FROM mob_groups WHERE name = "Mildaunegeux";
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (8,2660,134,'Mildaunegeux',0,128,2574,5000,0,81,83,0);
DELETE FROM mob_groups WHERE name = "Velosareon";
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (9,4219,134,'Velosareon',0,128,2574,5000,0,81,83,0);
DELETE FROM mob_groups WHERE name = "Dagourmarche";
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (10,892,134,'Dagourmarche',0,128,2066,5000,0,81,83,0);
DELETE FROM mob_groups WHERE name = "Apocalyptic_Beast";
REPLACE INTO mob_groups (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (1,198,40,'Apocalyptic_Beast',0,128,146,27000,27000,85,85,0);
-- --------------------------------------------------------------------
--                     Zone Misc Modifications                      --
-- --------------------------------------------------------------------
UPDATE zone_settings SET misc = 408 WHERE name LIKE "Dynamis%" AND name NOT LIKE "Dyanamis_%_[D]";
UPDATE zone_settings SET misc = misc & ~8 WHERE name = "Dynamis-San_dOria" OR name = "Dynamis-Windurst" OR name = "Dynamis-Bastok" OR name = "Dynamis-Jeuno" OR name = "Dynamis-Tavnazia";

UNLOCK TABLES;
