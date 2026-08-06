-----------------------------------
-- Roam pathing in Dynamis - Jeuno for a mob standing away from its spawn point.
--
-- A mob spawned near Upper Jeuno dragged to the Mog House would clip through the ledge instead of taking the appropriate path through the stairs.
-- This test ensures the mob pathes through the stairs when disengaged and walking back to spawn.
-----------------------------------

describe('Dynamis - Jeuno roam pathing away from the spawn anchor', function()
    local mogHouse      = { x = 48.930, y = 10.002, z = -71.032 }
    local stairs        = { x = 49.057, y = 7.250, z = -44.000 }

    local lowerFloorY   = 5.0
    local corridorWidth = 3.0

    local function distance(a, b)
        local dx, dy, dz = a.x - b.x, a.y - b.y, a.z - b.z
        return math.sqrt(dx * dx + dy * dy + dz * dz)
    end

    ---@type CClientEntityPair
    local player = nil

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.DYNAMIS_JEUNO })
    end)

    -- Find the right Vanguard Armorer.
    -- TODO: This will probably break when spawn regions are added?
    local function armorer()
        local nearest         = nil
        local nearestDistance = math.huge

        for _, entity in ipairs(player:getZone():queryEntitiesByName('Vanguard_Armorer')) do
            local spawnDistance = distance(entity:getSpawnPos(), mogHouse)
            if spawnDistance < nearestDistance then
                nearest         = entity
                nearestDistance = spawnDistance
            end
        end

        if not nearest then
            error('no Vanguard Armorer found in Dynamis - Jeuno')
        end

        return player.entities:get(nearest:getID())
    end

    it('has the Mog House, the stairs and the spawn point on the navmesh', function()
        local zone = player:getZone()
        assert(zone)
        local spawn = armorer():getSpawnPos()

        for name, pos in pairs({ mogHouse = mogHouse, stairs = stairs, spawn = spawn }) do
            assert(zone:isNavigablePoint(pos),
                string.format('%s (%.3f, %.3f, %.3f) should be navigable', name, pos.x, pos.y, pos.z))
        end
    end)

    it('roams out via the staircase instead of cutting straight at the spawn anchor', function()
        local mob   = armorer()
        local spawn = mob:getSpawnPos()

        assert(distance(mogHouse, spawn) < 50.0, 'Mog House should be inside roam range of the spawn point')
        assert(mogHouse.y - spawn.y > 9.0, 'Mog House should sit a floor below the spawn point')

        mob:respawn()
        mob:clearPath()

        -- Tick past the post-spawn window.
        for _ = 1, 5 do
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(mob)
        end

        mob:setPos(mogHouse.x, mogHouse.y, mogHouse.z)
        mob:clearPath()

        local moved        = 0.0
        local nearestStair = math.huge

        for _ = 1, 90 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)

            local pos    = mob:getPos()
            moved        = math.max(moved, distance(pos, mogHouse))
            nearestStair = math.min(nearestStair, distance(pos, stairs))

            -- Down here the corridor is the only way out.
            if pos.y > lowerFloorY then
                assert(math.abs(pos.x - mogHouse.x) < corridorWidth,
                    string.format('mob left the corridor at (%.3f, %.3f, %.3f)', pos.x, pos.y, pos.z))
            end
        end

        assert(moved > 1.0, 'mob should have roamed off the Mog House')
        assert(nearestStair < 5.0,
            string.format('mob should have reached the staircase; closest was %.1fy', nearestStair))
    end)
end)
