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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- This NPC is relevant only to San d'Orians on missions
    if player:getNation() == xi.nation.SANDORIA and player:getRank() ~= 10 then
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San D'Oria 9-2 "The Heir to the Light"
        if currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus == 5 then
            player:startEvent(8)

        -- San D'Oria 9-1 "Breaking Barriers"
        elseif currentMission == sandyMissions.BREAKING_BARRIERS and (missionStatus == 4 or missionStatus == 0) then
            if missionStatus == 4 then
                if
                    player:hasKeyItem(xi.ki.FIGURE_OF_TITAN) and
                    player:hasKeyItem(xi.ki.FIGURE_OF_GARUDA) and
                    player:hasKeyItem(xi.ki.FIGURE_OF_LEVIATHAN)
                then
                    player:startEvent(76)
                end
            else
                player:startEvent(32)
            end

        -- San D'Oria 8-2 "Lightbringer"
        elseif currentMission == sandyMissions.LIGHTBRINGER and (missionStatus == 6 or missionStatus == 0) then
            if missionStatus == 6 then
                player:startEvent(104)
            else
                player:startEvent(100)
            end

        -- San D'Oria 6-1 "Leaute's Last Wishes"
        elseif currentMission == sandyMissions.LEAUTE_S_LAST_WISHES and missionStatus == 1 then
            player:startEvent(87)

        -- San D'Oria 5-2 "The Shadow Lord"
        elseif currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 5 then
            player:startEvent(61)

        -- San D'Oria 3-3 "Appointment to Jeuno"
        elseif currentMission == sandyMissions.APPOINTMENT_TO_JEUNO and missionStatus == 2 then
            player:startEvent(537)

        -- Default
        else
            player:startEvent(514)
        end
    else
        player:startEvent(514)
    end

    return 1

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if csid == 537 then
        player:setMissionStatus(player:getNation(), 3)
        player:addKeyItem(xi.ki.LETTER_TO_THE_AMBASSADOR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_TO_THE_AMBASSADOR)
    elseif csid == 61 then
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 87 then
        player:setCharVar('missionStatus', 2)
    elseif csid == 100 then
        player:setCharVar("Mission8-1Completed", 0) -- dont need this var anymore. JP midnight is done and prev mission completed.
        player:setMissionStatus(player:getNation(), 1)
    elseif csid == 104 then
        player:setCharVar("Mission8-2Kills", 0)
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 8 then
        player:setMissionStatus(player:getNation(), 6)
    elseif csid == 32 then
        player:setCharVar("Cutscenes_8-2", 0) -- dont need this var now that mission is flagged and cs have been triggered to progress
        player:setMissionStatus(player:getNation(), 1)
    elseif csid == 76 then
        finishMissionTimeline(player, 3, csid, option)
    end

end

return entity
