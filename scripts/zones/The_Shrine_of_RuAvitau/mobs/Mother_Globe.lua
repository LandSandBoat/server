-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Mother Globe
-- TODO: Looked like pets had an additional effect: stun with an unknown proc rate
-- TODO: "Links with Slave Globes, and Slave Globes link with Defenders. Defenders do not link with Slave Globes or Mother Globe."
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

local slaveGlobes =
{
    ID.mob.MOTHER_GLOBE + 1,
    ID.mob.MOTHER_GLOBE + 2,
    ID.mob.MOTHER_GLOBE + 3,
    ID.mob.MOTHER_GLOBE + 4,
    ID.mob.MOTHER_GLOBE + 5,
    ID.mob.MOTHER_GLOBE + 6,
}

local callPetParams =
{
    inactiveTime = 5000,
    dieWithOwner = true,
    maxSpawns = 1,
}

local pathingSections =
{
    -- Northwest
    {
        { x = 832.45, y = -99.65, z = -565.00 },
        { x = 834.79, y = -99.67, z = -554.25 },
        { x = 842.90, y = -99.94, z = -549.05 },
        { x = 845.66, y = -99.46, z = -555.50 },
        { x = 840.26, y = -99.42, z = -563.39 },
        { x = 841.66, y = -99.42, z = -571.71 },
        { x = 849.51, y = -99.42, z = -561.49 },
    },
    -- North
    {
        { x = 849.51, y = -99.42,  z = -561.49 },
        { x = 847.32, y = -99.58,  z = -553.49 },
        { x = 858.75, y = -100.00, z = -542.83 },
        { x = 860.90, y = -99.80,  z = -550.61 },
        { x = 860.48, y = -99.42,  z = -560.12 },
        { x = 869.18, y = -99.42,  z = -559.25 },
        { x = 870.88, y = -99.73,  z = -551.46 },
    },
    -- Northeast
    {
        { x = 870.88, y = -99.73,  z = -551.46 },
        { x = 869.88, y = -99.42,  z = -558.37 },
        { x = 878.95, y = -99.42,  z = -562.44 },
        { x = 886.04, y = -99.67,  z = -554.98 },
        { x = 891.75, y = -100.03, z = -563.94 },
        { x = 882.36, y = -99.42,  z = -569.62 },
    },
    -- East
    {
        { x = 882.36, y = -99.42,  z = -569.62 },
        { x = 890.97, y = -99.94,  z = -567.80 },
        { x = 898.65, y = -100.00, z = -578.96 },
        { x = 892.48, y = -100.02, z = -579.11 },
        { x = 882.03, y = -99.42,  z = -579.31 },
        { x = 881.86, y = -99.42,  z = -589.81 },
        { x = 891.76, y = -100.03, z = -591.55 },
    },
    -- Southeast
    {
        { x = 891.76, y = -100.03, z = -591.55 },
        { x = 882.12, y = -99.42,  z = -591.05 },
        { x = 878.32, y = -99.42,  z = -598.61 },
        { x = 884.73, y = -99.60,  z = -604.82 },
        { x = 876.06, y = -100.02, z = -612.56 },
        { x = 874.10, y = -99.42,  z = -603.22 },
    },
    -- South
    {
        { x = 874.10, y = -99.42,  z = -603.22 },
        { x = 875.18, y = -100.03, z = -612.02 },
        { x = 861.14, y = -100.00, z = -618.96 },
        { x = 860.36, y = -99.81,  z = -609.44 },
        { x = 859.46, y = -99.42,  z = -599.01 },
        { x = 849.40, y = -99.42,  z = -598.75 },
        { x = 845.80, y = -99.81,  z = -609.53 },
    },
    -- Southwest
    {
        { x = 845.80, y = -99.81, z = -609.53 },
        { x = 847.18, y = -99.42, z = -600.09 },
        { x = 840.99, y = -99.42, z = -599.33 },
        { x = 836.33, y = -99.59, z = -605.44 },
        { x = 828.94, y = -99.95, z = -597.17 },
        { x = 837.12, y = -99.42, z = -593.98 },
    },
    -- West
    {
        { x = 837.12, y = -99.42,  z = -593.98 },
        { x = 828.66, y = -99.97,  z = -596.25 },
        { x = 823.02, y = -100.00, z = -579.41 },
        { x = 832.06, y = -99.67,  z = -580.32 },
        { x = 840.79, y = -99.42,  z = -580.07 },
        { x = 841.48, y = -99.42,  z = -570.20 },
        { x = 831.31, y = -99.74,  z = -565.11 },
    },
    -- Center
    {
        { x = 850.52, y = -99.42, z = -570.99 },
        { x = 860.07, y = -99.42, z = -568.35 },
        { x = 868.55, y = -99.42, z = -570.77 },
        { x = 870.59, y = -99.42, z = -581.20 },
        { x = 868.05, y = -99.42, z = -591.39 },
        { x = 860.33, y = -99.42, z = -592.56 },
        { x = 850.36, y = -99.42, z = -592.10 },
        { x = 860.61, y = -99.42, z = -584.37 },
    },
}

-- Choose a section of the room to path to and meander around in for a bit
local selectPatrolPath = function(mob)
    local selectedCircle = pathingSections[math.random(1, 9)]
    if not selectedCircle then
        return nil
    end

    local shuffledPositions = utils.shuffle(selectedCircle)
    local numPositions = math.random(1, 4)
    local pathPositions = {}

    for i = 1, numPositions do
        pathPositions[i] = shuffledPositions[i]
    end

    return pathPositions
end

local countSpawnedSlaves = function()
    local count = 0
    for _, slaveGlobeID in ipairs(slaveGlobes) do
        local slave = GetMobByID(slaveGlobeID)
        if slave and slave:isSpawned() then
            count = count + 1
        end
    end

    return count
end

local setupTrainFollowing = function(mob)
    local followTarget = mob
    for _, slaveGlobeID in ipairs(slaveGlobes) do
        local currentSlave = GetMobByID(slaveGlobeID)
        if currentSlave and currentSlave:isAlive() then
            local action = currentSlave:getCurrentAction()
            if action ~= xi.act.NONE and action ~= xi.act.DEATH then
                currentSlave:follow(followTarget, xi.followType.ROAM)
                followTarget = currentSlave
            end
        end
    end
end

local trySpawnSlaveGlobe = function(mob)
    local nextSlaveSpawnTime = mob:getLocalVar('nextSlaveSpawnTime')
    local currentTime = GetSystemTime()

    -- Early exit if not time to spawn yet
    if currentTime < nextSlaveSpawnTime then
        return
    end

    -- Early exit if all slaves are spawned
    local spawnedCount = countSpawnedSlaves()
    if spawnedCount >= #slaveGlobes then
        return
    end

    if xi.mob.callPets(mob, slaveGlobes, callPetParams) then
        mob:setLocalVar('nextSlaveSpawnTime', currentTime + 35)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('nextSlaveSpawnTime', GetSystemTime() + 30) -- spawn first 30s from now
    mob:addStatusEffectEx(xi.effect.SHOCK_SPIKES, xi.effect.SHOCK_SPIKES, 60, 0, 3600, true)

    -- Silently reapply shock spikes immediately
    mob:addListener('EFFECT_LOSE', 'MG_SPIKES', function(mobArg, effect)
        if
            mobArg:isAlive() and
            effect:getEffectType() == xi.effect.SHOCK_SPIKES
        then
            mobArg:addStatusEffectEx(xi.effect.SHOCK_SPIKES, xi.effect.SHOCK_SPIKES, 60, 0, 3600, true)
        end
    end)
end

-- Handle path completion and start new patrol paths
entity.onPath = function(mob)
    if not mob:isFollowingPath() then
        -- Path completed, immediately start a new patrol
        mob:setLocalVar('isPatrolling', 0)
    end
end

entity.onMobRoam = function(mob)
    -- Try to spawn slaves while roaming
    trySpawnSlaveGlobe(mob)

    local lastSlaveCount = mob:getLocalVar('lastSlaveCount')
    if countSpawnedSlaves() ~= lastSlaveCount then
        setupTrainFollowing(mob)

        mob:setLocalVar('lastSlaveCount', countSpawnedSlaves())
    end

    -- Handle circular room patrolling when not in combat
    if mob:getLocalVar('isPatrolling') == 0 then
        local patrolPath = selectPatrolPath(mob)
        if patrolPath and #patrolPath > 0 then
            mob:setLocalVar('isPatrolling', 1)
            mob:pathThrough(patrolPath, xi.path.flag.COORDS)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENTHUNDER, { damage = 110 })
end

entity.onMobFight = function(mob, target)
    -- Keep pets linked
    for _, slaveGlobeID in ipairs(slaveGlobes) do
        local pet = GetMobByID(slaveGlobeID)
        if pet and pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

    -- Try to spawn a slave globe
    trySpawnSlaveGlobe(mob)
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('isPatrolling', 0) -- reset patrol so it can pick a new path

    setupTrainFollowing(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        for _, slaveGlobeID in ipairs(slaveGlobes) do
            local pet = GetMobByID(slaveGlobeID)
            if pet and pet:isSpawned() then
                DespawnMob(slaveGlobeID)
            end
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:removeListener('MG_SPIKES')
    mob:setRespawnTime(math.random(10800, 21600)) -- 3 to 6 hours
end

return entity
