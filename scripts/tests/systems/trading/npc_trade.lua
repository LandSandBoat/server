describe('NpcTradeTransaction', function()
    ---@type CClientEntityPair
    local player

    -- eight distinct stacks, to fill the window ahead of the item under test
    local fillers =
    {
        xi.item.FIRE_CRYSTAL,
        xi.item.ICE_CRYSTAL,
        xi.item.WIND_CRYSTAL,
        xi.item.EARTH_CRYSTAL,
        xi.item.LIGHTNING_CRYSTAL,
        xi.item.WATER_CRYSTAL,
        xi.item.LIGHT_CRYSTAL,
        xi.item.DARK_CRYSTAL,
    }

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.METALWORKS })
    end)

    it('takes the item a trade was accepted for', function()
        player:setCharVar('TOO_MANY_CHEFS', 3)
        player:addItem(xi.item.RED_OVEN_MITT)

        player.actions:tradeNpc('Leonhardt',
            {
                { itemId = xi.item.RED_OVEN_MITT, quantity = 1 },
            },
            { eventId = 950 })

        assert(player:getItemCount(xi.item.RED_OVEN_MITT) == 0, 'the mitt was not taken')
    end)

    -- the window holds nine slots once gil takes slot 0, so the last one has to be consumed like any other
    it('takes an item offered in the last slot of a full window', function()
        player:setCharVar('TOO_MANY_CHEFS', 3)

        local offer = {}
        for _, filler in ipairs(fillers) do
            player:addItem(filler)
            offer[#offer + 1] = { itemId = filler, quantity = 1 }
        end

        player:addItem(xi.item.RED_OVEN_MITT)
        offer[#offer + 1] = { itemId = xi.item.RED_OVEN_MITT, quantity = 1 }

        assert(#offer == 9, 'offer size: ' .. tostring(#offer))

        player.actions:tradeNpc('Leonhardt', offer, { eventId = 950 })

        assert(player:getItemCount(xi.item.RED_OVEN_MITT) == 0, 'the mitt in the last slot was kept')

        for _, filler in ipairs(fillers) do
            assert(player:getItemCount(filler) == 0, 'filler ' .. tostring(filler) .. ' was kept')
        end
    end)

    it('gives back everything when the npc wants none of it', function()
        player:addItem(xi.item.RED_OVEN_MITT)

        player.actions:tradeNpc('Leonhardt',
            {
                { itemId = xi.item.RED_OVEN_MITT, quantity = 1 },
            })

        local mitt = player:findItem(xi.item.RED_OVEN_MITT, xi.inventoryLocation.INVENTORY)
        assert(mitt, 'the mitt was taken without the trade being accepted')
        assert(mitt:state() == xi.itemState.FREE, 'state: ' .. tostring(mitt:state()))
    end)

    it('holds an offered item while the npc decides', function()
        player:setCharVar('TOO_MANY_CHEFS', 3)
        player:addItem(xi.item.RED_OVEN_MITT)

        local mitt = player:findItem(xi.item.RED_OVEN_MITT, xi.inventoryLocation.INVENTORY)

        assert(mitt, 'the mitt was not added')
        assert(mitt:state() == xi.itemState.FREE, 'state before the offer: ' .. tostring(mitt:state()))

        player.actions:tradeNpc('Leonhardt',
            {
                { itemId = xi.item.RED_OVEN_MITT, quantity = 1 },
            },
            { eventId = 950 })

        assert(player:getItemCount(xi.item.RED_OVEN_MITT) == 0, 'the mitt was not taken')
    end)
end)
