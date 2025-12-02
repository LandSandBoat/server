describe('Soultrapper', function()
    ---@type CClientEntityPair
    local player
    ---@type CBaseEntity
    local euvhi
    local soultrapper

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            job = xi.job.SMN,
            level = 75,
            zone = xi.zone.ALTAIEU
        })

        -- Add equipment needed to take pictures
        player:addItem(xi.item.SOULTRAPPER_2000)
        player:addItem(xi.item.BLANK_SOUL_PLATE, 12)
        soultrapper = player:findItem(xi.item.SOULTRAPPER_2000)
        assert(soultrapper)

        -- Equip soultrapper and plates
        player:equipItem(xi.item.SOULTRAPPER_2000)
        player:equipItem(xi.item.BLANK_SOUL_PLATE)

        -- Force ZNM success to 100% for testing
        xi.znm.SOULTRAPPER_SUCCESS = 100

        -- Find a mob to take picture of
        euvhi = player.entities:moveTo('Aweuvhi')
    end)

    it('cant be used before timer reaches 0', function()
        player.actions:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)

        -- If we have a soul plate before the timer is up, the test fails
        player.assert.no:hasItem(xi.item.SOUL_PLATE)
    end)

    it('can be used when timer reaches 0', function()
        xi.test.world:skipTime(31)
        player.actions:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player)
        player.assert:hasItem(xi.item.SOUL_PLATE)
    end)

    it('cant be reused before cooldown reaches 0', function()
        -- Take first picture
        xi.test.world:skipTime(31)
        player.actions:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player)
        player.assert:hasItem(xi.item.SOUL_PLATE)
        player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY)

        -- Try to use again immediately
        player.actions:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player)
        player.assert.no:hasItem(xi.item.SOUL_PLATE)
    end)

    it('can be reused when cooldown reaches 0', function()
        -- Take first picture
        xi.test.world:skipTime(31)
        player.actions:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player)
        player.assert:hasItem(xi.item.SOUL_PLATE)
        player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY)

        -- Reuse after 30s
        xi.test.world:skipTime(30)
        player.actions:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player)
        player.assert:hasItem(xi.item.SOUL_PLATE)
    end)
end)
