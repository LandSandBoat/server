-----------------------------------
-- Area: Windurst Waters
--  NPC: Shataru-Potaru
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 150.716, y = -2.500, z = 130.594 },
    { x = 150.995, z = 130.387 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
