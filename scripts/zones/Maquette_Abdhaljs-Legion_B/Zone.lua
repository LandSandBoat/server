-----------------------------------
-- Zone: Maquette Abdhaljs-Legion B (287)
-----------------------------------
local ID = require("scripts/zones/Maquette_Abdhaljs-Legion_B/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(-34.2, -16, 58, 32, xi.zones.MHAURA)
    end

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(137, 12.5, -137, 32)
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
