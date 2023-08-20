-----------------------------------
-- Ichor Stream
-- Family: Hpemde
-- Description: Spews venomous ichor at targets in a fan-shaped area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Cone
-- Notes: Poison is about 5/tic.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 5, 0, 120))

    return typeEffect
end

return mobskillObject
