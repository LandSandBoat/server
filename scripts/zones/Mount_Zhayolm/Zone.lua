-----------------------------------
--
-- Zone: Mount_Zhayolm (61)
--
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    GetMobByID(ID.mob.CERBERUS):setRespawnTime(math.random(12, 36) * 3600)

    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if prevZone == tpz.zone.LEBROS_CAVERN then
        player:setPos(681.950, -24.00, 369.936, 40)
    elseif player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-521.016, -6.191, 60.013, 126)
    end
    return cs
end

zone_object.afterZoneIn = function(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 208 then
        player:setPos(0, 0, 0, 0, 63)
    end
end

return zone_object
