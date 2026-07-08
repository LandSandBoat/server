-----------------------------------
-- Area: Windurst Walls
--  NPC: Suhie-Kaihie
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -151.273, y = -2.500, z = 149.672, wait = 5000 },
    { x = -166.101, z = 149.860, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
