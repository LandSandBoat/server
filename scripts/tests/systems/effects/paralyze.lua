describe('Paralyze', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.SAM, level = 99 })
        player:setMod(xi.mod.PARALYZE, 100)
    end)

    it('puts abilities on cooldown', function()
        player.actions:useAbility(player, xi.jobAbility.MEDITATE)
        xi.test.world:tickEntity(player)
        assert(player:hasRecast(xi.recast.ABILITY, xi.recastID.MEDITATE), 'Player did not have ability on recast')
    end)

    it('does not put 1HR abilities on cooldown', function()
        player.actions:useAbility(player, xi.jobAbility.MEIKYO_SHISUI)
        xi.test.world:tickEntity(player)
        player.actions:useAbility(player, xi.jobAbility.YAEGASUMI)
        xi.test.world:tickEntity(player)
        assert(not player:hasRecast(xi.recast.ABILITY, xi.recastID.SPECIAL), 'Player had 1HR ability on recast')
        assert(not player:hasRecast(xi.recast.ABILITY, xi.recastID.SPECIAL2), 'Player had 2nd 1HR ability on recast')
    end)
end)
