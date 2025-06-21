describe('items with weather latent', function()
    local player
    local baseEva

    before_each(function()
        _, player = xi.test.world:spawnPlayer()

        player:changeJob(xi.job.NIN)
        player:setLevel(75)
        baseEva = player:getEVA()
    end)

    it('do not grant effect with wrong weather', function()
        player:addItem(xi.item.MONSOON_JINPACHI)
        player:equipItem(xi.item.MONSOON_JINPACHI)

        player:setWeather(xi.weather.NONE)
        assert.are.equal(baseEva, player:getEVA())
    end)

    it('grant effect with matching weather', function()
        player:addItem(xi.item.MONSOON_JINPACHI)
        player:equipItem(xi.item.MONSOON_JINPACHI)

        player:setWeather(xi.weather.RAIN)
        assert.is_true(player:getEVA() - baseEva == 8)
    end)
end)
