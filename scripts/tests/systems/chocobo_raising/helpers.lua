-----------------------------------
-- Rolls, states and effect checks for the tests that run the raising rules with no player.
-----------------------------------
local helpers = {}

helpers.dayLength = 86400
helpers.created   = 1000000

-- Returns the next value from `rolls` inside the range, then the lowest value.
---@param rolls integer[]
function helpers.scriptedRolls(rolls)
    local queue = { unpack(rolls) }

    return function(low, high)
        local roll = table.remove(queue, 1) or low

        return utils.clamp(roll, low, high)
    end
end

function helpers.lowestRoll(low, high)
    return low
end

function helpers.highestRoll(low, high)
    return high
end

-- A nil value matches any.
---@param effects table[]
---@param kind string
---@param id any
---@param value any?
---@return boolean
function helpers.hasEffect(effects, kind, id, value)
    for _, effect in ipairs(effects) do
        if
            effect[1] == kind and
            effect[2] == id and
            (not value or effect[3] == value)
        then
            return true
        end
    end

    return false
end

-- A new egg on Basic Care, created at `helpers.created`.
function helpers.newState()
    return
    {
        first_name      = 'Chocobo',
        last_name       = 'Chocobo',
        created         = helpers.created,
        last_update_age = 1,
        stage           = xi.chocoboRaising.stage.EGG,
        strength        = 0,
        endurance       = 0,
        discernment     = 0,
        receptivity     = 0,
        affection       = 255,
        energy          = 100,
        hunger          = 0,
        conditions      = 0,
        personality     = 0,
        ability1        = 0,
        ability2        = 0,
        appearance      = 0,
        care_plan       = 0x70707070,
        locked_plan     = xi.chocoboRaising.carePlans.BASIC_CARE,
    }
end

-- A chocobo `day` days into its raise, running `plan` (Basic Care by default) on the next day.
function helpers.stateOnDay(day, stage, plan)
    local state = helpers.newState()
    state.stage           = stage
    state.locked_plan     = plan or xi.chocoboRaising.carePlans.BASIC_CARE
    state.created         = helpers.created - day * helpers.dayLength
    state.last_update_age = day + 1

    return state
end

return helpers
