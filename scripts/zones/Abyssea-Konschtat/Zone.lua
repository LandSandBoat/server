-----------------------------------
-- Zone: Abyssea - Konschtat
-----------------------------------
-- Research
-- EventID 1024-1029 aura of boundless rage
-- EventID 2048-2179 The treasure chest will disappear is 180 seconds menu.
-- EventID 2180 Teleport?
-- EventID 2181 DEBUG Menu
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require("scripts/globals/abyssea")
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 70, -80, -850, 170, -70, -773)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    -- Note: in retail even tractor lands you back at searing ward, will handle later.
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(153, -72, -840, 140)
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
