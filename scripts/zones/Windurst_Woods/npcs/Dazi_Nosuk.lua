-----------------------------------
-- Area: Windurst Woods
--  NPC: Dazi Nosuk
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -48.584, y = -2.908, z = 14.903 },
    { x = -49.423, y = -3.284, z = 19.245 },
    { x = -50.150, y = -3.858, z = 24.000 },
    { x = -50.090, y = -3.640, z = 34.648 },
    { x = -50.150, y = -3.858, z = 24.000 },
    { x = -49.423, y = -3.284, z = 19.245 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
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
