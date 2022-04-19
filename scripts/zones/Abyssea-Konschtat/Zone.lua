-----------------------------------
-- Zone: Abyssea - Konschtat
-----------------------------------
-- Research
-- EventID 1024-1029 aura of boundless rage
-- EventID 2048-2179 The treasure chest will disappear is 180 seconds menu.
-- EventID 2180 Teleport?
-- EventID 2181 DEBUG Menu
-----------------------------------
local ID = require("scripts/zones/Abyssea-Konschtat/IDs")
require("scripts/globals/abyssea")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 70, -80, -850, 170, -70, -773)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    -- Note: in retail even tractor lands you back at searing ward, will handle later.
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(153, -72, -840, 140)
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
