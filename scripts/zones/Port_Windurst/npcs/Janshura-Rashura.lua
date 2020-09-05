-----------------------------------
-- Area: Port Windurst
--  NPC: Janshura Rashura
-- Starts Windurst Missions
-- !pos -227 -8 184 240
-- Note: Includes Topaz modifications which may be subject to Topaz license
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrigger(player, npc)

    if (player:getNation() ~= tpz.nation.WINDURST) then
        player:startEvent(71) -- for other nation
    else
        CurrentMission = player:getCurrentMission(WINDURST)
        MissionStatus = player:getCharVar("MissionStatus")
        pRank = player:getRank()
        cs, p, offset = getMissionOffset(player, 3, CurrentMission, MissionStatus)

        if (CurrentMission <= tpz.mission.id.windurst.THE_SHADOW_AWAITS and (cs ~= 0 or offset ~= 0 or (CurrentMission == tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and offset == 0))) then
            if (cs == 0) then
                player:showText(npc, ORIGINAL_MISSION_OFFSET + offset) -- dialog after accepting mission
            else
                player:startEvent(cs, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            end
        elseif (CurrentMission ~= tpz.mission.id.windurst.NONE) then
            player:startEvent(76)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT) == false) then
            player:startEvent(83)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER) == false) then
            player:startEvent(104)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_PRICE_OF_PEACE) == false) then
            player:startEvent(109)
        elseif (player:hasKeyItem(tpz.ki.MESSAGE_TO_JEUNO_WINDURST)) then
            player:startEvent(163)
        elseif (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.MOON_READING) == true) then
            player:startEvent(567)
        else
            flagMission, repeatMission = getMissionMask(player)
            -- NPC dialog changes when starting 3-2 according to whether it's the first time or being repeated
            if (player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.WRITTEN_IN_THE_STARS)) then
                param3 = 1
            else
                param3 = 0
            end
            player:startEvent(78, flagMission, 0, param3, 0, tpz.ki.STAR_CRESTED_SUMMONS, repeatMission)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    finishMissionTimeline(player, 3, csid, option)

    if (csid == 118 and option == 1) then
        player:addTitle(tpz.title.NEW_BEST_OF_THE_WEST_RECRUIT)
    elseif (csid == 78 and (option == 12 or option == 15)) then
        player:addKeyItem(tpz.ki.STAR_CRESTED_SUMMONS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.STAR_CRESTED_SUMMONS)
    end
    if (csid == 567) then
        player:setCharVar("WWatersRTenText", 1)
    end

end
