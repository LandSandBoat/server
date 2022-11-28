-----------------------------------
-- Zone: Residential_Area
-----------------------------------
local ID = require('scripts/zones/Residential_Area/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getCharVar("newMog") == 0 then
        cs = 30000
        player:setCharVar("newMog", 1)
    end

    player:eraseAllStatusEffect()
    player:setPos(0, 0, 0, 192)

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
