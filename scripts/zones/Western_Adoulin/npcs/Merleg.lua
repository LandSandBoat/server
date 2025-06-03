-----------------------------------
-- Area: Western Adoulin
--  NPC: Merleg
-- Starts, Involved with, and Finishes Quest: 'A Pioneers Best (Imaginary) Friend'
-- !pos 34 0 -131 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local apbif = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND)
    if apbif == xi.questStatus.QUEST_ACCEPTED then
        if player:hasStatusEffect(xi.effect.IONIS) then
            -- Finishing Quest: 'A Pioneers Best (Imaginary) Friend'
            player:startEvent(2522)
        else
            -- Dialgoue during Quest: 'A Pioneers Best (Imaginary) Friend'
            player:startEvent(2521)
        end
    elseif apbif == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(2520)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2520 then
        -- Starting Quest: 'A Pioneers Best (Imaginary) Friend'
        player:addQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND)
        if player:hasStatusEffect(xi.effect.IONIS) then
            -- Finishes quest if Ionis is already active
            player:startEvent(2522)
        end
    elseif csid == 2522 then
        -- Finishing Quest: 'A Pioneers Best (Imaginary) Friend'
        player:completeQuest(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_PIONEERS_BEST_IMAGINARY_FRIEND)
        player:addExp(500 * xi.settings.main.EXP_RATE)
        npcUtil.giveCurrency(player, 'bayld', 200)
        npcUtil.giveKeyItem(player, xi.ki.FAIL_BADGE)

        -- TODO: Verify fame value added
        player:addFame(xi.fameArea.ADOULIN, 30)
    end
end

return entity
