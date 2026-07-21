describe('Sanction food duration bonus', function()
    describe('in an Aht Urhgan region', function()
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer(
                {
                    job   = xi.job.WAR,
                    level = 75,
                    zone  = xi.zone.AHT_URHGAN_WHITEGATE,
                })
        end)

        it('grants FOOD_DURATION', function()
            assert(player:getMod(xi.mod.FOOD_DURATION) == 0, 'should start with no bonus')

            player:addStatusEffect(xi.effect.SANCTION, { power = 3, duration = 10800, origin = player })

            player.assert
                :hasEffect(xi.effect.SANCTION)
                :hasModifier(xi.mod.FOOD_DURATION, 100)
        end)

        it('removes FOOD_DURATION when Sanction is lost', function()
            player:addStatusEffect(xi.effect.SANCTION, { power = 3, duration = 10800, origin = player })
            assert(player:getMod(xi.mod.FOOD_DURATION) == 100, 'bonus should be active in region')

            player:delStatusEffect(xi.effect.SANCTION)
            xi.test.world:tick()

            assert(player:getMod(xi.mod.FOOD_DURATION) == 0, 'losing Sanction should remove the bonus')
        end)
    end)

    describe('outside Aht Urhgan regions', function()
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer(
                {
                    job   = xi.job.WAR,
                    level = 75,
                    zone  = xi.zone.SOUTHERN_SAN_DORIA,
                })
        end)

        it('does not grant FOOD_DURATION', function()
            player:addStatusEffect(xi.effect.SANCTION, { power = 3, duration = 10800, origin = player })

            player.assert:hasEffect(xi.effect.SANCTION)
            assert(player:getMod(xi.mod.FOOD_DURATION) == 0,
                'Sanction outside Aht Urhgan should not grant food duration, got ' .. tostring(player:getMod(xi.mod.FOOD_DURATION)))
        end)
    end)
end)
