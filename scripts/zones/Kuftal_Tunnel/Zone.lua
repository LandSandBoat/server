-----------------------------------
-- Zone: Kuftal_Tunnel (174)
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-20, -20, -241, 177)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

local boulderOpenCycles =
{
    [ 1] = { xi.moonCycle.LESSER_WAXING_GIBBOUS, xi.moonCycle.GREATER_WANING_CRESCENT },
    [ 3] = { xi.moonCycle.GREATER_WAXING_GIBBOUS, xi.moonCycle.LESSER_WANING_CRESCENT },
    [ 5] = { xi.moonCycle.NEW_MOON, xi.moonCycle.FULL_MOON },
    [ 7] = { xi.moonCycle.LESSER_WAXING_CRESCENT, xi.moonCycle.GREATER_WANING_GIBBOUS },
    [ 9] = { xi.moonCycle.GREATER_WAXING_CRESCENT, xi.moonCycle.LESSER_WANING_GIBBOUS },
    [11] = { xi.moonCycle.FIRST_QUARTER, xi.moonCycle.THIRD_QUARTER },
    [13] = { xi.moonCycle.LESSER_WAXING_GIBBOUS, xi.moonCycle.GREATER_WANING_CRESCENT },
    [15] = { xi.moonCycle.GREATER_WAXING_GIBBOUS, xi.moonCycle.LESSER_WANING_CRESCENT },
    [17] = { xi.moonCycle.NEW_MOON, xi.moonCycle.FULL_MOON },
    [19] = { xi.moonCycle.LESSER_WAXING_CRESCENT, xi.moonCycle.GREATER_WANING_GIBBOUS },
    [21] = { xi.moonCycle.GREATER_WAXING_CRESCENT, xi.moonCycle.LESSER_WANING_GIBBOUS },
    [23] = { xi.moonCycle.FIRST_QUARTER, xi.moonCycle.THIRD_QUARTER },
}

zoneObject.onGameHour = function(zone)
    local moonCycle = getVanadielMoonCycle()
    local hour = VanadielHour()
    local boulder = GetNPCByID(ID.npc.DOOR_ROCK)
    local validCycles = nil

    if hour then
        validCycles = boulderOpenCycles[hour]
    end

    if
        boulder and
        validCycles and
        boulder:getAnimation() == xi.anim.CLOSE_DOOR
    then
        if
            moonCycle == validCycles[1] or
            moonCycle == validCycles[2]
        then
            boulder:openDoor(144 * 6) -- one vanadiel hour is 144 earth seconds. lower boulder for 6 vanadiel hours.
        end
    end
end

return zoneObject
