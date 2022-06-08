
CREATE TABLE IF NOT EXISTS economy_total_gil (`timestamp` DATETIME, total_gil BIGINT UNSIGNED);
CREATE TABLE IF NOT EXISTS economy_large_transactions (`timestamp` DATETIME, `accid` INT UNSIGNED, `charid` INT UNSIGNED, `name` TEXT, `change` BIGINT SIGNED, `new_total` BIGINT UNSIGNED);

DROP TRIGGER IF EXISTS large_transactions_update;

DELIMITER $$

CREATE TRIGGER large_transactions_update AFTER UPDATE ON xidb.char_inventory FOR EACH ROW
BEGIN
    -- Any gil increase (and paired decrease) larger than 100000 will be tracked
    SET @OLD_VALUE = CAST(OLD.quantity AS SIGNED);
    SET @NEW_VALUE = CAST(NEW.quantity AS SIGNED);
    SET @CHANGE = ABS(@NEW_VALUE - @OLD_VALUE);

    IF NEW.itemId = 65535 AND @CHANGE >= 100000 THEN
        INSERT INTO economy_large_transactions (`timestamp`, `accid`, `charid`, `name`, `change`, `new_total`)
        VALUES(
            NOW(),
            (SELECT `accid` FROM char_inventory INNER JOIN chars ON chars.charid = NEW.charid LIMIT 1),
            NEW.charid,
            (SELECT `charname` FROM char_inventory INNER JOIN chars ON chars.charid = NEW.charid LIMIT 1),
            @CHANGE,
            NEW.quantity
        );
    END IF;
END $$

DELIMITER ;
