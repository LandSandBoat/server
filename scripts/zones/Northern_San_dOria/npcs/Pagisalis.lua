-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pagisalis
-- Involved In Quest: Enveloped in Darkness
-- !zone 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES) == xi.questStatus.QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.LUMP_OF_BEESWAX, 2) and
            trade:getItemCount() == 2
        then
            player:startEvent(563)
        end
    end
end

entity.onTrigger = function(player, npc)
    local sanFame = player:getFameLevel(xi.fameArea.SANDORIA)
    local undyingFlames = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES)

    if sanFame >= 2 and undyingFlames == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(562)
    elseif undyingFlames == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(565)
    elseif undyingFlames == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(566)
    else
        player:startEvent(564)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 562 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES)
    elseif csid == 563 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.FRIARS_ROPE)
        else
            player:tradeComplete()
            player:addTitle(xi.title.FAITH_LIKE_A_CANDLE)
            player:addItem(xi.item.FRIARS_ROPE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.FRIARS_ROPE)
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES)
        end
    end
end

return entity
