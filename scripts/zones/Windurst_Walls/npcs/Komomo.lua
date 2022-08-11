-----------------------------------
-- Area: Windurst Walls
--  NPC: Komomo
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -185.998, -2.596, 150.789,
    -186.428, -2.565, 150.094,
    -186.996, -2.554, 150.019,
    -187.910, -2.547, 150.332,
    -188.308, -2.561, 151.251,
    -187.576, -2.560, 151.772,
    -186.621, -2.589, 151.791,
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
    player:startEvent(290)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
