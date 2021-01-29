-----------------------------------
--
-- Zone: Windurst_Walls (239)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -2, -17, 140, 2, -16, 142)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if ENABLE_ROV == 1 and player:getCurrentMission(ROV) == xi.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    elseif player:getCurrentMission(ROV) == xi.mission.id.rov.FATES_CALL and player:getRank(player:getNation()) >= 5 then
        cs = 30036
    elseif
        ENABLE_ASA == 1 and player:getCurrentMission(ASA) == xi.mission.id.asa.A_SHANTOTTO_ASCENSION
        and (prevZone == xi.zone.WINDURST_WATERS or prevZone == xi.zone.WINDURST_WOODS) and player:getMainLvl()>=10
    then
        cs = 510
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and player:getMissionStatus(player:getNation()) == 4 then
        cs = 443
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) - 123
        player:setPos(-257.5, -5.05, position, 0)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)  -- Heaven's Tower enter portal
            player:startEvent(86)
        end,
    }
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 86 then
        player:setPos(0, 0, -22.40, 192, 242)
    elseif csid == 510 then
        player:startEvent(514)
    elseif csid == 514 then
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.A_SHANTOTTO_ASCENSION)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:setCharVar("ASA_Status", 0)
    elseif csid == 443 then
        player:completeMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING)
        player:setMissionStatus(player:getNation(), 0)
        player:setRank(10)
        player:addGil(GIL_RATE*100000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*100000)
        player:addItem(183)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 183)
        player:addTitle(xi.title.VESTAL_CHAMBERLAIN)
    elseif csid == 30035 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
    end
end

return zone_object
