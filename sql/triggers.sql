SET NAMES 'utf8';

DELIMITER $$

DROP TRIGGER IF EXISTS auction_house_buy $$
CREATE TRIGGER auction_house_buy
    BEFORE UPDATE ON auction_house
    FOR EACH ROW
BEGIN
    IF OLD.seller != 0 AND NEW.sale != 0 THEN INSERT INTO delivery_box VALUES (NEW.seller, NEW.seller_name, 1, 0, 0xFFFF, NEW.itemid, NEW.sale, NULL, 0, 'AH-Jeuno', 0, 0); END IF;
END $$

DROP TRIGGER IF EXISTS delivery_box_insert $$
CREATE TRIGGER delivery_box_insert
    BEFORE INSERT ON delivery_box
    FOR EACH ROW
BEGIN
    SET @slot := 0;
    SELECT MAX(slot) INTO @slot FROM delivery_box WHERE box = NEW.box AND charid = NEW.charid;
    IF NEW.box = 1 THEN
    IF @slot IS NULL OR @slot < 8 THEN SET NEW.slot := 8; ELSE SET NEW.slot := @slot + 1; END IF;
    END IF;
END $$

DROP TRIGGER IF EXISTS account_delete $$
CREATE TRIGGER account_delete
    BEFORE DELETE ON accounts
    FOR EACH ROW
BEGIN
    DELETE FROM `accounts_banned` WHERE `accid` = OLD.id;
    DELETE FROM `chars` WHERE `accid` = OLD.id;     
END $$

DROP TRIGGER IF EXISTS session_delete $$
CREATE TRIGGER session_delete
    BEFORE DELETE ON accounts_sessions
    FOR EACH ROW
BEGIN
    UPDATE `char_stats` SET zoning = 0 WHERE `charid` = OLD.charid;
END $$

DROP TRIGGER IF EXISTS char_delete $$
CREATE TRIGGER char_delete
    BEFORE DELETE ON chars
    FOR EACH ROW
BEGIN
    DELETE FROM `char_blacklist`  WHERE `charid_owner` = OLD.charid;
    DELETE FROM `char_chocobos`   WHERE `charid` = OLD.charid;
    DELETE FROM `char_effects`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_equip`      WHERE `charid` = OLD.charid;
    DELETE FROM `char_equip_saved` WHERE `charid` = OLD.charid;
    DELETE FROM `char_exp`        WHERE `charid` = OLD.charid;
    DELETE FROM `char_history`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_inventory`  WHERE `charid` = OLD.charid;
    DELETE FROM `char_jobs`       WHERE `charid` = OLD.charid;
    DELETE FROM `char_job_points` WHERE `charid` = OLD.charid;
    DELETE FROM `char_look`       WHERE `charid` = OLD.charid;
    DELETE FROM `char_merit`      WHERE `charid` = OLD.charid;
    DELETE FROM `char_pet`        WHERE `charid` = OLD.charid;
    DELETE FROM `char_points`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_profile`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_recast`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_skills`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_spells`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_stats`      WHERE `charid` = OLD.charid;
    DELETE FROM `char_storage`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_style`      WHERE `charid` = OLD.charid;
    DELETE FROM `char_unlocks`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_vars`       WHERE `charid` = OLD.charid;
    DELETE FROM `auction_house`   WHERE `seller` = OLD.charid;
    DELETE FROM `delivery_box`    WHERE `charid` = OLD.charid;
    UPDATE `account_ip_record` SET `charid`  = 0 where `charid` = OLD.charid;
    UPDATE `delivery_box` SET sent = 0 WHERE box = 2 AND received = 0 AND sent = 1 AND senderid = OLD.charid;
END $$

DROP TRIGGER IF EXISTS char_insert $$
CREATE TRIGGER char_insert
    BEFORE INSERT ON chars
    FOR EACH ROW
BEGIN
    INSERT INTO `char_equip`     SET `charid` = NEW.charid;
    INSERT INTO `char_exp`       SET `charid` = NEW.charid;
    INSERT INTO `char_history`   SET `charid` = NEW.charid;
    INSERT INTO `char_inventory` SET `charid` = NEW.charid;
    INSERT INTO `char_jobs`      SET `charid` = NEW.charid;
    INSERT INTO `char_pet`       SET `charid` = NEW.charid;
    INSERT INTO `char_points`    SET `charid` = NEW.charid;
    INSERT INTO `char_profile`   SET `charid` = NEW.charid;
    INSERT INTO `char_storage`   SET `charid` = NEW.charid;
    INSERT INTO `char_unlocks`   SET `charid` = NEW.charid;
END $$
