-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Rahal
-- Involved in Quests: The Holy Crest, Lure of the Wildcat (San d'Oria)
-- !pos -28 0.1 -6 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar("WildcatSandy")

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 17)
    then
        player:startEvent(559)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 559 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 17, true))
    end
end

return entity
