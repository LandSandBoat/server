-----------------------------------
-- Area: Chateau d'Oraguille
-- Door: Great Hall
-- Involved in Missions: 3-3, 5-2, 6-1, 8-2, 9-1
-- !pos 0 -1 13 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)


    local currentMission = player:getCurrentMission(SANDORIA)
    local MissionStatus = player:getCharVar("MissionStatus")

    -- Mission San D'Oria 9-2 The Heir to the Light
    if (currentMission == tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and MissionStatus == 5) then
        player:startEvent(8)
    -- Mission San D'Oria 9-1 Breaking Barriers
    elseif (currentMission == tpz.mission.id.sandoria.BREAKING_BARRIERS and MissionStatus == 4) then
        if (player:hasKeyItem(tpz.ki.FIGURE_OF_TITAN) and player:hasKeyItem(tpz.ki.FIGURE_OF_GARUDA) and player:hasKeyItem(tpz.ki.FIGURE_OF_LEVIATHAN)) then
            player:startEvent(76)
        end
    elseif (currentMission == tpz.mission.id.sandoria.BREAKING_BARRIERS and MissionStatus == 0) then
        player:startEvent(32)
        -- Mission San D'Oria 8-2 Lightbringer
    elseif (currentMission == tpz.mission.id.sandoria.LIGHTBRINGER and MissionStatus == 6) then
        player:startEvent(104)
    elseif (currentMission == tpz.mission.id.sandoria.LIGHTBRINGER and MissionStatus == 0) then
        player:startEvent(100)
    -- Mission San D'Oria 6-1 Leaute's Last Wishes
    elseif (currentMission == tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES and MissionStatus == 1) then
        player:startEvent(87)
    -- Mission San D'Oria 5-2 The Shadow Lord
    elseif (currentMission == tpz.mission.id.sandoria.THE_SHADOW_LORD and MissionStatus == 5) then
        player:startEvent(61)
    -- Mission San D'Oria 3-3 Appointment to Jeuno
    elseif (currentMission == tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO and MissionStatus == 2) then
        player:startEvent(537)
    else
        player:startEvent(514)
    end

    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 537) then
        player:setCharVar("MissionStatus", 3)
        player:addKeyItem(tpz.ki.LETTER_TO_THE_AMBASSADOR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_TO_THE_AMBASSADOR)
    elseif (csid == 61) then
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 87) then
        player:setCharVar('MissionStatus', 2)
    elseif (csid == 100) then
        player:setCharVar("Mission8-1Completed", 0) -- dont need this var anymore. JP midnight is done and prev mission completed.
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 104) then
        player:setCharVar("Mission8-2Kills", 0)
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 8) then
        player:setCharVar("MissionStatus", 6)
    elseif (csid == 32) then
        player:setCharVar("Cutscenes_8-2", 0) -- dont need this var now that mission is flagged and cs have been triggered to progress
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 76) then
        finishMissionTimeline(player, 3, csid, option)
    end

end
