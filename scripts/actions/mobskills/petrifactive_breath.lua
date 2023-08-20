-----------------------------------
-- Petrifactive Breath
-- Description: Petrifies a single target.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(15, 45)))

    return typeEffect
end

return mobskillObject
