-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Shadow
-- Harvest Festival Roaming Monster
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -221, y = -8, z = 34 },
    { x = -243, y = -4, z = 34 },
    { x = -252, y = -1, z = 41 },
    { x = -458, y = -1, z = 51 },
    { x = -224, y = -2, z = 65 },
    { x = -188, y = -4, z = 60 },
    { x = -195, y = -4, z = 89 },
    { x = -257, y = 0, z = 66 },
    { x = -246, y = -3, z = 29 },
    { x = -176, y = -8, z = 30 },
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
