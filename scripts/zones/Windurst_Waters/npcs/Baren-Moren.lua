-----------------------------------
-- Area: Windurst Waters
--  NPC: Baren-Moren
-- Starts and Finishes Quest: Hat in Hand
-- !pos -66 -3 -148 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local aFeatherInOnesCap = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_FEATHER_IN_ONES_CAP)

    if
        (aFeatherInOnesCap == xi.questStatus.QUEST_ACCEPTED or
        player:getCharVar('QuestFeatherInOnesCap_var') == 1) and
        npcUtil.tradeHas(trade, { { 842, 3 } })
    then
        player:startEvent(79, 1500) -- Quest Turn In
    end
end

entity.onTrigger = function(player, npc)
    local hatInHand = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.HAT_IN_HAND)
    local aFeatherInOnesCap = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_FEATHER_IN_ONES_CAP)
    local pfame = player:getFameLevel(xi.fameArea.WINDURST)

    if hatInHand == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(48) -- Quest Offered
    elseif player:hasKeyItem(xi.ki.NEW_MODEL_HAT) then
        local count = player:getCharVar('QuestHatInHand_count')

        if count >= 8 then
            player:startEvent(52, 80) -- 80 = HAT + FULL REWARD = 8 NPCS
            player:setLocalVar('hatRewardTier', 5)
        elseif count >= 6 then
            player:startEvent(52, 50) -- 50 = HAT + GOOD REWARD >= 6-7 NPCS
            player:setLocalVar('hatRewardTier', 4)
        elseif count >= 4 then
            player:startEvent(52, 30) -- 30 = PARTIAL REWARD >= 4-5 NPCS
            player:setLocalVar('hatRewardTier', 3)
        elseif count >= 2 then
            player:startEvent(52, 20) -- 20 = POOR REWARD >= 2-3 NPCS
            player:setLocalVar('hatRewardTier', 2)
        else
            player:startEvent(52) -- 0 = NO REWARD >= 0-1 NPCS
            player:setLocalVar('hatRewardTier', 1)
        end
    elseif
        hatInHand == xi.questStatus.QUEST_COMPLETED and
        aFeatherInOnesCap == xi.questStatus.QUEST_AVAILABLE and
        pfame >= 3 and
        not player:needToZone()
    then
        player:startEvent(75, 0, 842) -- Quest 'Feather In One's Cap' offered
    elseif
        aFeatherInOnesCap == xi.questStatus.QUEST_ACCEPTED or
        player:getCharVar('QuestFeatherInOnesCap_var') == 1
    then
        player:startEvent(78, 0, 842) -- Quest Objective Reminder
    elseif
        aFeatherInOnesCap == xi.questStatus.QUEST_COMPLETED and
        not player:needToZone()
    then
        player:startEvent(75, 0, 842) -- Repeatable Quest 'A Feather In One's Cap' offered

    -- default dialog
    else
        local rand = math.random(1, 6)

        if rand == 1 then
            player:startEvent(42) -- Standard Conversation 1
        elseif rand == 2 then
            player:startEvent(44) -- Standard Conversation 2
        elseif rand == 3 then
            player:startEvent(45) -- Standard Conversation 3
        elseif rand == 4 then
            player:startEvent(46) -- Standard Conversation 4
        elseif rand == 5 then
            player:startEvent(47) -- Standard Conversation 5
        elseif rand == 6 then
            player:startEvent(1022) -- Standard Conversation 6
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local aFeatherInOnesCap = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_FEATHER_IN_ONES_CAP)

    if csid == 48 and option == 1 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.HAT_IN_HAND)
        npcUtil.giveKeyItem(player, xi.ki.NEW_MODEL_HAT)
    elseif csid == 52 and option >= 1 then
        local rewardTier = player:getLocalVar('hatRewardTier')
        local rewards = { fame = 75, fameArea = xi.fameArea.WINDURST, var = { 'QuestHatInHand_var', 'QuestHatInHand_count' } }

        if rewardTier == 5 then
            rewards.gil = 500
            rewards.item = 12543
        elseif rewardTier == 4 then
            rewards.gil = 400
            rewards.item = 12543
        elseif rewardTier == 3 then
            rewards.gil = 300
        elseif rewardTier == 2 then
            rewards.gil = 150
        elseif rewardTier == 1 then
            rewards.gil = 300
        end

        if npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.HAT_IN_HAND, rewards) then
            player:delKeyItem(xi.ki.NEW_MODEL_HAT)
            player:needToZone(true)
        end
    elseif csid == 75 and option == 1 then
        if aFeatherInOnesCap == xi.questStatus.QUEST_AVAILABLE then
            player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_FEATHER_IN_ONES_CAP)
        elseif aFeatherInOnesCap == xi.questStatus.QUEST_COMPLETED then
            player:setCharVar('QuestFeatherInOnesCap_var', 1)
        end
    elseif csid == 79 then
        if aFeatherInOnesCap == xi.questStatus.QUEST_ACCEPTED then
            npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.A_FEATHER_IN_ONES_CAP, { fame = 75, fameArea = xi.fameArea.WINDURST })
        else
            player:addFame(xi.fameArea.WINDURST, 8)
            player:setCharVar('QuestFeatherInOnesCap_var', 0)
        end

        player:addGil(xi.settings.main.GIL_RATE * 1500)
        player:confirmTrade()
        player:needToZone(true)
    end
end

return entity
