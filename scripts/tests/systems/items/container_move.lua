local function findItemSlot(player, container, itemId)
    for i = 1, 30 do
        local item = player:getStorageItem(container, i, 255)
        if item and item:getID() == itemId then
            return i
        end
    end

    return nil
end

describe('Moving items between containers', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('a full stack can be moved to another container', function()
        player:changeContainerSize(xi.inv.MOGSATCHEL, 30)
        player:addItem(xi.item.FIRE_ARROW, 50)

        local srcSlot = findItemSlot(player, xi.inv.INVENTORY, xi.item.FIRE_ARROW)
        assert(srcSlot, 'could not find fire arrows')

        player.actions:moveItem(xi.inv.INVENTORY, srcSlot, xi.inv.MOGSATCHEL, 50)

        assert(findItemSlot(player, xi.inv.INVENTORY, xi.item.FIRE_ARROW) == nil,
            'item should no longer be in inventory')
        assert(findItemSlot(player, xi.inv.MOGSATCHEL, xi.item.FIRE_ARROW),
            'item should be in satchel')
    end)

    it('non-equipment is rejected from wardrobe', function()
        player:changeContainerSize(xi.inv.WARDROBE, 30)
        player:addItem(xi.item.FIRE_CRYSTAL)

        local srcSlot = findItemSlot(player, xi.inv.INVENTORY, xi.item.FIRE_CRYSTAL)
        assert(srcSlot)

        player.actions:moveItem(xi.inv.INVENTORY, srcSlot, xi.inv.WARDROBE, 1)

        assert(findItemSlot(player, xi.inv.INVENTORY, xi.item.FIRE_CRYSTAL),
            'item should still be in inventory')
        assert(findItemSlot(player, xi.inv.WARDROBE, xi.item.FIRE_CRYSTAL) == nil,
            'item should not be in wardrobe')
    end)

    it('sorting merges partial stacks into one', function()
        player:addItem(xi.item.FIRE_ARROW, 30)
        player:addItem(xi.item.FIRE_ARROW, 40)

        local slotsBefore = player:getFreeSlotsCount()

        player.actions:sortContainer(xi.inv.INVENTORY)

        assert(player:getFreeSlotsCount() == slotsBefore + 1,
            string.format('sort should merge stacks (freed %d slots)',
                player:getFreeSlotsCount() - slotsBefore))
    end)
end)
