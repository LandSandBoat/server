-----------------------------------
-- Zone: Phomiuna_Aqueducts (27)
-----------------------------------
local ID = require('scripts/zones/Phomiuna_Aqueducts/IDs')
require('scripts/globals/settings')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(260.02, -2.12, -290.461, 192)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 40, 0, 0) -- LV40 cap
    end
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
