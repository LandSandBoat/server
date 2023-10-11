-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Ghast
-- Harvest Festival Roaming Monster
-----------------------------------

require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -160, y = 0, z = 90 },
    { x = -143, y = 0, z = 89 },
    { x = -111, y = 0, z = 60 },
    { x = -73,  y = 0, z = 59 },
    { x = -26,  y = 0, z = 57 },
    { x = -91,  y = 0, z = 63 },
    { x =  98,  y = 0, z = 68 },
    { x = -108, y = 0, z = 69 },
    { x = -134, y = 0, z = 95 },
    { x = -137, y = 0, z = 107 },
    { x = -160, y = 0, z = 106 },
    { x = -159, y = 0, z = 94, },
    { x = -160, y = 0, z = 90 },
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
