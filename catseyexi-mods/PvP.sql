USE tpzdb;
UPDATE `npc_list` SET pos_rot=27,pos_x=-45.571,pos_y=-0.984,pos_z=24.508 WHERE `npcid`=17928225;
UPDATE `npc_list` SET pos_rot=145 WHERE `npcid`=17928251;
SELECT * FROM `zonelines` AS ZL WHERE ZL.fromzone = 281 OR ZL.tozone = 218;
DELETE FROM `zonelines` WHERE `zoneline` = 812922746;