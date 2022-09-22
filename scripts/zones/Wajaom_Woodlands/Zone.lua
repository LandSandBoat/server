-----------------------------------
-- Zone: Wajaom_Woodlands (51)
-----------------------------------
local ID = require('scripts/zones/Wajaom_Woodlands/IDs')
require('scripts/globals/chocobo_digging')
require('scripts/globals/chocobo')
require('scripts/globals/helm')
require('scripts/globals/zone')
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(610.542, -28.547, 356.247, 122)
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
