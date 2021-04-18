-----------------------------------
-- Area: Windurst Waters
--  NPC: Tosuka-Porika
-- Starts Quests: Early Bird Catches the Bookworm, Chasing Tales
-- Involved in Quests: Hat in Hand, Past Reflections, Blessed Radiance
-- Involved in Missions: Windurst 2-1/7-1/8-2, CoP 3-3
-- !pos -26 -6 103 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local bookwormStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM)
    local chasingStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getMissionStatus(player:getNation())
    local windurstFame = player:getFameLevel(WINDURST)

    -- The Jester Who'd Be King (Windurst 8-2)
    if
        currentMission == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getMissionStatus(player:getNation()) == 1 and not
        player:hasKeyItem(xi.ki.OPTISTERY_RING)
    then
        player:startEvent(801, 0, xi.ki.OPTISTERY_RING)

    -- The Road Forks (CoP 3-3)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 10 then
        player:startEvent(875)

    -- The Sixth Ministry (Windurst 7-1)
    elseif currentMission == xi.mission.id.windurst.THE_SIXTH_MINISTRY then
        if missionStatus == 0 then
            player:startEvent(715, 0, xi.ki.OPTISTERY_RING)
        elseif missionStatus == 1 then
            player:startEvent(716, 0, xi.ki.OPTISTERY_RING)
        elseif missionStatus == 2 then
            player:startEvent(724)
        end

    -- Lost for Words (Windurst 2-1)
    elseif currentMission == xi.mission.id.windurst.LOST_FOR_WORDS then
        if missionStatus == 0 then
            player:startEvent(160) -- Beginning CS for Mission 2-1
        elseif missionStatus > 0 and missionStatus < 6 then
            player:startEvent(161) -- Additional dialogue for 2-1
        elseif (missionStatus == 6) then
            player:startEvent(168) -- Finish Mission 2-1
        end

    -- Hat in Hand
    elseif player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and not utils.mask.getBit(player:getCharVar("QuestHatInHand_var"), 5) then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(55)

    -- Early Bird Catches the Bookworm
    elseif
        bookwormStatus == QUEST_AVAILABLE and
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER) == QUEST_COMPLETED and
        windurstFame >= 2 and
        player:needToZone() == false
    then
        player:startEvent(387) -- Start quest "Early Bird Catches the Bookworm"

    elseif bookwormStatus == QUEST_ACCEPTED then
        player:startEvent(388) -- During quest "Early Bird Catches the Bookworm"

    -- Chasing Tales
    elseif
        chasingStatus == QUEST_AVAILABLE and
        bookwormStatus == QUEST_COMPLETED and
        currentMission ~= xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        windurstFame >= 3 and
        player:needToZone() == false
    then
        player:startEvent(403) -- Start quest "Chasing Tales"

    elseif chasingStatus == QUEST_ACCEPTED and player:getCharVar("CHASING_TALES_TRACK_BOOK") == 0 then
        player:startEvent(406) -- CS immediately after accepting quest (Points player to Furakku-Norakku)
    elseif chasingStatus == QUEST_ACCEPTED then
        player:startEvent(412) -- CS after talking to Furakku-Norakku

    -- Standard dialogues
    elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) then
        player:startEvent(380) -- "Thanks to some adventurer somewhere, I was able to awaken from an inescapable nightmare."
    elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_SIXTH_MINISTRY) then
        player:startEvent(379) -- "Hey, you're the adventurer from the other day!"
    elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.LOST_FOR_WORDS) then
        player:startEvent(169) -- "You must not frighten the others with rumors that the Book of the Gods has gone blank..."
    elseif player:getLocalVar("TosukaDialogueToggle") == 1 then
        player:startEvent(881) -- He toggles this event with 370 when player has no other mission/quest dialogue.
        player:setLocalVar("TosukaDialogueToggle", 0)
    else
        player:startEvent(370) -- "It doesn't seem like you'd have any business with our distinguished Library of Magic..."
        player:setLocalVar("TosukaDialogueToggle", 1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- The Road Forks (CoP 3-3)
    if csid == 875 then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 11)

    -- The Jester Who'd Be King (Windurst 8-2)
    elseif csid == 801 and npcUtil.giveKeyItem(player, xi.ki.OPTISTERY_RING) then
        if player:hasKeyItem(xi.ki.RHINOSTERY_RING) and player:hasKeyItem(xi.ki.AURASTERY_RING) then
            player:setMissionStatus(player:getNation(), 2)
        end

    -- The Sixth Ministry (Windurst 7-1)
    elseif csid == 715 and npcUtil.giveKeyItem(player, xi.ki.OPTISTERY_RING) then
        player:setMissionStatus(player:getNation(), 1)
    elseif csid == 724 then
        finishMissionTimeline(player, 3, csid, option)

    -- Lost for Words (Windurst 2-1)
    elseif csid == 160 then
        player:setMissionStatus(player:getNation(), 1)
    elseif csid == 168 then
        finishMissionTimeline(player, 1, csid, option)

    -- Hat in Hand
    elseif csid == 55 then  -- Show Off Hat
        player:setCharVar("QuestHatInHand_var", utils.mask.setBit(player:getCharVar("QuestHatInHand_var"), 5, true))
        player:addCharVar("QuestHatInHand_count", 1)

    -- Early Bird Catches the Bookworm
    elseif csid == 387 and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM)

    -- Chasing Tales
    elseif csid == 403 and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)
    end
end

return entity
