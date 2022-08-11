-----------------------------------
-- Area: Windurst Waters
--  NPC: Caliburn
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
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
    player:startEvent(599)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
