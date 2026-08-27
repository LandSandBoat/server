-- Invariants every item transaction has to hold, whichever path it takes:
-- nothing is created or destroyed, and no stack stays claimed after the operation closes.
describe('Item transaction invariants', function()
    ---@type CClientEntityPair
    local player

    local stackable = xi.item.FIRE_CRYSTAL
    local stackSize = 12

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
    end)

    local function totalHeld(itemId)
        return player:getItemCount(itemId)
    end

    local function slotOf(itemId)
        local item = player:findItem(itemId, xi.inventoryLocation.INVENTORY)

        assert(item, 'expected to be holding item ' .. tostring(itemId))

        return item:getSlotID()
    end

    -- every matching stack, since these operations leave more than one behind
    local function assertAllFree(itemId)
        for slot = 1, 80 do
            local item = player:getStorageItem(0, slot, 255)

            if item and item:getID() == itemId then
                assert(item:state() == xi.itemState.FREE, 'slot ' .. tostring(slot) .. ' left claimed, state: ' .. tostring(item:state()))
            end
        end
    end

    describe('splitting and merging', function()
        it('keeps the total when a stack is split', function()
            player:addItem(stackable, stackSize)

            local slot = slotOf(stackable)

            player.actions:moveItem(xi.inventoryLocation.INVENTORY, slot, xi.inventoryLocation.INVENTORY, 5)

            assert(totalHeld(stackable) == stackSize, 'total after split: ' .. tostring(totalHeld(stackable)))
            assertAllFree(stackable)
        end)

        it('keeps the total when the halves are merged back', function()
            player:addItem(stackable, stackSize)

            local slot = slotOf(stackable)

            player.actions:moveItem(xi.inventoryLocation.INVENTORY, slot, xi.inventoryLocation.INVENTORY, 5)

            local split = nil

            for candidate = 1, 80 do
                local item = player:getStorageItem(0, candidate, 255)

                if item and item:getID() == stackable and candidate ~= slot then
                    split = candidate
                    break
                end
            end

            assert(split, 'the split half was never created')

            player.actions:moveItem(xi.inventoryLocation.INVENTORY, split, xi.inventoryLocation.INVENTORY, 5, slot)

            assert(totalHeld(stackable) == stackSize, 'total after merge: ' .. tostring(totalHeld(stackable)))
            assertAllFree(stackable)
        end)

        -- The add is clamped at the stack limit, so a merge that does not fit must leave the remainder behind rather than swallowing it
        it('keeps the total when a merge does not fit', function()
            player:addItem(stackable, stackSize)
            player:addItem(stackable, 5)

            local full = nil
            local part = nil

            for candidate = 1, 80 do
                local item = player:getStorageItem(0, candidate, 255)

                if item and item:getID() == stackable then
                    if item:getQuantity() == stackSize then
                        full = candidate
                    else
                        part = candidate
                    end
                end
            end

            assert(full and part, 'expected a full stack and a partial one')

            player.actions:moveItem(xi.inventoryLocation.INVENTORY, part, xi.inventoryLocation.INVENTORY, 5, full)

            assert(totalHeld(stackable) == stackSize + 5, 'total after a merge that does not fit: ' .. tostring(totalHeld(stackable)))
            assertAllFree(stackable)
        end)

        it('keeps the total when a container is sorted', function()
            player:addItem(stackable, 4)
            player:addItem(stackable, 4)
            player:addItem(stackable, 4)

            player.actions:sortContainer(xi.inventoryLocation.INVENTORY)

            assert(totalHeld(stackable) == 12, 'total after sort: ' .. tostring(totalHeld(stackable)))
            assertAllFree(stackable)
        end)
    end)

    describe('gil', function()
        it('is unchanged when a stack is split', function()
            local before = player:getGil()

            player:addItem(stackable, stackSize)

            local slot = slotOf(stackable)

            player.actions:moveItem(xi.inventoryLocation.INVENTORY, slot, xi.inventoryLocation.INVENTORY, 5)

            assert(player:getGil() == before, 'gil moved during an item-only operation')
        end)

        -- pay() claims the gil stack, and a refusal has to leave the balance exactly as it was
        it('is unchanged when more is spent than is held', function()
            player:setGil(100)

            assert(not player:delGil(500), 'spending more gil than held reported success')
            assert(player:getGil() == 100, 'gil after a refused payment: ' .. tostring(player:getGil()))
        end)

        it('is unchanged when a payment is refused after a partial spend', function()
            player:setGil(100)

            assert(player:delGil(60), 'the first payment was refused')
            assert(not player:delGil(60), 'the second payment should not have fit')
            assert(player:getGil() == 40, 'gil after one payment: ' .. tostring(player:getGil()))
        end)
    end)

    describe('claims', function()
        -- Equipped gear is busy, which is what stops it being traded, sold or bazaared out from under the character wearing it
        it('marks equipped gear busy and frees it again', function()
            player:addItem(xi.item.BRONZE_AXE)

            local axe = player:findItem(xi.item.BRONZE_AXE, xi.inventoryLocation.INVENTORY)

            assert(axe, 'the axe was not added')

            player:equipItem(xi.item.BRONZE_AXE, xi.inventoryLocation.INVENTORY, xi.slot.MAIN)

            assert(player:getEquipID(xi.slot.MAIN) == xi.item.BRONZE_AXE, 'the axe was not equipped')
            assert(axe:state() == xi.itemState.EQUIPPED, 'equipped state: ' .. tostring(axe:state()))

            player:unequipItem(xi.slot.MAIN)

            assert(axe:state() == xi.itemState.FREE, 'state after unequip: ' .. tostring(axe:state()))
        end)

        -- dropping moves the stack to the recycle bin, and it has to arrive there unclaimed
        it('leaves a dropped stack Free in the recycle bin', function()
            player:addItem(stackable, 2)

            local slot = slotOf(stackable)

            player.actions:dropItem(xi.inventoryLocation.INVENTORY, slot, 2)

            assert(not player:findItem(stackable, xi.inventoryLocation.INVENTORY), 'the stack stayed in inventory')

            local binned = player:findItem(stackable, xi.inventoryLocation.RECYCLEBIN)

            assert(binned, 'the stack reached neither inventory nor the recycle bin')
            assert(binned:state() == xi.itemState.FREE, 'binned state: ' .. tostring(binned:state()))
        end)

        -- character creation runs from the login sequence, and the gil it claims has to come back Free
        it('leaves gil usable after character creation', function()
            local newPlayer = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME, new = true })
            local gilBefore = newPlayer:getGil()

            newPlayer:addGil(50)

            assert(newPlayer:getGil() == gilBefore + 50, 'gil after creation: ' .. tostring(newPlayer:getGil()))
        end)
    end)
end)
