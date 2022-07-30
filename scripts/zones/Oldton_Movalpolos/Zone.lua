-----------------------------------
-- Zone: Oldton_Movalpolos (11)
-----------------------------------
local ID = require("scripts/zones/Oldton_Movalpolos/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.MINING)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(70.956, 5.99, 139.843, 134)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
