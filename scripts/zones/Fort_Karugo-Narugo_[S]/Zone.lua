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
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
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
    npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)
    if (npc ~= nil) then
        if (weather == tpz.weather.DUST_STORM or weather == tpz.weather.SAND_STORM) then
            npc:setStatus(tpz.status.DISAPPEAR)
        else
            npc:setStatus(tpz.status.NORMAL)
        end
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
