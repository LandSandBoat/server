-----------------------------------
-- Area: Windurst Waters
--  NPC: Pia
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -32.439, y = -2.500, z = -108.308, wait = 6000 },
    { x = -27.034, z = -113.642, wait = 6000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local npcID = npc:getID()
        local sender = player:getCharVar("[MerryMakers]Sender")
        local confirmed = player:getCharVar("[MerryMakers]Confirmed")

        if npcID == sender or npcID == confirmed then
            xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, ID)
            return
        end
    end

    player:startEvent(597)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
