-----------------------------------
-- Area: Windurst Waters
--  NPC: Pia
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -32.439, y = -2.500, z = -108.308, wait = 6000 },
    { x = -27.034, z = -113.642, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
