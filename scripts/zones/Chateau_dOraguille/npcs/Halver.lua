-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Halver
-- Involved in Mission 2-3, 3-3, 5-1, 5-2, 8-1
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 2 0.1 0.1 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    --print(player:getMissionStatus(player:getNation()))
    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)
    local WildcatSandy = player:getCharVar("WildcatSandy")
    local missionStatus = player:getMissionStatus(player:getNation())

    -- Lure of the Wildcat San d'Oria
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 16)) then
        player:startEvent(558)
    -- Blackmail quest
    elseif (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)) then
        player:startEvent(549)
        player:setCharVar("BlackMailQuest", 1)
        player:delKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
    -- San D'Oria Flag check
    elseif (player:getCharVar("Flagsando") == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 181)
        else
            player:setCharVar("Flagsando", 0)
            player:addItem(181)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 181)
        end
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.CONFESSIONS_OF_ROYALTY and player:hasKeyItem(xi.ki.RAILLEFALS_LETTER)) then
        player:startEvent(564)
    elseif (player:getCurrentMission(TOAU) == xi.mission.id.toau.EASTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(565)
    elseif (pNation == xi.nation.SANDORIA) then
        -- Rank 10 default dialogue
        if player:getRank() == 10 then
            player:startEvent(31)
        -- Mission San D'Oria 9-2 The Heir to the Light
        elseif (currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus == 7) then
            player:startEvent(9)
        elseif (currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus > 5) then
            player:startEvent(30)
        elseif (currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus > 4) then
            player:showText(npc, ID.text.HEIR_TO_LIGHT_EXTRA)
        elseif (currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus > 1) then
            player:startEvent(29)
        -- Mission San d'Oria 9-1 Lightbringer (optional)
        elseif (currentMission == xi.mission.id.sandoria.BREAKING_BARRIERS and missionStatus == 0) then
            player:startEvent(26)
        elseif (currentMission == xi.mission.id.sandoria.BREAKING_BARRIERS and missionStatus == 1) then
            player:startEvent(1)
        -- Mission San d'Oria 8-2 Lightbringer (optional)
        elseif (currentMission == xi.mission.id.sandoria.LIGHTBRINGER and missionStatus == 6) then
            player:showText(npc, ID.text.LIGHTBRINGER_EXTRA)
        -- Mission San d'Oria 8-1 Coming of Age
        elseif (currentMission == xi.mission.id.sandoria.COMING_OF_AGE and missionStatus == 3 and player:hasKeyItem(xi.ki.DROPS_OF_AMNIO)) then
            player:startEvent(102)
        elseif (currentMission == xi.mission.id.sandoria.COMING_OF_AGE and missionStatus == 1) then
            player:startEvent(58)
        -- Mission San D'Oria 6-1 Leaute's last wishes
        elseif (currentMission == xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES and missionStatus == 3) then
            player:startEvent(22)
        elseif (currentMission == xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES and missionStatus == 2) then
            player:startEvent(24)
        elseif (currentMission == xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES and missionStatus == 1) then
            player:startEvent(23)
        elseif (currentMission == xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES and missionStatus == 0) then
            player:startEvent(25)
        -- Mission San D'Oria 5-2 The Shadow Lord
        elseif (player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SHADOW_LORD) and currentMission == xi.mission.id.sandoria.NONE) then
            player:showText(npc, ID.text.HALVER_OFFSET+500)
        elseif (currentMission == xi.mission.id.sandoria.THE_SHADOW_LORD and missionStatus == 5) then
            player:showText(npc, ID.text.HALVER_OFFSET+471)
        elseif (currentMission == xi.mission.id.sandoria.THE_SHADOW_LORD and missionStatus == 4 and player:hasKeyItem(xi.ki.SHADOW_FRAGMENT)) then
            player:startEvent(548)
        elseif (currentMission == xi.mission.id.sandoria.THE_SHADOW_LORD and missionStatus == 0) then
            player:startEvent(546)
            -- Mission San D'Oria 5-1 The Ruins of Fei'Yin
        elseif (currentMission == xi.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and missionStatus == 12 and player:hasKeyItem(xi.ki.BURNT_SEAL)) then
            player:startEvent(534)
        elseif (currentMission == xi.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and missionStatus == 10) then
            player:showText(npc, ID.text.HALVER_OFFSET+334)
        elseif (currentMission == xi.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and missionStatus == 9) then
            player:startEvent(533)
        -- Mission San D'Oria 3-3 Appointment to Jeuno
        elseif (currentMission == xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO and missionStatus == 0) then
            player:startEvent(508)
        -- Mission San D'Oria 2-3 Journey Abroad
        elseif (currentMission == xi.mission.id.sandoria.JOURNEY_ABROAD and missionStatus == 11) then
            player:startEvent(507)
        elseif (currentMission == xi.mission.id.sandoria.JOURNEY_ABROAD and missionStatus == 0) then
            player:startEvent(505)
        elseif (currentMission == xi.mission.id.sandoria.JOURNEY_ABROAD) then
            player:startEvent(532)
        -- Default dialogue
        else
            player:startEvent(577)
        end
    elseif (pNation == xi.nation.BASTOK) then
        -- Bastok 2-3 San -> Win
        if (currentMission == xi.mission.id.bastok.THE_EMISSARY) then
            if (missionStatus == 3) then
                player:startEvent(501)
            end
        -- Bastok 2-3 San -> Win, report to consulate
        elseif (currentMission == xi.mission.id.bastok.THE_EMISSARY_SANDORIA) then
            player:showText(npc, ID.text.HALVER_OFFSET+279)
        -- Bastok 2-3 Win -> San
        elseif (currentMission == xi.mission.id.bastok.THE_EMISSARY_SANDORIA2) then
            if (missionStatus == 8) then
                player:startEvent(503)
            elseif (missionStatus <= 10) then
                player:showText(npc, ID.text.HALVER_OFFSET+279)
            end
        else
            player:showText(npc, ID.text.HALVER_OFFSET+1092)
        end
    elseif (pNation == xi.nation.WINDURST) then
        -- Windurst 2-3
        if (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS and missionStatus < 3) then
            player:startEvent(532)
        elseif (currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA or currentMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2) then
            if (missionStatus == 3) then
                player:startEvent(502)
            elseif (missionStatus == 8) then
                player:startEvent(504)
            else
                player:showText(npc, ID.text.HALVER_OFFSET+279)
            end
        end

    else
        player:showText(npc, ID.text.HALVER_OFFSET+1092)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 501) then
        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA)
        player:setMissionStatus(player:getNation(), 4)
    elseif (csid == 503) then
        player:setMissionStatus(player:getNation(), 9)
    elseif (csid == 508) then
        player:setMissionStatus(player:getNation(), 2)
    elseif (csid == 505) then
        player:setMissionStatus(player:getNation(), 2)
        player:addKeyItem(xi.ki.LETTER_TO_THE_CONSULS_SANDORIA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_CONSULS_SANDORIA)
    elseif (csid == 502) then
        player:setMissionStatus(player:getNation(), 4)
    elseif (csid == 558) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 16, true))
    elseif (csid == 504) then
        player:setMissionStatus(player:getNation(), 9)
    elseif (csid == 546) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 507 or csid == 534 or csid == 548) then
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 533) then
        player:addKeyItem(xi.ki.NEW_FEIYIN_SEAL)
        player:setMissionStatus(player:getNation(), 10)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.NEW_FEIYIN_SEAL)
    elseif (csid == 25) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 22) then
        player:setMissionStatus(player:getNation(), 4)
    elseif (csid == 9) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 181)
            player:setCharVar("Flagsando", 1)
        else
            player:addItem(181)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 181)
        end
        player:setMissionStatus(player:getNation(), 0)
        player:completeMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT)
        player:setRank(10)
        player:addGil(100000)
        player:messageSpecial(ID.text.GIL_OBTAINED, 100000)
        player:setTitle(xi.title.SAN_DORIAN_ROYAL_HEIR)
        player:setCharVar("SandoEpilogue", 1)
    elseif (csid == 58) then
        player:setMissionStatus(player:getNation(), 2)
    elseif (csid == 102) then
        finishMissionTimeline(player, 3, csid, option)
        player:setCharVar("Wait1DayM8-1_date", os.time() + 60)
    elseif (csid == 564 and option == 1) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.EASTERLY_WINDS)
        player:delKeyItem(xi.ki.RAILLEFALS_LETTER)
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return entity
