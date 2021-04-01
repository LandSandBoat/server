-----------------------------------
--
-- Zone: Pashhow_Marshlands (109)
--
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.BOWHO_WARMONGER)
    GetMobByID(ID.mob.BOWHO_WARMONGER):setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(547.841, 23.192, 696.323, 136)
    end

    if prevZone == xi.zone.BEADEAUX and player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_FOUR_MUSKETEERS then
        local missionStatus = player:getCharVar("MissionStatus")

        if missionStatus > 0 and missionStatus < 22 then
            cs = 10
        elseif missionStatus == 22 then
            cs = 11
        end
    elseif quests.rainbow.onZoneIn(player) then
        cs = 13
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 15
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 13 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 15 then
        if player:getXPos() < 362 then
            player:updateEvent(0, 0, 0, 0, 0, 2)
        end
    end
end

zone_object.onEventFinish = function( player, csid, option)
    if csid == 10 then
        player:setPos(578, 25, -376, 126)
    elseif csid == 11 then
        finishMissionTimeline(player, 1, csid, option)
        player:setPos(578, 25, -376, 126)
    end
end

return zone_object
