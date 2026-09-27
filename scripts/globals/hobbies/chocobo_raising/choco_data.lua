-----------------------------------
-- Chocobo Raising - Chocobo State
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/breeding')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/model')
require('scripts/globals/hobbies/chocobo_raising/user_data')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

local effect = xi.chocoboRaising.effect

-----------------------------------
-- Specs
-----------------------------------
-- The saved row from getChocoboRaisingInfo, plus the fields a visit adds.
---@class ChocoboState
---@field charid             integer?
---@field first_name         string
---@field last_name          string
---@field sex                integer
---@field created            integer
---@field age                integer?
---@field last_update_age    integer
---@field stage              integer
---@field location           integer
---@field color              integer
---@field allele1            integer
---@field allele2            integer
---@field allele3            integer
---@field strength           integer
---@field endurance          integer
---@field discernment        integer
---@field receptivity        integer
---@field affection          integer
---@field energy             integer
---@field satisfaction       integer
---@field conditions         integer
---@field ability1           integer
---@field ability2           integer
---@field personality        integer
---@field weather_preference integer
---@field hunger             integer
---@field care_plan          integer
---@field held_item          integer
---@field locked_plan        integer
---@field appearance         integer
---@field walk_progress      integer
---@field csList             table[]?
---@field foodGiven          integer[]?
---@field report             { events: table[] }?
---@field reportStage        integer?
---@field retiring           boolean?
---@field rewardCard         boolean?
---@field skipping           boolean?
---@field storyPending       boolean?
---@field whistleSearchWalk  integer?

-----------------------------------
-- Helpers
-----------------------------------
local function hasRetirementRecord(records)
    for _, record in ipairs(records) do
        for _, cutscene in ipairs(record[3]) do
            if cutscene == xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4 then
                return true
            end
        end
    end

    return false
end

-----------------------------------
-- Private Functions
-----------------------------------
local effectHandlers =
{
    [effect.ADD_KEY_ITEM] = function(player, keyItem)
        player:addKeyItem(keyItem)
    end,

    [effect.DEL_KEY_ITEM] = function(player, keyItem)
        player:delKeyItem(keyItem)
    end,

    [effect.SET_CHAR_VAR] = function(player, name, value)
        player:setCharVar(name, value)
    end,

    [effect.SET_LOCAL_VAR] = function(player, name, value)
        player:setLocalVar(name, value)
    end,

    [effect.ADD_GIL] = function(player, amount)
        npcUtil.giveCurrency(player, 'gil', amount)
    end,

    [effect.SET_HANDKERCHIEF    ] = xi.chocoboRaising.setHandkerchiefState,
    [effect.SET_WHISTLE_PROGRESS] = xi.chocoboRaising.setWhistleProgress,
    [effect.SET_USER_FLAG       ] = xi.chocoboRaising.setUserFlag,
}

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@param egg CItem?
---@return ChocoboState
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
    newChoco.hunger             = xi.chocoboRaising.maxHunger

    xi.chocoboRaising.seedEggStats(newChoco, egg)

    local defaultCarePlan = bit.lshift(7, 4) + 0
    newChoco.care_plan =
        bit.lshift(defaultCarePlan, 24) +
        bit.lshift(defaultCarePlan, 16) +
        bit.lshift(defaultCarePlan,  8) +
        bit.lshift(defaultCarePlan,  0)

    newChoco.held_item     = 0
    newChoco.locked_plan   = xi.chocoboRaising.carePlans.BASIC_CARE
    newChoco.appearance    = 0
    newChoco.walk_progress = 0

    return newChoco
end

-- Days only advance in initChocoState.
---@param player CBaseEntity
---@param chocoState ChocoboState
---@return boolean
xi.chocoboRaising.updateChocoState = function(player, chocoState)
    debug(string.format('Writing chocoState to cache and db. last_update_age: %d', chocoState.last_update_age))

    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    return player:setChocoboRaisingInfo(chocoState)
end

---@param player CBaseEntity
---@return ChocoboCharacterView
xi.chocoboRaising.characterView = function(player)
    return
    {
        handkerchief         = xi.chocoboRaising.handkerchiefState(player),
        handkerchiefSameZone = player:getLocalVar(xi.chocoboRaising.handkerchiefZoneVar) == 1,
        hasWhiteHandkerchief = player:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF),
        hasWhistle           = player:hasItem(xi.item.CHOCOBO_WHISTLE),
        whistleProg          = xi.chocoboRaising.whistleProgress(player),
        debugOnset           = player:getCharVar(xi.chocoboRaising.debugOnsetVar),
    }
end

---@param player CBaseEntity
---@param effects ChocoboEffect[]
xi.chocoboRaising.applyEffects = function(player, effects)
    for _, entry in ipairs(effects) do
        local handler = effectHandlers[entry[1]]
        if not handler then
            print(string.format('ERROR! Unknown chocobo raising effect: %s', tostring(entry[1])))
        else
            handler(player, entry[2], entry[3])
        end
    end
end

-- Applies every rollover since the last visit, so the report only shows past days.
---@param player CBaseEntity
---@param saved ChocoboState?
---@return ChocoboState?
xi.chocoboRaising.initChocoState = function(player, saved)
    local chocoState = saved or player:getChocoboRaisingInfo()
    if not chocoState then
        return nil
    end

    local changed = false
    if not xi.chocoboRaising.carePlanData[chocoState.locked_plan] then
        chocoState.locked_plan = xi.chocoboRaising.carePlans.BASIC_CARE
        changed                = true
    end

    local ctx =
    {
        dayLength = xi.chocoboRaising.dayLength,
        character = xi.chocoboRaising.characterView(player),
    }

    local nextDay          = chocoState.last_update_age
    local records, effects = xi.chocoboRaising.model.advance(chocoState, GetSystemTime(), ctx)

    -- Every visit replays the retirement until it finishes.
    if
        chocoState.stage == xi.chocoboRaising.stage.ADULT_4 and
        not hasRetirementRecord(records)
    then
        local lastDay = xi.chocoboRaising.daysToAdult4
        table.insert(records, { lastDay, lastDay, { xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4 }, { gil = 0, good = 1, poor = 0 }, 0 })
    end

    chocoState.age       = chocoState.last_update_age
    chocoState.csList    = {}
    chocoState.foodGiven = {}
    chocoState.report    = { events = records }

    if
        chocoState.last_update_age == nextDay and
        not changed
    then
        xi.chocoboRaising.chocoState[player:getID()] = chocoState

        return chocoState
    end

    -- Saved first: a failed save must not grant the same days' gil and key items twice.
    if not xi.chocoboRaising.updateChocoState(player, chocoState) then
        return nil
    end

    xi.chocoboRaising.applyEffects(player, effects)

    return chocoState
end
