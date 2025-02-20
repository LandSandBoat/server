-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Legata
-- Starts and Finishes Quest: Starting a Flame (R)
-- !pos 82 0 116 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME) ~= xi.questStatus.QUEST_AVAILABLE then
        if
            trade:hasItemQty(xi.item.FLINT_STONE, 4) and
            trade:getItemCount() == 4
        then
            player:startEvent(36)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME) == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(37)
    else
        player:startEvent(35)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 37 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME)
    elseif csid == 36 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 100)
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME) == xi.questStatus.QUEST_ACCEPTED then
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end
    end
end

return entity
