-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -305, y = -10, z = -113 },
    { x = -299, y = -10, z = -121 },
    { x = -308, y = -10, z = -131 },
    { x = -293, y = -15, z = -146 },
    { x = -308, y = -10, z = -131 },
    { x = -326, y = -10, z = -147 },
    { x = -310, y = -15, z = -164 },
    { x = -326, y = -10, z = -147 },
    { x = -358, y = -10, z = -178 },
    { x = -305, y = -10, z = -124 },
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
