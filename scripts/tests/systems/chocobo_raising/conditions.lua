-----------------------------------
-- Condition onset, duration and cures, and the stat foods.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local dayLength = helpers.dayLength
local created   = helpers.created
local model     = xi.chocoboRaising.model
local cond      = xi.chocoboRaising.conditions
local stages    = xi.chocoboRaising.stage
local plans     = xi.chocoboRaising.carePlans
local odds      = xi.chocoboRaising.odds
local kerchief  = xi.chocoboRaising.handkerchief
local scenes    = xi.chocoboRaising.cutscenes

local stateOnDay = helpers.stateOnDay

-- Only rolls with a 100% chance succeed.
local lowestRoll = helpers.lowestRoll

local function withConditions(state, ...)
    for _, condition in ipairs({ ... }) do
        xi.chocoboRaising.setCondition(state, condition, true)
    end

    return state
end

-- Percent rolls succeed for any chance of at least `percent`; other rolls return their lowest value.
local function rollsAt(percent)
    return function(low, high)
        if high == 100 then
            return 101 - percent
        end

        return low
    end
end

-- The stubbed math.randomInt answers with this.
local currentRolls = lowestRoll

-- Runs `days` rollovers, one by default, answering every roll with `rolls`.
local function advance(state, rolls, handkerchief, days)
    currentRolls = rolls

    local ctx =
    {
        dayLength = dayLength,
        character = { handkerchief = handkerchief or kerchief.DONE },
    }

    return model.advance(state, created + (days or 1) * dayLength + 60, ctx)
end

local function heard(records, cutscene)
    for _, record in ipairs(records) do
        for _, played in ipairs(record[3]) do
            if played == cutscene then
                return true
            end
        end
    end

    return false
end

-- spec: { day, stage, plan, affection, held = { conditions }, forcedFeed, handkerchief }
local function build(spec)
    local state = withConditions(stateOnDay(spec[1], spec[2], spec.plan), unpack(spec.held or {}))
    state.affection = spec.affection or state.affection

    if spec.forcedFeed then
        state.conditions = bit.bor(state.conditions, bit.lshift(1, xi.chocoboRaising.forcedFeedFlag))
    end

    return state
end

describe('Chocobo raising conditions', function()
    before_each(function()
        currentRolls = lowestRoll
        stub('math.randomInt', function(low, high)
            return currentRolls(low, high)
        end)
    end)

    describe('onset', function()
        local chick      = { 9, stages.CHICK }
        local adolescent = { 20, stages.ADOLESCENT }
        local adult      = { 40, stages.ADULT_1 }

        local onsets =
        {
            { 'happiness on a chick\'s first days',           cond.HIGH_SPIRITS,       odds.happyHatch,        { 4, stages.CHICK } },
            { 'happiness in a chick',                          cond.HIGH_SPIRITS,       odds.happyChick,        chick },
            { 'happiness in an adolescent',                    cond.HIGH_SPIRITS,       odds.happyAdolescent,   adolescent },
            { 'minor illness in a chick',                      cond.SICK,               odds.sickChick,         chick },
            { 'minor illness in an adolescent',                cond.SICK,               odds.sick,              adolescent },
            { 'minor illness in an adult',                     cond.SICK,               odds.sick,              adult },
            { 'injury on a paid plan',                         cond.INJURED,            odds.injuredPaidPlan,   { 20, stages.ADOLESCENT, plan = plans.CARRYING_PACKAGES } },
            { 'boredom in an adolescent',                      cond.BORED,              odds.boredAdolescent,   adolescent },
            { 'boredom in an adult',                           cond.BORED,              odds.boredAdult,        adult },
            { 'love from day 43',                              cond.LOVESICK,           odds.lovesick,          { 50, stages.ADULT_2 } },
            { 'spoiling',                                      cond.SPOILED,            odds.spoiled,           chick },
            { 'vitality the day after happiness',              cond.FULL_OF_ENERGY,     odds.afterHappy,        { 20, stages.ADOLESCENT, held = { cond.HIGH_SPIRITS } } },
            { 'intelligence the day after happiness',          cond.BRIGHT_AND_FOCUSED, odds.afterHappy,        { 20, stages.ADOLESCENT, held = { cond.HIGH_SPIRITS } } },
            { 'a stomachache after a forced feed',             cond.STOMACHACHE,        odds.stomachacheForced, { 20, stages.ADOLESCENT, forcedFeed = true } },
            { 'loneliness at affection rank 0',                cond.LONELY,             odds.lonely,            { 40, stages.ADULT_1, affection = 0 } },
            { 'running away while lonely at affection rank 0', cond.RUN_AWAY,           odds.runAway,           { 40, stages.ADULT_1, affection = 0, held = { cond.LONELY } } },
            { 'crying while the handkerchief is out',          cond.CRYING_AT_NIGHT,    odds.crying,            { 9, stages.CHICK, handkerchief = kerchief.DAY_PASSED } },
        }

        it('starts each condition at its chance and not above it, with its onset scene', function()
            for _, case in ipairs(onsets) do
                local name      = case[1]
                local condition = case[2]
                local percent   = case[3]
                local spec      = case[4]

                local state   = build(spec)
                local records = advance(state, rollsAt(percent), spec.handkerchief)
                assert(xi.chocoboRaising.getCondition(state, condition), string.format('Expected %s at a %d%% roll', name, percent))
                assert(bit.band(records[1][5], bit.lshift(1, condition)) ~= 0, string.format('Expected %s in the report record', name))

                state = build(spec)
                advance(state, rollsAt(percent + 1), spec.handkerchief)
                assert(not xi.chocoboRaising.getCondition(state, condition), string.format('Expected no %s above %d%%', name, percent))
            end

            local bored        = stateOnDay(20, stages.ADOLESCENT)
            local boredRecords = advance(bored, rollsAt(odds.boredAdolescent))
            assert(heard(boredRecords, scenes.REALLY_BORED), 'Expected the bored scene')
        end)

        -- Every percent roll succeeds, so only the rule stops each of these.
        local blocked =
        {
            { 'happiness in an adult',                     cond.HIGH_SPIRITS,    adult },
            { 'injury on an unpaid plan',                  cond.INJURED,         adolescent },
            { 'a stomachache without a forced feed',       cond.STOMACHACHE,     adolescent },
            { 'boredom in a chick',                        cond.BORED,           chick },
            { 'love before day 43',                        cond.LOVESICK,        adult },
            { 'vitality without happiness the day before', cond.FULL_OF_ENERGY,  adolescent },
            { 'vitality in a chick',                       cond.FULL_OF_ENERGY,  { 9, stages.CHICK, held = { cond.HIGH_SPIRITS } } },
            { 'minor illness in an egg',                   cond.SICK,            { 1, stages.EGG } },
            { 'minor illness while seriously ill',         cond.SICK,            { 40, stages.ADULT_1, held = { cond.VERY_ILL } } },
            { 'crying once the handkerchief is done',      cond.CRYING_AT_NIGHT, chick },
            { 'loneliness at affection rank 1',            cond.LONELY,          { 40, stages.ADULT_1, affection = 40 } },
            { 'loneliness before adulthood',               cond.LONELY,          { 20, stages.ADOLESCENT, affection = 0 } },
            { 'running away at affection rank 1',          cond.RUN_AWAY,        { 40, stages.ADULT_1, affection = 40, held = { cond.LONELY } } },
        }

        it('never starts a condition its rule forbids', function()
            for _, case in ipairs(blocked) do
                local state = build(case[3])
                advance(state, rollsAt(1), case[3].handkerchief)

                assert(not xi.chocoboRaising.getCondition(state, case[2]), string.format('Expected no %s', case[1]))
            end
        end)

        it('puts the chocobo to sleep on a Rest day, silently, until the next rollover', function()
            local state   = stateOnDay(10, stages.CHICK, plans.RESTING)
            local records = advance(state, lowestRoll)

            assert(xi.chocoboRaising.getCondition(state, cond.SLEEPING), 'Expected sleeping after Rest')
            assert(not heard(records, scenes.SLEEPING_SOUNDLY), 'Expected no sleeping scene')

            records = advance(state, lowestRoll, kerchief.DONE, 2)
            assert(not xi.chocoboRaising.getCondition(state, cond.SLEEPING), 'Expected the chocobo awake the day after')
            assert(not heard(records, scenes.WAKING_UP_EVERY_MORNING), 'Expected no waking scene')
        end)

        it('starts crying with the handkerchief on day 7, then stops at the next rollover', function()
            local state   = stateOnDay(6, stages.CHICK)
            local records = advance(state, lowestRoll, kerchief.NONE)

            local day7 = records[1][3]
            assert(xi.chocoboRaising.getCondition(state, cond.CRYING_AT_NIGHT), 'Expected crying on day 7')
            assert(day7[#day7] == scenes.CRYING_AT_NIGHT, 'Expected the handkerchief scene last')

            advance(state, lowestRoll, kerchief.GIVEN, 2)
            assert(not xi.chocoboRaising.getCondition(state, cond.CRYING_AT_NIGHT), 'Expected the crying over on day 8')
        end)
    end)

    describe('duration', function()
        it('ends each condition at its chance, silently for sleep and crying', function()
            for condition, percent in pairs(xi.chocoboRaising.conditionEndOdds) do
                local state   = withConditions(stateOnDay(50, stages.ADULT_2), condition)
                local records = advance(state, rollsAt(percent))
                assert(not xi.chocoboRaising.getCondition(state, condition), string.format('Expected condition %d over at a %d%% roll', condition, percent))

                local silent = condition == cond.SLEEPING or condition == cond.CRYING_AT_NIGHT
                assert(heard(records, scenes.INJURY_HAS_HEALED + condition) ~= silent, string.format('Condition %d: expected the end scene unless the condition is silent', condition))
                assert((bit.band(records[1][5], bit.lshift(1, condition)) ~= 0) ~= silent, string.format('Condition %d: expected the ended condition in the report unless silent', condition))

                if percent < 100 then
                    state = withConditions(stateOnDay(50, stages.ADULT_2), condition)
                    advance(state, rollsAt(percent + 1))
                    assert(xi.chocoboRaising.getCondition(state, condition), string.format('Expected condition %d to last above %d%%', condition, percent))
                end
            end
        end)

        it('turns a minor illness serious, except on the day the chocobo grows up', function()
            local state   = withConditions(stateOnDay(50, stages.ADULT_2), cond.SICK)
            local records = advance(state, rollsAt(odds.sickWorsens))

            assert(xi.chocoboRaising.getCondition(state, cond.VERY_ILL) and not xi.chocoboRaising.getCondition(state, cond.SICK), 'Expected serious illness in place of the minor one')
            assert(heard(records, scenes.IS_VERY_ILL), 'Expected the serious illness scene')
            assert(not heard(records, scenes.ILLNESS_HAS_HEALED), 'Expected no healed scene')

            local both = bit.lshift(1, cond.SICK) + bit.lshift(1, cond.VERY_ILL)
            assert(bit.band(records[1][5], both) == both, 'Expected both illnesses in the report')

            state = withConditions(stateOnDay(50, stages.ADULT_2), cond.SICK)
            advance(state, rollsAt(odds.sickWorsens + 1))
            assert(not xi.chocoboRaising.getCondition(state, cond.VERY_ILL), 'Expected no serious illness above the chance')

            local chick        = withConditions(stateOnDay(xi.chocoboRaising.daysToAdolescent - 1, stages.CHICK), cond.SICK)
            local grownRecords = advance(chick, rollsAt(odds.sickWorsens))

            assert(chick.stage == stages.ADOLESCENT, 'Expected the chick to grow up')
            assert(heard(grownRecords, scenes.CHICK_TO_ADOLESCENT), 'Expected the growth scene')
            assert(not heard(grownRecords, scenes.IS_VERY_ILL), 'Expected no serious illness scene on the growth day')
            assert(not heard(grownRecords, scenes.ILLNESS_HAS_HEALED), 'Expected no healed scene on the growth day')
            assert(chick.conditions == 0, string.format('Expected no conditions after growing up, got 0x%X', chick.conditions))
        end)

        it('keeps a condition over quiet days', function()
            local state = withConditions(stateOnDay(50, stages.ADULT_2), cond.LOVESICK)
            advance(state, lowestRoll, kerchief.DONE, 5)

            assert(xi.chocoboRaising.getCondition(state, cond.LOVESICK), 'Expected love to last')
        end)

        it('orders the scenes of one rollover', function()
            local state   = withConditions(stateOnDay(50, stages.ADULT_2), cond.RUN_AWAY, cond.BORED)
            local records = advance(state, rollsAt(odds.boredAdult))
            local played  = records[1][3]

            assert(played[1] == scenes.CHOCOBO_IS_BACK and played[2] == scenes.SEEMS_HAPPIER, 'Expected no plan scene, then the return before the boredom ending')
        end)
    end)

    describe('away', function()
        it('uses up the plan day but carries out nothing', function()
            local state     = withConditions(stateOnDay(50, stages.ADULT_2, plans.CARRYING_PACKAGES), cond.RUN_AWAY)
            state.energy    = 40
            state.affection = 100

            local records = advance(state, lowestRoll)
            local totals  = records[1][4]

            assert(state.strength == 0 and state.endurance == 0 and state.discernment == 0 and state.receptivity == 0, 'Expected no stat change')
            assert(state.affection == 100, string.format('Expected affection kept, got %d', state.affection))
            assert(state.energy == 40, string.format('Expected energy kept, got %d', state.energy))
            assert(totals.gil == 0 and totals.good == 0 and totals.poor == 0, 'Expected no pay and no plan outcome')
            assert(not xi.chocoboRaising.getCondition(state, cond.INJURED), 'Expected no injury from the paid plan')
            assert(state.care_plan == 0x60707070, string.format('Expected the plan day used up, got 0x%08X', state.care_plan))
        end)
    end)

    it('cures only a held condition, at the rollover after the cure', function()
        local state = withConditions(stateOnDay(50, stages.ADULT_2), cond.BORED)
        xi.chocoboRaising.addPendingCure(state, cond.BORED)
        assert(xi.chocoboRaising.getCondition(state, cond.BORED), 'Expected boredom until the rollover')

        local records = advance(state, lowestRoll)
        assert(not xi.chocoboRaising.getCondition(state, cond.BORED), 'Expected boredom cured')
        assert(heard(records, scenes.SEEMS_HAPPIER), 'Expected the cured scene')
        assert(records[1][5] == bit.lshift(1, cond.BORED), 'Expected the cured condition in the report')

        local healthy = stateOnDay(50, stages.ADULT_2)
        xi.chocoboRaising.addPendingCure(healthy, cond.BORED)
        assert(healthy.conditions == 0, 'Expected no pending cure for a condition the chocobo does not have')
    end)
end)

describe('Chocobo raising conditions at the trainer', function()
    ---@type CClientEntityPair
    local player
    local client

    -- `rolls` answers percent rolls, `picks` every other roll.
    local rolls = 1
    local picks = 'low'

    -- A chick on day 4.
    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        xi.test.world:setSeed(1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:deleteRaisedChocobo()

        client = raisingClient.tradeEgg(player)

        xi.test.world:skipVanaDays(4 * 25)
        raisingClient.visit(client)

        raisingClient.setChocobo(player, { conditions = 0 })

        rolls = 1
        picks = 'low'
        stub('math.randomInt', function(low, high)
            if high == 100 then
                return rolls
            end

            if picks == 'high' then
                return high
            end

            return low
        end)
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    local function feed(items)
        raisingClient.trade(client, items)
        raisingClient.send(client, 241)
        raisingClient.finish(client, 0)
    end

    local function stats()
        local info = player:getChocoboRaisingInfo()

        return { info.strength, info.endurance, info.discernment, info.receptivity }
    end

    local foodArrow     = math.floor(xi.chocoboRaising.statPerFoodArrow * xi.chocoboRaising.statPositiveMultiplier)
    local foodArrowDown = math.floor(xi.chocoboRaising.statPerFoodArrow * xi.chocoboRaising.statNegativeMultiplier)

    -- Feeds one item and returns the index of the stat that rose, or nil.
    local function statRaisedBy(item)
        local before = stats()

        player:addItem(item)
        feed({ item })

        local after  = stats()
        local raised
        for index = 1, 4 do
            if after[index] ~= before[index] then
                local up   = after[index] == before[index] + foodArrow
                local down = after[index] < before[index] and after[index] >= before[index] - foodArrowDown
                assert(not raised and (up or (down and item == xi.item.CARROT_PASTE)), 'Expected one stat changed by one food arrow')
                raised = index
            end
        end

        return raised
    end

    it('raises a stat with each stat food at its chance', function()
        local statFoods =
        {
            { 'Sharug Greens',       xi.item.BUNCH_OF_SHARUG_GREENS, 1, 2 },
            { 'Azouph Greens',       xi.item.BUNCH_OF_AZOUPH_GREENS, 3, 4 },
            { 'San d\'Orian Carrot', xi.item.SAN_DORIAN_CARROT,      1, 4 },
        }

        local fresh = player:getChocoboRaisingInfo()

        for _, case in ipairs(statFoods) do
            player:setChocoboRaisingInfo(fresh)
            picks = 'low'

            rolls = 101 - odds.foodStat
            local first = statRaisedBy(case[2])
            assert(first == case[3], string.format('%s: expected stat %d from the first pick, got %s', case[1], case[3], tostring(first)))

            picks = 'high'
            local last = statRaisedBy(case[2])
            assert(last == case[4], string.format('%s: expected stat %d from the last pick, got %s', case[1], case[4], tostring(last)))

            rolls = 100 - odds.foodStat
            assert(not statRaisedBy(case[2]), string.format('%s: expected no stat above the %d%% chance', case[1], odds.foodStat))
        end
    end)

    it('always changes a stat with Carrot Paste', function()
        -- Room to move either way.
        raisingClient.setChocobo(player, { strength = 100, endurance = 100, discernment = 100, receptivity = 100 })

        assert(statRaisedBy(xi.item.CARROT_PASTE) == 1, 'Expected a stat from the lowest roll')
    end)

    it('shows the day\'s conditions in the report record', function()
        raisingClient.setChocobo(player, { conditions = bit.lshift(1, cond.SICK) })

        xi.test.world:skipVanaDays(25)
        local visit = raisingClient.visit(client)

        assert(visit.records[1].conditions == bit.lshift(1, cond.SICK), string.format('Expected p6 to hold the illness, got 0x%X', visit.records[1].conditions))
    end)

    it('can give a stomachache the day after a forced feed', function()
        player:addItem({ id = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 4 })
        feed({ { itemId = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 4 } })

        local flag = bit.lshift(1, xi.chocoboRaising.forcedFeedFlag)
        assert(bit.band(player:getChocoboRaisingInfo().conditions, flag) ~= 0, 'Expected the forced feed noted')

        rolls = 101 - odds.stomachacheForced
        xi.test.world:skipVanaDays(25)
        local visit = raisingClient.visit(client)

        local conditions = player:getChocoboRaisingInfo().conditions
        assert(bit.band(conditions, bit.lshift(1, cond.STOMACHACHE)) ~= 0, 'Expected a stomachache')
        assert(bit.band(conditions, flag) == 0, 'Expected the forced feed forgotten')
        assert(raisingClient.heard(visit, scenes.HAS_STOMACHACHE), 'Expected the stomachache scene')
    end)

    it('keeps boredom after a compete until the rollover', function()
        raisingClient.setChocobo(player, { conditions = bit.lshift(1, cond.BORED) })

        xi.chocoboRaising.onRaisingEventPlayout(player, scenes.COMPETE_WITH_OTHERS, player:getChocoboRaisingInfo())
        assert(bit.band(player:getChocoboRaisingInfo().conditions, bit.lshift(1, cond.BORED)) ~= 0, 'Expected boredom until the rollover')

        xi.test.world:skipVanaDays(25)
        local visit = raisingClient.visit(client)

        assert(bit.band(player:getChocoboRaisingInfo().conditions, bit.lshift(1, cond.BORED)) == 0, 'Expected boredom cured')
        assert(raisingClient.heard(visit, scenes.SEEMS_HAPPIER), 'Expected the cured scene')
    end)
end)
