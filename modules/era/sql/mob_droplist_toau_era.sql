-----------------------------------
-- Mob drop list item removal module
-- This module removes or dds items for specific era's
-----------------------------------

-- Define rate variables
SET @COMMON = 150;   -- Common, 15%

-- ACP/AMK/ASA Items
DELETE FROM mob_droplist WHERE itemId = 2741; -- Seedspall Luna (Uncommon, 10%) ACP
DELETE FROM mob_droplist WHERE itemId = 2758; -- Quadav Backscale (Rare, 5%) AMK 
DELETE FROM mob_droplist WHERE itemId = 2778; -- Inferior Cocoon (Uncommon, 10%) ASA item
DELETE FROM mob_droplist WHERE itemId = 2776; -- Pumice Stone (Uncommon, 10%) ASA item
DELETE FROM mob_droplist WHERE itemId = 2757; -- Orcish Armor Plate (Rare, 5%) AMK item
DELETE FROM mob_droplist WHERE itemId = 2759; -- Block Of Yagudo Caulk (Rare, 5%) AMK item
DELETE FROM mob_droplist WHERE itemId = 2742; -- Seedspall Astrum
DELETE FROM mob_droplist WHERE itemId = 2740; -- Seedspall Lux (Uncommon, 10%) ACP Item

-- WOTG
DELETE FROM mob_droplist WHERE itemId = 4702; -- Scroll of Sacrifice
DELETE FROM mob_droplist WHERE itemId = 4703; -- Scroll Of Esuna WOTG
DELETE FROM mob_droplist WHERE itemId = 4726; -- Scroll Of Enthunder II WOTG
DELETE FROM mob_droplist WHERE itemId = 4703; -- Scroll Of Esuna WOTG
DELETE FROM mob_droplist WHERE itemId = 4725; -- Scroll Of Enstone II WOTG
DELETE FROM mob_droplist WHERE itemId = 4724; -- Scroll Of Enaero II WOTG
DELETE FROM mob_droplist WHERE itemId = 4723; -- Scroll of Enblizzard II WOTG
DELETE FROM mob_droplist WHERE itemId = 4722; -- Scroll of Enfire II
DELETE FROM mob_droplist WHERE itemId = 4701; -- Scroll Of Cura WOTG
DELETE FROM mob_droplist WHERE itemId = 4704; -- Scroll Of Auspice

-- Sky NM only Drop 1 Stone Until 2010
DELETE FROM mob_droplist WHERE dropId = 2820 AND itemId = 1419 AND itemRate = @COMMON; -- Springstone Dec 7th 2010 Mother Globe
DELETE FROM mob_droplist WHERE dropId = 2821 AND itemId = 1421 AND itemRate = @COMMON; -- Summerstone Dec 7th 2010 Faust
DELETE FROM mob_droplist WHERE dropId = 2822 AND itemId = 1423 AND itemRate = @COMMON; -- Autumnstone Dec 7th 2010 Ullikummi
DELETE FROM mob_droplist WHERE dropId = 2823 AND itemId = 1425 AND itemRate = @COMMON; -- Winterstone Dec 7th 2010 Olla Grande
DELETE FROM mob_droplist WHERE dropId = 2800 AND itemId = 1424 AND itemRate = @COMMON; -- Gem Of The North Dec 7th 2010 Zipacna
DELETE FROM mob_droplist WHERE dropId = 2326 AND itemId = 1418 AND itemRate = @COMMON; -- Gem Of The WestDec 7th 2010 Steam Cleaner
DELETE FROM mob_droplist WHERE dropId = 638 AND itemId = 1422 AND itemRate = @COMMON; -- Gem Of The West Dec 7th 2010 Despot
DELETE FROM mob_droplist WHERE dropId = 357 AND itemId = 1420 AND itemRate = @COMMON; -- Gem Of The South Dec 7th 2010 Brigandish Blade

-- Targeted Item Removals

-- ZoneID: 193 - Seeker Bats
-- ZoneID: 193 - Ancient Bat
DELETE FROM mob_droplist WHERE dropId = 461 AND itemId = 924; -- Vial Of Fiend Blood (Uncommon, 10%)

-- ZoneID: 109 Brass Quadav
DELETE FROM mob_droplist WHERE dropId = 350 AND itemId = 4552; -- Serving Of Herb Crawler Eggs (Despoil)
DELETE FROM mob_droplist WHERE dropId = 350 AND itemId = 4409; -- Hard-Boiled Egg (Despoil)

-- ZoneID: 119 - Yagudo Piper
DELETE FROM mob_droplist WHERE dropId = 2744 AND itemId = 4994; -- Scroll Of Mages Ballad (Uncommon, 10%)  Approx 2012

-- ZoneID: 145 - Yagudo Piper
DELETE FROM mob_droplist WHERE dropId = 2745 AND itemId = 4994; -- Scroll Of Mages Ballad (Uncommon, 10%)  Approx 2012

-- ZoneID: 212 - Pygmytoise
DELETE FROM mob_droplist WHERE dropId = 2815 AND itemId = 646; -- Chunk Of Adaman Ore (Rare, 5%) OOE mob
