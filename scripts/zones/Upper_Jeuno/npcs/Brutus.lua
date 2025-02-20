-----------------------------------
-- Area: Upper Jeuno
--  NPC: Brutus
-- Starts Quest: Chocobo's Wounds, Save My Son, Path of the Beastmaster, Wings of gold, Scattered into Shadow, Chocobo on the Loose!
-- !pos -55 8 95 244
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wingsOfGold = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
    local scatteredIntoShadow = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
    local scatteredIntoShadowStat = player:getCharVar('scatIntoShadowCS')

    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    -- SCATTERED INTO SHADOW
    if
        wingsOfGold == xi.questStatus.QUEST_COMPLETED and
        scatteredIntoShadow == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.BST and
        mLvl >= xi.settings.main.AF2_QUEST_LEVEL
    then
        if player:getCharVar('scatIntoShadow_shortCS') == 1 then
            player:startEvent(143)
        else
            player:setCharVar('scatIntoShadow_shortCS', 1)
            player:startEvent(141)
        end
    elseif scatteredIntoShadow == xi.questStatus.QUEST_ACCEPTED then
        if
            player:hasKeyItem(xi.ki.AQUAFLORA1) or
            player:hasKeyItem(xi.ki.AQUAFLORA2) or
            player:hasKeyItem(xi.ki.AQUAFLORA3)
        then
            player:startEvent(142)
        elseif scatteredIntoShadowStat == 0 then
            player:startEvent(144)
        elseif scatteredIntoShadowStat == 1 then
            player:startEvent(149)
        elseif scatteredIntoShadowStat == 2 then
            player:startEvent(135)
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
    -- SCATTERED INTO SHADOW
    if (csid == 141 or csid == 143) and option == 1 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
        player:setCharVar('scatIntoShadow_shortCS', 0)
        npcUtil.giveKeyItem(player, { xi.ki.AQUAFLORA1, xi.ki.AQUAFLORA2, xi.ki.AQUAFLORA3 })
    elseif csid == 144 then
        player:setCharVar('scatIntoShadowCS', 1)
    elseif csid == 135 then
        npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW, { item = 14097, fame = 40, var = 'scatIntoShadowCS' })
    end
end

return entity
