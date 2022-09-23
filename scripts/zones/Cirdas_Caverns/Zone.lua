-----------------------------------
--
-- Zone: Cirdas Caverns
--
-----------------------------------
local ID = require("scripts/zones/Cirdas_Caverns/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Area around Ergon Locus (17883912)
    local locusX = -140.000
    local locusY = 10.000
    local locusZ = 60.000
    local distance = 15
    zone:registerRegion(1,
        locusX - distance, locusY - distance, locusZ - distance,
        locusX + distance, locusY + distance, locusZ + distance)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-180, 30, -314, 203)
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
