-----------------------------------
-- Zone: Chocobo_Circuit
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocoboRacing.registerPads(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    xi.chocoboRacing.onPadsZoneIn(player, prevZone)

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-59, -14, -124, 188)
    end

    return cs
end

zoneObject.onZoneOut = function(player)
    xi.chocoboRacing.onPadsZoneOut(player)
end

zoneObject.onZoneTick = function(zone)
    xi.chocoboRacing.onZoneTick(zone)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    xi.chocoboRacing.onPadTriggerAreaEnter(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onPadEventUpdate(player, csid, option)
    xi.chocoboRacing.onEventUpdate(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onEventFinish(player, csid, option, npc)
end

return zoneObject
