-----------------------------------
--
-- Zone: Windurst_Waters_[S] (94)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/chocobo")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    tpz.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(157 + math.random(1, 5), -5, -62, 192)
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
