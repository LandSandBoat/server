-----------------------------------
-- Area: Windurst Woods
--  NPC: Orahi-Karapahi
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    63.612, -4.250, 102.695,
    63.612, -4.250, 102.695,
    63.612, -4.250, 102.695,
    63.612, -4.250, 102.695,
    60.000, -4.250, 103.188,
    58.772, -4.250, 103.357,
    58.772, -4.250, 103.357,
    58.772, -4.250, 103.357,
    58.772, -4.250, 103.357,
    60.000, -4.250, 103.188,
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
    player:startEvent(413)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
