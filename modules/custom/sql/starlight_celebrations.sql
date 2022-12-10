-- ------------------------------------------------------------------------ --
--  Module to add Starlight Decorations to Jeuno, Additional Seasonal NPCs  --
-- ------------------------------------------------------------------------ --


-- ------------------------------------------------------------
-- Port Jeuno (Zone 246)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Port_Jeuno' AND zoneid='246';
UPDATE zone_settings SET music_night=239 WHERE name='Port_Jeuno' AND zoneid='246';

UPDATE npc_list SET pos_rot = 192, pos_x = -81.000, pos_y = 0.500, pos_z = 0.000, flag = 98305, namevis = 8, status = 0, entityFlags = 2075, look = 0x0000FF0200000000000000000000000000000000, name_prefix = 0, widescan = 0 WHERE npcid = 17784975 AND name = 'blank';
UPDATE npc_list SET pos_rot = 192, pos_x = 7.250, pos_y = 0.500, pos_z = 0.000, flag = 98305, namevis = 8, status = 0, entityFlags = 2075, look = 0x0000FF0200000000000000000000000000000000, name_prefix = 0, widescan = 0 WHERE npcid = 17784976 AND name = 'blank';

-- ------------------------------------------------------------
-- Lower Jeuno (Zone 245)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Lower_Jeuno' AND zoneid='245';
UPDATE zone_settings SET music_night=239 WHERE name='Lower_Jeuno' AND zoneid='245';

INSERT INTO `npc_list` VALUES (17781000,'blank','     ',181,-16.1840,0.675,5.3257,98305,40,40,0,0,8,0,2075,0x0000FC0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781001,'blank','     ',0,-18.3335,-0.100,-35.6341,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781002,'blank','     ',0,-18.3405,-0.100,-35.6283,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781003,'blank','     ',0,-28.0633,0.000,-55.2038,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781004,'blank','     ',0,-69.7005,0.000,-127.3172,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781005,'blank','     ',0,-86.1038,0.000,-143.9980,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781006,'blank','     ',0,-92.3048,0.000,-155.1194,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781007,'blank','     ',0,-90.9425,0.000,-160.1327,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781008,'blank','     ',0,-94.2040,0.000,-184.0553,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781009,'blank','     ',0,-53.2500,-6.000,-114.3925,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781010,'blank','     ',0,-6.8849,-0.100,-15.2041,98305,40,40,0,0,8,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);

-- ------------------------------------------------------------
-- Upper Jeuno (Zone 244)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Upper_Jeuno' AND zoneid='244';
UPDATE zone_settings SET music_night=239 WHERE name='Upper_Jeuno' AND zoneid='244';

UPDATE npc_list SET pos_rot = 18, pos_x = -50.000, pos_y = 0.675, pos_z = 109.253, flag = 98305, namevis = 8, status = 0, entityFlags = 98305, look = 0x0000FC0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776863 AND name = 'blank';
UPDATE npc_list SET pos_rot = 185, pos_x = -44.364, pos_y = 8.000, pos_z = 104.674, flag = 98305, namevis = 8, status = 0, entityFlags = 98305, look = 0x0000FE0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776875 AND name = 'blank';
UPDATE npc_list SET pos_rot = 42, pos_x = -37.256, pos_y = -0.500, pos_z = 27.000, flag = 98305, namevis = 8, status = 0, entityFlags = 98305, look = 0x0000FF0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776888 AND name = 'blank';
UPDATE npc_list SET pos_rot = 94, pos_x = -66.605, pos_y = -0.200, pos_z = 65.117, flag = 98305, namevis = 8, status = 0, entityFlags = 98305, look = 0x0000FE0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776889 AND name = 'blank';

-- ------------------------------------------------------------
-- Valkurm Dunes (Zone 103)
-- ------------------------------------------------------------

UPDATE npc_list SET pos_rot = 139, pos_x = 136.2782, pos_y = -7.6649, pos_z = 96.8022, flag = 98305, namevis = 8, status = 0, entityFlags = 98305, look = 0x0000FE0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17199707 AND name = 'Moogle';
UPDATE npc_list SET pos_rot = 139, pos_x = 142.2639, pos_y = -7.2481, pos_z = 103.2505, flag = 98305, namevis = 8, status = 0, entityFlags = 98305, look = 0x0000FE0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17199708 AND name = 'Moogle';
