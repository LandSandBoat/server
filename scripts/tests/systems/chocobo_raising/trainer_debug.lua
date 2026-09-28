-----------------------------------
-- The GM debug entries in the trainer's main menu.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local goForward      = 226 + 1 * 256
local abilitiesPrint = 229
local userWorkPrint  = 232
local debugEntryBits = 0x1C000000

describe('Chocobo raising trainer debug entries', function()
    ---@type CClientEntityPair
    local player
    ---@type RaisingClient
    local client

    -- The client goes back to the menu after each entry.
    local function assertBackToMenu()
        raisingClient.send(client, 214)
        raisingClient.send(client, 215)
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:setGMLevel(0)
        player:deleteRaisedChocobo()

        stub('math.randomInt', 1)

        client = raisingClient.tradeEgg(player)

        raisingClient.setChocobo(player,
        {
            strength     = 200,
            endurance    = 3,
            discernment  = 150,
            receptivity  = 45,
            affection    = 130,
            energy       = 77,
            satisfaction = 12,
        })
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    it('shows the entries to a GM only, and gives a player zeros for the prints', function()
        raisingClient.talk(client)
        local mask = raisingClient.send(client, 215)[0]
        raisingClient.finish(client, 0)
        assert(bit.band(mask, debugEntryBits) == debugEntryBits, string.format('Expected the entries hidden from a player, got 0x%08X', mask))

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, abilitiesPrint), 'Abilities print')
        raisingClient.assertZeros(raisingClient.send(client, userWorkPrint), 'User work print')
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().strength == 200, 'Expected the chocobo unchanged')

        player:setGMLevel(1)
        raisingClient.talk(client)
        mask = raisingClient.send(client, 215)[0]
        raisingClient.finish(client, 0)
        assert(bit.band(mask, debugEntryBits) == 0, string.format('Expected the entries shown to a GM, got 0x%08X', mask))
    end)

    it('prints the raw stats and care values, and the user work to chat, and changes nothing', function()
        player:setGMLevel(3)

        raisingClient.talk(client)
        local reply = raisingClient.send(client, abilitiesPrint)
        assertBackToMenu()
        raisingClient.finish(client, 0)

        local stats = { 200, 3, 150, 45 }
        for i, expected in ipairs(stats) do
            local actual = bit.band(bit.rshift(reply[1], (i - 1) * 8), 0xFF)
            assert(actual == expected, string.format('Expected stat byte %d to be %d, got %d', i - 1, expected, actual))
        end

        local care = { 130, 77, 12 }
        for i, expected in ipairs(care) do
            local actual = bit.band(bit.rshift(reply[2], (i - 1) * 8), 0xFF)
            assert(actual == expected, string.format('Expected care byte %d to be %d, got %d', i - 1, expected, actual))
        end

        local before = player:getChocoboRaisingInfo()

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, userWorkPrint), 'User work print')

        local printed = string.find(raisingClient.chatText(player), 'Lost chick: owner', 1, true)

        assertBackToMenu()
        raisingClient.finish(client, 0)

        assert(printed, 'Expected the user work printed to chat, as the debug menu does')

        local after = player:getChocoboRaisingInfo()
        assert(after.created == before.created and after.strength == before.strength, 'Expected the chocobo unchanged')
    end)

    it('goes forward one day, reported on the next visit', function()
        player:setGMLevel(3)

        raisingClient.talk(client)
        raisingClient.send(client, goForward)
        assertBackToMenu()
        raisingClient.finish(client, 0)

        local visit = raisingClient.visit(client)
        assert(#visit.records > 0, 'Expected a report after going forward')

        local endDay = visit.records[#visit.records].endDay
        assert(endDay == 1, string.format('Expected the report to reach day 1, got day %d', endDay))
    end)

    describe('with debug logging on', function()
        local eventVmModule = 'scripts/globals/hobbies/chocobo_raising/event_vm'
        local lines         = {}

        -- The printer reads the setting when the module loads.
        local function reloadEventVm()
            package.loaded[eventVmModule] = nil
            require(eventVmModule)
        end

        local function logged(prefix)
            for _, line in ipairs(lines) do
                if string.sub(line, 1, #prefix) == prefix then
                    return line
                end
            end

            return nil
        end

        before_each(function()
            lines = {}
            xi.test.world:setSetting('main.DEBUG_CHOCOBO_RAISING', true)
            reloadEventVm()
            stub('print', function(line)
                table.insert(lines, tostring(line))
            end)

            player:setGMLevel(3)
        end)

        after_each(function()
            xi.test.world:setSetting('main.DEBUG_CHOCOBO_RAISING', false)
            reloadEventVm()
        end)

        it('logs each entry', function()
            raisingClient.talk(client)
            raisingClient.send(client, goForward)
            raisingClient.send(client, abilitiesPrint)
            raisingClient.send(client, userWorkPrint)
            raisingClient.finish(client, 0)

            local expected =
            {
                'Debug: moved time forward 1 days',
                'Debug: abilities print STR:200/VIT:3/INT:150/MND:45, Affection:130/Energy:77/Satisfaction:12',
            }

            for _, line in ipairs(expected) do
                assert(logged(line), string.format('Expected the log line "%s"', line))
            end

            assert(logged('Debug: user work print'), 'Expected the user work log line')
        end)
    end)
end)
