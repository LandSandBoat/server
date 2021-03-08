-----------------------------------
-- Area: Heavens Tower
--  NPC: Zubaba
-- Involved in Mission 3-2
-- !pos 15 -27 18 242
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local currentMission = player:getCurrentMission(WINDURST)
    local nextMissionFinished = player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_NEW_JOURNEY)

    if currentMission == xi.mission.id.windurst.WRITTEN_IN_THE_STARS and player:getCharVar("MissionStatus") == 3 then
        if trade:hasItemQty(16447, 3) and trade:getItemCount() == 3 then -- Trade Rusty Dagger
            player:tradeComplete()
            player:startEvent(151)
        end
    end
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getCharVar("MissionStatus")
    local nextMissionFinished = player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_NEW_JOURNEY)
    local starsMissionFinished = player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS)

    if
        currentMission == xi.mission.id.windurst.WRITTEN_IN_THE_STARS and
        not nextMissionFinished and
        not starsMissionFinished
    then
        if missionStatus == 0 then
            player:startEvent(121)
        elseif missionStatus == 1 then
            player:startEvent(122)
        elseif missionStatus == 2 then
            player:startEvent(135)
        end
    elseif
        currentMission == xi.mission.id.windurst.WRITTEN_IN_THE_STARS and
        (nextMissionFinished or starsMissionFinished)
    then
        if missionStatus == 0 then
            player:startEvent(257, 0, 16447) -- Rusty Dagger
        elseif missionStatus == 3 then
            player:startEvent(150, 0, 16447)
        end
    elseif player:hasKeyItem(xi.ki.STAR_CRESTED_SUMMONS) then
        player:startEvent(157)
    elseif currentMission == xi.mission.id.windurst.THE_SHADOW_AWAITS and player:hasKeyItem(xi.ki.SHADOW_FRAGMENT) then
        player:startEvent(194) -- her reaction after 5-1.
    elseif
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and
        (missionStatus >= 3 or player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING))
    then
        player:startEvent(387)
    else
        player:startEvent(56)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 121 then
        player:addKeyItem(xi.ki.CHARM_OF_LIGHT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CHARM_OF_LIGHT)
        player:setCharVar("MissionStatus", 1)
    elseif csid == 149 or csid == 257 then
        player:setCharVar("MissionStatus", 3)
    elseif csid == 135 or csid == 151 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 387 then
        player:setCharVar("WindurstSecured", 0)
    end
end

return entity
