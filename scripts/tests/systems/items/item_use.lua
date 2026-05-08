describe('Item use', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.WAR,
                level = 75,
                zone  = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('idle item is in Free state', function()
        player:addItem(xi.item.POTION)
        local potion = player:findItem(xi.item.POTION)
        assert(potion)
        assert(potion:state() == xi.itemState.FREE)
    end)

    it('equipped item is in Equipped state', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)

        local sword = player:findItem(xi.item.BRONZE_SWORD)
        assert(sword)
        assert(sword:state() == xi.itemState.EQUIPPED)
    end)

    it('food is InTransaction during cast then consumed', function()
        player:addItem(xi.item.MEAT_MITHKABOB)
        local kabob = player:findItem(xi.item.MEAT_MITHKABOB)
        assert(kabob)
        assert(kabob:state() == xi.itemState.FREE)

        player.actions:useItem(player, kabob:getSlotID(), xi.inventoryLocation.INVENTORY)

        local midUse = player:findItem(xi.item.MEAT_MITHKABOB)
        assert(midUse, 'item should still be in inventory mid-cast')
        assert(midUse:state() == xi.itemState.IN_TRANSACTION,
            'expected InTransaction during cast, got ' .. tostring(midUse:state()))

        xi.test.world:skipTime(5)

        player.assert
            :hasEffect(xi.effect.FOOD)
            .no:hasItem(xi.item.MEAT_MITHKABOB)
    end)

    it('using charged equipment keeps it in Equipped state', function()
        local ok = player:addUsedItem(xi.item.WARP_RING)
        assert(ok)
        local ring = player:findItem(xi.item.WARP_RING)
        assert(ring)

        player:equipItem(xi.item.WARP_RING, nil, xi.slot.RING1)
        assert(player:getEquippedItem(xi.slot.RING1))

        player.actions:useItem(player, ring:getSlotID(), xi.inventoryLocation.INVENTORY)

        local midUse = player:findItem(xi.item.WARP_RING)
        assert(midUse)
        assert(midUse:state() == xi.itemState.EQUIPPED)
    end)
end)
