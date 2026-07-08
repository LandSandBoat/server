describe('player trade', function()
    ---@type CClientEntityPair
    local p1
    ---@type CClientEntityPair
    local p2

    local itemA = xi.item.WIND_CRYSTAL
    local itemB = xi.item.FIRE_CRYSTAL

    before_each(function()
        p1 = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        p2 = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        p2:setPos(p1:getXPos(), p1:getYPos(), p1:getZPos())
    end)

    it('swaps one item each way', function()
        p1:addItem(itemA)
        p2:addItem(itemB)

        p1.actions:tradeRequest(p2)
        p2.actions:tradeAccept()

        local p1Item = p1:findItem(itemA)
        local p2Item = p2:findItem(itemB)
        assert(p1Item)
        assert(p2Item)

        p1.actions:tradeOffer(0, p1Item:getSlotID(), itemA, 1)
        p2.actions:tradeOffer(0, p2Item:getSlotID(), itemB, 1)

        p1.actions:tradeMake()
        p2.actions:tradeMake()

        p1.assert.no:hasItem(itemA)
        p2.assert.no:hasItem(itemB)
        p1.assert:hasItem(itemB)
        p2.assert:hasItem(itemA)
    end)
end)
