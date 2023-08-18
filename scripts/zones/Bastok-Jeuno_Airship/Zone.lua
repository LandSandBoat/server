-----------------------------------
-- Zone: Bastok-Jeuno_Airship
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 or player:getYPos() == 0 or player:getZPos() == 0 then
        player:setPos(math.random(-4, 4), 1, math.random(-23, -12))
    end

    return cs
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(100)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 100 then
        local prevzone = player:getPreviousZone()

        if prevzone == xi.zone.PORT_JEUNO then
            player:setPos(0, 0, 0, 0, xi.zone.PORT_BASTOK)
        elseif prevzone == xi.zone.PORT_BASTOK then
            player:setPos(0, 0, 0, 0, xi.zone.PORT_JEUNO)
        end
    end
end

return zoneObject
