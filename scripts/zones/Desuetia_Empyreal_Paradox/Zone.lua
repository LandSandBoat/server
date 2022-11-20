-----------------------------------
-- Zone: Desuetia Empyreal Paradox (290)
-----------------------------------
local ID = require('scripts/zones/Desuetia_Empyreal_Paradox/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        -- player:setPos(x, y, z, rot)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
