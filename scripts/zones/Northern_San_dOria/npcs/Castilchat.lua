-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Castilchat
-- Starts Quest: Trial Size Trial by Ice
-- !pos -186 0 107 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/teleports")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    if
        trade:hasItemQty(1545, 1) and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE) == QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN and
        count == 1
    then -- Trade mini fork of ice
        player:startEvent(734, 0, 1545, 4, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeByIce = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeByIce == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2
    then -- Requires player to be Summoner at least lvl 20
        player:startEvent(733, 0, 1545, 4, 20)     --mini tuning fork of ice, zone, level
    elseif trialSizeByIce == QUEST_ACCEPTED then
        local iceFork = player:hasItem(1545)

        if iceFork then
            player:startEvent(708) --Dialogue given to remind player to be prepared
        else
            player:startEvent(737, 0, 1545, 4, 20) -- Need another mini tuning fork
        end
    elseif trialSizeByIce == QUEST_COMPLETED then
        player:startEvent(736) -- Defeated Avatar
    else
        player:startEvent(711) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 733 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1545)
        else
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE)
            player:addItem(1545)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1545)
        end
    elseif csid == 734 and option == 0 or csid == 737 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1545)
        else
            player:addItem(1545)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1545)
        end
    elseif csid == 734 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_FROST)
    end
end

return entity
