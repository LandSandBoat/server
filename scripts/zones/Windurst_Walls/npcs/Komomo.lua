-----------------------------------
-- Area: Windurst Walls
--  NPC: Komomo
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -185.998, y = -2.596, z = 150.789 },
    { x = -186.428, y = -2.565, z = 150.094 },
    { x = -186.996, y = -2.554, z = 150.019 },
    { x = -187.910, y = -2.547, z = 150.332 },
    { x = -188.308, y = -2.561, z = 151.251 },
    { x = -187.576, y = -2.560, z = 151.772 },
    { x = -186.621, y = -2.589, z = 151.791 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
