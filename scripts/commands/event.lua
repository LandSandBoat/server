-----------------------------------
-- func: event <command> ...
--       event help [<command>]
--       event start <eventName> [<startTime>]
--       event end <eventName> [<endTime>]
-- desc: Schedule events/campaigns.
-----------------------------------
local scheduledEvent = xi.events.ScheduledEvent
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 2,
    parameters = 'sssssssssssssss',
}

local function error(player, msg)
    if msg then
        player:printToPlayer(msg)
    end

    player:printToPlayer('For usage instructions, run: !event help')
end

local dateFormats =
{
    { pattern = '^((%d%d%d%d)[-/](%d%d)[-/](%d%d))(.*)$', keys = { 'date', 'year', 'month', 'day', 'timeString' } },
    { pattern = '^((%d%d?) (%a%a%a%a*),? (%d%d%d%d))(.*)$', keys = { 'dateName', 'day', 'monthName', 'year', 'timeString' } },
    { pattern = '^((%a%a%a%a*) (%d%d?),? (%d%d%d%d))(.*)$', keys = { 'dateName', 'monthName', 'day', 'year', 'timeString' } },
}

local timeFormats =
{
    { pattern = '^,?[T ]((%d%d?):(%d%d):(%d%d)([ap]m))(.*)$', keys = { 'time', 'hour', 'min', 'sec', 'ampm', 'offsetString' } },
    { pattern = '^,?[T ]((%d%d):(%d%d):(%d%d))(.*)$', keys = { 'time', 'hour', 'min', 'sec', 'offsetString' } },
    { pattern = '^,?[T ]((%d%d?):(%d%d)([ap]m))(.*)$', keys = { 'time', 'hour', 'min', 'ampm', 'offsetString' } },
    { pattern = '^,?[T ]((%d%d):(%d%d))(.*)$', keys = { 'time', 'hour', 'min', 'offsetString' } },
}

local offsetFormats =
{
    { pattern = '^(Z)$', keys = { 'utc' } },
    { pattern = '^([+-])(%d%d):(%d%d)$', keys = { 'sign', 'offsetHour', 'offsetMin' } },
    { pattern = '^([+-])(%d%d)$', keys = { 'sign', 'offsetHour' } },
}

local monthNames =
{
    Jan = 1, January = 1,
    Feb = 2, February = 2,
    Mar = 3, March = 3,
    Apr = 4, April = 4,
    May = 5,
    Jun = 6, June = 6,
    Jul = 7, July = 7,
    Aug = 8, August = 8,
    Sep = 9, September = 9,
    Oct = 10, October = 10,
    Nov = 11, November = 11,
    Dec = 12, December = 12,
}

local function matchFormat(str, formats)
    for _, format in ipairs(formats) do
        local matches = { string.match(str, format.pattern) }

        if matches and matches[1] then
            local res = {}
            for index, key in ipairs(format.keys) do
                res[key] = matches[index]
            end

            return res
        end
    end

    return nil
end

local function parseDateString(player, dateString)
    print('dateString ' .. dateString)

    local obj = matchFormat(dateString, dateFormats)

    if not obj then
        player:printToPlayer('Invalid date component.')
        return 0
    end

    if obj.timeString and #obj.timeString > 0 then
        local timeInfo = matchFormat(obj.timeString, timeFormats)

        if timeInfo then
            for k, v in pairs(timeInfo) do
                obj[k] = v
            end
        else
            player:printToPlayer('Invalid time component.')
            return 0
        end
    end

    local offset = 0

    if obj.offsetString and #obj.offsetString > 0 then
        local offsetInfo = matchFormat(obj.offsetString, offsetFormats)

        if offsetInfo then
            for k, v in pairs(offsetInfo) do
                obj[k] = v
            end
        else
            player:printToPlayer('Invalid timezone component.')
            return 0
        end

        obj.offsetMin = obj.offsetMin or 0
        obj.isdst = false

        ---@diagnostic disable-next-line: param-type-mismatch
        local utcOffset = os['time'](os.date('!*t')) - os['time'](os.date('*t'))

        if obj.utc then
            offset = utcOffset
        elseif obj.sign == '+' then
            offset = utcOffset + (obj.offsetHour * 60 * 60) + (obj.offsetMin * 60)
        elseif obj.sign == '-' then
            offset = utcOffset - (obj.offsetHour * 60 * 60) - (obj.offsetMin * 60)
        end
    end

    if obj.monthName then
        obj.month = monthNames[obj.monthName]

        if not obj.month then
            player:printToPlayer('Invalid month name.')
            return 0
        end
    end

    if obj.ampm == 'pm' and tonumber(obj.hour) ~= 12 then
        obj.hour = obj.hour + 12
    elseif obj.ampm == 'am' and tonumber(obj.hour) == 12 then
        obj.hour = obj.hour - 12
    end

    local timestamp = os['time'](obj)

    return timestamp and (timestamp - offset) or 0
end

local function handleHelp(player, command)
    command = command and string.lower(command)

    if not command then
        player:printToPlayer('!event <command> <eventName> ...', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('List of available !event commands:', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('(< > means user entry, [ ] means optional)', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('list', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('start <eventName> [<startTime>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('end <eventName> [<endTime>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('check <eventName>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('You can get additional info on a specific command with: !event help <command>', xi.msg.channel.SYSTEM_3)
    elseif command == 'list' then
        player:printToPlayer('list', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('A command to list all available Scheduled Events and their current schedules.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Example: !event list', xi.msg.channel.SYSTEM_3)
    elseif command == 'start' then
        player:printToPlayer('start <eventName> [<startTime>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('A command to schedule the start time of an event (or start now if no time provided).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('The event will continue indefinitely unless the `end` command is also used.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Example: !event start assault Sep 2, 2023 11:00-07', xi.msg.channel.SYSTEM_3)
    elseif command == 'end' then
        player:printToPlayer('end <eventName> [<startTime>]', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('A command to schedule the end time of an event (or end now if no time provided).', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Example: !event end assault Sep 9, 2023 11:00-07', xi.msg.channel.SYSTEM_3)
    elseif command == 'check' then
        player:printToPlayer('check <eventName>', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('A command to check if a given event is currently live.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('Example: !event check assault', xi.msg.channel.SYSTEM_3)
    else
        player:printToPlayer('Unknown event command.')
        return handleHelp(player)
    end
end

local function handleList(player)
    for eventName, eventObj in pairs(xi.events.scheduled) do
        local isActive = false
        if type(scheduledEvent.getIsActive) == 'function' then
            isActive = scheduledEvent.getIsActive(eventObj)
        end

        local startTime = 0
        if type(scheduledEvent.getStartTime) == 'function' then
            startTime = scheduledEvent.getStartTime(eventObj)
        end

        local endTime = 0
        if type(scheduledEvent.getEndTime) == 'function' then
            endTime = scheduledEvent.getEndTime(eventObj)
        end

        local msg = eventName

        if startTime == 0 then
            msg = msg .. ' is not scheduled to start.'
        else
            msg = msg .. ' is ' .. (isActive and 'live' or 'not live') .. '.'

            msg = msg .. ' Starts: ' .. os.date('%b %d, %Y %I:%M:%S%p', startTime) .. '.'

            if endTime == 0 then
                msg = msg .. ' Does not have an end date.'
            else
                msg = msg .. ' Ends: ' .. os.date('%b %d, %Y %I:%M:%S%p', endTime) .. '.'
            end
        end

        player:printToPlayer(msg, xi.msg.channel.SYSTEM_3)
    end
end

local function handleStart(player, eventName, ...)
    local dateString = table.concat({ ... }, ' ')

    local targetTime = (dateString and #dateString > 0 and parseDateString(player, dateString)) or GetSystemTime()

    if targetTime == 0 then
        player:printToPlayer('Could not parse that date string.')
        return
    end

    SetServerVariable('[Event]' .. eventName .. 'Start', targetTime)

    local eventObj = xi.events.scheduled[eventName]
    local isActive = false
    if eventObj then
        if type(eventObj.getIsActive) == 'function' then
            isActive = eventObj:getIsActive()
        elseif type(scheduledEvent.getIsActive) == 'function' then
            isActive = scheduledEvent.getIsActive(eventObj)
        end
    end

    player:printToPlayer(eventName .. ' event start date: ' .. os.date('%b %d, %Y %I:%M:%S%p', targetTime), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(eventName .. ' event is ' .. (isActive and 'live' or 'not live') .. '.', xi.msg.channel.SYSTEM_3)
end

local function handleEnd(player, eventName, ...)
    local dateString = table.concat({ ... }, ' ')

    local targetTime = (dateString and #dateString > 0 and parseDateString(player, dateString)) or GetSystemTime()

    if targetTime == 0 then
        player:printToPlayer('Could not parse that date string.')
        return
    end

    SetServerVariable('[Event]' .. eventName .. 'End', targetTime)

    local eventObj = xi.events.scheduled[eventName]
    local isActive = false
    if eventObj then
        if type(eventObj.getIsActive) == 'function' then
            isActive = eventObj:getIsActive()
        elseif type(scheduledEvent.getIsActive) == 'function' then
            isActive = scheduledEvent.getIsActive(eventObj)
        end
    end

    player:printToPlayer(eventName .. ' event end date: ' .. os.date('%b %d, %Y %I:%M:%S%p', targetTime), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(eventName .. ' event is ' .. (isActive and 'live' or 'not live') .. '.', xi.msg.channel.SYSTEM_3)
end

local function handleCheck(player, eventName)
    local startTime = GetServerVariable('[Event]' .. eventName .. 'Start')
    local endTime = GetServerVariable('[Event]' .. eventName .. 'End')

    local eventObj = xi.events.scheduled[eventName]
    local isActive = false
    if eventObj then
        if type(eventObj.getIsActive) == 'function' then
            isActive = eventObj:getIsActive()
        elseif type(scheduledEvent.getIsActive) == 'function' then
            isActive = scheduledEvent.getIsActive(eventObj)
        end
    end

    if startTime == 0 then
        player:printToPlayer(eventName .. ' event is not scheduled to start.', xi.msg.channel.SYSTEM_3)
    else
        player:printToPlayer(eventName .. ' event start date: ' .. os.date('%b %d, %Y %I:%M:%S%p', startTime), xi.msg.channel.SYSTEM_3)

        if endTime == 0 then
            player:printToPlayer(eventName .. ' event does not have an end date.', xi.msg.channel.SYSTEM_3)
        else
            player:printToPlayer(eventName .. ' event end date: ' .. os.date('%b %d, %Y %I:%M:%S%p', endTime), xi.msg.channel.SYSTEM_3)
        end
    end

    player:printToPlayer(eventName .. ' event is ' .. (isActive and 'live' or 'not live') .. '.', xi.msg.channel.SYSTEM_3)
end

commandObj.onTrigger = function(player, command, ...)
    local arg = { ... }

    if not command or command == 'help' then
        return handleHelp(player, arg[1])
    end

    if command == 'list' then
        handleList(player)
        return
    end

    local eventName = arg[1]

    if not eventName then
        return error(player, 'Invalid eventName provided.')
    end

    local eventMatched = false

    for key, _ in pairs(xi.events.scheduled) do
        if string.lower(key) == string.lower(eventName) then
            eventName = key
            eventMatched = true
            break
        end
    end

    if not eventMatched then
        return error(player, 'No event with that eventName found.')
    end

    command = string.lower(command)

    local args = { ... }
    table.remove(args, 1)

    if command == 'start' then
        handleStart(player, eventName, unpack(args))
    elseif command == 'end' then
        handleEnd(player, eventName, unpack(args))
    elseif command == 'check' then
        handleCheck(player, eventName)
    else
        error(player, 'Unknown event command.')
    end
end

return commandObj
