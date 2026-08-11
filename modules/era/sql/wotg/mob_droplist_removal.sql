-----------------------------------
-- Mob drop list item removal module
-- This module removes or dds items for the ToAU era
-----------------------------------

-- ACP/AMK/ASA Items
-- Added in their respective mini-expansions
DELETE FROM mob_droplist WHERE itemId = 2757; -- Orcish Armor Plate AMK item
DELETE FROM mob_droplist WHERE itemId = 2758; -- Quadav Backscale AMK item
DELETE FROM mob_droplist WHERE itemId = 2759; -- Block Of Yagudo Caulk AMK item
DELETE FROM mob_droplist WHERE itemId = 2740; -- Seedspall Lux ACP Item
DELETE FROM mob_droplist WHERE itemId = 2741; -- Seedspall Luna ACP item
DELETE FROM mob_droplist WHERE itemId = 2742; -- Seedspall Astrum ACP Item
DELETE FROM mob_droplist WHERE itemId = 2776; -- Pumice Stone ASA item
DELETE FROM mob_droplist WHERE itemId = 2777; -- Magicked Blood ASA item
DELETE FROM mob_droplist WHERE itemId = 2778; -- Inferior Cocoon ASA item

-- WOTG
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
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
