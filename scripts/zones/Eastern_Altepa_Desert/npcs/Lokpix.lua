-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: Lokpix
-- Starts Quest "Open Sesame"
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME) == QUEST_ACCEPTED) then
        if
            (trade:hasItemQty(2796, 1) and trade:hasItemQty(582, 1) and trade:getItemCount() == 2) or
            (trade:hasItemQty(2796, 1) and trade:hasItemQty(3319, 1) and trade:getItemCount() == 2) or
            (trade:hasItemQty(2796, 1) and trade:hasItemQty(3300, 12) and trade:getItemCount() == 13)
        then
            player:startEvent(22)
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME) == QUEST_AVAILABLE) then
        player:startEvent(20)
    elseif (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME) == QUEST_ACCEPTED) then
        player:startEvent(21)
    elseif (player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME)) then
        player:startEvent(24)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("OPTION: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("OPTION: %u", option)

    if (csid == 20 and option == 1) then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME)
    elseif (csid == 22) then
        player:tradeComplete()
        player:addKeyItem(xi.ki.LOADSTONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LOADSTONE)
        player:addFame(RABAO, 30)
        player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.OPEN_SESAME)
    end

end

return entity
