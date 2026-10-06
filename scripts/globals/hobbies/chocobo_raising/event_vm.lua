-----------------------------------
-- Chocobo Raising - Update Event VM
-- Options are a command in the low byte and an argument above it.
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/walks')
require('scripts/globals/hobbies/chocobo_raising/whistle')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

local skipReportArg = 1

local failedCareAction = 0x80000000

local maxCarePlanSlot   = 3
local maxCarePlanLength = 7

-- The hiding walk is picked once per quest; a cured handkerchief comes back dirty, a missed one plain.
local whistleSearchVar = '[ChocoboRaising]WhistleSearchWalk'

-----------------------------------
-- Tables
-----------------------------------
---@enum chocoboRaisingCommand
local command =
{
    UNKNOWN_32                 = 32,
    AFTER_RETIREMENT           = 40,
    PRESENT_CHOCOBO_MOOD       = 46,
    TELL_STORY                 = 50,
    WHISTLE_SEARCH             = 88,
    RECEIVE_STORY_KEY_ITEM     = 95,
    RETIRE_YOUR_CHOCOBO        = 96,
    CHECK_REPORT_STATUS        = 208,
    PRE_MENU                   = 214,
    MAIN_MENU                  = 215,
    FORCED_NAMING              = 216,
    WALK_ENCOUNTER             = 217,
    BUY_CHOCOBO_WHISTLE        = 221,
    RECEIVE_CHOCOBO_WHISTLE    = 222,
    REGISTER_CHOCOBO_WHISTLE   = 223,
    DEBUG_GO_FORWARD           = 226,
    DEBUG_ABILITIES_PRINT      = 229,
    DEBUG_USER_WORK_PRINT      = 232,
    GIVE_UP_CHOCOBO            = 240,
    FEED_CHOCOBO               = 241,
    CARE_ACTION                = 242,
    CARE_FOR_CHOCOBO_MENU      = 243,
    PRESENT_CHOCOBO_APPEARANCE = 244,
    EVENT_PLAYOUT              = 246,
    REPORT                     = 248,
    SET_CARE_SCHEDULE_MENU     = 250,
    ASK_ABOUT_CONDITION_MENU   = 251,
    UNKNOWN_252                = 252,
    SET_CARE_PLAN              = 254,
    NAME_CHOCOBO               = 255,
}

local commandNames = {}
for name, value in pairs(command) do
    commandNames[value] = name
end

-- Cutscenes that still play when the report is skipped.
local mandatoryCutscenes = set
{
    xi.chocoboRaising.cutscenes.ADULT_2_TO_ADULT_3,
    xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4,
}

local carePlanStage =
{
    [xi.chocoboRaising.carePlans.BASIC_CARE]               = xi.chocoboRaising.stage.EGG,
    [xi.chocoboRaising.carePlans.RESTING]                  = xi.chocoboRaising.stage.CHICK,
    [xi.chocoboRaising.carePlans.TAKING_A_WALK]            = xi.chocoboRaising.stage.CHICK,
    [xi.chocoboRaising.carePlans.LISTENING_TO_MUSIC]       = xi.chocoboRaising.stage.CHICK,
    [xi.chocoboRaising.carePlans.EXERCISING_ALONE]         = xi.chocoboRaising.stage.ADOLESCENT,
    [xi.chocoboRaising.carePlans.EXCERCISING_IN_A_GROUP]   = xi.chocoboRaising.stage.ADOLESCENT,
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHILDREN]    = xi.chocoboRaising.stage.ADOLESCENT,
    [xi.chocoboRaising.carePlans.PLAYING_WITH_CHOCOBOS]    = xi.chocoboRaising.stage.ADOLESCENT,
    [xi.chocoboRaising.carePlans.CARRYING_PACKAGES]        = xi.chocoboRaising.stage.ADOLESCENT,
    [xi.chocoboRaising.carePlans.EXHIBITING_TO_THE_PUBLIC] = xi.chocoboRaising.stage.ADOLESCENT,
    [xi.chocoboRaising.carePlans.DELIVERING_MESSAGES]      = xi.chocoboRaising.stage.ADULT_1,
    [xi.chocoboRaising.carePlans.DIGGING_FOR_TREASURE]     = xi.chocoboRaising.stage.ADULT_1,
    [xi.chocoboRaising.carePlans.ACTING_IN_A_PLAY]         = xi.chocoboRaising.stage.ADULT_1,
}

local walkDistance =
{
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_SHORT]   = 1,
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_REGULAR] = 2,
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_LONG]    = 3,
}

local walkLocations =
{
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_SHORT]   = 'shortWalkLocation',
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_REGULAR] = 'mediumWalkLocation',
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_LONG]    = 'longWalkLocation',
}

local careActionMenu =
{
    [xi.chocoboRaising.cutscenes.HAPPY_TO_SEE_YOU]         = { bit = 0, stage = xi.chocoboRaising.stage.EGG },
    [xi.chocoboRaising.cutscenes.INTERESTED_IN_YOUR_STORY] = { bit = 1, stage = xi.chocoboRaising.stage.ADOLESCENT },
    [xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME]      = { bit = 2, stage = xi.chocoboRaising.stage.CHICK },
    [xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS]      = { bit = 3, stage = xi.chocoboRaising.stage.ADOLESCENT },
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_SHORT]       = { bit = 4, stage = xi.chocoboRaising.stage.CHICK },
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_REGULAR]     = { bit = 5, stage = xi.chocoboRaising.stage.ADOLESCENT },
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_LONG]        = { bit = 6, stage = xi.chocoboRaising.stage.ADULT_1 },
}

-- Trainer stories heard on a walk, by RECEIVE_STORY_KEY_ITEM's argument.
local walkStoryKeyItems =
{
    [1] = xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO,
    [2] = xi.keyItem.STORY_OF_A_CURIOUS_CHOCOBO,
    [3] = xi.keyItem.STORY_OF_A_WORRISOME_CHOCOBO,
    [4] = xi.keyItem.STORY_OF_A_YOUTHFUL_CHOCOBO,
    [5] = xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO,
}

-- A sleeping chocobo can only be watched over or scolded awake.
local sleepingCareActions = set
{
    xi.chocoboRaising.cutscenes.HAPPY_TO_SEE_YOU,
    xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME,
}

-----------------------------------
-- Helpers
-----------------------------------
-- Energy before in bits 0-7 and after in bits 8-15, or the failure flag with the action.
local function spendEnergy(player, chocoState, careAction, weather)
    local costs = xi.chocoboRaising.careActionEnergy[careAction]

    local keep = 100 - utils.clamp(player:getMod(xi.mod.CHOCOBO_CARE_ENERGY), 0, 100)

    if chocoState.energy < math.ceil(costs[2] * keep / 100) then
        return bit.bor(failedCareAction, careAction), false
    end

    local cost = costs[2]
    if
        weather == xi.weather.NONE or
        weather == xi.weather.SUNSHINE
    then
        cost = costs[1]
    end

    cost = math.ceil(cost * keep / 100)

    local before      = chocoState.energy
    chocoState.energy = before - cost

    return before + bit.lshift(chocoState.energy, 8), true
end

local function sendNameStrings(player, chocoState)
    local fullName, firstName, lastName = xi.chocoboRaising.nameStrings(chocoState)

    player:updateEventString(fullName, firstName, lastName, lastName, 0, 0, 0, 0, 0, 0, 0, 0)
end

local function carePlanOffered(chocoState, planType)
    local stage = carePlanStage[planType]

    return stage ~= nil and chocoState.stage >= stage
end

local function unpackCarePlanArg(arg)
    return
        bit.band(0xFF, arg),
        bit.band(0x7, bit.rshift(arg, 8)),
        bit.band(0x1F, bit.rshift(arg, 11))
end

local function containsRetirement(cutscenes)
    for _, cutscene in ipairs(cutscenes) do
        if cutscene == xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4 then
            return true
        end
    end

    return false
end

-- Any GM level counts, whether or not GM visibility is on.
local function isGM(player)
    return player:getGMLevel() >= 1
end

-- The client redraws from 244 after every report scene, so it shows the stage the report has reached.
local function shownStage(chocoState)
    local report = chocoState.report
    if
        not report or
        (#report.events == 0 and #chocoState.csList == 0)
    then
        return chocoState.stage
    end

    if chocoState.reportStage then
        return chocoState.reportStage
    end

    return xi.chocoboRaising.ageToStage(report.events[1][1])
end

local function careActionOffered(chocoState, careAction)
    local entry = careActionMenu[careAction]
    if
        not entry or
        chocoState.stage < entry.stage or
        xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.RUN_AWAY)
    then
        return false
    end

    if
        xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.SLEEPING) and
        not sleepingCareActions[careAction]
    then
        return false
    end

    if careAction == xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS then
        return xi.chocoboRaising.walks.canCompete(chocoState)
    end

    return true
end

-- A paste has other values for a chick.
local function foodValue(itemData, chocoState, key)
    if
        itemData.chick and
        chocoState.stage == xi.chocoboRaising.stage.CHICK and
        itemData.chick[key]
    then
        return itemData.chick[key]
    end

    return itemData[key]
end

-----------------------------------
-- Private Functions
-----------------------------------
local function handleNamingUpdate(player, chocoState, arg)
    local offset1     = bit.band(0x3FF, arg)
    local offset2     = bit.band(0x3FF, bit.rshift(arg, 10))
    local fname       = xi.chocoboNames[offset1]
    local lname       = xi.chocoboNames[offset2]
    local fullnamekey = string.format('%s %s', fname, lname)

    local nameTooLong = string.len(fullnamekey) > 15 + 1

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
    end

    if xi.chocoboRaising.isNamed(chocoState) then
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:updateEvent(1, 1, 1, 1, 1, 1, 1, 1)
    end
end

local function handleCarePlanUpdate(player, chocoState, arg)
    local carePlanSlot, carePlanLength, carePlanType = unpackCarePlanArg(arg)

    if chocoState.care_plan == 0 then
        local defaultCarePlan = bit.lshift(7, 4) + 0

        chocoState.care_plan =
            bit.lshift(defaultCarePlan, 24) +
            bit.lshift(defaultCarePlan, 16) +
            bit.lshift(defaultCarePlan,  8) +
            bit.lshift(defaultCarePlan,  0)
    end

    local carePlan         = bit.lshift(carePlanLength, 4) + carePlanType
    local targetSlotOffset = 24 - carePlanSlot * 8
    local mask             = bit.bnot(bit.lshift(0xFF, targetSlotOffset))
    local zerodCarePlan    = bit.band(chocoState.care_plan, mask)

    chocoState.care_plan = bit.bor(zerodCarePlan, bit.lshift(carePlan, targetSlotOffset))

    debug(string.format('%s updating chocobo care plan: slot: %i type: %i length: %i',
        player:getName(), carePlanSlot + 1, carePlanType, carePlanLength))

    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- Reply p0: 0 interested, 1 learned, 2 inspired.
local function handleStoryUpdate(player, chocoState, arg)
    debug(string.format('Story: %i', arg))

    chocoState.storyPending = nil

    local result, effects = xi.chocoboRaising.walks.tellStory(chocoState, arg)

    -- The key item goes at once, so the gains are saved with it.
    xi.chocoboRaising.updateChocoState(player, chocoState)
    xi.chocoboRaising.applyEffects(player, effects)
    player:updateEvent(result, 0, 0, 0, 0, 0, 0, 0)
end

-- Reply: cutscene, energy, walk event, event data, stage, trainer met, meeting count, weather.
local function handleGoOnAWalk(player, chocoState, careAction)
    local location   = xi.chocoboRaising.raisingLocation[player:getZoneID()]
    local walkZoneId = xi.chocoboRaising[walkLocations[careAction]][location]
    local weather    = xi.chocoboRaising.getWeatherInZone(walkZoneId)
    local cutscene   = xi.chocoboRaising.getCutsceneWithOffset(player, careAction)

    sendNameStrings(player, chocoState)

    local energy, walked = spendEnergy(player, chocoState, careAction, weather)
    if not walked then
        player:updateEvent(cutscene, energy, 0, 0, chocoState.stage, 0, 0, weather)
        return
    end

    local isWhistleQuestProg = xi.chocoboRaising.whistleProgress(player) == xi.chocoboRaising.whistle.prog.SEARCH
    if
        isWhistleQuestProg and
        chocoState.stage >= xi.chocoboRaising.stage.ADULT_1
    then
        chocoState.whistleSearchWalk = walkDistance[careAction]
        xi.chocoboRaising.updateChocoState(player, chocoState)
        -- A nonzero p6 is a meeting count, which skips the search.
        player:updateEvent(cutscene, energy, 1, 0, chocoState.stage, 0, 0, weather)
        return
    end

    local ctx =
    {
        location        = location,
        walkZone        = walkZoneId,
        lostChick       = player:getCharVar(xi.chocoboRaising.walks.lostChickVar),
        canMeetDietmund = player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) and
            not xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.MET_DIETMUND),
    }

    local result, effects = xi.chocoboRaising.walks.walk(chocoState, careAction, ctx)

    -- Saved before the rewards, so leaving the event cannot earn them twice.
    xi.chocoboRaising.updateChocoState(player, chocoState)
    xi.chocoboRaising.applyEffects(player, effects)
    player:updateEvent(cutscene, energy, result.event, result.data, chocoState.stage, result.trainer, result.meeting, weather)
end

-- Reply p2: 1 item given, 2 inventory full.
local function handleWatchOver(player, chocoState, careAction)
    local weather  = xi.chocoboRaising.getWeatherInZone(player:getZoneID())
    local cutscene = xi.chocoboRaising.getCutsceneWithOffset(player, careAction)

    local energy  = chocoState.energy + bit.lshift(chocoState.energy, 8)
    local watched = true

    if chocoState.stage ~= xi.chocoboRaising.stage.EGG then
        energy, watched = spendEnergy(player, chocoState, careAction, weather)
    end

    if not watched then
        player:updateEvent(cutscene, energy, 0, 0, chocoState.stage, 0, 0, weather)
        return
    end

    local givingItem = 0
    local givenItem  = 0

    if chocoState.held_item > 0 then
        givingItem = 1
        givenItem  = chocoState.held_item

        if player:getFreeSlotsCount() == 0 then
            givingItem = 2
        end
    end

    -- Saved before the item is given, so leaving the event or a failed save cannot give it twice.
    if givingItem == 1 then
        chocoState.held_item = 0

        if not xi.chocoboRaising.updateChocoState(player, chocoState) then
            chocoState.held_item = givenItem
            givingItem           = 0
            givenItem            = 0
        end
    end

    player:updateEvent(cutscene, energy, givingItem, givenItem, chocoState.stage, 0, 0, weather)

    if givingItem == 1 then
        player:addItem({ id = givenItem, silent = true })
    end
end

-- Reply p2: a set bit hides the story.
local function handleTellAStory(player, chocoState, careAction)
    local weather  = xi.chocoboRaising.getWeatherInZone(player:getZoneID())
    local cutscene = xi.chocoboRaising.getCutsceneWithOffset(player, careAction)

    local stories =
    {
        xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO,
        xi.keyItem.STORY_OF_A_CURIOUS_CHOCOBO,
        xi.keyItem.STORY_OF_A_WORRISOME_CHOCOBO,
        xi.keyItem.STORY_OF_A_YOUTHFUL_CHOCOBO,
        xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO,
        xi.keyItem.STORY_OF_A_DILIGENT_CHOCOBO,
    }

    -- Bit 0 is chitchat, always offered.
    local storyMask = bit.bnot(1)
    for index, keyItem in ipairs(stories) do
        if player:hasKeyItem(keyItem) then
            storyMask = bit.band(storyMask, bit.bnot(bit.lshift(1, index)))
        end
    end

    sendNameStrings(player, chocoState)

    local energy, told = spendEnergy(player, chocoState, careAction, weather)
    if told then
        chocoState.storyPending = true
        xi.chocoboRaising.updateChocoState(player, chocoState)
    end

    player:updateEvent(cutscene, energy, storyMask, 0, chocoState.stage, 0, 0, weather)
end

local function handleScold(player, chocoState, careAction)
    local weather  = xi.chocoboRaising.getWeatherInZone(player:getZoneID())
    local cutscene = xi.chocoboRaising.getCutsceneWithOffset(player, careAction)

    local energy, scolded = spendEnergy(player, chocoState, careAction, weather)
    local woke            = 0

    if scolded then
        if xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.SLEEPING) then
            xi.chocoboRaising.setCondition(chocoState, xi.chocoboRaising.conditions.SLEEPING, false)
            woke = 1
        end

        xi.chocoboRaising.onRaisingEventPlayout(player, careAction, chocoState)
    end

    sendNameStrings(player, chocoState)

    -- p2 is 1 when the scold woke the chocobo.
    player:updateEvent(cutscene, energy, woke, 0, chocoState.stage, 0, 0, weather)
end

-- Result: 0 win, 2 loss, 3 the win that earns the happy story.
local function handleCompete(player, chocoState, careAction)
    local weather  = xi.chocoboRaising.getWeatherInZone(player:getZoneID())
    local cutscene = xi.chocoboRaising.getCutsceneWithOffset(player, careAction)

    local energy, competed = spendEnergy(player, chocoState, careAction, weather)
    local result           = 0

    if competed then
        local effects

        result, effects = xi.chocoboRaising.walks.compete(chocoState)

        -- Saved before the rewards, so leaving the event cannot earn them twice.
        xi.chocoboRaising.updateChocoState(player, chocoState)
        xi.chocoboRaising.applyEffects(player, effects)
        xi.chocoboRaising.onRaisingEventPlayout(player, careAction, chocoState)
    end

    local rivalsName = xi.chocoboRaising.walks.friendName(xi.chocoboRaising.walkTrainer.RIVALS, player:getChocoboUserData().chocobosRaised)
    local fullName   = xi.chocoboRaising.nameStrings(chocoState)

    player:updateEventString(fullName, rivalsName, '', '', 0, 0, 0, 0, 0, 0, 0, 0)
    player:updateEvent(cutscene, energy, result, 0, chocoState.stage, 0, 0, weather)
end

-- Header: first day in bits 0-9, day count in 10-19, last day in 20-29, bit 31 when more follow.
local function handleReport(player, chocoState, arg)
    chocoState.skipping = arg == skipReportArg

    if #chocoState.report.events == 0 then
        local nextDay = chocoState.last_update_age
        local header  = nextDay + bit.lshift(nextDay - 1, 20)

        player:updateEvent(command.REPORT, header, 0, 0, chocoState.stage, xi.chocoboRaising.isNamed(chocoState) and 1 or 0, 0, 0)
        return
    end

    local record = table.remove(chocoState.report.events, 1)
    local first  = record[1]
    local last   = record[2]
    local days   = last - first + 1

    chocoState.reportStage = xi.chocoboRaising.ageToStage(first)

    for _, cutscene in ipairs(record[3]) do
        table.insert(chocoState.csList, { cutscene, days, #record[3] })
    end

    local header = first + bit.lshift(days, 10) + bit.lshift(last, 20)
    if #chocoState.report.events > 0 then
        header = header + 0x80000000
    end

    local retirement = 0
    if containsRetirement(record[3]) then
        retirement            = 1
        chocoState.retiring   = true
        chocoState.rewardCard = true
    end

    -- p3: gil in bits 0-15, good days in 16-23, poor days in 24-31. p6: the record's conditions.
    local totals  = record[4]
    local outcome = bit.band(totals.gil, 0xFFFF) + bit.lshift(totals.good, 16) + bit.lshift(totals.poor, 24)

    -- Unnamed until the growth scene: then the client names the chocobo from the event strings.
    local shownNamed = xi.chocoboRaising.isNamed(chocoState) and 1 or 0
    if
        chocoState.last_name == '' and
        chocoState.reportStage < xi.chocoboRaising.stage.ADULT_3
    then
        shownNamed = 0
    end

    player:updateEvent(command.REPORT, header, #chocoState.csList, outcome, chocoState.reportStage, shownNamed, record[5], retirement)
end

local function handlePlayout(player, chocoState, arg)
    if #chocoState.csList == 0 then
        player:updateEvent(0xFFFFFFFF, 0, 0, 0, chocoState.reportStage or chocoState.stage, 0, 0, 0)
        return
    end

    if chocoState.skipping then
        while #chocoState.csList > 0 and not mandatoryCutscenes[chocoState.csList[1][1]] do
            table.remove(chocoState.csList, 1)
        end

        if #chocoState.csList == 0 then
            player:updateEvent(0xFFFFFFFF, 0, 0, 0, chocoState.reportStage or chocoState.stage, 0, 0, 0)
            return
        end
    end

    xi.chocoboRaising.handleCSUpdate(player, chocoState)
end

local function handleMainMenu(player, chocoState, arg)
    local menuFlags = 0xFFFFFFFF

    local askAboutChocoboCondition = -bit.lshift(0x01, 0)
    local setUpCareSchedule        = -bit.lshift(0x01, 2)

    menuFlags = menuFlags +
        askAboutChocoboCondition +
        setUpCareSchedule

    -- A chocobo that ran away can be neither cared for nor let go.
    local ranAway = xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.RUN_AWAY)

    if not ranAway then
        local careForYourChocobo = -bit.lshift(0x01, 1)
        menuFlags                = menuFlags + careForYourChocobo
    end

    if
        chocoState.stage > xi.chocoboRaising.stage.EGG and
        not xi.chocoboRaising.isNamed(chocoState)
    then
        local nameYourChocobo = -bit.lshift(0x01, 3)
        menuFlags             = menuFlags + nameYourChocobo
    end

    if chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 then
        local requestDocumentation = -bit.lshift(0x01, 4)
        menuFlags                  = menuFlags + requestDocumentation
    end

    if
        chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 and
        xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.WHISTLE_QUEST_DONE)
    then
        local registerToCallYourChocobo = -bit.lshift(0x01, 5)
        menuFlags                       = menuFlags + registerToCallYourChocobo
    end

    if xi.chocoboRaising.whistle.canReceiveWhistle(player) then
        local receiveChocoboWhistle = -bit.lshift(0x01, 6)
        menuFlags                   = menuFlags + receiveChocoboWhistle
    end

    if xi.chocoboRaising.whistle.canBuyWhistle(player) then
        local purchaseChocoboWhistle = -bit.lshift(0x01, 7)
        menuFlags                    = menuFlags + purchaseChocoboWhistle
    end

    -- The same check as the guard, so a GM sees exactly what the guard allows.
    if isGM(player) then
        local goForward1UnitDebug = -bit.lshift(0x01, 26)
        local abilitiesPrintDebug = -bit.lshift(0x01, 27)
        local userWorkPrintDebug  = -bit.lshift(0x01, 28)

        menuFlags = menuFlags +
            goForward1UnitDebug +
            abilitiesPrintDebug +
            userWorkPrintDebug
    end

    if not ranAway then
        if chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 then
            local retireYourChocobo = -bit.lshift(0x01, 29)
            menuFlags               = menuFlags + retireYourChocobo
        else
            local giveUpChocoboRaising = -bit.lshift(0x01, 30)
            menuFlags                  = menuFlags + giveUpChocoboRaising
        end
    end

    local exit = -bit.lshift(0x01, 31)
    menuFlags  = menuFlags + exit

    player:updateEvent(menuFlags, 0, 0, 0, 0, 0, 0, 0)
end

-- Egg: p1 1. Adult: p1 large beak, p2 large talons, p3 full tail.
local function handleAppearance(player, chocoState, arg)
    local stage = shownStage(chocoState)

    local color = xi.chocoboRaising.color.YELLOW
    if stage >= xi.chocoboRaising.stage.ADOLESCENT then
        color = chocoState.color
    end

    if stage == xi.chocoboRaising.stage.EGG then
        player:updateEvent(color, 1, 0, 0, stage, 1, 0, 0)
        return
    end

    if stage < xi.chocoboRaising.stage.ADULT_1 then
        player:updateEvent(color, 0, 0, 0, stage, 1, 0, 0)
        return
    end

    local appearance  = chocoState.appearance or 0
    local largeBeak   = bit.band(appearance, xi.chocoboRaising.appearance.LARGE_BEAK) ~= 0 and 1 or 0
    local largeTalons = bit.band(appearance, xi.chocoboRaising.appearance.LARGE_TALONS) ~= 0 and 1 or 0
    local fullTail    = bit.band(appearance, xi.chocoboRaising.appearance.FULL_TAIL) ~= 0 and 1 or 0

    player:updateEvent(color, largeBeak, largeTalons, fullTail, stage, 1, 0, 0)
end

local function handleCondition(player, chocoState, arg)
    local affection = xi.chocoboRaising.affectionToAffectionRank(chocoState.affection)
    local energy    = xi.chocoboRaising.energyToRank(chocoState.energy)
    local hunger    = xi.chocoboRaising.numberToRank(chocoState.hunger)

    local female = 0
    if
        chocoState.stage > xi.chocoboRaising.stage.EGG and
        chocoState.sex == xi.chocoboRaising.gender.FEMALE
    then
        female = 1
    end

    local arg1 = xi.chocoboRaising.packStats1(chocoState)
    local arg2 = affection + bit.lshift(energy, 8) + bit.lshift(hunger, 16)
    local arg3 = bit.lshift(chocoState.personality, 0) +
        bit.lshift(chocoState.weather_preference, 4) +
        bit.lshift(chocoState.ability1, 8) +
        bit.lshift(chocoState.ability2, 12) +
        bit.lshift(chocoState.stage, 16) +
        bit.lshift(female, 19)

    -- The pending cures above bit 15 stay on the server.
    local arg4 = bit.band(chocoState.conditions, 0xFFFF)

    player:updateEvent(command.ASK_ABOUT_CONDITION_MENU, arg1, arg2, arg3, arg4, 0, 0, 0)
end

local function handleCareMenu(player, chocoState, arg)
    local mask = 0x7FFFFFFF
    for careAction, entry in pairs(careActionMenu) do
        if careActionOffered(chocoState, careAction) then
            mask = mask - bit.lshift(1, entry.bit)
        end
    end

    player:updateEvent(mask, chocoState.energy, 0, 0, 0, 0, 0, 0)
end

local function eatFood(chocoState, itemData)
    -- A chocobo fed while completely full gets no energy from it.
    local full = xi.chocoboRaising.numberToRank(chocoState.hunger) >= xi.chocoboRaising.hunger.COMPLETELY_FULL

    chocoState.hunger    = utils.clamp(chocoState.hunger + foodValue(itemData, chocoState, 'hunger'), 0, xi.chocoboRaising.maxHunger)
    chocoState.affection = utils.clamp(chocoState.affection + foodValue(itemData, chocoState, 'affection'), 0, 255)

    if
        itemData.energy and
        not full
    then
        chocoState.energy = utils.clamp(chocoState.energy + itemData.energy, 0, 100)
    end

    if itemData.stats then
        for index, field in ipairs(xi.chocoboRaising.statFields) do
            xi.chocoboRaising.addToStat(chocoState, field, itemData.stats[index] * xi.chocoboRaising.statPerFoodArrow)
        end
    end

    -- Cures wait for the next rollover.
    for _, condition in ipairs(foodValue(itemData, chocoState, 'cures') or {}) do
        xi.chocoboRaising.addPendingCure(chocoState, condition)
    end

    local randomStat = foodValue(itemData, chocoState, 'randomStat')
    if
        randomStat and
        xi.chocoboRaising.rolls(randomStat.chance)
    then
        local index  = randomStat.stats[math.randomInt(1, #randomStat.stats)]
        local change = xi.chocoboRaising.statPerFoodArrow
        if
            randomStat.lowers or
            (randomStat.eitherWay and math.randomInt(1, 2) == 1)
        then
            change = -change
        end

        xi.chocoboRaising.addToStat(chocoState, xi.chocoboRaising.statFields[index], change)
    end

    if itemData.wakes then
        xi.chocoboRaising.setCondition(chocoState, xi.chocoboRaising.conditions.SLEEPING, false)
    end

    -- Once the colour shows, a new gene only matters for breeding.
    if itemData.rerollGene then
        local gene = string.format('allele%d', math.randomInt(1, 3))

        chocoState[gene] = math.randomInt(xi.chocoboRaising.color.YELLOW, xi.chocoboRaising.color.GREEN)

        if chocoState.stage < xi.chocoboRaising.stage.ADOLESCENT then
            chocoState.color = xi.chocoboRaising.allelesToColor({ chocoState.allele1, chocoState.allele2, chocoState.allele3 })
        end
    end

    if
        itemData.forgetsAbility and
        xi.chocoboRaising.rolls(xi.chocoboRaising.forgetChance)
    then
        local learned = {}
        for _, slot in ipairs({ 'ability1', 'ability2' }) do
            if chocoState[slot] ~= 0 then
                table.insert(learned, slot)
            end
        end

        if #learned > 0 then
            chocoState[utils.randomEntry(learned)] = 0
        end
    end
end

-- Reply: item (10 for several), glow or the refused item, -1 when overfed, 1 when the items differ, 1, hunger rank.
local function handleFeed(player, chocoState, arg)
    if not player:confirmTrade() then
        chocoState.foodGiven = {}
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        return
    end

    local ID     = zones[player:getZoneID()]
    local glow   = xi.chocoboRaising.glow.NONE
    local mixed  = 0
    local forced = 0

    for idx, itemId in ipairs(chocoState.foodGiven) do
        local itemData = xi.chocoboRaising.validFoods[itemId]

        -- An item eaten while full counts as forced, even if earlier ones were not.
        if xi.chocoboRaising.numberToRank(chocoState.hunger) >= xi.chocoboRaising.hunger.COMPLETELY_FULL then
            forced = 0xFFFFFFFF
        end

        player:messageSpecial(ID.text.CHOCOBO_FEEDING_ITEM, itemId, idx)
        eatFood(chocoState, itemData)
        glow = itemData.glow

        if itemId ~= chocoState.foodGiven[1] then
            mixed = 1
        end
    end

    local shown = 10
    if #chocoState.foodGiven == 1 then
        shown = chocoState.foodGiven[1]
    end

    if forced ~= 0 then
        glow = chocoState.foodGiven[#chocoState.foodGiven]
        chocoState.conditions = bit.bor(chocoState.conditions, bit.lshift(1, xi.chocoboRaising.forcedFeedFlag))
    end

    player:updateEvent(shown, glow, forced, mixed, 1, xi.chocoboRaising.numberToRank(chocoState.hunger), 0, 0)

    chocoState.foodGiven = {}
    xi.chocoboRaising.updateChocoState(player, chocoState)
end

local function handleMood(player, chocoState, arg)
    player:updateEvent(bit.band(chocoState.conditions, 0xFFFF), 0, 0, 0, 0, 0, 0, 0)
end

local function handleWhistleSearch(player, chocoState, arg)
    chocoState.whistleSearchWalk = nil

    local hidingWalk = player:getCharVar(whistleSearchVar)
    if hidingWalk == 0 then
        hidingWalk = math.randomInt(1, 3)
        player:setCharVar(whistleSearchVar, hidingWalk)
    end

    if arg ~= hidingWalk then
        player:updateEvent(0, 0, 0, 0, 0, 2, 0, 0)
        return
    end

    local keyItem = xi.keyItem.HANDKERCHIEF
    if xi.chocoboRaising.handkerchiefState(player) == xi.chocoboRaising.handkerchief.DONE then
        keyItem = xi.keyItem.DIRTY_HANDKERCHIEF
    end

    player:updateEvent(keyItem, 0, 0, 0, 0, 1, 0, 0)
    xi.chocoboRaising.setWhistleProgress(player, xi.chocoboRaising.whistle.prog.FOUND)
    player:setCharVar(whistleSearchVar, 0)
    player:addKeyItem(keyItem)
end

-- Argument: the retirement cutscene, location * 256 + 96.
local function handleRetire(player, chocoState, arg)
    player:updateEvent(0, arg, 0, 0, xi.chocoboRaising.stage.ADULT_4, 0, 0, 0)

    chocoState.retiring   = true
    chocoState.rewardCard = true
end

-- TODO: The reply without the gil.
local function handleRegister(player, chocoState, arg)
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    xi.chocoboRaising.whistle.register(player, chocoState)
end

local careActions =
{
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_SHORT]       = handleGoOnAWalk,
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_REGULAR]     = handleGoOnAWalk,
    [xi.chocoboRaising.cutscenes.GO_ON_A_WALK_LONG]        = handleGoOnAWalk,
    [xi.chocoboRaising.cutscenes.HAPPY_TO_SEE_YOU]         = handleWatchOver,
    [xi.chocoboRaising.cutscenes.INTERESTED_IN_YOUR_STORY] = handleTellAStory,
    [xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME]      = handleScold,
    [xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS]      = handleCompete,
}

local handlers =
{
    [command.AFTER_RETIREMENT] = function(player, chocoState, arg)
        player:updateEvent(chocoState.color, 0, 0, 0, 0, 0, 0, 0)
    end,

    [command.PRESENT_CHOCOBO_MOOD] = handleMood,
    [command.TELL_STORY]           = handleStoryUpdate,
    [command.WHISTLE_SEARCH]       = handleWhistleSearch,

    [command.UNKNOWN_32] = function(player, chocoState, arg)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    -- The key item was given at walk time; this only shows the message.
    [command.RECEIVE_STORY_KEY_ITEM] = function(player, chocoState, arg)
        local keyItem = walkStoryKeyItems[arg]
        if
            keyItem and
            player:hasKeyItem(keyItem)
        then
            player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, keyItem)
        end

        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    [command.RETIRE_YOUR_CHOCOBO] = handleRetire,

    [command.CHECK_REPORT_STATUS] = function(player, chocoState, arg)
        if #chocoState.report.events > 0 then
            player:updateEvent(0xFFFFFFFF, command.CHECK_REPORT_STATUS, 0, 0, shownStage(chocoState), 0, 0, 0)
        else
            player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        end
    end,

    -- The handkerchief hand-in plays from p1, outside the report.
    [command.PRE_MENU] = function(player, chocoState, arg)
        if xi.chocoboRaising.model.canReturnHandkerchief(xi.chocoboRaising.characterView(player)) then
            local cutscene = xi.chocoboRaising.getCutsceneWithOffset(player, xi.chocoboRaising.cutscenes.THAT_SHOULD_BE_ENOUGH)

            player:updateEvent(0, cutscene, 0, 0, 0, 0, 0, 0)
            xi.chocoboRaising.applyEffects(player, xi.chocoboRaising.model.returnHandkerchief())

            return
        end

        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    [command.MAIN_MENU] = handleMainMenu,

    -- The client names the chocobo itself and waits for no reply.
    [command.FORCED_NAMING] = function(player, chocoState, arg)
    end,

    -- The friend chocobo's name replaces the first name.
    [command.WALK_ENCOUNTER] = function(player, chocoState, arg)
        local trainerId  = xi.chocoboRaising.walks.followUpTrainer[arg]
        local friendName = xi.chocoboRaising.walks.friendName(trainerId, player:getChocoboUserData().chocobosRaised)
        local fullName, _, lastName = xi.chocoboRaising.nameStrings(chocoState)

        player:updateEventString(fullName, friendName, lastName, lastName, 0, 0, 0, 0, 0, 0, 0, 0)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    [command.REGISTER_CHOCOBO_WHISTLE] = handleRegister,

    -- Argument: days, always 1 from the menu. The client reads no reply.
    [command.DEBUG_GO_FORWARD] = function(player, chocoState, arg)
        xi.chocoboRaising.model.moveTime(chocoState, arg, xi.chocoboRaising.dayLength)
        xi.chocoboRaising.updateChocoState(player, chocoState)
        debug(string.format('Debug: moved time forward %d days', arg))
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    -- The client prints p1 as STR/VIT/INT/MND bytes and p2 as affection/energy/satisfaction bytes.
    [command.DEBUG_ABILITIES_PRINT] = function(player, chocoState, arg)
        local packedRawStats =
            bit.lshift(chocoState.strength,     0) +
            bit.lshift(chocoState.endurance,    8) +
            bit.lshift(chocoState.discernment, 16) +
            bit.lshift(chocoState.receptivity, 24)

        debug(string.format('Debug: abilities print STR:%d/VIT:%d/INT:%d/MND:%d, Affection:%d/Energy:%d/Satisfaction:%d',
            chocoState.strength, chocoState.endurance, chocoState.discernment, chocoState.receptivity,
            chocoState.affection, chocoState.energy, chocoState.satisfaction))
        player:updateEvent(1, packedRawStats, xi.chocoboRaising.packStats2(chocoState), 0, 0, 0, 0, 0)
    end,

    -- The client reads no reply and prints nothing, so the server prints what the debug menu shows.
    [command.DEBUG_USER_WORK_PRINT] = function(player, chocoState, arg)
        xi.chocoboRaising.printUserWork(player)
        debug('Debug: user work print')
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    [command.GIVE_UP_CHOCOBO] = function(player, chocoState, arg)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        chocoState.retiring = true
    end,

    [command.FEED_CHOCOBO] = handleFeed,

    [command.CARE_ACTION] = function(player, chocoState, arg)
        local handler = careActions[arg]
        if handler then
            handler(player, chocoState, arg)
            return
        end

        print(string.format('ERROR! Unknown chocobo care action: %i', arg))
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end,

    [command.CARE_FOR_CHOCOBO_MENU]      = handleCareMenu,
    [command.PRESENT_CHOCOBO_APPEARANCE] = handleAppearance,
    [command.EVENT_PLAYOUT]              = handlePlayout,
    [command.REPORT]                     = handleReport,

    [command.SET_CARE_SCHEDULE_MENU] = function(player, chocoState, arg)
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

        local menuMask = 0x7FFFFFFF
        for planType in pairs(carePlanStage) do
            if carePlanOffered(chocoState, planType) then
                menuMask = menuMask - bit.lshift(1, planType)
            end
        end

        -- p2 is the plan locked for the next day.
        player:updateEvent(command.SET_CARE_SCHEDULE_MENU, planInfo, chocoState.locked_plan, 0, 0, 0, 0, menuMask)
    end,

    [command.ASK_ABOUT_CONDITION_MENU] = handleCondition,

    [command.UNKNOWN_252] = function(player, chocoState, arg)
        local hasReport = 0
        if #chocoState.report.events > 0 then
            hasReport = 0xFFFFFFFF
        end

        player:updateEvent(hasReport, 1, 1, 1, chocoState.stage, 1, 1, 1)
    end,

    [command.SET_CARE_PLAN] = handleCarePlanUpdate,
    [command.NAME_CHOCOBO]  = handleNamingUpdate,
}

-- The client can send any option, so each command a menu hides is checked here.
local allowed =
{
    [command.DEBUG_GO_FORWARD]      = isGM,
    [command.DEBUG_ABILITIES_PRINT] = isGM,
    [command.DEBUG_USER_WORK_PRINT] = isGM,

    [command.RETIRE_YOUR_CHOCOBO] = function(player, chocoState, arg)
        return chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 and not xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.RUN_AWAY)
    end,

    [command.GIVE_UP_CHOCOBO] = function(player, chocoState, arg)
        return chocoState.stage < xi.chocoboRaising.stage.ADULT_1 and not xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.RUN_AWAY)
    end,

    [command.REGISTER_CHOCOBO_WHISTLE] = function(player, chocoState, arg)
        return chocoState.stage >= xi.chocoboRaising.stage.ADULT_1 and xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.WHISTLE_QUEST_DONE)
    end,

    [command.WHISTLE_SEARCH] = function(player, chocoState, arg)
        return chocoState.whistleSearchWalk == arg and
            xi.chocoboRaising.whistleProgress(player) == xi.chocoboRaising.whistle.prog.SEARCH
    end,

    [command.TELL_STORY] = function(player, chocoState, arg)
        local keyItem = xi.chocoboRaising.walks.storyKeyItems[arg]

        return chocoState.storyPending and
            (not keyItem or player:hasKeyItem(keyItem))
    end,

    [command.CARE_ACTION] = function(player, chocoState, arg)
        return careActionOffered(chocoState, arg)
    end,

    [command.NAME_CHOCOBO] = function(player, chocoState, arg)
        return chocoState.stage > xi.chocoboRaising.stage.EGG and not xi.chocoboRaising.isNamed(chocoState)
    end,

    [command.SET_CARE_PLAN] = function(player, chocoState, arg)
        local slot, length, planType = unpackCarePlanArg(arg)

        return slot <= maxCarePlanSlot and
            length >= 1 and
            length <= maxCarePlanLength and
            carePlanOffered(chocoState, planType)
    end,
}

-----------------------------------
-- Global Functions
-----------------------------------
-- Shared by the debug menu's "User work display" and the trainer's "User work print".
---@param player CBaseEntity
xi.chocoboRaising.printUserWork = function(player)
    local chick    = xi.chocoboRaising.walks.lostChick(player:getCharVar(xi.chocoboRaising.walks.lostChickVar))
    local userData = player:getChocoboUserData()

    player:printToPlayer(string.format('Handkerchief: %d, same zone: %d, whistle: %d, chocobos raised: %d, flags: 0x%X',
        xi.chocoboRaising.handkerchiefState(player),
        player:getLocalVar(xi.chocoboRaising.handkerchiefZoneVar),
        xi.chocoboRaising.whistleProgress(player),
        userData.chocobosRaised,
        userData.flags), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Lost chick: owner %d, stable %d, clues %d, solved %d',
        chick.owner, chick.location, chick.clues, chick.solved and 1 or 0), xi.msg.channel.SYSTEM_3)
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
xi.chocoboRaising.eventVM = function(player, csid, option, npc)
    local zoneID        = player:getZoneID()
    local csids         = xi.chocoboRaising.csidTable[zoneID]
    local mainCSID      = csids[2]
    local tradeCSID     = csids[3]
    local rejectionCSID = csids[4]

    if csid == tradeCSID then
        if option == command.UNKNOWN_252 then
            player:updateEvent(0, xi.chocoboRaising.raisingLocation[zoneID], 0, 0, 0, 0, 0, 0)
        end

        return
    end

    -- The egg rejection waits for the chocobo's stage.
    if csid == rejectionCSID then
        if option ~= command.PRESENT_CHOCOBO_APPEARANCE then
            return
        end

        local saved = player:getChocoboRaisingInfo()
        if saved then
            player:updateEvent(0, 0, 0, 0, saved.stage, 1, 0, 0)
        end

        return
    end

    if csid ~= mainCSID then
        return
    end

    local chocoState = xi.chocoboRaising.chocoState[player:getID()]
    if not chocoState then
        print('ERROR! onEventUpdateVCSTrainer \'chocoState\' is nil!')
        return
    end

    local opCommand = bit.band(option, 0xFF)
    local arg       = bit.rshift(option, 8)

    debug(string.format('ChocoVM: %s (%i), arg %i', commandNames[opCommand] or '?', opCommand, arg))

    local check = allowed[opCommand]
    if check and not check(player, chocoState, arg) then
        print(string.format('WARNING! %s sent chocobo raising option %i, which the menu does not offer', player:getName(), option))
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        return
    end

    local handler = handlers[opCommand]
    if handler then
        handler(player, chocoState, arg)
        return
    end

    print(string.format('ERROR! Unknown chocobo raising option: %i (command %i, arg %i)', option, opCommand, arg))
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end
