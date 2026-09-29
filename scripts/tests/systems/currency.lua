describe('Currency', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('reads back what was set', function()
        player:setCurrency('cruor', 1234)

        assert(player:getCurrency('cruor') == 1234,
            string.format('expected 1234 cruor, saw %d', player:getCurrency('cruor')))
    end)

    it('keeps each currency in its own column', function()
        player:setCurrency('cruor', 10)
        player:setCurrency('zeni_point', 20)

        assert(player:getCurrency('cruor') == 10,
            string.format('expected 10 cruor, saw %d', player:getCurrency('cruor')))
        assert(player:getCurrency('zeni_point') == 20,
            string.format('expected 20 zeni, saw %d', player:getCurrency('zeni_point')))
    end)

    it('adds up to the given cap', function()
        player:setCurrency('allied_notes', 90)
        player:addCurrency('allied_notes', 50, 100)

        assert(player:getCurrency('allied_notes') == 100,
            string.format('expected 100 allied notes, saw %d', player:getCurrency('allied_notes')))
    end)

    it('stops at 0 when removing more than is held', function()
        player:setCurrency('jetton', 5)
        player:delCurrency('jetton', 8)

        assert(player:getCurrency('jetton') == 0,
            string.format('expected 0 jettons, saw %d', player:getCurrency('jetton')))
    end)

    it('reads 0 for a name that is not a currency', function()
        assert(player:getCurrency('not_a_currency') == 0)
    end)
end)
