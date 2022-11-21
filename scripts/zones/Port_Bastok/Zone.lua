-----------------------------------
-- Zone: Port_Bastok (236)
-----------------------------------
local ID = require('scripts/zones/Port_Bastok/IDs')
require('scripts/globals/conquest')
require('scripts/globals/settings')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -112, -3, -17, -96, 3, -3)     -- event COP
    zone:registerTriggerArea(2, 53.5, 5, -165.3, 66.5, 6, -72) -- drawbridge area
    xi.conquest.toggleRegionalNPCs(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 1
        end

        player:setPos(132, -8.5, -13, 179)
        player:setHomePoint()
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            cs = 73
            player:setPos(-36.000, 7.000, -58.000, 194)
        else
            local position = math.random(1, 5) + 57
            player:setPos(position, 8.5, -239, 192)
        end
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, transport)
    if player:getLocalVar('[AIRSHIP]Paid') == 1 then
        player:startEvent(71)
    else
        player:setPos(-93.8551, -2.6121, -7.9205, 253)
        player:setLocalVar('[AIRSHIP]Paid', 0)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 71 then
        player:setPos(0, 0, 0, 0, 224)
        player:setLocalVar('[AIRSHIP]Paid', 1)
    elseif csid == 140 and option == 0 then
        player:setLocalVar('[AIRSHIP]Paid', 0)
    end
end

return zoneObject
