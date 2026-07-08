-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Glenne
-- Starts and Finishes Quest: A Sentry's Peril
-- !pos -122 -2 15 230
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -121.512833, y = -2.000000, z = 14.492509, wait = 1000 },
    { x = -126.7060, z = 14.492509, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
