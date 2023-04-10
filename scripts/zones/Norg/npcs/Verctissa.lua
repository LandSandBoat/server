-----------------------------------
-- Area: Norg
--  NPC: Verctissa
-- Starts Quest: Trial Size Trial By Water
-- !pos -13 1 -20 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/teleports")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(1549, 1) and
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER) == QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(200, 0, 1549, 2, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeWater = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeWater == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.NORG) >= 2
    then
        --Requires player to be Summoner at least lvl 20
        player:startEvent(199, 0, 1549, 2, 20)     --mini tuning fork of water, zone, level
    elseif trialSizeWater == QUEST_ACCEPTED then
        local waterFork = player:hasItem(1549)

        if waterFork then
            player:startEvent(111) --Dialogue given to remind player to be prepared
        else
            player:startEvent(203, 0, 1549, 2, 20) --Need another mini tuning fork
        end
    elseif trialSizeWater == QUEST_COMPLETED then
        player:startEvent(202) --Defeated Avatar
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 199 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1549) --Mini tuning fork
        else
            player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER)
            player:addItem(1549)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1549)
        end
    elseif csid == 203 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1549) --Mini tuning fork
        else
            player:addItem(1549)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1549)
        end
    elseif csid == 200 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_TIDES)
    end
end

return entity
