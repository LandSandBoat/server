-----------------------------------
-- Zone: Escha - Zi'Tah (288)
-----------------------------------
local ID = require('scripts/zones/Escha_ZiTah/IDs')
require('scripts/globals/missions')
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
        -- 0, 0, 0 currently lands the player at a valid location in zone
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
