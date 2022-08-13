-----------------------------------
-- Area: Port San d'Oria
--  NPC: Brifalien
-- Involved in Quests: Riding on the Clouds
-- !pos -20 -4 -74 232
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -19.298, -4.000, -74.169,
    -19.298, -4.000, -74.169,
    -19.298, -4.000, -74.169,
    -19.298, -4.000, -74.169,
    -20.027, -4.000, -74.828,
    -20.577, -4.000, -74.736,
    -20.567, -4.000, -73.723,
    -20.134, -4.000, -73.353,
    -19.298, -4.000, -74.169,
    -19.298, -4.000, -74.169,
    -19.298, -4.000, -74.169,
    -19.298, -4.000, -74.169,
    -20.577, -4.000, -74.736,
    -20.577, -4.000, -74.736,
    -20.577, -4.000, -74.736,
    -20.577, -4.000, -74.736,
    -20.134, -4.000, -73.353,
    -20.134, -4.000, -73.353,
    -20.134, -4.000, -73.353,
    -20.134, -4.000, -73.353,
    -20.134, -4.000, -73.353,
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

entity.onEventFinish = function(player, csid, option)
end

return entity
