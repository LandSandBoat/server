-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Miageau
-- Type: Quest Giver NPC
-- !pos 115 0 108 231
-- Starts and Finishes: Waters of Cheval
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATER_OF_THE_CHEVAL) == QUEST_ACCEPTED) then
        if (trade:getItemCount() == 1 and trade:hasItemQty(603, 1)) then
            player:startEvent(515)
        end
    end
end

entity.onTrigger = function(player, npc)

    local watersOfTheCheval = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATER_OF_THE_CHEVAL)
    if (watersOfTheCheval == QUEST_ACCEPTED) then
        if (player:hasItem(602) == true) then
            player:startEvent(512)
        else
            player:startEvent(519)
        end
    elseif (watersOfTheCheval == QUEST_AVAILABLE) then
        player:startEvent(504)
    else
        player:startEvent(517)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 515) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13183)
        else
            player:tradeComplete()
            player:addItem(13183)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13183)
            player:addFame(SANDORIA, 30)
            player:addTitle(xi.title.THE_PURE_ONE)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATER_OF_THE_CHEVAL)
        end
    elseif (csid == 504) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATER_OF_THE_CHEVAL)
    end

end

return entity
