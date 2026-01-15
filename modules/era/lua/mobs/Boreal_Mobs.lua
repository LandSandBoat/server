-----------------------------------
-- Module: Boreal Mobs Behavior
--
-- This module reverts the following retail changes:
--
-- March 27, 2012 (JST) Version Update
-- https://forum.square-enix.com/ffxi/threads/22099
-- [dev1095] Limit Break Quest "Atop the Highest Mountains" Adjustments
--   - The ??? targets from which frigicite may be obtained will always be visible.
--   - The quest NMs located near these targets will no longer be stationary.
--   - Methods of detection for these NMs have been adjusted.
--   - These NMs no longer use Doom.
--
-- August 28, 2007 Version Update
-- http://www.playonline.com/pcd/update/ff11us/20070828oz52G1/detail.html
-- - Atop the Highest Mountains
--   The relative strength of the quest monsters (Boreal Hound, Boreal Coeurl,
--   and Boreal Tiger) has been reduced so that a party of six level 51
--   characters will be able to defeat them.
--   *The quest monsters mentioned above will use the ability "Doom" if the
--   battle continues for more than thirty minutes.

-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('boreal_mobs')

local rotationDelayMin = 4000
local rotationDelayMax = 7000
local rotationChangeMin = 35
local rotationChangeMax = 55
local rotationFlipChance = 10
local thirtyMinutes = 30 * 60

local function rotateMob(mob)
    if mob:isAlive() and not mob:isEngaged() then
        local rotationDirection = mob:getLocalVar('rotationDirection')
        local rotationChange = math.random(rotationChangeMin, rotationChangeMax)

        -- Chance to flip rotation direction
        if math.random(1, 100) <= rotationFlipChance then
            mob:setLocalVar('rotationDirection', (rotationDirection + 1) % 2)
            rotationDirection = mob:getLocalVar('rotationDirection')
        end

        if rotationDirection == 1 then
            rotationChange = -1 * rotationChange
        end

        mob:setRotation((mob:getPos()['rot'] + rotationChange) % 256)
        mob:timer(math.random(rotationDelayMin, rotationDelayMax), function(mobArg)
            rotateMob(mobArg)
        end)
    end
end

local function onMobSpawn(mob)
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('fightStartTime', 0)
    mob:setLocalVar('doomUsed', 0)
    mob:setLocalVar('returningToSpawn', 0)
    mob:timer(math.random(rotationDelayMin, rotationDelayMax), function(mobArg)
        rotateMob(mobArg)
    end)
end

local function onMobRoam(mob)
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
end

local function onMobEngage(mob, target)
    mob:setLocalVar('returningToSpawn', 0)
    mob:setLocalVar('spinning', 0)
    if mob:getLocalVar('fightStartTime') == 0 then
        mob:setLocalVar('fightStartTime', GetSystemTime())
    end
end

local function onMobFight(mob, target)
    local fightStartTime = mob:getLocalVar('fightStartTime')
    local doomUsed = mob:getLocalVar('doomUsed')

    if fightStartTime > 0 and doomUsed == 0 then
        if GetSystemTime() - fightStartTime >= thirtyMinutes then
            mob:useMobAbility(xi.mobSkill.DOOM)
            mob:setLocalVar('doomUsed', 1)
        end
    end
end

local function onMobDisengage(mob)
    mob:setLocalVar('fightStartTime', 0)
    mob:setLocalVar('doomUsed', 0)
    mob:setLocalVar('spinning', 0)
    mob:setLocalVar('returningToSpawn', 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

-----------------------------------
-- Boreal Tiger
-----------------------------------
m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Tiger.onMobSpawn', function(mob)
    super(mob)
    onMobSpawn(mob)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Tiger.onMobRoam', function(mob)
    onMobRoam(mob)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Tiger.onMobEngage', function(mob, target)
    super(mob, target)
    onMobEngage(mob, target)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Tiger.onMobFight', function(mob, target)
    super(mob, target)
    onMobFight(mob, target)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Tiger.onMobDisengage', function(mob)
    super(mob)
    onMobDisengage(mob)
end)

-----------------------------------
-- Boreal Hound
-----------------------------------
m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Hound.onMobSpawn', function(mob)
    super(mob)
    onMobSpawn(mob)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Hound.onMobRoam', function(mob)
    onMobRoam(mob)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Hound.onMobEngage', function(mob, target)
    super(mob, target)
    onMobEngage(mob, target)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Hound.onMobFight', function(mob, target)
    super(mob, target)
    onMobFight(mob, target)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Hound.onMobDisengage', function(mob)
    super(mob)
    onMobDisengage(mob)
end)

-----------------------------------
-- Boreal Coeurl
-----------------------------------
m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobSpawn', function(mob)
    super(mob)
    onMobSpawn(mob)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobRoam', function(mob)
    onMobRoam(mob)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobEngage', function(mob, target)
    super(mob, target)
    onMobEngage(mob, target)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobFight', function(mob, target)
    super(mob, target)
    onMobFight(mob, target)
end)

m:addOverride('xi.zones.Xarcabard.mobs.Boreal_Coeurl.onMobDisengage', function(mob)
    super(mob)
    onMobDisengage(mob)
end)

return m
