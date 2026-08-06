-----------------------------------
-- Line of sight, aggro, navigation and pathing around geometry in Bostaunieux Oubliette
--
-- Hand-surveyed spots where a mob and a player sit close together but are separated by geometry
-- the mob can neither see nor walk through, so it must path around before it can attack:
--
--   Corner : opposite sides of a wall's 90-degree corner (~5.8y apart, sight blocked).
--   Wall   : opposite faces of a very thin wall (~1.5y apart, sight still blocked).
--   Bridge : two stone banks split by a deep-water channel and joined by a stone bridge (point B,
--            off to one side). A mob CAN see across the water but cannot walk through it, so to
--            reach the far bank it must detour over the bridge.
--
-- Coordinates were captured in-game and confirmed with !pos and !cansee.
-----------------------------------

describe('Bostaunieux Oubliette line of sight and navigation', function()
    local point =
    {
        cornerA = { x = -133.557, y = -0.0533008, z = -63.5575 },
        cornerB = { x = -137.257, y =  0.0,        z = -68.0179 },

        wallA   = { x = -114.265, y =  0.0,        z = -57.0852 },
        wallB   = { x = -115.736, y =  0.0234314,  z = -56.9375 },

        bridgeA = { x = -112.607, y = -0.0287482, z = -56.7111 },
        bridgeB = { x = -110.574, y = -0.302273,  z = -60.6202 }, -- on the bridge
        bridgeC = { x = -107.296, y = -0.0142787, z = -57.4638 },
    }

    local function distance(a, b)
        local dx, dy, dz = a.x - b.x, a.y - b.y, a.z - b.z
        return math.sqrt(dx * dx + dy * dy + dz * dz)
    end

    local function midpoint(a, b)
        return { x = (a.x + b.x) / 2, y = (a.y + b.y) / 2, z = (a.z + b.z) / 2 }
    end

    ---@type CClientEntityPair
    local player = nil

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BOSTAUNIEUX_OUBLIETTE })
    end)

    local function placeAt(entity, pos)
        entity:setPos(pos.x, pos.y, pos.z)
    end

    local function bloodsucker()
        for _, e in ipairs(player:getZone():queryEntitiesByName('Bloodsucker')) do
            if e:isSpawned() and e:getStatus() ~= xi.status.DISAPPEAR then
                return player.entities:get(e:getID())
            end
        end

        error('no spawned Bloodsucker found in Bostaunieux Oubliette')
    end

    describe('line of sight', function()
        local function mobCanSee(fromPos, toPos)
            local mob = bloodsucker()
            mob:respawn()
            mob:clearPath()
            placeAt(mob, fromPos)
            placeAt(player, toPos)
            return mob:canSee(player)
        end

        it('is blocked around the wall corner', function()
            assert(not mobCanSee(point.cornerA, point.cornerB),
                'mob should not see a player hidden around the corner')
        end)

        it('is blocked straight through the thin wall', function()
            assert(not mobCanSee(point.wallA, point.wallB),
                'mob should not see a player on the far side of the thin wall')
        end)

        it('is clear across the gap between the bridge banks', function()
            assert(mobCanSee(point.bridgeA, point.bridgeC),
                'mob should see a player across the open gap')
        end)
    end)

    describe('sight aggro respects line of sight', function()
        local function primeAggressor(mobPos, playerPos)
            local mob = bloodsucker()

            mob:respawn() -- reset the shared mob to a clean state
            mob:setAggressive(true)
            mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
            mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
            mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)

            -- Tick past the post-spawn neutral window so the mob can aggro at all.
            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(mob)
            end

            -- Snap to the test spot (undoing the roaming above) and face the player.
            placeAt(mob, mobPos)
            mob:clearPath()
            mob:lookAt(playerPos.x, playerPos.y, playerPos.z)

            -- Reveal the player at the chosen spot; moving there re-taps aggro.
            player.actions:move(playerPos.x, playerPos.y, playerPos.z, 30)

            return mob
        end

        it('does not aggro around the wall corner', function()
            local mob = primeAggressor(point.cornerA, point.cornerB)

            -- Precondition on canSee keeps the negative test from passing vacuously.
            assert(not mob:canSee(player), 'player should be hidden around the corner')
            assert(not mob:isEngaged(), 'mob should not aggro a player it cannot see around the corner')
        end)

        it('does not aggro through the thin wall', function()
            local mob = primeAggressor(point.wallA, point.wallB)

            assert(not mob:canSee(player), 'player should be hidden behind the thin wall')
            assert(not mob:isEngaged(), 'mob should not aggro a player it cannot see through the wall')
        end)

        it('aggros across the open gap between the bridge banks', function()
            local mob = primeAggressor(point.bridgeA, point.bridgeC)

            -- Positive control: sight is clear across the gap, so aggro must fire.
            assert(mob:canSee(player), 'player should be in plain sight across the gap')
            assert(mob:isEngaged(), 'mob should aggro a player it can see across the gap')
        end)
    end)

    describe('navmesh navigation', function()
        it('has every surveyed footing point on the navmesh', function()
            local zone = player:getZone()
            assert(zone, 'zone must be populated')

            for name, pos in pairs(point) do
                assert(zone:isNavigablePoint(pos),
                    string.format('surveyed point %s (%.3f, %.3f, %.3f) should be navigable',
                        name, pos.x, pos.y, pos.z))
            end
        end)

        it('the channel between the banks is impassable deep water - only the bridge crosses', function()
            local zone = player:getZone()
            assert(zone, 'zone must be populated')

            -- The midpoint of the straight line between the two stone banks sits over the channel,
            -- clear of the bridge (which is offset to one side at point B).
            assert(zone:getTerrainType(point.bridgeB) == xi.terrain.STONE,
                'the bridge itself should be stone (walkable)')
            assert(zone:getTerrainType(midpoint(point.bridgeA, point.bridgeC)) == xi.terrain.DEEP_WATER,
                'the channel between the banks should be deep water (impassable) - the mob must detour over the bridge')
        end)
    end)

    describe('must path around obstacles instead of attacking through them', function()
        local function engageThroughObstacle(mobPos, playerPos)
            local mob = bloodsucker()
            mob:respawn()
            mob:clearPath()
            placeAt(player, playerPos)
            placeAt(mob, mobPos)

            mob:addEnmity(player, 100, 100)
            mob:engage(player:getTargID())

            return mob
        end

        local function assertPathedIntoView(mob, startPos, ticks, obstacle)
            for _ = 1, ticks do
                xi.test.world:tickEntity(mob)
            end

            assert(distance(mob:getPos(), startPos) > 1.5,
                'mob should have moved off its spot to path around the ' .. obstacle)
            assert(mob:canSee(player),
                'mob should have repositioned until it had line of sight to the player')
        end

        it('paths around the thin wall rather than attacking through it', function()
            -- Point-blank (~1.5y, inside melee range) but the thin wall is between them: the mob has
            -- no line of sight and must not simply stand there swinging through the wall.
            local mob = engageThroughObstacle(point.wallB, point.wallA)

            assert(mob:isEngaged(), 'mob should be engaged on the player')
            assert(distance(mob:getPos(), point.wallA) < 2.0, 'mob should start within melee range of the player')
            assert(not mob:canSee(player), 'the wall should block line of sight at the start')

            assertPathedIntoView(mob, point.wallB, 15, 'wall')
        end)

        it('paths around the wall corner rather than attacking through it', function()
            local mob = engageThroughObstacle(point.cornerB, point.cornerA)

            assert(mob:isEngaged(), 'mob should be engaged on the player')
            assert(not mob:canSee(player), 'the corner should block line of sight at the start')

            assertPathedIntoView(mob, point.cornerB, 20, 'corner')
        end)
    end)
end)
