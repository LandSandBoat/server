-----------------------------------
--
-- Zone: Eastern Adoulin (257)
--
-----------------------------------
local ID = require("scripts/zones/Eastern_Adoulin/IDs")
-----------------------------------
local zone_object = {}

local defineZoneAroundXYZ = function(zone, id, x, y, z, distance)
    zone:registerRegion(id,
        x - distance, y - distance, z - distance,
        x + distance, y + distance, z + distance)
end

zone_object.onInitialize = function(zone)
    defineZoneAroundXYZ(zone, 1, 100.580, -40.150, -63.830, 7) -- Area around Ploh Trishbahk (castle gate)
    defineZoneAroundXYZ(zone, 2, -80.214,  -0.150,  30.717, 7) -- Area around Oscairn (Peacekeeper Coalition)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-155, 0, -19, 250)
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
