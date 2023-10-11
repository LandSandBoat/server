-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -245, y = -12, z = -53 },
    { x = -278, y = -12, z = -36 },
    { x = -320, y = -15, z = -51 },
    { x = -330, y = -15, z = -57 },
    { x = -329, y = -15, z = -79 },
    { x = -281, y = -12, z = -96 },
    { x = -254, y = -9,  z = -122 },
    { x = -221, y = -6,  z = -113 },
    { x = -193, y = -6,  z = -81 },
    { x = -202, y = -6,  z = -67 },
    { x = -242, y = -6,  z = -74 },
    { x = -243, y = -12, z = -59 },
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
