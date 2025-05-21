-----------------------------------
-- Area: Mhaura
--  NPC: Lacia
-- Starts Quest: Trial Size Trial By Lightning
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.MINI_TUNING_FORK_OF_LIGHTNING, 1) and
        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING) == xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(10026, 0, xi.item.MINI_TUNING_FORK_OF_LIGHTNING, 5, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeLightning = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeLightning == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 2
    then
        --Requires player to be Summoner at least lvl 20
        player:startEvent(10025, 0, xi.item.MINI_TUNING_FORK_OF_LIGHTNING, 5, 20)     --mini tuning fork of lightning, zone, level
    elseif trialSizeLightning == xi.questStatus.QUEST_ACCEPTED then
        local hasLightningFork = player:hasItem(xi.item.MINI_TUNING_FORK_OF_LIGHTNING)

        if hasLightningFork then
            player:startEvent(10018) --Dialogue given to remind player to be prepared
        else
            player:startEvent(10029, 0, xi.item.MINI_TUNING_FORK_OF_LIGHTNING, 5, 20) --Need another mini tuning fork
        end
    elseif trialSizeLightning == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(10028) --Defeated Ramuh
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10025 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MINI_TUNING_FORK_OF_LIGHTNING)
        else
            player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)
            player:addItem(xi.item.MINI_TUNING_FORK_OF_LIGHTNING)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MINI_TUNING_FORK_OF_LIGHTNING)
        end
    elseif csid == 10029 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MINI_TUNING_FORK_OF_LIGHTNING)
        else
            player:addItem(xi.item.MINI_TUNING_FORK_OF_LIGHTNING)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MINI_TUNING_FORK_OF_LIGHTNING)
        end
    elseif csid == 10026 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_STORMS)
    end
end

return entity
