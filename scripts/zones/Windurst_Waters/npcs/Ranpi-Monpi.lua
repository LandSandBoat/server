-----------------------------------
-- Area: Windurst Waters
--  NPC: Ranpi-Monpi
-- Starts and Finishes Quest: A Crisis in the Making
-- Involved in quest: In a Stew, For Want of a Pot, The Dawn of Delectability
-- !pos -116 -3 52  238
-- (outside the shop he is in)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local crisisstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_CRISIS_IN_THE_MAKING)

    -- A Crisis in the Making
    if
        crisisstatus == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 2 and
        not player:needToZone()
    then
        -- A Crisis in the Making + ITEM: Quest Offer
        player:startEvent(258, 0, 625)
    elseif crisisstatus == xi.questStatus.QUEST_ACCEPTED then
        local prog = player:getCharVar('QuestCrisisMaking_var')
        if prog == 1 then -- A Crisis in the Making: Quest Objective Reminder
            player:startEvent(262, 0, 625)
        elseif prog == 2 then -- A Crisis in the Making: Quest Finish
            player:startEvent(267)
        end
    elseif
        crisisstatus == xi.questStatus.QUEST_COMPLETED and
        not player:needToZone() and
        player:getCharVar('QuestCrisisMaking_var') == 0
    then
        -- A Crisis in the Making + ITEM: Repeatable Quest Offer
        player:startEvent(259, 0, 625)
    elseif
        crisisstatus == xi.questStatus.QUEST_COMPLETED and
        player:getCharVar('QuestCrisisMaking_var') == 1
    then
        -- A Crisis in the Making: Quest Objective Reminder
        player:startEvent(262, 0, 625)
    elseif
        crisisstatus == xi.questStatus.QUEST_COMPLETED and
        player:getCharVar('QuestCrisisMaking_var') == 2
    then
        -- A Crisis in the Making: Repeatable Quest Finish
        player:startEvent(268)
    else
    --Standard dialogs
        local rand = math.random(1, 3)
        if rand == 1 then  -- STANDARD CONVO: sings song about ingredients
            player:startEvent(249)
        elseif rand == 2 then   -- STANDARD CONVO 2: sings song about ingredients
            player:startEvent(251)
        elseif rand == 3 then   -- STANDARD CONVO 3:
            player:startEvent(256)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- A Crisis in the Making
    if csid == 258 and option == 1 then  -- A Crisis in the Making + ITEM: Quest Offer - ACCEPTED
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
        player:setCharVar('QuestCrisisMaking_var', 1)
        player:needToZone(true)
    elseif csid == 258 and option == 2 then  -- A Crisis in the Making + ITEM: Quest Offer - REFUSED
        player:needToZone(true)
    elseif csid == 259 and option == 1 then  -- A Crisis in the Making + ITEM: Repeatable Quest Offer - ACCEPTED
        player:setCharVar('QuestCrisisMaking_var', 1)
        player:needToZone(true)
    elseif csid == 259 and option == 2 then  -- A Crisis in the Making + ITEM: Repeatable Quest Offer - REFUSED
        player:needToZone(true)
    elseif csid == 267 then -- A Crisis in the Making: Quest Finish
        npcUtil.giveCurrency(player, 'gil', 400)
        player:setCharVar('QuestCrisisMaking_var', 0)
        player:delKeyItem(xi.ki.OFF_OFFERING)
        player:addFame(xi.fameArea.WINDURST, 75)
        player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
        player:needToZone(true)
    elseif csid == 268 then -- A Crisis in the Making: Repeatable Quest Finish
        npcUtil.giveCurrency(player, 'gil', 400)
        player:setCharVar('QuestCrisisMaking_var', 0)
        player:delKeyItem(xi.ki.OFF_OFFERING)
        player:addFame(xi.fameArea.WINDURST, 8)
        player:needToZone(true)
    end
end

return entity
