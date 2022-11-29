-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Telmoda
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local npcID = npc:getID()
        local sender = player:getLocalVar("[StarlightMerryMakers]Sender")
        local confirmed = player:getLocalVar("[StarlightMerryMakers]Confirmed")

        if npcID == sender or npcID == confirmed then
            xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, ID)
            return
        end
    end
    local telmodaMadaline = player:getCharVar("Telmoda_Madaline_Event")

    if telmodaMadaline ~= 1 then
        player:setCharVar("Telmoda_Madaline_Event", 1)
        player:startEvent(531)
    else
        player:startEvent(616)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
