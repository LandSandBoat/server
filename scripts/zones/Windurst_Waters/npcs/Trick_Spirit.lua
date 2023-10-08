-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -85,  y = -3, z = 70 },
    { x = -82,  y = -3, z = 63 },
    { x = -109, y = -2, z = 47 },
    { x = -97,  y = -3, z = 23 },
    { x = -43,  y = -2, z = 1 },
    { x = -31,  y = -2, z = 7 },
    { x = -32,  y = -3, z = 37 },
    { x = -39,  y = -3, z = 42 },
    { x = -39,  y = -5, z = 118 },
    { x = -31,  y = -5, z = 130 },
    { x = -39,  y = -5, z = 118 },
    { x = -41,  y = -5, z = 89 },
    { x = -82,  y = -5, z = 85 },
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
