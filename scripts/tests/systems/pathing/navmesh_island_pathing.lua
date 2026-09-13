local function walk(mob)
    for tick = 1, 100 do
        xi.test.world:skipTime(0.4)
        xi.test.world:tickEntity(mob)
        if not mob:isFollowingPath() then
            return
        end
    end
end

describe('navmesh island pathing', function()
    it('does not step onto navmesh it cannot walk back from', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.YUHTUNGA_JUNGLE })
        local mob    = player.entities:get('Goblin_Digger')
        mob:respawn()
        mob:clearPath()

        -- the end of this pocket is not connected to the rest of the mesh
        mob:setPos(-301.04, -0.68, 209.13)
        mob:pathTo(-290.27, -5.19, 224.99)
        walk(mob)

        local corridor = { x = -258.0, y = 8.2, z = 245.0 }
        mob:pathTo(corridor.x, corridor.y, corridor.z)
        walk(mob)

        local gap = mob:checkDistance(corridor.x, corridor.y, corridor.z)
        assert(gap < 1, 'stranded ' .. gap .. ' yalms from the corridor')
    end)

    it('does not take the height of an unreachable layer below its path', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.YHOATOR_JUNGLE })
        local mob    = player.entities:get('Goblin_Digger')
        mob:respawn()
        mob:clearPath()

        -- there is an unconnected pocket below this spot
        mob:setPos(-69.47, 7.20, -178.26)
        mob:pathTo(-84.13, -0.14, -179.94)
        walk(mob)

        local trail = { x = -20.34, y = 0.55, z = -145.57 }
        mob:pathTo(trail.x, trail.y, trail.z)
        walk(mob)

        local gap = mob:checkDistance(trail.x, trail.y, trail.z)
        assert(gap < 1, 'stranded ' .. gap .. ' yalms from the trail')
    end)
end)
