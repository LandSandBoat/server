-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Arenuel
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 36, y = 1.996, z = 63, rotation = 0, wait = 8000 },
    { z = 59, rotation = 0, wait = 8000 },
    { z = 71, rotation = 0, wait = 8000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(120)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
