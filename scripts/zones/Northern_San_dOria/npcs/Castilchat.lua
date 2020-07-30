-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Castilchat
-- Starts Quest: Trial Size Trial by Ice
-- !pos -186 0 107 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/teleports")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local count = trade:getItemCount()
    if (trade:hasItemQty(1545, 1) and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE) == QUEST_ACCEPTED and player:getMainJob() == tpz.job.SMN and count == 1) then -- Trade mini fork of ice
        player:startEvent(734, 0, 1545, 4, 20)
    end
end

function onTrigger(player, npc)

    local TrialSizeByIce = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE)

    if (player:getMainLvl() >= 20 and player:getMainJob() == tpz.job.SMN and TrialSizeByIce == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 2) then -- Requires player to be Summoner at least lvl 20
        player:startEvent(733, 0, 1545, 4, 20)     --mini tuning fork of ice, zone, level
    elseif (TrialSizeByIce == QUEST_ACCEPTED) then
        local IceFork = player:hasItem(1545)

        if (IceFork) then
            player:startEvent(708) --Dialogue given to remind player to be prepared
        elseif (IceFork == false and tonumber(os.date("%j")) ~= player:getCharVar("TrialSizeIce_date")) then
            player:startEvent(737, 0, 1545, 4, 20) -- Need another mini tuning fork
        else
            player:startEvent(758) -- Standard dialog when you loose, and you don't wait 1 real day
        end
    elseif (TrialSizeByIce == QUEST_COMPLETED) then
        player:startEvent(736) -- Defeated Avatar
    else
        player:startEvent(711) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 733 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1545)
        else
            player:setCharVar("TrialSizeIce_date", 0)
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE)
            player:addItem(1545)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1545)
        end
    elseif (csid == 734 and option == 0 or csid == 737) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1545)
        else
            player:addItem(1545)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1545)
        end
    elseif (csid == 734 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.CLOISTER_OF_FROST)
    end

end
