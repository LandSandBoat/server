-----------------------------------
-- Death Trap
--
-- Description: Attempts to stun or poison any players in a large trap. Resets hate.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 30' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local stun   = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.random(10, 15))
    local poison = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 10, 0, 300)

    mob:resetEnmity(target)

    if stun == xi.msg.basic.SKILL_ENFEEB_IS then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
        return xi.effect.STUN
    elseif poison == xi.msg.basic.SKILL_ENFEEB_IS then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
        return xi.effect.POISON
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return xi.effect.NONE
    end
end

return mobskillObject
