describe('Weather', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local rabbit

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            zone = xi.zone.WEST_RONFAURE,
            job  = xi.job.BLM,
            level = 99
        })
        player:addSpell(xi.magic.spell.STONE)

        rabbit = player.entities:moveTo('Forest_Hare')
        rabbit:spawn()
        player:setWeather(xi.weather.NONE)
    end)

    after_each(function()
        rabbit:respawn()
    end)

    describe('calculateDayAndWeather', function()
        it('does not increase damage without matching weather', function()
            local s = spy('xi.spells.damage.calculateDayAndWeather')
            xi.test.world:setVanaDay(xi.day.FIRESDAY)
            player.actions:useSpell(rabbit, xi.magic.spell.STONE)
            xi.test.world:skipTime(3)

            s:called(1)
            assert(s.calls[1].returned == 1) -- 1.0, no bonus
            s:calledWith(player, xi.element.EARTH, false)
        end)

        it('increases damage with matching weather', function()
            xi.test.world:setVanaDay(xi.day.FIRESDAY)
            local s = spy('xi.spells.damage.calculateDayAndWeather')

            player:setMod(xi.mod.FORCE_EARTH_DWBONUS, 1)
            player:setWeather(xi.weather.SAND_STORM)
            player.actions:useSpell(rabbit, xi.magic.spell.STONE)
            xi.test.world:skipTime(3)

            s:called(1)
            assert(s.calls[1].returned == 1.25, string.format('Expected multiplier to be %f but was %f', 1.25, s.calls[1].returned)) -- 1.25, 25% bonus
        end)
    end)
end)
