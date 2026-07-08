describe('Guild shop holidays', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.MHAURA })
        xi.settings.main.GUILD_SHOP_HOLIDAYS = true
    end)

    after_each(function()
        xi.settings.main.GUILD_SHOP_HOLIDAYS = false
    end)

    local statOpen    = 0
    local statHoliday = 2

    -- Kamilah in Mhaura is closed on Watersday.
    local shopHoliday = xi.day.WATERSDAY
    local otherDay    = xi.day.WINDSDAY

    local function guildStat()
        local stat
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x086 then
                stat = pkt.data[4]
            end
        end

        return stat
    end

    local function openOn(day, hour)
        xi.test.world:setVanaDay(day)
        xi.test.world:setVanaTime(hour or 8, 0)
        player.packets:clear()
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

    it('reports holiday on the guild holiday during shop hours', function()
        openOn(shopHoliday, 8)
        assert(guildStat() == statHoliday, 'not holiday on holiday')
    end)

    it('reports open on a non-holiday during shop hours', function()
        openOn(otherDay, 8)
        assert(guildStat() == statOpen, 'not open on non-holiday')
    end)

    it('rejects buying on the holiday', function()
        openOn(shopHoliday, 8)
        player:setGil(1000000)

        local reply = buy(xi.item.CHUNK_OF_TIN_ORE, 1)

        assert(reply.trade == 0xFF, 'buy not rejected on holiday: trade ' .. tostring(reply.trade))
        assert(not player:hasItem(xi.item.CHUNK_OF_TIN_ORE), 'item granted on holiday')
    end)

    it('ignores the holiday when the setting is disabled', function()
        xi.settings.main.GUILD_SHOP_HOLIDAYS = false
        openOn(shopHoliday, 8)
        assert(guildStat() == statOpen, 'holiday closed shop with setting disabled')
    end)
end)
