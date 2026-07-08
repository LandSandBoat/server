-----------------------------------
-- func: time
-- desc: Prints time info.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local channel = xi.msg.channel.SYSTEM_3
    local elementalDayName =
    {
        'Firesday',
        'Earthsday',
        'Watersday',
        'Windsday',
        'Iceday',
        'Lightningday',
        'Lightsday',
        'Darksday',
    }
    local totdName =
    {
        'Midnight',
        'New Day',
        'Dawn',
        'Daytime',
        'Dusk',
        'Evening',
        'Night',
    }
    local raceName =
    {
        'Hume Male',
        'Hume Female',
        'Elvaan Male',
        'Elvaan Female',
        'Taru Male',
        'Taru Female',
        'Mithra',
        'Galka',
    }
    local rseZoneName =
    {
        'Ordelle\'s Caves',
        'Gusgen Mines',
        'Maze of Shakhrami',
    }
    local earthDayName =
    {
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
    }
    -- Time and Date
    local year = VanadielYear() + 886
    local month = VanadielMonth()
    local day = VanadielDayOfTheMonth()
    local dayElement = elementalDayName[VanadielDayOfTheWeek() + 1]
    local hour = VanadielHour()
    local minute = VanadielMinute()
    local totd = totdName[VanadielTOTD()] or 'None'
    player:printToPlayer(fmt('It has been {} Vana\'diel days ({} seconds) since the Vana\'diel epoch.', VanadielUniqueDay(), VanadielTime()), channel)
    player:printToPlayer(fmt('The next Vana\'diel day is in {} seconds.', getVanaMidnight() - GetSystemTime()), channel)
    player:printToPlayer(fmt('Vana\'diel: {}/{}/{}, {}, {}:{:02} ({}, {} days into the year)', year, month, day, dayElement, hour, minute, totd, VanadielDayOfTheYear()), channel)

    -- Moon
    local moonPhase = VanadielMoonPhase()
    local moonCycle = getVanadielMoonCycle()

    local moonNames = {
        [xi.moonCycle.NEW_MOON]                = 'New Moon',
        [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 'Waxing Crescent',
        [xi.moonCycle.GREATER_WAXING_CRESCENT] = 'Waxing Crescent',
        [xi.moonCycle.FIRST_QUARTER]           = 'First Quarter',
        [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 'Waxing Gibbous',
        [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 'Waxing Gibbous',
        [xi.moonCycle.FULL_MOON]               = 'Full Moon',
        [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 'Waning Gibbous',
        [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 'Waning Gibbous',
        [xi.moonCycle.THIRD_QUARTER]           = 'Last Quarter',
        [xi.moonCycle.GREATER_WANING_CRESCENT] = 'Waning Crescent',
        [xi.moonCycle.LESSER_WANING_CRESCENT]  = 'Waning Crescent',
    }

    local moonType = moonNames[moonCycle]

    player:printToPlayer(fmt('              {} ({}%)', moonType, moonPhase), channel)

    -- Earth time
    local utcTimestamp = GetSystemTime()
    local secondsToMidnight = JstMidnight() - utcTimestamp
    local hoursToMidnight = math.floor(secondsToMidnight / (60 * 60))
    secondsToMidnight = secondsToMidnight - (hoursToMidnight * 60 * 60)
    local minutesToMidnight = math.floor(secondsToMidnight / 60)
    secondsToMidnight = secondsToMidnight - (minutesToMidnight * 60)
    local jstHours = 23 - hoursToMidnight
    local jstMinutes = 59 - minutesToMidnight
    local jstSeconds = 59 - secondsToMidnight
    local weeklyResetDays = math.floor((NextJstWeek() - utcTimestamp) / (24 * 60 * 60))
    player:printToPlayer(fmt('Japan: {}, {}:{:02}:{:02} (weekly reset in {} days)', earthDayName[JstDayOfTheWeek() + 1], jstHours, jstMinutes, jstSeconds, weeklyResetDays), channel)

    -- RSE
    local rseRace = raceName[VanadielRSERace()]
    local rseLocation = rseZoneName[VanadielRSELocation() + 1]
    player:printToPlayer(fmt('Current RSE is {} in {}.', rseRace, rseLocation), channel)
end

return commandObj
