-----------------------------------
-- Fomor parties retain their followers across normal death and respawn.
-----------------------------------

local function getPatrol(player, zoneId, leaderKey, index, followers)
    local leaderId = zones[zoneId].mob[leaderKey][index]
    local mobs = {}
    for offset = 0, followers do
        local mob = player.entities:get(leaderId + offset)
        assert(mob, 'missing Fomor party member')
        table.insert(mobs, mob)
    end

    return mobs
end

local function assertPatrol(mobs)
    local superlink = mobs[1]:getMobMod(xi.mobMod.SUPERLINK)
    assert(superlink ~= 0, 'Fomor party has no superlink group')

    for index, mob in ipairs(mobs) do
        assert(mob:isAlive() and mob:isSpawned(), 'Fomor party member did not respawn')
        assert(mob:getMobMod(xi.mobMod.SUPERLINK) == superlink, 'Fomor party has different superlink groups')

        local members = mob:getParty()
        for _, expectedMob in ipairs(mobs) do
            local found = false
            for _, member in ipairs(members) do
                if member:getID() == expectedMob:getID() then
                    found = true
                    break
                end
            end

            assert(found, 'Fomor party is missing an expected member')
        end

        if index > 1 then
            assert(mob:hasFollowTarget(), 'Fomor follower did not resume following')
        end
    end
end

local function killMember(player, mob)
    mob:updateClaim(player)
    mob:takeDamage(2000000000, player)
    xi.test.world:tickEntity(mob)
    for _ = 1, 5 do
        xi.test.world:skipTime(5)
        xi.test.world:tickEntity(mob)
    end

    assert(not mob:isAlive() and not mob:isSpawned(), 'defeated Fomor did not finish despawning')
end

local function advanceRespawns(player, seconds)
    player:setCharVar('FOMOR_HATE', 0)
    xi.test.world:skipTime(seconds + 30)
    xi.test.world:tick(xi.tick.SPAWN)
    for _ = 1, 3 do
        xi.test.world:skipTime(30)
        xi.test.world:tick(xi.tick.SPAWN)
    end
end

local function assertLinks(player, mobs, pullIndex)
    player:setGMHidden(false)
    player:setCharVar('FOMOR_HATE', 0)
    player.entities:moveTo(mobs[pullIndex])
    for _, mob in ipairs(mobs) do
        assert(not mob:isEngaged(), 'Fomor party engaged before the controlled pull')
    end

    mobs[pullIndex]:addEnmity(player, 10000, 10000)

    for _ = 1, 30 do
        xi.test.world:skipTime(1)
        for _, mob in ipairs(mobs) do
            xi.test.world:tickEntity(mob)
        end

        local allEngaged = true
        for _, mob in ipairs(mobs) do
            allEngaged = allEngaged and mob:isEngaged()
        end

        if allEngaged then
            return
        end
    end

    error('pulling one Fomor did not engage its party')
end

describe('Fomor parties', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
        player:setUnkillable(true)
        player:setGMHidden(true)
        player:setCharVar('FOMOR_HATE', 0)
        xi.test.world:setVanaTime(20, 0)
    end)

    it('initializes the upstairs Aqueduct pairs and patrols in the other three zones', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        for _, spec in ipairs({ { 'FOMOR_WARRIOR', 5 }, { 'FOMOR_RANGER', 8 }, { 'FOMOR_BARD', 4 }, { 'FOMOR_THIEF', 4 } }) do
            assertPatrol(getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, spec[1], spec[2], 1))
        end

        for _, spec in ipairs({
            { xi.zone.LUFAISE_MEADOWS, 'FOMOR_NINJA',    1, 1 },
            { xi.zone.MISAREAUX_COAST, 'FOMOR_RED_MAGE', 1, 1 },
            { xi.zone.SACRARIUM,      'FOMOR_BARD',     6, 2 },
        }) do
            player:gotoZone(spec[1])
            player:setUnkillable(true)
            advanceRespawns(player, 0)
            assertPatrol(getPatrol(player, spec[1], spec[2], spec[3], spec[4]))
        end
    end)

    it('restores every upstairs Aqueduct pair through both death orders and repeated lives', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        for _, spec in ipairs({ { 'FOMOR_WARRIOR', 5 }, { 'FOMOR_RANGER', 8 }, { 'FOMOR_BARD', 4 }, { 'FOMOR_THIEF', 4 } }) do
            local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, spec[1], spec[2], 1)
            for _, mob in ipairs(mobs) do
                mob:respawn()
            end

            for cycle = 1, 2 do
                local respawn = GetMobRespawnTime(mobs[1]:getID())
                if cycle == 1 then
                    killMember(player, mobs[2])
                    killMember(player, mobs[1])
                else
                    killMember(player, mobs[1])
                    killMember(player, mobs[2])
                end

                advanceRespawns(player, respawn)
                assertPatrol(mobs)
                assertLinks(player, mobs, cycle)
            end
        end
    end)

    it('keeps a defeated follower down until its living leader completes its life', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, 'FOMOR_WARRIOR', 5, 1)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local respawn = GetMobRespawnTime(mobs[1]:getID())
        killMember(player, mobs[2])
        advanceRespawns(player, respawn)
        assert(mobs[1]:isAlive() and mobs[1]:isSpawned(), 'living leader disappeared after its follower died')
        assert(not mobs[2]:isSpawned(), 'follower respawned before its leader')

        killMember(player, mobs[1])
        advanceRespawns(player, respawn)
        assertPatrol(mobs)
        assertLinks(player, mobs, 2)
    end)

    it('despawns an idle survivor when its leader dies and restores the next patrol', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, 'FOMOR_WARRIOR', 5, 1)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local respawn = GetMobRespawnTime(mobs[1]:getID())
        killMember(player, mobs[1])
        for _ = 1, 6 do
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(mobs[2])
        end

        assert(not mobs[2]:isSpawned(), 'idle follower survived its despawned leader')
        advanceRespawns(player, respawn)
        assertPatrol(mobs)
        assertLinks(player, mobs, 1)
    end)

    it('retains the night window when patrols return in Lufaise and Misareaux', function()
        for _, spec in ipairs({
            { xi.zone.LUFAISE_MEADOWS, 'FOMOR_NINJA'    },
            { xi.zone.MISAREAUX_COAST, 'FOMOR_RED_MAGE' },
        }) do
            xi.test.world:setVanaTime(20, 0)
            player:gotoZone(spec[1])
            player:setUnkillable(true)
            local mobs = getPatrol(player, spec[1], spec[2], 1, 1)
            for _, mob in ipairs(mobs) do
                mob:respawn()
            end

            local respawn = GetMobRespawnTime(mobs[1]:getID())
            killMember(player, mobs[2])
            killMember(player, mobs[1])
            xi.test.world:setVanaTime(12, 0)
            advanceRespawns(player, respawn)
            assert(not mobs[1]:isSpawned() and not mobs[2]:isSpawned(), 'night patrol respawned during the day')

            xi.test.world:setVanaTime(20, 0)
            advanceRespawns(player, 0)
            assertPatrol(mobs)
            assertLinks(player, mobs, 2)
        end
    end)

    it('restores both followers of the Sacrarium Bard patrol', function()
        player:gotoZone(xi.zone.SACRARIUM)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.SACRARIUM, 'FOMOR_BARD', 6, 2)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local respawn = GetMobRespawnTime(mobs[1]:getID())
        killMember(player, mobs[3])
        killMember(player, mobs[2])
        killMember(player, mobs[1])
        advanceRespawns(player, respawn)
        assertPatrol(mobs)
        assertLinks(player, mobs, 3)
    end)

    it('waits for a recent follower corpse to finish fading when its leader returns', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, 'FOMOR_WARRIOR', 5, 1)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        -- Read the configured timer before recovery can change it.
        local followerRespawn = GetMobRespawnTime(mobs[2]:getID())
        player:setGMHidden(false)
        player.entities:moveTo(mobs[2])
        mobs[2]:addEnmity(player, 10000, 10000)
        xi.test.world:skipTime(1)
        assert(mobs[2]:isEngaged(), 'follower did not engage before its leader died')
        killMember(player, mobs[1])
        assert(mobs[2]:isAlive() and mobs[2]:isEngaged(), 'fighting follower did not survive its leader')

        local remaining = mobs[1]:getRespawnTime()
        assert(remaining > 20, 'leader respawn is too close to prepare a recent corpse')
        xi.test.world:skipTime(remaining - 20)
        assert(not mobs[1]:isSpawned(), 'leader returned before the recent follower death')
        mobs[2]:updateClaim(player)
        mobs[2]:takeDamage(2000000000, player)
        xi.test.world:tickEntity(mobs[2])
        assert(not mobs[2]:isAlive() and mobs[2]:isSpawned(), 'follower is not a visible corpse')
        player:setCharVar('FOMOR_HATE', 0)

        -- Spawn waves advance the clock without ticking the corpse's AI.
        xi.test.world:tick(xi.tick.SPAWN)
        xi.test.world:tick(xi.tick.SPAWN)
        assert(mobs[1]:isAlive() and mobs[1]:isSpawned(), 'leader did not return during the corpse fade')
        assert(not mobs[2]:isAlive() and mobs[2]:isSpawned(), 'follower corpse was replaced before it faded')

        for _ = 1, 8 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mobs[2])
        end

        assertPatrol(mobs)
        assert(GetMobRespawnTime(mobs[2]:getID()) == followerRespawn, 'recovery changed the follower respawn timer')
        assertLinks(player, mobs, 1)
    end)

    it('cancels queued corpse recovery if its returned leader dies again', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, 'FOMOR_WARRIOR', 5, 1)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        player:setGMHidden(false)
        player.entities:moveTo(mobs[2])
        mobs[2]:addEnmity(player, 10000, 10000)
        xi.test.world:skipTime(1)
        assert(mobs[2]:isEngaged(), 'follower did not engage before its leader died')
        killMember(player, mobs[1])
        assert(mobs[2]:isAlive() and mobs[2]:isEngaged(), 'fighting follower did not survive its leader')

        local remaining = mobs[1]:getRespawnTime()
        assert(remaining > 20, 'leader respawn is too close to prepare a recent corpse')
        xi.test.world:skipTime(remaining - 20)
        assert(not mobs[1]:isSpawned(), 'leader returned before the recent follower death')
        mobs[2]:updateClaim(player)
        mobs[2]:takeDamage(2000000000, player)
        xi.test.world:tickEntity(mobs[2])
        assert(not mobs[2]:isAlive() and mobs[2]:isSpawned(), 'follower is not a visible corpse')
        player:setCharVar('FOMOR_HATE', 0)

        xi.test.world:tick(xi.tick.SPAWN)
        xi.test.world:tick(xi.tick.SPAWN)
        assert(mobs[1]:isAlive() and mobs[1]:isSpawned(), 'leader did not return during the corpse fade')
        killMember(player, mobs[1])
        for _ = 1, 4 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mobs[2])
        end

        assert(not mobs[2]:isSpawned(), 'queued recovery outlived its leader')
        assert(mobs[2]:actionQueueEmpty(), 'cancelled follower recovery remained queued')
        advanceRespawns(player, GetMobRespawnTime(mobs[1]:getID()))
        assertPatrol(mobs)
    end)

    it('leaves a Dragoon pet to its owner while recovering the ordinary follower', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, 'FOMOR_DRAGOON', 1, 2)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local master = mobs[2]:getMaster()
        assert(master and master:getID() == mobs[1]:getID(), 'Dragoon patrol offset one is not its real pet')
        killMember(player, mobs[3])
        killMember(player, mobs[2])
        killMember(player, mobs[1])

        local remaining = mobs[1]:getRespawnTime()
        assert(remaining > 20, 'leader respawn is too close to inspect its spawn listeners')
        xi.test.world:skipTime(remaining - 20)
        assert(not mobs[1]:isSpawned(), 'Dragoon leader returned before its spawn wave')
        xi.test.world:tick(xi.tick.SPAWN)
        xi.test.world:tick(xi.tick.SPAWN)

        assert(mobs[1]:isAlive() and mobs[1]:isSpawned(), 'Dragoon leader did not return')
        assert(not mobs[2]:isSpawned(), 'Dragoon pet spawned before its owner performed Call Wyvern')
        assert(mobs[2]:actionQueueEmpty(), 'Fomor party recovery queued the Dragoon pet')
        assert(not mobs[3]:actionQueueEmpty(), 'Fomor party recovery did not queue the ordinary follower')

        for _ = 1, 12 do
            xi.test.world:skipTime(1)
            for _, mob in ipairs(mobs) do
                xi.test.world:tickEntity(mob)
            end
        end

        assert(mobs[3]:isAlive() and mobs[3]:isSpawned(), 'ordinary Dragoon patrol follower did not return')
        assert(mobs[3]:hasFollowTarget(), 'ordinary Dragoon patrol follower did not resume following')
    end)

    it('preserves a fighting survivor and leaves no stale follower respawn', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local mobs = getPatrol(player, xi.zone.PHOMIUNA_AQUEDUCTS, 'FOMOR_WARRIOR', 5, 1)
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local respawn = GetMobRespawnTime(mobs[1]:getID())
        assertLinks(player, mobs, 2)
        killMember(player, mobs[1])
        mobs[2]:setHP(math.floor(mobs[2]:getMaxHP() / 2))
        local survivorHP = mobs[2]:getHP()
        advanceRespawns(player, respawn)
        assertPatrol(mobs)
        assert(mobs[2]:isEngaged(), 'surviving follower stopped fighting when its leader returned')
        assert(mobs[2]:getHP() == survivorHP, 'leader respawn reset its living follower')

        killMember(player, mobs[2])
        killMember(player, mobs[1])
        advanceRespawns(player, respawn)
        assertPatrol(mobs)
        assert(mobs[2]:getRespawnTime() == 0, 'recovered follower retained a pending respawn')
        assertLinks(player, mobs, 2)
        mobs[2]:setHP(math.floor(mobs[2]:getMaxHP() / 2))
        local recoveredHP = mobs[2]:getHP()
        advanceRespawns(player, GetMobRespawnTime(mobs[2]:getID()))
        assert(mobs[2]:isEngaged(), 'stale respawn interrupted the recovered follower')
        assert(mobs[2]:getHP() == recoveredHP, 'stale respawn reset the recovered follower')
        assert(mobs[2]:getRespawnTime() == 0, 'recovered follower acquired another pending respawn')
    end)

    it('keeps guard respawns synchronized to the last surviving member', function()
        player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
        player:setUnkillable(true)
        local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
        local mobs = {
            player.entities:get(ID.mob.FOMOR_PALADIN[2]),
            player.entities:get(ID.mob.FOMOR_SAMURAI[2]),
            player.entities:get(ID.mob.FOMOR_RED_MAGE[1]),
        }
        for _, mob in ipairs(mobs) do
            mob:respawn()
        end

        local respawn = GetMobRespawnTime(mobs[1]:getID())
        killMember(player, mobs[1])
        killMember(player, mobs[2])
        advanceRespawns(player, respawn)
        assert(not mobs[1]:isSpawned() and not mobs[2]:isSpawned(), 'guards returned while a member remained alive')
        assert(mobs[3]:isAlive() and mobs[3]:isSpawned(), 'surviving guard disappeared')

        killMember(player, mobs[3])
        advanceRespawns(player, respawn)
        for _, mob in ipairs(mobs) do
            assert(mob:isAlive() and mob:isSpawned(), 'guard did not return with its group')
            assert(bit.band(mob:getRoamFlags(), xi.roamFlag.SCRIPTED) ~= 0, 'guard lost its scripted roam flag')
            assert(not mob:hasFollowTarget(), 'guard started following a party leader')
        end
    end)
end)
