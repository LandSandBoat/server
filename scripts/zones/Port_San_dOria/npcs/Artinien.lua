-----------------------------------
-- Area: Port San d'Oria
--  NPC: Artinien
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -17.142, -4.000, -74.747,
    -17.142, -4.000, -74.747,
    -17.142, -4.000, -74.747,
    -17.142, -4.000, -74.747,
    -20.721, -4.000, -76.425,
    -20.721, -4.000, -76.425,
    -20.721, -4.000, -76.425,
    -20.721, -4.000, -76.425,
    -21.725, -4.000, -73.177,
    -19.164, -4.000, -71.713,
    -17.037, -4.000, -74.698,
    -17.037, -4.000, -74.698,
    -17.037, -4.000, -74.698,
    -17.037, -4.000, -74.698,
    -20.893, -4.000, -76.206,
    -21.735, -4.000, -75.139,
    -22.984, -4.000, -73.555,
    -22.984, -4.000, -73.555,
    -22.984, -4.000, -73.555,
    -19.132, -4.000, -71.759,
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
