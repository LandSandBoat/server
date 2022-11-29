-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Villion
-- Type: Adventurer's Assistant NPC
--  Involved in Quest: Flyers for Regine
-- !pos -157.524 4.000 263.818 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 9) -- FLYERS FOR REGINE
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
    player:startEvent(632)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
