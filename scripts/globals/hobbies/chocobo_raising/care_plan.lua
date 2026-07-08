-----------------------------------
-- Chocobo Raising - Care Plans
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

xi.chocoboRaising.handleStatChange = function(stat, value, change, max)
    if change == 0 then
        return value
    end

    if change > 0 then
        debug(string.format('  %s += %i', xi.chocoboRaising.carePlanStatNames[stat], change))
        change = change * xi.settings.main.CHOCOBO_RAISING_STAT_POS_MULTIPLIER
    elseif change < 0 then
        debug(string.format('  %s -= %i', xi.chocoboRaising.carePlanStatNames[stat], -change))
        change = change * xi.settings.main.CHOCOBO_RAISING_STAT_NEG_MULTIPLIER
    end

    -- TODO: Handle Green Racing Silks here for energy?
    -- https://ffxiclopedia.fandom.com/wiki/Green_Race_Silks

    return utils.clamp(value + change, 0, max)
end

xi.chocoboRaising.handleCarePlan = function(player, chocoState, carePlan, elapsedDays)
    elapsedDays = elapsedDays or 1

    debug(string.format('Execute Care Plan: %i days', elapsedDays))

    -- Extract scheduled care plans
    local plans = {}
    for i = 0, 3 do
        local offset   = 24 - (i * 8)
        local length   = bit.band(bit.rshift(chocoState.care_plan, offset + 4), 0xF)
        local planType = bit.band(bit.rshift(chocoState.care_plan, offset), 0xF)

        if length == 0 then
            length   = 7
            planType = xi.chocoboRaising.carePlans.BASIC_CARE
        end

        table.insert(plans, { length = length, type = planType })
    end

    -- Advance time and shift care plans as they are consumed
    local remainingDays = elapsedDays
    while remainingDays > 0 do
        local deduct = math.min(plans[1].length, remainingDays)
        plans[1].length = plans[1].length - deduct
        remainingDays = remainingDays - deduct

        if plans[1].length == 0 then
            table.remove(plans, 1)
            table.insert(plans, { length = 7, type = xi.chocoboRaising.carePlans.BASIC_CARE })
        end
    end

    -- Reconstruct care_plan bitmask
    local newCarePlan = 0
    for i = 0, 3 do
        local offset = 24 - (i * 8)
        newCarePlan = bit.bor(newCarePlan, bit.lshift(plans[i + 1].length, offset + 4))
        newCarePlan = bit.bor(newCarePlan, bit.lshift(plans[i + 1].type,   offset))
    end

    chocoState.care_plan = newCarePlan

    -- Apply stat changes
    local data = xi.chocoboRaising.carePlanData[carePlan]
    if data then
        chocoState.strength    = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.STRENGTH,    chocoState.strength,    data[1] * elapsedDays, 255)
        chocoState.endurance   = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.ENDURANCE,   chocoState.endurance,   data[2] * elapsedDays, 255)
        chocoState.discernment = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.DISCERNMENT, chocoState.discernment, data[3] * elapsedDays, 255)
        chocoState.receptivity = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.RECEPTIVITY, chocoState.receptivity, data[4] * elapsedDays, 255)
        chocoState.affection   = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.AFFECTION,   chocoState.affection,   data[5] * elapsedDays, 255)

        -- After each day the chocobo's energy is refreshed, so only previous day's energy cost is applied
        chocoState.energy = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.ENERGY, 100, data[6], 100)

        local payment = data[7]
        if payment then
            payment = payment * elapsedDays * xi.settings.main.CHOCOBO_RAISING_GIL_MULTIPLIER
            debug(string.format('Care Plan Payment: %d', payment))
            -- TODO: Handle payment using player object
            utils.unused(player)
        end
    else
        print(string.format('ERROR! Invalid carePlan (%s) passed to handleCarePlan.', tostring(carePlan)))
    end
end
