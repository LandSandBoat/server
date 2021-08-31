-----------------------------------
--
-- Zone: Misareaux_Coast (25)
--
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/helm")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
local MISAREAUX_COAST = require("scripts/zones/Misareaux_Coast/globals")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    MISAREAUX_COAST.ziphiusHandleQM()
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(567.624, -20, 280.775, 120)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local vHour = VanadielHour()
    if vHour >= 22 or vHour <= 7 then
        MISAREAUX_COAST.ziphiusHandleQM()
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
