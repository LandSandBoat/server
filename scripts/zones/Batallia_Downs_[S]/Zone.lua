-----------------------------------
--
-- Zone: Batallia_Downs_[S] (84)
--
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-500.451, -39.71, 504.894, 39)
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
