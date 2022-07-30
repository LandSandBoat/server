DROP PROCEDURE IF EXISTS replace_drop;
DELIMITER $$
CREATE PROCEDURE replace_drop(
    IN zoneName TINYTEXT,
    IN mobName TINYTEXT,
    IN oldDropName TINYTEXT,
    IN newDropName TINYTEXT
)
BEGIN
    SET @zoneId = (SELECT zoneid FROM zone_settings WHERE `name` = zoneName);
    SET @oldDropId = (SELECT itemid FROM item_basic WHERE `name` = oldDropName);
    SET @newDropId = (SELECT itemid FROM item_basic WHERE `name` = newDropName);
    SET @dropListId = (SELECT dropid from mob_groups WHERE zoneid = @zoneId AND name = mobName);
    UPDATE mob_droplist SET itemId = @newDropId WHERE dropId = @dropListId AND itemId = @oldDropId;
END $$
DELIMITER ;

-- replace_drop('zone name', 'mob name', 'old item name', 'new item name', new drop chance);
-- zone name: as found in zone_settings.sql
-- mob name: as found in mob_groups.sql
-- old/new item name: as found in item_basic.sql

CALL replace_drop('Jugner_Forest', 'King_Arthro', 'velocious_belt', 'speed_belt');
