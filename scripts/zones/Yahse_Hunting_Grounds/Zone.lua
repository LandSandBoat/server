-----------------------------------
-- Zone: Yahse Hunting Grounds
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.reives.setupZone(zone)

    -- Ergon Locus area at F-6
    zone:registerCylindricalTriggerArea(1, -447.7, 362.799, 6.6)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(361, 4, -211, 136)
    end

    return cs
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
