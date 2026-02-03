-----------------------------------
-- Mob drop list item removal module
-- This module removes or dds items for the ToAU era
-----------------------------------
-- Source: http://www.playonline.com/pcd/update/ff11us/20070308c2bbd1/detail.html
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
