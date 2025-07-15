-----------------------------------
-- Area: Spire of Mea
--  Mob: Envier
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Check for traits like double attack and store TP.
-- TODO: Check for low HP behavior changes.
-- TODO: Immunities, EEM, Attack Speed

local vars =
{
    SEETHER_TIME     = 'seetherTime',
    SEETHER_ELIGIBLE = 'seetherEligible',
}

local seetherParams =
{
    SPAWN_PERCENT = 50,
    SPAWN_MIN     = 10,
    SPAWN_MAX     = 45,
}

-----------------------------------
-- Set the spawn time for the next Seether.
-----------------------------------
local setSeetherSpawnTime = function(mob)
    mob:setLocalVar(vars.SEETHER_TIME, GetSystemTime() + math.random(seetherParams.SPAWN_MIN, seetherParams.SPAWN_MAX))
end

-----------------------------------
-- Aggros sound at 15 yalms.
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

-----------------------------------
-- Initialize variables.
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:setLocalVar(vars.SEETHER_TIME, 0)
    mob:setLocalVar(vars.SEETHER_ELIGIBLE, 0)
end

-----------------------------------
-- Handle spawning Seethers.
-----------------------------------
entity.onMobFight = function(mob, target)
    -- Spawn Seethers only below specific HP threshold.
    if
        mob:getLocalVar(vars.SEETHER_ELIGIBLE) == 0 and
        mob:getHPP() <= seetherParams.SPAWN_PERCENT
    then
        mob:setLocalVar(vars.SEETHER_ELIGIBLE, 1)
        setSeetherSpawnTime(mob)
    end

    -- Check if it is time to spawn a Seether.
    if
        mob:getLocalVar(vars.SEETHER_ELIGIBLE) > 0 and
        mob:getLocalVar(vars.SEETHER_TIME) < GetSystemTime()
    then
        local mobID  = mob:getID()
        local mobPos = mob:getPos()

        for i = 1, 3 do
            local seether = GetMobByID(mobID + i)

            -- Seethers use TP immediately upon spawning.
            if
                seether and
                not seether:isSpawned()
            then
                seether:setSpawn(mobPos.x, mobPos.y, mobPos.z)
                seether:spawn()
                seether:updateEnmity(target)
                setSeetherSpawnTime(mob)
                break
            end
        end
    end
end

-----------------------------------
-- Seethers die automatically when Envier dies.
-----------------------------------
entity.onMobDeath = function(mob, player, optParams)
    local mobID = mob:getID()

    for i = 1, 3 do
        local seether = GetMobByID(mobID + i)

        if
            seether and
            seether:isAlive()
        then
            seether:setHP(0)
        end
    end
end

return entity
