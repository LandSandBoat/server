describe('Double-Up', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            zone  = xi.zone.WEST_RONFAURE,
            job   = xi.job.COR,
            level = 99,
        })

        player:addLearnedAbility(xi.jobAbility.FIGHTERS_ROLL)

        -- Twelve or more busts the roll instead of upgrading it
        stub('math.randomInt', 1)
    end)

    local function fightersRoll()
        local roll = player:getStatusEffect(xi.effect.FIGHTERS_ROLL)
        assert(roll, 'Fighters Roll is not active')

        return roll
    end

    it('keeps the time remaining on the roll it upgrades', function()
        player.actions:useAbility(player, xi.jobAbility.FIGHTERS_ROLL)
        xi.test.world:tickEntity(player)

        xi.test.world:skipTime(30)

        player.actions:useAbility(player, xi.jobAbility.DOUBLE_UP)
        xi.test.world:tickEntity(player)

        -- Retail keeps counting down from the first roll rather than restarting it
        local remaining = fightersRoll():getTimeRemaining() / 1000
        assert(remaining > 265 and remaining <= 270, string.format('Expected 270s, got %.1fs', remaining))
    end)

    it('adds the second roll to the total', function()
        player.actions:useAbility(player, xi.jobAbility.FIGHTERS_ROLL)
        xi.test.world:tickEntity(player)

        xi.test.world:skipTime(5)

        player.actions:useAbility(player, xi.jobAbility.DOUBLE_UP)
        xi.test.world:tickEntity(player)

        assert(fightersRoll():getSubPower() == 2, 'Double-Up did not upgrade the roll')
    end)
end)
