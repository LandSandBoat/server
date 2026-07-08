-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -96, y = -0.001, z = 9, rotation = 192, wait = 4000 },
    { rotation = 64, wait = 1000 },
    { z = -9, rotation = 64, wait = 4000 },
    { rotation = 192, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
