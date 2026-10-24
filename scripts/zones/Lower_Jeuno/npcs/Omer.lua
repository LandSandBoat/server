-----------------------------------
-- Area: Lower Jeuno
--  NPC: Omer
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -90.752, y = 0.000, z = -127.466, rotation = 143, wait = 3000 },
    { rotation = 212, wait = 1000 },
    { x = -86.501, y = 0.000, z = -119.815, rotation = 148, wait = 3000 },
    { rotation = 84, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
