-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Vavegallet
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

local entity = {}

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
    player:startEvent(673)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
