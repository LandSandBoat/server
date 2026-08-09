-----------------------------------
-- Module: RoV NPC List Adjustments
-----------------------------------

-- Revert home point relocations
-- Source: https://forum.square-enix.com/ffxi/threads/49065-Nov-10-2015-%28JST%29-Version-Update
UPDATE `npc_list` SET `pos_x` = -293.791, `pos_y` = -10.000, `pos_z` = -102.539 WHERE `name` = 'HomePoint#1' AND (`npcid` & 0xFFF000) >> 12 = 235; -- Bastok Markets
UPDATE `npc_list` SET `pos_x` =   53.645, `pos_y` =   7.500, `pos_z` =  -28.682 WHERE `name` = 'HomePoint#1' AND (`npcid` & 0xFFF000) >> 12 = 236; -- Port Bastok
UPDATE `npc_list` SET `pos_x` =  -66.077, `pos_y` =   4.000, `pos_z` = -104.948 WHERE `name` = 'HomePoint#1' AND (`npcid` & 0xFFF000) >> 12 = 232; -- Port San d'Oria
UPDATE `npc_list` SET `pos_x` =  -67.980, `pos_y` =  -4.000, `pos_z` =  110.675 WHERE `name` = 'HomePoint#1' AND (`npcid` & 0xFFF000) >> 12 = 240; -- Port Windurst
