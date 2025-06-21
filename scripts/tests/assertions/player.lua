local assert   = require('luassert.assert')
local say      = require('say')
local utils    = require('scripts.tests.utils')

-- luacheck: ignore 241
---@class luassert.internal
local internal = {}

---Perform an assertion on a player object. This will allow you to call further
---function to perform an assertion.
---@param entity CBaseEntity The player entity
---@return luassert.player playerAssert A new object that has further assert function options
function internal.player(entity)
end

-- luacheck: ignore 241
---@class luassert.player
local player = {}

player.has = player
player.no = player

---Prepare assertions on a specific quest
---@param logId xi.questLog The quest log identifier
---@param id integer The quest identifier
---@return luassert.quest
function player.quest(logId, id)
end

---Assert that player possess a specific item
---@param itemId xi.item The item ID
---@return luassert.player
function player.item(itemId)
end

---Assert that player possess a specific key item
---@param keyItemId xi.keyItem The key item ID
---@return luassert.player
function player.ki(keyItemId)
end

---Assert that player has a modifier with value
---@param modId xi.mod The modifier ID
---@param expected integer Value to compare against
---@return luassert.player
function player.modifier(modId, expected)
end

---Assert that player has a status effect
---@param effectId xi.effect The modifier ID
---@return luassert.player
function player.effect(effectId)
end

---Assert that player is on a given mission
---@param logId xi.mission.log_id The mission log ID
---@param missionId integer The mission ID
---@return luassert.player
function player.mission(logId, missionId)
end

---Assert that player has a specific nation rank
---@param rank integer Expected rank
---@return luassert.player
function player.nationRank(rank)
end

local playerStateKey = '__cchar_state'

local function playerModifier(state, args, level)
    assert(args.n > 0, 'No player provided to the player-modifier')
    assert(rawget(state, playerStateKey) == nil, 'Player already set')
    rawset(state, playerStateKey, args[1])
    return state
end

local function setupAssertions()
    local assertions =
    {
        ['item'] =
        {
            positive = 'Expected player to have item %s',
            negative = 'Expected player not to have item %s',
            func     = function(p, args)
                local expectedItem = args[1]

                args[1] = utils.getEnumKey(xi.item, expectedItem)
                args.n = 1

                return p:hasItem(expectedItem)
            end,
        },
        ['ki'] =
        {
            positive = 'Expected player to have key item %s',
            negative = 'Expected player not to have key item %s',
            func     = function(p, args)
                local expectedKeyItem = args[1]

                args[1] = utils.getEnumKey(xi.keyItem, expectedKeyItem)
                args.n = 1

                return p:hasKeyItem(expectedKeyItem)
            end,
        },
        ['modifier'] =
        {
            positive = 'Expected player to have mod %s == %s, found %s',
            negative = 'Expected player to have mod %s != %s',
            func     = function(p, args)
                local expectedModId = args[1]
                local expectedValue = args[2]
                local actualValue = p:getMod(expectedModId)

                args[1] = utils.getEnumKey(xi.mod, expectedModId)
                args[2] = expectedValue
                args[3] = actualValue
                args.n = 3

                return actualValue == expectedValue
            end,
        },
        ['effect'] =
        {
            positive = 'Expected player to have status %s',
            negative = 'Expected player to not have status %s',
            func     = function(p, args)
                local expectedStatusId = args[1]

                args[1] = utils.getEnumKey(xi.effect, expectedStatusId)
                args.n = 1

                return p:hasStatusEffect(expectedStatusId)
            end,
        },
        ['mission'] =
        {
            positive = 'Expected player to be on mission %s.%s, but found %s',
            negative = 'Expected player to not be on mission %s',
            func     = function(p, args)
                local expectedMissionLogId = args[1]
                local expectedMissionId    = args[2]
                local actualMissionId      = p:getCurrentMission(expectedMissionLogId)

                args[1]                    = utils.getEnumKey(xi.mission.log_id, expectedMissionLogId)
                args[2]                    = utils.getEnumKey(xi.mission.id, expectedMissionId)
                args[3]                    = utils.getEnumKey(xi.mission.id, actualMissionId)
                args.n                     = 3

                return actualMissionId == expectedMissionId
            end,
        },
        ['nationRank'] =
        {
            positive = 'Expected player to have nation rank %s, but found %s',
            negative = 'Expected player to not have nation rank %s',
            func     = function(p, args)
                local expectedNationRank = args[1]
                local actualNationRank   = p:getRank(p:getNation())

                args[1]                  = expectedNationRank
                args[2]                  = actualNationRank
                args.n                   = 2

                return expectedNationRank == actualNationRank
            end,
        },
    }

    for assertion, config in pairs(assertions) do
        say:set(string.format('assertion.%s.positive', assertion), config.positive)
        say:set(string.format('assertion.%s.negative', assertion), config.negative)
        assert:register('assertion',
            assertion,
            function(state, args, level)
                ---@type CBaseEntity
                local p = rawget(state, playerStateKey)

                return config.func(p, args)
            end,

            string.format('assertion.%s.positive', assertion),
            string.format('assertion.%s.negative', assertion))
    end
end

setupAssertions()
assert:register('modifier', 'player', playerModifier)
