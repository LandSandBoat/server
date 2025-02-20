-----------------------------------
-- Area: Norg
--  NPC: Ryoma
-- Start and Finish Quest: 20 in Pirate Years, I'll Take the Big Box, True Will, Bugi Soden
-- !pos -23 0 -9 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local twentyInPirateYears = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
    local illTakeTheBigBox = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)
    local trueWill = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if
        twentyInPirateYears == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.NIN and
        mLvl >= 40
    then
        player:startEvent(133) -- Start Quest "20 in Pirate Years"
    elseif
        twentyInPirateYears == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.TRICK_BOX)
    then
        player:startEvent(134) -- Finish Quest "20 in Pirate Years"
    elseif
        twentyInPirateYears == xi.questStatus.QUEST_COMPLETED and
        illTakeTheBigBox == xi.questStatus.QUEST_AVAILABLE and
        mJob == xi.job.NIN and
        mLvl >= 50 and
        not player:needToZone()
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
    if csid == 133 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
        player:setCharVar('twentyInPirateYearsCS', 1)
    elseif csid == 134 then
        if player:getFreeSlotsCount() <= 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ANJU)
        else
            player:delKeyItem(xi.ki.TRICK_BOX)
            player:addItem(xi.item.ANJU)
            player:addItem(xi.item.ZUSHIO)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ANJU) -- Anju
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ZUSHIO) -- Zushio
            player:needToZone()
            player:setCharVar('twentyInPirateYearsCS', 0)
            player:addFame(xi.fameArea.NORG, 30)
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
        end
    elseif csid == 135 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)
    elseif csid == 136 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL)
    elseif csid == 137 then
        player:setCharVar('trueWillCS', 1)
    end
end

return entity
