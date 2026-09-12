describe('Meeble nap', function()
    local player
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.TEMENOS })
        mob    = player.entities:get('Temenos_Meeble')
        mob:respawn()
        mob:clearPath()
    end)

    it('spawns awake', function()
        assert(mob:getAnimationSub() == 4, 'expected animationSub 4, got ' .. mob:getAnimationSub())
    end)

    it('sleeps and wakes before the rest ends', function()
        mob:setMobMod(xi.mobMod.ROAM_COOL, 60)
        mob:setMobMod(xi.mobMod.ROAM_RATE, -1)

        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 5, 'expected asleep (5), got ' .. mob:getAnimationSub())

        xi.test.world:skipTime(45)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 5, 'woke too early')

        xi.test.world:skipTime(8)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 4, 'still asleep 9 s before the rest ends')
    end)
end)
