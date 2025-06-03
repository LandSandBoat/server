-----------------------------------
-- Zone: Bibiki_Bay (4)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1,  474, -10,  667,  511, 10,  708) -- Manaclipper while docked at Sunset Docks
    zone:registerCuboidTriggerArea(2, -410, -10, -385, -371, 10, -343) -- Manaclipper while docked at Purgonorgo Isle
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.MANACLIPPER then
            cs = xi.manaclipper.onZoneIn(player)
        else
            player:setPos(669.917, -23.138, 911.655, 111)
        end
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    xi.manaclipper.aboard(player, triggerArea:getTriggerAreaID(), true)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    xi.manaclipper.aboard(player, triggerArea:getTriggerAreaID(), false)
end

zoneObject.onTransportEvent = function(player, transport)
    xi.manaclipper.onTransportEvent(player, transport)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 12 then
        player:startEvent(10) -- arrive at Sunset Docks CS
    elseif csid == 13 then
        player:startEvent(11) -- arrive at Purgonorgo Isle CS
    elseif csid == 14 or csid == 16 then
        player:setPos(0, 0, 0, 0, xi.zone.MANACLIPPER)
    end
end

return zoneObject
