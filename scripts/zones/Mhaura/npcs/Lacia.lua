-----------------------------------
-- Area: Mhaura
--  NPC: Lacia
-- Starts Quest: Trial Size Trial By Lightning
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/teleports")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(1548, 1) and
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING) == QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(10026, 0, 1548, 5, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeLightning = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeLightning == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2
    then
        --Requires player to be Summoner at least lvl 20
        player:startEvent(10025, 0, 1548, 5, 20)     --mini tuning fork of lightning, zone, level
    elseif trialSizeLightning == QUEST_ACCEPTED then
        local hasLightningFork = player:hasItem(1548)

        if hasLightningFork then
            player:startEvent(10018) --Dialogue given to remind player to be prepared
        else
            player:startEvent(10029, 0, 1548, 5, 20) --Need another mini tuning fork
        end
    elseif trialSizeLightning == QUEST_COMPLETED then
        player:startEvent(10028) --Defeated Ramuh
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10025 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1548) --Mini tuning fork
        else
            player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)
            player:addItem(1548)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1548)
        end
    elseif csid == 10029 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1548) --Mini tuning fork
        else
            player:addItem(1548)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1548)
        end
    elseif csid == 10026 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_STORMS)
    end
end

return entity
