describe('Boost', function()
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.MNK,
                level = 5,
            })
    end)

    it('increases attack by 25%', function()
        assert(
            player:getMod(xi.mod.ATTP) == 0,
            'Fresh level 5 monk should have no ATTP bonus'
        )

        player.actions:useAbility(player, xi.jobAbility.BOOST)
        xi.test.world:tick()
        player:resetRecasts()
        player.actions:useAbility(player, xi.jobAbility.BOOST)
        xi.test.world:tick()

        player.assert
            :hasEffect(xi.effect.BOOST)
            :hasModifier(xi.mod.ATTP, 25)

        player:delStatusEffect(xi.effect.BOOST)
        xi.test.world:tick()

        assert(
            player:getMod(xi.mod.ATTP) == 0,
            'Losing boost should revert ATTP bonus'
        )
    end)
end)
