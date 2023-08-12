-----------------------------------
-- Area: Windurst Waters
--  NPC: Pia
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -32.439, y = -2.500, z = -108.308, wait = 6000 },
    { x = -27.034, z = -113.642, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(597)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
