-----------------------------------
-- Zone: Abyssea - Grauberg
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerRegion(1, -570, 20, -810, -487.3, 35, -740)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-555, 31, -760, 0)
    end

    xi.abyssea.onZoneIn(player)

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.abyssea.afterZoneIn(player)
end

zoneObject.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardRegionEnter(player)
        end,
    }
end

zoneObject.onRegionLeave = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardRegionLeave(player)
        end,
    }
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
