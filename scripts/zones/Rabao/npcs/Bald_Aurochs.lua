-----------------------------------
-- Area: Rabao
--  NPC: Bald Aurochs
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 8.502, y = -0.965, z = -82.459, wait = 10000 },
    { x = -1.666, y = 0.000, z = -79.405, wait = 10000 },
    { x = -2.386, y = 0.577, z = -73.129, wait = 10000 },
    { x = 9.343, y = 1.240, z = -64.403, wait = 10000 },
    { x = 10.698, y = -1.593, z = -76.171, wait = 10000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
