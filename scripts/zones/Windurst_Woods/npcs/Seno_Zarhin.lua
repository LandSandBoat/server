-----------------------------------
-- Area: Windurst Woods
--  NPC: Seno Zarhin
-----------------------------------
local entity = {}

local path =
{
    -38.365, 2.991, -55.456,    -- TODO: wait at location for 1 seconds
    -36.877, 2.883, -49.319,
    -31.336, 2.660, -45.977,
    -36.312, 2.944, -48.826
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(417)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
