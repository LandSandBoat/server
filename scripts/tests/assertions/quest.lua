local assert = require('luassert.assert')
local say    = require('say')
local utils  = require('scripts/tests/utils')

local questLogIdStateKey = '__quest_logid_state'
local questIdStateKey    = '__quest_id_state'

local function questModifier(state, args, level)
    assert(args.n > 1, 'Quest modifier expects [logId, id]')
    assert(rawget(state, questLogIdStateKey) == nil, 'Quest logId already set')
    assert(rawget(state, questIdStateKey) == nil, 'Quest id already set')
    rawset(state, questLogIdStateKey, args[1])
    rawset(state, questIdStateKey, args[2])
    return state
end

local function status(state, args, level)
    local player = rawget(state, '__cchar_state')   -- retrieve previously set player
    local logId = rawget(state, questLogIdStateKey) -- retrieve previously set quest logId
    local id = rawget(state, questIdStateKey)       -- retrieve previously set quest id
    local expectedStatus = args[1]
    local actualStatus = player:getQuestStatus(logId, id)

    args[1] = utils.getEnumKey(xi.questStatus, expectedStatus)
    args[2] = utils.getEnumKey(xi.questStatus, actualStatus)
    args.n = 2

    return actualStatus == expectedStatus
end

say:set('assertion.quest_status.positive', [[
Expected quest to have status %s, but found %s.
]])
say:set('assertion.quest_status.negative', [[
Expected quest not to have status %s
]])

assert:register('assertion', 'status', status,
    'assertion.quest_status.positive',
    'assertion.quest_status.negative')

assert:register('modifier', 'quest', questModifier)
