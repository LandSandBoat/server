-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Ghast
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -62, y = -4, z = -108 },
    { x = -56, y = -4, z = -128 },
    { x = -67, y = -4, z = -120 },
    { x = -127, y = -4, z = -117 },
    { x = -186, y = -6, z = -92 },
    { x = -198, y = -6, z = -84 },
    { x = -189, y = -6, z = -72 },
    { x = -120, y = -4, z = -95 },
    { x = -72, y = -4, z = -96 },
    { x = -55, y = -6, z = -82 },
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
