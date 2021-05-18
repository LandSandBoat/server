-----------------------------------
-- Area: Windurst Woods
--  NPC: Dazi Nosuk
-----------------------------------
local entity = {}

local path =
{
-48.584, -2.914, 14.901,
-50.111, -3.637, 34.936
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
    player:startEvent(428)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
