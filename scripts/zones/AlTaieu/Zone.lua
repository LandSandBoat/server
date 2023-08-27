-----------------------------------
-- Zone: AlTaieu (33)
-----------------------------------
local ID = require('scripts/zones/AlTaieu/IDs')
require('scripts/globals/missions')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-25, -1 , -620 , 33)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket("on00", player) -- Fog effect on zone in
end

return zoneObject
