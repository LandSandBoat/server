-----------------------------------
-- Area: Port Windurst
--  NPC: Seven of Clubs
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -25.016, -6.000, 149.974,
    -30.5551, -6.000, 149.359,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -25.016, -6.000, 149.974,
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
    player:startEvent(220)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
