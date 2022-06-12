-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Mother Globe
-- TODO: Looked like pets had an additional effect: stun with an unknown proc rate
-- TODO: "Links with Slave Globes, and Slave Globes link with Defenders. Defenders do not link with Slave Globes or Mother Globe."
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local findSlaveGlobeToSpawn = function()
    local spawnCount = 0

    for _, slaveGlobeID in ipairs(ID.mob.SLAVE_GLOBES) do
        local slaveGlobe = GetMobByID(slaveGlobeID)

        spawnCount = spawnCount + 1

        if not slaveGlobe:isSpawned() then
            return slaveGlobe, spawnCount
        end
    end

    return nil, spawnCount
end

local spawnSlaveGlobe = function(mg, slaveGlobe)
    slaveGlobe:setSpawn(mg:getXPos() + 1, mg:getYPos(), mg:getZPos() + 1)
    slaveGlobe:spawn()

    if mg:isEngaged() then
        slaveGlobe:updateEnmity(mg:getTarget())
    end

end

local setNextSpawnSlaveGlobe = function(mg, spawnCount, nowTime)
    local nextSpawnTime = 35 -- 30 + 5 seconds for "cast time"

    if spawnCount < #ID.mob.SLAVE_GLOBES then
        mg:setLocalVar("nextSlaveSpawnTime", nowTime + nextSpawnTime)
    else
        mg:setLocalVar("nextSlaveSpawnTime", 0)
    end
end

local trySpawnSlaveGlobe = function(mg, nowTime)
    local nextSlaveSpawnTime = mg:getLocalVar("nextSlaveSpawnTime")
    local shouldTryToSummonSlaveGlobe = nowTime > nextSlaveSpawnTime
    local inCombat = mg:isEngaged()
    local combatHasNotRecentlyStarted = mg:getBattleTime() > 3

    if shouldTryToSummonSlaveGlobe and (not inCombat or combatHasNotRecentlyStarted) then
        local slaveGlobe, spawnCount = findSlaveGlobeToSpawn(mg)
        if slaveGlobe then
            spawnSlaveGlobe(mg, slaveGlobe)
            setNextSpawnSlaveGlobe(mg, spawnCount, os.time())
        end
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
    for _, slaveGlobeID in ipairs(ID.mob.SLAVE_GLOBES) do
        local pet = GetMobByID(slaveGlobeID)
        if pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

    trySpawnSlaveGlobe(mob, os.time())
end

entity.onMobRoam = function(mob)
    trySpawnSlaveGlobe(mob, os.time())
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- TODO: Additional Effect for ~100 damage (theme suggests enthunder)
    -- Unknown if this can be stolen/dispelled like spikes.  Isn't mentioned, probably not.
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs

    for _, slaveGlobeID in ipairs(ID.mob.SLAVE_GLOBES) do
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
