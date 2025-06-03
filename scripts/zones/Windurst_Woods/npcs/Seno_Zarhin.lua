-----------------------------------
-- Area: Windurst Woods
--  NPC: Seno Zarhin
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -31.412, y = 2.667, z = -46.021 },
    { x = -36.695, y = 2.906, z = -49.078 },
    { x = -37.131, y = 2.847, z = -49.978 },
    { x = -37.214, y = 2.836, z = -50.277 },
    { x = -38.365, y = 2.991, z = -55.456 },
    { x = -37.214, y = 2.836, z = -50.277 },
    { x = -37.131, y = 2.847, z = -49.978 },
    { x = -36.695, y = 2.906, z = -49.078 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
