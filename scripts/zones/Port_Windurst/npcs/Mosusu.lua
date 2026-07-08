-----------------------------------
-- Area: Port Windurst
--  NPC: Mosusu
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -41.726, y = -5.760, z = 138.836 },
    { x = -41.662, z = 138.717, wait = 6000 },
    { x = -41.726, z = 138.836 },
    { x = -41.861, z = 138.824, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
