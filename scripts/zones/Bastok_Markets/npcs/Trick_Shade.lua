-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Shade
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -240, y = -12, z = -28 },
    { x = -255, y = -12, z = -87 },
    { x = -277, y = -12, z = -97 },
    { x = -346, y = -10, z = -166 },
    { x = -364, y = -10, z = -160 },
    { x = -344, y = -10, z = -181 },
    { x = -344, y = -10, z = -165 },
    { x = -280, y = -12, z = -96 },
    { x = -302, y = -12, z = -71 },
    { x = -282, y = -12, z = -39 },
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
