-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rouva
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -17 2 10 230
-----------------------------------
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
        not utils.mask.getBit(wildcatSandy, 2)
    then
        player:startEvent(808)
    else
        player:startEvent(664)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 808 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 2, true))
    end
end

return entity
