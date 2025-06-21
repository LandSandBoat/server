local utils = require('scripts/tests/utils')

describe('xi.spells', function()
    local client, player
    local rabbit

    setup(function()
        client, player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.BLM)
        player:setLevel(99)
        player:addSpell(xi.magic.spell.STONE)

        rabbit = player:getZone():queryEntitiesByName('Forest_Hare')[1]
        assert.is_not_nil(rabbit)
        client:gotoEntity(rabbit)
    end)

    before_each(function()
        rabbit:spawn()
        player:setWeather(xi.weather.NONE)
    end)

    after_each(function()
        utils.respawnDeadMob(rabbit)
    end)

    describe('damage', function()
        describe('calculateDayAndWeather', function()
            it('does not increase damage without matching weather', function()
                local s = spy.on(xi.spells.damage, 'calculateDayAndWeather')

                client:useSpell(rabbit, xi.magic.spell.STONE)
                xi.test.world:skipTime(3)

                assert.spy(s).was.called(1)
                assert.spy(s).returned_with(1) -- 1.0, no bonus
            end)

            -- Disabled because flaky due to day impacting calculations and need one bug fix
            pending('increases damage with matching weather', function()
                local s = spy.on(xi.spells.damage, 'calculateDayAndWeather')

                player:setMod(xi.mod.FORCE_EARTH_DWBONUS, 1)
                player:setWeather(xi.weather.SAND_STORM)
                client:useSpell(rabbit, xi.magic.spell.STONE)
                xi.test.world:skipTime(3)

                assert.spy(s).was.called(1)
                assert.spy(s).returned_with(1.25) -- 1.25x
            end)
        end)
    end)
end)
