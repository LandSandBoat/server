-----------------------------------
-- Area: Port Bastok
--  NPC: Ferrol
-- Starts Quest: Trial Size Trial by Earth
-- !pos 33.708 6.499 -39.425 236
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/teleports")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(1547, 1) and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH) == QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(298, 0, 1547, 1, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeEarth = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeEarth == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2
    then
        -- Requires player to be Summoner at least lvl 20
        player:startEvent(297, 0, 1547, 1, 20)     --mini tuning fork, zone, level
    elseif trialSizeEarth == QUEST_ACCEPTED then
        local earthFork = player:hasItem(1547)

        if earthFork then
            player:startEvent(251) -- Dialogue given to remind player to be prepared
        else
            player:startEvent(301, 0, 1547, 1, 20) -- Need another mini tuning fork
        end
    elseif trialSizeEarth == QUEST_COMPLETED then
        player:startEvent(300) -- Defeated Avatar
    else
        player:startEvent(254) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 297 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1547) --Mini tuning fork
        else
            player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)
            player:addItem(1547)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1547)
        end
    elseif csid == 301 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1547) --Mini tuning fork
        else
            player:addItem(1547)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1547)
        end
    elseif csid == 298 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_TREMORS)
    end
end

return entity
