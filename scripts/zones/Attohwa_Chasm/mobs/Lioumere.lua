-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Lioumere
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush_no_rehide') }
-----------------------------------

---@type TMobEntity
local entity = {}

local home = { x = 478.8, y = 20, z = 41.7 }

-- Reset stats. TODO: Study creating a combat behavior utility.
local function resetStats(mob)
    mob:delStatusEffectSilent(xi.effect.DIA)
    mob:delStatusEffectSilent(xi.effect.BIO)
    mob:delStatusEffectSilent(xi.effect.POISON)
    mob:delStatusEffectSilent(xi.effect.REQUIEM)
    mob:delStatusEffectSilent(xi.effect.BURN)
    mob:delStatusEffectSilent(xi.effect.CHOKE)
    mob:delStatusEffectSilent(xi.effect.DROWN)
    mob:delStatusEffectSilent(xi.effect.FROST)
    mob:delStatusEffectSilent(xi.effect.RASP)
    mob:delStatusEffectSilent(xi.effect.SHOCK)
    mob:delStatusEffectSilent(xi.effect.HELIX)
    mob:delStatusEffectSilent(xi.effect.KAUSTRA)
    mob:setHP(mob:getMaxHP())
end

local function resetEnmity(mob)
    local enmitylist = mob:getEnmityList()
    for _, enmity in ipairs(enmitylist) do
        mob:resetEnmity(enmity.entity)
    end
end

local function resetPosition(mob)
    resetStats(mob)
    mob:setLocalVar('pathingHome', 0)
    mob:setRotation(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:disengage() -- Clears enmity list and claim
end

local function pathHome(mob)
    mob:pathTo(home.x, home.y, home.z)
    mob:setLocalVar('pathingHome', 1)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobRoam = function(mob)
    local homeDistance = mob:checkDistance(home.x, home.y, home.z)

    -- About at home. Heal.
    if homeDistance <= 2 then
        resetStats(mob)
    end

    -- Not exactly at home. Keep pathing.
    if homeDistance ~= 0 then
        resetEnmity(mob)
        pathHome(mob)

    -- Exactly at home. Reset position, status and stop pathing.
    elseif mob:getLocalVar('pathingHome') == 1 then
        resetPosition(mob)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Travel to home after a mob skill (except initial pit ambush skill)
    if skill:getID() ~= xi.mobSkill.PIT_AMBUSH_1 then
        resetEnmity(mob)
        pathHome(mob)
    end
end

entity.onMobFight = function(mob, target)
    local homeDistance = mob:checkDistance(home.x, home.y, home.z)

    -- About at home. Heal.
    if homeDistance <= 2 then
        resetStats(mob)
    end

    -- Reset pathing if enough hate.
    local totalEnmity = mob:getCE(target) + mob:getVE(target)
    if totalEnmity > 6000 then
        mob:setLocalVar('pathingHome', 0)
        mob:clearPath()
        return
    end

    -- Too far from home. Reset enmity and path home.
    if
        homeDistance > 40 and
        mob:getLocalVar('pathingHome') == 0
    then
        resetEnmity(mob)
        pathHome(mob)

    -- Exactly at home. Reset position, status and stop pathing.
    elseif
        homeDistance == 0 and
        mob:getLocalVar('pathingHome') == 1
    then
        resetPosition(mob)
    end
end

return entity
