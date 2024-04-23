-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Taumila
-- Starts and Finishes Quest: Tiger's Teeth (R)
-- !pos -140 -5 -8 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH) ~= xi.questStatus.QUEST_AVAILABLE then
        if
            trade:hasItemQty(xi.item.BLACK_TIGER_FANG, 3) and
            trade:getItemCount() == 3
        then
            player:startEvent(572)
        end
    end
end

entity.onTrigger = function(player, npc)
    local tigersTeeth = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH)

    if
        player:getFameLevel(xi.fameArea.SANDORIA) >= 3 and
        tigersTeeth == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(574)
    elseif tigersTeeth == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(575)
    elseif tigersTeeth == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(573)
    else
        player:startEvent(571)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 574 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH)
    elseif csid == 572 then
        player:tradeComplete()
        player:addTitle(xi.title.FANG_FINDER)
        npcUtil.giveCurrency(player, 'gil', 2100)
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH) == xi.questStatus.QUEST_ACCEPTED then
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TIGER_S_TEETH)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end
    end
end

return entity
