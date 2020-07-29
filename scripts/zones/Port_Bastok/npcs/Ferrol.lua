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

function onTrade(player, npc, trade)

    if (trade:hasItemQty(1547, 1) and player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH) == QUEST_ACCEPTED and player:getMainJob() == tpz.job.SMN) then
        player:startEvent(298, 0, 1547, 1, 20)
    end

end

function onTrigger(player, npc)

    local TrialSizeEarth = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)

    if (player:getMainLvl() >= 20 and player:getMainJob() == tpz.job.SMN and TrialSizeEarth == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 2) then -- Requires player to be Summoner at least lvl 20
        player:startEvent(297, 0, 1547, 1, 20)     --mini tuning fork, zone, level
    elseif (TrialSizeEarth == QUEST_ACCEPTED) then
        local EarthFork = player:hasItem(1547)

        if (EarthFork) then
            player:startEvent(251) -- Dialogue given to remind player to be prepared
        elseif (EarthFork == false and tonumber(os.date("%j")) ~= player:getCharVar("TrialSizeEarth_date")) then
            player:startEvent(301, 0, 1547, 1, 20) -- Need another mini tuning fork
        else
            player:startEvent(303) -- Standard dialog when you loose, and you don't wait 1 real day
        end
    elseif (TrialSizeEarth == QUEST_COMPLETED) then
        player:startEvent(300) -- Defeated Avatar
    else
        player:startEvent(254) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 297 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1547) --Mini tuning fork
        else
            player:setCharVar("TrialSizeEarth_date", 0)
            player:addQuest(BASTOK, tpz.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)
            player:addItem(1547)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1547)
        end
    elseif (csid == 301 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1547) --Mini tuning fork
        else
            player:addItem(1547)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1547)
        end
    elseif (csid == 298 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.CLOISTER_OF_TREMORS)
    end

end
