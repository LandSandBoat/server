-----------------------------------
-- Area: Al Zahbi
--  NPC: Sujyahn
-- !pos -48.213 -1 34.723 48
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -50.871, y = 0.000, z = 32.143, wait = 2000 },
    { rotation = 225, wait = 4000 },
    { x = -32.024, y = 0.000, z = 50.447, wait = 2000 },
    { rotation = 97, wait = 4000 },
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
