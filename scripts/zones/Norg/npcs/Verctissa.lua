-----------------------------------
-- Area: Norg
--  NPC: Verctissa
-- Starts Quest: Trial Size Trial By Water
-- !pos -13 1 -20 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.MINI_TUNING_FORK_OF_WATER, 1) and
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER) == xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(200, 0, xi.item.MINI_TUNING_FORK_OF_WATER, 2, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeWater = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeWater == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.NORG) >= 2
    then
        --Requires player to be Summoner at least lvl 20
        player:startEvent(199, 0, xi.item.MINI_TUNING_FORK_OF_WATER, 2, 20)     --mini tuning fork of water, zone, level
    elseif trialSizeWater == xi.questStatus.QUEST_ACCEPTED then
        local waterFork = player:hasItem(xi.item.MINI_TUNING_FORK_OF_WATER)

        if waterFork then
            player:startEvent(111) --Dialogue given to remind player to be prepared
        else
            player:startEvent(203, 0, xi.item.MINI_TUNING_FORK_OF_WATER, 2, 20) --Need another mini tuning fork
        end
    elseif trialSizeWater == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(202) --Defeated Avatar
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 199 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WATER) --Mini tuning fork
        else
            player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER)
            player:addItem(xi.item.MINI_TUNING_FORK_OF_WATER)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WATER)
        end
    elseif csid == 203 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WATER) --Mini tuning fork
        else
            player:addItem(xi.item.MINI_TUNING_FORK_OF_WATER)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WATER)
        end
    elseif csid == 200 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_TIDES)
    end
end

return entity
