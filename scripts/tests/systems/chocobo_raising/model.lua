-----------------------------------
-- The raising day model, run over whole raises with no player.
-----------------------------------
local helpers = require('scripts.tests.systems.chocobo_raising.helpers')

local dayLength = helpers.dayLength
local created   = helpers.created
local model     = xi.chocoboRaising.model
local kerchief  = xi.chocoboRaising.handkerchief
local effect    = xi.chocoboRaising.effect
local plans     = xi.chocoboRaising.carePlans
local cutscenes = xi.chocoboRaising.cutscenes
local stages    = xi.chocoboRaising.stage

local newState   = helpers.newState
local stateOnDay = helpers.stateOnDay
local hasEffect  = helpers.hasEffect

-- Every roll returns its lowest value: care plans succeed and Basic Care always adds a point.
local lowestRoll = helpers.lowestRoll

-- Every roll returns its highest value: care plans fail.
local highestRoll = helpers.highestRoll

-- The stubbed math.randomInt answers with this.
local currentRolls = lowestRoll

-- The time at which one more day has passed for a chocobo from stateOnDay.
local nextDayTime = created + dayLength + 60

local function newContext(handkerchief)
    return
    {
        dayLength = dayLength,
        character = { handkerchief = handkerchief or kerchief.NONE },
    }
end

-- A minute into `day`.
local function dayTime(day)
    return created + day * dayLength + 60
end

local function cutscenesOn(records, day)
    for _, record in ipairs(records) do
        if day >= record[1] and day <= record[2] then
            return record[3]
        end
    end

    return {}
end

local function heardOn(records, day, cutscene)
    for _, played in ipairs(cutscenesOn(records, day)) do
        if played == cutscene then
            return true
        end
    end

    return false
end

-- Plan 1 of the schedule becomes `plan` for `days`; the other slots keep 7 days of Basic Care.
local function schedule(state, plan, days)
    state.care_plan = bit.lshift(bit.lshift(days, 4) + plan, 24) + 0x707070
end

local function setStats(state, strength, endurance, discernment, receptivity)
    state.strength    = strength
    state.endurance   = endurance
    state.discernment = discernment
    state.receptivity = receptivity
end

describe('Chocobo raising model', function()
    before_each(function()
        currentRolls = lowestRoll
        stub('math.randomInt', function(low, high)
            return currentRolls(low, high)
        end)
    end)

    it('counts each whole day since the egg trade once, up to day 129', function()
        local state = newState()

        model.advance(state, created + 3 * dayLength - 1, newContext())
        assert(state.last_update_age == 3, string.format('Expected days 1-2 done, next day 3, got %d', state.last_update_age))

        model.advance(state, created + 3 * dayLength, newContext())
        assert(state.last_update_age == 4, string.format('Expected day 3 done at exactly 72 hours, got %d', state.last_update_age))

        local sameDayRecords, sameDayEffects = model.advance(state, created + 3 * dayLength + 3600, newContext())
        assert(#sameDayRecords == 0 and #sameDayEffects == 0, 'Expected no report and no effects within the same day')

        local daily = newState()
        for day = 1, 40 do
            model.advance(daily, dayTime(day), newContext(kerchief.DONE))
        end

        local once = newState()
        model.advance(once, dayTime(40), newContext(kerchief.DONE))

        for _, field in ipairs({ 'stage', 'strength', 'endurance', 'discernment', 'receptivity', 'affection', 'energy', 'care_plan', 'last_update_age' }) do
            assert(daily[field] == once[field], string.format('%s: daily %s, once %s', field, tostring(daily[field]), tostring(once[field])))
        end

        local old     = newState()
        local records = model.advance(old, dayTime(400), newContext(kerchief.DONE))
        assert(old.last_update_age == 130, string.format('Expected the last day to be 129, got %d', old.last_update_age - 1))
        assert(records[#records][2] == 129, 'Expected the report to end on day 129')
    end)

    describe('stages', function()
        it('reaches each stage on its day with its cutscene', function()
            local boundaries =
            {
                {   4, cutscenes.EGG_HATCHING,          stages.CHICK      },
                {  19, cutscenes.CHICK_TO_ADOLESCENT,   stages.ADOLESCENT },
                {  29, cutscenes.ADOLESCENT_TO_ADULT_1, stages.ADULT_1    },
                {  43, cutscenes.ADULT_1_TO_ADULT_2,    stages.ADULT_2    },
                {  64, cutscenes.ADULT_2_TO_ADULT_3,    stages.ADULT_3    },
                { 129, cutscenes.ADULT_3_TO_ADULT_4,    stages.ADULT_4    },
            }

            for _, boundary in ipairs(boundaries) do
                local day      = boundary[1]
                local cutscene = boundary[2]
                local stage    = boundary[3]
                local state    = newState()

                model.advance(state, dayTime(day - 1), newContext(kerchief.DONE))
                assert(state.stage ~= stage, string.format('Stage %d came early, on day %d', stage, day - 1))

                local records = model.advance(state, dayTime(day), newContext(kerchief.DONE))
                assert(state.stage == stage, string.format('Expected stage %d on day %d, got %d', stage, day, state.stage))
                assert(heardOn(records, day, cutscene), string.format('Expected cutscene %d on day %d', cutscene, day))
            end
        end)

        it('names an unnamed chocobo on day 64 and keeps the player\'s name', function()
            local unnamed = newState()
            model.advance(unnamed, dayTime(64), newContext(kerchief.DONE))
            assert(unnamed.first_name ~= 'Chocobo' and unnamed.last_name == '', 'Expected a forced single name')

            local named      = newState()
            named.first_name = 'Blond'
            named.last_name  = 'Brian'
            model.advance(named, dayTime(64), newContext(kerchief.DONE))
            assert(named.first_name == 'Blond' and named.last_name == 'Brian', 'Expected the name to be kept')
        end)
    end)

    describe('White Handkerchief', function()
        it('is given on day 7 after the care plan cutscene, unless the character succeeded or holds a whistle', function()
            local state            = newState()
            local records, effects = model.advance(state, dayTime(7), newContext())
            local day7             = cutscenesOn(records, 7)

            assert(day7[#day7] == cutscenes.CRYING_AT_NIGHT, 'Expected crying at night last on day 7')
            assert(hasEffect(effects, effect.ADD_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF), 'Expected the key item')
            assert(hasEffect(effects, effect.SET_HANDKERCHIEF, kerchief.GIVEN), 'Expected GIVEN')

            local _, afterMiss = model.advance(newState(), dayTime(7), newContext(kerchief.CANCELLED))
            assert(hasEffect(afterMiss, effect.ADD_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF), 'Expected the key item again on the next chick after a miss')

            local succeededRecords, succeededEffects = model.advance(newState(), dayTime(21), newContext(kerchief.DONE))
            assert(not heardOn(succeededRecords, 7, cutscenes.CRYING_AT_NIGHT), 'Expected no crying at night once the character succeeded')
            assert(#succeededEffects == 0, 'Expected no effects once the character succeeded')

            local withWhistle = newContext(kerchief.CANCELLED)
            withWhistle.character.hasWhistle = true

            local _, whistleEffects = model.advance(newState(), dayTime(7), withWhistle)
            assert(#whistleEffects == 0, 'Expected no handkerchief while the character holds a Chocobo Whistle')
        end)

        it('is taken back in the report that reaches day 15, unless it was handed back', function()
            local state = newState()
            model.advance(state, dayTime(7), newContext())

            -- The report after day 7 marks the day passed, with the zone still to come.
            local _, passedEffects = model.advance(state, dayTime(8), newContext(kerchief.GIVEN))
            assert(hasEffect(passedEffects, effect.SET_HANDKERCHIEF, kerchief.DAY_PASSED), 'Expected DAY_PASSED')
            assert(hasEffect(passedEffects, effect.SET_LOCAL_VAR, xi.chocoboRaising.handkerchiefZoneVar, 1), 'Expected the zone still to come')

            local given = newState()
            model.advance(given, dayTime(14), newContext(kerchief.GIVEN))

            local records, effects = model.advance(given, dayTime(15), newContext(kerchief.GIVEN))
            assert(heardOn(records, 15, cutscenes.HAVENT_SEEN_YOU), 'Expected the cancel scene on day 15')
            assert(hasEffect(effects, effect.DEL_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF), 'Expected the key item taken back')
            assert(hasEffect(effects, effect.SET_HANDKERCHIEF, kerchief.CANCELLED), 'Expected CANCELLED')

            local awayRecords, awayEffects = model.advance(newState(), dayTime(21), newContext())
            assert(heardOn(awayRecords, 7, cutscenes.CRYING_AT_NIGHT), 'Expected crying at night on day 7 when the player stays away')
            assert(heardOn(awayRecords, 15, cutscenes.HAVENT_SEEN_YOU), 'Expected the cancel scene on day 15 when the player stays away')
            assert(awayEffects[1][1] == effect.ADD_KEY_ITEM, 'Expected the key item to be given first')
            assert(hasEffect(awayEffects, effect.DEL_KEY_ITEM, xi.keyItem.WHITE_HANDKERCHIEF), 'Expected the key item taken back in the same report')

            local returned = newState()
            model.advance(returned, dayTime(8), newContext(kerchief.GIVEN))

            local curedRecords, curedEffects = model.advance(returned, dayTime(9), newContext(kerchief.RETURNED))
            assert(heardOn(curedRecords, 9, cutscenes.WHITE_HANDKERCHIEF_END), 'Expected the cured scene on day 9')
            assert(not heardOn(curedRecords, 15, cutscenes.HAVENT_SEEN_YOU), 'Expected no cancel after the hand-in')
            assert(hasEffect(curedEffects, effect.SET_HANDKERCHIEF, kerchief.DONE), 'Expected DONE')
        end)

        it('can only be handed back after a report day and a zone', function()
            local character =
            {
                handkerchief         = kerchief.GIVEN,
                handkerchiefSameZone = false,
                hasWhiteHandkerchief = true,
            }

            assert(not model.canReturnHandkerchief(character), 'Expected no hand-in before a report day passed')

            character.handkerchief         = kerchief.DAY_PASSED
            character.handkerchiefSameZone = true
            assert(not model.canReturnHandkerchief(character), 'Expected no hand-in before zoning')

            character.handkerchiefSameZone = false
            assert(model.canReturnHandkerchief(character), 'Expected the hand-in')

            character.hasWhiteHandkerchief = false
            assert(not model.canReturnHandkerchief(character), 'Expected no hand-in without the key item')
        end)
    end)

    describe('care plans', function()
        it('runs a plan two days after it is set', function()
            local state = newState()
            model.advance(state, dayTime(4), newContext(kerchief.DONE))
            schedule(state, plans.TAKING_A_WALK, 7)

            local records = model.advance(state, dayTime(6), newContext(kerchief.DONE))
            assert(cutscenesOn(records, 5)[1] == plans.BASIC_CARE, 'Expected Basic Care on day 5')
            assert(cutscenesOn(records, 6)[1] == plans.TAKING_A_WALK, 'Expected the walk on day 6')
        end)

        it('leaves each plan\'s energy and pays Carry Packages on good and poor days', function()
            -- { plan, good day energy, poor day energy }
            local energies =
            {
                { plans.BASIC_CARE,             98, 98 },
                { plans.TAKING_A_WALK,          97, 97 },
                { plans.EXCERCISING_IN_A_GROUP, 96, 96 },
                { plans.CARRYING_PACKAGES,      87, 84 },
                { plans.DIGGING_FOR_TREASURE,   74, 68 },
            }

            for _, entry in ipairs(energies) do
                for index, rolls in ipairs({ lowestRoll, highestRoll }) do
                    local state  = stateOnDay(40, stages.ADULT_1, entry[1])
                    currentRolls = rolls

                    model.advance(state, nextDayTime, newContext(kerchief.DONE))
                    assert(state.energy == entry[index + 1], string.format('Plan %d: expected energy %d, got %d', entry[1], entry[index + 1], state.energy))
                end
            end

            -- { rolls, gil, good days, poor days }
            for _, case in ipairs({ { lowestRoll, 200, 1, 0 }, { highestRoll, 100, 0, 1 } }) do
                local state  = stateOnDay(20, stages.ADOLESCENT, plans.CARRYING_PACKAGES)
                currentRolls = case[1]

                local records, effects = model.advance(state, nextDayTime, newContext(kerchief.DONE))
                local totals           = records[1][4]

                assert(hasEffect(effects, effect.ADD_GIL, case[2]), string.format('Expected %d gil', case[2]))
                assert(totals.gil == case[2] and totals.good == case[3] and totals.poor == case[4], 'Expected the day totals in the record')
            end
        end)

        it('moves stats by the plan arrows, and stops lowering them from day 64', function()
            local chick = stateOnDay(10, stages.CHICK, plans.TAKING_A_WALK)
            setStats(chick, 50, 50, 50, 50)

            -- Walk is +2 +2 -1 -1 arrows; the lowest roll is 2 points an arrow.
            model.advance(chick, nextDayTime, newContext(kerchief.DONE))
            assert(chick.strength == 54 and chick.endurance == 54, 'Expected STR and END up 4')
            assert(chick.discernment == 48 and chick.receptivity == 48, 'Expected DSC and RCP down 2')

            local adult = stateOnDay(70, stages.ADULT_3, plans.LISTENING_TO_MUSIC)
            setStats(adult, 50, 50, 50, 50)

            model.advance(adult, nextDayTime, newContext(kerchief.DONE))
            assert(adult.strength == 50 and adult.endurance == 50, 'Expected no loss after day 64')
            assert(adult.discernment == 54, 'Expected gains to continue')
        end)

        it('raises each stat by one on Basic Care only when the 1 in 6 roll hits', function()
            local state = stateOnDay(10, stages.CHICK, plans.BASIC_CARE)
            setStats(state, 50, 50, 50, 50)

            model.advance(state, nextDayTime, newContext(kerchief.DONE))
            assert(state.strength == 51 and state.endurance == 51, string.format('Expected STR and END up 1, got %d and %d', state.strength, state.endurance))
            assert(state.discernment == 51 and state.receptivity == 51, string.format('Expected DSC and RCP up 1, got %d and %d', state.discernment, state.receptivity))

            currentRolls = function(low, high)
                if high == 6 then
                    return 2
                end

                return low
            end

            local missed = newState()
            model.advance(missed, dayTime(20), newContext(kerchief.DONE))
            assert(missed.strength == 0 and missed.receptivity == 0, 'Expected no gain when the 1 in 6 roll misses')
        end)

        it('allows SS/A/B/C and SS/SS/A/F with room to spare, and no higher grades', function()
            local ranks = xi.chocoboRaising.skillRanks

            local allRounder = newState()
            setStats(allRounder, 224, 160, 128, 96)
            xi.chocoboRaising.addToStat(allRounder, 'receptivity', 16)
            assert(allRounder.receptivity == 112, string.format('Expected room above SS/A/B/C, got RCP %d', allRounder.receptivity))

            local mount = newState()
            setStats(mount, 224, 224, 160, 0)
            xi.chocoboRaising.addToStat(mount, 'discernment', 255)
            assert(mount.discernment >= 176, string.format('Expected room above SS/SS/A/F, got DSC %d', mount.discernment))
            assert(xi.chocoboRaising.numberToRank(mount.discernment) == ranks.A_IMPRESSIVE, 'Expected DSC to stop short of S')
        end)

        it('keeps the four stats within the total cap, and not at all with a cap of 0', function()
            local state = stateOnDay(10, stages.CHICK, plans.TAKING_A_WALK)
            setStats(state, 200, 200, 120, 119)

            model.advance(state, nextDayTime, newContext(kerchief.DONE))

            local total = state.strength + state.endurance + state.discernment + state.receptivity
            assert(total <= xi.chocoboRaising.statGrowthCap, string.format('Expected at most %d, got %d', xi.chocoboRaising.statGrowthCap, total))

            local full = newState()
            setStats(full, 200, 200, 200, 40)

            local cap = xi.chocoboRaising.statGrowthCap
            xi.chocoboRaising.statGrowthCap = 640
            xi.chocoboRaising.addToStat(full, 'receptivity', 10)
            local capped = full.receptivity

            xi.chocoboRaising.statGrowthCap = 0
            xi.chocoboRaising.addToStat(full, 'receptivity', 10)
            local uncapped = full.receptivity
            xi.chocoboRaising.statGrowthCap = cap

            assert(capped == 40, string.format('Expected no growth at the cap, got %d', capped))
            assert(uncapped == 40 + math.floor(10 * xi.chocoboRaising.statPositiveMultiplier), string.format('Expected growth with no cap, got %d', uncapped))
        end)
    end)

    describe('daily state', function()
        it('sets the overnight hunger by stage and energy', function()
            -- Captured: hunger 7 as an egg and after the hatching scene (GFat and Raguza, day 4).
            local egg     = newState()
            local hatched = false

            for day = 1, xi.chocoboRaising.daysToChick do
                model.advance(egg, dayTime(day), newContext(kerchief.DONE))
                hatched = egg.stage == stages.CHICK
                assert(egg.hunger == xi.chocoboRaising.maxHunger, string.format('Expected full on day %d', day))
            end

            assert(hatched, 'Expected the egg to hatch')

            -- Captured: a chick left at energy 23 after a full day went from rank 7 to rank 1 overnight.
            local busy           = newState()
            busy.stage           = stages.CHICK
            busy.last_update_age = xi.chocoboRaising.daysToChick + 1
            busy.hunger          = xi.chocoboRaising.maxHunger
            busy.energy          = 23

            local quiet           = newState()
            quiet.stage           = busy.stage
            quiet.last_update_age = busy.last_update_age
            quiet.hunger          = xi.chocoboRaising.maxHunger
            quiet.energy          = 97

            model.advance(busy, dayTime(busy.last_update_age), newContext(kerchief.DONE))
            model.advance(quiet, dayTime(quiet.last_update_age), newContext(kerchief.DONE))

            assert(busy.hunger == 82, string.format('Expected 255 less 2.25 per energy point (82), got %d', busy.hunger))
            assert(quiet.hunger > busy.hunger, 'Expected a quiet chick to stay fuller')

            local adolescent           = newState()
            adolescent.stage           = stages.ADOLESCENT
            adolescent.last_update_age = xi.chocoboRaising.daysToAdolescent + 1
            adolescent.hunger          = xi.chocoboRaising.maxHunger

            model.advance(adolescent, dayTime(adolescent.last_update_age), newContext(kerchief.DONE))
            assert(adolescent.hunger == 0, string.format('Expected an adolescent day to start starving, got %d', adolescent.hunger))
        end)

        -- The QoL module changes the stage settings at server start, after the scripts have loaded.
        it('follows the hatch and retirement settings even when they change after loading', function()
            local original = xi.chocoboRaising.daysToChick
            xi.chocoboRaising.daysToChick = 2

            local egg = newState()
            model.advance(egg, dayTime(3), newContext(kerchief.DONE))

            xi.chocoboRaising.daysToChick = original

            assert(egg.stage == stages.CHICK, string.format('Expected a chick by day 3, got stage %d', egg.stage))

            local retirementDay   = xi.chocoboRaising.daysToAdult4
            local adult           = newState()
            adult.stage           = stages.ADULT_3
            adult.last_update_age = retirementDay - 1

            xi.chocoboRaising.disableRetirement = true
            local records    = model.advance(adult, dayTime(retirementDay + 10), newContext(kerchief.DONE))
            local stageLater = xi.chocoboRaising.ageToStage(retirementDay + 50)
            xi.chocoboRaising.disableRetirement = false

            assert(adult.stage == stages.ADULT_3, string.format('Expected adult stage 3, got %d', adult.stage))
            assert(not heardOn(records, retirementDay, cutscenes.ADULT_3_TO_ADULT_4), 'Expected no retirement scene')
            assert(adult.last_update_age == retirementDay + 11, string.format('Expected the days to keep counting, got %d', adult.last_update_age))
            assert(stageLater == stages.ADULT_3, 'Expected a report past the retirement day to show adult stage 3')
        end)
    end)

    it('takes the personality of the highest stat until day 19 and fixes the adult look on day 29', function()
        local state = newState()
        model.advance(state, dayTime(10), newContext(kerchief.DONE))

        setStats(state, 90, 20, 20, 20)
        model.advance(state, dayTime(19), newContext(kerchief.DONE))
        assert(state.personality == xi.chocoboRaising.temperament.ILL_TEMPERED, 'Expected ill-tempered with STR highest')

        setStats(state, 20, 20, 20, 150)
        model.advance(state, dayTime(25), newContext(kerchief.DONE))
        assert(state.personality == xi.chocoboRaising.temperament.ILL_TEMPERED, 'Expected the personality kept after day 19')

        local appearance  = xi.chocoboRaising.appearance
        local appearances =
        {
            { 'STR highest',           { 120,  50,  50,  50 }, appearance.LARGE_TALONS                        },
            { 'STR and END tied',      { 120, 120,  50,  50 }, appearance.LARGE_TALONS + appearance.FULL_TAIL },
            { 'DSC highest',           {  50,  50, 120,  50 }, appearance.LARGE_BEAK                          },
            { 'RCP highest',           {  50,  50,  50, 120 }, 0                                              },
            { 'highest below Average', {  80,  50,  50,  50 }, 0                                              },
        }

        for _, case in ipairs(appearances) do
            local adult = newState()
            model.advance(adult, dayTime(28), newContext(kerchief.DONE))

            setStats(adult, case[2][1], case[2][2], case[2][3], case[2][4])
            model.advance(adult, dayTime(29), newContext(kerchief.DONE))
            assert(adult.appearance == case[3], string.format('%s: expected appearance %d, got %d', case[1], case[3], adult.appearance))

            setStats(adult, 200, 200, 200, 0)
            model.advance(adult, dayTime(40), newContext(kerchief.DONE))
            assert(adult.appearance == case[3], string.format('%s: expected the look to stay after day 29', case[1]))
        end
    end)
end)
