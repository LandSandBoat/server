-----------------------------------
-- Area: Windurst Woods
--  NPC: Dazi Nosuk
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -48.584, -2.908, 14.903,
    -49.423, -3.284, 19.245,
    -50.150, -3.858, 24.000,
    -50.090, -3.640, 34.648,
    -50.150, -3.858, 24.000,
    -49.423, -3.284, 19.245,
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
    player:startEvent(428)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
