-----------------------------------
-- Area: Monarch Linn
-- Mob: Razon
-- ENM: Fire in the Sky
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

local elements =
{
    xi.damageType.EARTH,
    xi.damageType.WATER,
    xi.damageType.WIND,
    xi.damageType.FIRE,
    xi.damageType.ICE,
    xi.damageType.LIGHTNING,
    xi.damageType.LIGHT,
    xi.damageType.DARK,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, 3500)
    mob:setMod(xi.mod.MEVA, -75)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("triggerElement1", elements[math.random(1, 8)])
    mob:setLocalVar("triggerElement2", elements[math.random(1, 8)])

    mob:addListener("TAKE_DAMAGE", "RAZON_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if
            attackType == xi.attackType.MAGICAL and
            (damageType == mob:getLocalVar("triggerElement1") or
            damageType == mob:getLocalVar("triggerElement2"))
        then
            local tp = mobArg:getTP()
            mobArg:useMobAbility(626) -- dust cloud
            mobArg:setTP(tp)

            if mobArg:getAnimationSub() == 12 then
                mobArg:useMobAbility(571)
            elseif mobArg:getAnimationSub() == 5 then
                mobArg:useMobAbility(573)
            elseif mobArg:getAnimationSub() == 6 then
                mobArg:useMobAbility(575)
            end
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 575 then
        mob:timer(7000, function(mobArg)
            mobArg:getBattlefield():lose()
        end)
    end
end

entity.onMobDeath = function(mob)
end

return entity
