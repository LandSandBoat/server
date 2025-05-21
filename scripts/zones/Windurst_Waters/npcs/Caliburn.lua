-----------------------------------
-- Area: Windurst Waters
--  NPC: Caliburn
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -43.049, y = -5.000, z = 129.379, wait = 6000 },
    { x = -44.462, z = 128.041, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
