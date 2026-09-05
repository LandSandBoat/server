describe('Status effect durations', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WHM, level = 99 })
        player:addStatusEffect(xi.effect.POISON, { power = 5, duration = 60, tick = 3, origin = player })
    end)

    -- addStatusEffect takes seconds while the effect reports itself in milliseconds
    it('are applied in seconds and reported in milliseconds', function()
        local poison = player:getStatusEffect(xi.effect.POISON)
        assert(poison, 'Poison was not applied')

        assert(poison:getDuration() == 60000, string.format('Expected 60000ms, got %d', poison:getDuration()))
        assert(poison:getTick() == 3000, string.format('Expected a 3000ms tick, got %d', poison:getTick()))
    end)

    it('count the time remaining down from the full duration', function()
        xi.test.world:skipTime(20)

        local poison = player:getStatusEffect(xi.effect.POISON)
        assert(poison, 'Poison was not applied')

        assert(poison:getDuration() == 60000, 'The full duration should not change as the effect runs')
        assert(poison:getTimeRemaining() <= 40000, string.format('Expected 40000ms left, got %d', poison:getTimeRemaining()))
    end)

    it('are copied with the time remaining, not the full duration', function()
        local other = xi.test.world:spawnPlayer({ job = xi.job.WHM, level = 99 })

        xi.test.world:skipTime(20)

        local poison = player:getStatusEffect(xi.effect.POISON)
        assert(poison, 'Poison was not applied')

        other:copyStatusEffect(poison)

        local copied = other:getStatusEffect(xi.effect.POISON)
        assert(copied, 'The effect was not copied')
        assert(copied:getTimeRemaining() <= 40000, string.format('Expected 40000ms left, got %d', copied:getTimeRemaining()))
        assert(copied:getTick() == 3000, string.format('Expected a 3000ms tick, got %d', copied:getTick()))
    end)
end)
