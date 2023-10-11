-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Skeleton
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -265, y = -10, z = -118 },
    { x = -222, y = -6, z = -118 },
    { x = -220, y = -6, z = -98 },
    { x = -205, y = -6, z = -90 },
    { x = -185, y = -6, z = -99 },
    { x = -200, y = -6, z = -118 },
    { x = -202, y = 4, z = -191 },
    { x = -200, y = -6, z = -104 },
    { x = -249, y = -8, z = -124 },
    { x = -269, y = -10, z = -105 },
    { x = -291, y = -10, z = -102 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
    xi.events.harvest.onHalloweenTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, zones[player:getZoneID()].text.TRICK_OR_TREAT)
end

return entity
