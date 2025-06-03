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
    { x = -121.512833, y = -2.000000, z = 14.492509 },
    { x = -122.600044, z = 14.535807 },
    { x = -123.697128, z = 14.615446 },
    { x = -124.696846, z = 14.707844 },
    { x = -123.606018, z = 14.601295 },
    { x = -124.720863, z = 14.709210 },
    { x = -123.677681, z = 14.608237 },
    { x = -124.752579, z = 14.712106 },
    { x = -123.669525, z = 14.607473 },
    { x = -124.788277, z = 14.715488 },
    { x = -123.792847, z = 14.619405 },
    { x = -124.871826, z = 14.723736 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

return entity
