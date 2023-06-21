-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Mother Globe
-- TODO: Looked like pets had an additional effect: stun with an unknown proc rate
-- TODO: "Links with Slave Globes, and Slave Globes link with Defenders. Defenders do not link with Slave Globes or Mother Globe."
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
-----------------------------------
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

local startingSpacingDistance = -1 -- how far apart to initially attempt to space the slaves
local spacingDistanceMinimum = -.1 -- the distance at which if you're trying to build valid points this close together it will just bail out and stack on top of MG
local spacingDivisor = 2  -- affects how quickly the list will converge to just stacking on MG (larger the faster)

-- function returns two tables, one of spawned and one of unspawned
local getSlaves = function()
    local spawnedSlaves = {}
    local notSpawnedSlaves = {}

    for _, slaveGlobeID in ipairs(slaveGlobes) do
        local slaveGlobe = GetMobByID(slaveGlobeID)

        if slaveGlobe:isSpawned() then
            table.insert(spawnedSlaves, slaveGlobe)
        else
            table.insert(notSpawnedSlaves, slaveGlobe)
        end
    end

    return spawnedSlaves, notSpawnedSlaves
end

-- calculates a list of all valid slave globe idle positions
-- shrinks the distance between them (if it fails the isNavigablePoint test)
-- until the distance is low enough where they should just stack on mg
-- the assumption here is that MG is likely not in a navmesh violation state
local function calculateValidSlaveGlobePositions(zone, mgPos, spacingDistance)
    local slavePositions = {}

    -- extreme terminal decision so we don't recurse endlessly
    -- fall back to just piling up ontop of mg
    if spacingDistance > spacingDistanceMinimum then
        return { mgPos, mgPos, mgPos, mgPos, mgPos, mgPos }
    end

    for slavePositionSlot, _ in ipairs(slaveGlobes) do
        local xOffset = spacingDistance * slavePositionSlot
        local slavePosition =  utils.lateralTranslateWithOriginRotation(mgPos, { x = xOffset, y = 0, z = 0 })

        if zone:isNavigablePoint(slavePosition) then
            table.insert(slavePositions, slavePosition)
        else
            return calculateValidSlaveGlobePositions(zone, mgPos, spacingDistance / spacingDivisor)
        end
    end

    return slavePositions
end

-- spawn the slave and update any enmity
local spawnSlaveGlobe = function(mg, slaveGlobe, spawnPos)
    slaveGlobe:setSpawn(spawnPos.x, spawnPos.y, spawnPos.z, spawnPos.rot)
    slaveGlobe:spawn()

    if mg:isEngaged() then
        slaveGlobe:updateEnmity(mg:getTarget())
    end
end

-- set the next spawn time, if it's at a max, set to zero
-- zero helps to prevent insta spawning next slaves while
-- in combat if at the start it had all 6 out already
local setNextSpawnSlaveGlobe = function(mg, spawnCount, nowTime)
    local nextSpawnTime = 35 -- 30 + 5 seconds for "cast time"

    if spawnCount < #slaveGlobes then
        mg:setLocalVar("nextSlaveSpawnTime", nowTime + nextSpawnTime)
    else
        -- setting to zero prevents "insta" spawn on the 6th slaves death because slaveGlobePos
        -- on death will check and set the next respawn time
        mg:setLocalVar("nextSlaveSpawnTime", 0)
    end
end

local trySpawnSlaveGlobe = function(mg, nowTime, spawnedSlaves, notSpawnedSlaves, validSlavePositions)
    local nextSlaveSpawnTime = mg:getLocalVar("nextSlaveSpawnTime")
    local shouldSummonSlaveGlobe = nowTime > nextSlaveSpawnTime and #notSpawnedSlaves > 0
    local inCombat = mg:isEngaged()
    local combatHasNotRecentlyStarted = mg:getBattleTime() > 3

    if shouldSummonSlaveGlobe and (not inCombat or combatHasNotRecentlyStarted) then
        local slaveGlobe = notSpawnedSlaves[1]
        local slaveSlot = #spawnedSlaves + 1
        local slaveGlobePos = validSlavePositions[slaveSlot]

        spawnSlaveGlobe(mg, slaveGlobe, slaveGlobePos)
        setNextSpawnSlaveGlobe(mg, slaveSlot, os.time())
    end
end

local handleSlaveGlobesRoam = function(mg, validSlavePositions)
    local mgPos = mg:getPos()
    local positionsIndex = 1

    local spawnedSlaves, _ = getSlaves()

    for _, slaveGlobe in ipairs(spawnedSlaves) do
        local slaveGlobePos = validSlavePositions[positionsIndex]
        positionsIndex = positionsIndex + 1
        slaveGlobe:pathTo(slaveGlobePos.x, slaveGlobePos.y, slaveGlobePos.z)
        slaveGlobe:setRotation(mgPos.rot)
    end
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("nextSlaveSpawnTime", os.time() + 30) -- spawn first 30s from now
    mob:addStatusEffectEx(xi.effect.SHOCK_SPIKES, 0, 60, 0, 0) -- ~60 damage
    -- TODO: Effect can be stolen, giving a THF (Aura Steal) or BLU (Voracious Trunk) a 60 minute shock spikes effect (unknown potency).
    -- If effect is stolen, he will recast it instantly.
end

entity.onMobFight = function(mob, target)
    -- Keep pets linked
    for _, slaveGlobeID in ipairs(slaveGlobes) do
        local pet = GetMobByID(slaveGlobeID)
        if pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

    local spawnedSlaves, notSpawnedSlaves = getSlaves()
    local validSlavePositions = calculateValidSlaveGlobePositions(mob:getZone(), mob:getPos(), startingSpacingDistance)
    trySpawnSlaveGlobe(mob, os.time(), spawnedSlaves, notSpawnedSlaves, validSlavePositions)
end

entity.onMobRoam = function(mob)
    local spawnedSlaves, notSpawnedSlaves = getSlaves()
    local validSlavePositions = calculateValidSlaveGlobePositions(mob:getZone(), mob:getPos(), startingSpacingDistance)

    trySpawnSlaveGlobe(mob, os.time(), spawnedSlaves, notSpawnedSlaves, validSlavePositions)
    handleSlaveGlobesRoam(mob, validSlavePositions)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- TODO: Additional Effect for ~100 damage (theme suggests enthunder)
    -- Unknown if this can be stolen/dispelled like spikes.  Isn't mentioned, probably not.
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs

    for _, slaveGlobeID in ipairs(slaveGlobes) do
        local pet = GetMobByID(slaveGlobeID)
        if pet:isSpawned() then
            DespawnMob(slaveGlobeID)
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(10800, 21600)) -- 3 to 6 hours
end

return entity
