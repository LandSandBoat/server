describe('Guild shop daily roll', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.MHAURA })
    end)

    local offered = xi.item.CHUNK_OF_TIN_ORE

    local function open(hour)
        xi.test.world:setVanaTime(hour or 8, 0)
        player.entities:gotoAndTrigger('Kamilah')
    end

    local function nextDayOpen()
        xi.test.world:skipToNextVanaDay()
        open()
    end

    local function cfgOf(itemId)
        for _, cfg in ipairs(xi.data.guildShops['Kamilah'].stock) do
            if cfg.id == itemId then
                return cfg
            end
        end
    end

    local function buyEntry(itemId)
        return player.actions:guildBuyList()[itemId]
    end

    local function sellEntry(itemId)
        return player.actions:guildSellList()[itemId]
    end

    local function seedStock(itemId, stock)
        xi.guildShops.state['Kamilah'].items[itemId].stock = stock
    end

    it('keeps the locked prices steady as stock moves through the day', function()
        open()
        player:setGil(1000000)

        local buyBefore  = buyEntry(offered).price
        local sellBefore = sellEntry(offered).price

        player.actions:guildBuy(offered, 2) -- drains stock mid-day

        assert(buyEntry(offered).price == buyBefore, 'buy price changed mid-day')
        assert(sellEntry(offered).price == sellBefore, 'sell price changed mid-day')
    end)

    it('recomputes prices on the next day', function()
        open()
        local before = sellEntry(offered).price

        seedStock(offered, 50) -- below targetStock: next open restocks and reprices
        nextDayOpen()

        assert(sellEntry(offered).price ~= before, 'price not recomputed next day')
    end)

    it('restocks toward targetStock', function()
        open()
        local cfg = cfgOf(offered)

        seedStock(offered, cfg.targetStock - cfg.restockRate * 2) -- two days below targetStock

        nextDayOpen()
        assert(sellEntry(offered).count == cfg.targetStock - cfg.restockRate, 'day 1 restock wrong')

        nextDayOpen()
        assert(sellEntry(offered).count == cfg.targetStock, 'day 2 not at targetStock')

        nextDayOpen()
        assert(sellEntry(offered).count == cfg.targetStock, 'restock overshot targetStock')
    end)

    it('trims overstock back to targetStock', function()
        open()
        local cfg = cfgOf(offered)

        seedStock(offered, cfg.maxStock) -- sales can pile stock up to maxStock during the day

        nextDayOpen()
        assert(sellEntry(offered).count == cfg.targetStock, 'overstock not trimmed')
    end)
end)
