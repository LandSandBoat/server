describe('Porter Moogle', function()
    ---@type CClientEntityPair
    local player

    local storeEventId = 10105

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.LOWER_JEUNO })
        player:addItem(xi.item.MOOGLE_STORAGE_SLIP_01)
    end)

    -- The slip entitles the player to retrieve a copy, so keeping the original would be a dupe
    it('takes the gear the slip records', function()
        player:addItem(xi.item.ARES_MASK)

        -- the slip goes in the window too: getSlipId reads it from the trade, not from inventory
        player.actions:tradeNpc('Porter_Moogle',
            {
                { itemId = xi.item.MOOGLE_STORAGE_SLIP_01, quantity = 1 },
                { itemId = xi.item.ARES_MASK, quantity = 1 },
            },
            { eventId = storeEventId })

        assert(player:getItemCount(xi.item.ARES_MASK) == 0, 'the gear was kept after the slip recorded it')

        -- the slip carries a bitmask, and the mask is the first entry on slip 1
        local stored = player:getRetrievableItemsForSlip(xi.item.MOOGLE_STORAGE_SLIP_01)

        assert(bit.band(stored[1], 1) ~= 0, 'the slip did not record the gear it took')
    end)

    it('takes every piece of a multi-item deposit', function()
        player:addItem(xi.item.ARES_MASK)
        player:addItem(xi.item.ARES_CUIRASS)

        player.actions:tradeNpc('Porter_Moogle',
            {
                { itemId = xi.item.MOOGLE_STORAGE_SLIP_01, quantity = 1 },
                { itemId = xi.item.ARES_MASK, quantity = 1 },
                { itemId = xi.item.ARES_CUIRASS, quantity = 1 },
            },
            { eventId = storeEventId })

        assert(player:getItemCount(xi.item.ARES_MASK) == 0, 'the mask was kept')
        assert(player:getItemCount(xi.item.ARES_CUIRASS) == 0, 'the cuirass was kept')
    end)
end)
