-----------------------------------
-- Area: Windurst Waters
--  NPC: Mokyoko
-- Starts Windurst Missions
-- !pos -55 -8 227 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrigger(player, npc)

    if (player:getNation() ~= tpz.nation.WINDURST) then
        player:startEvent(103) -- for other nation
    else
        CurrentMission = player:getCurrentMission(WINDURST)
        MissionStatus = player:getCharVar("MissionStatus")
        pRank = player:getRank()
        cs, p, offset = getMissionOffset(player, 2, CurrentMission, MissionStatus)

        if (CurrentMission <= tpz.mission.id.windurst.THE_SHADOW_AWAITS and (cs ~= 0 or offset ~= 0 or (CurrentMission == tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and offset == 0))) then
            if (cs == 0) then
                player:showText(npc, ORIGINAL_MISSION_OFFSET + offset) -- dialog after accepting mission
            else
                player:startEvent(cs, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            end
        elseif (CurrentMission ~= tpz.mission.id.windurst.NONE) then
            player:startEvent(109)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT) == false) then
            player:startEvent(118)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER) == false) then
            player:startEvent(130)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_PRICE_OF_PEACE) == false) then
            player:startEvent(135)
        elseif (player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_WINDURST)) then
            player:startEvent(232)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.MOON_READING) == true) then
            player:startEvent(837)
        else
            flagMission, repeatMission = getMissionMask(player)
            player:startEvent(111, flagMission, 0, 0, 0, tpz.ki.STAR_CRESTED_SUMMONS, repeatMission)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
printf("RESULT: %u", option)

    finishMissionTimeline(player, 2, csid, option)

    if (csid == 118 and option == 1) then
        player:addTitle(tpz.title.FRESH_NORTH_WINDS_RECRUIT)
    elseif (csid == 111 and (option == 12 or option == 15)) then
        player:addKeyItem(tpz.ki.STAR_CRESTED_SUMMONS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.STAR_CRESTED_SUMMONS)
    end
    if (csid == 837) then
        player:setCharVar("WWatersRTenText", 1)
    end

end
