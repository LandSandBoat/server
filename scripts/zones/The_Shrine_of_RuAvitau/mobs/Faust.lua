-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-----------------------------------
---@type TMobEntity
local entity = {}

local east = 0
local north = 192
local home = { 740, -0.463, -99 }

local setFaustNextTurnTime = function(faust)
    faust:setLocalVar('NextTurnTime', GetSystemTime() + math.randomInt(45, 75))
end

local faustNextTurnTime = function(faust)
    return faust:getLocalVar('NextTurnTime')
end

local setFaustFacingDirection = function(faust, direction)
    faust:setLocalVar('FacingDirection', direction)
    faust:setRotation(direction)
end

local faustFacingDirection = function(faust)
    return faust:getLocalVar('FacingDirection')
end

local handleFaustFacingDirectionMechanics = function(faust)
    if GetSystemTime() > faustNextTurnTime(faust) then
        if faustFacingDirection(faust) == north then
            setFaustFacingDirection(faust, east)
        else
            setFaustFacingDirection(faust, north)
        end

        setFaustNextTurnTime(faust)
    end
end

entity.onMobInitialize = function(mob)
    mob:setBaseSpeed(80) -- Note: setBaseSpeed() also updates the animation speed to match.
    mob:setMod(xi.mod.REGAIN, 500)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.SIGHT)) -- Aggros to magic and sight (30 yalms).
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    setFaustNextTurnTime(mob)
    setFaustFacingDirection(mob, north) -- start him facing north (though the database technically already does this, we need to absorb the local dir)
end

entity.onMobRoam = function(mob)
    if mob:atPoint(home) then
        handleFaustFacingDirectionMechanics(mob)
    else
        mob:pathThrough(home, xi.pathflag.NONE)
    end
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Nearly always uses Typhoon below 50% HP
    if mob:getHPP() <= 50 and mob:getLocalVar('RegainBoosted') == 0 then
        mob:setMod(xi.mod.REGAIN, 1000)
        mob:setLocalVar('RegainBoosted', 1)
    end

    -- Follow-up Typhoons wait until the target is back in range
    if
        mob:getLocalVar('TyphoonFollowUp') == 1 and
        mob:checkDistance(target) < 5
    then
        mob:setLocalVar('TyphoonFollowUp', 0)
        mob:useMobAbility(xi.mobSkill.TYPHOON)
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- Typhoons twice above 50%, three times below 50%
    local typhoonCount = mob:getLocalVar('TyphoonCount')
    local maxTyphoons = mob:getHPP() < 50 and 2 or 1

    if typhoonCount < maxTyphoons then
        mob:setLocalVar('TyphoonFollowUp', 1)
        mob:setLocalVar('TyphoonCount', typhoonCount + 1)
    else
        mob:setLocalVar('TyphoonCount', 0)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(10800, 21600)) -- 3 to 6 hours.
end

return entity
