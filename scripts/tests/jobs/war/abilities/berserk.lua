describe('Berserk', function()
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.WAR,
                level = 49, -- Berserk is 25% ATTP until 50
            })
    end)

    it('increases attack by 25%', function()
        player.actions:useAbility(player, xi.jobAbility.BERSERK)
        xi.test.world:tick()

        player.assert
            :hasEffect(xi.effect.BERSERK)
            :hasModifier(xi.mod.ATTP, 25)
    end)

    it('decreases defense by 25%', function()
        player.actions:useAbility(player, xi.jobAbility.BERSERK)
        xi.test.world:tick()

        player.assert:hasModifier(xi.mod.DEFP, -25)
    end)

    -- TODO: Test Level scaling, Conqueror, Calligae, Job points etc
end)
