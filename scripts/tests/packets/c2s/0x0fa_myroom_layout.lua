describe('Furniture layout', function()
    ---@type CClientEntityPair
    local player

    local function stockSafe(itemId)
        player:addItem(itemId)
        player.actions:moveItem(xi.inv.INVENTORY, player:findItem(itemId, xi.inv.INVENTORY):getSlotID(), xi.inv.MOGSAFE, 1)

        return player:findItem(itemId, xi.inv.MOGSAFE)
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BASTOK_MARKETS })
        if player:isInEvent() then
            player.events:finish()
        end

        player:gotoMogHouse(xi.zone.BASTOK_MINES)
        if player:isInEvent() then
            player.events:finish()
        end
    end)

    it('moves a table carrying a gardening pot', function()
        local mapleTable = stockSafe(xi.item.MAPLE_TABLE)
        local pot        = stockSafe(xi.item.EARTHEN_FLOWERPOT)

        player.actions:placeFurniture(xi.inv.MOGSAFE, mapleTable:getSlotID(), 0, 0)
        player.actions:placeFurniture(xi.inv.MOGSAFE, pot:getSlotID(), 1, 1, 10)
        player.actions:finishFurnishing()

        -- the client sends stacked items before their parent when moving it
        player.actions:placeFurniture(xi.inv.MOGSAFE, pot:getSlotID(), 1, 3, 10)
        player.actions:placeFurniture(xi.inv.MOGSAFE, mapleTable:getSlotID(), 0, 2)
        player.actions:finishFurnishing()

        assert(player:findItem(xi.item.MAPLE_TABLE, xi.inv.MOGSAFE):getExData().y == 2, 'table did not move')
    end)
end)
