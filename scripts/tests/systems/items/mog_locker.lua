describe('Mog Locker lease', function()
    ---@type CClientEntityPair
    local player

    local function moveCrystalToLocker()
        local slot = player:getItemInvSlot(xi.item.WIND_CRYSTAL, 1)
        assert(slot, 'wind crystal not in inventory')
        player.actions:moveItem(xi.inv.INVENTORY, slot, xi.inv.MOGLOCKER, 1)
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WINDURST_WOODS })
        if player:isInEvent() then
            player.events:finish()
        end

        player:gotoMogHouse(xi.zone.WINDURST_WOODS)
        if player:isInEvent() then
            player.events:finish()
        end

        -- the locker has no slots until it is rented
        player:changeContainerSize(xi.inv.MOGLOCKER, 30)
        player:setCharVar('mog-locker-access-type', 1)
        player:addItem(xi.item.WIND_CRYSTAL)
    end)

    it('allows the locker while the lease is running', function()
        player:setCharVar('mog-locker-expiry-timestamp', VanadielTime() + 3600)

        moveCrystalToLocker()

        assert(player:findItem(xi.item.WIND_CRYSTAL, xi.inv.MOGLOCKER), 'locker refused with a running lease')
    end)

    it('refuses the locker once the lease has lapsed', function()
        player:setCharVar('mog-locker-expiry-timestamp', -1)

        moveCrystalToLocker()

        assert(not player:findItem(xi.item.WIND_CRYSTAL, xi.inv.MOGLOCKER), 'locker accepted an item after the lease lapsed')
        assert(player:findItem(xi.item.WIND_CRYSTAL, xi.inv.INVENTORY), 'item left the inventory')
    end)
end)
