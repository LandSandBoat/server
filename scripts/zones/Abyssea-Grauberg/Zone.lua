-----------------------------------
-- Zone: Abyssea - Grauberg
-----------------------------------
local ID = require("scripts/zones/Abyssea-Grauberg/IDs")
require("scripts/globals/quests")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -570, 20, -810, -487.3, 35, -740)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-555, 31, -760, 0)
    end

    xi.abyssea.onZoneIn(player)

    return cs
end

zone_object.afterZoneIn = function(player)
    xi.abyssea.afterZoneIn(player)
end

zone_object.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardRegionEnter(player)
        end,
    }
end

zone_object.onRegionLeave = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardRegionLeave(player)
        end,
    }
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
