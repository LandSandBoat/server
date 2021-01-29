-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Rahal
-- Involved in Quests: The Holy Crest, Lure of the Wildcat (San d'Oria)
-- !pos -28 0.1 -6 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local CrestProgress = player:getCharVar("TheHolyCrest_Event")
    local RemedyKI = player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
    local Stalker_Quest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
    local StalkerProgress = player:getCharVar("KnightStalker_Progress")
    local WildcatSandy = player:getCharVar("WildcatSandy")

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(WildcatSandy, 17)
    then
        player:startEvent(559)
    -- Need to speak with Rahal to get Dragon Curse Remedy
    elseif CrestProgress == 5 and RemedyKI == false then
        player:startEvent(60) -- Gives key item
    elseif CrestProgress == 5 and RemedyKI == true then
        player:startEvent(122) -- Reminder to go to Gelsba

    -- Completed AF2, AF3 available, and currently on DRG.  No level check, since they cleared AF2.
    elseif
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS) == QUEST_COMPLETED and
        Stalker_Quest == QUEST_AVAILABLE and player:getMainJob() == xi.job.DRG
    then
        if (player:getCharVar("KnightStalker_Declined") == 0) then
            player:startEvent(121) -- Start AF3
        else
            player:startEvent(120) -- Short version if they previously declined
        end
    elseif Stalker_Quest == QUEST_ACCEPTED then
        if StalkerProgress == 0 then
            player:startEvent(119) -- Reminder to go to Brugaire/Ceraulian
        elseif player:hasKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) then
            if StalkerProgress == 1 then
                player:startEvent(78) -- Reaction to challenge, go talk to Balasiel
            elseif StalkerProgress == 2 then
                player:startEvent(69) -- Reminder to talk to Balasiel
            elseif StalkerProgress == 3 then
                player:startEvent(110) -- To the south with you
            end
        end
    elseif player:getCharVar("KnightStalker_Option2") == 1 then
        player:startEvent(118) -- Optional CS after Knight Stalker

    -- San d'Oria Rank 10 Epilogue (optional)
    elseif player:getCharVar("SandoEpilogue") == 1 then
        player:startEvent(41)

    -- San d'Oria Missions
    elseif player:getNation() == xi.nation.SANDORIA and player:getRank() ~= 10 then
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San d'Oria 9-2 "The Heir to the Light" (optional)
        if currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus > 1 then
            if missionStatus > 4 then
                player:startEvent(40)
            else
                player:startEvent(39)
            end

        -- San d'Oria 9-1 "Breaking Barrier" (optional)
        elseif
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.BREAKING_BARRIERS) and
            currentMission ~= sandyMissions.THE_HEIR_TO_THE_LIGHT
        then
            player:startEvent(37)

        -- San d'Oria 8-2 "Lightbringer"
        elseif
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.LIGHTBRINGER) and
            player:getRank() == 9 and player:getRankPoints() == 0
        then
            player:startEvent(42) -- (optional)
        elseif currentMission == sandyMissions.LIGHTBRINGER then
            if missionStatus == 1 then
                player:startEvent(106)
            elseif missionStatus == 2 then
                player:startEvent(107)
            elseif missionStatus == 6 then
                player:startEvent(105) -- (optional)
            end

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        elseif
            -- Directly after winning BCNM and up until next mission
            currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 4 or
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.THE_SHADOW_LORD) and player:getRank() == 6 and
            (currentMission ~= sandyMissions.LEAUTE_S_LAST_WISHES or currentMission ~= sandyMissions.RANPERRE_S_FINAL_REST)
        then
            player:startEvent(77)

        -- San d'Oria 5-1 "The Ruins of Fei'Yin" (optional)
        elseif
            player:hasCompletedMission(xi.mission.log_id.SANDORIA, sandyMissions.THE_RUINS_OF_FEI_YIN) and player:getRank() == 5 and
            currentMission ~= sandyMissions.THE_SHADOW_LORD
        then
            player:startEvent(544)

        -- Default dialogue
        else
            player:startEvent(529)
        end
    else
        player:startEvent(529)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 60) then
        player:addKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DRAGON_CURSE_REMEDY)
    elseif (csid == 559) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 17, true))
    elseif (csid == 121) then
        if (option == 1) then
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
        else
            player:setCharVar("KnightStalker_Declined", 1)
        end
    elseif (csid == 120 and option == 1) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
        player:setCharVar("KnightStalker_Declined", 0)
    elseif (csid == 78) then
        player:setCharVar("KnightStalker_Progress", 2)
    elseif (csid == 110) then
        player:setCharVar("KnightStalker_Progress", 4)
    elseif (csid == 118) then
        player:setCharVar("KnightStalker_Option2", 0)
    elseif (csid == 106) then
        if (player:hasKeyItem(xi.ki.CRYSTAL_DOWSER)) then
            player:delKeyItem(xi.ki.CRYSTAL_DOWSER) -- To prevent them getting a message about already having the keyitem
        else
            player:setMissionStatus(player:getNation(), 2)
            player:addKeyItem(xi.ki.CRYSTAL_DOWSER)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CRYSTAL_DOWSER)
        end
    end
end

return entity
