-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Mother Globe
-- TODO: Looked like pets had an additional effect: stun with an unknown proc rate
-- TODO: "Links with Slave Globes, and Slave Globes link with Defenders. Defenders do not link with Slave Globes or Mother Globe."
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
-----------------------------------
local entity = {}

-- TODO: MG Slave Gloves follow her weirdly due to a 3 second delay in onMobRoam. This needs to be cleaned up somehow.

local pathNodes =
{
    { x = 880.16, y =  -99.81, z = -550.50 },
    { x = 860.09, y =  -99.74, z = -551.23 },
    { x = 834.92, y =  -99.55, z = -556.92 },
    { x = 830.51, y =  -99.81, z = -580.15 },
    { x = 839.36, y =  -99.47, z = -604.65 },
    { x = 859.37, y =  -99.67, z = -607.99 },
    { x = 859.37, y =  -99.67, z = -607.99 },
    { x = 892.04, y = -100.03, z = -580.07 },
    { x = 859.47, y =  -99.42, z = -579.54 }
}

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

    if mg:isEngaged() then
        mg:setLocalVar("summoning", 1)
        mg:entityAnimationPacket("casm")
        mg:setAutoAttackEnabled(false)
        mg:setMagicCastingEnabled(false)
        mg:setMobAbilityEnabled(false)

        mg:timer(3000, function(mob)
            if mob:isAlive() then
                mob:entityAnimationPacket("shsm")
                mob:setLocalVar("summoning", 0)
                mob:setAutoAttackEnabled(true)
                mob:setMagicCastingEnabled(true)
                mob:setMobAbilityEnabled(true)
                slaveGlobe:spawn()
                if mob:getTarget() ~= nil then
                    slaveGlobe:updateEnmity(mob:getTarget())
                end
            end
        end)
    else
        mg:entityAnimationPacket("casm")
        local pPet = slaveGlobe:getID() - 1
        local pet = GetMobByID(pPet)

        mg:timer(3000, function(mob)
            if mob:isAlive() then
                mob:entityAnimationPacket("shsm")
                slaveGlobe:spawn()
                if pPet == nil then
                    slaveGlobe:pathTo(mob:getXPos() + 0.15, mob:getYPos(), mob:getZPos() + 0.15)
                else
                    slaveGlobe:pathTo(pet:getXPos() + 0.5, pet:getYPos(), pet:getZPos() + 0.5)
                end
            end
        end)
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
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setLocalVar("nextSlaveSpawnTime", os.time() + 30) -- spawn first 30s from now
    mob:setLocalVar("posNum", math.random(1, 9))
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    -- 60 damage spikes with duration of 1 hour (in case stolen by thf)
    mob:addStatusEffectEx(xi.effect.SHOCK_SPIKES, 0, 60, 0, 3600)
    mob:setSpeed(20)
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
    if mob:getLocalVar("summoning") == 0 then
        trySpawnSlaveGlobe(mob, os.time(), spawnedSlaves, notSpawnedSlaves, validSlavePositions)
    end

    if not mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
        -- 60 damage spikes with duration of 1 hour (in case stolen by thf)
        mob:addStatusEffectEx(xi.effect.SHOCK_SPIKES, 0, 60, 0, 3600)
    end
end

entity.onMobRoam = function(mob)
    local spawnedSlaves, notSpawnedSlaves = getSlaves()
    local validSlavePositions = calculateValidSlaveGlobePositions(mob:getZone(), mob:getPos(), startingSpacingDistance)

    trySpawnSlaveGlobe(mob, os.time(), spawnedSlaves, notSpawnedSlaves, validSlavePositions)
    handleSlaveGlobesRoam(mob, validSlavePositions)

    local posNum = mob:getLocalVar("posNum")
    local moveX = 0
    local moveY = 0
    local moveZ = 0

    -- Get new positions
    for k, pos in pairs(pathNodes) do
        if k == posNum then
            moveX = pos.x
            moveY = pos.y
            moveZ = pos.z
            break
        end
    end

    local distance = mob:checkDistance(moveX, moveY, moveZ)

    if distance > 4 then
        mob:pathTo(moveX, moveY, moveZ)
    else
        local newPos = math.random(1, 9)
        while newPos == posNum do
            newPos = math.random(1, 9)
        end

        for k, pos in pairs(pathNodes) do
            if k == newPos then
                moveX = pos.x
                moveY = pos.y
                moveZ = pos.z
                break
            end
        end

        mob:pathTo(moveX, moveY, moveZ)
        mob:setLocalVar("posNum", newPos)
    end

    if not mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
        -- 60 damage spikes with duration of 1 hour (in case stolen by thf)
        mob:addStatusEffectEx(xi.effect.SHOCK_SPIKES, 0, 60, 0, 3600)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENTHUNDER)
end

entity.onMobEngaged = function(mob, target)
    mob:setSpeed(40)
end

entity.onMobDisengage = function(mob)
    mob:setSpeed(20)
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
    xi.mob.nmTODPersist(mob, math.random(10800, 21600)) -- 3 to 6 hrs
end

return entity
