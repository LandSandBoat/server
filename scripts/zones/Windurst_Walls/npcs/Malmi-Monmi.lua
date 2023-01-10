-----------------------------------
-- Area: Windurst Walls
--  NPC: Malmi-Monmi
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -101.174, y = -5.450, z = 148.387, wait = 6000 },
    { x = -103.634, y = -5.478, z = 146.359, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(295)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
