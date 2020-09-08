-----------------------------------
-- Area: Metalworks
--  NPC: Iron Eater
-- Involved in Missions
-- Starts and Finishes; The Weight of Your Limits
-- !pos 92.936 -19.532 1.814 237
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

local wsQuest = tpz.wsquest.steel_cyclone

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local currentMission = player:getCurrentMission(BASTOK)
    local missionStatus = player:getCharVar("MissionStatus")

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (currentMission == tpz.mission.id.bastok.THE_FOUR_MUSKETEERS and missionStatus == 0) then -- Four Musketeers
        player:startEvent(715)
    elseif (currentMission == tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(780)
    elseif (currentMission == tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(782)
    elseif (player:getCharVar("Flagbastok") == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 182)
        else
            player:setCharVar("Flagbastok", 0)
            player:addItem(182)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 182)
        end
    elseif (currentMission == tpz.mission.id.bastok.THE_FOUR_MUSKETEERS and missionStatus == 1) then
        player:startEvent(716)
    elseif (currentMission == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US and missionStatus == 0) then
        player:startEvent(767) -- First cutscene of mission
    elseif (currentMission == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US) and (missionStatus == 2) then
        player:showText(npc, 8596) -- Dialogue after first cutscene
    elseif (currentMission == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US) and (missionStatus == 3) then
        player:startEvent(768) -- Cutscene on return from Quicksand Caves
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED) then
        if (player:getCharVar("FiresOfDiscProg") == 1) then
            player:startEvent(956)
        else
            player:startEvent(957)
        end
    else
        player:startEvent(604)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 715 and option == 0) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 780) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 767 and option == 0) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 768) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 782) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 182)
            player:setCharVar("Flagbastok", 1)
        else
            player:addItem(182)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 182)
        end
        player:setCharVar("MissionStatus", 0)
        player:completeMission(BASTOK, tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE)
        player:setRank(10)
        player:addGil(GIL_RATE*100000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*100000)
        player:setTitle(tpz.title.HERO_AMONG_HEROES)
    elseif (csid == 956) then
        player:setCharVar("FiresOfDiscProg", 2)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.STEEL_CYCLONE_LEARNED)
    end
end
