describe('Guild shop selling', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.MHAURA })
    end)

    local offered    = xi.item.CHUNK_OF_TIN_ORE -- initial 110 => offered and sellable
    local notOffered = xi.item.CHAINMAIL        -- initial 0   => only bought from players

    local function open(hour)
        xi.test.world:setVanaTime(hour or 8, 0)
        player.entities:gotoAndTrigger('Kamilah')
    end

    local function cfgOf(itemId)
        for _, cfg in ipairs(xi.data.guildShops['Kamilah'].stock) do
            if cfg.id == itemId then
                return cfg
            end
        end
    end

    -- trade: amount sold; 0xFF (-1) partial fill, 0xFC (-4) over-stack reject
    local function sell(itemId, quantity)
        player.packets:clear()
        player.actions:guildSell(itemId, quantity)
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x084 then
                return { itemNo = pkt.data[4] + pkt.data[5] * 256, stock = pkt.data[6], trade = pkt.data[7] }
            end
        end
    end

    local function sellList()
        return player.actions:guildSellList()
    end

    local function offeredToday(itemId)
        return player.actions:guildBuyList()[itemId] ~= nil
    end

    it('credits the locked price, removes the item, and raises shop stock', function()
        open()
        player:addItem(offered, 1)

        local before = sellList()[offered]
        local gil    = player:getGil()

        local reply = sell(offered, 1)

        assert(reply.trade == 1, 'sale not accepted: trade ' .. tostring(reply.trade))
        assert(player:getGil() == gil + before.price, 'gil not credited')
        assert(not player:hasItem(offered), 'item not taken')
        assert(sellList()[offered].count == before.count + 1, 'stock not +1')
    end)

    it('clamps a sale to the shop max stock', function()
        open()
        local cfg = cfgOf(offered)

        -- no packet sets shop stock; seed one below max so the 5-sale only has room for 1
        xi.guildShops.state['Kamilah'].items[offered].stock = cfg.maxStock - 1
        player:addItem(offered, 5)
        local held = player:getItemCount(offered)

        local reply = sell(offered, 5)

        assert(sellList()[offered].count == cfg.maxStock, 'stock not clamped to max')
        assert(player:getItemCount(offered) == held - 1, 'took more than the room left')
        assert(reply.trade == 0xFF, 'partial fill not flagged: trade ' .. tostring(reply.trade))
    end)

    it('sells across multiple inventory stacks', function()
        open()

        -- two stacks of 3 + 12, so a 12-sale has to span both (tin ore caps at 12)
        player:addItem(offered, 12)
        player:addItem(offered, 12)
        player:delItem(offered, 9) -- drains the front stack: 12 -> 3
        assert(player:getItemCount(offered) == 15, 'setup: expected 3 + 12 = 15')

        local before = sellList()[offered]
        local gil    = player:getGil()

        local reply = sell(offered, 12)

        assert(reply.trade == 12, 'full sale not reported as 12: ' .. tostring(reply.trade))
        assert(player:getItemCount(offered) == 3, 'inventory not 3')
        assert(player:getGil() == gil + before.price * 12, 'gil off for 12 sold')
        assert(sellList()[offered].count == before.count + 12, 'stock not +12')
    end)

    it('offers a seeded item the next day, not the same day', function()
        open()
        player:addItem(notOffered, 1)

        sell(notOffered, 1)
        assert(not offeredToday(notOffered), 'offered the same day it was seeded')

        xi.test.world:skipToNextVanaDay()
        open()
        assert(offeredToday(notOffered), 'not offered the next day')
    end)
end)
