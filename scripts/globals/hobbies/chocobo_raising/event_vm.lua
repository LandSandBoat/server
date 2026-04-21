-----------------------------------
-- Chocobo Raising - Update Event VM
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

xi.chocoboRaising.eventVM = function(player, csid, option, npc)
    -- TODO: The majority of logic is controlled by the option, which is
    -- sent in by the client. We can't trust this isn't tampered with.
    -- We shouldtrack which options are valid at which time.

    local ID         = zones[player:getZoneID()]
    local mainCsid   = xi.chocoboRaising.csidTable[player:getZoneID()][2]
    local tradeCsid  = xi.chocoboRaising.csidTable[player:getZoneID()][3]
    local chocoState = xi.chocoboRaising.chocoState[player:getID()]

    -- Egg trade
    if csid == tradeCsid then
        if option == 252 then
            player:updateEvent(0, xi.chocoboRaising.raisingLocation[player:getZoneID()], 0, 0, 0, 0, 0, 0)
        end

    -- Egg check
    elseif csid == mainCsid then
        if chocoState == nil then
            print('ERROR! onEventUpdateVCSTrainer \'chocoState\' is nil!')

            return
        end

        debug(string.format('CS Update: %i', option))

        -- Setting the name for a chocobo: when the name is
        -- applied from the menu the name offsets (from the menu)
        -- are sent combined inside the option. The bottom byte
        -- of the option is filled as below:
        -- (Name offsets are 10-bits wide)
        --
        -- 0000 0000 0000 0100 0000 0000 1111 1111
        --      ^----------^^----------^ ^-------^
        --       last_name   first_name   name_change_flag (0xFF)

        if bit.band(0x000000FF, option) == 0xFF then
            local offset1     = bit.band(0x3FF, bit.rshift(option, 8))
            local offset2     = bit.band(0x3FF, bit.rshift(option, 18))
            local fname       = xi.chocoboNames[offset1]
            local lname       = xi.chocoboNames[offset2]
            local fullnamekey = string.format('%s %s', fname, lname)

            -- https://ffxiclopedia.fandom.com/wiki/Chocobo_Names
            -- '... with the caveat that your chocobo's name may be no more than 15 letters in total.'
            -- NOTE: This is enforced by the client, this is here to stop malicious naming attempts
            local nameTooLong = string.len(fullnamekey) > (15 + 1) -- 15 + the space character

            -- If renaming fails, the name will remain as 'Chocobo Chocobo' and the
            -- rejection CS will play
            if not fname or not lname then
                print('ERROR! onEventUpdateVCSTrainer - chocoboNames lookup failed!')
            elseif nameTooLong then
                print(string.format('ERROR! %s selected name combination too long for chocobo: %s', player:getName(), fullnamekey))
            elseif xi.bannedChocoboNames[fullnamekey] then
                print(string.format('ERROR! %s selected banned name for chocobo: %s', player:getName(), fullnamekey))
            else
                chocoState.first_name = fname
                chocoState.last_name  = lname

                debug(string.format('%s updating chocobo name: %s', player:getName(), fullnamekey))

                -- Write to cache
                xi.chocoboRaising.chocoState[player:getID()] = chocoState

                -- Set synthetic CS option for later CSs
                option = 0xFF
                debug(string.format('CS (Synthetic) Update: %i', option))
            end
        end

        -- Similar to above, updates to care plan are flagged by setting bits
        -- in the update option. In this case, the mask if 0xFE (1111 1110).
        --
        -- Plan 1, basic care, 7 days
        -- 459006
        -- 0000 0000 0000 0111 0000 0000 1111 1110
        --            ^---^^-^      ^--^ ^-------^
        --             1    2        3    4
        --
        -- 1: Length of care plan
        -- 2: Type of care plan
        -- 3: Slot of care plan
        -- 4: 'Key' for care plan updates (0xFE)

        if bit.band(0x000000FF, option) == 0xFE then
            local carePlanSlot   = bit.band(0xF, bit.rshift(option, 8))
            local carePlanLength = bit.band(0x7, bit.rshift(option, 16))
            local carePlanType   = bit.band(0xF, bit.rshift(option, 19))

            -- If zero, make sure to default
            if chocoState.care_plan == 0 then
                local defaultCarePlan = bit.lshift(7, 4) + 0

                chocoState.care_plan =
                    bit.lshift(defaultCarePlan, 24) +
                    bit.lshift(defaultCarePlan, 16) +
                    bit.lshift(defaultCarePlan,  8) +
                    bit.lshift(defaultCarePlan,  0)
            end

            local carePlan = bit.lshift(carePlanLength, 4) + carePlanType

            -- Zero out the target slot
            local targetSlotOffset = 24 - (carePlanSlot * 8)
            local mask             = bit.bnot(bit.lshift(0xFF, targetSlotOffset))
            local zerodCarePlan    = bit.band(chocoState.care_plan, mask)

            -- Then write the new care plan to it
            local finalCarePlan  = bit.bor(zerodCarePlan, bit.lshift(carePlan, targetSlotOffset))
            chocoState.care_plan = finalCarePlan

            print(string.format('%s updating chocobo care plan: slot: %i type: %i length: %i',
                player:getName(), carePlanSlot + 1, carePlanType, carePlanLength))

            -- Write to cache
            xi.chocoboRaising.chocoState[player:getID()] = chocoState
        end

        --------------------------------------------------------
        -- Main body update logic
        --------------------------------------------------------
        switch (option): caseof
        {
            -- ?
            [208] = function()
                local hasReport = 0
                if #chocoState.report.events > 0 then
                    hasReport = 0xFFFFFFFF
                end

                player:updateEvent(hasReport, 0, 0, 0, chocoState.stage, 0, 0, 0)
            end,

            -- ?
            [252] = function()
                local hasReport = 0
                if #chocoState.report.events > 0 then
                    hasReport = 0xFFFFFFFF
                end

                player:updateEvent(hasReport, 1, 1, 1, chocoState.stage, 1, 1, 1)
            end,

            -- Main menu (248 -> 214 -> 215)
            -- Update (248 -> 246 -> 244)
            [248] = function()
                local report = 0x00000000

                if #chocoState.report.events > 0 then
                    -- Pop the event from the front of the list
                    local currentEvent = chocoState.report.events[1]
                    table.remove(chocoState.report.events, 1)

                    local eventStartStart = currentEvent[1]
                    local eventStartEnd   = currentEvent[2]
                    local eventCSList     = currentEvent[3]

                    chocoState.age   = eventStartStart
                    chocoState.stage = xi.chocoboRaising.ageToStage(chocoState.age)

                    for _, cs in pairs(eventCSList) do
                        table.insert(chocoState.csList, cs)
                    end

                    report = bit.lshift(eventStartStart, 0) + bit.lshift(eventStartEnd, 20)

                    if eventStartStart == eventStartEnd then
                        -- Single day update
                        report = report + 0x00000400
                    else
                        -- Multi-day update
                        report = report + 0x00001000
                    end
                end

                local playMultipleCutscenes = 0

                if #chocoState.report.events > 0 then
                    report = report + 0x80000000
                    playMultipleCutscenes = 0x00010000
                end

                local exitFlag = 0

                player:updateEvent(248, report, #chocoState.csList, playMultipleCutscenes, chocoState.stage, 0, 0, exitFlag)
            end,

            [214] = function()
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [215] = function()
                -- Define menu options
                -- bit.lshift(0x01, 0): Ask about your chocobo's condition
                local askAboutChocoboCondition = -bit.lshift(0x01, 0)

                -- bit.lshift(0x01, 1): Care for your chocobo
                local careForYourChocobo = -bit.lshift(0x01, 1)

                -- Set up a care schedule
                local setUpCareSchedule = -bit.lshift(0x01, 2)
                local nameChocobo       = 0

                if
                    chocoState.stage > xi.chocoboRaising.stage.EGG and
                    chocoState.first_name == 'Chocobo' and
                    chocoState.last_name == 'Chocobo'
                then
                    nameChocobo = -bit.lshift(0x01, 3) -- Name your chocobo
                end

                -- bit.lshift(0x01, 4): Request Documentation
                -- bit.lshift(0x01, 5): Register to call your chocobo
                -- bit.lshift(0x01, 6): Receive your chocobo whistle
                -- bit.lshift(0x01, 7): Purchase a chocobo whistle

                -- 8 - 25 are all '-----' (blank)

                -- Go forward 1 unit (debug) (Unused, see command: !chocoboraising)
                local goForward1UnitDebug = -bit.lshift(0x01, 26)
                utils.unused(goForward1UnitDebug)

                -- Abilities print (debug) (Unused, see command: !chocoboraising)
                local abilitiesPrintDebug = -bit.lshift(0x01, 27)
                utils.unused(abilitiesPrintDebug)

                -- User work print (debug) (Unused, see command: !chocoboraising)
                local userWorkPrintDebug = -bit.lshift(0x01, 28)
                utils.unused(userWorkPrintDebug)

                local retireOrGiveUp = 0
                if chocoState.stage < xi.chocoboRaising.stage.ADULT_1 then
                    retireOrGiveUp = -bit.lshift(0x01, 30) -- Give up chocobo raising
                else
                    retireOrGiveUp = -bit.lshift(0x01, 29) -- Retire your chocobo
                end

                -- bit.lshift(0x01, 31): Nothing. (exit)
                local exit = -bit.lshift(0x01, 31)

                -- Enable menu options (remove bits from 0xFFFFFFFF)
                local menuFlags = 0xFFFFFFFF +
                    askAboutChocoboCondition +
                    careForYourChocobo +
                    setUpCareSchedule +
                    nameChocobo +
                    retireOrGiveUp

                if chocoState.stage >= xi.chocoboRaising.stage.CHICK then
                    utils.unused()
                    --menuFlags = menuFlags
                end

                if chocoState.stage >= xi.chocoboRaising.stage.ADOLESCENT then
                    utils.unused()
                    -- menuFlags = menuFlags
                end

                if chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 then
                    utils.unused()
                    -- menuFlags = menuFlags
                end

                -- Exit is always available
                menuFlags = menuFlags + exit

                player:updateEvent(menuFlags, 0, 0, 0, 0, 0, 0, 0)
            end,

            [241] = function() -- Feed chocobo
                -- Complete the trade here to prevent any cheesing
                player:confirmTrade()

                for idx, itemId in ipairs(chocoState.foodGiven) do
                    local itemData     = xi.chocoboRaising.validFoods[itemId]
                    local hungerAmount = itemData[1]
                    local energyAmount = itemData[3]
                    local glowColor   = itemData[10]

                    player:messageSpecial(ID.text.CHOCOBO_FEEDING_ITEM, itemId, idx)

                    -- TODO: Handle item effects

                    if xi.chocoboRaising.hasCondition(chocoState) then
                        for _, condition in pairs(chocoState.conditions) do
                            if xi.chocoboRaising.getCondition(chocoState, condition) then
                                local foodCureTable = xi.chocoboRaising.conditionsHealedByItems[condition]

                                if foodCureTable then
                                    if utils.contains(itemId, foodCureTable) then
                                        -- TODO: Play CS for healing condition, or messaging?
                                        xi.chocoboRaising.setCondition(chocoState, condition, false)
                                    end
                                end
                            end
                        end
                    end

                    local reaction = 1

                    chocoState.hunger = utils.clamp(chocoState.hunger + hungerAmount, 0, 255)
                    chocoState.energy = utils.clamp(chocoState.energy + energyAmount, 0, 100)

                    -- If multiple items, glow is always green
                    if #chocoState.foodGiven > 1 then
                        glowColor = xi.chocoboRaising.glow.GREEN
                    end

                    player:updateEvent(10, glowColor, 0, 0, reaction, xi.chocoboRaising.numberToRank(chocoState.hunger), 0, 0)
                end

                chocoState.foodGiven = nil

                xi.chocoboRaising.updateChocoState(player, chocoState)
            end,

            [244] = function() -- Present chocobo appearance
                -- TODO: There is more information going on in here

                -- TODO: These appearance changes are locked in on day 29 if
                -- they are 'Average' (128) or above. This will need to be
                -- written to the db and this part rewritten.

                -- Crest type
                local enlargedCrest = 0

                if chocoState.discernment >= 128 then
                    enlargedCrest = 1
                end

                -- Feet type
                local enlargedFeet = 0

                if chocoState.strength >= 128 then
                    enlargedFeet = 1
                end

                -- Tail feathers type
                local moreTailFeathers = 0

                if chocoState.endurance >= 128 then
                    moreTailFeathers = 1
                end

                -- Event update parameters.
                player:updateEvent(chocoState.color, enlargedCrest, enlargedFeet, moreTailFeathers, chocoState.stage, 1, 0, 0)
            end,

            [46] = function() -- Ask about chocobo's condition (menu)
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [600] = function()
                -- Get KI during another CS (determined randomly)
                local ki    = xi.ki.DIRTY_HANDKERCHIEF
                local getKi = 1

                player:updateEvent(ki, 0, 0, 0, 0, getKi, 0, 0)
                player:addKeyItem(ki)
            end,

            [251] = function() -- Ask about chocobo's condition (confirm)
                -- Block all other information
                --local blockFlag = bit.lshift(0x01, 31) -- Sorry, but you will have to do this later. I have something new to report.
                local arg0 = 251
                local arg1 = xi.chocoboRaising.packStats1(chocoState)
                local arg2 = bit.lshift(xi.chocoboRaising.affectionRank.PARENT, 0) + bit.lshift(chocoState.hunger, 16)
                local arg3 = bit.lshift(chocoState.personality, 0) +
                    bit.lshift(chocoState.weather_preference, 4) +
                    bit.lshift(chocoState.ability1, 8) +
                    bit.lshift(chocoState.ability2, 12) +
                    bit.lshift(chocoState.stage, 16)

                -- Condition flags (can be combined)
                -- No flags: Stable
                -- local legWounded = bit.lshift(0x01, 0)
                -- local slightlyIll = bit.lshift(0x01, 1)
                -- local stomachAche = bit.lshift(0x01, 2)
                -- local depressed = bit.lshift(0x01, 3)
                -- local excellentCondition = bit.lshift(0x01, 4)
                -- local sleepingSoundly = bit.lshift(0x01, 5)
                -- local veryIll = bit.lshift(0x01, 6)
                -- local boredRestless = bit.lshift(0x01, 7)
                -- local hopelesslySpoiled = bit.lshift(0x01, 8)
                -- local ranAway = bit.lshift(0x01, 9)
                -- local inLove = bit.lshift(0x01, 10)
                -- local makingAFuss = bit.lshift(0x01, 11)
                -- local fullOfEnergy = bit.lshift(0x01, 12)
                -- local brightAndFocussed = bit.lshift(0x01, 13)
                local arg4 = 0 -- fullOfEnergy + brightAndFocussed

                player:updateEvent(arg0, arg1, arg2, arg3, arg4, 0, 0, 0)
            end,

            [243] = function() -- Care for your chocobo (menu)
                local watchOverChocobo  = 0x01
                local tellAStory        = 0x02
                local scoldTheChocobo   = 0x04
                local competeWithOthers = 0x08
                local goOnAWalkShort    = 0x10
                local goOnAWalkRegular  = 0x20
                local goOnAWalkLong     = 0x40
                local mask              = 0x7FFFFFFF - watchOverChocobo

                if chocoState.stage >= xi.chocoboRaising.stage.CHICK then
                    mask = mask - scoldTheChocobo - goOnAWalkShort
                end

                if chocoState.stage >= xi.chocoboRaising.stage.ADOLESCENT then
                    mask = mask - tellAStory - goOnAWalkRegular
                    -- TODO: Is this unlocked per-chocobo, or per-player?
                    -- TODO: competeWithOthers: Available at adolescent stage; You must go on a regular walk to unlock this.
                    if true then
                        mask = mask - competeWithOthers
                    end
                end

                if chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 then
                    mask = mask - goOnAWalkLong
                end

                player:updateEvent(mask, chocoState.energy, 0, 0, 0, 0, 0, 0)
            end,

            [10994] = function() -- Go on a walk (Short) - Leisurely / Brisk
                table.insert(chocoState.csList, xi.chocoboRaising.cutscenes.TAKE_A_WALK)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0, 0)

                local csData =
                {
                    -- Sandoria (Chick)
                    -- [0] = { 0, 0,  2, 0, 0, 0, 0, 0 }, -- Find lost chocobo
                    [1] = { 0, 0,  7, 0, 0, 0, 0, 0 }, -- Find item (chocobo takes home)
                    -- [2] = { 0, 0,  0, 0, 0, 0, 0, 0 }, -- Nothing?
                    [2] = { 0, 0, 3, 256, 0, 3, 0, 0 }, -- Meet Ace

                    -- Bastok (Chick)
                    -- [11] = {},

                    -- Windurst (Chick)
                    -- [20] = { 0, 0, 7, 0,   0, 0, 0, 0 }, -- Get KI
                    -- [21] = { 0, 0, 2, 0,   0, 0, 0, 0 }, -- Find lost chocobo
                    -- [22] = { 0, 0, 0, 0,   0, 0, 0, 0 }, -- Nothing?
                    -- [23] = { 0, 0, 3, 256, 0, 1, 0, 0 }, -- Meet Ace
                    -- [24] = { 0, 0, 0, 0,   0, 0, 0, 0 }, -- Nothing?
                    -- [25] = { 0, 0, 7, 0,   0, 0, 0, 0 }, -- Find item (chocobo takes home)
                }

                local baseCS       = xi.chocoboRaising.csidTable[player:getZoneID()][6]
                local energyAmount = xi.chocoboRaising.walkEnergyAmount[1] + math.random(0, xi.chocoboRaising.walkEnergyRandomness)
                local energyFlag   = 0

                if chocoState.energy < energyAmount then
                    energyFlag = -1
                else
                    chocoState.energy = chocoState.energy - energyAmount
                end

                local walkZoneId = xi.chocoboRaising.shortWalkLocation[xi.chocoboRaising.raisingLocation[player:getZoneID()]]
                local csWeather  = xi.chocoboRaising.getWeatherInZone(walkZoneId)
                local output     = { 0, 0, 0, 0, 0, 0, 0, 0 }

                -- Will there be an event?
                if math.random(1, 100) <= xi.chocoboRaising.walkEventChance then
                    local possibleEvents = {}

                    -- If not holding an item, it's possible to find an item
                    if chocoState.held_item == 0 then
                        table.insert(possibleEvents, 1)
                    end

                    -- If you haven't completed the White Handkerchief quest yet
                    if not player:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF) then
                        table.insert(possibleEvents, 2)
                    end

                    -- TODO: Meet other chocobos & raisers

                    local randomEvent = utils.randomEntry(possibleEvents)
                    if randomEvent then
                        output = { unpack(csData[randomEvent]) }
                    end
                end

                output[1] = baseCS
                output[2] = energyFlag
                output[5] = chocoState.stage
                output[8] = csWeather

                -- TODO: This is a bit confusing
                if output[3] == 7 and energyFlag >= 0 then -- Chocobo found an item
                    local itemId         = utils.randomEntry(xi.chocoboRaising.walkItems[walkZoneId])
                    output[2]            = itemId
                    chocoState.held_item = itemId
                end

                player:updateEvent(unpack(output))
            end,

            [11250] = function() -- Go on a walk (Regular) - Leisurely / Brisk
                table.insert(chocoState.csList, xi.chocoboRaising.cutscenes.TAKE_A_WALK)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0, 0)

                local csData =
                {
                    [1] = { 0, 0,  7, 0, 0, 0, 0, 0 }, -- Find item (chocobo takes home)
                }

                local baseCS       = xi.chocoboRaising.csidTable[player:getZoneID()][6]
                local energyAmount = xi.chocoboRaising.walkEnergyAmount[2] + math.random(0, xi.chocoboRaising.walkEnergyRandomness)
                local energyFlag   = 0

                if chocoState.energy < energyAmount then
                    energyFlag = -1
                else
                    chocoState.energy = chocoState.energy - energyAmount
                end

                local walkZoneId = xi.chocoboRaising.mediumWalkLocation[xi.chocoboRaising.raisingLocation[player:getZoneID()]]
                local csWeather  = xi.chocoboRaising.getWeatherInZone(walkZoneId)

                local output = { 0, 0, 0, 0, 0, 0, 0, 0 }

                -- Will there be an event?
                if math.random(1, 100) <= xi.chocoboRaising.walkEventChance then
                    -- TODO: Hard-coded to randomly finding an item
                    output = { unpack(csData[1]) }
                end

                output[1] = baseCS
                output[2] = energyFlag
                output[5] = chocoState.stage
                output[8] = csWeather

                -- If the chocobo is going to find and item, but already has one:
                -- Don't play the cutscene!
                if output[3] == 7 and chocoState.held_item > 0 then
                    output[3] = 0
                end

                if output[3] == 7 and energyFlag >= 0 then -- Chocobo found an item
                    local itemId         = utils.randomEntry(xi.chocoboRaising.walkItems[walkZoneId])
                    output[2]            = itemId
                    chocoState.held_item = itemId
                end

                player:updateEvent(unpack(output))
            end,

            [11506] = function() -- Go on a walk (Long) - Leisurely / Brisk
                table.insert(chocoState.csList, xi.chocoboRaising.cutscenes.TAKE_A_WALK)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0, 0)

                local csData =
                {
                    [1] = { 0, 0,  7, 0, 0, 0, 0, 0 }, -- Find item (chocobo takes home)
                }

                local baseCS       = xi.chocoboRaising.csidTable[player:getZoneID()][6]
                local energyAmount = xi.chocoboRaising.walkEnergyAmount[3] + math.random(0, xi.chocoboRaising.walkEnergyRandomness)
                local energyFlag   = 0

                if chocoState.energy < energyAmount then
                    energyFlag = -1
                else
                    chocoState.energy = chocoState.energy - energyAmount
                end

                local walkZoneId = xi.chocoboRaising.longWalkLocation[xi.chocoboRaising.raisingLocation[player:getZoneID()]]
                local csWeather  = xi.chocoboRaising.getWeatherInZone(walkZoneId)
                local output     = { 0, 0, 0, 0, 0, 0, 0, 0 }

                -- Will there be an event?
                if math.random(1, 100) <= xi.chocoboRaising.walkEventChance then
                    -- TODO: Hard-coded to randomly finding an item
                    output = { unpack(csData[1]) }
                end

                output[1] = baseCS
                output[2] = energyFlag
                output[5] = chocoState.stage
                output[8] = csWeather

                -- If the chocobo is going to find and item, but already has one:
                -- Don't play the cutscene!
                if output[3] == 7 and chocoState.held_item > 0 then
                    output[3] = 0
                end

                if output[3] == 7 and energyFlag >= 0 then -- Chocobo found an item
                    local itemId         = utils.randomEntry(xi.chocoboRaising.walkItems[walkZoneId])
                    output[2]            = itemId
                    chocoState.held_item = itemId
                end

                player:updateEvent(unpack(output))
            end,

            [12530] = function() -- Watch over your your chocobo (confirm)
                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0)

                local baseCS = xi.chocoboRaising.csidTable[player:getZoneID()][9]

                if chocoState.stage == xi.chocoboRaising.stage.EGG then
                    -- Your egg does not seem to be in the best condition at the moment...
                    local badEggFlag = 0 -- bit.lshift(0x01, 31) (1st arg)

                    player:updateEvent(baseCS, badEggFlag, 0, 0, 0, 0, 0, 0)
                else
                    local energyFlag = 0

                    if chocoState.energy < xi.chocoboRaising.watchOverEnergy then
                        energyFlag = -1
                    else
                        chocoState.energy = chocoState.energy - xi.chocoboRaising.watchOverEnergy
                    end

                    -- Sandy: 304, 14396, 0, 0, 6, 0, 0, 2
                    -- Windurst: 816, 18250, 1, 511, 2, 0, 0, 1
                    local givingItem = 0
                    local givenItem  = 0

                    if chocoState.held_item > 0 then
                        givingItem = 1
                        givenItem  = chocoState.held_item
                    end

                    if
                        givingItem == 1 and
                        player:getFreeSlotsCount() == 0
                    then
                        givingItem = 2
                    end

                    player:updateEvent(baseCS, energyFlag, givingItem, givenItem, 2, 0, 0, 1)

                    if givingItem == 1 then
                        player:addItem({ id = givenItem, silent = true })
                        chocoState.held_item = 0
                    end
                end
            end,

            [13042] = function() -- Tell a story
                -- A chocobo must have a DSC of D (A bit deficient, 64-95) or
                -- higher to have a chance at learning a skill from a story
                if chocoState.discernment >= 64 then
                    utils.unused()
                    -- TODO: Chance to learn skill
                end

                local storyMask = 0xFFFFFF9C

                chocoState = xi.chocoboRaising.onRaisingEventPlayout(player, xi.chocoboRaising.cutscenes.INTERESTED_IN_YOUR_STORY, chocoState)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name, 0, 0, 0, 0, 0, 0, 0)
                player:updateEvent(xi.chocoboRaising.getCutsceneWithOffset(player, xi.chocoboRaising.cutscenes.INTERESTED_IN_YOUR_STORY), 0, storyMask, 0, chocoState.stage, 0, 0, 3)
                xi.chocoboRaising.updateChocoState(player, chocoState)
            end,

            [13298] = function() -- Scold the chocobo
                chocoState = xi.chocoboRaising.onRaisingEventPlayout(player, xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME, chocoState)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name, 0, 0, 0, 0, 0, 0, 0)
                player:updateEvent(xi.chocoboRaising.getCutsceneWithOffset(player, xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME), 0, 0, 0, chocoState.stage, 0, 0, 0)
                xi.chocoboRaising.updateChocoState(player, chocoState)
            end,

            [13554] = function() -- Compete with others
                -- player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                --     4163, 67, 0, 0, 0, 0, 0)
                -- player:updateEvent(820, 18017, 0, 72, 3, 254, 46, 1)

                -- 0: player chocobo, 1: tie, 2: rival chocobo
                -- NOTE: The guides claim that the winner is random, so
                --     : let's make it 50/50 to start with, and then a small
                --     : chance on top for a tie.
                local winner = utils.randomEntry({ 0, 2 })
                if math.random(1, 100) <= 5 then
                    winner = 1
                end

                local winnerStr =
                {
                    [0] = 'Player',
                    [1] = 'Tie',
                    [2] = 'Rival',
                }

                debug('Competition Winner: ' .. winnerStr[winner])

                -- TODO: Use relevant name for area
                local rivalsName = 'Hero'

                -- TODO: Hook up rival's look

                -- TODO: Track wins in chocoState+db, only need to track up to 3

                chocoState = xi.chocoboRaising.onRaisingEventPlayout(player, xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS, chocoState)

                player:updateEventString(chocoState.first_name, rivalsName, '', '', 0, 0, 0, 0, 0, 0, 0)
                player:updateEvent(xi.chocoboRaising.getCutsceneWithOffset(player, xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS), 0, winner, 0, chocoState.stage, 0, 0, 0)
            end,

            [250] = function() -- Set Basic Care (menu)
                local plan1Length = bit.rshift(bit.band(chocoState.care_plan, 0xF0000000), 28)
                local plan1Type   = bit.rshift(bit.band(chocoState.care_plan, 0x0F000000), 24)
                local plan2Length = bit.rshift(bit.band(chocoState.care_plan, 0x00F00000), 20)
                local plan2Type   = bit.rshift(bit.band(chocoState.care_plan, 0x000F0000), 16)
                local plan3Length = bit.rshift(bit.band(chocoState.care_plan, 0x0000F000), 12)
                local plan3Type   = bit.rshift(bit.band(chocoState.care_plan, 0x00000F00),  8)
                local plan4Length = bit.rshift(bit.band(chocoState.care_plan, 0x000000F0),  4)
                local plan4Type   = bit.rshift(bit.band(chocoState.care_plan, 0x0000000F),  0)

                local planInfo =
                    bit.lshift(plan1Length,   0) + bit.lshift(plan1Type,   3) +
                    bit.lshift(plan2Length,   8) + bit.lshift(plan2Type,  11) +
                    bit.lshift(plan3Length,  16) + bit.lshift(plan3Type,  19) +
                    bit.lshift(plan4Length,  24) + bit.lshift(plan4Type,  27)

                -- TODO: Set up mask for relevant stage
                local menuMask = 0 -- 0x7FFFFFFE

                player:updateEvent(250, planInfo, 0, 0, 0, 0, 0, menuMask)
            end,

            [254] = function() -- Set Basic Care plan 1
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [510] = function() -- Set Basic Care plan 2
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [766] = function() -- Set Basic Care plan 3
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [1022] = function() -- Set Basic Care plan 4
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [1056] = function() -- Unknown
                print('ChocoboRaising: Unknown update: 1056')
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [1241] = function() -- Called during 'Compete with Others'
                -- Appears to always be blank
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [246] = function() -- Update CS
                chocoState = xi.chocoboRaising.handleCSUpdate(player, chocoState, true)
            end,

            [256] = function() -- Brief report?
                --
            end,

            [504] = function() -- Skip report
                -- TODO: Set up movement between chocoState.report.events and chocoState.csList to
                --     : include the length of each playout in days, so it can be used in handleCSUpdate()
                --     : to multiply values etc.
                -- Prepare chocoState.csList
                for _, currentEvent in pairs (chocoState.report.events) do
                    local eventStartStart = currentEvent[1]
                    -- local eventStartEnd = currentEvent[2]
                    local eventCSList = currentEvent[3]

                    chocoState.age   = eventStartStart
                    chocoState.stage = xi.chocoboRaising.ageToStage(chocoState.age)

                    for _, cs in pairs(eventCSList) do
                        table.insert(chocoState.csList, cs)
                    end
                end

                chocoState.report.events = {}

                -- NOTE: each cs will be popped off inside of handleCSUpdate
                while #chocoState.csList > 0 do
                    chocoState = xi.chocoboRaising.handleCSUpdate(player, chocoState, false)
                end

                xi.chocoboRaising.updateChocoState(player, chocoState)
            end,

            [221] = function() -- Buy your chocobo whistle
                --
            end,

            [222] = function() -- Recieve your chocobo whistle
                --
            end,

            [482] = function() -- DEBUG: Go forward 1 unit
                -- TODO: Split stored age and time of creation so age can be manipulated
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [229] = function() -- DEBUG: Abilities print
                player:updateEvent(1, xi.chocoboRaising.packStats1(chocoState), xi.chocoboRaising.packStats2(chocoState), 0, 0, 0, 0, 0)
            end,

            [232] = function() -- DEBUG: User work print
                -- TODO: Should we be tracking all user interactions with the chocobo?
            end,

            [240] = function() -- Give up your chocobo
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
                player:deleteRaisedChocobo()
            end,

            [255] = function() -- Synthetic update: Change/set chocobo name
                -- If the name is still 'Chocobo Chocobo' then the renaming failed or was
                -- rejected, play the appropriate response.
                if chocoState.first_name == 'Chocobo' and chocoState.last_name == 'Chocobo' then
                    player:updateEvent(1, 1, 1, 1, 1, 1, 1, 1)
                else
                    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
                end
            end,

            [40] = function() -- Retire your chocobo
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
                player:deleteRaisedChocobo()
            end,
        }
    end
end
