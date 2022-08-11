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
    -41.726, -5.760, 138.836,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.726, -5.760, 138.836,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
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
    player:startEvent(329)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
