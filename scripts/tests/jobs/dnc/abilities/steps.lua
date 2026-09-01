describe('Steps', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            zone  = xi.zone.WEST_RONFAURE,
            job   = xi.job.DNC,
            level = 99,
        })

        -- A missed step applies no effect at all
        stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1.0)

        mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:setUnkillable(true)

        player.actions:engage(mob)
        xi.test.world:tickEntity(player)
    end)

    local function useBoxStep()
        player:setTP(3000)
        player.actions:useAbility(mob, xi.jobAbility.BOX_STEP)
        xi.test.world:tickEntity(player)
    end

    local function dazeTimeRemaining()
        local daze = mob:getStatusEffect(xi.effect.SLUGGISH_DAZE_1)
        assert(daze, 'Box Step applied no Sluggish Daze')

        return daze:getTimeRemaining() / 1000
    end

    it('lasts one minute when first applied', function()
        useBoxStep()

        local remaining = dazeTimeRemaining()
        assert(remaining > 55 and remaining <= 60, string.format('Expected 60s, got %.1fs', remaining))
    end)

    it('adds thirty seconds to the time remaining, not to the original duration', function()
        useBoxStep()
        xi.test.world:skipTime(30)
        useBoxStep()

        -- 30s left of the first minute, plus 30s for the second step
        local remaining = dazeTimeRemaining()
        assert(remaining > 55 and remaining <= 60, string.format('Expected 60s, got %.1fs', remaining))
    end)

    it('caps at two minutes', function()
        useBoxStep()

        -- Each step is worth +30s and the recast costs 5s, so this walks past the cap
        for _ = 1, 5 do
            xi.test.world:skipTime(5)
            useBoxStep()
        end

        local remaining = dazeTimeRemaining()
        assert(remaining > 115 and remaining <= 120, string.format('Expected the 120s cap, got %.1fs', remaining))
    end)
end)
