describe('npcUtil.giveItem()', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            job = xi.job.SMN,
            level = 75,
        })

        -- Add filler to the inventory
        player:addItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 80)
    end)

    it('item table with single item', function()
        assert(
            npcUtil.giveItem(player, { xi.item.SHURIKEN }) == false,
            'Should fail to give a single item'
        )

        player:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)

        assert(
            npcUtil.giveItem(player, { xi.item.SHURIKEN }) == true,
            'Should give a single item'
        )

        player.assert:hasItem(xi.item.SHURIKEN)
    end)

    it('item table with sub table', function()
        assert(
            npcUtil.giveItem(player, { { xi.item.SHURIKEN, 2 } }) == false,
            'Should fail to give a stack'
        )

        player:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)

        assert(
            npcUtil.giveItem(player, { { xi.item.SHURIKEN, 2 } }) == true,
            'Should give a stack'
        )

        player.assert:hasItem(xi.item.SHURIKEN)

        -- check that player has the right quantities
        player:delItem(xi.item.SHURIKEN, 1)
        player.assert:hasItem(xi.item.SHURIKEN)
        player:delItem(xi.item.SHURIKEN, 1)
        player.assert.no:hasItem(xi.item.SHURIKEN)
    end)

    it('item table with multiple items', function()
        for _ = 1, 2 do
            assert(
                npcUtil.giveItem(player, { xi.item.SHURIKEN, xi.item.JUJI_SHURIKEN }) == false,
                'Should fail to give items'
            )

            player:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)
        end

        player.assert.no:hasItem(xi.item.SHURIKEN)
        player.assert.no:hasItem(xi.item.JUJI_SHURIKEN)
        assert(
            player:getFreeSlotsCount() == 2,
            'player should have 2 open inventory slots'
        )

        assert(
            npcUtil.giveItem(player, { xi.item.SHURIKEN, xi.item.JUJI_SHURIKEN }) == true,
            'Should give both items'
        )

        player.assert
            :hasItem(xi.item.SHURIKEN)
            :hasItem(xi.item.JUJI_SHURIKEN)

        -- check that player has the right quantities
        player:delItem(xi.item.SHURIKEN, 1)
        player.assert.no:hasItem(xi.item.SHURIKEN)

        player:delItem(xi.item.JUJI_SHURIKEN, 1)
        player.assert.no:hasItem(xi.item.JUJI_SHURIKEN)
    end)

    it('item table with multiple sub tables/quantities', function()
        for _ = 1, 2 do
            assert(
                npcUtil.giveItem(player, { { xi.item.SHURIKEN, 1 }, { xi.item.JUJI_SHURIKEN, 2 } }) == false,
                'Should fail to give items'
            )

            player:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)
        end

        player.assert.no:hasItem(xi.item.SHURIKEN)
        player.assert.no:hasItem(xi.item.JUJI_SHURIKEN)
        assert(
            player:getFreeSlotsCount() == 2,
            'player should have 2 open inventory slots'
        )

        assert(
            npcUtil.giveItem(player, { { xi.item.SHURIKEN, 1 }, { xi.item.JUJI_SHURIKEN, 2 } }) == true,
            'Should give both items'
        )

        player.assert
            :hasItem(xi.item.SHURIKEN)
            :hasItem(xi.item.JUJI_SHURIKEN)

        -- check that player has the right quantities
        player:delItem(xi.item.SHURIKEN, 1)
        player.assert.no:hasItem(xi.item.SHURIKEN)

        player:delItem(xi.item.JUJI_SHURIKEN, 1)
        player.assert:hasItem(xi.item.JUJI_SHURIKEN)
        player:delItem(xi.item.JUJI_SHURIKEN, 1)
        player.assert.no:hasItem(xi.item.JUJI_SHURIKEN)
    end)
end)
