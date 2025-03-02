-----------------------------------
-- Zone: Wajaom_Woodlands (51)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helmType.HARVESTING)
    xi.chocobo.initZone(zone)
    xi.darkRider.addHoofprints(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(610.542, -28.547, 356.247, 122)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
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
end

return zoneObject
