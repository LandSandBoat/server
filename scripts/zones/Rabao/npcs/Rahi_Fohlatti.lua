-----------------------------------
-- Area: Rabao
--  NPC: Rahi Fohlatti
-- Starts Quest: Trial Size Trial by Wind
-- !pos -17 7 -10 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.MINI_TUNING_FORK_OF_WIND, 1) and
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND) == xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(109, 0, xi.item.MINI_TUNING_FORK_OF_WIND, 3, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeWind = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeWind == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 2
    then
        --Requires player to be Summoner at least lvl 20
        player:startEvent(108, 0, xi.item.MINI_TUNING_FORK_OF_WIND, 3, 20)     --mini tuning fork, zone, level
    elseif trialSizeWind == xi.questStatus.QUEST_ACCEPTED then
        local windFork = player:hasItem(xi.item.MINI_TUNING_FORK_OF_WIND)

        if windFork then
            player:startEvent(68) -- Dialogue given to remind player to be prepared
        else
            player:startEvent(112, 0, xi.item.MINI_TUNING_FORK_OF_WIND, 3, 20) -- Need another mini tuning fork
        end
    elseif trialSizeWind == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(111) -- Defeated Avatar
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 108 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WIND) --Mini tuning fork
        else
            player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)
            player:addItem(xi.item.MINI_TUNING_FORK_OF_WIND)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WIND)
        end
    elseif csid == 112 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WIND) --Mini tuning fork
        else
            player:addItem(xi.item.MINI_TUNING_FORK_OF_WIND)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MINI_TUNING_FORK_OF_WIND)
        end
    elseif csid == 109 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_GALES)
    end
end

return entity
