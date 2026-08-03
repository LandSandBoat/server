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

    it('swapping the main weapon keeps a dual-wield offhand', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.NIN, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.KUNAI)
        player:addItem(xi.item.WAKIZASHI)
        player:addItem(xi.item.BRONZE_KNIFE)
        player:equipItem(xi.item.KUNAI, nil, xi.slot.MAIN)
        player:equipItem(xi.item.BRONZE_KNIFE, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.SUB), 'offhand not equipped')

        player:equipItem(xi.item.WAKIZASHI, nil, xi.slot.MAIN) -- one-handed -> one-handed swap

        assert(player:getEquippedItem(xi.slot.MAIN):getID() == xi.item.WAKIZASHI, 'main did not swap')
        assert(player:getEquippedItem(xi.slot.SUB), 'offhand wrongly removed on a main swap')
        assert(player:getEquippedItem(xi.slot.SUB):getID() == xi.item.BRONZE_KNIFE, 'offhand changed')
    end)

    it('switching from a two-handed weapon with a grip to a one-handed weapon drops the grip', function()
        player:addItem(xi.item.GREATSWORD)
        player:addItem(xi.item.POLE_GRIP)
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.GREATSWORD, nil, xi.slot.MAIN)
        player:equipItem(xi.item.POLE_GRIP, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.SUB):getID() == xi.item.POLE_GRIP, 'grip not equipped')

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN) -- two-handed -> one-handed

        assert(player:getEquippedItem(xi.slot.MAIN):getID() == xi.item.BRONZE_SWORD, 'main did not swap')
        assert(player:getEquippedItem(xi.slot.SUB) == nil, 'grip should drop on a one-handed main')
    end)

    it('unequipping the main weapon entirely drops the dual-wield offhand', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.NIN, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.KUNAI)
        player:addItem(xi.item.BRONZE_KNIFE)
        player:equipItem(xi.item.KUNAI, nil, xi.slot.MAIN)
        player:equipItem(xi.item.BRONZE_KNIFE, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.SUB), 'offhand not equipped')

        player.actions:equipSet({ { index = 0, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })

        assert(player:getEquippedItem(xi.slot.MAIN) == nil, 'main still equipped')
        assert(player:getEquippedItem(xi.slot.SUB) == nil, 'offhand should drop when the main is removed entirely')
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

    it('equipped ammo stack decrements on use', function()
        player:addItem(xi.item.FIRE_ARROW, 50)
        player:equipItem(xi.item.FIRE_ARROW, nil, xi.slot.AMMO)

        player:delItem(xi.item.FIRE_ARROW, 1)

        local ammo = player:getEquippedItem(xi.slot.AMMO)
        assert(ammo)
        assert(ammo:getQuantity() == 49)
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
