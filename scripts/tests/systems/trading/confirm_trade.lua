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

        -- TODO: this should probably use hasAttachment but it fails for some reason?
        -- use "failure to unlock attachment" as "hasAttachment"
        assert(player:unlockAttachment(xi.item.BARRAGE_TURBINE) == false, 'barrage turbine is unlocked')

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

        -- TODO: this should probably use hasAttachment but it fails for some reason?
        -- use "failure to unlock attachment" as "hasAttachment"
        assert(player:unlockAttachment(xi.item.BARRIER_MODULE_II) == false, 'barrier module II is unlocked')

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
end)
