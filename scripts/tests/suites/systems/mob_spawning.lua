-- TODO: Not yet converted
---@type TestSuite
local suite = {}

---@param mobs CBaseEntity[]
---@return CBaseEntity
local function assertExactlyOneAlive(mobs)
    local aliveMob = nil
    for _, mob in ipairs(mobs) do
        if mob:isAlive() then
            assert(aliveMob == nil, 'Another mob is alive in this slot.')
            aliveMob = mob
        end
    end

    assert(aliveMob ~= nil, 'No mob is alive in slot.')
    return aliveMob
end

---@param ... integer
---@return CBaseEntity[]
local function getMobs(...)
    local result = {}
    for i, id in ipairs({ ... }) do
        result[i] = GetEntityByID(id)
        assert(result[i] ~= nil, 'Did not find mob with ID %u', id)
    end

    return result
end

---@param world SimulationWorld
---@param zoneId xi.zone
---@param mobIds integer[]
local function verifyAllSpawnEventuallyWithExactlyOneAlive(world, zoneId, mobIds)
    local client, _ = world:spawnPlayer({ zone = zoneId })

    -- Mobs sharing a slot
    local mobs = getMobs(unpack(mobIds))

    -- Keep track of which mobs in the slot have spawned such that it ensures all of them eventually spawn
    local hasSpawnedBefore = {}
    local spawnedCount = 0

    local maxIterations = 10000
    for _ = 1, maxIterations do
        local mob = assertExactlyOneAlive(mobs)

        -- Keep track of which mobs in the slot have spawned
        if not hasSpawnedBefore[mob:getID()] then
            hasSpawnedBefore[mob:getID()] = true
            spawnedCount = spawnedCount + 1

            if spawnedCount == #mobs then
                -- All of the available mobs in the slot have now been spawned at least once
                break
            end
        end

        client:claimAndKillMob(mob)

        -- Wait for respawn
        world:skipTime({ minutes = 20 })
        world:tick()
    end

    assert(spawnedCount == #mobs, string.format('Not all mobs expected appeared after %u respawns.', maxIterations))
end

suite['Exactly one random mob in spawn slot allowed at a time'] = function(world)
    -- Verify with statues sharing a slot in RuAvitau
    verifyAllSpawnEventuallyWithExactlyOneAlive(
        world,
        xi.zone.THE_SHRINE_OF_RUAVITAU,
        { 17506408, 17506411, 17506414, 17506417 }
    )
end

suite['Exactly one random mob in spawn slot that has a chanced NM spawn allowed at a time'] = function(world)
    -- Verify with Stray Mary and its placeholders
    verifyAllSpawnEventuallyWithExactlyOneAlive(
        world,
        xi.zone.KONSCHTAT_HIGHLANDS,
        { 17219791, 17219928, 17219795, 17219933 }
    )
end

suite['NM spawning'] = function(world)
    local client, _ = world:spawnPlayer({ zone = xi.zone.VALKURM_DUNES })

    -- Valkurm Emperor and PH
    local placeholders = getMobs(17199434)
    local nm = client:getEntity(17199438)
    assert(nm)

    local maxIterations = 10000
    for _ = 1, maxIterations do
        if nm:isAlive() then
            break
        end

        for _, ph in ipairs(placeholders) do
            client:claimAndKillMob(ph)
        end

        -- Wait for respawn
        world:skipTime({ minutes = 10 })
        world:tick()
    end

    assert(nm)
    assert(nm:isAlive(), string.format('NM did not spawn even after killing placeholders %u times.', maxIterations))

    client:claimAndKillMob(nm)
    assert(nm:isDead(), 'NM did not die as expected.')

    -- Wait for respawn
    world:skipTime({ minutes = 10 })
    world:tick()

    -- NM did not respawn and PHs are all alive again.
    assert(nm:isDead(), 'NM should not respawn immediately after being killed.')
    for _, PH in ipairs(placeholders) do
        assert(PH:isAlive(), string.format('Expected PH with ID %u to be alive.', PH:getID()))
    end
end

suite['NM spawning multi'] = function(world)
    local client, _ = world:spawnPlayer({ zone = xi.zone.UPPER_DELKFUTTS_TOWER })

    -- Testing multiple PHs that can spawn NMs with different IDs - in this case, Enkelados.
    local placeholders = getMobs(17424388, 17424426)
    local nms = getMobs(17424385, 17424423)
    local spawnedNmCounts = {}
    local satisfiedNmCount = 0
    local waitForAtleastCount = 3

    local maxIterations = 10000
    for _ = 1, maxIterations do
        for _, nm in ipairs(nms) do
            if nm:isAlive() then
                if spawnedNmCounts[nm:getID()] == nil then
                    spawnedNmCounts[nm:getID()] = 1
                else
                    spawnedNmCounts[nm:getID()] = spawnedNmCounts[nm:getID()] + 1
                end

                -- If the NM has spawned enough times, mark it as done
                if spawnedNmCounts[nm:getID()] == waitForAtleastCount then
                    satisfiedNmCount = satisfiedNmCount + 1
                end

                client:claimAndKillMob(nm)
            end
        end

        if satisfiedNmCount == #nms then
            break
        end

        for _, ph in ipairs(placeholders) do
            if ph:isAlive() then
                client:claimAndKillMob(ph)
            end
        end

        -- Wait for respawns
        world:skipTime({ minutes = 20 })
        world:tick()
    end

    assert(#nms == satisfiedNmCount,
        string.format('Not all NMs spawned after killing placeholders %u times.', maxIterations))
end

return suite
