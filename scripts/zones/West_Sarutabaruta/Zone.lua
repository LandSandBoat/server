-----------------------------------
--
-- Zone: West_Sarutabaruta (115)
--
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())

    tpz.helm.initZone(zone, tpz.helm.type.HARVESTING)
end

zone_object.onZoneIn = function( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-374.008, -23.712, 63.289, 213)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 48
    elseif player:getCurrentMission(ASA) == tpz.mission.id.asa.BURGEONING_DREAD and prevZone == tpz.zone.WINDURST_WATERS then
        cs = 62
    elseif player:getCurrentMission(ASA) == tpz.mission.id.asa.BURGEONING_DREAD and prevZone == tpz.zone.PORT_WINDURST then
        cs = 63
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 50
    -- removed only "cs =" works onzonein and can't take parameters atm
    -- elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        -- player:startEvent(50, 0, 0, 0, 0, 0, 2) -- talking doll go east
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function( player, region)
end

zone_object.onEventUpdate = function( player, csid, option)
    if csid == 48 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 62 or csid == 63 then
        player:setCharVar("ASA_Status", option)
    elseif csid == 50 then
        if player:getZPos() > 470 then
            player:updateEvent(0, 0, 0, 0, 0, 2)
        else
            player:updateEvent(0, 0, 0, 0, 0, 1)
        end
    end
end

zone_object.onEventFinish = function( player, csid, option)
    if csid == 62 or csid == 63 then
        player:completeMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.BURGEONING_DREAD)
        player:addMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
    end
end

return zone_object
