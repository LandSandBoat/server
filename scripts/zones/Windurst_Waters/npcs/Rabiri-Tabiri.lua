-----------------------------------
-- Area: Windurst Waters
--  NPC: Rabiri-Tabiri
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -97.480, -2.000, 50.409, -- Force turn.
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -103.792, -2.000, 42.469, -- Force turn.
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -109.966, -2.000, 49.942, -- Force turn.
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path, xi.path.flag.RUN)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(568)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
