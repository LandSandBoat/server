-----------------------------------
-- Zone: Mount_Zhayolm (61)
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    GetMobByID(ID.mob.CERBERUS):setRespawnTime(math.random(12, 36) * 3600)

    xi.helm.initZone(zone, xi.helmType.MINING)
    xi.darkRider.addHoofprints(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if prevZone == xi.zone.LEBROS_CAVERN then
        player:setPos(681.950, -24.00, 369.936, 40)
    elseif
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(682, -24, 363, 94)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function()
    xi.apkallu.updateHate(xi.zone.MOUNT_ZHAYOLM, -3)
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
    if csid == 208 then
        player:setPos(0, 0, 0, 0, 63)
    end
end

return zoneObject
