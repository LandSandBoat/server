-----------------------------------
-- A.M.A.N. Trove
-----------------------------------
local ffi = require('ffi')
-----------------------------------

local exploringTheTrove = 1447
-- Takes a Records of Eminence objective the way the client does.
local function takeRecord(player, recordId)
    local packet = ffi.new('uint8_t[8]')
    packet[4] = bit.band(recordId, 0xFF)
    packet[5] = bit.rshift(recordId, 8)
    player.packets:send(0x10C, packet, ffi.sizeof(packet))
end

describe('A.M.A.N. Trove', function()
    local enabled

    setup(function()
        enabled = xi.settings.main.ENABLE_AMAN_TROVE
        xi.settings.main.ENABLE_AMAN_TROVE = 1
    end)

    teardown(function()
        xi.settings.main.ENABLE_AMAN_TROVE = enabled
    end)

    describe('Greyson', function()
        ---@type CClientEntityPair
        local player
        local ageDays

        before_each(function()
            player  = xi.test.world:spawnPlayer({ zone = xi.zone.LOWER_JEUNO, job = xi.job.WAR, level = 99 })
            ageDays = 46

            local created = player:getTimeCreated()
            stub('GetSystemTime', function()
                return created + ageDays * 86400
            end)
        end)

        it('turns away a character below level 99', function()
            takeRecord(player, exploringTheTrove)
            player:setLevel(75)
            player.entities:gotoAndTrigger('Greyson', { eventId = 20082 })
        end)

        it('turns away a character younger than 45 days', function()
            ageDays = 10
            player.entities:gotoAndTrigger('Greyson')
            player.events:expectNotInEvent()
        end)

        it('turns away a character without Exploring the Trove', function()
            player.entities:gotoAndTrigger('Greyson', { eventId = 20082 })
        end)

        it('completes Exploring the Trove after the intro', function()
            takeRecord(player, exploringTheTrove)
            player.entities:gotoAndTrigger('Greyson', { eventId = 20083 })
            assert(player:getEminenceCompleted(exploringTheTrove), 'record was not completed')
        end)

        describe('once the record is complete', function()
            before_each(function()
                player:setEminenceCompleted(exploringTheTrove)
            end)

            it('completes the monthly record and gives a Mars Orb on talking', function()
                takeRecord(player, 3768)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084 })
                assert(player:getEminenceCompleted(3768), 'monthly record was not completed')
                player.assert:hasItem(xi.item.MARS_ORB)
            end)

            it('stores traded silver vouchers', function()
                player:addItem(xi.item.SILVER_AMAN_VOUCHER, 3)
                player.actions:tradeNpc('Greyson', { { itemId = xi.item.SILVER_AMAN_VOUCHER, quantity = 3 } }, { eventId = 20085 })
                assert(player:getCurrency('silver_aman_voucher') == 3, 'vouchers were not stored')
                player.assert.no:hasItem(xi.item.SILVER_AMAN_VOUCHER)
            end)

            it('exchanges 10 vouchers for a Venus Orb', function()
                player:addCurrency('silver_aman_voucher', 12)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 2 })
                player.assert:hasItem(xi.item.VENUS_ORB)
                assert(player:getCurrency('silver_aman_voucher') == 2, 'wrong number of vouchers taken')
            end)

            it('gives no orb when vouchers run short', function()
                player:addCurrency('silver_aman_voucher', 5)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 1 })
                player.assert.no:hasItem(xi.item.MARS_ORB)
                assert(player:getCurrency('silver_aman_voucher') == 5, 'vouchers were taken')
            end)

            it('sells at most 5 vouchers a month', function()
                player:addGil(1000000)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 3 })
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 4 })
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 3 })
                assert(player:getCurrency('silver_aman_voucher') == 5, 'wrong number of vouchers sold')
                player.assert:hasGil(500000)
            end)

            it('swaps a used orb for a reward', function()
                player:addItem(xi.item.MARS_ORB)
                assert(player:incrementItemWear(xi.item.MARS_ORB) == 1, 'the orb did not wear')
                player.actions:tradeNpc('Greyson', { xi.item.MARS_ORB })

                local rewarded = false
                for _, itemId in ipairs({ xi.item.SPECIAL_GOBBIEDIAL_KEY, xi.item.COPPER_AMAN_VOUCHER, xi.item.BOTTLE_OF_ORANGE_JUICE, xi.item.BOTTLE_OF_APPLE_JUICE }) do
                    rewarded = rewarded or player:hasItem(itemId)
                end

                -- A fresh orb is one of the rewards, so a held orb must be unused.
                rewarded = rewarded or (player:hasItem(xi.item.MARS_ORB) and player:getWornUses(xi.item.MARS_ORB) == 0)
                assert(rewarded, 'no reward for the used orb')
            end)

            it('keeps an orb that has not been used', function()
                player:addItem(xi.item.MARS_ORB)
                player.actions:tradeNpc('Greyson', { xi.item.MARS_ORB })
                player.assert:hasItem(xi.item.MARS_ORB)
                assert(player:getWornUses(xi.item.MARS_ORB) == 0, 'the unused orb was worn')
            end)
        end)
    end)

    describe('Monthly records', function()
        local hello = string.char(0xFD, 0x02, 0x02, 0x01, 0x0B, 0xFD)

        ---@type CClientEntityPair
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA, job = xi.job.WAR, level = 99 })
            player:setNation(xi.nation.SANDORIA)
        end)

        after_each(function()
            xi.settings.main.ENABLE_AMAN_TROVE = 1
        end)

        it('completes Examine a Home Point in the home nation', function()
            takeRecord(player, 3769)
            player.entities:gotoAndTrigger('HomePoint#1', { eventId = 8700 })

            assert(player:getEminenceCompleted(3769), 'record was not completed')
            player.assert:hasItem(xi.item.SILVER_AMAN_VOUCHER)
        end)

        it('ignores a home point outside the home nation', function()
            player:setNation(xi.nation.BASTOK)
            takeRecord(player, 3769)
            player.entities:gotoAndTrigger('HomePoint#1', { eventId = 8700 })

            assert(not player:getEminenceCompleted(3769), 'record was completed')
        end)

        it('pays nothing while A.M.A.N. Trove is disabled', function()
            xi.settings.main.ENABLE_AMAN_TROVE = 0
            takeRecord(player, 3769)
            player.entities:gotoAndTrigger('HomePoint#1', { eventId = 8700 })

            assert(not player:getEminenceCompleted(3769), 'record was completed')
            player.assert.no:hasItem(xi.item.SILVER_AMAN_VOUCHER)
        end)

        it('completes Auction an Item on a listing', function()
            takeRecord(player, 3770)
            player:triggerRoeEvent(xi.roeTrigger.AUCTION_LISTING, { itemid = xi.item.AMBER_STONE })

            assert(player:getEminenceCompleted(3770), 'record was not completed')
        end)

        it('completes Unity Chat Greetings only for the auto-translated greeting', function()
            takeRecord(player, 3771)
            player:triggerRoeEvent(xi.roeTrigger.UNITY_CHAT, { unityMessage = 'Hello!' })
            assert(not player:getEminenceCompleted(3771), 'plain text completed the record')

            player:triggerRoeEvent(xi.roeTrigger.UNITY_CHAT, { unityMessage = hello })
            assert(player:getEminenceCompleted(3771), 'record was not completed')
        end)

        it('counts Conquest Participation kills only in conquest regions', function()
            takeRecord(player, 3772)

            player:triggerRoeEvent(xi.roeTrigger.DEFEAT_MOB)
            assert(player:getEminenceProgress(3772) == 0, 'a kill outside a conquest region counted')

            player:gotoZone(xi.zone.WEST_RONFAURE)
            for _ = 1, 30 do
                player:triggerRoeEvent(xi.roeTrigger.DEFEAT_MOB)
            end

            assert(player:getEminenceCompleted(3772), 'record was not completed')
        end)

        it('clears on the first of the JST month only', function()
            player:setEminenceCompleted(3768)

            for _ = 1, 32 do
                xi.test.world:tick(xi.tick.JST_DAY)
                if JstDayOfTheMonth() == 1 then
                    break
                end

                assert(player:getEminenceCompleted(3768), 'monthly record cleared before the first of the month')
            end

            assert(not player:getEminenceCompleted(3768), 'monthly record is still complete')
        end)
    end)
end)
