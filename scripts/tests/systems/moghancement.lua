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
            player.actions:moveItem(xi.inv.INVENTORY, player:findItem(itemId, xi.inv.INVENTORY):getSlotID(), xi.inv.MOGSAFE, 1)
        end

        local box  = player:findItem(xi.item.ARMOR_BOX, xi.inv.MOGSAFE)
        local cask = player:findItem(xi.item.WATER_CASK, xi.inv.MOGSAFE)
        assert(box)
        assert(cask)

        -- Place cask first to prove "most recently placed furniture" tiebreaking isn't a thing.
        player.actions:placeFurniture(xi.inv.MOGSAFE, cask:getSlotID(), 0, 0)
        player.actions:placeFurniture(xi.inv.MOGSAFE, box:getSlotID(), 3, 0)
        player.actions:finishFurnishing()

        assert(player:hasKeyItem(xi.ki.MOGHANCEMENT_GARDENING), 'expected higher id (521) to win')
        assert(not player:hasKeyItem(xi.ki.MOGHANCEMENT_WATER), 'expected lower id (517) to not be granted')
    end)
end)
