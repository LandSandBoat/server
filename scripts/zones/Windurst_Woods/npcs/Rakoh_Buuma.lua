-----------------------------------
-- Area: Windurst Woods
--  NPC: Rakoh Buuma
-- Starts Windurst Missions
-- !pos 106 -5 -23 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getNation() ~= xi.nation.WINDURST then
        player:startEvent(105) -- for other nation
    else
        local currentMission = player:getCurrentMission(WINDURST)
        local missionStatus = player:getMissionStatus(player:getNation())
        local pRank = player:getRank()
        local cs, p, offset = getMissionOffset(player, 1, currentMission, missionStatus)

        if (currentMission <= xi.mission.id.windurst.THE_SHADOW_AWAITS and (cs ~= 0 or offset ~= 0 or (currentMission == xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and offset == 0))) then
            if cs == 0 then
                player:showText(npc, ORIGINAL_MISSION_OFFSET + offset) -- dialog after accepting mission
            else
                player:startEvent(cs, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            end
        elseif (currentMission ~= xi.mission.id.windurst.NONE) then
            player:startEvent(112)
        elseif not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT) then
            player:startEvent(121)
        elseif not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HEART_OF_THE_MATTER) then
            player:startEvent(132)
        elseif not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_PRICE_OF_PEACE) then
            player:startEvent(149)
        elseif player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_WINDURST) then
            player:startEvent(197)
        elseif player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) then
            player:startEvent(632)
        else
            local param3
            local flagMission, repeatMission = getMissionMask(player)
            -- NPC dialog changes when starting 3-2 according to whether it's the first time or being repeated
            if (player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS)) then
                param3 = 1
            else
                param3 = 0
            end
            player:startEvent(114, flagMission, 0, param3, 0, xi.ki.STAR_CRESTED_SUMMONS, repeatMission)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    finishMissionTimeline(player, 1, csid, option)

    if csid == 121 and option == 1 then
        player:addTitle(xi.title.NEW_BUUMAS_BOOMERS_RECRUIT)
    elseif csid == 114 and (option == 12 or option == 15) then
        player:addKeyItem(xi.ki.STAR_CRESTED_SUMMONS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.STAR_CRESTED_SUMMONS)
    elseif csid == 632 then
        player:setCharVar("WWoodsRTenText", 1)
    end
end

return entity
