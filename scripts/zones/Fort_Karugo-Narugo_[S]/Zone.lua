-----------------------------------
--
-- Zone: Fort_Karugo-Narugo_[S] (96)
--
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(820, 25.782, 117.991, 66)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onZoneWeatherChange = function(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)
    if (npc ~= nil) then
        if (weather == xi.weather.DUST_STORM or weather == xi.weather.SAND_STORM) then
            npc:setStatus(xi.status.DISAPPEAR)
        else
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
