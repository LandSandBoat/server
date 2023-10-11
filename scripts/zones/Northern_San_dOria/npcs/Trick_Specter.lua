-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Specter
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 102, y = 1, z = 93 },
    { x = 83,  y = 1, z = 83 },
    { x = 44,  y = 0, z = 46 },
    { x = 25,  y = 0, z = 46 },
    { x = 5,   y = 0, z = 65 },
    { x = 6,   y = 0, z = 97 },
    { x = -6,  y = 0, z = 97 },
    { x = -6,  y = 0, z = 65 },
    { x = -20, y = 0, z = 55 },
    { x = -26, y = 0, z = 39 },
    { x = -23, y = 0, z = 25 },
    { x = -7,  y = 0, z = 14 },
    { x = -3,  y = 0, z = -23 },
    { x = 5,   y = 0, z = -21 },
    { x = 7,   y = 0, z = 15 },
    { x = 24,  y = 0, z = 27 },
    { x = 28,  y = 0, z = 33 },
    { x = 52,  y = 0, z = 33 },
    { x = 104, y = 0, z = -10 },
    { x = 127, y = 0, z = -0 },
    { x = 104, y = 0, z = -10 },
    { x = 60,  y = 0, z = 32 },
    { x = 63,  y = 0, z = 46 },
    { x = 102, y = 1, z = 93 },
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
