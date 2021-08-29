-----------------------------------
-- Zone: Abyssea - Vunkerl
-----------------------------------
local ID = require("scripts/zones/Abyssea-Vunkerl/IDs")
require("scripts/globals/abyssea")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- NOTE: Player can make it all the way to the west ledge due to the shape of the
    -- area.  Might need to add some additional logic in the future.
    zone:registerRegion(1, -385, -55, 644, -305, -38.85, 710)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-351, -46.750, 699.5, 10)
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
