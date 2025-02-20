-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Paouala
-- Starts and Finishes Quest: Sleepless Nights
-- !pos 158 -6 17 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS) == xi.questStatus.QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.JUG_OF_MARYS_MILK, 1) and
            trade:getItemCount() == 1
        then
            player:startEvent(84)
        end
    end
end

entity.onTrigger = function(player, npc)
    local sleeplessNights = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)

    if
        player:getFameLevel(xi.fameArea.SANDORIA) >= 2 and
        sleeplessNights == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(85)
    elseif sleeplessNights == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(83)
    elseif sleeplessNights == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(81)
    else
        player:startEvent(82)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 85 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)
    elseif csid == 84 then
        player:tradeComplete()
        player:addTitle(xi.title.SHEEPS_MILK_DELIVERER)
        npcUtil.giveCurrency(player, 'gil', 5000)
        player:addFame(xi.fameArea.SANDORIA, 30)
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)
    end
end

return entity
