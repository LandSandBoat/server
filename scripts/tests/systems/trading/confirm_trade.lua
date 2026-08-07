describe('confirmTrade & confirmItem', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.PUP,
                level = 75,
                zone  = xi.zone.AHT_URHGAN_WHITEGATE,
            })

        player:unlockAttachment(xi.item.HARLEQUIN_FRAME)
        player:unlockAttachment(xi.item.HARLEQUIN_HEAD)
    end)

    it('can unlock attachment with extra attachment in window', function()
        assert(player:getCharVar('TateeyaTradeStatus') == 0, 'automaton attachment trading is not unlocked')

        player.entities:gotoAndTrigger('Tateeya', { eventId = 650 })

        assert(player:getCharVar('TateeyaTradeStatus') == 1, 'should unlock automaton attachment trading from Tateeya')

        player:addItem(xi.item.BARRAGE_TURBINE, 2)
        player:addItem(xi.item.BARRIER_MODULE_II)

        local turbineAttachment = player:findItem(xi.item.BARRAGE_TURBINE, xi.inventoryLocation.INVENTORY):getSubID()
        local moduleAttachment  = player:findItem(xi.item.BARRIER_MODULE_II, xi.inventoryLocation.INVENTORY):getSubID()

        player.actions:tradeNpc('Tateeya',
            {
                {
                    itemId   = xi.item.BARRAGE_TURBINE,
                    quantity = 1,
                },
                {
                    itemId   = xi.item.BARRIER_MODULE_II,
                    quantity = 1,
                }
            },
            { eventId = 651 })

        assert(player:hasAttachment(turbineAttachment), 'barrage turbine is unlocked')

        local turbine = player:findItem(xi.item.BARRAGE_TURBINE, xi.inventoryLocation.INVENTORY)

        assert(turbine, 'player still has a barrage turbine in inventory')
        assert(turbine:getQuantity() == 1, 'player still has a single barrage turbine in inventory')
        assert(turbine:getReservedValue() == 0, 'the barrage turbine item is not reserved')

        local barrierModule = player:findItem(xi.item.BARRIER_MODULE_II, xi.inventoryLocation.INVENTORY)

        assert(barrierModule, 'player still has a barrier module in inventory')
        assert(barrierModule:getReservedValue() == 0, 'the barrier module is not reserved')

        player.actions:tradeNpc('Tateeya',
            {
                {
                    itemId   = xi.item.BARRIER_MODULE_II,
                    quantity = 1,
                },
                {
                    itemId   = xi.item.BARRAGE_TURBINE,
                    quantity = 1,
                }
            },
            { eventId = 651 })

        assert(player:hasAttachment(moduleAttachment), 'barrier module II is unlocked')

        -- pointer should be stale - search for the barrier module again
        barrierModule = player:findItem(xi.item.BARRIER_MODULE_II, xi.inventoryLocation.INVENTORY)
        assert(barrierModule == nil, 'player does not have a barrier module in inventory')

        -- search for the turbine again
        turbine = player:findItem(xi.item.BARRAGE_TURBINE, xi.inventoryLocation.INVENTORY)
        assert(turbine, 'player still has a barrage turbine in inventory')
        assert(turbine:getQuantity() == 1, 'player still has a single barrage turbine in inventory')
        assert(turbine:getReservedValue() == 0, 'the barrage turbine item is not reserved')

        -- You already have this unlocked
        player.actions:tradeNpc('Tateeya',
            {
                {
                    itemId   = xi.item.BARRAGE_TURBINE,
                    quantity = 1,
                }
            },
            { eventId = 652 })
    end)

    it('does not leave a reserve when only part of a stack is confirmed', function()
        player.entities:gotoAndTrigger('Tateeya', { eventId = 650 })

        player:addItem(xi.item.BARRAGE_TURBINE, 2)

        -- Tateeya confirms a single item out of the traded stack
        player.actions:tradeNpc('Tateeya',
            {
                {
                    itemId   = xi.item.BARRAGE_TURBINE,
                    quantity = 2,
                }
            },
            { eventId = 651 })

        local turbine = player:findItem(xi.item.BARRAGE_TURBINE, xi.inventoryLocation.INVENTORY)

        assert(turbine, 'player still has a barrage turbine in inventory')
        assert(turbine:getQuantity() == 1, 'only the confirmed turbine was taken')
        assert(turbine:getReservedValue() == 0, 'the leftover turbine is not reserved')
    end)
end)
