-----------------------------------
-- Area: Heaven's Tower
--  NPC: Chuqui-Chanqui
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -18.932, y = 0.500, z = -6.795 },
    { x = -21.262, z = 0.276, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(80)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
