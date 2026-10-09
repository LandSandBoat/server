-----------------------------------
-- Chocobo Racing: Simulator
-- Per-section simulation of a race. Distances are in steps.
-- STR sets the speed, orders set how stamina is spent, END sizes the stamina pool and softens running out.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}
xi.chocoboRacing.simulator = xi.chocoboRacing.simulator or {}

---@class ChocoboRaceRunState
---@field distances number[] Ground covered by each chocobo
---@field stamina number[] Stamina left for each chocobo
---@field appleAt integer[] Section each chocobo ate its speed apple
---@field waiting boolean[] Biscuit holders waiting to lose the lead
---@field owed number[] Ground lost at the start that is still to be won back
---@field strBonus number[] Speed from STR at full stamina
---@field drainRate number[] Stamina drain multiplier
---@field easesOff boolean[] Sprinters that will switch to Keep Pace
---@field easedOff boolean[] Sprinters that have switched to Keep Pace
---@field startStamina number[] Stamina at the start
---@field flatBonus number[] Distance added every section
---@field endLateLoss number[] Distance lost every section of the closing stretch
---@field strKeptEmpty number[] Share of strBonus kept once out of stamina
---@field burst number[] Extra effort at the start, fading over the next sections

---TODO: Captured birds can hold Gallop in both slots.
---Whether the bonus then counts twice is unknown, so every ability counts once.
---@param chocobo ChocoboRaceEntry
---@param ability xi.chocoboRaising.ability
---@return boolean
local function hasAbility(chocobo, ability)
    return chocobo.ability1 == ability or chocobo.ability2 == ability
end

---@param distances number[]
---@return integer
local function leaderOf(distances)
    local leader = 1
    for i = 2, #distances do
        if distances[i] > distances[leader] then
            leader = i
        end
    end

    return leader
end

--- Share of the STR bonus for a raw STR, interpolated linearly between the points of strCurve.
---@param value integer
---@return number
local function strShare(value)
    local strCurve = xi.chocoboRacing.simulator.rules.speed.strCurve
    local knot     = math.min(math.floor(value / 64), 3)
    local low      = strCurve[knot + 1]

    return low + (strCurve[knot + 2] - low) * (value - knot * 64) / 64
end

--- Effect size relative to its size at fullEffectSection.
---@param section integer
---@param offset number
---@return number
local function effectScale(section, offset)
    return (xi.chocoboRacing.simulator.rules.fullEffectSection + offset) / (section + offset)
end

--- Biscuits are always thrown at the leader. A bird that leads keeps its biscuit for a later free section and gets no trigger.
--- Pepper Biscuit costs the leader distance, Fire Biscuit costs it stamina.
---@param race ChocoboRaceResult
---@param user integer
---@param section integer
---@param state ChocoboRaceRunState
---@param trigger ChocoboRaceTrigger
---@return ChocoboRaceTrigger?
local function throwBiscuit(race, user, section, state, trigger)
    local rules  = xi.chocoboRacing.simulator.rules
    local item   = race.chocobos[user].item
    local target = leaderOf(state.distances)

    -- Early return: the thrower leads, so it waits.
    if target == user then
        state.waiting[user] = true
        return nil
    end

    local biscuit = rules.fireBiscuit
    if item == xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT then
        biscuit = rules.pepperBiscuit
    end

    -- Early return: missed.
    if math.randomInt(1, 100) > biscuit.hitPercent then
        trigger.targets = 0
        trigger.param   = bit.lshift(1, target - 1)
        return trigger
    end

    trigger.targets = bit.lshift(1, target - 1)
    trigger.param   = 0
    if item == xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT then
        state.distances[target] = state.distances[target] - biscuit.distanceLoss * effectScale(section, rules.items.effectOffset)
    else
        state.stamina[target] = state.stamina[target] - biscuit.staminaLoss
    end

    return trigger
end

---Applies one item use and returns its trigger.
---@param race ChocoboRaceResult
---@param user integer
---@param section integer
---@param state ChocoboRaceRunState
---@return ChocoboRaceTrigger?
local function useItem(race, user, section, state)
    local rules     = xi.chocoboRacing.simulator.rules

    local chocobo   = race.chocobos[user]
    local item      = chocobo.item
    local distances = state.distances
    local stamina   = state.stamina
    local trigger   = { user = bit.lshift(1, user - 1), targets = bit.lshift(1, user - 1), type = item }

    -- Early return: biscuits.
    if
        item == xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT or
        item == xi.chocoboRacing.sectionEvent.FIRE_BISCUIT
    then
        return throwBiscuit(race, user, section, state, trigger)
    end

    -- TODO: Shadow Apple: no effect could be found in the captures.
    switch(item):caseof
    {
        -- Speed Apple: an instant jump forward and a little stamina back, then a small boost for a few sections.
        [xi.chocoboRacing.sectionEvent.SPEED_APPLE] = function()
            distances[user]     = distances[user] + rules.speedApple.distanceGain * effectScale(section, rules.items.effectOffset)
            stamina[user]       = stamina[user] + rules.speedApple.staminaGain
            state.appleAt[user] = section
        end,

        -- Stamina Apple: stamina back.
        [xi.chocoboRacing.sectionEvent.STAMINA_APPLE] = function()
            stamina[user] = stamina[user] + rules.staminaApple.staminaGain
        end,

        -- Gysahl Bomb: every opponent may be hit and lose distance. Higher thrower RCP than the target's makes a hit likelier.
        [xi.chocoboRacing.sectionEvent.GYSAHL_BOMB] = function()
            trigger.targets = 0
            trigger.param   = 0
            for target = 1, #race.chocobos do
                if target ~= user then
                    if math.randomInt(1, 256) <= rules.gysahlBomb.hitBase + math.floor(rules.gysahlBomb.hitPerRcp * (chocobo.stats.rcp - race.chocobos[target].stats.rcp) / 256) then
                        trigger.targets   = bit.bor(trigger.targets, bit.lshift(1, target - 1))
                        distances[target] = distances[target] - rules.gysahlBomb.distanceLoss * effectScale(section, rules.items.effectOffset)
                    else
                        trigger.param = bit.bor(trigger.param, bit.lshift(1, target - 1))
                    end
                end
            end
        end,
    }

    return trigger
end

--- Items are decided before the race. In each item section, birds that still hold an item roll in turn, sprinters first. The first bird to succeed uses its item.
---@param race ChocoboRaceResult
---@return table<integer, integer> eventAt Bird using its item, by section
---@return table<integer, boolean> isItemSection
local function planItems(race)
    local rules      = xi.chocoboRacing.simulator.rules
    local racerCount = #race.chocobos
    local eventAt    = {}
    local holding    = {}
    for i = 1, racerCount do
        holding[i] = race.chocobos[i].item ~= 0
    end

    local itemSections  = {}
    local isItemSection = {}
    for _, range in ipairs(rules.items.sections) do
        for section = range[1], range[2] do
            table.insert(itemSections, section)
            isItemSection[section] = true
        end
    end

    for _, section in ipairs(itemSections) do
        -- Chance out of 256 that a bird still holding its item uses it: { opening, closing }.
        local stretchIndex = 2
        if section < rules.sections.quietStart then
            stretchIndex = 1
        end

        local turn = utils.shuffle(utils.range(1, racerCount))
        table.sort(turn, function(a, b)
            return (race.chocobos[a].orders == xi.chocoboRacing.order.SPRINT and 0 or 1) < (race.chocobos[b].orders == xi.chocoboRacing.order.SPRINT and 0 or 1)
        end)

        for _, i in ipairs(turn) do
            if
                holding[i] and
                math.randomInt(1, 256) <= rules.items.useChance[race.chocobos[i].orders][race.chocobos[i].item][stretchIndex]
            then
                eventAt[section] = i
                holding[i]       = false
                break
            end
        end
    end

    return eventAt, isItemSection
end

--- In rain, mud takes one section that has no item use.
---@param race ChocoboRaceResult
---@param eventAt table<integer, integer>
---@return integer?
local function planMud(race, eventAt)
    local rules = xi.chocoboRacing.simulator.rules

    -- Early return: no rain, no mud.
    if race.weather ~= xi.weather.RAIN then
        return nil
    end

    local opening = {}
    for section = rules.mud.openingSections[1], rules.mud.openingSections[2] do
        if not eventAt[section] then
            table.insert(opening, section)
        end
    end

    if #opening > 0 and math.randomInt(1, 256) <= rules.mud.openingChance then
        return utils.randomEntry(opening)
    end

    local closing = {}
    for section = rules.mud.closingSections[1], rules.mud.closingSections[2] do
        if not eventAt[section] then
            table.insert(closing, section)
        end
    end

    for index, section in ipairs(closing) do
        if index == #closing or math.randomInt(1, 256) <= rules.mud.closingChance then
            return section
        end
    end

    return nil
end

--- Works out each bird's speed, stamina and drain from its stats and orders.
---@param race ChocoboRaceResult
---@return ChocoboRaceRunState
local function prepareBirds(race)
    local rules = xi.chocoboRacing.simulator.rules
    local state =
    {
        distances    = {},
        stamina      = {},
        appleAt      = {},
        waiting      = {},
        owed         = {},
        strBonus     = {},
        drainRate    = {},
        easesOff     = {},
        easedOff     = {},
        startStamina = {},
        flatBonus    = {},
        endLateLoss  = {},
        strKeptEmpty = {},
        burst        = {},
    }

    for i = 1, #race.chocobos do
        local chocobo     = race.chocobos[i]
        local stats       = chocobo.stats
        local orderRules  = rules.orders[chocobo.orders]
        local rcpShare    = stats.rcp / 255
        local pacingError = math.randomNormal(0, 1) * rules.stamina.drainLuck * (1 - rcpShare)
        local dscRank     = bit.rshift(stats.dsc, 5) / 7 -- Stat rank 0 to 7, scaled to 0 to 1.
        local endRank     = bit.rshift(stats['end'], 5) / 7

        state.strBonus[i]     = rules.speed.strBonus * strShare(stats.str)
        state.drainRate[i]    = math.max(
            (1 - rules.stamina.drainEndCut * (stats['end'] / 255) ^ rules.stamina.drainEndShape) * (1 - orderRules.drainStr + orderRules.drainStr * stats.str / 256) *
            (1 - orderRules.drainDscCut * stats.dsc / 255) * (1 - rules.stamina.drainRcpCut * stats.rcp / 255), rules.stamina.minDrain) * math.exp(pacingError)
        state.easesOff[i]     = chocobo.orders == xi.chocoboRacing.order.SPRINT and
            math.randomInt(1, 256) <= math.floor(256 * utils.clamp(rules.sprint.easeChance + rules.sprint.easeChanceRcp * rcpShare, 0, 1))
        state.flatBonus[i]    = rules.speed.dscBonus * dscRank + rules.speed.endBonus * endRank
        state.endLateLoss[i]  = rules.speed.endLateLoss * endRank
        state.burst[i]        = rules.start.burst * (1 - stats.dsc / 256)
        state.strKeptEmpty[i] = rules.tired.strKeptEmpty + rules.tired.strKeptEnd * stats['end'] / 255
        state.stamina[i]      = 1 + rules.stamina.startEndBonus * stats['end'] / 255
        state.startStamina[i] = state.stamina[i]

        if hasAbility(chocobo, xi.chocoboRaising.ability.GALLOP) then
            state.flatBonus[i] = state.flatBonus[i] + rules.abilities.gallopDistance
        end

        if hasAbility(chocobo, xi.chocoboRaising.ability.AUTO_REGEN) then
            state.flatBonus[i] = state.flatBonus[i] + rules.abilities.regenDistance
        end
    end

    return state
end

--- The start: some birds start slowly, more often with low DSC. Then every bird runs the first section.
---@param race ChocoboRaceResult
---@param state ChocoboRaceRunState
---@return ChocoboRaceTrigger
local function runStart(race, state)
    local rules        = xi.chocoboRacing.simulator.rules
    local slowStarters = 0
    for i = 1, #race.chocobos do
        local chocobo    = race.chocobos[i]
        local orderRules = rules.orders[chocobo.orders]

        -- A bird that starts well also gets its burst in the first section.
        local startShift = math.randomNormal(0, rules.start.luck)
        local effort     = orderRules.effort[1]
        if math.randomInt(1, 256) > chocobo.stats.dsc then
            slowStarters = bit.bor(slowStarters, bit.lshift(1, i - 1))
            startShift   = startShift - rules.start.slowLoss * (1 - rules.start.slowLossDscCut * chocobo.stats.dsc / 256)
        else
            effort = effort + state.burst[i]
        end

        -- About a third of the start evens out over the next sections.
        state.distances[i] = startShift + (rules.speed.base + rules.speed.strBonus * rules.speed.startStrMultiplier * strShare(chocobo.stats.str)) * effort
        state.owed[i]      = -rules.regain.startShare * startShift
        state.stamina[i]   = state.stamina[i] - orderRules.drain[1] * state.drainRate[i]
    end

    return { targets = slowStarters, type = xi.chocoboRacing.sectionEvent.RACE_START }
end

--- Mud catches birds and costs them distance. Birds that like rain are less likely to get caught.
---@param race ChocoboRaceResult
---@param section integer
---@param state ChocoboRaceRunState
---@return ChocoboRaceTrigger
local function stickInMud(race, section, state)
    local rules   = xi.chocoboRacing.simulator.rules
    local trigger = { targets = 0, param = 0, type = xi.chocoboRacing.sectionEvent.ACCIDENT }
    for i = 1, #race.chocobos do
        local chance = race.chocobos[i].weather == xi.chocoboRaising.weather.RAINY and rules.mud.caughtPercentRainLover or rules.mud.caughtPercent
        if math.randomInt(1, 100) <= chance then
            trigger.targets    = bit.bor(trigger.targets, bit.lshift(1, i - 1))
            state.distances[i] = state.distances[i] - rules.mud.distanceLoss * effectScale(section, rules.mud.effectOffset)
        else
            trigger.param = bit.bor(trigger.param, bit.lshift(1, i - 1))
        end
    end

    return trigger
end

--- Distance one bird covers in a section. Spends its stamina.
---@param race ChocoboRaceResult
---@param i integer
---@param section integer
---@param stretch integer
---@param leaderDistance number
---@param state ChocoboRaceRunState
---@return number
local function runSection(race, i, section, stretch, leaderDistance, state)
    local rules     = xi.chocoboRacing.simulator.rules
    local stamina   = state.stamina
    local distances = state.distances

    -- A sprinter that eases off switches to Keep Pace for good after it spends part of its stamina. It keeps its own drain rate.
    if
        state.easesOff[i] and
        stamina[i] <= rules.sprint.easeAt * state.startStamina[i]
    then
        state.easedOff[i] = true
    end

    local orderRules = rules.orders[race.chocobos[i].orders]
    if state.easedOff[i] then
        orderRules = rules.orders[xi.chocoboRacing.order.KEEP_PACE]
    end

    local burstEffort = state.burst[i] * math.exp(-(section - 2) / rules.start.burstFade)
    local effort      = orderRules.effort[stretch] + burstEffort
    local drainSpent  = orderRules.drain[stretch] * state.drainRate[i]

    -- A bird slows as its stamina runs low. It loses mostly the speed that STR gives.
    local freshness   = utils.clamp(stamina[i] / rules.tired.slowBelow, 0, 1)
    local strKept     = math.max(state.strKeptEmpty[i] + (1 - state.strKeptEmpty[i]) * freshness + rules.tired.overdrawnLoss * math.min(stamina[i], 0), rules.tired.minStrKept)
    local basePace    = rules.speed.base * (1 - (1 - rules.tired.strLossShare) * (1 - strKept))

    -- A bird within a step of the leader spends less stamina.
    local leadSaving  = 0
    if leaderDistance - distances[i] < rules.stamina.leadRange then
        leadSaving = rules.stamina.leadDrainCut
    end

    stamina[i]    = stamina[i] - drainSpent * (1 - leadSaving) - burstEffort * state.drainRate[i]
    local advance = (basePace + state.strBonus[i] * strKept) * effort + state.flatBonus[i] + math.randomNormal(0, rules.luck[stretch]) + rules.catchUp[stretch] * (leaderDistance - distances[i])
    if hasAbility(race.chocobos[i], xi.chocoboRaising.ability.AUTO_REGEN) then
        stamina[i] = stamina[i] + rules.abilities.regenStamina
    end

    -- The bird wins back part of the ground it lost at the start. This costs stamina.
    local regained = state.owed[i] * rules.regain.perSection
    state.owed[i]  = state.owed[i] - regained
    advance        = advance + regained
    stamina[i]     = stamina[i] - rules.regain.staminaCost * regained

    -- A speed apple adds distance in the next section too, then a small boost for a few sections.
    local apple = state.appleAt[i]
    if apple and section == apple + 1 then
        advance = advance + rules.speedApple.nextDistanceGain * effectScale(apple, rules.items.effectOffset)
    end

    if
        apple and
        section > apple and
        section <= apple + rules.speedApple.lingerSections
    then
        advance = advance + rules.speedApple.lingerGain
    end

    if stretch == 3 then
        advance = advance - state.endLateLoss[i]
    end

    if
        stretch > 1 and
        hasAbility(race.chocobos[i], xi.chocoboRaising.ability.CANTER)
    then
        advance = advance + rules.abilities.canterDistance
    end

    return advance
end

--- In the closing stretch, birds low on stamina show straining.
---@param section integer
---@param state ChocoboRaceRunState
---@return ChocoboRaceTrigger?
local function strainingTrigger(section, state)
    local rules = xi.chocoboRacing.simulator.rules

    -- Early return: outside the straining sections.
    if
        section < rules.tired.strainSections[1] or
        section > rules.tired.strainSections[2]
    then
        return nil
    end

    local straining = 0
    for i = 1, #state.stamina do
        if state.stamina[i] <= rules.tired.strainBelow * state.startStamina[i] then
            straining = bit.bor(straining, bit.lshift(1, i - 1))
        end
    end

    -- Early return: nobody is straining.
    if straining == 0 then
        return nil
    end

    return { user = straining, type = xi.chocoboRacing.sectionEvent.STRAINING }
end

--- Positions are the gap to the leader in whole steps, centred so the first and last add up to maxGap or one less.
---@param distances number[]
---@return integer[]
local function positionsOf(distances)
    local maxGap         = xi.chocoboRacing.simulator.rules.field.maxGap
    local leaderDistance = distances[leaderOf(distances)]
    local gaps           = {}
    local farthestBack   = 0
    for i = 1, #distances do
        gaps[i]      = math.min(math.floor(leaderDistance - distances[i] + 0.5), maxGap)
        farthestBack = math.max(farthestBack, gaps[i])
    end

    local offset    = math.floor((maxGap - farthestBack) / 2)
    local positions = {}
    for i = 1, #distances do
        positions[i] = gaps[i] + offset
    end

    return positions
end

--- Finishing places, 0-based; ties go to the lower number.
---@param distances number[]
---@return integer[]
local function placesOf(distances)
    local places      = {}
    local finishOrder = utils.range(1, #distances)
    table.sort(finishOrder, function(a, b)
        if distances[a] ~= distances[b] then
            return distances[a] > distances[b]
        end

        return a < b
    end)

    for place, i in ipairs(finishOrder) do
        places[i] = place - 1
    end

    return places
end

--- Runs the race for a drawn field. Fills race.sections with the 32 sections and race.places with 0-based places.
---@param race ChocoboRaceResult
xi.chocoboRacing.simulator.run = function(race)
    local rules                  = xi.chocoboRacing.simulator.rules
    local racerCount             = #race.chocobos
    local eventAt, isItemSection = planItems(race)
    local mudAt                  = planMud(race, eventAt)
    local state                  = prepareBirds(race)
    local distances              = state.distances
    local sections               = {}
    local previous               = {}
    for i = 1, racerCount do
        previous[i] = rules.field.startPosition
    end

    for section = 1, rules.sections.count do
        local trigger = nil

        -- 1 for the opening, 2 for the quiet stretch, 3 for the closing stretch.
        local stretch = 1
        if section >= rules.sections.closingStart then
            stretch = 3
        elseif section >= rules.sections.quietStart then
            stretch = 2
        end

        if section == 1 then
            trigger = runStart(race, state)
        else
            -- This section's mud or item.
            if section == mudAt then
                trigger = stickInMud(race, section, state)
            elseif eventAt[section] then
                trigger = useItem(race, eventAt[section], section, state)
            -- A biscuit holder that waited while leading throws once it no longer leads.
            elseif isItemSection[section] then
                local leader = leaderOf(distances)
                for i = 1, racerCount do
                    if state.waiting[i] and i ~= leader then
                        state.waiting[i] = nil
                        trigger          = useItem(race, i, section, state)
                        break
                    end
                end
            end

            -- Every bird runs, measured against where the leader stood at the start of the section.
            local leaderDistance = distances[leaderOf(distances)]
            local advance        = {}
            for i = 1, racerCount do
                advance[i] = runSection(race, i, section, stretch, leaderDistance, state)
            end

            for i = 1, racerCount do
                distances[i] = distances[i] + advance[i]
            end

            -- Straining shows only when nothing else happened in the section.
            if not trigger then
                trigger = strainingTrigger(section, state)
            end
        end

        local to          = positionsOf(distances)
        sections[section] = { from = previous, to = to, trigger = trigger }
        previous          = to
    end

    race.sections = sections
    race.places   = placesOf(distances)
end
