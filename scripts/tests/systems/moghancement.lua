describe('Moghancement', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WINDURST_WOODS })

        if player:isInEvent() then
            player.events:finish()
        end

        player:gotoMogHouse(xi.zone.WINDURST_WOODS)
    end)

    it('breaks an aura tie by highest moghancement id', function()
        -- Both Water/aura 2: Armor Box gives Water (517), Water Cask gives Gardening (521).
        for _, itemId in ipairs({ xi.item.ARMOR_BOX, xi.item.WATER_CASK }) do
            player:addItem(itemId)
            player.actions:moveItem(xi.inv.INVENTORY, player:findItem(itemId, xi.inv.INVENTORY):getSlotID(), xi.inv.MOG_SAFE, 1)
        end

        local box  = player:findItem(xi.item.ARMOR_BOX, xi.inv.MOG_SAFE)
        local cask = player:findItem(xi.item.WATER_CASK, xi.inv.MOG_SAFE)
        assert(box)
        assert(cask)

        -- Place cask first to prove "most recently placed furniture" tiebreaking isn't a thing.
        player.actions:placeFurniture(xi.inv.MOG_SAFE, cask:getSlotID(), 0, 0)
        player.actions:placeFurniture(xi.inv.MOG_SAFE, box:getSlotID(), 3, 0)
        player.actions:finishFurnishing()

        assert(player:hasKeyItem(xi.keyItem.MOGHANCEMENT_GARDENING), 'expected higher id (521) to win')
        assert(not player:hasKeyItem(xi.keyItem.MOGHANCEMENT_WATER), 'expected lower id (517) to not be granted')
    end)

    local certificates =
    {
        { 'San d\'Orian', xi.item.SAN_DORIAN_MARRIAGE_CERTIFICATE },
        { 'Bastokan', xi.item.BASTOKAN_MARRIAGE_CERTIFICATE },
        { 'Windurstian', xi.item.WINDURSTIAN_MARRIAGE_CERTIFICATE },
    }

    for _, certificate in ipairs(certificates) do
        it('grants Moghancement: Money when the ' .. certificate[1] .. ' marriage certificate is hung', function()
            local itemId   = certificate[2]
            local gilBonus = xi.mod.MOGHANCEMENT_GIL_BONUS_P
            local money    = xi.keyItem.MOGHANCEMENT_MONEY
            assert(not player:hasKeyItem(money))
            assert(player:getMod(gilBonus) == 0)

            player:addItem(itemId)
            local inInventory = assert(player:findItem(itemId, xi.inv.INVENTORY))
            player.actions:moveItem(xi.inv.INVENTORY, inInventory:getSlotID(), xi.inv.MOGSAFE, 1)
            local inSafe = assert(player:findItem(itemId, xi.inv.MOGSAFE))

            player.actions:placeFurniture(xi.inv.MOGSAFE, inSafe:getSlotID(), 0, 0)
            player.actions:finishFurnishing()

            assert(inSafe:isInstalled(), 'the certificate was not installed')
            assert(player:hasKeyItem(money), 'the certificate did not grant Moghancement: Money')
            assert(player:getMod(gilBonus) == 10, 'the Money gil bonus was not applied')
        end)
    end
end)
