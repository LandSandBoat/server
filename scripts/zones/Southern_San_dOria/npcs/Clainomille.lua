-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Clainomille
-- !pos -72.771 0.999 -6.112 230
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -66.767, y = 2.000, z = -11.673, rotation = 220, wait = 8000 },
    { x = -74.918, z = -4.125, rotation = 220, wait = 8000 },
    { x = -76.530, z = 0.443 },
    { x = -75.314, z = 1.616, rotation = 35, wait = 8000 },
    { x = -76.530, z = 0.443 },
    { x = -74.918, z = -4.125 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
