-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Quelveuiat
-- !pos -3.177 -22.750 -25.970 26
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -3.177, y = -22.750, z = -25.970, rotation = 132, wait = 35000 },
    { x = 3.177, y = -22.750, z = -25.970, rotation = 0, wait = 35000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
