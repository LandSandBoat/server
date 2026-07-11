describe('Guild shop buying', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.MHAURA })
    end)

    local offered    = xi.item.CHUNK_OF_TIN_ORE -- initial 110 => offered at open
    local notOffered = xi.item.CHAINMAIL        -- initial 0   => only bought, never offered

    local function open(hour)
        xi.test.world:setVanaDay(xi.day.WINDSDAY)
        xi.test.world:setVanaTime(hour or 8, 0)
        player.entities:gotoAndTrigger('Kamilah')
    end

    local function buy(itemId, quantity)
        player.packets:clear()
        player.actions:guildBuy(itemId, quantity)
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x082 then
                return { itemNo = pkt.data[4] + pkt.data[5] * 256, count = pkt.data[6], trade = pkt.data[7] }
            end
        end
    end

    local function offeredStock(itemId)
        local entry = player.actions:guildBuyList()[itemId]
        return entry and entry.count
    end

    it('grants the item, charges gil, and decrements the listed stock', function()
        open()
        player:setGil(1000000)
        local stock = offeredStock(offered)
        local gil   = player:getGil()

        local reply = buy(offered, 1)

        assert(reply.trade == 1, 'buy not accepted: trade ' .. tostring(reply.trade))
        assert(player:hasItem(offered), 'item not granted')
        assert(player:getGil() < gil, 'gil not deducted')
        assert(reply.count == stock - 1, 'reply stock not -1')
        assert(offeredStock(offered) == stock - 1, 'list stock not -1')
    end)

    it('rejects a buy over the stack size', function()
        open()
        player:setGil(10000000)

        local reply = buy(offered, 99) -- tin ore stacks to 12

        assert(reply.trade == 0xFF, 'over-stack not rejected: trade ' .. tostring(reply.trade))
        assert(not player:hasItem(offered), 'item granted on reject')
    end)

    it('rejects an item the shop does not offer', function()
        open()
        player:setGil(1000000)
        local gil = player:getGil()

        local reply = buy(notOffered, 1)

        assert(reply.itemNo == 0 and reply.trade == 0xFF, 'unoffered item not rejected')
        assert(player:getGil() == gil, 'gil changed on reject')
        assert(not player:hasItem(notOffered), 'item granted on reject')
    end)

    it('rejects buying while the shop is closed', function()
        open(7) -- before opening hours
        player:setGil(1000000)
        local gil = player:getGil()

        local reply = buy(offered, 1)

        assert(reply.trade == 0xFF, 'bought while closed')
        assert(player:getGil() == gil, 'gil changed while closed')
        assert(not player:hasItem(offered), 'item granted while closed')
    end)

    it('charges the same locked price across the day', function()
        open()
        player:setGil(1000000)

        local g1 = player:getGil()
        buy(offered, 1)
        local delta1 = g1 - player:getGil()

        xi.test.world:skipTime(1)

        local g2 = player:getGil()
        buy(offered, 1)
        local delta2 = g2 - player:getGil()

        assert(delta1 > 0 and delta1 == delta2, string.format('buy price not locked: delta1=%d delta2=%d', delta1, delta2))
    end)

    it('rejects a buy the player cannot afford', function()
        open()
        local stock = offeredStock(offered)
        player:setGil(0)

        local reply = buy(offered, 1)

        assert(reply.trade == 0xFF, 'bought without gil')
        assert(not player:hasItem(offered), 'item granted without gil')
        assert(offeredStock(offered) == stock, 'stock changed on reject')
    end)
end)

describe('Guild shop shared stock', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.AHT_URHGAN_WHITEGATE })
        xi.test.world:setVanaDay(xi.day.WINDSDAY)
        xi.test.world:setVanaTime(8, 0)
    end)

    -- Wahraga and Gathweeda share one Alchemists Guild stock pool
    it('Gathweeda draws from the same stock pool as Wahraga', function()
        local item = xi.item.VIAL_OF_MERCURY

        player.entities:gotoAndTrigger('Wahraga')
        player:setGil(10000000)
        local wahragaStock = player.actions:guildBuyList()[item].count

        player.actions:guildBuy(item, 1) -- buy one from Wahraga

        player.entities:gotoAndTrigger('Gathweeda')
        local gathweedaStock = player.actions:guildBuyList()[item].count

        assert(gathweedaStock == wahragaStock - 1,
            string.format('stock not shared: Wahraga %d, Gathweeda %d', wahragaStock, gathweedaStock))
    end)
end)
