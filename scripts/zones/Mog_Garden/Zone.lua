-----------------------------------
-- Zone: Mog Garden (280)
-----------------------------------
require('scripts/globals/mog_garden')
local ID = require('scripts/zones/Mog_Garden/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.mog_garden.onInitialize(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-2.517, 0.452, -5.068, 190)
    end

    cs = xi.mog_garden.onZoneIn(player, prevZone)

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    xi.mog_garden.onTriggerAreaEnter(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    xi.mog_garden.onEventUpdate(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    xi.mog_garden.onEventFinish(player, csid, option)
end

return zoneObject
