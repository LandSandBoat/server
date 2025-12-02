-----------------------------------
-- Knife Edge Circle
-- Used by NM Tres Duendes
-- Description: Stuns and poisons enemies within a fan-shaped area originating from caster.
-- Type: Conal Enfeeble
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.NONE
    local stun       = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 15)
    local poison     = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 20, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    if stun == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.STUN
    elseif poison == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.POISON
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
