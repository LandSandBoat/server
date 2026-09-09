local ffi = require('ffi')

describe('Regular mob pet resummoning', function()
    local player
    local owner
    local pet

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BATALLIA_DOWNS })
        owner  = player.entities:get('Goblin_Pathfinder')

        local linkedPet = owner:getPet()
        assert(linkedPet)
        pet = player.entities:get(linkedPet)

        owner:respawn()
        owner:clearPath()
        pet:despawn()
    end)

    it('disables the separate BST Call Beast timer', function()
        assert(owner:getMobMod(xi.mobMod.SPECIAL_SKILL) == 0)
    end)

    it('counts elapsed time from death while the corpse remains', function()
        pet:spawn()
        pet:setHP(0)
        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 437)
        owner:triggerListener('TICK', owner, 810)

        assert(pet:isSpawned(), 'the corpse should still be present')
        assert(owner:getLocalVar('[Pet]Idle') == 1247)
    end)

    it('pauses on a path without losing the accumulated time', function()
        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 20000)
        owner:pathThrough({ owner:getXPos() + 10, owner:getYPos(), owner:getZPos() })
        assert(owner:isFollowingPath())

        owner:triggerListener('TICK', owner, 20000)
        assert(owner:getLocalVar('[Pet]Idle') == 20000)

        owner:clearPath()
        owner:triggerListener('TICK', owner, 400)
        assert(owner:getLocalVar('[Pet]Idle') == 20400)
    end)

    it('does not count while engaged and resets when hate is lost', function()
        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 20000)
        owner:updateEnmity(player)
        xi.test.world:tickEntity(owner)
        assert(owner:isEngaged())

        local idleTime = owner:getLocalVar('[Pet]Idle')
        owner:triggerListener('TICK', owner, 60000)
        assert(owner:getLocalVar('[Pet]Idle') == idleTime)
        assert(not pet:isAlive())

        owner:resetEnmity(player)
        owner:disengage()
        xi.test.world:tickEntity(owner)
        assert(owner:getLocalVar('[Pet]Idle') == 0)
        assert(owner:getLocalVar('[Pet]Counting') == 0)
    end)

    it('does not count while its pet is alive', function()
        pet:spawn()
        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        assert(owner:getLocalVar('[Pet]Idle') == 0)
    end)

    it('does not start a summon before the controller processes new hate', function()
        owner:setLocalVar('[Pet]Counting', 1)
        owner:setLocalVar('[Pet]Idle', 59600)
        owner:addEnmity(player, 100, 100)
        assert(not owner:isEngaged(), 'new hate has not reached the controller yet')

        owner:triggerListener('TICK', owner, 400)
        assert(owner:actionQueueEmpty(), 'pending hate must block the summon animation')
        assert(not pet:isAlive())
    end)

    it('cancels a summon if the owner gains hate during the animation', function()
        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        assert(not owner:actionQueueEmpty())

        owner:addEnmity(player, 100, 100)
        assert(not owner:isEngaged(), 'the summon stun delays engagement')
        xi.test.world:skipTime(3)

        assert(not pet:isAlive(), 'the pending summon must not finish in combat')
        assert(owner:getLocalVar('[Pet]Idle') == 60000)
    end)

    it('starts one three-second summon after sixty seconds idle', function()
        owner:triggerListener('TICK', owner, 400)
        for _ = 1, 149 do
            owner:triggerListener('TICK', owner, 400)
        end

        assert(owner:getLocalVar('[Pet]Idle') == 59600)
        assert(owner:actionQueueEmpty())
        assert(not pet:isAlive())

        owner:triggerListener('TICK', owner, 400)
        assert(not owner:actionQueueEmpty())
        assert(owner:getLocalVar('[Pet]Idle') == 60000)
        assert(not pet:isAlive())

        xi.test.world:skipTime(3)
        assert(pet:isAlive())
        assert(pet:getMaster():getID() == owner:getID())
        assert(owner:getLocalVar('[Pet]Idle') == 0)
        assert(owner:getLocalVar('[Pet]Counting') == 0)
    end)

    it('supplies elapsed milliseconds to TICK without breaking one-argument listeners', function()
        local elapsedTime
        local observedId
        owner:addListener('TICK', 'TEST_ELAPSED', function(_, elapsed)
            elapsedTime = elapsed
        end)

        owner:addListener('TICK', 'TEST_OLD_ARGUMENTS', function(mob)
            observedId = mob:getID()
        end)

        xi.test.world:tickEntity(owner)
        xi.test.world:tick()

        assert(elapsedTime >= 400 and elapsedTime < 1000)
        assert(observedId == owner:getID())
        owner:removeListener('TEST_ELAPSED')
        owner:removeListener('TEST_OLD_ARGUMENTS')
    end)

    it('summons at sixty seconds with the real AI clock', function()
        owner:setMobMod(xi.mobMod.ROAM_COOL, 3600)
        xi.test.world:tickEntity(owner)

        local elapsedTime = 0
        owner:addListener('TICK', 'TEST_SUMMON_CLOCK', function(_, elapsed)
            elapsedTime = elapsedTime + elapsed
        end)

        for _ = 1, 160 do
            xi.test.world:tick()
            if not owner:actionQueueEmpty() then
                break
            end
        end

        assert(not owner:actionQueueEmpty(), 'the summon should have started')
        assert(elapsedTime >= 60000 and elapsedTime < 61000)
        owner:removeListener('TEST_SUMMON_CLOCK')
    end)

    it('leaves a BST pet alive when its owner dies', function()
        pet:spawn()
        owner:setHP(0)
        xi.test.world:tickEntity(owner)
        assert(pet:isAlive())
    end)
end)

describe('Normal pet summon placement', function()
    local player
    local owner
    local pet

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.ROLANBERRY_FIELDS })
        owner  = player.entities:get(17228224)

        local linkedPet = owner:getPet()
        assert(linkedPet)
        pet = player.entities:get(linkedPet)

        owner:despawn()
        owner:spawn()
        owner:clearPath()
        owner:setMobMod(xi.mobMod.ROAM_COOL, 3600)
        pet:despawn()
        player.entities:moveTo(owner)
        xi.test.world:tick()
        owner:clearPath()
    end)

    it('spawns the Rolanberry bee beside its owner on both initial and repeat summons', function()
        for _ = 1, 2 do
            local pos = owner:getPos()
            owner:setSpawn(pos.x + 100, pos.y, pos.z, pos.rot)
            player.packets:clear()
            owner:triggerListener('TICK', owner, 400)
            owner:triggerListener('TICK', owner, 60000)
            xi.test.world:skipTime(3)

            assert(pet:isAlive())
            assert(pet:checkDistance(owner) <= 3, 'pet should spawn on nearby ground')
            assert(math.abs(pet:getYPos() - pos.y) <= 1)
            assert(owner:getZone():isNavigablePoint(pet:getPos()))
            assert(pet:getRotPos() == owner:getRotPos())
            assert(not pet:isFollowingPath(), 'the summoned pet should not start an independent roam path')
            local home = pet:getSpawnPos()
            assert(math.abs(home.x - pet:getXPos()) < 0.01, 'pet home should be its summon position, not the owner home')
            assert(math.abs(home.y - pet:getYPos()) < 0.01)
            assert(math.abs(home.z - pet:getZPos()) < 0.01)

            xi.test.world:tick()
            player.actions:move(pos.x, pos.y, pos.z)
            local receivedPosition = false
            for _, packet in ipairs(player.packets:getIncoming()) do
                if packet.type == 0x00E then
                    local entityId = packet.data[4] + packet.data[5] * 256 + packet.data[6] * 65536 + packet.data[7] * 16777216
                    if entityId == pet:getID() and bit.band(packet.data[0x0A], 1) ~= 0 then
                        local bytes = ffi.new('uint8_t[12]')
                        for offset = 0, 11 do
                            bytes[offset] = packet.data[0x0C + offset]
                        end

                        local position = ffi.cast('float*', bytes)
                        assert(math.abs(position[0] - home.x) < 0.01, 'first pet packet should already be at its summon point')
                        assert(math.abs(position[1] - home.y) < 0.01)
                        assert(math.abs(position[2] - home.z) < 0.01)
                        receivedPosition = true
                        break
                    end
                end
            end

            assert(receivedPosition, 'the nearby player should receive the pet spawn')
            xi.test.world:skipTime(5)
            assert(pet:isAlive(), 'the new pet should not despawn because its owner home is far away')
            assert(pet:checkDistance(owner) < 5, 'the pet should remain near its owner instead of returning to the owner home')
            pet:despawn()
            owner:clearPath()
        end
    end)

    it('honors an explicit spawn point instead of choosing a region position', function()
        local pos = owner:getPos()
        pet:setSpawn(pos.x, pos.y, pos.z, pos.rot)
        pet:spawn()

        assert(pet:isAlive())
        assert(math.abs(pet:getXPos() - pos.x) < 0.01)
        assert(math.abs(pet:getYPos() - pos.y) < 0.01)
        assert(math.abs(pet:getZPos() - pos.z) < 0.01)
    end)

    it('retries blocked ground every three seconds without starting the animation', function()
        local findPosition = GetFurthestValidPosition
        local blocked      = true
        local queries      = 0
        stub('GetFurthestValidPosition', function(mob, distance, angle)
            queries = queries + 1
            if blocked then
                return nil
            end

            return findPosition(mob, distance, angle)
        end)

        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        assert(not pet:isAlive())
        assert(owner:getLocalVar('[Pet]Idle') == 60000)
        assert(owner:actionQueueEmpty(), 'blocked ground must not start an animation')
        assert(queries == 1)

        for _ = 1, 7 do
            owner:triggerListener('TICK', owner, 400)
        end

        assert(queries == 1, 'do not query the ground every AI tick')
        owner:triggerListener('TICK', owner, 200)
        assert(queries == 2)
        assert(owner:actionQueueEmpty())

        blocked = false
        owner:triggerListener('TICK', owner, 2999)
        assert(queries == 2)
        owner:triggerListener('TICK', owner, 1)
        assert(queries == 3)
        assert(not owner:actionQueueEmpty())
        xi.test.world:skipTime(3)
        assert(pet:isAlive())
        assert(owner:getLocalVar('[Pet]Idle') == 0)
        assert(owner:getLocalVar('[Pet]Counting') == 0)
        assert(owner:getLocalVar('[Pet]Retry') == 0)
        assert(queries == 4, 'check the ground again at cast completion')
    end)

    it('rejects ground that becomes unsafe during the animation', function()
        local findPosition = GetFurthestValidPosition
        local blocked      = false
        stub('GetFurthestValidPosition', function(mob, distance, angle)
            if blocked then
                return nil
            end

            return findPosition(mob, distance, angle)
        end)

        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        assert(not owner:actionQueueEmpty())
        blocked = true
        xi.test.world:skipTime(3)
        assert(not pet:isAlive())
        assert(owner:getLocalVar('[Pet]Idle') == 60000)

        blocked = false
        owner:triggerListener('TICK', owner, 3000)
        xi.test.world:skipTime(3)
        assert(pet:isAlive())
    end)

    it('keeps an idle pet near its owner beyond the pet home boundary', function()
        local pos = owner:getPos()
        pet:setSpawn(pos.x, pos.y, pos.z, pos.rot)
        pet:spawn()
        assert(pet:getMobMod(xi.mobMod.DONT_ROAM_HOME) == 1)
        assert(pet:getMobMod(xi.mobMod.NO_DESPAWN) == 0)

        pet:setSpawn(pos.x + 100, pos.y, pos.z, pos.rot)
        pet:setMobMod(xi.mobMod.ROAM_COOL, 0)
        for _ = 1, 30 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(pet)
        end

        assert(pet:isAlive(), 'distance from the summon point must not despawn a following pet')
        assert(pet:checkDistance(owner) < 5, 'the pet must stay with the owner instead of heading home')

        -- Turning the home check back on should despawn the pet at this distance.
        pet:setMobMod(xi.mobMod.DONT_ROAM_HOME, 0)
        pet:clearPath()
        for _ = 1, 10 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(pet)
        end

        assert(not pet:isSpawned())
    end)

    it('still despawns an idle BST pet after its owner dies', function()
        local pos = owner:getPos()
        pet:setSpawn(pos.x, pos.y, pos.z, pos.rot)
        pet:spawn()
        pet:setMobMod(xi.mobMod.ROAM_COOL, 0)
        owner:setHP(0)
        for _ = 1, 30 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(pet)
        end

        assert(not pet:isSpawned(), 'the home-distance exemption must not disable dead-owner cleanup')
    end)

    it('rejects ground points beyond three yalms', function()
        stub('GetFurthestValidPosition', function(mob)
            return { x = mob:getXPos() + 4, y = mob:getYPos(), z = mob:getZPos() }
        end)

        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        xi.test.world:skipTime(3)
        assert(not pet:isAlive())
        assert(owner:getLocalVar('[Pet]Idle') == 60000)
    end)

    it('rejects ground points more than one yalm above or below the owner', function()
        local height = 2
        stub('GetFurthestValidPosition', function(mob)
            return { x = mob:getXPos(), y = mob:getYPos() + height, z = mob:getZPos() }
        end)

        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        xi.test.world:skipTime(3)
        assert(not pet:isAlive())
        assert(owner:getLocalVar('[Pet]Idle') == 60000)

        height = -2
        owner:triggerListener('TICK', owner, 400)
        xi.test.world:skipTime(3)
        assert(not pet:isAlive())
        assert(owner:getLocalVar('[Pet]Idle') == 60000)
    end)

    it('resets on pet spawn even if the pet dies before the next owner tick', function()
        owner:setLocalVar('[Pet]Idle', 60000)
        owner:setLocalVar('[Pet]Counting', 1)
        pet:spawn()
        pet:setHP(0)

        assert(owner:getLocalVar('[Pet]Idle') == 0)
        assert(owner:getLocalVar('[Pet]Counting') == 0)
        owner:triggerListener('TICK', owner, 400)
        assert(owner:getLocalVar('[Pet]Idle') == 0)
    end)

    it('keeps the owner home assignment for callers that do not opt in', function()
        stub('GetFurthestValidPosition', function()
            error('default callers must not query the ground')
        end)

        xi.test.world:setSeed(1710)
        local pos = owner:getPos()
        owner:setSpawn(pos.x + 100, pos.y, pos.z, pos.rot)
        assert(xi.mob.callPets(owner, nil, { inactiveTime = 3000 }))
        xi.test.world:skipTime(3)

        assert(pet:isAlive())
        local home = pet:getSpawnPos()
        assert(math.abs(home.x - pet:getXPos() - 100) < 0.01, 'the default helper should retain its owner home assignment')
        assert(math.abs(home.y - pet:getYPos()) < 0.01)
        assert(math.abs(home.z - pet:getZPos()) < 0.01)
    end)

    it('keeps combat summoning for callers that do not opt in', function()
        assert(xi.mob.callPets(owner, nil, { inactiveTime = 3000 }))
        owner:addEnmity(player, 100, 100)
        xi.test.world:skipTime(3)

        assert(pet:isAlive(), 'default callers must retain their combat summon behavior')
    end)

    it('keeps a fighting BST pet engaged after its owner dies', function()
        local pos = owner:getPos()
        pet:setSpawn(pos.x, pos.y, pos.z, pos.rot)
        pet:spawn()
        pet:setSpawn(pos.x + 100, pos.y, pos.z, pos.rot)
        player:setUnkillable(true)
        pet:addEnmity(player, 100, 100)
        xi.test.world:tickEntity(pet)
        assert(pet:isEngaged())

        owner:setHP(0)
        for _ = 1, 10 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(pet)
        end

        assert(pet:isAlive())
        assert(pet:isEngaged(), 'idle cleanup must not interrupt a fighting pet')
    end)
end)

describe('Regular elemental pet stats', function()
    it('preserves the spell-summoned spirit stats and the tribe pet name', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CASTLE_ZVAHL_BAILEYS })
        local owners = player:getZone():queryEntitiesByName('Demon_Warlock')
        assert(#owners >= 2)

        local owner     = owners[1]
        local oldOwner  = owners[2]
        local pet       = player.entities:get(owner:getPet())
        local oldPet    = player.entities:get(oldOwner:getPet())
        local petName   = pet:getName()
        local modifiers =
        {
            xi.mod.FIRE_RES_RANK, xi.mod.ICE_RES_RANK, xi.mod.WIND_RES_RANK, xi.mod.EARTH_RES_RANK,
            xi.mod.THUNDER_RES_RANK, xi.mod.WATER_RES_RANK, xi.mod.LIGHT_RES_RANK, xi.mod.DARK_RES_RANK,
            xi.mod.PARALYZE_RES_RANK, xi.mod.BIND_RES_RANK, xi.mod.SILENCE_RES_RANK, xi.mod.SLOW_RES_RANK,
            xi.mod.POISON_RES_RANK, xi.mod.LIGHT_SLEEP_RES_RANK, xi.mod.DARK_SLEEP_RES_RANK,
            xi.mod.BLIND_RES_RANK, xi.mod.STUN_RES_RANK, xi.mod.GRAVITY_RES_RANK,
            xi.mod.SLASH_SDT, xi.mod.PIERCE_SDT, xi.mod.HTH_SDT, xi.mod.IMPACT_SDT,
            xi.mod.FIRE_SDT, xi.mod.ICE_SDT, xi.mod.WIND_SDT, xi.mod.EARTH_SDT,
            xi.mod.THUNDER_SDT, xi.mod.WATER_SDT, xi.mod.LIGHT_SDT, xi.mod.DARK_SDT,
            xi.mod.DMGPHYS, xi.mod.UDMGMAGIC,
        }

        owner:spawn()
        oldOwner:spawn()
        assert(owner:getSpellListId() == 0)
        pet:spawn()

        for petId = xi.petId.FIRE_SPIRIT, xi.petId.DARK_SPIRIT do
            oldPet:despawn()
            oldOwner:spawnPet(petId)
            pet:setMobLevel(oldPet:getMainLvl())
            pet:setPetStats(petId)

            assert(pet:getName() == petName)
            assert(oldPet:getName() ~= petName, 'the old spawn path should still rename spirits')
            assert(pet:getMainJob() == oldPet:getMainJob())
            assert(pet:getSubJob() == oldPet:getSubJob())
            assert(pet:getFamily() == oldPet:getFamily())
            assert(pet:getCrystalElement() == oldPet:getCrystalElement())
            assert(pet:getSpellListId() == oldPet:getSpellListId())
            assert(pet:getModelId() == oldPet:getModelId())
            assert(pet:getMaxHP() == oldPet:getMaxHP())
            assert(pet:getMaxMP() == oldPet:getMaxMP())

            for _, modifier in ipairs(modifiers) do
                assert(pet:getMod(modifier) == oldPet:getMod(modifier), string.format('spirit %d modifier %d', petId, modifier))
            end
        end
    end)

    it('gives a normal Fomor Summoner the shared timer and a dark spirit', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.LUFAISE_MEADOWS })
        local owner  = player.entities:get('Fomor_Summoner')

        local linkedPet = owner:getPet()
        assert(linkedPet)
        local pet = player.entities:get(linkedPet)

        owner:spawn()
        owner:clearPath()
        pet:despawn()
        local pos = owner:getPos()
        owner:triggerListener('TICK', owner, 400)
        owner:triggerListener('TICK', owner, 60000)
        xi.test.world:skipTime(3)

        assert(pet:isAlive())
        assert(pet:getName() == 'Fomors_Elemental')
        assert(pet:getMainJob() == xi.job.DRK)
        assert(pet:getCrystalElement() == xi.element.DARK)
        assert(pet:checkDistance(owner) <= 3)
        assert(math.abs(pet:getYPos() - pos.y) <= 1)
        assert(owner:getZone():isNavigablePoint(pet:getPos()))
        local home = pet:getSpawnPos()
        assert(math.abs(home.x - pet:getXPos()) < 0.01)
        assert(math.abs(home.y - pet:getYPos()) < 0.01)
        assert(math.abs(home.z - pet:getZPos()) < 0.01)
    end)

    it('keeps the existing NM spell-summon path', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CASTLE_ZVAHL_BAILEYS })
        local owner  = player.entities:get('Grand_Duke_Batym')

        local linkedPet = owner:getPet()
        assert(linkedPet)
        local pet = player.entities:get(linkedPet)

        owner:spawn()
        pet:despawn()
        assert(owner:getSpellListId() == 31)
        owner:triggerListener('TICK', owner, 60000)
        assert(owner:getLocalVar('[Pet]Counting') == 0)
        assert(owner:actionQueueEmpty())

        owner:spawnPet(xi.petId.ICE_SPIRIT)
        assert(pet:isAlive())
        assert(pet:getMobMod(xi.mobMod.DONT_ROAM_HOME) == 0)
        assert(pet:getName() == 'IceSpirit')
        assert(pet:getMainJob() == xi.job.BLM)
        assert(pet:getSpellListId() == 205)
    end)

    it('keeps the existing SMN pet death rule', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.GIDDEUS })
        local owner  = player.entities:get('Yagudo_Mendicant')

        local linkedPet = owner:getPet()
        assert(linkedPet)
        local pet = player.entities:get(linkedPet)

        owner:spawn()
        pet:spawn()
        assert(pet:isAlive())
        owner:setHP(0)
        xi.test.world:tickEntity(owner)
        assert(not pet:isAlive())
    end)
end)
