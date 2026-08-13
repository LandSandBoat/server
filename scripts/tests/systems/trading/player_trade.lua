describe('PlayerTradeTransaction', function()
    ---@type CClientEntityPair
    local p1
    ---@type CClientEntityPair
    local p2

    local itemA = xi.item.WIND_CRYSTAL
    local itemB = xi.item.FIRE_CRYSTAL

    local function openTrade()
        p1.actions:tradeRequest(p2)
        p2.actions:tradeAccept()
    end

    local function findItem(player, itemId, location)
        local item = player:findItem(itemId, location)
        assert(item, 'item ' .. tostring(itemId) .. ' not in inventory')

        return item
    end

    local function totalOf(itemId)
        return p1:getItemCount(itemId) + p2:getItemCount(itemId)
    end

    before_each(function()
        p1 = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        p2 = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })

        -- Same position so the 6y range check passes.
        p2:setPos(p1:getXPos(), p1:getYPos(), p1:getZPos())
    end)

    it('staged items are InTransaction while the offer is open', function()
        p1:addItem(itemA)
        openTrade()

        local item = findItem(p1, itemA)
        assert(item:state() == xi.itemState.FREE, 'state before staging: ' .. tostring(item:state()))

        p1.actions:tradeOffer(1, item:getSlotID(), itemA, 1)

        local staged = findItem(p1, itemA)
        assert(staged:state() == xi.itemState.IN_TRANSACTION, 'state after staging: ' .. tostring(staged:state()))
    end)

    it('a staged item cannot be equipped', function()
        local gear = xi.item.BRONZE_DAGGER

        p1:addItem(gear)
        openTrade()

        local gearSlot = findItem(p1, gear):getSlotID()

        p1.actions:tradeOffer(1, gearSlot, gear, 1)

        p1.actions:equipSet({ { index = gearSlot, kind = xi.slot.MAIN, container = 0 } })

        assert(p1:getEquipID(xi.slot.MAIN) ~= gear, 'staged item was equipped')
        assert(findItem(p1, gear):state() == xi.itemState.IN_TRANSACTION, 'state after equip attempt: ' .. tostring(findItem(p1, gear):state()))

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        p1.assert.no:hasItem(gear)
        p2.assert:hasItem(gear)
    end)

    it('a received item is usable afterwards', function()
        local gear = xi.item.BRONZE_DAGGER

        p1:addItem(gear)
        openTrade()

        p1.actions:tradeOffer(1, findItem(p1, gear):getSlotID(), gear, 1)
        p1.actions:tradeMake()
        p2.actions:tradeMake()

        local received = findItem(p2, gear)
        assert(received:state() == xi.itemState.FREE, 'received state: ' .. tostring(received:state()))
        assert(received:getReservedValue() == 0, 'received reserve: ' .. tostring(received:getReservedValue()))
    end)

    it('an item reserved elsewhere cannot be staged', function()
        local gear = xi.item.BRONZE_DAGGER

        p1:addItem(gear)

        local item = findItem(p1, gear)
        local slot = item:getSlotID()

        -- Reproduce a pending NPC trade
        item:setReservedValue(1)

        openTrade()
        p1.actions:tradeOffer(1, slot, gear, 1)
        p1.actions:tradeMake()
        p2.actions:tradeMake()

        assert(totalOf(gear) == 1, 'copies in play: ' .. tostring(totalOf(gear)))
    end)

    it('sorting skips staged stacks on either side of a merge', function()
        p1:addItem(itemA, 5)
        p1:addItem(itemA, 5)

        local lowerSlot = findItem(p1, itemA):getSlotID()

        openTrade()
        p1.actions:tradeOffer(1, lowerSlot, itemA, 5)
        p1.actions:sortContainer(xi.inventoryLocation.INVENTORY)

        assert(totalOf(itemA) == 10, 'merge destination: ' .. tostring(totalOf(itemA)))

        p1.actions:tradeClearSlot(1, lowerSlot, itemA)
        p1.actions:tradeOffer(1, lowerSlot + 1, itemA, 5)
        p1.actions:sortContainer(xi.inventoryLocation.INVENTORY)

        assert(totalOf(itemA) == 10, 'merge source: ' .. tostring(totalOf(itemA)))
    end)

    it('a repeated Start does not disturb the open trade', function()
        p1:addItem(itemA)
        p2:addItem(itemA)

        openTrade()

        p1.actions:tradeOffer(1, findItem(p1, itemA):getSlotID(), itemA, 1)
        p2.actions:tradeOffer(1, findItem(p2, itemA):getSlotID(), itemA, 1)

        p2.actions:tradeAccept()

        p1.actions:tradeCancel()
        p2.actions:tradeCancel()

        local i1 = findItem(p1, itemA)
        local i2 = findItem(p2, itemA)
        assert(i1:state() == xi.itemState.FREE, 'p1 item state: ' .. tostring(i1:state()))
        assert(i2:state() == xi.itemState.FREE, 'p2 item state: ' .. tostring(i2:state()))
    end)

    it('gil only stages in slot 0 and items only in slots 1-8', function()
        p1:setGil(5000)
        p1:addItem(itemA)

        openTrade()

        p1.actions:tradeOffer(1, 0, xi.item.GIL, 1000)
        p1.actions:tradeOffer(0, findItem(p1, itemA):getSlotID(), itemA, 1)

        assert(findItem(p1, itemA):state() == xi.itemState.FREE, 'item state: ' .. tostring(findItem(p1, itemA):state()))

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        assert(p1:getGil() == 5000, 'p1 gil: ' .. tostring(p1:getGil()))
        p1.assert:hasItem(itemA)
        p2.assert.no:hasItem(itemA)
    end)

    it('a rare the partner already owns cannot be staged', function()
        local rare = xi.item.MANNEQUIN_HANDS

        p1:addItem(rare)
        p2:addItem(rare)

        openTrade()
        p1.actions:tradeOffer(1, findItem(p1, rare):getSlotID(), rare, 1)

        assert(findItem(p1, rare):state() == xi.itemState.FREE, 'rare state: ' .. tostring(findItem(p1, rare):state()))

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        assert(totalOf(rare) == 2, 'copies in play: ' .. tostring(totalOf(rare)))
    end)

    it('gil needs a free slot on the receiving side', function()
        p1:setGil(5000)
        p2:setGil(0)

        while p2:getFreeSlotsCount(xi.inventoryLocation.INVENTORY) > 0 do
            p2:addItem(itemA)
        end

        openTrade()
        p1.actions:tradeOffer(0, 0, xi.item.GIL, 1000)
        p1.actions:tradeMake()
        p2.actions:tradeMake()

        assert(p1:getGil() == 5000, 'p1 gil: ' .. tostring(p1:getGil()))
        assert(p2:getGil() == 0, 'p2 gil: ' .. tostring(p2:getGil()))
    end)

    it('cancelling before Make returns the item to its slot', function()
        p1:addItem(itemA)
        openTrade()

        local origSlot = findItem(p1, itemA):getSlotID()

        p1.actions:tradeOffer(1, origSlot, itemA, 1)
        p1.actions:tradeCancel()

        local restored = findItem(p1, itemA, xi.inventoryLocation.INVENTORY)
        assert(restored:getSlotID() == origSlot, 'came back in slot ' .. tostring(restored:getSlotID()))
        assert(restored:state() == xi.itemState.FREE, 'state after cancel: ' .. tostring(restored:state()))
    end)

    it('both sides offer and Make swaps the items', function()
        p1:addItem(itemA)
        p2:addItem(itemB)

        openTrade()

        local p1Item = findItem(p1, itemA)
        local p2Item = findItem(p2, itemB)
        assert(p1Item and p2Item, 'expected both items present')

        p1.actions:tradeOffer(1, p1Item:getSlotID(), itemA, 1)
        p2.actions:tradeOffer(1, p2Item:getSlotID(), itemB, 1)

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        p1.assert.no:hasItem(itemA)
        p2.assert.no:hasItem(itemB)
        p1.assert:hasItem(itemB)
        p2.assert:hasItem(itemA)
    end)

    it('any offer change after Make invalidates acceptance', function()
        p1:addItem(itemA)
        p2:addItem(itemB)

        openTrade()

        p1.actions:tradeOffer(1, findItem(p1, itemA):getSlotID(), itemA, 1)
        p2.actions:tradeOffer(1, findItem(p2, itemB):getSlotID(), itemB, 1)

        p1.actions:tradeMake()
        p1.actions:tradeClearSlot(1, findItem(p1, itemA):getSlotID(), itemA)

        -- p2 hitting Make alone must not commit, p1's Make was cleared.
        p2.actions:tradeMake()

        p1.assert:hasItem(itemA)
        p2.assert:hasItem(itemB)
    end)

    it('clearSlot returns the item to Free state', function()
        p1:addItem(itemA)
        openTrade()

        local invItem = findItem(p1, itemA)
        p1.actions:tradeOffer(1, invItem:getSlotID(), itemA, 1)
        assert(findItem(p1, itemA):state() == xi.itemState.IN_TRANSACTION)

        p1.actions:tradeClearSlot(1, invItem:getSlotID(), itemA)

        local restored = findItem(p1, itemA)
        assert(restored:state() == xi.itemState.FREE, 'state after clear: ' .. tostring(restored:state()))
    end)

    it('the same slot can be re-staged with a different quantity', function()
        p1:addItem(itemA, 3)

        openTrade()

        local invItem = findItem(p1, itemA)
        p1.actions:tradeOffer(1, invItem:getSlotID(), itemA, 1)
        p1.actions:tradeOffer(1, invItem:getSlotID(), itemA, 2)

        local staged = findItem(p1, itemA)
        assert(staged:state() == xi.itemState.IN_TRANSACTION, 'state after re-stage: ' .. tostring(staged:state()))
    end)

    it('trade can be initiated while a player is synthing', function()
        local crystal    = xi.item.WIND_CRYSTAL
        local ingredient = xi.item.ARROWWOOD_LOG

        p1:setSkillLevel(xi.skill.WOODWORKING, 200)
        p1:addItem(crystal)
        p1:addItem(ingredient)
        p1:addItem(itemA)
        p2:addItem(itemB)

        p1.actions:craft(crystal, { ingredient })

        p1.actions:tradeRequest(p2)
        p2.actions:tradeAccept()

        local p1Item = findItem(p1, itemA)
        local p2Item = findItem(p2, itemB)
        assert(p1Item and p2Item, 'expected both items present')

        p1.actions:tradeOffer(1, p1Item:getSlotID(), itemA, 1)
        p2.actions:tradeOffer(1, p2Item:getSlotID(), itemB, 1)

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        p1.assert:hasItem(itemB)
        p2.assert:hasItem(itemA)
    end)

    it('gil-only trade transfers gil', function()
        p1:setGil(5000)
        p2:setGil(0)

        openTrade()

        -- Trade slot 0 is gil, and gil lives at inventory slot 0.
        p1.actions:tradeOffer(0, 0, xi.item.GIL, 1000)

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        assert(p1:getGil() == 4000, 'p1 gil: ' .. tostring(p1:getGil()))
        assert(p2:getGil() == 1000, 'p2 gil: ' .. tostring(p2:getGil()))
    end)

    it('mixed gil + item trade in one direction', function()
        p1:setGil(2000)
        p1:addItem(itemA)

        openTrade()

        local p1Item = findItem(p1, itemA)
        p1.actions:tradeOffer(0, 0, xi.item.GIL, 500)
        p1.actions:tradeOffer(1, p1Item:getSlotID(), itemA, 1)

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        assert(p1:getGil() == 1500, 'p1 gil: ' .. tostring(p1:getGil()))
        assert(p2:getGil() == 500, 'p2 gil: ' .. tostring(p2:getGil()))
        p1.assert.no:hasItem(itemA)
        p2.assert:hasItem(itemA)
    end)

    it('cancelling a gil stage leaves gil unchanged', function()
        p1:setGil(3000)
        openTrade()

        p1.actions:tradeOffer(0, 0, xi.item.GIL, 1000)
        p1.actions:tradeCancel()

        assert(p1:getGil() == 3000, 'p1 gil: ' .. tostring(p1:getGil()))
    end)

    it('staged gil cannot be spent at a vendor', function()
        local gear = xi.item.BRONZE_DAGGER

        p1:setGil(5000)
        p1:createShop(1)
        p1:addShopItem(gear, 1000)

        openTrade()
        p1.actions:tradeOffer(0, 0, xi.item.GIL, 5000)
        p1.actions:shopBuy(0, 1)

        assert(p1:getGil() == 5000, 'p1 gil: ' .. tostring(p1:getGil()))
        p1.assert.no:hasItem(gear)
    end)

    it('the server refuses a Make from out of range', function()
        p1:addItem(itemA)
        p2:addItem(itemB)

        openTrade()

        p1.actions:tradeOffer(1, findItem(p1, itemA):getSlotID(), itemA, 1)
        p2.actions:tradeOffer(1, findItem(p2, itemB):getSlotID(), itemB, 1)

        p2:setPos(p1:getXPos() + 50, p1:getYPos(), p1:getZPos())

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        p1.assert:hasItem(itemA)
        p2.assert:hasItem(itemB)
        p1.assert.no:hasItem(itemB)
        p2.assert.no:hasItem(itemA)
    end)

    it('zoning out aborts the trade', function()
        p1:addItem(itemA)
        openTrade()

        p1.actions:tradeOffer(1, findItem(p1, itemA):getSlotID(), itemA, 1)
        p1:gotoZone(xi.zone.NORTHERN_SAN_DORIA)

        p1.assert:hasItem(itemA)
    end)
end)
