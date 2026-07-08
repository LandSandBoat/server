-----------------------------------
-- Area: Nashmau
--  NPC: Chuchuroon
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -20.826, y = 0.000, z = -44.997, wait = 3000 },
    { x = -10.165, y = 0.000, z = -36.021, wait = 3000 },
    { x = -16.420, y = 0.000, z = -34.094, wait = 3000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
