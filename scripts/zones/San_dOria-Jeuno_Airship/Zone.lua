-----------------------------------
-- Zone: San_dOria-Jeuno_Airship
-----------------------------------
---@type TZone
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

zoneObject.onGameHour = function(zone)
    local qmObj        = zone:queryEntitiesByName('qm1')[1]
    local vanadielHour = VanadielHour()

    if
        IsMoonFull() and
        (vanadielHour >= 18 or
        vanadielHour < 6)
    then
        qmObj:setStatus(xi.status.NORMAL)
    else
        qmObj:setStatus(xi.status.DISAPPEAR)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 100 then
        local prevzone = player:getPreviousZone()

        if prevzone == xi.zone.PORT_JEUNO then
            player:setPos(0, 0, 0, 0, 232)
        elseif prevzone == xi.zone.PORT_SAN_DORIA then
            player:setPos(0, 0, 0, 0, 246)
        end
    end
end

return zoneObject
