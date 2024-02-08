-----------------------------------
-- Belly Dance
--
-- Description: Charms all targets in an area of effect, that are facing the Lamia.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15' radial
-- Notes: Used only by Lamia NM's, particularly in Besieged.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    --[[
    power = 1
    tic = 0
    duration = 60

    isEnfeeble = true
    statmod = xi.mod.INT

    resist = xi.mobskills.applyPlayerResistance(mob, xi.effect.CHARM_I, target, isEnfeeble, xi.effect.CHARM_I, statmod)
    if resist > 0.2 then
        if target:getStatusEffect(xi.effect.CHARM_I) == nil then
            skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
            target:addStatusEffect(xi.effect.CHARM_I, power, tic, duration)
        else
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return xi.effect.CHARM_I
    ]]
end

return mobskillObject
