-----------------------------------
-- Area: Windurst Walls
--  NPC: Suhie-Kaihie
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -151.273, y = -2.500, z = 149.672, wait = 5000 },
    { x = -166.101, z = 149.860, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(291)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
