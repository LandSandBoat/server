-----------------------------------
--
-- Zone: Grauberg_[S] (89)
--
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(495.063, 69.903, 924.102, 23)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onZoneWeatherChange = function(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)
    if (weather == xi.weather.WIND or weather == xi.weather.GALES) then
        npc:setStatus(xi.status.NORMAL)
    else
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
