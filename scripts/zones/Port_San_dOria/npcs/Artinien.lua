-----------------------------------
-- Area: Port San d'Oria
--  NPC: Artinien
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -17.142, y = -4.000, z = -74.747, wait = 2000 },
    { x = -20.721, z = -76.425, wait = 2000 },
    { x = -21.725, z = -73.177 },
    { x = -19.164, z = -71.713 },
    { x = -17.037, z = -74.698, wait = 2000 },
    { x = -20.893, z = -76.206 },
    { x = -21.735, z = -75.139 },
    { x = -22.984, z = -73.555, wait = 2000 },
    { x = -19.132, z = -71.759 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
