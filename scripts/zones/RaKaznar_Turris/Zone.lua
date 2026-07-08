-----------------------------------
-- Zone: Ra'Kaznar Turris (277)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 54.000, -31.000, 13.000, 63.500, -29.000, 27.000) -- Entrance. Return to Ra'Kaznar Inner Court.
    -- Sphere-Type region: (regionID, x, y, z, radius).
    zone:registerSphericalTriggerArea(2, 120, -10, -20, 1) -- Small teleporter in the upper side of the south ramp. Event 10.
    zone:registerSphericalTriggerArea(3, 200,  10, -20, 1) -- Small teleporter in the lower side of the south ramp. Event 11.
    zone:registerSphericalTriggerArea(4, 120, -10,  60, 1) -- Small teleporter in the upper side of the north ramp. Event 12.
    zone:registerSphericalTriggerArea(5, 200,  10,  60, 1) -- Small teleporter in the lower side of the north ramp. Event 13.
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(58, 30, 20, 0)
    end

    return cs
end

local regionEventTable =
{
    [1] = 83, -- Teleports player out to Ra'Kaznar Inner Court.
    [2] = 10, -- Teleports player to the bottom of the south ramp.
    [3] = 11, -- Teleports player to the top of the south ramp.
    [4] = 12, -- Teleports player to the bottom of the north ramp.
    [5] = 13, -- Teleports player to the top of the north ramp.
}

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local regionId = triggerArea:getTriggerAreaID()
    local eventId  = regionEventTable[regionId]

    if eventId then
        if eventId == 83 then
            -- Elevator event.
            player:startEvent(eventId, 1, 0, 1, 613, 277, 4, 0, 0) -- Elevators "Param1" follow the pattern of "Goes up? 1. Goes down? 0."
        else
            player:startEvent(eventId)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    local count = 1
    if csid >= 10 and csid <= 13 then
        count = count + 1
        player:updateEvent(count) -- 2 updates appear 1 after another. First param is always 1 higher in the second update.
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 83 and option == 4 then
        player:setPos(751.5, 120, 20, 0, xi.zone.RAKAZNAR_INNER_COURT)
    end
end

return zoneObject
