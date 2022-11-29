-----------------------------------
-- Zone: Empyreal_Paradox
-----------------------------------
local ID = require('scripts/zones/Empyreal_Paradox/IDs')
require('scripts/globals/conquest')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 538, -2, -501,  542, 0, -497) -- to The Garden of Ru'hmet
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        --player:setPos(502, 0, 500, 222) -- BC Area
        player:setPos(539, -1, -500, 69)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if triggerArea:GetTriggerAreaID() == 1 then
        player:startEvent(100)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 100 and option == 1 then
        player:setPos(-420, -1, 379.900, 62, 35)
    end
end

return zoneObject
