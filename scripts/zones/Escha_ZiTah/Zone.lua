-----------------------------------
--
-- Zone: Escha - Zi'Tah (288)
--
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        -- player:setPos(x, y, z, rot)
    end

    if player:getCurrentMission(ROV) == xi.mission.id.rov.EDDIES_OF_DESPAIR_I then
        cs = 1
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_I)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_LAND_AFTER_TIME)
    end
end

return zone_object
