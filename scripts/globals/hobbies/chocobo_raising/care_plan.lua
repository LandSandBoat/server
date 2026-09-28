-----------------------------------
-- Chocobo Raising - Care Plans and Stats
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

-----------------------------------
-- Tables
-----------------------------------
xi.chocoboRaising.statFields = { 'strength', 'endurance', 'discernment', 'receptivity' }

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboOutcome
---@field gil  integer
---@field good integer
---@field poor integer

-----------------------------------
-- Helpers
-----------------------------------
-- The schedule is four bytes, plan 1 in the high byte: days in the high nibble, plan in the low.
local function readSchedule(chocoState)
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

    return plans
end

local function writeSchedule(chocoState, plans)
    local newCarePlan = 0
    for i = 0, 3 do
        local offset = 24 - (i * 8)
        newCarePlan  = bit.bor(newCarePlan, bit.lshift(plans[i + 1].length, offset + 4))
        newCarePlan  = bit.bor(newCarePlan, bit.lshift(plans[i + 1].type,   offset))
    end

    chocoState.care_plan = newCarePlan
end

-----------------------------------
-- Private Functions
-----------------------------------
local function successChance(chocoState, data)
    local statRank = 0
    for _, field in ipairs(data.successStats) do
        statRank = statRank + xi.chocoboRaising.numberToRank(chocoState[field])
    end

    statRank = statRank / #data.successStats

    local affectionRank = xi.chocoboRaising.affectionToAffectionRank(chocoState.affection)

    -- Guess taken from guides; no capture behind it.
    return utils.clamp(60 + affectionRank * 5 + math.floor(statRank * 3) - data.difficulty * 5, 5, 95)
end

-----------------------------------
-- Global Functions
-----------------------------------
---@param stat xi.chocoboRaising.carePlanStats
---@param value number
---@param change number
---@param max number
---@return number
xi.chocoboRaising.handleStatChange = function(stat, value, change, max)
    if change == 0 then
        return value
    end

    if change > 0 then
        debug(string.format('  %s += %i', xi.chocoboRaising.carePlanStatNames[stat], change))
        change = change * xi.chocoboRaising.statPositiveMultiplier
    else
        debug(string.format('  %s -= %i', xi.chocoboRaising.carePlanStatNames[stat], -change))
        change = change * xi.chocoboRaising.statNegativeMultiplier
    end

    -- TODO: Green Race Silks energy effect.

    return utils.clamp(value + change, 0, max)
end

-- Applies the multiplier settings, the 0-255 range and the total cap.
---@param chocoState table
---@param field string
---@param change number
---@return nil
xi.chocoboRaising.addToStat = function(chocoState, field, change)
    if change == 0 then
        return
    end

    local multiplier = change > 0 and xi.chocoboRaising.statPositiveMultiplier or xi.chocoboRaising.statNegativeMultiplier
    change           = math.floor(change * multiplier)

    local cap = xi.chocoboRaising.statGrowthCap
    if change > 0 and cap > 0 then
        local total = 0
        for _, statField in ipairs(xi.chocoboRaising.statFields) do
            total = total + chocoState[statField]
        end

        change = math.min(change, math.max(cap - total, 0))
    end

    chocoState[field] = utils.clamp(chocoState[field] + change, 0, 255)
end

-- Returns plan 1 and takes a day from it. Empty slots refill with 7 days of Basic Care.
---@param chocoState table
---@return xi.chocoboRaising.carePlans
xi.chocoboRaising.consumeCarePlanDay = function(chocoState)
    local plans    = readSchedule(chocoState)
    local planType = plans[1].type

    plans[1].length = plans[1].length - 1
    if plans[1].length == 0 then
        table.remove(plans, 1)
        table.insert(plans, { length = 7, type = xi.chocoboRaising.carePlans.BASIC_CARE })
    end

    writeSchedule(chocoState, plans)

    return planType
end

---@param chocoState table
---@param carePlan xi.chocoboRaising.carePlans
---@param day integer
---@return ChocoboOutcome
xi.chocoboRaising.runCarePlan = function(chocoState, carePlan, day)
    local data = xi.chocoboRaising.carePlanData[carePlan]
    if not data then
        print(string.format('ERROR! Invalid carePlan (%s) passed to runCarePlan.', tostring(carePlan)))
        return
        {
            gil  = 0,
            good = 0,
            poor = 0,
        }
    end

    debug(string.format('Execute Care Plan: %i', carePlan))

    local succeeded = math.randomInt(1, 100) <= successChance(chocoState, data)

    -- Guess: plans stop lowering stats once growth stabilises on day 64.
    local stable = day >= xi.chocoboRaising.daysToAdult3

    for index, field in ipairs(xi.chocoboRaising.statFields) do
        local arrows = data.stats[index]
        local change = 0

        if carePlan == xi.chocoboRaising.carePlans.BASIC_CARE then
            -- Guess from guides: one day in six.
            if math.randomInt(1, 6) == 1 then
                change = 1
            end
        elseif arrows ~= 0 then
            for _ = 1, math.abs(arrows) do
                change = change + math.randomInt(xi.chocoboRaising.statPerPlanArrow[1], xi.chocoboRaising.statPerPlanArrow[2])
            end

            if arrows < 0 then
                change = -change
            end
        end

        -- Guess: a poor day halves the change toward zero, so it never deepens a loss.
        if not succeeded then
            local halved = math.floor(math.abs(change) / 2)
            change       = change < 0 and -halved or halved
        end

        if change > 0 or not stable then
            xi.chocoboRaising.addToStat(chocoState, field, change)
        end
    end

    chocoState.affection = utils.clamp(chocoState.affection + data.affection * xi.chocoboRaising.affectionPerPlanArrow, 0, 255)

    -- Energy refills every day, less the plan's cost; a poor day costs more.
    local energyCost = succeeded and data.energy or data.energy + data.poorEnergy

    chocoState.energy = utils.clamp(100 - energyCost, 0, 100)

    -- Rest cures each bad condition half the time.
    if carePlan == xi.chocoboRaising.carePlans.RESTING then
        for _, condition in ipairs(xi.chocoboRaising.badConditions) do
            if
                xi.chocoboRaising.getCondition(chocoState, condition) and
                math.randomInt(1, 2) == 1
            then
                xi.chocoboRaising.setCondition(chocoState, condition, false)
            end
        end
    end

    local outcome =
    {
        gil  = 0,
        good = 0,
        poor = 0,
    }

    if succeeded then
        outcome.good = 1
    else
        outcome.poor = 1
    end

    if data.pay then
        local pay   = succeeded and data.pay[1] or data.pay[2]
        outcome.gil = math.floor(pay * xi.chocoboRaising.gilMultiplier)
    end

    return outcome
end
