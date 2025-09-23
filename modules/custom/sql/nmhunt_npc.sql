-- Explorer Moogle NPC for Era's NM Hunt
-- Ru'Lude Gardens
UPDATE `npc_list` 
SET 
    pos_rot = 0,
    pos_x = -61.000,
    pos_y = 6.000,
    pos_z = -6.000,
    flag = 0,
    speed = 40,
    speedsub = 40,
    status = 0,
    look = _binary 0x00003A0800000000000000000000000000000000
WHERE 
    npcid = 17772772;
