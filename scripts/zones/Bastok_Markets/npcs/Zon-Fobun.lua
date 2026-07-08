-----------------------------------
-- Area: Bastok Markets
--  NPC: Zon-Fobun
-- !pos -241.293 -3 63.406 235
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -242.254, y = -2.000, z = 61.679, wait = 4000 },
    { x = -240.300, y = -2.000, z = 65.194, wait = 4000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
