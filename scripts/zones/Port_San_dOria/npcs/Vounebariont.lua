-----------------------------------
-- Area: Port San d'Oria
--  NPC: Vounebariont
-- Starts and Finishes Quest: Thick Shells
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS) ~= xi.questStatus.QUEST_AVAILABLE then
        if
            trade:hasItemQty(xi.item.BEETLE_SHELL, 5) and
            trade:getItemCount() == 5
        then
            player:startEvent(514)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getFameLevel(xi.fameArea.SANDORIA) >= 2 then
        player:startEvent(516)
    else
        player:startEvent(568)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 516 then
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS) == xi.questStatus.QUEST_AVAILABLE then
            player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS)
        end
    elseif csid == 514 then
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS) == xi.questStatus.QUEST_ACCEPTED then
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS)
            player:addFame(xi.fameArea.SANDORIA, 30)
        else
            player:addFame(xi.fameArea.SANDORIA, 5)
        end

        player:tradeComplete()
        player:addTitle(xi.title.BUG_CATCHER)
        npcUtil.giveCurrency(player, 'gil', 750)
    end
end

return entity
