-----------------------------------
-- Area: Windurst Waters
--  NPC: Yohra-Ora
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -44.506, y = -5.000, z = 74.003, wait = 5000 },
    { x = -32.241, y = -5.000, z = 74.480, wait = 5000 },
    { x = -39.187, y = -5.000, z = 78.766, wait = 5000 },
    { x = -44.506, y = -5.000, z = 74.003, wait = 5000 },
    { x = -39.187, y = -5.000, z = 78.766, wait = 5000 },
    { x = -32.241, y = -5.000, z = 74.480, wait = 5000 },
    { x = -39.187, y = -5.000, z = 78.766, wait = 5000 },
    { x = -32.241, y = -5.000, z = 74.480, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc) then
            return
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(565)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
