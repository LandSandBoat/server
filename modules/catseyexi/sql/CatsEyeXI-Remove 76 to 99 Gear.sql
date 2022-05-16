-- -----------------------------------------------
-- Remove lv 76-99 gear from AH to reduce clutter
-- -----------------------------------------------

-- Clear AH sellable flag from item
UPDATE item_basic, item_equipment SET item_basic.flags = item_basic.flags & ~0x0040 WHERE item_equipment.`level` > 75 AND (item_basic.flags & 0x0040) = 1 AND item_equipment.itemId = item_basic.itemid;

-- Set to invalid category
UPDATE item_basic, item_equipment SET item_basic.aH = 255 WHERE item_equipment.`level` > 75 AND item_basic.aH > 0 AND item_equipment.itemId = item_basic.itemid;


-- -----------------------------------------------
-- Remove itemLevel gear from AH to reduce clutter
-- -----------------------------------------------

-- Clear AH sellable flag from item
UPDATE item_basic, item_equipment SET item_basic.flags = item_basic.flags & ~0x0040 WHERE item_equipment.ilevel > 0 AND (item_basic.flags & 0x0040) AND item_equipment.itemId = item_basic.itemid;

-- Set to invalid category
UPDATE item_basic, item_equipment SET item_basic.aH = 255 WHERE item_equipment.ilevel > 0 AND item_basic.aH > 0 AND item_equipment.itemId = item_basic.itemid;


-- -----------------------------------------------
-- Remove lv 76-99 gear from Goblin Mystery box
-- -----------------------------------------------

-- Clear ITEM_FLAG_MYSTERY_BOX from item
UPDATE item_basic, item_equipment SET item_basic.flags = item_basic.flags & ~0x0004 WHERE item_equipment.`level` > 75 AND (item_basic.flags & 0x0004) AND item_equipment.itemId = item_basic.itemid;


-- -----------------------------------------------
-- Remove itemLevel gear from Goblin Mystery box
-- -----------------------------------------------

-- Clear ITEM_FLAG_MYSTERY_BOX from item
UPDATE item_basic, item_equipment SET item_basic.flags = item_basic.flags & ~0x0004 WHERE item_equipment.ilevel > 0 AND (item_basic.flags & 0x0004) AND item_equipment.itemId = item_basic.itemid;