-- ------------------------------------------------------------------------ --
--  Module to add Starlight Decorations to Jeuno, Additional Seasonal NPCs  --
-- ------------------------------------------------------------------------ --


-- ------------------------------------------------------------
-- Port Jeuno (Zone 246)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Port_Jeuno' AND zoneid='246';
UPDATE zone_settings SET music_night=239 WHERE name='Port_Jeuno' AND zoneid='246';

UPDATE npc_list SET pos_rot = 192, pos_x = -81.000, pos_y = 0.500, pos_z = 0.000, flag = 98305, namevis = 64, status = 0, entityFlags = 2075, look = 0x0000FF0200000000000000000000000000000000, name_prefix = 0, widescan = 0 WHERE npcid = 17784975 AND name = 'blank';
UPDATE npc_list SET pos_rot = 192, pos_x = 7.250, pos_y = 0.500, pos_z = 0.000, flag = 98305, namevis = 64, status = 0, entityFlags = 2075, look = 0x0000FF0200000000000000000000000000000000, name_prefix = 0, widescan = 0 WHERE npcid = 17784976 AND name = 'blank';

-- ------------------------------------------------------------
-- Lower Jeuno (Zone 245)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Lower_Jeuno' AND zoneid='245';
UPDATE zone_settings SET music_night=239 WHERE name='Lower_Jeuno' AND zoneid='245';

INSERT INTO `npc_list` VALUES (17781000,'blank','     ',57,-16.1250,0.675,5.4297,98305,40,40,0,0,64,0,2075,0x0000FC0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781001,'blank','     ',0,-18.3335,-0.100,-35.6341,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781002,'blank','     ',0,-18.3405,-0.100,-35.6283,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781003,'blank','     ',0,-28.0633,-0.100,-55.2038,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781004,'blank','     ',0,-69.7005,-0.100,-127.3172,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781005,'blank','     ',0,-86.1038,-0.100,-143.9980,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781006,'blank','     ',0,-92.3048,-0.100,-155.1194,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781007,'blank','     ',0,-90.9425,-0.100,-160.1327,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781008,'blank','     ',0,-94.2040,-0.100,-184.0553,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781009,'blank','     ',0,-53.2500,-6.000,-114.3925,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);
INSERT INTO `npc_list` VALUES (17781010,'blank','     ',0,-6.8849,-0.100,-15.2041,98305,40,40,0,0,64,0,2075,0x0000FE0200000000000000000000000000000000,34,NULL,0);

-- ------------------------------------------------------------
-- Upper Jeuno (Zone 244)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Upper_Jeuno' AND zoneid='244';
UPDATE zone_settings SET music_night=239 WHERE name='Upper_Jeuno' AND zoneid='244';

UPDATE npc_list SET pos_rot = 18, pos_x = -50.000, pos_y = 0.675, pos_z = 109.253, flag = 98305, namevis = 64, status = 0, entityFlags = 98305, look = 0x0000FC0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776863 AND name = 'blank';
UPDATE npc_list SET pos_rot = 185, pos_x = -44.364, pos_y = 8.000, pos_z = 104.674, flag = 98305, namevis = 64, status = 0, entityFlags = 98305, look = 0x0000FE0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776875 AND name = 'blank';
UPDATE npc_list SET pos_rot = 42, pos_x = -37.256, pos_y = -0.500, pos_z = 27.000, flag = 98305, namevis = 64, status = 0, entityFlags = 98305, look = 0x0000FF0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776888 AND name = 'blank';
UPDATE npc_list SET pos_rot = 94, pos_x = -66.605, pos_y = -0.200, pos_z = 65.117, flag = 98305, namevis = 64, status = 0, entityFlags = 98305, look = 0x0000FE0200000000000000000000000000000000, name_prefix = 34, widescan = 0 WHERE npcid = 17776889 AND name = 'blank';
