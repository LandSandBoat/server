-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhakih
-----------------------------------
local entity = {}

local path =
{
    { x = -4.010, y = 0.000, z = 79.261, wait = 20000 },
    { x = 3.596, y = 0.000, z = 78.553, wait = 20000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
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
