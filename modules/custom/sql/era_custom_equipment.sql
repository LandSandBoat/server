-- Era Custom Stats on weapons/items/armor

-- Choral Cannions +1
REPLACE INTO item_mods VALUES (15570, 76, 12); -- MOVE_SPEED_GEAR_BONUS: 12

-- Mjollnir
REPLACE INTO item_mods VALUES (18324, 13, 5); -- MND: 5
REPLACE INTO item_mods VALUES (18324, 71, 7); -- MPHEAL: 7
REPLACE INTO item_mods VALUES (18324, 374, 15); -- CURE_POTENCY: 15
REPLACE INTO item_mods VALUES (18324, 369, 1); -- REFRESH: 1

-- Claustrum
REPLACE INTO item_mods VALUES (18330, 7, 60); -- CONVHPTOMP: 60
REPLACE INTO item_mods VALUES (18330, 12, 11); -- INT: 11
REPLACE INTO item_mods VALUES (18330, 28, 20); -- MATT: 20
REPLACE INTO item_mods VALUES (18330, 30, 30); -- MACC: 30
REPLACE INTO item_mods VALUES (18330, 71, 15); -- MPHEAL: 15
REPLACE INTO item_mods VALUES (18330, 346, 4); -- PERPETUATION_REDUCTION: 4
REPLACE INTO item_mods VALUES (18330, 357, -3); -- BP_DELAY: -3
REPLACE INTO item_mods VALUES (18330, 369, 1); -- REFRESH: 1
REPLACE INTO item_mods VALUES (18330, 487, 20); -- MAGIC_BURST_BONUS_CAPPED: 20

-- Chatoyant Staff
UPDATE item_equipment SET MId = 583 WHERE itemId = 18633;

-- Isador (BLU Custom Relic)
DELETE FROM item_mods WHERE itemId = 18897 AND modId IN (25, 30, 170);
REPLACE INTO item_mods VALUES (18897, 5, 50); -- MP: 50
REPLACE INTO item_mods VALUES (18897, 8, 5); -- STR: 5
REPLACE INTO item_mods VALUES (18897, 9, 5); -- DEX: 5
REPLACE INTO item_mods VALUES (18897, 122, 15); -- BLUE: 15
REPLACE INTO item_mods VALUES (18897, 369, 1); -- REFRESH: 1
UPDATE item_equipment SET level = 75 WHERE itemId = 18897;
UPDATE item_weapon SET dmg = 47, hit = 2 WHERE itemId = 18897; -- DMG: 47, Occasionally attacks twice
