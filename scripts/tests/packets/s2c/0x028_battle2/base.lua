-- Collection of retail BATTLE2 packets for testing
-- Please follow this process:
-- - Add a new entry in the table with an empty test
-- - Name the entry in a descriptive fashion, including the type of action packet.
-- - Use 'actionparse' on Ashita to get a dump of the action packet
-- - Obtain several copies of the packet to figure out uncleared buffers we don't care about
-- - Click the 'Export' button in actionparse and paste the table below
-- - Zero out retail uncleared buffers
-- - Replace the m_uID fields with TEST_CHAR (adjust accordingly if test involves several entities)
-- - Replace the mob ID fields with TEST_MOB (adjust accordingly)
-- - Replace dynamic values with IGNORE (for example damage dealt)
-- - Replace the various fields with the appropriate enums
--   - Add the entries if they're missing
-- - Fill in the actual test function

local ph         = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@class Battle2Result
---@field miss integer Resolution of the action (hit, miss, parry, etc.)
---@field kind integer Action kind/type
---@field sub_kind integer Action subtype (e.g., spell ID for magic)
---@field info integer? Additional info field
---@field scale integer? Damage/effect scaling factor
---@field value integer? Main value (damage, healing, effect ID, etc.). Use IGNORE to skip comparison
---@field message integer? Message ID to display
---@field bit integer Bitfield for various flags
---@field has_proc boolean Whether a proc/additional effect occurred
---@field proc_kind integer? Proc effect kind
---@field proc_info integer? Proc effect info
---@field proc_value integer? Proc effect value
---@field proc_message integer? Proc effect message ID
---@field has_react boolean Whether a reaction (spikes, counter, etc.) occurred
---@field react_kind integer? Reaction kind
---@field react_info integer? Reaction info
---@field react_value integer? Reaction value
---@field react_message integer? Reaction message ID

---@class Battle2Target
---@field m_uID integer? Target entity ID (use TEST_CHAR or TEST_MOB)
---@field result_sum integer Number of results for this target
---@field result Battle2Result[] Array of action results

---@class Battle2Packet
---@field m_uID integer? Actor entity ID (use TEST_CHAR or TEST_MOB)
---@field trg_sum integer? Number of targets
---@field res_sum integer Total number of results across all targets
---@field cmd_no integer Action category (xi.action.category)
---@field cmd_arg integer Action argument (spell ID, ability ID, etc.)
---@field info integer Additional info (recast time, etc.)
---@field target Battle2Target[] Array of targets affected by this action

---@class Battle2TestEntry
---@field test fun(player: CClientEntityPair, mob: CTestEntity) Test function that sets up and executes the test scenario
---@field expected Battle2Packet|Battle2Packet[] Expected packet(s). Single packet or array of packets

---@alias Battle2TestSuite table<string, Battle2TestEntry>

---@type table<string, Battle2TestSuite>
local testSuites =
{
    ['Abilities']        = require('scripts.tests.packets.s2c.0x028_battle2.abilities'),
    ['Basic Attacks']    = require('scripts.tests.packets.s2c.0x028_battle2.basic_attacks'),
    ['Beastmaster']      = require('scripts.tests.packets.s2c.0x028_battle2.beastmaster'),
    ['Dancer #dnc']      = require('scripts.tests.packets.s2c.0x028_battle2.dancer'),
    ['Dragoon #drg']     = require('scripts.tests.packets.s2c.0x028_battle2.dragoon'),
    ['Items #item']      = require('scripts.tests.packets.s2c.0x028_battle2.items'),
    ['Magic #magic']     = require('scripts.tests.packets.s2c.0x028_battle2.magic'),
    ['Mobskills']        = require('scripts.tests.packets.s2c.0x028_battle2.mobskills'),
    ['Ranged']           = require('scripts.tests.packets.s2c.0x028_battle2.ranged'),
    ['Rune Fencer #run'] = require('scripts.tests.packets.s2c.0x028_battle2.runefencer'),
    ['Summoner #smn']    = require('scripts.tests.packets.s2c.0x028_battle2.summoner'),
    ['Weaponskills #ws'] = require('scripts.tests.packets.s2c.0x028_battle2.weaponskills'),
}

-- TODO: Replace with some higher level diff library
local function diffPacket(actual, expected, prefix, phValues)
    prefix = prefix or 'action'
    local diffs = {}

    for key, expectedValue in pairs(expected) do
        local actualValue = actual[key]
        local fieldName   = prefix .. '.' .. key

        if type(expectedValue) == 'table' then
            if type(actualValue) ~= 'table' then
                table.insert(diffs, string.format('%s: expected table, got %s', fieldName, type(actualValue)))
            else
                -- Recursively diff
                local nestedDiffs = diffPacket(actualValue, expectedValue, fieldName, phValues)
                for _, diff in ipairs(nestedDiffs) do
                    table.insert(diffs, diff)
                end
            end
        elseif expectedValue == ph.TEST_CHAR then
            -- Match dynamically the test char ID
            if actualValue ~= phValues.charId then
                table.insert(diffs, string.format('%s: %s != %s', fieldName, tostring(actualValue), tostring(phValues.charId)))
            end
        elseif expectedValue == ph.TEST_MOB then
            -- Match dynamically the mob ID
            if actualValue ~= phValues.mobId then
                table.insert(diffs, string.format('%s: %s != %s', fieldName, tostring(actualValue), tostring(phValues.mobId)))
            end
        elseif actualValue ~= expectedValue then
            -- Ignore values hard to predict such as damage
            if expectedValue ~= ph.IGNORE then
                table.insert(diffs, string.format('%s: %s != %s', fieldName, tostring(actualValue), tostring(expectedValue)))
            end
        end
    end

    return diffs
end

describe('BATTLE2', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local mob

    before_each(function()
        xi.test.world:setSeed(1)

        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.WAR,
                level = 99,
                zone  = xi.zone.QUFIM_ISLAND,
            })

        mob = player.entities:moveTo(17293357)
        mob:respawn()
        mob.assert:isAlive()
    end)

    -- Iterate through test suites in deterministic order
    local suiteNames = {}
    for suiteName in pairs(testSuites) do
        table.insert(suiteNames, suiteName)
    end

    table.sort(suiteNames)

    for _, suiteName in ipairs(suiteNames) do
        local suiteDefinition = testSuites[suiteName]
        describe(suiteName, function()
            -- Iterate through test cases in deterministic order
            local caseNames = {}
            for caseName in pairs(suiteDefinition) do
                table.insert(caseNames, caseName)
            end

            table.sort(caseNames)

            for _, caseName in ipairs(caseNames) do
                local caseDefinition = suiteDefinition[caseName]
                it(caseName, function()
                    caseDefinition.test(player, mob)
                    xi.test.world:tickEntity(player) -- Tick player AI once to progress states
                    xi.test.world:tickEntity(mob)    -- Tick mob AI once to progress states

                    -- Determine if we expect one packet or multiple
                    local expectedPackets = {}
                    if caseDefinition.expected[1] == nil then
                        -- Single packet (no array index [1])
                        expectedPackets = { caseDefinition.expected }
                    else
                        -- Multiple packets (array with index [1])
                        expectedPackets = caseDefinition.expected
                    end

                    -- Track which expected packets have been matched
                    local matchedExpected = {}
                    for i = 1, #expectedPackets do
                        matchedExpected[i] = false
                    end

                    -- Retrieve BATTLE2 packets
                    local receivedPackets     = player.packets:actionPackets()
                    local receivedPacketCount = #receivedPackets
                    local allDiffs            = {}

                    for i, action in pairs(receivedPackets) do
                        -- Try to match against any unmatched expected packet
                        local bestMatchIdx   = nil
                        local bestMatchDiffs = nil

                        for expectedIdx, expectedPacket in pairs(expectedPackets) do
                            if not matchedExpected[expectedIdx] then
                                local diffs = diffPacket(action, expectedPacket, nil, { charId = player:getID(), mobId = mob:getID() })
                                if #diffs == 0 then
                                    InfoTest(string.format('Matched expected packet #%d', expectedIdx))
                                    matchedExpected[expectedIdx] = true
                                    bestMatchIdx                 = expectedIdx
                                    bestMatchDiffs               = diffs
                                    break
                                elseif bestMatchIdx == nil or #diffs < #bestMatchDiffs then
                                    -- Track the closest match for debugging
                                    bestMatchIdx   = expectedIdx
                                    bestMatchDiffs = diffs
                                end
                            end
                        end

                        -- Store diffs for the best match if we didn't find a perfect match
                        if bestMatchIdx ~= nil then
                            allDiffs[i] =
                            {
                                expectedIdx = bestMatchIdx,
                                diffs       = bestMatchDiffs,
                            }
                        end
                    end

                    -- Check if all expected packets were matched
                    local unmatchedPackets = {}
                    for i = 1, #expectedPackets do
                        if not matchedExpected[i] then
                            table.insert(unmatchedPackets, i)
                        end
                    end

                    if #unmatchedPackets > 0 then
                        InfoTest(string.format('Received %d BATTLE2 packet(s), could not match %d of %d expected packet(s)',
                            receivedPacketCount, #unmatchedPackets, #expectedPackets))

                        -- For each unmatched expected packet, print ALL matches
                        for _, expectedIdx in ipairs(unmatchedPackets) do
                            local hasMatches = false

                            -- Print all received packet matches for this expected packet
                            for recvIdx, diffInfo in pairs(allDiffs) do
                                if diffInfo.expectedIdx == expectedIdx then
                                    hasMatches = true
                                    InfoTest(string.format('Expected #%d vs Received packet #%d: %d diffs',
                                        expectedIdx, recvIdx, #diffInfo.diffs))
                                    for _, diff in pairs(diffInfo.diffs) do
                                        InfoTest('  ' .. diff)
                                    end
                                end
                            end

                            if not hasMatches then
                                InfoTest(string.format('Expected #%d: No received packets to compare', expectedIdx))
                            end
                        end

                        assert(false, string.format('Could not match expected BATTLE2 packet(s): %s',
                            table.concat(unmatchedPackets, ', ')))
                    end
                end)
            end
        end)
    end
end)
