-----------------------------------
-- Zone: Kuftal_Tunnel (174)
-----------------------------------
local ID = require('scripts/zones/Kuftal_Tunnel/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.GUIVRE)
    GetMobByID(ID.mob.GUIVRE):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
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

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

-- NOTE: Data order in these tables matters to determine the range that is being checked.
-- If the first entry is larger, it is a boundary case where and `or` range is used instead
-- (Example, moon phase > 90, or moon phase < 10)
local boulderOpenPhases =
{
    [1] =
    {
        [ 1] = { 29, 43 },
        [ 3] = { 12, 26 },
        [ 5] = { 95, 10 },
        [ 7] = { 79, 93 },
        [ 9] = { 62, 76 },
        [11] = { 45, 60 },
        [13] = { 29, 43 },
        [15] = { 12, 26 },
        [17] = { 95, 10 },
        [19] = { 79, 93 },
        [21] = { 62, 76 },
        [23] = { 45, 60 },
    },

    [2] =
    {
        [ 1] = { 57, 71 },
        [ 3] = { 74, 88 },
        [ 5] = { 90,  5 },
        [ 7] = {  7, 21 },
        [ 9] = { 24, 38 },
        [11] = { 40, 55 },
        [13] = { 57, 71 },
        [15] = { 74, 88 },
        [17] = { 90,  5 },
        [19] = {  7, 21 },
        [21] = { 24, 38 },
        [23] = { 40, 55 },
    }
}

local function isInRange(inputNum, rangeTable)
    if not rangeTable then
        return false
    end

    if rangeTable[1] < rangeTable[2] then
        return inputNum >= rangeTable[1] and inputNum <= rangeTable[2]
    else
        return inputNum >= rangeTable[1] or inputNum <= rangeTable[2]
    end
end

zoneObject.onGameHour = function(zone)
    local moonDirection = VanadielMoonDirection() -- 0 (neither) 1 (waning) or 2 (waxing)

    if moonDirection > 0 then
        local phaseInfo = boulderOpenPhases[moonDirection][VanadielHour()]
        local boulder = GetNPCByID(ID.npc.DOOR_ROCK)

        if
            isInRange(VanadielMoonPhase(), phaseInfo) and
            boulder:getAnimation() == xi.anim.CLOSE_DOOR
        then
            boulder:openDoor(144 * 6) -- one vanadiel hour is 144 earth seconds. lower boulder for 6 vanadiel hours.
        end
    end
end

return zoneObject
