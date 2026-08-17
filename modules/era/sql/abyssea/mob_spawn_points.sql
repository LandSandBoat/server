-----------------------------------
-- Module: Abyssea Mob Spawn Points Adjustments
-----------------------------------

-- WHM AF Quest "Piejue's Decision" ??? and mob spawn relocated
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/09/2011)
UPDATE `mob_spawn_points` SET `pos_x` = 173.643, `pos_y` = -24.536, `pos_z` = -81.385 WHERE `mobname` = 'Altedour_I_Tavnazia'; -- Fei'Yin
