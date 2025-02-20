-----------------------------------
-- Area: Lower Jeuno
--  NPC: Omer
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -90, y = 0, z = -127, rotation = 150, wait = 4000 },
    { rotation = 214, wait = 1000 },
    { x = -86, z = -120, rotation = 150, wait = 4000 },
    { rotation = 86, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
