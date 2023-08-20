-----------------------------------
-- Temporal Shift
-- Family: Hpemde
-- Description: Enemies within range are temporarily prevented from acting.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15 yalms
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 5))

    return typeEffect
end

return mobskillObject
