-----------------------------------
-- Area: Windurst Walls
--  NPC: Polink-Moink
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.526, -6.822, -34.548,
    -3.605, -6.951, -32.150,
    -3.696, -6.876, -29.409,
    -3.820, -6.919, -25.643,
    -3.935, -7.808, -22.173,
    -4.101, -8.952, -17.130,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -4.101, -8.952, -17.130,
    -3.935, -7.808, -22.173,
    -3.820, -6.919, -25.643,
    -3.696, -6.876, -29.409,
    -3.605, -6.951, -32.150,
    -3.526, -6.822, -34.548,
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
    player:startEvent(302)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
