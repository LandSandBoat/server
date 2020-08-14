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
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    --print(player:getCharVar("MissionStatus"))
    local pNation = player:getNation()
    local currentMission = player:getCurrentMission(pNation)
    local WildcatSandy = player:getCharVar("WildcatSandy")
    local MissionStatus = player:getCharVar("MissionStatus")

    -- Lure of the Wildcat San d'Oria
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 16) == false) then
        player:startEvent(558)
    -- Blackmail quest
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.BLACKMAIL) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SUSPICIOUS_ENVELOPE)) then
        player:startEvent(549)
        player:setCharVar("BlackMailQuest", 1)
        player:delKeyItem(tpz.ki.SUSPICIOUS_ENVELOPE)
    -- San D'Oria Flag check
    elseif (player:getCharVar("Flagsando") == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 181)
        else
            player:setCharVar("Flagsando", 0)
            player:addItem(181)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 181)
        end
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.CONFESSIONS_OF_ROYALTY and player:hasKeyItem(tpz.ki.RAILLEFALS_LETTER)) then
        player:startEvent(564)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.EASTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(565)
    elseif (pNation == tpz.nation.SANDORIA) then
        -- Mission San D'Oria 9-2 The Heir to the Light
        if (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT)) then
            player:startEvent(31)
        elseif (currentMission == tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and MissionStatus == 7) then
            player:startEvent(9)
        elseif (currentMission == tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and MissionStatus == 6) then
            player:startEvent(30)
        elseif (currentMission == tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and MissionStatus >= 2 and MissionStatus <=5) then
            player:startEvent(29)
        -- Mission San d'Oria 8-1 Coming of Age --
        elseif (currentMission == tpz.mission.id.sandoria.COMING_OF_AGE and MissionStatus == 3 and player:hasKeyItem(tpz.ki.DROPS_OF_AMNIO)) then
            player:startEvent(102)
        elseif (currentMission == tpz.mission.id.sandoria.COMING_OF_AGE and MissionStatus == 1) then
            player:startEvent(58)
        -- Mission San D'Oria 6-1 Leaute's last wishes
        elseif (currentMission == tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES and MissionStatus == 3) then
            player:startEvent(22)
        elseif (currentMission == tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES and MissionStatus == 2) then
            player:startEvent(24)
        elseif (currentMission == tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES and MissionStatus == 1) then
            player:startEvent(23)
        elseif (currentMission == tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES and MissionStatus == 0) then
            player:startEvent(25)
        -- Mission San D'Oria 5-2 The Shadow Lord
        elseif (player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.THE_SHADOW_LORD) and currentMission == tpz.mission.id.sandoria.NONE) then
            player:showText(npc, ID.text.HALVER_OFFSET+500)
        elseif (currentMission == tpz.mission.id.sandoria.THE_SHADOW_LORD and MissionStatus == 5) then
            player:showText(npc, ID.text.HALVER_OFFSET+471)
        elseif (currentMission == tpz.mission.id.sandoria.THE_SHADOW_LORD and MissionStatus == 4 and player:hasKeyItem(tpz.ki.SHADOW_FRAGMENT)) then
            player:startEvent(548)
        elseif (currentMission == tpz.mission.id.sandoria.THE_SHADOW_LORD and MissionStatus == 0) then
            player:startEvent(546)
            -- Mission San D'Oria 5-1 The Ruins of Fei'Yin
        elseif (currentMission == tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and MissionStatus == 12 and player:hasKeyItem(tpz.ki.BURNT_SEAL)) then
            player:startEvent(534)
        elseif (currentMission == tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and MissionStatus == 10) then
            player:showText(npc, ID.text.HALVER_OFFSET+334)
        elseif (currentMission == tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN and MissionStatus == 9) then
            player:startEvent(533)
        -- Mission San D'Oria 3-3 Appointment to Jeuno
        elseif (currentMission == tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO and MissionStatus == 0) then
            player:startEvent(508)
        -- Mission San D'Oria 2-3 Journey Abroad
        elseif (currentMission == tpz.mission.id.sandoria.JOURNEY_ABROAD and MissionStatus == 11) then
            player:startEvent(507)
        elseif (currentMission == tpz.mission.id.sandoria.JOURNEY_ABROAD and MissionStatus == 0) then
            player:startEvent(505)
        elseif (currentMission == tpz.mission.id.sandoria.JOURNEY_ABROAD) then
            player:startEvent(532)
        end
    elseif (pNation == tpz.nation.BASTOK) then
        -- Bastok 2-3 San -> Win
        if (currentMission == tpz.mission.id.bastok.THE_EMISSARY) then
            if (MissionStatus == 3) then
                player:startEvent(501)
            end
        -- Bastok 2-3 San -> Win, report to consulate
        elseif (currentMission == tpz.mission.id.bastok.THE_EMISSARY_SANDORIA) then
            player:showText(npc, ID.text.HALVER_OFFSET+279)
        -- Bastok 2-3 Win -> San
        elseif (currentMission == tpz.mission.id.bastok.THE_EMISSARY_SANDORIA2) then
            if (MissionStatus == 8) then
                player:startEvent(503)
            elseif (MissionStatus <= 10) then
                player:showText(npc, ID.text.HALVER_OFFSET+279)
            end
        else
            player:showText(npc, ID.text.HALVER_OFFSET+1092)
        end
    elseif (pNation == tpz.nation.WINDURST) then
        -- Windurst 2-3
        if (currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS and MissionStatus < 3) then
            player:startEvent(532)
        elseif (currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA or currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2) then
            if (MissionStatus == 3) then
                player:startEvent(502)
            elseif (MissionStatus == 8) then
                player:startEvent(504)
            else
                player:showText(npc, ID.text.HALVER_OFFSET+279)
            end
        end

    else
        player:showText(npc, ID.text.HALVER_OFFSET+1092)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 501) then
        player:addMission(BASTOK, tpz.mission.id.bastok.THE_EMISSARY_SANDORIA)
        player:setCharVar("MissionStatus", 4)
    elseif (csid == 503) then
        player:setCharVar("MissionStatus", 9)
    elseif (csid == 508) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 505) then
        player:setCharVar("MissionStatus", 2)
        player:addKeyItem(tpz.ki.LETTER_TO_THE_CONSULS_SANDORIA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_TO_THE_CONSULS_SANDORIA)
    elseif (csid == 502) then
        player:setCharVar("MissionStatus", 4)
    elseif (csid == 558) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 16, true)
    elseif (csid == 504) then
        player:setCharVar("MissionStatus", 9)
    elseif (csid == 546) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 507 or csid == 534 or csid == 548) then
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 533) then
        player:addKeyItem(tpz.ki.NEW_FEIYIN_SEAL)
        player:setCharVar("MissionStatus", 10)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.NEW_FEIYIN_SEAL)
    elseif (csid == 25) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 22) then
        player:setCharVar("MissionStatus", 4)
    elseif (csid == 9) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 181)
            player:setCharVar("Flagsando", 1)
        else
            player:addItem(181)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 181)
        end
        player:setCharVar("MissionStatus", 0)
        player:completeMission(SANDORIA, tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT)
        player:setRank(10)
        player:addGil(100000)
        player:messageSpecial(ID.text.GIL_OBTAINED, 100000)
        player:setTitle(tpz.title.SAN_DORIAN_ROYAL_HEIR)
        player:setCharVar("SandoEpilogue", 1)
    elseif (csid == 58) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 102) then
        finishMissionTimeline(player, 3, csid, option)
        player:setCharVar("Wait1DayM8-1_date", os.date("%j"))
    elseif (csid == 564 and option == 1) then
        player:completeMission(TOAU, tpz.mission.id.toau.CONFESSIONS_OF_ROYALTY)
        player:addMission(TOAU, tpz.mission.id.toau.EASTERLY_WINDS)
        player:delKeyItem(tpz.ki.RAILLEFALS_LETTER)
        player:setCharVar("AhtUrganStatus", 1)
    end
end
