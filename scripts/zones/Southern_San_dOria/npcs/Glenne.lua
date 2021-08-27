-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Glenne
-- Starts and Finishes Quest: A Sentry's Peril
-- !pos -122 -2 15 230
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -121.512833, -2.000000, 14.492509,
    -122.600044, -2.000000, 14.535807,
    -123.697128, -2.000000, 14.615446,
    -124.696846, -2.000000, 14.707844,
    -123.606018, -2.000000, 14.601295,
    -124.720863, -2.000000, 14.709210,
    -123.677681, -2.000000, 14.608237,
    -124.752579, -2.000000, 14.712106,
    -123.669525, -2.000000, 14.607473,
    -124.788277, -2.000000, 14.715488,
    -123.792847, -2.000000, 14.619405,
    -124.871826, -2.000000, 14.723736
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
