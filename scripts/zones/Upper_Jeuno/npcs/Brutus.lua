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

    local mLvl = player:getMainLvl()

    -- STANDARD DIALOGS
    if scatteredIntoShadow == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(151)
    elseif wingsOfGold == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(134)
    elseif not player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS) then
        player:startEvent(66, mLvl)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
