-----------------------------------
-- Chocobo Raising - Raw Event Condenser
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

local arraysEqual = function(t1, t2)
    if
        type(t1) ~= 'table' or
        type(t2) ~= 'table' or
        #t1 ~= #t2
    then
        return false
    end

    for i = 1, #t1 do
        if t1[i] ~= t2[i] then
            return false
        end
    end

    return true
end

xi.chocoboRaising.condenseEvents = function(events)
    local condensedEvents = {}
    local currentSpan     = nil

    debug('Raw Events')
    for _, entry in ipairs(events) do
        local eventDay    = entry[1]
        local eventCSList = entry[2]

        debug('  Day', eventDay, ':', eventCSList[1])

        if
            currentSpan and
            eventDay == currentSpan[2]
        then
            for _, cs in ipairs(eventCSList) do
                table.insert(currentSpan[3], cs)
            end
        elseif
            currentSpan and
            eventDay == currentSpan[2] + 1 and
            arraysEqual(eventCSList, currentSpan[3])
        then
            currentSpan[2] = eventDay
        else
            if currentSpan then
                table.insert(condensedEvents, currentSpan)
            end

            currentSpan = { eventDay, eventDay, {} }

            for _, cs in ipairs(eventCSList) do
                table.insert(currentSpan[3], cs)
            end
        end

        local foundRetirement = false
        for _, cs in ipairs(eventCSList) do
            if cs == xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4 then
                foundRetirement = true
                break
            end
        end

        if foundRetirement then
            break
        end
    end

    if currentSpan then
        table.insert(condensedEvents, currentSpan)
    end

    debug('Condensed Events & Spans')
    for _, entry in ipairs(condensedEvents) do
        local csList = entry[3]
        if #csList > 1 then
            debug('  Days', entry[1], 'to', entry[2], ':', tostring(csList[1]) .. string.format(' (+%d events)', #csList - 1))
        else
            debug('  Days', entry[1], 'to', entry[2], ':', csList[1])
        end
    end

    return condensedEvents
end
