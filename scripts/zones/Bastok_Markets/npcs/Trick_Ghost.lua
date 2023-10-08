-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -309, y = -12, z = -77 },
    { x = -306, y = -12, z = -86 },
    { x = -323, y = -15, z = -86 },
    { x = -328, y = -15, z = -75 },
    { x = -317, y = -15, z = -67 },
    { x = -329, y = -15, z = -59 },
    { x = -321, y = -15, z = -51 },
    { x = -262, y = -12, z = -46 },
    { x = -253, y = -12, z = -70 },
    { x = -272, y = -12, z = -95 },
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
