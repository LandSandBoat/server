-----------------------------------
-- Area: Bastok Markets
--  NPC: Gwill
-- Starts & Ends Quest: The Return of the Adventurer
-- Involved in Quests: The Cold Light of Day, Riding on the Clouds
-- !pos ? ? ? 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local returnOfAdven = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER)
    if (returnOfAdven == QUEST_ACCEPTED and trade:hasItemQty(628, 1) and trade:getItemCount() == 1) then
        player:startEvent(243)
    end

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_2") == 2) then
        if (trade:hasItemQty(1127, 1) and trade:getItemCount() == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:tradeComplete()
            player:addKeyItem(xi.ki.SMILING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SMILING_STONE)
        end
    end

end

entity.onTrigger = function(player, npc)

    local pFame = player:getFameLevel(BASTOK)
    local FatherFigure = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FATHER_FIGURE)
    local TheReturn = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER)

    if (FatherFigure == QUEST_COMPLETED and TheReturn == QUEST_AVAILABLE and pFame >= 3) then
        player:startEvent(242)
    elseif (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_COLD_LIGHT_OF_DAY) == QUEST_ACCEPTED) then
        player:startEvent(103)
    else
        player:startEvent(113)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 242) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER)
    elseif (csid == 243) then
        if (player:getFreeSlotsCount() >= 1) then
            player:tradeComplete()
            player:addTitle(xi.title.KULATZ_BRIDGE_COMPANION)
            player:addItem(12498)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12498)
            player:addFame(BASTOK, 80)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12498)
        end
    end

end

return entity
