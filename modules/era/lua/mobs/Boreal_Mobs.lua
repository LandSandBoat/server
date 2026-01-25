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
-- This module re-introduces the following retail changes:
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

local thirtyMinutes = 30 * 60

local function onMobSpawn(mob)
    mob:setTrueDetection(true)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('fightStartTime', 0)
    mob:setLocalVar('doomUsed', 0)
    mob:setLocalVar('returningToSpawn', 0)
end

local function onMobRoam(mob)
    local returningToSpawn = mob:getLocalVar('returningToSpawn')

    if returningToSpawn == 1 then
        local spawnPos = mob:getSpawnPos()
        if mob:checkDistance(spawnPos) < 3 then
            mob:setLocalVar('returningToSpawn', 0)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        elseif not mob:isFollowingPath() then
            mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
        end
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end
end

local function onMobEngage(mob, target)
    mob:setLocalVar('returningToSpawn', 0)
    -- mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    if mob:getLocalVar('fightStartTime') == 0 then
        mob:setLocalVar('fightStartTime', GetSystemTime())
    end
end

local function onMobFight(mob, target)
    local fightStartTime = mob:getLocalVar('fightStartTime')
    local doomUsed = mob:getLocalVar('doomUsed')

    if fightStartTime > 0 and doomUsed == 0 then
        if GetSystemTime() - fightStartTime >= thirtyMinutes then
            mob:useMobAbility(xi.mobSkill.DOOM_1)
            mob:setLocalVar('doomUsed', 1)
        end
    end
end

local function onMobDisengage(mob)
    mob:setLocalVar('fightStartTime', 0)
    mob:setLocalVar('doomUsed', 0)
    mob:setLocalVar('returningToSpawn', 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

-----------------------------------
-- Apply overrides to all Boreal mobs
-----------------------------------
local borealMobs =
{
    'Boreal_Tiger',
    'Boreal_Hound',
    'Boreal_Coeurl',
}

for _, mobName in ipairs(borealMobs) do
    local basePath = 'xi.zones.Xarcabard.mobs.' .. mobName

    m:addOverride(basePath .. '.onMobSpawn', function(mob)
        super(mob)
        onMobSpawn(mob)
    end)

    m:addOverride(basePath .. '.onMobRoam', function(mob)
        onMobRoam(mob)
    end)

    m:addOverride(basePath .. '.onMobEngage', function(mob, target)
        super(mob, target)
        onMobEngage(mob, target)
    end)

    m:addOverride(basePath .. '.onMobFight', function(mob, target)
        super(mob, target)
        onMobFight(mob, target)
    end)

    m:addOverride(basePath .. '.onMobDisengage', function(mob)
        super(mob)
        onMobDisengage(mob)
    end)
end

return m
