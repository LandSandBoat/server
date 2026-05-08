-----------------------------------
-- Zone: Arrapago_Reef (54)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -462, -4, -420, -455, -1, -392) -- approach the Cutter
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-456, -3, -405, 64)
    end

    if prevZone == xi.zone.ILRUSI_ATOLL then
        player:setPos(26, -7, 606, 222)
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
    xi.apkallu.updateHate(xi.zone.ARRAPAGO_REEF, -3)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 108 then -- enter instance: illrusi atoll
        player:setPos(0, 0, 0, 0, 55)
    elseif csid == 222 then -- Enter instance: Black coffin
        player:setPos(0, 0, 0, 0, 60)
    end
end

return zoneObject
