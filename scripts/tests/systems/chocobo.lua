-- TODO:
--  - Allied notes
--  - Racing game
--  - Non-premium pricing

describe('Chocobo Rental', function()
    ---@type CClientEntityPair
    local player
    -- The data we'll be testing
    local chocoboTable = xi.chocobo.chocoboInfo[xi.zone.LA_THEINE_PLATEAU]

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 20, zone = xi.zone.LA_THEINE_PLATEAU })
        player:addKeyItem(xi.ki.CHOCOBO_LICENSE)
    end)

    after_each(function()
        -- Reset sales after each test
        chocoboTable.sales = 0
    end)

    it('players under 20 cant ride', function()
        player:setLevel(19) -- Even with a license!
        player.entities:gotoAndTrigger('Coumaine', { eventId = 121 })
    end)

    it('players without a license cant ride', function()
        player:delKeyItem(xi.ki.CHOCOBO_LICENSE)
        player.entities:gotoAndTrigger('Coumaine', { eventId = 121 })
    end)

    it('players without enough gil cant ride', function()
        -- This returns the correct event but it should NOT mount the PC
        player.entities:gotoAndTrigger('Coumaine', { eventId = 120 })
        player.assert.no:hasEffect(xi.effect.MOUNTED)
    end)

    it('players meeting all qualifications can ride', function()
        player:setGil(140) -- First sale is always 140g for a level 20 PC
        player.entities:gotoAndTrigger('Coumaine', { eventId = 120 })
        player.assert:hasEffect(xi.effect.MOUNTED)
    end)

    it('price increases after each sale', function()
        -- Setup stubs to ensure they get called when renting a chocobo
        local increaseSalesStub = stub('xi.chocobo.increaseSales')
        local getPriceStub      = stub('xi.chocobo.getPrice')

        player:setGil(140)
        player.entities:gotoAndTrigger('Coumaine', { eventId = 120, finishOption = 0 })
        player.assert:hasEffect(xi.effect.MOUNTED)
        player.assert:hasGil(0)
        increaseSalesStub:called(1)
        getPriceStub:called(1)

        -- Next getPrice should be 5% higher
        local expectedPrice = math.floor(140 + 140 * 0.05)
        assert(xi.chocobo.getPrice(player) == expectedPrice, 'Chocobo price did not increase')
    end)

    it('price decreases every minute', function()
        local onTimeServerTickStub = stub('xi.chocobo.onTimeServerTick')

        -- Simulate that 1000 sales have occured
        -- Verify that the price reflects the change
        chocoboTable.sales = 1000
        local expectedPrice = math.floor(140 + 140 * (0.05 * 1000))
        assert(xi.chocobo.getPrice(player) == expectedPrice, 'Chocobo price did not increase')

        -- Now pass 1 Vanadiel minute (25 ticks)
        -- TODO: Figure out a better notation?
        for _ = 1, 25 do
            xi.test.world:tick(xi.tick.TIME)
        end

        -- Verify that the function was called 25 times and the price decreased
        expectedPrice = math.floor(140 + 140 * (0.05 * 999))
        onTimeServerTickStub:called(25)
        assert(chocoboTable.sales == 999, 'Chocobo sales did not decrease after 1 minute')
        assert(xi.chocobo.getPrice(player) == expectedPrice, 'Chocobo price did not decrease')
    end)
end)
