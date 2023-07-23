-----------------------------------
-- Area: Windurst Waters
--  NPC: Shataru-Potaru
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 150.716, y = -2.500, z = 130.594 },
    { x = 150.995, z = 130.387 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(585)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
