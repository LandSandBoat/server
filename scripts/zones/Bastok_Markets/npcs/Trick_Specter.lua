-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Specter
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -178, y = -8, z = -34 },
    { x = -235, y = -12, z = -30 },
    { x = -200, y = -8, z = -28 },
    { x = -199, y = -8, z = 27 },
    { x = -217, y = -8, z = 34 },
    { x = -154, y = -4, z = 30 },
    { x = -198, y = -8, z = 28 },
    { x = -198, y = -8, z = -30 },
    { x = -153, y = -4, z = -29 },
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
