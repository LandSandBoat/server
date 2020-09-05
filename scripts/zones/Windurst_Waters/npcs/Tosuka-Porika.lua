-----------------------------------
-- Area: Windurst Waters
--  NPC: Tosuka-Porika
--  Starts Quests: Early Bird Catches the Bookworm, Chasing Tales
-- Involved in Quests: Hat in Hand, Past Reflections, Blessed Radiance
--  Involved in Missions: Windurst 2-1, Windurst 7-1, Windurst 8-2, CoP 3-3
-- !pos -26 -6 103 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    -- cs notes
    -- 370 (370) = You have no mission, gtfo
    -- 379 (379) = Not sure yet (Adventurer from the other day?)
    -- 380 (380) = About the book of gods and "some adventurer"
    -- 160 (160) = 1st cutscene of Windurst Mission 2-1
    -- 161 (161) = More info on 2-1, if you talk to him right after the previous cutscene again

    local bookwormStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM)
    local glyphStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.GLYPH_HANGER)
    local chasingStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CHASING_TALES)

    local Fame = player:getFameLevel(WINDURST)

    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(801)

    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")==10) then
        player:startEvent(875) -- COP event

    -- Start Past Reflections in First -----------
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.LOST_FOR_WORDS) then
        MissionStatus = player:getCharVar("MissionStatus")
        if (MissionStatus == 0) then
            player:startEvent(160) -- First CS for Mission 2-1
        elseif (MissionStatus > 0 and MissionStatus < 6) then
            player:startEvent(161) -- During Mission 2-1
        elseif (MissionStatus == 6) then
            player:startEvent(168) -- Finish Mission 2-1
        end
    elseif (bookwormStatus == QUEST_AVAILABLE and glyphStatus == QUEST_COMPLETED and Fame >= 2 and player:needToZone() == false) then
        player:startEvent(387) -- Start Quest "Early Bird Catches the Bookworm"
    elseif (bookwormStatus == QUEST_ACCEPTED) then
        player:startEvent(388) -- During Quest "Early Bird Catches the Bookworm"
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND) == QUEST_ACCEPTED or player:getCharVar("QuestHatInHand_var2") == 1) then
        function testflag(set, flag)
            return (set % (2*flag) >= flag)
        end
        if (testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 32) == false) then
            player:startEvent(55) -- Show Off Hat
        end
    -- Book is tpz.ki.A_SONG_OF_LOVE, KeyItem ID = 126
    elseif (chasingStatus == QUEST_AVAILABLE and bookwormStatus == QUEST_COMPLETED and WindyMission ~= tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and Fame >= 3 and player:needToZone() == false) then
        player:startEvent(403) --  Add initial cutscene
    elseif (chasingStatus == QUEST_ACCEPTED and player:getCharVar("CHASING_TALES_TRACK_BOOK") > 0) then
        player:startEvent(412)
    elseif (player:hasKeyItem(tpz.ki.OVERDUE_BOOK_NOTIFICATION) ==true) then
        player:startEvent(412)
    elseif (chasingStatus == QUEST_ACCEPTED) then
        player:startEvent(406) --  Add follow up cutscene
        -- Windurst Mission 7-1 --
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_SIXTH_MINISTRY and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(715, 0, tpz.ki.OPTISTERY_RING)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_SIXTH_MINISTRY and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(716, 0, tpz.ki.OPTISTERY_RING)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_SIXTH_MINISTRY and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(724)
    else
        player:startEvent(370) -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 55) then  -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 32)
        player:addCharVar("QuestHatInHand_count", 1)
    elseif (csid == 160) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 168) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 387 and option == 0) then -- Early Bird Catches the Bookworm
        player:addQuest(WINDURST, tpz.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM)
    elseif (csid == 403 and option == 0) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.CHASING_TALES)
    elseif (csid ==875) then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 11)
    elseif (csid == 715) then
        player:addKeyItem(tpz.ki.OPTISTERY_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OPTISTERY_RING)
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 724) then
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 801) then
        player:addKeyItem(tpz.ki.OPTISTERY_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OPTISTERY_RING)
        if (player:hasKeyItem(tpz.ki.AURASTERY_RING) and player:hasKeyItem(tpz.ki.RHINOSTERY_RING)) then
            player:setCharVar("MissionStatus", 2)
        end
    end
end
