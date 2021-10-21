-----------------------------------
--
-- Zone: Riverne-Site_B01
--
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/conquest")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(729.749, -20.319, 407.153, 90) -- {R}
    end
    return cs
end

zone_object.afterZoneIn = function(player)
    if (xi.settings.ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0) -- LV50 cap
    end
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
