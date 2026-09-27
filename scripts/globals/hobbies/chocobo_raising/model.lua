-----------------------------------
-- Chocobo Raising - Day Model
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/care_plan')
require('scripts/globals/hobbies/chocobo_raising/condense_events')
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.model = xi.chocoboRaising.model or {}

-----------------------------------
-- Constants
-----------------------------------
local model = xi.chocoboRaising.model

-- Success is once per character; a miss repeats on the next chick. DONE is kept as a user flag, not in the var.
xi.chocoboRaising.handkerchiefVar = '[ChocoboRaising]Handkerchief'
xi.chocoboRaising.whistleQuestVar = 'HQuest[ChocoboWhistle]Prog'

-- Set when a day passes with the handkerchief held; zoning clears it.
xi.chocoboRaising.handkerchiefZoneVar = '[ChocoboRaising]HandkerchiefZone'

-- Debug: conditions that start on the next rollover, one bit each.
xi.chocoboRaising.debugOnsetVar = '[ChocoboRaising]DebugOnset'

local cond   = xi.chocoboRaising.conditions
local stages = xi.chocoboRaising.stage
local odds   = xi.chocoboRaising.odds

local handkerchiefStartDay  = 7
local handkerchiefCancelDay = 15

local averageStat = 96

-- A chick loses this much hunger overnight per point of energy it needs to refill; fitted to 20 captured nights.
local chickHungerPerEnergy = 2.25

-----------------------------------
-- Tables
-----------------------------------
---@enum xi.chocoboRaising.whistleProg
xi.chocoboRaising.whistleProg =
{
    NOT_STARTED   = 0,
    SEE_HANTILEON = 1,
    SEARCH        = 2,
    FOUND         = 3,
    DONE          = 4,
}

---@enum xi.chocoboRaising.handkerchief
xi.chocoboRaising.handkerchief =
{
    NONE       = 0,
    GIVEN      = 1,
    RETURNED   = 2, -- Handed back; the next report plays the cured scene
    DONE       = 3,
    CANCELLED  = 4, -- Taken back on day 15 for this chick
    DAY_PASSED = 5, -- A report day passed after it was given
}

local handkerchief = xi.chocoboRaising.handkerchief

local dominantPersonality =
{
    xi.chocoboRaising.temperament.ILL_TEMPERED,
    xi.chocoboRaising.temperament.VERY_PATIENT,
    xi.chocoboRaising.temperament.QUITE_SENSITIVE,
    xi.chocoboRaising.temperament.ENIGMATIC,
}

-- Fixed on day 29. A feature needs its stat highest and at Average (96) or better; ties give each.
-- TODO: Each feature should also add a hidden point to its stat.
local appearanceFlags =
{
    xi.chocoboRaising.appearance.LARGE_TALONS,
    xi.chocoboRaising.appearance.FULL_TAIL,
    xi.chocoboRaising.appearance.LARGE_BEAK,
}

-- Report order when several conditions change on one rollover.
local conditionOrder =
{
    cond.CRYING_AT_NIGHT,
    cond.RUN_AWAY,
    cond.LONELY,
    cond.HIGH_SPIRITS,
    cond.INJURED,
    cond.SICK,
    cond.VERY_ILL,
    cond.STOMACHACHE,
    cond.FULL_OF_ENERGY,
    cond.BORED,
    cond.SPOILED,
    cond.LOVESICK,
    cond.BRIGHT_AND_FOCUSED,
    cond.SLEEPING,
}

-- No scene marks these starting or ending, and they can start again on the rollover that ends them.
local silentConditions = set({ cond.SLEEPING, cond.CRYING_AT_NIGHT })

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboCharacterView
---@field handkerchief         xi.chocoboRaising.handkerchief
---@field hasWhistle           boolean
---@field whistleProg          xi.chocoboRaising.whistleProg?
---@field debugOnset           integer?
---@field hasWhiteHandkerchief boolean
---@field handkerchiefSameZone boolean

---@class ChocoboAdvanceContext
---@field dayLength integer
---@field character ChocoboCharacterView

-----------------------------------
-- Helpers
-----------------------------------
-- Returns indexes into statFields.
local function highestStats(state)
    local highest = -1
    local indexes = {}

    for index, field in ipairs(xi.chocoboRaising.statFields) do
        if state[field] > highest then
            highest = state[field]
            indexes = { index }
        elseif state[field] == highest then
            table.insert(indexes, index)
        end
    end

    return indexes, highest
end

-- Captures show neither before the adolescent stage.
local function afterHappy(state, today)
    if
        state.stage >= stages.ADOLESCENT and
        utils.mask.getBit(today.held, cond.HIGH_SPIRITS)
    then
        return odds.afterHappy
    end

    return 0
end

-----------------------------------
-- Private Functions
-----------------------------------
local function advanceStage(state, day, cutscenes)
    for _, entry in ipairs(xi.chocoboRaising.ageBoundaries()) do
        if state.stage == entry[1] and day >= entry[2] then
            table.insert(cutscenes, entry[3])
            state.stage = entry[4]

            -- Growing up cures every condition.
            state.conditions = 0

            if
                state.stage == stages.ADULT_3 and
                not xi.chocoboRaising.isNamed(state)
            then
                state.first_name = xi.chocoboNames.getRandomName()
                state.last_name  = ''
            end

            return state.stage
        end
    end

    return nil
end

-- Cures fed today apply at the next rollover. Pending cures sit in bits 16 up; bit 15 flags one.
-- Returns the cured conditions.
local function applyPendingCures(state, cutscenes)
    local pending = bit.rshift(state.conditions, xi.chocoboRaising.pendingCureShift)
    local cured   = 0

    for condition = 0, cond.BRIGHT_AND_FOCUSED do
        if
            utils.mask.getBit(pending, condition) and
            xi.chocoboRaising.getCondition(state, condition)
        then
            xi.chocoboRaising.setCondition(state, condition, false)
            table.insert(cutscenes, xi.chocoboRaising.cutscenes.INJURY_HAS_HEALED + condition)
            cured = bit.bor(cured, bit.lshift(1, condition))
        end
    end

    state.conditions = bit.band(state.conditions, xi.chocoboRaising.conditionMask)

    return cured
end

-- Returns the conditions that ended with a scene. A minor illness may turn serious instead.
local function endConditions(state, held, scenes)
    local shown = 0

    for _, condition in ipairs(conditionOrder) do
        if utils.mask.getBit(held, condition) then
            if
                condition == cond.SICK and
                xi.chocoboRaising.rolls(odds.sickWorsens)
            then
                xi.chocoboRaising.setCondition(state, cond.SICK, false)
                xi.chocoboRaising.setCondition(state, cond.VERY_ILL, true)
                scenes[cond.VERY_ILL] = xi.chocoboRaising.cutscenes.IS_INJURED + cond.VERY_ILL
                shown = bit.bor(shown, bit.lshift(1, cond.SICK))
            elseif xi.chocoboRaising.rolls(xi.chocoboRaising.conditionEndOdds[condition]) then
                xi.chocoboRaising.setCondition(state, condition, false)

                if not silentConditions[condition] then
                    scenes[condition] = xi.chocoboRaising.cutscenes.INJURY_HAS_HEALED + condition
                    shown = bit.bor(shown, bit.lshift(1, condition))
                end
            end
        end
    end

    return shown
end

local function forceConditions(state, mask, scenes)
    for _, condition in ipairs(conditionOrder) do
        if
            utils.mask.getBit(mask, condition) and
            not xi.chocoboRaising.getCondition(state, condition)
        then
            xi.chocoboRaising.setCondition(state, condition, true)

            if not silentConditions[condition] then
                scenes[condition] = xi.chocoboRaising.cutscenes.IS_INJURED + condition
            end
        end
    end
end

-- Given on day 7, taken back on day 15, never offered to a whistle holder.
local function advanceHandkerchief(character, day, cutscenes, effects)
    if character.handkerchief == handkerchief.RETURNED then
        table.insert(cutscenes, xi.chocoboRaising.cutscenes.WHITE_HANDKERCHIEF_END)
        character.handkerchief = handkerchief.DONE
        table.insert(effects, { xi.chocoboRaising.effect.SET_HANDKERCHIEF, handkerchief.DONE })
    elseif
        day == handkerchiefStartDay and
        character.handkerchief ~= handkerchief.DONE and
        not character.hasWhistle
    then
        table.insert(cutscenes, xi.chocoboRaising.cutscenes.CRYING_AT_NIGHT)
        character.handkerchief = handkerchief.GIVEN
        table.insert(effects, { xi.chocoboRaising.effect.ADD_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF })
        table.insert(effects, { xi.chocoboRaising.effect.SET_HANDKERCHIEF, handkerchief.GIVEN })
    elseif
        day == handkerchiefCancelDay and
        (character.handkerchief == handkerchief.GIVEN or character.handkerchief == handkerchief.DAY_PASSED)
    then
        table.insert(cutscenes, xi.chocoboRaising.cutscenes.HAVENT_SEEN_YOU)
        character.handkerchief = handkerchief.CANCELLED
        table.insert(effects, { xi.chocoboRaising.effect.DEL_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF })
        table.insert(effects, { xi.chocoboRaising.effect.SET_HANDKERCHIEF, handkerchief.CANCELLED })
    elseif character.handkerchief == handkerchief.GIVEN then
        character.handkerchief = handkerchief.DAY_PASSED
        table.insert(effects, { xi.chocoboRaising.effect.SET_HANDKERCHIEF, handkerchief.DAY_PASSED })
        table.insert(effects, { xi.chocoboRaising.effect.SET_LOCAL_VAR, xi.chocoboRaising.handkerchiefZoneVar, 1 })
    end
end

-- Each returns the onset chance in percent. today: { day, plan, held, forcedFed, handkerchief }.
local onsetOdds =
{
    [cond.CRYING_AT_NIGHT] = function(state, today)
        if
            state.stage ~= stages.CHICK or
            (today.handkerchief ~= handkerchief.GIVEN and today.handkerchief ~= handkerchief.DAY_PASSED)
        then
            return 0
        end

        if today.day == handkerchiefStartDay then
            return 100
        end

        return odds.crying
    end,

    [cond.RUN_AWAY] = function(state, today)
        if xi.chocoboRaising.affectionToAffectionRank(state.affection) == xi.chocoboRaising.affectionRank.DOESNT_CARE then
            return odds.runAway
        end

        return 0
    end,

    [cond.LONELY] = function(state, today)
        if
            state.stage >= stages.ADULT_1 and
            xi.chocoboRaising.affectionToAffectionRank(state.affection) == xi.chocoboRaising.affectionRank.DOESNT_CARE
        then
            return odds.lonely
        end

        return 0
    end,

    [cond.HIGH_SPIRITS] = function(state, today)
        if state.stage == stages.ADOLESCENT then
            return odds.happyAdolescent
        end

        if state.stage ~= stages.CHICK then
            return 0
        end

        if today.day == 5 or today.day == 6 then
            return odds.happyHatch
        end

        return odds.happyChick
    end,

    [cond.INJURED] = function(state, today)
        local data = xi.chocoboRaising.carePlanData[today.plan]
        if data and data.pay then
            return odds.injuredPaidPlan
        end

        return 0
    end,

    [cond.SICK] = function(state, today)
        if utils.mask.getBit(bit.bor(today.held, state.conditions), cond.VERY_ILL) then
            return 0
        end

        if state.stage == stages.CHICK then
            return odds.sickChick
        end

        return odds.sick
    end,

    [cond.STOMACHACHE] = function(state, today)
        if today.forcedFed then
            return odds.stomachacheForced
        end

        return 0
    end,

    [cond.FULL_OF_ENERGY] = afterHappy,

    [cond.BORED] = function(state, today)
        if state.stage == stages.ADOLESCENT then
            return odds.boredAdolescent
        end

        if state.stage >= stages.ADULT_1 then
            return odds.boredAdult
        end

        return 0
    end,

    [cond.SPOILED] = function(state, today)
        return odds.spoiled
    end,

    [cond.LOVESICK] = function(state, today)
        if state.stage >= stages.ADULT_2 then
            return odds.lovesick
        end

        return 0
    end,

    [cond.BRIGHT_AND_FOCUSED] = afterHappy,

    [cond.SLEEPING] = function(state, today)
        if today.plan == xi.chocoboRaising.carePlans.RESTING then
            return 100
        end

        return 0
    end,
}

local function startConditions(state, today, scenes)
    if state.stage == stages.EGG or state.stage == stages.ADULT_4 then
        return
    end

    for _, condition in ipairs(conditionOrder) do
        local onsetChance = onsetOdds[condition]

        if
            onsetChance and
            not xi.chocoboRaising.getCondition(state, condition) and
            (silentConditions[condition] or not utils.mask.getBit(today.held, condition)) and
            xi.chocoboRaising.rolls(onsetChance(state, today))
        then
            xi.chocoboRaising.setCondition(state, condition, true)

            if not silentConditions[condition] then
                scenes[condition] = xi.chocoboRaising.cutscenes.IS_INJURED + condition
            end
        end
    end
end

-- The plan locked yesterday runs today, so a plan set on day N first runs on day N + 2.
---@param state table
---@param day integer
---@param character ChocoboCharacterView
---@param events table[]
---@param effects ChocoboEffect[]
local function advanceDay(state, day, character, events, effects)
    local plan = state.locked_plan
    local away = utils.mask.getBit(state.conditions, cond.RUN_AWAY)

    -- A day spent away uses up the plan day but carries out nothing.
    local cutscenes = away and {} or { plan }

    local forcedFed = utils.mask.getBit(state.conditions, xi.chocoboRaising.forcedFeedFlag)
    local shown     = applyPendingCures(state, cutscenes)

    local outcome =
    {
        gil  = 0,
        good = 0,
        poor = 0,
    }

    -- TODO: The day after Rest can start well below full energy.
    -- The care plan refills energy, so what the day left is read first.
    local endEnergy = state.energy
    if not away then
        outcome = xi.chocoboRaising.runCarePlan(state, plan, day)
    end

    state.locked_plan = xi.chocoboRaising.consumeCarePlanDay(state)

    if outcome.gil > 0 then
        table.insert(effects, { xi.chocoboRaising.effect.ADD_GIL, outcome.gil })
    end

    -- Personality follows the highest stat from hatching until day 19, then stays. A tie is easygoing.
    if
        state.stage ~= stages.EGG and
        day <= xi.chocoboRaising.daysToAdolescent
    then
        local indexes = highestStats(state)
        if #indexes == 1 then
            state.personality = dominantPersonality[indexes[1]]
        else
            state.personality = xi.chocoboRaising.temperament.VERY_EASYGOING
        end
    end

    local held   = state.conditions
    local scenes = {}

    shown = bit.bor(shown, endConditions(state, held, scenes))

    local grewTo = advanceStage(state, day, cutscenes)

    -- An egg, and a chick on the day it hatches, are completely full. A chick goes hungrier after a busy
    -- day; older chocobos start every captured day starving.
    if
        state.stage == stages.EGG or
        grewTo == stages.CHICK
    then
        state.hunger = xi.chocoboRaising.maxHunger
    elseif state.stage == stages.CHICK then
        state.hunger = math.max(state.hunger - math.floor(chickHungerPerEnergy * (100 - endEnergy)), 0)
    else
        state.hunger = 0
    end

    -- Growing up clears every condition, so nothing queued above plays.
    if grewTo then
        scenes = {}
        shown  = 0
    end

    if grewTo == stages.ADULT_1 then
        local indexes, highest = highestStats(state)

        state.appearance = 0
        if highest >= averageStat then
            for _, index in ipairs(indexes) do
                if appearanceFlags[index] then
                    state.appearance = bit.bor(state.appearance, appearanceFlags[index])
                end
            end
        end

        -- The whistle quest starts whatever the handkerchief outcome. San d'Oria raisers skip the visit to Hantileon.
        if
            character.whistleProg == xi.chocoboRaising.whistleProg.NOT_STARTED and
            not character.hasWhistle
        then
            local fromSanDoria = state.location == xi.chocoboRaising.raisingLocation[xi.zone.SOUTHERN_SAN_DORIA]
            character.whistleProg = fromSanDoria and xi.chocoboRaising.whistleProg.SEARCH or xi.chocoboRaising.whistleProg.SEE_HANTILEON

            table.insert(effects, { xi.chocoboRaising.effect.SET_WHISTLE_PROGRESS, character.whistleProg })
        end
    end

    advanceHandkerchief(character, day, cutscenes, effects)

    ---@type xi.chocoboRaising.carePlans?
    local todaysPlan = plan
    if away then
        todaysPlan = nil
    end

    local today =
    {
        day          = day,
        plan         = todaysPlan,
        held         = held,
        forcedFed    = forcedFed,
        handkerchief = character.handkerchief,
    }

    startConditions(state, today, scenes)

    if character.debugOnset ~= 0 then
        forceConditions(state, character.debugOnset, scenes)
        character.debugOnset = 0
        table.insert(effects, { xi.chocoboRaising.effect.SET_CHAR_VAR, xi.chocoboRaising.debugOnsetVar, 0 })
    end

    for _, condition in ipairs(conditionOrder) do
        if scenes[condition] then
            table.insert(cutscenes, scenes[condition])
        end
    end

    table.insert(events, { day, cutscenes, outcome, bit.bor(shown, state.conditions) })
end

-----------------------------------
-- Global Functions
-----------------------------------
-- Needs a report day to pass and then a zone.
---@param character ChocoboCharacterView
---@return boolean
model.canReturnHandkerchief = function(character)
    return character.handkerchief == handkerchief.DAY_PASSED and
        character.hasWhiteHandkerchief and
        not character.handkerchiefSameZone
end

-- A chocobo that leaves while the handkerchief is out counts as a miss.
---@param character ChocoboCharacterView
---@return ChocoboEffect[]
model.cancelHandkerchief = function(character)
    if
        character.handkerchief ~= handkerchief.GIVEN and
        character.handkerchief ~= handkerchief.DAY_PASSED
    then
        return {}
    end

    return
    {
        { xi.chocoboRaising.effect.DEL_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF },
        { xi.chocoboRaising.effect.SET_HANDKERCHIEF, handkerchief.CANCELLED },
    }
end

---@return ChocoboEffect[]
model.returnHandkerchief = function()
    return
    {
        { xi.chocoboRaising.effect.DEL_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF },
        { xi.chocoboRaising.effect.SET_HANDKERCHIEF, handkerchief.RETURNED },
    }
end

---@param state table
---@param now integer
---@param ctx ChocoboAdvanceContext
---@return table[]
---@return ChocoboEffect[]
model.advance = function(state, now, ctx)
    -- Day 1 ends one day after the egg trade.
    local lastDay   = utils.clamp(math.floor((now - state.created) / ctx.dayLength), 0, xi.chocoboRaising.lastDay())
    local character =
    {
        handkerchief = ctx.character.handkerchief,
        hasWhistle   = ctx.character.hasWhistle,
        whistleProg  = ctx.character.whistleProg or 0,
        debugOnset   = ctx.character.debugOnset or 0,
    }

    local events  = {}
    local effects = {}

    for day = state.last_update_age, lastDay do
        advanceDay(state, day, character, events, effects)
    end

    state.last_update_age = math.max(state.last_update_age, lastDay + 1)

    return xi.chocoboRaising.condenseEvents(events), effects
end

-- The next advance applies the skipped days.
---@param state table
---@param days integer
---@param dayLength integer
---@return nil
model.moveTime = function(state, days, dayLength)
    state.created = state.created - days * dayLength
end

---@param state table
---@param stage xi.chocoboRaising.stage
---@param now integer
---@param dayLength integer
---@return nil
model.setStage = function(state, stage, now, dayLength)
    -- With retirement off no row leads to the retired stage.
    local firstDay = stage == stages.ADULT_4 and xi.chocoboRaising.daysToAdult4 or 0

    for _, entry in ipairs(xi.chocoboRaising.ageBoundaries()) do
        if entry[4] == stage then
            firstDay = entry[2]
        end
    end

    state.created         = now - firstDay * dayLength
    state.last_update_age = firstDay + 1
    state.stage           = stage
end
