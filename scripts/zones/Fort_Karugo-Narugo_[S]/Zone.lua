-----------------------------------
-- Zone: Fort_Karugo-Narugo_[S] (96)
-----------------------------------
local ID = require('scripts/zones/Fort_Karugo-Narugo_[S]/IDs')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(135, -21, 578, 171)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onZoneWeatherChange = function(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS)

    if npc ~= nil then
        if
            weather == xi.weather.DUST_STORM or
            weather == xi.weather.SAND_STORM
        then
            npc:setStatus(xi.status.DISAPPEAR)
        else
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
