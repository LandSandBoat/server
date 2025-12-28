describe('Knockback', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 1, zone = xi.zone.BEAUCEDINE_GLACIER_S })
        mob    = player.entities:moveTo('Ruszor')
    end)

    it('works', function()
        local s = stub('xi.mobskills.calculateKnockback')
        mob:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 0)
        xi.test.world:skipTime(1)
        s:called(1)
        s:returnValue(xi.action.knockback.LEVEL5)
    end)

    it('can be reduced with appropriate gear', function()
        local s = stub('xi.mobskills.calculateKnockback')
        player:setMod(xi.mod.KNOCKBACK_REDUCTION, 2)
        mob:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 0)
        xi.test.world:skipTime(1)
        s:called(1)
        s:returnValue(xi.action.knockback.LEVEL3)
    end)

    it('can be negated entirely', function()
        local s = stub('xi.mobskills.calculateKnockback')
        player:setMod(xi.mod.KNOCKBACK_REDUCTION, 8)
        mob:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 0)
        xi.test.world:skipTime(1)
        s:called(1)
        s:returnValue(xi.action.knockback.NONE)
    end)
end)
