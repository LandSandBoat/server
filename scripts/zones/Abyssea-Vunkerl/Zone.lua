-----------------------------------
-- Zone: Abyssea - Vunkerl
-----------------------------------
local ID = require('scripts/zones/Abyssea-Vunkerl/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NOTE: Player can make it all the way to the west ledge due to the shape of the
    -- area.  Might need to add some additional logic in the future.
    zone:registerTriggerArea(1, -385, -55, 644, -305, -38.85, 710)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-351, -46.750, 699.5, 10)
    end

    xi.abyssea.onZoneIn(player)

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.abyssea.afterZoneIn(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardTriggerAreaEnter(player)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardTriggerAreaLeave(player)
        end,
    }
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    xi.abyssea.onEventFinish(player, csid, option)
end

return zoneObject
