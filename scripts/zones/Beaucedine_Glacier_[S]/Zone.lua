-----------------------------------
-- Zone: Beaucedine_Glacier_[S] (136)
-----------------------------------
local ID = require('scripts/zones/Beaucedine_Glacier_[S]/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-180, -81.85, 280, 44)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
