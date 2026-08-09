-----------------------------------
-- Module: Abyssea NPC List Adjustments
-----------------------------------

-- WHM AF Quest "Piejue's Decision" ??? relocated
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/09/2011)
UPDATE `npc_list` SET `pos_x` = 173.143, `pos_y` = -24.016, `pos_z` = -81.385 WHERE `name` = 'qm1' AND (`npcid` & 0xFFF000) >> 12 = 204; -- Fei'Yin
