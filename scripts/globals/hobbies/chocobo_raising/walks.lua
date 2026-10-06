-----------------------------------
-- Chocobo Raising - Walks, competing and stories
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/care_plan')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/user_data')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.walks = xi.chocoboRaising.walks or {}

-----------------------------------
-- Constants
-----------------------------------
local walks     = xi.chocoboRaising.walks
local cutscenes = xi.chocoboRaising.cutscenes

-- Bits: owner 0-3, clues 4-5, stable 6-7, 2 per trainer's clues from 8, reported result 16-17, solved 18.
walks.lostChickVar = '[ChocoboRaising]LostChick'

local storyMeeting = 2
local maxMeetings  = 3

-- walk_progress packs 2 bits of meeting count per trainer, then 2 bits of compete wins.
local winsShift = 12

local firstStory = 4

-- Guess from guides; no capture shows a story being learned.
walks.learnChance = 25

-----------------------------------
-- Tables
-----------------------------------
-- Values of the walk reply's p5.
---@enum xi.chocoboRaising.walkTrainer
xi.chocoboRaising.walkTrainer =
{
    PULONONO  = 1,
    ZOPAGO    = 2,
    HANTILEON = 3,
    BRUTUS    = 4,
    RIVALS    = 5, -- Bashraf, Foudeel and Wahboud
    DIETMUND  = 6,
}

-- Values of the walk reply's p2.
---@enum xi.chocoboRaising.walks.walkEvent
walks.walkEvent =
{
    LOST_CHICK = 2,
    LETTER     = 3,
    RACE       = 4,
    JOB        = 5,
    ALL_CLUES  = 6,
    ITEM       = 7,
}

local trainer   = xi.chocoboRaising.walkTrainer
local walkEvent = walks.walkEvent

-- Dietmund joins these on a long walk once "Save My Son" is done, once per character.
local trainers =
{
    [1] = -- San d'Oria
    {
        [cutscenes.GO_ON_A_WALK_SHORT  ] = { trainer.HANTILEON },
        [cutscenes.GO_ON_A_WALK_REGULAR] = { trainer.ZOPAGO },
        [cutscenes.GO_ON_A_WALK_LONG   ] = { trainer.PULONONO, trainer.BRUTUS },
    },
    [2] = -- Bastok
    {
        [cutscenes.GO_ON_A_WALK_SHORT  ] = { trainer.ZOPAGO },
        [cutscenes.GO_ON_A_WALK_REGULAR] = { trainer.HANTILEON },
        [cutscenes.GO_ON_A_WALK_LONG   ] = { trainer.PULONONO, trainer.BRUTUS },
    },
    [3] = -- Windurst
    {
        [cutscenes.GO_ON_A_WALK_SHORT  ] = { trainer.PULONONO },
        [cutscenes.GO_ON_A_WALK_REGULAR] = { trainer.HANTILEON },
        [cutscenes.GO_ON_A_WALK_LONG   ] = { trainer.ZOPAGO, trainer.BRUTUS },
    },
}

-- Percent chance of meeting someone, then of finding an item, at or below the captured rates.
walks.eventChance =
{
    [cutscenes.GO_ON_A_WALK_SHORT  ] = { 21, 18 },
    [cutscenes.GO_ON_A_WALK_REGULAR] = { 15, 26 },
    [cutscenes.GO_ON_A_WALK_LONG   ] = { 18, 15 },
}

---@enum xi.chocoboRaising.walks.lostChickResult
walks.lostChickResult =
{
    NONE        = 0,
    RETURNED    = 1,
    WRONG_OWNER = 2,
}

local clueEvents = { walkEvent.LETTER, walkEvent.RACE, walkEvent.JOB }

-- Rivals and Dietmund give no clues.
local clueTrainers =
{
    [trainer.PULONONO ] = true,
    [trainer.ZOPAGO   ] = true,
    [trainer.HANTILEON] = true,
    [trainer.BRUTUS   ] = true,
}

-- In the clerk's order. ask: the option that offers the question inline; guess: the option naming the owner.
---@type table<integer, table<integer, ChocoboChickOwner>>
walks.chickOwners =
{
    [1] =
    {
        [1] = { npc = 'Coderiant',   events = { 583 }, ask = 1, guess = 2 },
        [2] = { npc = 'Cahaurme',    events = { 847 }, guess = 1 },
        [3] = { npc = 'Victoire',    events = { 848 }, guess = 1 },
        [4] = { npc = 'Corua',       events = { 849 }, guess = 1 },
        [5] = { npc = 'Luthiaque',   events = { 658 }, ask = 1, guess = 2 },
        [6] = { npc = 'Lanqueron',   events = { 850 }, guess = 1 },
        [7] = { npc = 'Violitte',    events = { 851 }, guess = 2, mapVendorEvent = 595 },
        [8] = { npc = 'Valderotaux', events = { 58 },  ask = 1, guess = 2 },
    },

    [2] =
    {
        [1] = { npc = 'Drangord',  events = { 21 },     ask = 1, guess = 2 },
        [2] = { npc = 'Deegis',    events = { 537 },    guess = 1 },
        [3] = { npc = 'Gray_Wolf', events = { 19 },     ask = 1, guess = 2 },
        [4] = { npc = 'Gerbaum',   events = { 22, 23 }, ask = 1, guess = 2 },
        [5] = { npc = 'Griselda',  events = { 538 },    guess = 1 },
        [6] = { npc = 'Galdeo',    events = { 539 },    guess = 1 },
        -- TODO: Abd-al-Raziq (7) and Azima (8) ask inside their guild shop events.
    },

    [3] =
    {
        -- TODO: Kyaa Taali (1) asks inside her guild shop event.
        [2] = { npc = 'Kapeh_Myohrye',       events = { 340 },           ask = 1, guess = 2 },
        -- TODO: Kopuro-Popuro (3) asks with option 2 and guesses with option 100; confirm the event.
        [4] = { npc = 'Kororo',              events = { 277 },           ask = 2, guess = 3 },
        [5] = { npc = 'Gioh_Ajihri',         events = { 424 },           ask = 1, guess = 2 },
        [6] = { npc = 'Gottah_Maporushanoh', events = { 420, 483, 486 }, ask = 1, guess = 2 },
        -- TODO: Peshi Yohnts (7) and Ponono (8) ask inside their guild shop events.
    },
}

-- The third meeting teaches the trainer's story.
local stories =
{
    [trainer.HANTILEON] = xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO,
    [trainer.BRUTUS   ] = xi.keyItem.STORY_OF_A_CURIOUS_CHOCOBO,
    [trainer.ZOPAGO   ] = xi.keyItem.STORY_OF_A_WORRISOME_CHOCOBO,
    [trainer.PULONONO ] = xi.keyItem.STORY_OF_A_YOUTHFUL_CHOCOBO,
}

-- Indexed by the character's chocobo number, repeating from the sixth.
local friendNames =
{
    [trainer.HANTILEON] = { 'Air', 'Ice', 'Sea', 'Sky', 'Sun' },
    [trainer.ZOPAGO   ] = { 'Blood', 'Chaos', 'Devil', 'Ghost', 'Night' },
    [trainer.PULONONO ] = { 'Spring', 'Melody', 'Poetic', 'Pretty' },
    [trainer.BRUTUS   ] = { 'Brilliant', 'Fantastic', 'Lightning', 'Sparkling', 'Wonderful' },
    [trainer.RIVALS   ] = { 'Best', 'Fast', 'Hero', 'King' },
}

-- The follow-up option (command 217) numbers trainers in its own order.
walks.followUpTrainer =
{
    [1] = trainer.HANTILEON,
    [2] = trainer.ZOPAGO,
    [3] = trainer.PULONONO,
    [4] = trainer.RIVALS,
    [5] = trainer.BRUTUS,
}

-- Stories 4 to 9 teach abilities 1 to 6 in order.
walks.storyKeyItems =
{
    [4] = xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO,
    [5] = xi.keyItem.STORY_OF_A_CURIOUS_CHOCOBO,
    [6] = xi.keyItem.STORY_OF_A_WORRISOME_CHOCOBO,
    [7] = xi.keyItem.STORY_OF_A_YOUTHFUL_CHOCOBO,
    [8] = xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO,
    [9] = xi.keyItem.STORY_OF_A_DILIGENT_CHOCOBO,
}

-- Guess: the discernment each ability needs.
local storyDiscernment =
{
    [xi.chocoboRaising.ability.GALLOP         ] = 64,
    [xi.chocoboRaising.ability.CANTER         ] = 96,
    [xi.chocoboRaising.ability.BURROW         ] = 64,
    [xi.chocoboRaising.ability.BORE           ] = 160,
    [xi.chocoboRaising.ability.AUTO_REGEN     ] = 64,
    [xi.chocoboRaising.ability.TREASURE_FINDER] = 64,
}

-- Guess: telling a story for a known ability raises this stat instead.
local inspiredStat =
{
    [xi.chocoboRaising.ability.GALLOP         ] = 'strength',
    [xi.chocoboRaising.ability.CANTER         ] = 'endurance',
    [xi.chocoboRaising.ability.BURROW         ] = 'discernment',
    [xi.chocoboRaising.ability.BORE           ] = 'receptivity',
    [xi.chocoboRaising.ability.AUTO_REGEN     ] = 'affection',
    [xi.chocoboRaising.ability.TREASURE_FINDER] = 'discernment',
}

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboLostChick
---@field owner        integer
---@field clues        integer
---@field location     integer
---@field trainerClues table<xi.chocoboRaising.walkTrainer, integer>
---@field result       xi.chocoboRaising.walks.lostChickResult
---@field solved       boolean

---@class ChocoboChickOwner
---@field npc            string
---@field events         integer[]
---@field ask            integer?
---@field guess          integer
---@field mapVendorEvent integer?

---@class ChocoboWalkContext
---@field location        integer
---@field walkZone        xi.zone
---@field lostChick       integer?
---@field canMeetDietmund boolean?

---@class ChocoboWalkResult
---@field event   integer
---@field data    integer
---@field trainer integer
---@field meeting integer

-----------------------------------
-- Helpers
-----------------------------------
local function setMeetings(state, trainerId, count)
    local shift = (trainerId - 1) * 2
    local mask  = bit.bnot(bit.lshift(3, shift))

    state.walk_progress = bit.bor(bit.band(state.walk_progress or 0, mask), bit.lshift(count, shift))
end

local function setWins(state, count)
    local mask = bit.bnot(bit.lshift(3, winsShift))

    state.walk_progress = bit.bor(bit.band(state.walk_progress or 0, mask), bit.lshift(count, winsShift))
end

-----------------------------------
-- Private Functions
-----------------------------------
-- Only owners with a question event can be picked.
local function pickOwner(location)
    local ownerIds = {}
    for ownerId = 1, 8 do
        if walks.chickOwners[location][ownerId] then
            table.insert(ownerIds, ownerId)
        end
    end

    return ownerIds[math.randomInt(1, #ownerIds)]
end

-- p3 carries the owner in bits 8-15 and the clues this trainer gave before in 0-7.
local function giveClue(chick, met, location, result, effects)
    if
        chick.owner == 0 or
        chick.location ~= location or
        not clueTrainers[met]
    then
        return
    end

    local given = chick.trainerClues[met]
    result.data = bit.bor(bit.lshift(chick.owner, 8), given)

    if chick.clues >= #clueEvents then
        result.event = walkEvent.ALL_CLUES
        return
    end

    chick.clues             = chick.clues + 1
    chick.trainerClues[met] = given + 1
    result.event            = clueEvents[chick.clues]

    table.insert(effects, { xi.chocoboRaising.effect.SET_CHAR_VAR, walks.lostChickVar, walks.packLostChick(chick) })
end

-----------------------------------
-- Global Functions
-----------------------------------
-- Guess: receptivity above 63 adds 1% per 16 points.
---@param state table
---@param careAction xi.chocoboRaising.cutscenes
---@return integer
walks.meetingChance = function(state, careAction)
    local bonus = math.floor(math.max((state.receptivity or 0) - 63, 0) / 16)

    return walks.eventChance[careAction][1] + bonus
end

---@param location integer
---@param careAction xi.chocoboRaising.cutscenes
---@param canMeetDietmund boolean?
---@return xi.chocoboRaising.walkTrainer[]
walks.candidates = function(location, careAction, canMeetDietmund)
    local candidates = {}
    for _, trainerId in ipairs(trainers[location][careAction]) do
        table.insert(candidates, trainerId)
    end

    if careAction == cutscenes.GO_ON_A_WALK_LONG and canMeetDietmund then
        table.insert(candidates, trainer.DIETMUND)
    end

    return candidates
end

---@param value integer
---@return ChocoboLostChick
walks.lostChick = function(value)
    local chick =
    {
        owner        = bit.band(value, 0xF),
        clues        = bit.band(bit.rshift(value, 4), 3),
        location     = bit.band(bit.rshift(value, 6), 3),
        trainerClues = {},
        result       = bit.band(bit.rshift(value, 16), 3),
        solved       = bit.band(bit.rshift(value, 18), 1) == 1,
    }

    for trainerId in pairs(clueTrainers) do
        chick.trainerClues[trainerId] = bit.band(bit.rshift(value, 8 + (trainerId - 1) * 2), 3)
    end

    return chick
end

---@param chick ChocoboLostChick
---@return integer
walks.packLostChick = function(chick)
    local value = bit.bor(chick.owner, bit.lshift(chick.clues, 4), bit.lshift(chick.location, 6), bit.lshift(chick.result, 16))
    for trainerId, count in pairs(chick.trainerClues) do
        value = bit.bor(value, bit.lshift(count, 8 + (trainerId - 1) * 2))
    end

    if chick.solved then
        value = bit.bor(value, bit.lshift(1, 18))
    end

    return value
end

-- Returns whether the guess was right, and the effects. Either way the search ends and the trainer
-- reports the result; a wrong guess lets a later short walk find a chick again.
---@param value integer
---@param location integer
---@param ownerId integer
---@return boolean
---@return ChocoboEffect[]
walks.askOwner = function(value, location, ownerId)
    local chick   = walks.lostChick(value)
    local right   = chick.owner ~= 0 and chick.location == location and chick.owner == ownerId
    local effects = {}
    local after   =
    {
        owner        = 0,
        clues        = 0,
        location     = 0,
        trainerClues = {},
        result       = walks.lostChickResult.WRONG_OWNER,
        solved       = chick.solved,
    }

    if right then
        after.result = walks.lostChickResult.RETURNED
        after.solved = true
        table.insert(effects, { xi.chocoboRaising.effect.ADD_KEY_ITEM, xi.keyItem.STORY_OF_A_DILIGENT_CHOCOBO })
    end

    table.insert(effects, { xi.chocoboRaising.effect.SET_CHAR_VAR, walks.lostChickVar, walks.packLostChick(after) })

    return right, effects
end

---@param value integer
---@return ChocoboEffect[]
walks.clearLostChickResult = function(value)
    local chick  = walks.lostChick(value)
    chick.result = walks.lostChickResult.NONE

    return { { xi.chocoboRaising.effect.SET_CHAR_VAR, walks.lostChickVar, walks.packLostChick(chick) } }
end

-- The clerk's event start: p0 offers the review once a clue is known, p3-p5 the clues, p6 the owner.
---@param value integer
---@param location integer
---@return table<integer, integer>
walks.clerkReview = function(value, location)
    local chick  = walks.lostChick(value)
    local params =
    {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0,
        [7] = 0,
    }

    if
        chick.owner == 0 or
        chick.location ~= location or
        chick.clues == 0
    then
        return params
    end

    params[0] = 1
    params[6] = chick.owner

    for clue = 1, chick.clues do
        params[2 + clue] = 1
    end

    return params
end

---@param trainerId xi.chocoboRaising.walkTrainer
---@param chocoboNumber integer
---@return string
walks.friendName = function(trainerId, chocoboNumber)
    local names = friendNames[trainerId]
    if not names then
        return ''
    end

    return names[((math.max(chocoboNumber, 1) - 1) % #names) + 1]
end

---@param state table
---@param trainerId xi.chocoboRaising.walkTrainer
---@return integer
walks.meetings = function(state, trainerId)
    return bit.band(bit.rshift(state.walk_progress or 0, (trainerId - 1) * 2), 3)
end

---@param state table
---@return integer
walks.wins = function(state)
    return bit.band(bit.rshift(state.walk_progress or 0, winsShift), 3)
end

---@param state table
---@return boolean
walks.canCompete = function(state)
    return walks.meetings(state, trainer.RIVALS) > 0
end

-- Returns reply p2, p3, p5 and p6; an empty chick's short walk finds the lost chick until it is solved.
---@param state table
---@param careAction xi.chocoboRaising.cutscenes
---@param ctx ChocoboWalkContext
---@return ChocoboWalkResult
---@return ChocoboEffect[]
walks.walk = function(state, careAction, ctx)
    local result =
    {
        event   = 0,
        data    = 0,
        trainer = 0,
        meeting = 0,
    }

    local effects = {}
    local chick   = walks.lostChick(ctx.lostChick or 0)
    local met

    if
        careAction == cutscenes.GO_ON_A_WALK_REGULAR and
        walks.meetings(state, trainer.RIVALS) == 0
    then
        met = trainer.RIVALS
    else
        local meetingChance = walks.meetingChance(state, careAction)
        local roll          = math.randomInt(1, 100)

        if roll <= meetingChance then
            local candidates = walks.candidates(ctx.location, careAction, ctx.canMeetDietmund)
            met = candidates[math.randomInt(1, #candidates)]
        elseif
            roll <= meetingChance + walks.eventChance[careAction][2] and
            state.held_item == 0
        then
            local items = xi.chocoboRaising.walkItems[ctx.walkZone]
            if items and #items > 0 then
                state.held_item = items[math.randomInt(1, #items)]
                result.event    = walkEvent.ITEM
            end
        end
    end

    if met == trainer.DIETMUND then
        result.trainer = met
        table.insert(effects, { xi.chocoboRaising.effect.SET_USER_FLAG, xi.chocoboRaising.userFlag.MET_DIETMUND })

        return result, effects
    end

    if
        not met and
        result.event == 0 and
        careAction == cutscenes.GO_ON_A_WALK_SHORT and
        chick.owner == 0 and
        not chick.solved
    then
        chick.owner    = pickOwner(ctx.location)
        chick.location = ctx.location
        result.event   = walkEvent.LOST_CHICK
        table.insert(effects, { xi.chocoboRaising.effect.SET_CHAR_VAR, walks.lostChickVar, walks.packLostChick(chick) })
    end

    if met then
        giveClue(chick, met, ctx.location, result, effects)

        local meetings = walks.meetings(state, met)

        result.trainer = met
        result.meeting = meetings

        setMeetings(state, met, math.min(meetings + 1, maxMeetings))

        if meetings == storyMeeting and stories[met] then
            table.insert(effects, { xi.chocoboRaising.effect.ADD_KEY_ITEM, stories[met] })
        end
    end

    return result, effects
end

-- Result 0 win, 2 loss, 3 third win (teaches the happy story). Wins need not be in a row.
---@param state table
---@return integer
---@return ChocoboEffect[]
walks.compete = function(state)
    -- Guess: an even chance.
    if math.randomInt(1, 2) == 2 then
        return 2, {}
    end

    local wins = walks.wins(state)
    if wins >= 3 then
        return 0, {}
    end

    setWins(state, wins + 1)
    if wins + 1 == 3 then
        return 3, { { xi.chocoboRaising.effect.ADD_KEY_ITEM, xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO } }
    end

    return 0, {}
end

-- Returns the reply's p0 (0 interested, 1 learned, 2 inspired) and the effects.
-- Learning or inspiration uses up the story and restores 10 to 100 energy.
---@param state table
---@param story integer
---@return integer
---@return ChocoboEffect[]
walks.tellStory = function(state, story)
    local keyItem = walks.storyKeyItems[story]
    if not keyItem then
        return 0, {}
    end

    xi.chocoboRaising.addToStat(state, 'discernment', 1)

    local ability = story - firstStory + 1
    if
        state.discernment < storyDiscernment[ability] or
        math.randomInt(1, 100) > walks.learnChance
    then
        return 0, {}
    end

    local effects = { { xi.chocoboRaising.effect.DEL_KEY_ITEM, keyItem } }

    state.energy = utils.clamp(state.energy + math.randomInt(10, 100), 0, 100)

    if state.ability1 == 0 and state.ability2 ~= ability then
        state.ability1 = ability
        return 1, effects
    end

    if state.ability2 == 0 and state.ability1 ~= ability then
        state.ability2 = ability
        return 1, effects
    end

    -- A known ability, or both slots full.
    local field = inspiredStat[ability]
    if field == 'affection' then
        state.affection = utils.clamp(state.affection + xi.chocoboRaising.statPerPlanArrow[1], 0, 255)
    else
        xi.chocoboRaising.addToStat(state, field, xi.chocoboRaising.statPerPlanArrow[1])
    end

    return 2, effects
end
