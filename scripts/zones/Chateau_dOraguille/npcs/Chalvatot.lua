-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Chalvatot
-- Finish Mission "The Crystal Spring"
-- Start & Finishes Quests: Her Majesty's Garden
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -105 0.1 72 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lureOfTheWildcat = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)
    local wildcatSandy = player:getCharVar("WildcatSandy")

    -- LURE OF THE WILDCAT
    if
        lureOfTheWildcat == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 19)
    then
        player:startEvent(561)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- LURE OF THE WILDCAT
    if csid == 561 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 19, true))
    end
end

return entity
