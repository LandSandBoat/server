-----------------------------------
--
-- Zone: Hall_of_the_Gods (251)
--
-----------------------------------
local ID = require("scripts/zones/Hall_of_the_Gods/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-0.011, -1.848, -176.133, 192)
    elseif player:getCurrentMission(ACP) == xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS and prevZone == xi.zone.ROMAEVE then
        cs = 5
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 5 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.BORN_OF_HER_NIGHTMARES)
    end
end

return zone_object
