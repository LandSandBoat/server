describe('BazaarPurchaseTransaction', function()
    ---@type CClientEntityPair
    local seller
    ---@type CClientEntityPair
    local buyer

    local goods = xi.item.WIND_CRYSTAL
    local price = 100

    local function findItem(player, itemId)
        local item = player:findItem(itemId, xi.inventoryLocation.INVENTORY)
        assert(item, 'item ' .. tostring(itemId) .. ' not in inventory')

        return item
    end

    local function totalOf(itemId)
        return seller:getItemCount(itemId) + buyer:getItemCount(itemId)
    end

    -- the item has to be on display and the buyer looking at the bazaar before a buy is accepted
    local function list(quantity)
        seller:addItem(goods, quantity)

        local slot = findItem(seller, goods):getSlotID()
        seller.actions:bazaarPrice(slot, price)

        assert(findItem(seller, goods):state() == xi.itemState.BAZAAR, 'listing is not on display')

        buyer.actions:bazaarOpen(seller)

        return slot
    end

    before_each(function()
        seller = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        buyer  = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })

        buyer:setPos(seller:getXPos(), seller:getYPos(), seller:getZPos())
    end)

    it('moves the goods and the gil in opposite directions', function()
        local slot = list(1)
        buyer:addGil(price * 2)

        local sellerGil = seller:getGil()
        local buyerGil  = buyer:getGil()

        buyer.actions:bazaarBuy(slot, 1)

        assert(buyer:getItemCount(goods) == 1, 'buyer received: ' .. tostring(buyer:getItemCount(goods)))
        assert(seller:getItemCount(goods) == 0, 'seller kept: ' .. tostring(seller:getItemCount(goods)))
        assert(seller:getGil() > sellerGil, 'seller was not paid')
        assert(buyer:getGil() < buyerGil, 'buyer did not pay')
    end)

    it('leaves the remainder of a part-bought stack on display', function()
        local slot = list(12)
        buyer:addGil(price * 20)

        buyer.actions:bazaarBuy(slot, 4)

        assert(buyer:getItemCount(goods) == 4, 'buyer received: ' .. tostring(buyer:getItemCount(goods)))
        assert(seller:getItemCount(goods) == 8, 'seller kept: ' .. tostring(seller:getItemCount(goods)))
        assert(findItem(seller, goods):state() == xi.itemState.BAZAAR, 'remainder left the display')
    end)

    it('does not sell to a buyer who cannot pay', function()
        local slot = list(1)

        buyer.actions:bazaarBuy(slot, 1)

        assert(totalOf(goods) == 1, 'copies in play: ' .. tostring(totalOf(goods)))
        assert(seller:getItemCount(goods) == 1, 'seller lost the goods')
        assert(buyer:getItemCount(goods) == 0, 'buyer received goods without paying')
    end)

    it('releases the listing when it is taken off display', function()
        local slot = list(1)

        seller.actions:bazaarPrice(slot, 0)

        local item = findItem(seller, goods)
        assert(item:state() == xi.itemState.FREE, 'state: ' .. tostring(item:state()))
    end)

    it('refuses to bazaar gil', function()
        seller:addGil(1000)

        seller.actions:bazaarPrice(0, 50)

        local gil = seller:findItem(xi.item.GIL, xi.inventoryLocation.INVENTORY)
        assert(gil, 'gil is missing entirely')
        assert(gil:state() == xi.itemState.FREE, 'gil was claimed by the bazaar: ' .. tostring(gil:state()))
        assert(seller:getGil() == 1000, 'gil changed: ' .. tostring(seller:getGil()))
    end)

    it('a listed item cannot be staged into a player trade', function()
        list(1)

        local slot = findItem(seller, goods):getSlotID()

        seller.actions:tradeRequest(buyer)
        buyer.actions:tradeAccept()
        seller.actions:tradeOffer(1, slot, goods, 1)
        seller.actions:tradeMake()
        buyer.actions:tradeMake()

        assert(totalOf(goods) == 1, 'copies in play: ' .. tostring(totalOf(goods)))
        assert(seller:getItemCount(goods) == 1, 'the listing left the seller')
    end)

    it('refuses a sale the seller cannot be paid for', function()
        local slot = list(1)
        seller:setGil(999999999)
        buyer:addGil(price * 2)
        local buyerGil = buyer:getGil()

        buyer.actions:bazaarBuy(slot, 1)

        assert(buyer:getGil() == buyerGil, 'buyer was charged for a refused sale')
        assert(seller:getItemCount(goods) == 1, 'the listing left the seller')
    end)
end)
