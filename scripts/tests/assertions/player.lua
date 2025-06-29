local assert   = require('luassert.assert')
local say      = require('say')
local utils    = require('scripts/tests/utils')

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
