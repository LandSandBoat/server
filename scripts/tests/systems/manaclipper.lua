local deckBoundary =
{
    { -11.15,  -5.81 },
    {  -9.66, -10.61 },
    {  -9.78, -15.83 },
    {  -4.79, -18.21 },
    {   0.13, -16.25 },
    {   4.65, -17.67 },
    {   9.99, -15.77 },
    {   9.51, -10.79 },
    {  11.18,  -6.05 },
    {  10.05,   3.86 },
    {   0.04,   1.60 },
    {  -9.95,   3.68 },
}

local function isInsideDeck(position)
    local inside   = false
    local previous = deckBoundary[#deckBoundary]
    for _, point in ipairs(deckBoundary) do
        local edgeX = previous[1] - point[1]
        local edgeZ = previous[2] - point[2]
        if
            math.abs(edgeX * (position.z - point[2]) - edgeZ * (position.x - point[1])) <= 0.001 and
            position.x >= math.min(point[1], previous[1]) - 0.001 and
            position.x <= math.max(point[1], previous[1]) + 0.001 and
            position.z >= math.min(point[2], previous[2]) - 0.001 and
            position.z <= math.max(point[2], previous[2]) + 0.001
        then
            return true
        end

        if
            (point[2] > position.z) ~= (previous[2] > position.z) and
            position.x < (previous[1] - point[1]) * (position.z - point[2]) / (previous[2] - point[2]) + point[1]
        then
            inside = not inside
        end

        previous = point
    end

    return inside
end

describe('Manaclipper mobs', function()
    local ID = zones[xi.zone.MANACLIPPER]
    local levelRanges =
    {
        [ID.mob.CUTTER]           = { 31, 34 },
        [ID.mob.FATTY_PUGIL]      = { 25, 34 },
        [ID.mob.URAGNITE[1]]      = { 31, 35 },
        [ID.mob.URAGNITE[2]]      = { 35, 40 },
        [ID.mob.CLOT[1]]          = { 31, 35 },
        [ID.mob.CLOT[2]]          = { 36, 37 },
        [ID.mob.COLOSSAL_CALAMARI] = { 41, 42 },
    }

    ---@type CClientEntityPair
    local player
    local zone
    local mobs
    local now
    local roll
    local lifetime
    local nextSpawnTime
    local spawnCalls
    local rollCount
    local rolls
    local spawnPositions
    local boarding
    local levelRangesChanged

    before_each(function()
        levelRangesChanged = false

        mobs           = {}
        spawnPositions = {}
        zone           = nil
        nextSpawnTime  = nil
        boarding       = true

        -- Skip Zoredonite's roll while boarding.
        local getMobByID = GetMobByID
        stub('GetMobByID', function(mobId)
            if boarding and mobId == ID.mob.ZOREDONITE then
                return nil
            end

            return getMobByID(mobId)
        end)

        player = xi.test.world:spawnPlayer({ zone = xi.zone.MANACLIPPER })
        player:gotoZone(xi.zone.WEST_RONFAURE)
        boarding = false
        zone = GetZone(xi.zone.MANACLIPPER)
        assert(zone, 'Manaclipper is not loaded')

        for _, mobId in ipairs({ ID.mob.CUTTER, ID.mob.FATTY_PUGIL, ID.mob.URAGNITE[1], ID.mob.URAGNITE[2], ID.mob.CLOT[1], ID.mob.CLOT[2], ID.mob.COLOSSAL_CALAMARI }) do
            local mob = player.entities:get(mobId)
            assert(mob, 'Manaclipper mob is not loaded')
            spawnPositions[mobId] = mob:getSpawnPos()
            mob:despawn()
            table.insert(mobs, mob)
        end

        nextSpawnTime = zone:getLocalVar('nextSpawnTime')
        now           = 1000000
        roll          = 15
        lifetime      = 222
        rollCount     = 0
        rolls         = nil

        stub('GetSystemTime', function()
            return now
        end)

        stub('math.randomInt', function(minimum, maximum)
            if minimum == 1 and maximum == 100 then
                rollCount = rollCount + 1
                return rolls and rolls[rollCount] or roll
            elseif minimum == 222 and maximum == 312 then
                return lifetime
            end

            return maximum
        end)

        spawnCalls = spy('SpawnMob')
        xi.zones.Manaclipper.Zone.onInitialize(zone)
    end)

    after_each(function()
        for _, mob in ipairs(mobs) do
            if levelRangesChanged then
                local levels = levelRanges[mob:getID()]
                mob:setLevelRange(levels[1], levels[2])
            end

            mob:removeListener('MANACLIPPER_POSITION_TEST')
            mob:despawn()
            local position = spawnPositions[mob:getID()]
            mob:setSpawn(position.x, position.y, position.z, position.rot)
        end

        if zone and nextSpawnTime then
            zone:setLocalVar('nextSpawnTime', nextSpawnTime)
        end
    end)

    it('waits one minute and processes a wave only once', function()
        assert(zone:getLocalVar('nextSpawnTime') == now + 60)

        now = now + 59
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(rollCount == 0)

        now = now + 1
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)
        assert(rollCount == 7)
        assert(zone:getLocalVar('nextSpawnTime') == now + 60)

        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)
        assert(rollCount == 7)
    end)

    it('rolls each unspawned mob independently every minute after a successful wave', function()
        rolls = { 16, 15, 100, 1, 16, 15, 100 }
        now   = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(3)
        assert(rollCount == 7, 'a failed or successful roll skipped another mob')
        assert(zone:getLocalVar('nextSpawnTime') == now + 60)

        rolls = nil
        now   = now + 59
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(3)
        assert(rollCount == 7)

        now = now + 1
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)
        assert(rollCount == 11, 'the next minute did not roll exactly the four remaining mobs')

        for _, mob in ipairs(mobs) do
            mob.assert:isSpawned()
        end
    end)

    it('accepts fifteen and rejects sixteen without retrying the failed wave', function()
        roll = 16
        now  = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(rollCount == 7)
        assert(zone:getLocalVar('nextSpawnTime') == now + 60)

        roll = 15
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(rollCount == 7)

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)
        assert(rollCount == 14)
    end)

    it('does not replay missed waves after a long gap', function()
        roll = 16
        now  = now + 600
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(rollCount == 7)
        assert(zone:getLocalVar('nextSpawnTime') == now + 60)

        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(rollCount == 7)
    end)

    it('spawns each available deck slot once and excludes fishing mobs and Zoredonite', function()
        local otherMobs = {}
        for _, mob in pairs(zone:getMobs()) do
            local mobId    = mob:getID()
            local ordinary = false
            for _, deckMob in ipairs(mobs) do
                if deckMob:getID() == mobId then
                    ordinary = true
                    break
                end
            end

            if not ordinary then
                otherMobs[mobId] = mob:isSpawned()
            end
        end

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)
        assert(rollCount == 7)

        for _, mob in ipairs(mobs) do
            mob.assert:isSpawned()
            assert(mob:getMobMod(xi.mobMod.IDLE_DESPAWN) == 222)
        end

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)
        assert(rollCount == 7, 'an occupied slot received another spawn roll')

        for mobId, spawned in pairs(otherMobs) do
            local mob = player.entities:get(mobId)
            assert(mob and mob:isSpawned() == spawned, 'ordinary waves changed a fishing mob or Zoredonite')
        end
    end)

    it('keeps a corpse occupied until it fully disappears', function()
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local mob = player.entities:get(ID.mob.CUTTER)
        assert(mob, 'Cutter is not loaded')
        mob:setHP(0)
        xi.test.world:tickEntity(mob)
        assert(not mob:isAlive())
        mob.assert:isSpawned()

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(rollCount == 0, 'a live mob or corpse received a spawn roll')
        assert(not mob:isAlive(), 'wave revived a corpse')

        mob:despawn()
        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(1)
        assert(mob:isAlive())
    end)

    it('gives every ordinary mob the maximum idle lifetime when selected', function()
        lifetime = 312
        now      = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)

        for _, mob in ipairs(mobs) do
            mob.assert:isSpawned()
            assert(mob:getMobMod(xi.mobMod.IDLE_DESPAWN) == 312)
        end
    end)

    it('spawns each deck slot within its captured level bounds', function()
        for _, mob in ipairs(mobs) do
            local levels = levelRanges[mob:getID()]
            mob:respawn()
            local level = mob:getMainLvl()
            assert(level >= levels[1] and level <= levels[2])
        end
    end)

    it('initializes every level within the captured bounds', function()
        levelRangesChanged = true

        for _, mob in ipairs(mobs) do
            local mobId  = mob:getID()
            local levels = levelRanges[mobId]
            for level = levels[1], levels[2] do
                mob:setLevelRange(level, level)
                mob:respawn()

                assert(mob:getMainLvl() == level, 'the mob did not use its native level range')
                assert(mob:getHP() == mob:getMaxHP(), 'the mob did not spawn with full HP')
                assert(mob:getMobMod(xi.mobMod.IDLE_DESPAWN) == 222)

                if mobId == ID.mob.URAGNITE[1] or mobId == ID.mob.URAGNITE[2] then
                    assert(mob:getAnimationSub() == 4)
                    assert(mob:getMobMod(xi.mobMod.SKILL_LIST) == 251)
                    assert(mob:getLocalVar('[uragnite]chanceToShell') == 20)
                    assert(mob:hasListener('ROAM_TICK'))
                    assert(mob:hasListener('TAKE_DAMAGE'))
                end
            end
        end
    end)

    it('uses the deck region instead of a fixed spawn point', function()
        local spawnedPositions = {}
        for _, mob in ipairs(mobs) do
            mob:setSpawn(100, 100, 100)
            mob:addListener('SPAWN', 'MANACLIPPER_POSITION_TEST', function(spawnedMob)
                spawnedPositions[spawnedMob:getID()] = spawnedMob:getPos()
            end)
        end

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        spawnCalls:called(7)

        for _, mob in ipairs(mobs) do
            local spawnedPosition = spawnedPositions[mob:getID()]
            assert(spawnedPosition, 'spawn position was not recorded')
            for _, position in ipairs({ mob:getSpawnPos(), spawnedPosition }) do
                assert(zone:isNavigablePoint(position), 'spawn point is not walkable')
                assert(isInsideDeck(position), 'spawn point is outside the deck region')
                assert(position.y >= -3.7 and position.y <= -2.5, 'spawn point is off the deck')
            end
        end
    end)

    it('stays on the deck while roaming', function()
        xi.test.world:setSeed(20260923)
        lifetime = 312
        now      = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)

        local moved = false
        for _ = 1, 500 do
            xi.test.world:tick()
            for _, mob in ipairs(mobs) do
                xi.test.world:tickEntity(mob)
                mob.assert:isSpawned()

                local position = mob:getPos()
                assert(isInsideDeck(position), 'mob walked outside the deck region')
                assert(position.y >= -3.7 and position.y <= -2.5, 'mob walked off the deck')

                local spawn = mob:getSpawnPos()
                if math.abs(position.x - spawn.x) + math.abs(position.z - spawn.z) > 1 then
                    moved = true
                end
            end
        end

        assert(moved, 'the deck mobs never moved')
    end)

    it('keeps the wave and existing mobs when passengers board and leave', function()
        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        local deadline = zone:getLocalVar('nextSpawnTime')

        now = now + 20
        boarding = true
        player:gotoZone(xi.zone.MANACLIPPER)
        local secondPlayer = xi.test.world:spawnPlayer({ zone = xi.zone.MANACLIPPER })
        boarding = false
        spawnCalls:called(7)
        assert(zone:getLocalVar('nextSpawnTime') == deadline)

        for _, passenger in ipairs({ player, secondPlayer }) do
            xi.zones.Manaclipper.Zone.onTransportEvent(passenger, xi.zone.MANACLIPPER, '')
            passenger.events:expect({ eventId = 100 })
            passenger.events:finish()
            passenger.events:finish()
            assert(passenger:getZoneID() == xi.zone.BIBIKI_BAY)
        end

        spawnCalls:called(7)
        assert(zone:getLocalVar('nextSpawnTime') == deadline)

        local spawned = 0
        for _, mob in ipairs(mobs) do
            if mob:isSpawned() then
                spawned = spawned + 1
            end
        end

        assert(spawned == 7, 'boarding or arrival removed the existing deck mob')
    end)

    it('restores Uragnite attacks after expiring inside its shell', function()
        local mob = player.entities:get(ID.mob.URAGNITE[1])
        assert(mob, 'Uragnite is not loaded')
        local mobId = mob:getID()

        lifetime = 230
        for _, candidate in ipairs(mobs) do
            local candidateId = candidate:getID()
            if candidateId ~= mobId then
                SpawnMob(candidateId)
            end
        end

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        mob.assert:isSpawned()

        xi.test.world:skipTime(184)
        mob:clearPath()
        mob:triggerListener('ROAM_TICK', mob)
        xi.test.world:skipTime(36)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 5, 'Uragnite did not close its shell')

        xi.test.world:skipTime(11)
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(mob)
        mob.assert.no:isSpawned()

        xi.test.world:skipTime(5)
        now = now + 240
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        mob.assert:isSpawned()
        assert(mob:getAnimationSub() == 4)

        boarding = true
        player:gotoZone(xi.zone.MANACLIPPER)
        boarding = false
        player.entities:moveTo(mobId)
        player:setUnkillable(true)
        player.packets:clear()
        mob:addEnmity(player, 100, 100)

        for _ = 1, 15 do
            xi.test.world:tickEntity(mob)
            xi.test.world:skipTime(1)
        end

        local attacks = 0
        for _, packet in ipairs(player.packets:actionPackets()) do
            if
                packet.m_uID == mobId and
                packet.cmd_no == xi.action.category.BASIC_ATTACK
            then
                attacks = attacks + 1
            end
        end

        assert(attacks > 0, 'the respawned Uragnite cannot auto-attack')
    end)

    it('despawns an idle mob and lets a later wave reuse its slot', function()
        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)

        local mob
        for _, candidate in ipairs(mobs) do
            if candidate:isSpawned() then
                mob = candidate
                break
            end
        end

        assert(mob, 'the first wave did not spawn a mob')
        mob:clearPath()

        -- skipTime leaves the spawn clock unchanged.
        xi.test.world:skipTime(217)
        xi.test.world:tickEntity(mob)
        mob.assert:isSpawned()

        xi.test.world:skipTime(10)
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(mob)
        mob.assert.no:isSpawned()

        xi.test.world:skipTime(360)
        xi.test.world:tick(xi.tick.SPAWN)
        mob.assert.no:isSpawned()

        now = now + 60
        xi.zones.Manaclipper.Zone.onZoneTick(zone)
        mob.assert:isSpawned()
    end)
end)
