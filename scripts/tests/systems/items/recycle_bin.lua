local function findItemSlot(player, container, itemId)
    for i = 1, 30 do
        local item = player:getStorageItem(container, i, 255)
        if item and item:getID() == itemId then
            return i
        end
    end

    return nil
end

describe('Recycle bin', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('dropping removes item from inventory', function()
        player:addItem(xi.item.BRONZE_SWORD)
        local slot = findItemSlot(player, xi.inv.INVENTORY, xi.item.BRONZE_SWORD)
        assert(slot)

        player.actions:dropItem(xi.inv.INVENTORY, slot, 1)

        assert(findItemSlot(player, xi.inv.INVENTORY, xi.item.BRONZE_SWORD) == nil,
            'item should no longer be in inventory')
    end)

    it('dropped item ends up in the bin', function()
        player:addItem(xi.item.BRONZE_SWORD)
        local slot = findItemSlot(player, xi.inv.INVENTORY, xi.item.BRONZE_SWORD)
        assert(slot)

        player.actions:dropItem(xi.inv.INVENTORY, slot, 1)

        local binItem = player:getStorageItem(xi.inv.RECYCLEBIN, 1, 255)
        assert(binItem and binItem:getID() == xi.item.BRONZE_SWORD,
            'item should be in recycle bin slot 1')
    end)

    it('11th drop evicts the oldest entry', function()
        for i = 1, 10 do
            player:addItem(xi.item.BRONZE_AXE)
            local slot = findItemSlot(player, xi.inv.INVENTORY, xi.item.BRONZE_AXE)
            assert(slot, 'failed to add filler ' .. i)
            player.actions:dropItem(xi.inv.INVENTORY, slot, 1)
        end

        local firstBefore = player:getStorageItem(xi.inv.RECYCLEBIN, 1, 255)
        assert(firstBefore and firstBefore:getID() == xi.item.BRONZE_AXE)

        player:addItem(xi.item.BRONZE_SWORD)
        local swordSlot = findItemSlot(player, xi.inv.INVENTORY, xi.item.BRONZE_SWORD)
        assert(swordSlot)
        player.actions:dropItem(xi.inv.INVENTORY, swordSlot, 1)

        local newest = player:getStorageItem(xi.inv.RECYCLEBIN, 10, 255)
        assert(newest and newest:getID() == xi.item.BRONZE_SWORD,
            'newest drop should be in slot 10')
    end)
end)
