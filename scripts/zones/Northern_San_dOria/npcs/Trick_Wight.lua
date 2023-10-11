-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -242, y = 8,  z = 44 },
    { x = -244, y = 8,  z = 12 },
    { x = -234, y = 8,  z = 18 },
    { x = -223, y = 8,  z = 74 },
    { x = -178, y = 4,  z = 75 },
    { x = -177, y = 0,  z = 103 },
    { x = -234, y = -4, z = 105 },
    { x = -177, y = 0,  z = 103 },
    { x = -178, y = 4,  z = 75 },
    { x = -224, y = 8,  z = 63 },
    { x = -223, y = 8,  z = 74 },
    { x = -242, y = 8,  z = 44 },
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
