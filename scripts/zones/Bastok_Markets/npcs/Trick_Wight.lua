-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Wight
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -193, y = -6, z = -83 },
    { x = -187, y = -6, z = -104 },
    { x = -212, y = -6, z = -92 },
    { x = -219, y = -6, z = -97 },
    { x = -200, y = -6, z = -119 },
    { x = -199, y = 2, z = -145 },
    { x = -166, y = 2, z = -124 },
    { x = -123, y = -2, z = -145 },
    { x = -109, y = -4, z = -142 },
    { x = -111, y = -4, z = -96 },
    { x = -159, y = -4, z = -83 },
    { x = -194, y = -6, z = -74 },
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
