describe('Soultrapper', function()
    local client, player
    local euvhi
    local soultrapper

    before_each(function()
        client, player = xi.test.world:spawnPlayer({ zone = xi.zone.ALTAIEU })
        player:changeJob(xi.job.SMN)
        player:setLevel(75)

        -- Add equipment needed to take pictures
        player:addItem(xi.item.SOULTRAPPER_2000)
        player:addItem(xi.item.BLANK_SOUL_PLATE, 12)
        soultrapper = player:findItem(xi.item.SOULTRAPPER_2000)
        assert.is_not_nil(soultrapper)

        -- Equip soultrapper and plates
        player:equipItem(xi.item.SOULTRAPPER_2000)
        player:equipItem(xi.item.BLANK_SOUL_PLATE)

        -- Force ZNM success to 100% for testing
        print(xi.znm.SOULTRAPPER_SUCCESS)
        xi.znm.SOULTRAPPER_SUCCESS = 100

        -- Find a mob to take picture of
        euvhi = client:gotoEntity('Aweuvhi')
    end)

    -- Currently broken
    pending('cant be used before timer reaches 0', function()
        client:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tick()

        -- If we manage to delete a soul plate before the timer is up, the test fails
        assert.is_false(player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY))
    end)

    it('can be used when timer reaches 0', function()
        xi.test.world:skipTime(31)
        client:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player())
        assert.is_true(player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY))
    end)

    pending('cant be reused before cooldown reaches 0', function()
        -- Take first picture
        xi.test.world:skipTime(31)
        client:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player())
        assert.is_true(player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY))

        -- Try to use again immediately
        client:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player())
        assert.is_false(player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY))
    end)

    it('can be reused when cooldown reaches 0', function()
        -- Take first picture
        xi.test.world:skipTime(31)
        client:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player())
        assert.is_true(player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY))

        -- Reuse after 30s
        xi.test.world:skipTime(30)
        client:useItem(euvhi, soultrapper:getSlotID())
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player())
        assert.is_true(player:delItem(xi.item.SOUL_PLATE, 1, xi.inv.INVENTORY))
    end)
end)
