-----------------------------------
-- Zone: Port_Bastok (236)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -112, -3, -17, -96, 3, -3)     -- event COP
    zone:registerCuboidTriggerArea(2, 53.5, 5, -165.3, 66.5, 6, -72) -- drawbridge area
    xi.conquest.toggleRegionalNPCs(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            cs = { 73 }
            player:setPos(-36.000, 7.000, -58.000, 194)
        else
            local position = math.random(1, 5) + 57
            player:setPos(position, 8.5, -239, 192)
        end
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(71)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 71 then
        player:setPos(0, 0, 0, 0, 224)
    end
end

return zoneObject
