-----------------------------------
-- Chocobo Raising - Debug Event VM
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/breeding')
require('scripts/globals/hobbies/chocobo_raising/choco_data')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/event_vm')
require('scripts/globals/hobbies/chocobo_raising/model')
require('scripts/globals/hobbies/chocobo_raising/user_data')
require('scripts/globals/hobbies/chocobo_raising/walks')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

local alterStable = 7

-- Genes picked in the DNA menu wait here for its confirmation; bit 9 marks a pick.
local pendingDNAVar  = '[ChocoboRaising]DebugDNA'
local pendingDNAFlag = 0x200

-----------------------------------
-- Tables
-----------------------------------
---@enum chocoboRaisingDebugCommand
local command =
{
    ABILITIES          = 206,
    LOST_CHICK         = 207,
    INFLICT_NEXT_DAY   = 209,
    COLOR              = 210,
    TEMPERAMENT        = 211,
    WEATHER_PREFERENCE = 212,
    FLAGS              = 213,
    MOVE_TIME_FORWARD  = 226,
    RESET_DEFAULTS     = 227,
    WEATHER_CHECK      = 228,
    STATUS             = 229,
    ALTER_STAT         = 230,
    SKIP_EVENTS        = 231,
    USER_WORK          = 232,
    CHECK_CONDITION    = 233,
    HEAL_CONDITION     = 234,
    INFLICT_CONDITION  = 235,
    GROWTH_STAGE       = 236,
    DNA                = 237,
    RECEIVE_ITEM       = 238,
}

-- Commands that work without a raised chocobo.
local noChocoboNeeded = set
{
    command.LOST_CHICK,
    command.FLAGS,
    command.RESET_DEFAULTS,
    command.WEATHER_CHECK,
    command.USER_WORK,
    command.RECEIVE_ITEM,
}

-- ALTER_STAT's stat index, in menu order.
local alterableStats =
{
    [0] = 'strength',
    [1] = 'endurance',
    [2] = 'discernment',
    [3] = 'receptivity',
    [4] = 'affection',
    [5] = 'energy',
    [6] = 'satisfaction',
}

-- FLAGS' flag number, in menu order.
---@enum chocoboRaisingDebugFlag
local flag =
{
    ZONE              = 1,
    ONE_DAY           = 2,
    CRYING_KEY_ITEM   = 3,
    TREASURE_KEY_ITEM = 4,
    WHISTLE_PROGRESS  = 10,
}

local storyFlags =
{
    [5]  = xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO,
    [6]  = xi.keyItem.STORY_OF_A_CURIOUS_CHOCOBO,
    [7]  = xi.keyItem.STORY_OF_A_WORRISOME_CHOCOBO,
    [8]  = xi.keyItem.STORY_OF_A_YOUTHFUL_CHOCOBO,
    [9]  = xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO,
    [11] = xi.keyItem.STORY_OF_A_DILIGENT_CHOCOBO,
}

-- RECEIVE_ITEM's item number, in menu order.
local debugItems =
{
    [1] = xi.item.CHOCOBO_EGG_FAINTLY_WARM,
    [2] = xi.item.CHOCOBO_EGG_SLIGHTLY_WARM,
    [3] = xi.item.CHOCOBO_EGG_A_BIT_WARM,
    [4] = xi.item.CHOCOBO_EGG_A_LITTLE_WARM,
    [5] = xi.item.CHOCOBO_EGG_SOMEWHAT_WARM,
    [6] = xi.item.CHOCOCARD_M,
    [7] = xi.item.CHOCOCARD_F,
}

-- Menu order, 1 to 10. The read reply uses the enum's element order instead.
local weatherMenu =
{
    xi.chocoboRaising.weather.CLEAR,
    xi.chocoboRaising.weather.CLOUDY,
    xi.chocoboRaising.weather.HOT_SUNNY,
    xi.chocoboRaising.weather.SNOWY,
    xi.chocoboRaising.weather.WINDY,
    xi.chocoboRaising.weather.SANDSTORMS,
    xi.chocoboRaising.weather.THUNDERSTORM,
    xi.chocoboRaising.weather.RAINY,
    xi.chocoboRaising.weather.AURORAS,
    xi.chocoboRaising.weather.DARK,
}

-----------------------------------
-- Helpers
-----------------------------------
local function enumName(enum, value)
    for name, entry in pairs(enum) do
        if entry == value then
            return name
        end
    end

    return tostring(value)
end

local function packDNA(chocoState)
    return chocoState.allele1 + bit.lshift(chocoState.allele2, 3) + bit.lshift(chocoState.allele3, 6)
end

local function unpackDNA(packed)
    return
    {
        bit.band(packed, 7),
        bit.band(bit.rshift(packed, 3), 7),
        bit.band(bit.rshift(packed, 6), 7),
    }
end

local function toggleKeyItem(player, keyItem)
    if player:hasKeyItem(keyItem) then
        player:delKeyItem(keyItem)
    else
        player:addKeyItem(keyItem)
    end
end

local function conditionNames(conditions)
    local names = {}
    for condition = 0, xi.chocoboRaising.conditions.BRIGHT_AND_FOCUSED do
        if utils.mask.getBit(conditions, condition) then
            table.insert(names, enumName(xi.chocoboRaising.conditions, condition))
        end
    end

    if #names == 0 then
        return 'none'
    end

    return table.concat(names, ', ')
end

-----------------------------------
-- Private Functions
-----------------------------------
-- The menu reads p1 to p4 as on/off and prints p5; the story submenu reads p6.
local function replyWithFlags(player, action)
    local character = xi.chocoboRaising.characterView(player)
    local stories   = 0
    local bitIndex  = 0

    for flagId = 5, 11 do
        if storyFlags[flagId] then
            stories  = stories + bit.lshift(player:hasKeyItem(storyFlags[flagId]) and 1 or 0, bitIndex)
            bitIndex = bitIndex + 1
        end
    end

    local oneDay      = character.handkerchief == xi.chocoboRaising.handkerchief.DAY_PASSED and 1 or 0
    local zone        = not character.handkerchiefSameZone and 1 or 0
    local crying      = character.hasWhiteHandkerchief and 1 or 0
    local treasure    = player:hasKeyItem(xi.keyItem.DIRTY_HANDKERCHIEF) and 1 or 0
    local whistleProg = xi.chocoboRaising.whistleProgress(player)

    debug(string.format('Debug: %s; one day %d, zone %d, crying key item %d, treasure key item %d, whistle %d, stories 0x%02X',
        action, oneDay, zone, crying, treasure, whistleProg, stories))

    player:updateEvent(0, oneDay, zone, crying, treasure, whistleProg, stories, 0)
end

-- FLAGS' toggle for each flag number except the stories.
local flagToggles =
{
    [flag.ONE_DAY] = function(player, character)
        local nextState = xi.chocoboRaising.handkerchief.DAY_PASSED
        if character.handkerchief == xi.chocoboRaising.handkerchief.DAY_PASSED then
            nextState = xi.chocoboRaising.handkerchief.GIVEN
        end

        xi.chocoboRaising.setHandkerchiefState(player, nextState)
    end,

    [flag.ZONE] = function(player, character)
        local sameZone = 1
        if character.handkerchiefSameZone then
            sameZone = 0
        end

        player:setLocalVar(xi.chocoboRaising.handkerchiefZoneVar, sameZone)
    end,

    [flag.CRYING_KEY_ITEM] = function(player, character)
        toggleKeyItem(player, xi.keyItem.WHITE_HANDKERCHIEF)

        local state = xi.chocoboRaising.handkerchief.NONE
        if player:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF) then
            state = xi.chocoboRaising.handkerchief.GIVEN
        end

        xi.chocoboRaising.setHandkerchiefState(player, state)
    end,

    [flag.TREASURE_KEY_ITEM] = function(player, character)
        toggleKeyItem(player, xi.keyItem.DIRTY_HANDKERCHIEF)
    end,

    [flag.WHISTLE_PROGRESS] = function(player, character)
        xi.chocoboRaising.setWhistleProgress(player, (xi.chocoboRaising.whistleProgress(player) + 1) % (xi.chocoboRaising.whistleProg.DONE + 1))
    end,
}

-- A toggle shows the menu again without asking, so its reply carries the new flags.
local function handleFlags(player, chocoState, arg)
    if arg == 0 then
        replyWithFlags(player, 'read flags')
        return
    end

    local toggle = flagToggles[arg]
    if toggle then
        toggle(player, xi.chocoboRaising.characterView(player))
    elseif storyFlags[arg] then
        toggleKeyItem(player, storyFlags[arg])
    end

    replyWithFlags(player, string.format('toggled flag %d', arg))
end

-- Argument: 0 shows, 1 with the owner index in bits 8-15 sets the owner, 2 resets.
-- Reply: p0 the owner, p1 1 once the chick went home.
local function handleLostChick(player, chocoState, arg)
    local setOwner = 1
    local reset    = 2
    local action   = bit.band(arg, 0xFF)

    if action == setOwner then
        local chick    = xi.chocoboRaising.walks.lostChick(0)
        chick.owner    = math.min(bit.band(bit.rshift(arg, 8), 0xFF), 7) + 1
        chick.location = xi.chocoboRaising.raisingLocation[player:getZoneID()]
        player:setCharVar(xi.chocoboRaising.walks.lostChickVar, xi.chocoboRaising.walks.packLostChick(chick))
    elseif action == reset then
        player:setCharVar(xi.chocoboRaising.walks.lostChickVar, 0)
    end

    local chick = xi.chocoboRaising.walks.lostChick(player:getCharVar(xi.chocoboRaising.walks.lostChickVar))
    debug(string.format('Debug: lost chick action %d; owner %d, stable %d, clues %d, solved %d',
        action, chick.owner, chick.location, chick.clues, chick.solved and 1 or 0))

    player:updateEvent(chick.owner, chick.solved and 1 or 0, 0, 0, 0, 0, 0, 0)
end

local function handleAlterStat(player, chocoState, arg)
    local value = bit.band(arg, 0xFF)
    local stat  = bit.band(bit.rshift(arg, 8), 0xFF)
    local field = alterableStats[stat]

    if stat == alterStable then
        -- The area menu sends San d'Oria 1, Bastok 2, Windurst 3.
        chocoState.location = utils.clamp(value, 1, 3)
    elseif field then
        local max = 255

        if field == 'energy' then
            max = 100
        end

        chocoState[field] = utils.clamp(value, 0, max)
    end

    debug(string.format('Debug: altered stat %d to %d', stat, value))
    xi.chocoboRaising.updateChocoState(player, chocoState)
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- The menu shows again after a change without asking, so every reply carries the value in p0.
local function handleReadOrSet(field, offset, max)
    return function(player, chocoState, arg)
        if arg ~= 0 then
            chocoState[field] = utils.clamp(arg - offset, 0, max)
            xi.chocoboRaising.updateChocoState(player, chocoState)
        end

        debug(string.format('Debug: %s choice %d; now %d', field, arg, chocoState[field]))
        player:updateEvent(chocoState[field], 0, 0, 0, 0, 0, 0, 0)
    end
end

local function handleWeatherPreference(player, chocoState, arg)
    if weatherMenu[arg] then
        chocoState.weather_preference = weatherMenu[arg]
        xi.chocoboRaising.updateChocoState(player, chocoState)
    end

    debug(string.format('Debug: weather preference choice %d; now %d', arg, chocoState.weather_preference))
    player:updateEvent(chocoState.weather_preference, 0, 0, 0, 0, 0, 0, 0)
end

-- The client sets only bits 0-15; the bits above keep whatever the last option left there.
local function conditionSetter(value)
    return function(player, chocoState, arg)
        local condition = bit.band(arg, 0xFF)

        xi.chocoboRaising.setCondition(chocoState, condition, value)
        debug(string.format('Debug: set condition %d to %s; conditions 0x%04X', condition, tostring(value), bit.band(chocoState.conditions, 0xFFFF)))
        xi.chocoboRaising.updateChocoState(player, chocoState)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end
end

local function handleInflictNextDay(player, chocoState, arg)
    local condition = bit.band(arg, 0xFF)
    local onset     = bit.bor(player:getCharVar(xi.chocoboRaising.debugOnsetVar), bit.lshift(1, condition))

    debug(string.format('Debug: condition %d starts next day; next day 0x%04X', condition, onset))
    player:setCharVar(xi.chocoboRaising.debugOnsetVar, onset)
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- The client prints a banner and reads nothing back, so the conditions go to chat.
local function handleCheckCondition(player, chocoState, arg)
    player:printToPlayer(string.format('Conditions: %s', conditionNames(chocoState.conditions)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Next day: %s', conditionNames(player:getCharVar(xi.chocoboRaising.debugOnsetVar))), xi.msg.channel.SYSTEM_3)
    debug(string.format('Debug: checked conditions 0x%04X', bit.band(chocoState.conditions, 0xFFFF)))
    player:updateEvent(bit.band(chocoState.conditions, 0xFFFF), 0, 0, 0, 0, 0, 0, 0)
end

local function applyGrowthStage(player, chocoState, stage)
    debug(string.format('Debug: growth stage %d', stage))

    if stage == 0 then
        player:deleteRaisedChocobo()
        xi.chocoboRaising.chocoState[player:getID()] = nil

        return
    end

    xi.chocoboRaising.model.setStage(chocoState, stage, GetSystemTime(), xi.chocoboRaising.dayLength)
    xi.chocoboRaising.updateChocoState(player, chocoState)
end

local function handleGrowthStage(player, chocoState, arg)
    applyGrowthStage(player, chocoState, bit.band(arg, 0xFF))
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- Argument: 1 reads the genes, 0 with the genes in bits 8-16 picks them, 2 confirms the pick.
local function handleDNA(player, chocoState, arg)
    local pickDNA    = 0
    local readDNA    = 1
    local confirmDNA = 2
    local action     = bit.band(arg, 0xFF)

    if action == readDNA then
        debug(string.format('Debug: read genes %d %d %d', chocoState.allele1, chocoState.allele2, chocoState.allele3))
        player:setLocalVar(pendingDNAVar, 0)
        player:updateEvent(packDNA(chocoState), 0, 0, 0, 0, 0, 0, 0)

        return
    end

    if action == pickDNA then
        local picked = unpackDNA(bit.rshift(arg, 8))
        debug(string.format('Debug: picked genes %d %d %d', picked[1], picked[2], picked[3]))
        player:setLocalVar(pendingDNAVar, bit.bor(bit.band(bit.rshift(arg, 8), 0x1FF), pendingDNAFlag))
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)

        return
    end

    local pending = player:getLocalVar(pendingDNAVar)
    player:setLocalVar(pendingDNAVar, 0)

    if
        action == confirmDNA and
        bit.band(pending, pendingDNAFlag) ~= 0
    then
        local dna = unpackDNA(pending)

        chocoState.allele1 = dna[1]
        chocoState.allele2 = dna[2]
        chocoState.allele3 = dna[3]
        chocoState.color   = xi.chocoboRaising.allelesToColor(dna)

        xi.chocoboRaising.updateChocoState(player, chocoState)
    end

    debug(string.format('Debug: DNA action %d; genes %d %d %d', action, chocoState.allele1, chocoState.allele2, chocoState.allele3))
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- The raised chocobo's card, or a blank one without a chocobo, with the picked genes and the card's gender.
local function debugCard(player, chocoState, dna, gender)
    local source = chocoState or
    {
        first_name         = 'Debug',
        last_name          = 'Chocobo',
        strength           = 0,
        endurance          = 0,
        discernment        = 0,
        receptivity        = 0,
        allele1            = 0,
        allele2            = 0,
        allele3            = 0,
        ability1           = xi.chocoboRaising.ability.NONE,
        ability2           = xi.chocoboRaising.ability.NONE,
        personality        = 0,
        weather_preference = 0,
        appearance         = 0,
    }

    local card = xi.chocoboRaising.chocoStateToCard(player, source)

    card.dna    = dna
    card.color  = xi.chocoboRaising.allelesToColor(dna)
    card.gender = gender

    return card
end

-- Argument: item number in bits 0-7, genes in bits 8-16.
local function handleReceiveItem(player, chocoState, arg)
    local itemIndex = bit.band(arg, 0xFF)
    local itemId    = debugItems[itemIndex]
    local dna       = unpackDNA(bit.rshift(arg, 8))

    debug(string.format('Debug: receive item %d (%s) with genes %d %d %d', itemIndex, tostring(itemId), dna[1], dna[2], dna[3]))

    if itemId == xi.item.CHOCOCARD_M then
        player:addItem({ id = itemId, exdata = debugCard(player, chocoState, dna, xi.chocoboRaising.gender.MALE) })
    elseif itemId == xi.item.CHOCOCARD_F then
        player:addItem({ id = itemId, exdata = debugCard(player, chocoState, dna, xi.chocoboRaising.gender.FEMALE) })
    elseif itemId then
        -- Hatching only reads genes from bred eggs; plan 0 makes it read as a Gourmet egg.
        player:addItem({ id = itemId, exdata = { dna = dna, isBred = true, plan = 0 } })
    end

    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- Argument: 1 reads both slots; 2 sets slot 1 from bits 8-15 and slot 2 from bits 16-23.
-- The client shows the slots again from the reply to either.
local function handleAbilities(player, chocoState, arg)
    local setAbilities = 2
    local action       = bit.band(arg, 0xFF)

    if action == setAbilities then
        chocoState.ability1 = bit.band(bit.rshift(arg, 8), 0xFF)
        chocoState.ability2 = bit.band(bit.rshift(arg, 16), 0xFF)
        xi.chocoboRaising.updateChocoState(player, chocoState)
    end

    debug(string.format('Debug: abilities action %d; slots %d and %d', action, chocoState.ability1, chocoState.ability2))
    player:updateEvent(chocoState.ability1, chocoState.ability2, 0, 0, 0, 0, 0, 0)
end

local function handleMoveTime(player, chocoState, arg)
    debug(string.format('Debug: moved time forward %d days', arg))
    xi.chocoboRaising.model.moveTime(chocoState, arg, xi.chocoboRaising.dayLength)
    xi.chocoboRaising.updateChocoState(player, chocoState)
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- Applies the moved days now, so the next report starts after them.
local function handleSkipEvents(player, chocoState, arg)
    local refreshed = xi.chocoboRaising.initChocoState(player)
    if refreshed then
        refreshed.report.events = {}
        debug(string.format('Debug: skipped events; now day %d', refreshed.last_update_age))
    end

    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

-- Clears what only this menu sets: next-day conditions and a picked but unconfirmed DNA.
local function handleResetDefaults(player, chocoState, arg)
    debug('Debug: returned to default; next-day conditions and picked genes cleared')
    player:setCharVar(xi.chocoboRaising.debugOnsetVar, 0)
    player:setLocalVar(pendingDNAVar, 0)
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

local function handleWeatherCheck(player, chocoState, arg)
    local weather    = xi.chocoboRaising.getWeatherInZone(xi.zone.WEST_RONFAURE)
    local preference = 'no chocobo'
    if chocoState then
        preference = enumName(xi.chocoboRaising.weather, chocoState.weather_preference)
    end

    player:printToPlayer(string.format('West Ronfaure weather: %s, preference: %s', enumName(xi.weather, weather), preference), xi.msg.channel.SYSTEM_3)
    debug(string.format('Debug: weather check %d', weather))
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

local function handleUserWork(player, chocoState, arg)
    xi.chocoboRaising.printUserWork(player)
    debug('Debug: user work shown')

    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

local function handleStatus(player, chocoState, arg)
    local rawStats =
        chocoState.strength +
        bit.lshift(chocoState.endurance, 8) +
        bit.lshift(chocoState.discernment, 16) +
        bit.lshift(chocoState.receptivity, 24)

    local rawCare =
        chocoState.affection +
        bit.lshift(chocoState.energy, 8) +
        bit.lshift(chocoState.satisfaction, 16)

    debug(string.format('Debug: status STR %d END %d DSC %d RCP %d, affection %d energy %d satisfaction %d',
        chocoState.strength, chocoState.endurance, chocoState.discernment, chocoState.receptivity,
        chocoState.affection, chocoState.energy, chocoState.satisfaction))

    player:updateEvent(0, rawStats, rawCare, 0, 0, 0, 0, 0)
end

local handlers =
{
    [command.ABILITIES]          = handleAbilities,
    [command.LOST_CHICK]         = handleLostChick,
    [command.INFLICT_NEXT_DAY]   = handleInflictNextDay,
    [command.COLOR]              = handleReadOrSet('color', 1, xi.chocoboRaising.color.GREEN),
    [command.TEMPERAMENT]        = handleReadOrSet('personality', 1, 4),
    [command.WEATHER_PREFERENCE] = handleWeatherPreference,
    [command.FLAGS]              = handleFlags,
    [command.MOVE_TIME_FORWARD]  = handleMoveTime,
    [command.RESET_DEFAULTS]     = handleResetDefaults,
    [command.WEATHER_CHECK]      = handleWeatherCheck,
    [command.STATUS]             = handleStatus,
    [command.ALTER_STAT]         = handleAlterStat,
    [command.SKIP_EVENTS]        = handleSkipEvents,
    [command.USER_WORK]          = handleUserWork,
    [command.CHECK_CONDITION]    = handleCheckCondition,
    [command.HEAL_CONDITION]     = conditionSetter(false),
    [command.INFLICT_CONDITION]  = conditionSetter(true),
    [command.GROWTH_STAGE]       = handleGrowthStage,
    [command.DNA]                = handleDNA,
    [command.RECEIVE_ITEM]       = handleReceiveItem,
}

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@return integer
xi.chocoboRaising.debugCSID = function(player)
    return xi.chocoboRaising.csidTable[player:getZoneID()][10]
end

-- GM only. Most commands need a raised chocobo.
---@param player CBaseEntity
---@param npc CBaseEntity
xi.chocoboRaising.onTriggerDebug = function(player, npc)
    if
        not xi.settings.main.ENABLE_CHOCOBO_RAISING or
        player:getGMLevel() < 1
    then
        return
    end

    -- Loaded as saved: passed days wait for the trainer's report, or for "Skip events".
    local chocoState = player:getChocoboRaisingInfo()

    -- The menu title joins strings 0 and 1. The client keeps the last event's strings, so both are always sent.
    local firstName = ''
    local lastName  = ''

    -- A chocobo that left must not linger in the cache for the menu.
    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    if chocoState then
        local _
        _, firstName, lastName = xi.chocoboRaising.nameStrings(chocoState)
    end

    player:startEventString(xi.chocoboRaising.debugCSID(player), firstName, lastName, '', '')
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
xi.chocoboRaising.onEventUpdateDebug = function(player, csid, option, npc)
    if csid ~= xi.chocoboRaising.debugCSID(player) then
        return
    end

    local opCommand  = bit.band(option, 0xFF)
    local arg        = bit.rshift(option, 8)
    local chocoState = xi.chocoboRaising.chocoState[player:getID()]
    local handler    = handlers[opCommand]

    if not handler then
        print(string.format('ERROR! Unknown chocobo raising debug option: %i (command %i, arg %i)', option, opCommand, arg))
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)

        return
    end

    if not chocoState and not noChocoboNeeded[opCommand] then
        debug(string.format('Debug: option %d needs a raised chocobo', option))
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
        return
    end

    handler(player, chocoState, arg)
end

-- The growth stage menu sends no update; its option is still set when the event ends.
---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
xi.chocoboRaising.onEventFinishDebug = function(player, csid, option, npc)
    if
        csid ~= xi.chocoboRaising.debugCSID(player) or
        bit.band(option, 0xFF) ~= command.GROWTH_STAGE
    then
        return
    end

    local chocoState = xi.chocoboRaising.chocoState[player:getID()]
    if chocoState then
        applyGrowthStage(player, chocoState, bit.band(bit.rshift(option, 8), 0xFF))
    end
end
