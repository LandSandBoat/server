-----------------------------------
-- Area: Port Windurst
--  NPC: Mosusu
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    {x = -41.726, y = -5.760, z = 138.836},
    {x = -41.662, z = 138.717, wait = 6000},
    {x = -41.726, z = 138.836},
    {x = -41.861, z = 138.824, wait = 6000},
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
    npc:pathThrough(path, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(329)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
