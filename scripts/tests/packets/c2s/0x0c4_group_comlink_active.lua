describe('Linkshell equip', function()
    ---@type CClientEntityPair
    local player
    local lsName = 'TestLinkshell'
    local lsId
    local shellSlot
    local pearlSlot

    local function linkSlotItemId(slot)
        local item = player:getStorageItem(xi.inventoryLocation.INVENTORY, 0, slot)
        return item and item:getID() or 0
    end

    before_each(function()
        player = xi.test.world:spawnPlayer()

        player:addItem(xi.item.NEW_LINKSHELL)
        shellSlot = assert(player:getItemInvSlot(xi.item.NEW_LINKSHELL, 1))
        player.actions:linkshellActive(shellSlot, 1, true, lsName)
        assert(player:getStorageItem(xi.inventoryLocation.INVENTORY, shellSlot, 255):getID() == xi.item.LINKSHELL, 'linkshell was not created')

        assert(player:addLinkpearl(lsName, false), 'linkpearl was not added')
        pearlSlot = assert(player:getItemInvSlot(xi.item.LINKPEARL, 1))

        player.actions:linkshellActive(pearlSlot, 1, true)
        lsId = player:getLinkshellId(1)
        assert(lsId ~= 0, 'linkpearl did not join the linkshell')
        assert(linkSlotItemId(xi.slot.LINK1) == xi.item.LINKPEARL, 'linkpearl not equipped')
    end)

    after_each(function()
        player.actions:linkshellActive(pearlSlot, 1, false)
        player.actions:dropItem(xi.inventoryLocation.INVENTORY, shellSlot, 1)
    end)

    it('keeps membership when an equipped pearl is equipped again', function()
        player.actions:linkshellActive(pearlSlot, 1, true)

        assert(player:getLinkshellId(1) == lsId, 'dropped from the linkshell')
        assert(linkSlotItemId(xi.slot.LINK1) == xi.item.LINKPEARL, 'linkpearl no longer equipped')
    end)

    it('keeps membership when an equipped pearl is equipped in the other slot', function()
        player.actions:linkshellActive(pearlSlot, 2, true)

        assert(player:getLinkshellId(1) == lsId, 'dropped from the linkshell')
        assert(player:getLinkshellId(2) == 0, 'joined a second slot')
        assert(linkSlotItemId(xi.slot.LINK2) == 0, 'linkpearl bound to a second slot')
    end)

    it('ignores an unequip for an item that is not in the slot', function()
        player.actions:linkshellActive(shellSlot, 1, false)

        assert(player:getLinkshellId(1) == lsId, 'dropped from the linkshell')
        assert(linkSlotItemId(xi.slot.LINK1) == xi.item.LINKPEARL, 'linkpearl no longer equipped')
    end)

    it('unequips the pearl in the slot', function()
        player.actions:linkshellActive(pearlSlot, 1, false)

        assert(player:getLinkshellId(1) == 0, 'still in the linkshell')
        assert(linkSlotItemId(xi.slot.LINK1) == 0, 'linkpearl still equipped')
    end)
end)
