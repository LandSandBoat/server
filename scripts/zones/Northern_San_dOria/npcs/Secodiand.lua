-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Secodiand
-- Starts and Finishes Quest: Fear of the dark
-- !pos -160 -0 137 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK) ~= xi.questStatus.QUEST_AVAILABLE then
        if trade:hasItemQty(xi.item.BAT_WING, 2) and trade:getItemCount() == 2 then
            player:startEvent(18)
        end
    end
end

entity.onTrigger = function(player, npc)
    local fearOfTheDark = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)

    if fearOfTheDark == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(19)
    else
        player:startEvent(17)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 19 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)
    elseif csid == 18 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 200)
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK) == xi.questStatus.QUEST_ACCEPTED then
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end
    end
end

return entity
