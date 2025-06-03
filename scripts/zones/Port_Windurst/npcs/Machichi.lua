-----------------------------------
-- Area: Port Windurst
--  NPC: Machichi
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -106.567, y = -5.000, z = 169.822, wait = 6000 },
    { x = -113.700, y = -5.118, z = 178.268, wait = 6000 },
    { x = -108.809, y = -5.000, z = 172.477 },
    { x = -106.296, y = -5.000, z = 170.138 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
