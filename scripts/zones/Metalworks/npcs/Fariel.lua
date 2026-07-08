-----------------------------------
-- Area: Metalworks
--  NPC: Fariel
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 54.220, y = -14.000, z = -8.204, wait = 10000 },
    { x = 53.541, z = 6.536, wait = 10000 },
    { x = 41.340, z = 7.727, wait = 10000 },
    { x = 41.338, z = -9.662, wait = 10000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
