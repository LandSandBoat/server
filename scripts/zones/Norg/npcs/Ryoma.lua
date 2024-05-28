-----------------------------------
-- Area: Norg
--  NPC: Ryoma
-- Start and Finish Quest: 20 in Pirate Years, I'll Take the Big Box, True Will, Bugi Soden
-- !pos -23 0 -9 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local twentyInPirateYears = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
    local illTakeTheBigBox = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)
    local trueWill = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if
        twentyInPirateYears == xi.questStatus.QUEST_COMPLETED and
        illTakeTheBigBox == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.NIN and
        mLvl >= 50 and
        player:getLocalVar('Quest[5][144]mustZone') == 0 -- temporary until i'll take the big box is converted to IF
    then
        player:startEvent(135) -- Start Quest "I'll Take the Big Box"
    elseif
        illTakeTheBigBox == xi.questStatus.QUEST_COMPLETED and
        trueWill == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(136) -- Start Quest "True Will"
    elseif
        player:hasKeyItem(xi.ki.OLD_TRICK_BOX) and
        player:getCharVar('trueWillCS') == 0
    then
        player:startEvent(137)
    elseif player:getCharVar('trueWillCS') == 1 then
        player:startEvent(138)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 135 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)
    elseif csid == 136 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL)
    elseif csid == 137 then
        player:setCharVar('trueWillCS', 1)
    end
end

return entity
