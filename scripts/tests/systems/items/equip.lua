describe('Equipment', function()
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

    it('equips a weapon to main hand', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)

        local weapon = player:getEquippedItem(xi.slot.MAIN)
        assert(weapon)
        assert(weapon:getID() == xi.item.BRONZE_SWORD)
    end)

    it('unequip empties the slot', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN))

        player:unequipItem(xi.slot.MAIN)

        assert(player:getEquippedItem(xi.slot.MAIN) == nil)
    end)

    it('swapping weapons replaces the previous one', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.BRONZE_AXE)

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN):getID() == xi.item.BRONZE_SWORD)

        player:equipItem(xi.item.BRONZE_AXE, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN):getID() == xi.item.BRONZE_AXE)
    end)

    it('cannot equip an item you do not own', function()
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN) == nil)
    end)

    it('cannot put a sword on your feet', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.FEET)
        assert(player:getEquippedItem(xi.slot.FEET) == nil)
    end)

    it('two-handed weapon clears the sub slot', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.LAUAN_SHIELD)
        player:addItem(xi.item.GREATSWORD)

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        player:equipItem(xi.item.LAUAN_SHIELD, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.SUB))

        player:equipItem(xi.item.GREATSWORD, nil, xi.slot.MAIN)

        assert(player:getEquippedItem(xi.slot.MAIN):getID() == xi.item.GREATSWORD)
        assert(player:getEquippedItem(xi.slot.SUB) == nil)
    end)

    it('equipping the same item again is a no-op', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        local first = player:getEquippedItem(xi.slot.MAIN)

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)

        assert(player:getEquippedItem(xi.slot.MAIN) == first)
    end)

    it('changing job unequips gear that does not match', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN))

        player:changeJob(xi.job.BLM)

        assert(player:getEquippedItem(xi.slot.MAIN) == nil)
    end)

    it('all visible armor slots accept their piece', function()
        local pieces =
        {
            { id = xi.item.BRONZE_CAP,      slot = xi.slot.HEAD },
            { id = xi.item.BRONZE_HARNESS,  slot = xi.slot.BODY },
            { id = xi.item.BRONZE_MITTENS,  slot = xi.slot.HANDS },
            { id = xi.item.BRONZE_SUBLIGAR, slot = xi.slot.LEGS },
            { id = xi.item.BRONZE_LEGGINGS, slot = xi.slot.FEET },
        }

        for _, piece in ipairs(pieces) do
            player:addItem(piece.id)
            player:equipItem(piece.id, nil, piece.slot)
            local equipped = player:getEquippedItem(piece.slot)
            assert(equipped, string.format('slot %d empty', piece.slot))
            assert(equipped:getID() == piece.id,
                string.format('slot %d has wrong item: %d', piece.slot, equipped:getID()))
        end
    end)
end)
