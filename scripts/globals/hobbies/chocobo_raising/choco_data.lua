-----------------------------------
-- Chocobo Raising
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/breeding')
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

xi.chocoboRaising.newChocobo = function(player, egg)
    local newChoco = {}

    newChoco.first_name = 'Chocobo'
    newChoco.last_name  = 'Chocobo'

    newChoco.sex = xi.chocoboRaising.rollEggGender(egg)

    newChoco.created         = GetSystemTime()
    newChoco.age             = 0
    newChoco.last_update_age = 1
    newChoco.stage           = xi.chocoboRaising.stage.EGG
    newChoco.location        = xi.chocoboRaising.raisingLocation[player:getZoneID()]

    local dna = xi.chocoboRaising.rollEggAlleles(egg)

    newChoco.allele1 = dna[1]
    newChoco.allele2 = dna[2]
    newChoco.allele3 = dna[3]

    newChoco.color = xi.chocoboRaising.allelesToColor(dna)

    newChoco.strength           = 0
    newChoco.endurance          = 0
    newChoco.discernment        = 0
    newChoco.receptivity        = 0
    newChoco.affection          = 255
    newChoco.energy             = 100
    newChoco.satisfaction       = 0
    newChoco.conditions         = 0
    newChoco.ability1           = xi.chocoboRaising.rollEggInheritedAbility(egg)
    newChoco.ability2           = 0
    newChoco.personality        = 0
    newChoco.weather_preference = 0
    newChoco.hunger             = 0

    local defaultCarePlan = bit.lshift(7, 4) + 0
    newChoco.care_plan =
        bit.lshift(defaultCarePlan, 24) +
        bit.lshift(defaultCarePlan, 16) +
        bit.lshift(defaultCarePlan,  8) +
        bit.lshift(defaultCarePlan,  0)

    newChoco.held_item = 0

    return newChoco
end

xi.chocoboRaising.updateChocoState = function(player, chocoState)
    chocoState.age             = math.floor((GetSystemTime() - chocoState.created) / xi.chocoboRaising.dayLength) + 1
    chocoState.age             = math.min(chocoState.age, xi.chocoboRaising.daysToAdult4 + 1)
    chocoState.last_update_age = chocoState.age

    debug(string.format('Writing chocoState to cache and db. age: %d, last_update_age: %d', chocoState.age, chocoState.last_update_age))

    xi.chocoboRaising.chocoState[player:getID()] = chocoState
    player:setChocoboRaisingInfo(chocoState)

    return chocoState
end

local function handleQuestEvents(player, events, age, reportLength, questState)
    if
        not questState.whiteHandkerchiefStarted and
        not player:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF) and
        age == 7 and
        not questState.chocoboWhistleQuestBegan
    then
        debug('Starting White Handkerchief quest')
        table.insert(events, { age, { xi.chocoboRaising.cutscenes.CRYING_AT_NIGHT } })
        questState.whiteHandkerchiefStarted = true
    elseif
        questState.whiteHandkerchiefStarted and
        not questState.whiteHandkerchiefCancelled and
        age == 15 and
        reportLength >= 7
    then
        debug('Cancelling White Handkerchief quest')
        table.insert(events, { age, { xi.chocoboRaising.cutscenes.HAVENT_SEEN_YOU } })
        questState.whiteHandkerchiefCancelled = true
    elseif
        not questState.whiteHandkerchiefStarted and
        not questState.whiteHandkerchiefCancelled and
        not questState.whiteHandkerchiefFinished and
        age >= 8 and
        player:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF)
    then
        debug('Ending White Handkerchief quest')
        table.insert(events, { age, { xi.chocoboRaising.cutscenes.THAT_SHOULD_BE_ENOUGH } })
        questState.whiteHandkerchiefFinished = true
    end
end

-- TODO: There's a lot of logic in here about reporting, should we move this into it's own file?
xi.chocoboRaising.initChocoState = function(player)
    local chocoState = player:getChocoboRaisingInfo()
    if not chocoState then
        return chocoState
    end

    -- Generate data that doesn't need to be persisted to the db
    -- but is needed at runtime

    -- Age is worked out alongside 'the day you handed in your egg'
    -- So on the 0th day, the chocobo is 1 day old.
    chocoState.age = math.floor((GetSystemTime() - chocoState.created) / xi.chocoboRaising.dayLength) + 1
    chocoState.age = math.min(chocoState.age, xi.chocoboRaising.daysToAdult4 + 1)

    debug('chocoState.age = ' .. chocoState.age)
    debug('chocoState.last_update_age = ' .. chocoState.last_update_age)

    -- Add helpers and empty tables to navigate CSs
    chocoState.csList        = {}
    chocoState.foodGiven     = {}
    chocoState.report        = {}
    chocoState.report.events = {}

    -- Step 1: Determine if enough time has passed to show a report (n > 0 day)
    local daysPassed = chocoState.age - chocoState.last_update_age
    if daysPassed <= 0 then
        chocoState.last_update_age = chocoState.age
        return chocoState
    end

    chocoState.report.day_start = chocoState.last_update_age
    chocoState.report.day_end   = chocoState.age

    local reportLength = chocoState.report.day_end - chocoState.report.day_start
    debug('Report length:', reportLength)

    chocoState.last_update_age = chocoState.age

    -- Step 2: Build a table of every event that happened on every day
    local events                 = {}
    local possibleCarePlanFuture = {}

    -- Extract care plan logic into a clean array of future plan types
    for i = 0, 3 do
        local offset   = 24 - (i * 8)
        local length   = bit.band(bit.rshift(chocoState.care_plan, offset + 4), 0xF)
        local planType = bit.band(bit.rshift(chocoState.care_plan, offset), 0xF)

        for _ = 1, length do
            table.insert(possibleCarePlanFuture, planType)
        end
    end

    -- Track quest states
    local questState =
    {
        whiteHandkerchiefStarted   = false,
        whiteHandkerchiefCancelled = false,
        whiteHandkerchiefFinished  = false,
        chocoboWhistleQuestBegan   = player:getCharVar('HQuest[ChocoboWhistle]Prog') > 0,
    }

    for idx = 1, reportLength do
        local possibleCarePlanEvent = possibleCarePlanFuture[idx] or xi.chocoboRaising.carePlans.BASIC_CARE

        local age          = chocoState.report.day_start + idx - 1
        local currentStage = xi.chocoboRaising.ageToStage(age)

        table.insert(events, { age, { possibleCarePlanEvent } })

        -- If the chocobo doesn't have any conditions, roll to see if they get one
        if not xi.chocoboRaising.hasCondition(chocoState) then
            for _, condition in ipairs(xi.chocoboRaising.conditions) do
                -- TODO: Use stats and history instead of pure chance
                if math.random(1, 100) <= 5 then
                    xi.chocoboRaising.setCondition(chocoState, condition, true)
                    break
                end
            end
        end

        -- Evaluate condition logic (stubbed)
        for _, condition in ipairs(xi.chocoboRaising.conditions) do
            if xi.chocoboRaising.getCondition(chocoState, condition) then
                utils.unused()
            end
        end

        -- Handle age-up cs's
        for _, entry in ipairs(xi.chocoboRaising.ageBoundaries) do
            if currentStage == entry[1] and age >= entry[2] then
                table.insert(events, { age, { entry[3] } })
            end
        end

        handleQuestEvents(player, events, age, reportLength, questState)
    end

    -- Step 3: Condense that table down and assign to report
    chocoState.report.events = xi.chocoboRaising.condenseEvents(events)

    return chocoState
end
