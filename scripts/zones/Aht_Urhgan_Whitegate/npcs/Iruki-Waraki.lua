-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Iruki-Waraki
--  Involved in quest: No Strings Attached
-- !pos 101.329 -6.999 -29.042 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { xi.item.FLASK_OF_SLEEPING_POTION, xi.item.CUP_OF_CHAI }) and
        player:getCharVar('OperationTeaTimeProgress') == 1
    then
        -- Chai, Sleeping Potion
        player:startEvent(780)
    end
end

entity.onTrigger = function(player, npc)
    local noStringsAttached = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED)
    local theWaywardAutomaton = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    local theWaywardAutomatonProgress = player:getCharVar('TheWaywardAutomatonProgress')
    local operationTeaTime = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME)
    local operationTeaTimeProgress = player:getCharVar('OperationTeaTimeProgress')
    local playerLvl = player:getMainLvl()
    local playerJob = player:getMainJob()

    --Quest: The Wayward Automaton
    if
        playerJob == xi.job.PUP and
        playerLvl >= xi.settings.main.AF1_QUEST_LEVEL and
        noStringsAttached == xi.questStatus.QUEST_COMPLETED and
        theWaywardAutomaton == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(774) -- he tells you to help find his auto
    elseif
        theWaywardAutomaton == xi.questStatus.QUEST_ACCEPTED and
        theWaywardAutomatonProgress == 1
    then
        player:startEvent(775) -- reminder about to head to Nashmau
    elseif
        theWaywardAutomaton == xi.questStatus.QUEST_ACCEPTED and
        theWaywardAutomatonProgress == 3
    then
        player:startEvent(776) -- tell him you found Automaton
    elseif
        playerJob == xi.job.PUP and
        playerLvl < xi.settings.main.AF2_QUEST_LEVEL and
        theWaywardAutomaton == xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(777)
    elseif
        playerJob ~= xi.job.PUP and
        theWaywardAutomaton == xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(777)
    elseif
        playerJob ~= xi.job.PUP and
        noStringsAttached == xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(267) -- asking you how are you doing with your automaton

    --Quest: Operation teatime
    elseif
        playerJob == xi.job.PUP and
        playerLvl >= xi.settings.main.AF2_QUEST_LEVEL and
        noStringsAttached == xi.questStatus.QUEST_COMPLETED and
        theWaywardAutomaton == xi.questStatus.QUEST_COMPLETED and
        operationTeaTime == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(778)
    elseif
        operationTeaTime == xi.questStatus.QUEST_ACCEPTED and
        operationTeaTimeProgress == 1
    then
        player:startEvent(779) -- Reminds you to get items
    elseif
        operationTeaTime == xi.questStatus.QUEST_ACCEPTED and
        operationTeaTimeProgress == 2
    then
        player:startEvent(781) -- Reminds you to get items
    elseif operationTeaTime == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(777)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 774 then
        player:setCharVar('TheWaywardAutomatonProgress', 1)
        player:addQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    elseif csid == 776 then
        npcUtil.completeQuest(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON, { item = xi.item.TURBO_ANIMATOR, var = 'TheWaywardAutomatonProgress' })
    elseif csid == 778 then
        player:setCharVar('OperationTeaTimeProgress', 1)
        player:addQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME)
    elseif csid == 780 then
        player:setCharVar('OperationTeaTimeProgress', 2)
        player:confirmTrade()
    end
end

return entity
