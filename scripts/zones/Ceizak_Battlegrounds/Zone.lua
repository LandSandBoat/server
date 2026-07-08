-----------------------------------
-- Zone: Ceizak Battlegrounds (261)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Ergon Locus area at K-10
    zone:registerCylindricalTriggerArea(1, 357.819, -250.201, 11)

    -- Ergon Locus area at I-8
    zone:registerCylindricalTriggerArea(2, 87.2, 72.9, 8)

    xi.reives.setupZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(431, 0, 178, 110)
    end

    return cs
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
