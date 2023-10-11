-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Phantom
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -340, y = -10, z = -187 },
    { x = -352, y = -10, z = -174 },
    { x = -335, y = -10, z = -153 },
    { x = -290, y = -10, z = -109 },
    { x = -266, y = -10, z = -108 },
    { x = -295, y = -10, z = -115 },
    { x = -347, y = -10, z = -165 },
    { x = -364, y = -10, z = -160 },
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
