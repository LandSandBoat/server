-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Parvipon
-- Starts and Finishes Quest: The Merchant's Bidding (R)
-- !pos -169 -1 13 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MERCHANTS_BIDDING) ~= xi.questStatus.QUEST_AVAILABLE then
        if
            trade:hasItemQty(xi.item.RABBIT_HIDE, 3) and
            trade:getItemCount() == 3
        then
            player:startEvent(89)
        end
    end
end

entity.onTrigger = function(player, npc)
    local theMerchantsBidding = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MERCHANTS_BIDDING)

    if theMerchantsBidding == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(90)
    else
        player:startEvent(88)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 90 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MERCHANTS_BIDDING)
    elseif csid == 89 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 120)
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MERCHANTS_BIDDING) == xi.questStatus.QUEST_ACCEPTED then
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MERCHANTS_BIDDING)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end
    end
end

return entity
