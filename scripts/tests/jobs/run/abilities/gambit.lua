describe('Gambit', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local euvhi

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            job = xi.job.RUN,
            level = 75,
            zone = xi.zone.ALTAIEU
        })

        -- Find a mob to reduce res
        euvhi = player.entities:moveTo('Aweuvhi')
    end)

    it('reduces wind res', function()
        local origWind = euvhi:getMod(xi.mod.WIND_SDT)
        player.actions:useAbility(player, xi.jobAbility.FLABRA)
        xi.test.world:tick()
        player:resetRecasts()
        player.actions:useAbility(player, xi.jobAbility.FLABRA)
        xi.test.world:tick()
        player:resetRecasts()
        player.actions:useAbility(player, xi.jobAbility.FLABRA)
        xi.test.world:tick()

        assert(
            player:getActiveRuneCount() == 3,
            'Using Flabra 3 times should have 3 runes'
        )

        player.actions:useAbility(euvhi, xi.jobAbility.GAMBIT)
        xi.test.world:tick()

        euvhi.assert
            :hasEffect(xi.effect.GAMBIT)
            :hasModifier(xi.mod.WIND_SDT, origWind + 3000)

        euvhi:delStatusEffect(xi.effect.GAMBIT)
        xi.test.world:tick()

        assert(
            euvhi:getMod(xi.mod.WIND_SDT) == origWind,
            'Losing rayke should revert WIND_SDT'
        )
    end)
end)
