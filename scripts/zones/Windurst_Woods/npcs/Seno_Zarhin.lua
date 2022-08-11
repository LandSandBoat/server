-----------------------------------
-- Area: Windurst Woods
--  NPC: Seno Zarhin
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -31.412, 2.667, -46.021,
    -36.695, 2.906, -49.078,
    -37.131, 2.847, -49.978,
    -37.214, 2.836, -50.277,
    -38.365, 2.991, -55.456,
    -37.214, 2.836, -50.277,
    -37.131, 2.847, -49.978,
    -36.695, 2.906, -49.078,
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
