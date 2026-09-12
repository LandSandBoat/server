describe('wait', function()
    local player
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BATALLIA_DOWNS })
        mob    = player.entities:get('Goblin_Pathfinder')
        mob:respawn()
        mob:clearPath()
    end)

    it('holds the path until it ends', function()
        local x = mob:getXPos()
        mob:pathThrough({ x + 10, mob:getYPos(), mob:getZPos() })
        mob:wait(5000)
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(mob)
        assert(math.abs(mob:getXPos() - x) < 0.1, 'mob moved during its wait')

        xi.test.world:skipTime(5)
        xi.test.world:tickEntity(mob)
        xi.test.world:tickEntity(mob)
        assert(math.abs(mob:getXPos() - x) > 0.1, 'mob never moved once the wait ended')
    end)
end)
