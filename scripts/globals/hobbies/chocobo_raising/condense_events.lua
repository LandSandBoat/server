-----------------------------------
-- Chocobo Raising - Raw Event Condenser
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

local maxRecordDays = 7

-----------------------------------
-- Global Functions
-----------------------------------
-- Records are { firstDay, lastDay, cutscenes, { gil, good, poor }, conditions shown }.
-- Days showing only the same plan scene share a record of up to 7 days; a day with more scenes closes it.
---@param events table[]
---@return table[]
xi.chocoboRaising.condenseEvents = function(events)
    local condensedEvents = {}
    local currentSpan     = nil
    local spanOpen        = false

    debug('Raw Events')
    for _, entry in ipairs(events) do
        local eventDay    = entry[1]
        local eventCSList = entry[2]
        local outcome     = entry[3]
        local conditions  = entry[4]

        debug('  Day', eventDay, ':', eventCSList[1])

        if
            currentSpan and
            spanOpen and
            eventDay == currentSpan[2] + 1 and
            eventDay - currentSpan[1] < maxRecordDays and
            eventCSList[1] == currentSpan[3][1]
        then
            currentSpan[2] = eventDay

            for i = 2, #eventCSList do
                table.insert(currentSpan[3], eventCSList[i])
            end
        else
            currentSpan = { eventDay, eventDay, {}, { gil = 0, good = 0, poor = 0 }, 0 }
            table.insert(condensedEvents, currentSpan)

            for _, cs in ipairs(eventCSList) do
                table.insert(currentSpan[3], cs)
            end
        end

        currentSpan[5] = bit.bor(currentSpan[5], conditions or 0)

        if outcome then
            currentSpan[4].gil  = currentSpan[4].gil + outcome.gil
            currentSpan[4].good = currentSpan[4].good + outcome.good
            currentSpan[4].poor = currentSpan[4].poor + outcome.poor
        end

        spanOpen = #eventCSList <= 1

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

    debug('Condensed Events & Spans')
    for _, entry in ipairs(condensedEvents) do
        local csList = entry[3]
        if #csList > 1 then
            debug('  Days', entry[1], 'to', entry[2], ':', string.format('%s (+%d events)', tostring(csList[1]), #csList - 1))
        else
            debug('  Days', entry[1], 'to', entry[2], ':', csList[1])
        end
    end

    return condensedEvents
end
