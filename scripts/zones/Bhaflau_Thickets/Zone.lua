-----------------------------------
-- Zone: Bhaflau_Thickets (52)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helmType.HARVESTING)
    xi.darkRider.addHoofprints(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(432, -7, -39, 135)
    end

    if prevZone == xi.zone.MAMOOL_JA_TRAINING_GROUNDS then
        player:setPos(-186, -10, -802, 80)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')
end

zoneObject.onGameHour = function(zone)
    xi.darkRider.onGameHour(zone)

    if VanadielHour() == 0 then
        xi.darkRider.addHoofprints(zone)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 108 then
        player:setPos(0, 0, 0, 0, 66)
    end
end

return zoneObject
