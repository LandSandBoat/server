-----------------------------------
-- Zone: Foret de Hennetiel
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.reives.setupZone(zone)

    zone:registerCylindricalTriggerArea(1, 529.946, 157.579, 17.69) -- Ergon Locus, Circular Trigger Area, 17.69 Radius
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(360, 6, 455, 93)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
