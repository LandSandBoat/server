-----------------------------------
-- Module: Boreal Coeurl Era Behavior
-- Modifications:
--   1. Spins in place (no wandering)
--   2. True sight and true sound
--   3. Uses Doom ability after 30 minutes
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('era_boreal_coeurl')

local ROTATION_DELAY_MIN = 4000
local ROTATION_DELAY_MAX = 7000
local THIRTY_MINUTES = 30 * 60
local DOOM_SKILL_ID = 1067

local function rotateMob(mob)
    if mob:isAlive() and not mob:isEngaged() then
        local rotationDirection = mob:getLocalVar('rotationDirection')
        local rotationChange = math.random(35, 55)

        -- 10% chance to flip rotation direction
        if math.random(1, 100) <= 10 then
            mob:setLocalVar('rotationDirection', (rotationDirection + 1) % 2)
            rotationDirection = mob:getLocalVar('rotationDirection')
        end

        if rotationDirection == 1 then
            rotationChange = -1 * rotationChange
        end

        mob:setRotation((mob:getPos()['rot'] + rotationChange) % 256)
        mob:timer(math.random(ROTATION_DELAY_MIN, ROTATION_DELAY_MAX), function(mobArg)
            rotateMob(mobArg)
        end)
    end
end

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobSpawn', function(mob)
    super(mob)
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('fightStartTime', 0)
    mob:setLocalVar('doomUsed', 0)
    mob:setLocalVar('returningToSpawn', 0)
    mob:timer(math.random(ROTATION_DELAY_MIN, ROTATION_DELAY_MAX), function(mobArg)
        rotateMob(mobArg)
    end)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobRoam', function(mob)
    local returningToSpawn = mob:getLocalVar('returningToSpawn')

    if returningToSpawn == 1 then
        local spawnPos = mob:getSpawnPos()
        if mob:checkDistance(spawnPos) < 3 then
            mob:setLocalVar('returningToSpawn', 0)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:setLocalVar('spinning', 1)
            rotateMob(mob)
        elseif not mob:isFollowingPath() then
            mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
        end
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        if mob:getLocalVar('spinning') == 0 then
            mob:setLocalVar('spinning', 1)
            rotateMob(mob)
        end
    end
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobEngage', function(mob, target)
    super(mob, target)
    mob:setLocalVar('returningToSpawn', 0)
    mob:setLocalVar('spinning', 0)
    if mob:getLocalVar('fightStartTime') == 0 then
        mob:setLocalVar('fightStartTime', os.time())
    end
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobFight', function(mob, target)
    super(mob, target)
    local fightStartTime = mob:getLocalVar('fightStartTime')
    local doomUsed = mob:getLocalVar('doomUsed')

    if fightStartTime > 0 and doomUsed == 0 then
        if os.time() - fightStartTime >= THIRTY_MINUTES then
            mob:useMobAbility(DOOM_SKILL_ID)
            mob:setLocalVar('doomUsed', 1)
        end
    end
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobDisengage', function(mob)
    super(mob)
    mob:setLocalVar('fightStartTime', 0)
    mob:setLocalVar('doomUsed', 0)
    mob:setLocalVar('spinning', 0)
    mob:setLocalVar('returningToSpawn', 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end)

return m
