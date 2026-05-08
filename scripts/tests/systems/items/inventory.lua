describe('Inventory', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('can receive a single item', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player.assert:hasItem(xi.item.BRONZE_SWORD)
    end)

    it('overflowing a stack spills into a second slot', function()
        local before = player:getFreeSlotsCount()
        player:addItem(xi.item.FIRE_ARROW, 150)
        local after = player:getFreeSlotsCount()

        player.assert:hasItem(xi.item.FIRE_ARROW)
        assert(before - after == 2,
            string.format('expected 2 slots consumed, saw %d', before - after))
    end)

    it('rejects items when full', function()
        while player:getFreeSlotsCount() > 0 do
            player:addItem(xi.item.BRONZE_SWORD)
        end

        assert(player:getFreeSlotsCount() == 0, 'inventory should be full')

        player:addItem(xi.item.SHURIKEN)
        player.assert.no:hasItem(xi.item.SHURIKEN)
    end)

    it('cannot hold two copies of a Rare item', function()
        player:addItem(xi.item.ADVENTURER_COUPON)
        player.assert:hasItem(xi.item.ADVENTURER_COUPON)
        local before = player:getFreeSlotsCount()

        player:addItem(xi.item.ADVENTURER_COUPON)

        assert(player:getFreeSlotsCount() == before, 'rare dup should not consume a slot')
    end)

    it('removing an entire stack frees the slot', function()
        player:addItem(xi.item.FIRE_ARROW, 5)
        player.assert:hasItem(xi.item.FIRE_ARROW)
        local withItem = player:getFreeSlotsCount()

        player:delItem(xi.item.FIRE_ARROW, 5)

        player.assert.no:hasItem(xi.item.FIRE_ARROW)
        assert(player:getFreeSlotsCount() == withItem + 1)
    end)

    it('partial removal keeps the slot occupied', function()
        player:addItem(xi.item.FIRE_ARROW, 10)
        local before = player:getFreeSlotsCount()

        player:delItem(xi.item.FIRE_ARROW, 3)

        player.assert:hasItem(xi.item.FIRE_ARROW)
        assert(player:getFreeSlotsCount() == before)
    end)

    it('gil goes straight to the currency slot', function()
        local startGil = player:getGil()
        local before = player:getFreeSlotsCount()

        player:addItem(xi.item.GIL, 1000)

        assert(player:getGil() == startGil + 1000,
            string.format('expected %d gil, saw %d', startGil + 1000, player:getGil()))
        assert(player:getFreeSlotsCount() == before)
    end)

    it('table-form add returns a usable item handle', function()
        local item = player:addItem({ id = xi.item.FIRE_ARROW, quantity = 5 })
        assert(item ~= nil)
        assert(item:getID() == xi.item.FIRE_ARROW)
        assert(item:getQuantity() == 5)
    end)

    it('signatures survive the add path', function()
        local item = player:addItem({ id = xi.item.BRONZE_SWORD, signature = 'TestSig' })
        assert(item ~= nil)
        assert(item:getSignature() == 'TestSig',
            string.format('expected TestSig, got %s', item:getSignature()))
    end)

    it('cannot remove more than the owned quantity', function()
        player:addItem(xi.item.FIRE_ARROW, 5)
        local before = player:getFreeSlotsCount()

        player:delItem(xi.item.FIRE_ARROW, 100)

        player.assert:hasItem(xi.item.FIRE_ARROW)
        assert(player:getFreeSlotsCount() == before)
    end)

    it('charged equipment can be added with worn state', function()
        local ok = player:addUsedItem(xi.item.WARP_RING)
        assert(ok)
        player.assert:hasItem(xi.item.WARP_RING)
    end)

    it('linkpearl for a missing linkshell is cleaned up', function()
        local before = player:getFreeSlotsCount()

        assert(player:addLinkpearl('NonexistentLinkshellName', false) == false)
        assert(player:getFreeSlotsCount() == before)
    end)
end)
