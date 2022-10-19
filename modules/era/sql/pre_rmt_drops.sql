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

CALL replace_drop('FeiYin', 'Western_Shadow', 'retaliators', 'cross-counters');
CALL replace_drop('FeiYin', 'Eastern_Shadow', 'valis_bow', 'eurytos_bow');
CALL replace_drop('South_Gustaberg', 'Leaping_Lizzy', 'bounding_boots', 'leaping_boots');
CALL replace_drop('Castle_Oztroja', 'Mee_Deggi_the_Punisher', 'ochimusha_kote', 'ochiudos_kote');
CALL replace_drop('Castle_Oztroja', 'Quu_Domi_the_Gallant', 'sarutobi_kyahan', 'fuma_kyahan');
CALL replace_drop('Labyrinth_of_Onzozo', 'Lord_of_Onzozo', 'octave_club', 'kraken_club');
CALL replace_drop('Valkurm_Dunes', 'Valkurm_Emperor', 'empress_hairpin', 'emperor_hairpin');
CALL replace_drop('Maze_of_Shakhrami', 'Argus', 'peacock_amulet', 'peacock_charm');
CALL replace_drop('Jugner_Forest', 'King_Arthro', 'velocious_belt', 'speed_belt');
CALL replace_drop('Sauromugue_Champaign', 'Roc', 'dryad_staff', 'healing_staff');
CALL replace_drop('Rolanberry_Fields', 'Simurgh', 'trotter_boots', 'strider_boots');
CALL replace_drop('Ordelles_Caves', 'Stroper_Chyme', 'shikaree_ring', 'archers_ring');

-- Astral Ring (Coffer chests in Castle of Oztroja) handled in modules/era/lua/rmt_drops.lua
