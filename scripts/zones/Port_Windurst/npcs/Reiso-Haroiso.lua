-----------------------------------
-- Area: Port Windurst
--  NPC: Reiso-Haroiso
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 45.821, y = -5.000, z = 121.300 },
    { x = 45.736, z = 124.757 },
    { x = 45.669, z = 127.514 },
    { x = 45.736, z = 124.757 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
