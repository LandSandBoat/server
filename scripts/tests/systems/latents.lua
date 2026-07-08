describe('items with weather latent', function()
    local player
    local baseEva

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.NIN, level = 75 })
        baseEva = player:getEVA()
    end)

    it('do not grant effect with wrong weather', function()
        player:addItem(xi.item.MONSOON_JINPACHI)
        player:equipItem(xi.item.MONSOON_JINPACHI)

        player:setWeather(xi.weather.NONE)
        assert(baseEva == player:getEVA(),
            string.format('EVA should not change with wrong weather. Expected %d, got %d', baseEva, player:getEVA()))
    end)

    it('grant effect with matching weather', function()
        player:addItem(xi.item.MONSOON_JINPACHI)
        player:equipItem(xi.item.MONSOON_JINPACHI)

        player:setWeather(xi.weather.RAIN)
        local evaBoost = player:getEVA() - baseEva
        assert(evaBoost == 8, string.format('EVA should increase by 8 with matching weather. Got boost of %d', evaBoost))
    end)
end)
