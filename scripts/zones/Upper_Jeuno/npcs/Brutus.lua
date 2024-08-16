-----------------------------------
-- Area: Upper Jeuno
--  NPC: Brutus
-- Starts Quest: Chocobo's Wounds, Save My Son, Path of the Beastmaster, Wings of gold, Scattered into Shadow, Chocobo on the Loose!
-- !pos -55 8 95 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pathOfTheBeastmaster = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)
    local wingsOfGold = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
    local scatteredIntoShadow = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)

    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    -- WINGS OF GOLD
    if
        pathOfTheBeastmaster == xi.questStatus.QUEST_COMPLETED and
        wingsOfGold == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.BST and
        mLvl >= xi.settings.main.AF1_QUEST_LEVEL
    then
        if player:getCharVar('wingsOfGold_shortCS') == 1 then
            player:startEvent(137) -- Start Quest 'Wings of gold' (Short dialog)
        else
            player:setCharVar('wingsOfGold_shortCS', 1)
            player:startEvent(139) -- Start Quest 'Wings of gold' (Long dialog)
        end
    elseif wingsOfGold == xi.questStatus.QUEST_ACCEPTED then
        if not player:hasKeyItem(xi.ki.GUIDING_BELL) then
            player:startEvent(136)
        else
            player:startEvent(138) -- Finish Quest 'Wings of gold'
        end

    -- STANDARD DIALOGS
    elseif scatteredIntoShadow == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(151)
    elseif wingsOfGold == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(134)
    elseif not player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS) then
        player:startEvent(66, mLvl)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- WINGS OF GOLD
    if (csid == 137 or csid == 139) and option == 1 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
        player:setCharVar('wingsOfGold_shortCS', 0)
    elseif
        csid == 138 and
        npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD, { item = 16680, fame = 20 })
    then
        player:delKeyItem(xi.ki.GUIDING_BELL)
    end
end

return entity
