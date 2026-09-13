describe('wander', function()
    local player
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.EAST_RONFAURE })
        mob    = player.entities:get('Goblin_Digger')
        mob:respawn()
        mob:clearPath()
    end)

    it('walks away from its spawn and does not come back', function()
        local spawn    = mob:getSpawnPos()
        local farthest = 0
        for second = 1, 1800 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)
            farthest = math.max(farthest, mob:checkDistance(spawn.x, spawn.y, spawn.z))
        end

        assert(mob:isSpawned(), 'the digger despawned')
        assert(farthest > 60, 'the digger stayed within ' .. farthest .. ' of its spawn')
    end)

    it('walks back into its region when it ends up outside', function()
        -- open ground 30 yalms off its lanes
        local outside = { x = 203.6, y = -22.05, z = -239.9 }
        mob:setPos(outside.x, outside.y, outside.z)
        for second = 1, 120 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)
        end

        assert(mob:isSpawned(), 'the digger despawned')
        assert(mob:checkDistance(outside.x, outside.y, outside.z) > 30, 'the digger did not walk back to its lanes')
    end)
end)
