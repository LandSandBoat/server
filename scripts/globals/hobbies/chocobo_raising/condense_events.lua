-----------------------------------
-- Chocobo Raising - Raw Event Condenser
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

local compareTables = function(t1, t2)
    if
        not t1 or
        not t2
    then
        return false
    end

    if type(t1) ~= 'table' then
        return false
    end

    if type(t2) ~= 'table' then
        return false
    end

    if #t1 ~= #t2 then
        return false
    end

    for idx, val1 in pairs(t1) do
        local val2 = t2[idx]

        if val1 ~= val2 then
            return false
        end
    end

    return true
end

xi.chocoboRaising.condenseEvents = function(events)
    local cutEvent = function(t, eStart, eEnd, csList)
        table.insert(t, { eStart, eEnd, csList })
    end

    local condensedEvents     = {}
    local currentStartDay     = nil
    local currentEndDay       = nil
    local currentEventCSTable = nil

    debug('Raw Events')
    for _, entry in ipairs(events) do
        local eventDay    = entry[1]
        local eventCSList = entry[2]

        debug('Day', eventDay, ':', eventCSList[1])

        if not currentEventCSTable then
            -- Start first span
            currentStartDay     = eventDay
            currentEndDay       = eventDay
            currentEventCSTable = {}
            for _, cs in ipairs(eventCSList) do
                table.insert(currentEventCSTable, cs)
            end
        elseif eventDay == currentEndDay then
            -- Additional event on the same day, append to current span
            for _, cs in ipairs(eventCSList) do
                table.insert(currentEventCSTable, cs)
            end
        elseif
            eventDay == currentEndDay + 1 and
            compareTables(eventCSList, currentEventCSTable)
        then
            -- Next day, but same exact CS table. Extend the span.
            currentEndDay = eventDay
        else
            -- Span broken: cut it and start a new one
            cutEvent(condensedEvents, currentStartDay, currentEndDay, currentEventCSTable)

            currentStartDay     = eventDay
            currentEndDay       = eventDay
            currentEventCSTable = {}
            for _, cs in ipairs(eventCSList) do
                table.insert(currentEventCSTable, cs)
            end
        end
    end

    -- Final 'cut'
    if currentEventCSTable then
        cutEvent(condensedEvents, currentStartDay, currentEndDay, currentEventCSTable)
    end

    debug('Condensed Events & Spans')
    for _, entry in ipairs(condensedEvents) do
        debug('Days', entry[1], 'to', entry[2], ':', entry[3][1])
    end

    return condensedEvents
end
