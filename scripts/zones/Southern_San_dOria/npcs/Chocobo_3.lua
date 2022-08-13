-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    17.079, 2.200, -100.110,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    19.627, 2.200, -97.389,
    17.754, 2.200, -99.761,
    19.627, 2.200, -97.389,
    16.944, 2.200, -97.278,
    17.707, 2.200, -99.819,
    19.627, 2.200, -97.389,
    17.597, 2.200, -96.827,
    19.627, 2.200, -97.389,
    17.407, 2.200, -99.630,
    17.345, 2.200, -96.794,
    19.864, 2.200, -97.119,
    17.407, 2.200, -99.630,
    17.345, 2.200, -96.794,
    17.407, 2.200, -99.630,
    19.864, 2.200, -97.119,
    16.354, 2.200, -100.158,
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
    player:startEvent(818)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
