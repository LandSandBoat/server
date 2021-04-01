-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Parvipon
-- Starts and Finishes Quest: The Merchant's Bidding (R)
-- !pos -169 -1 13 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MERCHANT_S_BIDDING) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(856, 3) and trade:getItemCount() == 3) then
            player:startEvent(89)
        end
    end
end

entity.onTrigger = function(player, npc)

TheMerchantsBidding = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MERCHANT_S_BIDDING)

    if (TheMerchantsBidding == QUEST_AVAILABLE) then
        player:startEvent(90)
    else
        player:startEvent(88)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 90 and option == 1) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MERCHANT_S_BIDDING)
    elseif (csid == 89) then
        player:tradeComplete()
        player:addGil(GIL_RATE*120)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*120)
        if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MERCHANT_S_BIDDING) == QUEST_ACCEPTED) then
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MERCHANT_S_BIDDING)
        else
            player:addFame(SANDORIA, 5)
        end
    end

end

return entity
