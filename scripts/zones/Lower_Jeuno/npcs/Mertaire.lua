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
    local circleOfTime   = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local job            = player:getMainJob()
    local level          = player:getMainLvl()

    -- CIRCLE OF TIME (Bard AF3)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == xi.questStatus.QUEST_COMPLETED and
        circleOfTime == xi.questStatus.QUEST_AVAILABLE and
        job == xi.job.BRD and
        level >= xi.settings.main.AF3_QUEST_LEVEL
    then
        player:startEvent(139) -- Start "The Circle of Time"

    elseif circleOfTime == xi.questStatus.QUEST_ACCEPTED then
        player:messageSpecial(ID.text.MERTAIRE_RING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CIRCLE OF TIME (Bard AF3)
    if csid == 139 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
        player:setCharVar('circleTime', 1)
    end
end

return entity
