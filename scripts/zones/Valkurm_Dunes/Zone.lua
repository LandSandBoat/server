-----------------------------------
--
-- Zone: Valkurm_Dunes (103)
--
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/missions/amk/helpers")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(60.989, -4.898, -151.001, 198)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3;
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) ==
        1) then
        cs = 5
    end

    -- AMK06/AMK07
    if ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if (csid == 3) then
        quests.rainbow.onEventUpdate(player)
    elseif (csid == 5) then
        if (player:getZPos() > 45) then
            if (player:getZPos() > -301) then
                player:updateEvent(0, 0, 0, 0, 0, 1)
            else
                player:updateEvent(0, 0, 0, 0, 0, 3)
            end
        end
    end
end

zone_object.onEventFinish = function(player, csid, option)
end

zone_object.onZoneWeatherChange = function(weather)
    local qm1 = GetNPCByID(ID.npc.SUNSAND_QM) -- Quest: An Empty Vessel
    if (weather == xi.weather.DUST_STORM) then
        qm1:setStatus(xi.status.NORMAL)
    else
        qm1:setStatus(xi.status.DISAPPEAR)
    end
end

return zone_object
