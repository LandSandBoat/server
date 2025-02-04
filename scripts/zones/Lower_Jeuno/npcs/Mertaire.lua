-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Mertaire
-- Starts and Finishes Quest: The Old Monument (start only), A Minstrel in Despair, Painful Memory (BARD AF1)
-- !pos -17 0 -61 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local painfulMemory  = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)
    local circleOfTime   = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local job            = player:getMainJob()
    local level          = player:getMainLvl()

    -- PAINFUL MEMORY (Bard AF1)
    if
        painfulMemory == xi.questStatus.QUEST_AVAILABLE and
        job == xi.job.BRD and
        level >= xi.settings.main.AF1_QUEST_LEVEL
    then
        if player:getCharVar('PainfulMemoryCS') == 0 then
            player:startEvent(138) -- Long dialog for 'Painful Memory'
        else
            player:startEvent(137) -- Short dialog for 'Painful Memory'
        end

    elseif painfulMemory == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(136) -- During Quest 'Painful Memory'

    -- CIRCLE OF TIME (Bard AF3)
    elseif
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == xi.questStatus.QUEST_COMPLETED and
        circleOfTime == xi.questStatus.QUEST_AVAILABLE and
        job == xi.job.BRD and
        level >= xi.settings.main.AF3_QUEST_LEVEL
    then
        player:startEvent(139) -- Start "The Circle of Time"

    elseif circleOfTime == xi.questStatus.QUEST_ACCEPTED then
        player:messageSpecial(ID.text.MERTAIRE_RING)

    -- DEFAULT DIALOG
    elseif painfulMemory == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(135) -- Standard dialog after completed "Painful Memory"

    else
        player:messageSpecial(ID.text.MERTAIRE_DEFAULT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- PAINFUL MEMORY (Bard AF1)
    if csid == 138 and option == 0 then
        player:setCharVar('PainfulMemoryCS', 1) -- player declined quest

    elseif
        (csid == 137 or csid == 138) and
        option == 1
    then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)
        player:setCharVar('PainfulMemoryCS', 0)
        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)

    -- CIRCLE OF TIME (Bard AF3)
    elseif csid == 139 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
        player:setCharVar('circleTime', 1)
    end
end

return entity
