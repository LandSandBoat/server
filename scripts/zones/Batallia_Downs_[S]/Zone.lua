-----------------------------------
-- Zone: Batallia_Downs_[S] (84)
-----------------------------------
local ID = require('scripts/zones/Batallia_Downs_[S]/IDs')
require('scripts/globals/voidwalker')
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
        player:setPos(-500.451, -39.71, 504.894, 39)
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
