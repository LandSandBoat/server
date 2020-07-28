-----------------------------------
-- Area: Rabao
--  NPC: Rahi Fohlatti
-- Starts Quest: Trial Size Trial by Wind
-- !pos -17 7 -10 247
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/teleports")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:hasItemQty(1546, 1) and player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND) == QUEST_ACCEPTED and player:getMainJob() == tpz.job.SMN) then
        player:startEvent(109, 0, 1546, 3, 20)
    end
end

function onTrigger(player, npc)
    local TrialSizeWind = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)

    if (player:getMainLvl() >= 20 and player:getMainJob() == tpz.job.SMN and TrialSizeWind == QUEST_AVAILABLE and player:getFameLevel(RABAO) >= 2) then --Requires player to be Summoner at least lvl 20
        player:startEvent(108, 0, 1546, 3, 20)     --mini tuning fork, zone, level
    elseif (TrialSizeWind == QUEST_ACCEPTED) then
        local WindFork = player:hasItem(1546)

        if (WindFork) then
            player:startEvent(68) -- Dialogue given to remind player to be prepared
        elseif (WindFork == false and tonumber(os.date("%j")) ~= player:getCharVar("TrialSizeWind_date")) then
            player:startEvent(112, 0, 1546, 3, 20) -- Need another mini tuning fork
        else
            player:startEvent(114) -- Standard dialog when you loose, and you don't wait 1 real day
        end
    elseif (TrialSizeWind == QUEST_COMPLETED) then
        player:startEvent(111) -- Defeated Avatar
    else
        player:startEvent(71) -- Standard dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 108 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1546) --Mini tuning fork
        else
            player:addQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)
            player:addItem(1546)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1546)
        end
    elseif (csid == 112 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1546) --Mini tuning fork
        else
            player:addItem(1546)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1546)
        end
    elseif (csid == 109 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.CLOISTER_OF_GALES)
    end

end
