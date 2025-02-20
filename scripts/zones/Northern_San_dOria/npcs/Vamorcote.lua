-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Vamorcote
-- Starts and Finishes Quest: The Setting Sun
-- !pos -137.070 10.999 161.855 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- "The Setting Sun" conditional script
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN) == xi.questStatus.QUEST_ACCEPTED then
        if trade:hasItemQty(xi.item.ENGRAVED_KEY, 1) and trade:getItemCount() == 1 then
            player:startEvent (658)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- Look at the "The Setting Sun" quest status and San d'Oria player's fame
    local theSettingSun = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)

    if
        theSettingSun == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SANDORIA) >= 5 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) ~= xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(654, 0, xi.item.ENGRAVED_KEY, xi.item.ENGRAVED_KEY) --The quest is offered to the player.
    elseif theSettingSun == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(655, 0, 0, xi.item.ENGRAVED_KEY) --The NPC asks if the player got the key.'
    elseif theSettingSun == xi.questStatus.QUEST_COMPLETED and player:needToZone() then
        player:startEvent(659) --The quest is already done by the player and the NPC does small talks.
    else
        player:startEvent(651)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 654 and option == 1 then --Player accepts the quest
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)
    elseif csid == 658 then --The player trades the Engraved Key to the NPC. Here come the rewards!
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 10000)
        player:addFame(xi.fameArea.SANDORIA, 30)
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)
    end
end

return entity
