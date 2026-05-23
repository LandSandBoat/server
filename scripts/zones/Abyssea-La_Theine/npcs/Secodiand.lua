-----------------------------------
-- Area: Abyssea-La Theine
--  NPC: Secodiand
-- Starts and Finishes Quest: Fear of the Dark III
-- !pos -489.5 -2.8 759.2 132
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FEAR_OF_THE_DARK_III) ~= xi.questStatus.QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, { { xi.item.CLIONID_WING, 3 } }) then
            player:startEvent(160)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FEAR_OF_THE_DARK_III) == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(161) -- Start quest "Fear of the Dark III"
    else
        player:startEvent(159) -- During & after completed quest "Fear of the Dark III"
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 161 and option ~= 0 then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FEAR_OF_THE_DARK_III)
    elseif csid == 160 then
        player:addCurrency('cruor', 200)
        player:printToPlayer('You received 200 cruor') --TODO implement cruor in npc_utils
        player:addFame(xi.fameArea.ABYSSEA_LATHEINE, 10) --TODO confirm retail fame amount. Reported Rank 6 w/ about 40 quest completions => around 10 fame per completion.
        player:completeQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FEAR_OF_THE_DARK_III)
        player:confirmTrade()
    end
end

return entity
