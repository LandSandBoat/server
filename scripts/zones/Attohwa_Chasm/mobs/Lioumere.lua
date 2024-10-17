-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Lioumere
-----------------------------------
---@type TMobEntity
local entity = {}

local lioumereHome = { x = 478.8, y = 20, z = 41.7 }

local function resetAllEnmity(mob)
    -- reset enmity
    local enmitylist = mob:getEnmityList()
    for _, enmity in ipairs(enmitylist) do
        mob:resetEnmity(enmity.entity)
    end
end

local function travelToHome(mob)
    -- reset all enmity (to zero)
    resetAllEnmity(mob)
    -- start walking home
    mob:pathTo(lioumereHome.x, lioumereHome.y, lioumereHome.z)
    mob:setLocalVar('pathingHome', 1)
end

local function healWhileAtHome(mob, isAtHome)
    if
        isAtHome and
        mob:getHPP() < 100
    then
        mob:setHP(mob:getMaxHP())
    end
end

local function resetAtHome(mob, isAtHome)
    mob:setLocalVar('pathingHome', 0)
    -- face the correct direction and do not move while waiting at home
    mob:setRotation(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    -- heal Lioumere
    healWhileAtHome(mob, isAtHome)
    -- disengage clears enmity list and claim
    mob:disengage()
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)

    -- use custom listeners rather than antlion_ambush or antlion_ambush_noaggro mixins
    -- because unlike other Antlions Lioumere does not go underground or use pit
    -- ambush when reengaging (after initial spawn)
    mob:addListener('SPAWN', 'LIOUMERE_AMBUSH_SPAWN', function(mobArg)
        mobArg:hideName(true)
        mobArg:setUntargetable(true)
        mobArg:setAnimationSub(0)
    end)

    mob:addListener('ENGAGE', 'LIOUMERE_AMBUSH_ENGAGE', function(mobArg, target)
        if mobArg:getLocalVar('alreadyEngagedOnce') == 0 then
            mobArg:setLocalVar('alreadyEngagedOnce', 1)
            mobArg:useMobAbility(xi.mobSkill.PIT_AMBUSH_1)
        end

        -- make sure Lioumere can move away from home if needed
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'LIOUMERE_AMBUSH_FINISH', function(mobArg, skillID)
        if skillID == xi.mobSkill.PIT_AMBUSH_1 then
            mobArg:hideName(false)
            mobArg:setUntargetable(false)
            mobArg:setAnimationSub(1)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobRoam = function(mob)
    local isAtHome = mob:atPoint(lioumereHome.x, lioumereHome.y, lioumereHome.z)

    -- if disengaged away from home (for some reason) then go home
    if not isAtHome then
        travelToHome(mob)
    end

    -- if Lioumere is home always keep healed
    healWhileAtHome(mob, isAtHome)

    -- if Lioumere just reaches home then perform some reset logic
    if
        isAtHome and
        mob:getLocalVar('pathingHome') == 1
    then
        resetAtHome(mob, isAtHome)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- travel to home after a mob skill (except initial pit ambush skill)
    if skill:getID() ~= xi.mobSkill.PIT_AMBUSH_1 then
        travelToHome(mob)
    end
end

entity.onMobFight = function(mob, target)
    local isAtHome = mob:atPoint(lioumereHome.x, lioumereHome.y, lioumereHome.z)
    local totalEnmity = mob:getCE(target) + mob:getVE(target)

    -- if Lioumere just reaches home then perform some reset logic like disengaging
    if
        isAtHome and
        mob:getLocalVar('pathingHome') == 1
    then
        resetAtHome(mob, isAtHome)
    -- also Lioumere travels home if pulled more than 40 yalms away from home
    elseif
        mob:getLocalVar('pathingHome') == 0 and
        mob:checkDistance(lioumereHome.x, lioumereHome.y, lioumereHome.z) > 40
    then
        travelToHome(mob)
    end

    -- interrupt Lioumere pathing home if generating enough enmity while pathing
    if totalEnmity > 6000 then
        mob:setLocalVar('pathingHome', 0)
        mob:clearPath()
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
