-----------------------------------
-- Zone: Kazham (250)
-----------------------------------
local ID = require('scripts/zones/Kazham/IDs')
require('scripts/globals/conquest')
require('scripts/globals/chocobo')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
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
        if prevZone == xi.zone.KAZHAM_JEUNO_AIRSHIP then
            cs = 10002
        end

        player:setPos(-4.000, -3.000, 14.000, 66)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(10000)
    if player:getLocalVar('[AIRSHIP]Paid') == 1 then
        player:startEvent(10000)
    else
        player:setPos(-17.8247, -4.0000, -17.6277, 191.000)
        player:setLocalVar('[AIRSHIP]Paid', 0)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 10000 then
        player:setPos(0, 0, 0, 0, 226)
        player:setLocalVar('[AIRSHIP]Paid', 1)
    elseif csid == 121 and option == 0 then
        player:setLocalVar('[AIRSHIP]Paid', 0)
    end
end

return zoneObject
